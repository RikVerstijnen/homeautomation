--./script_time_max.lua
----------------------------------------------------------------------------------------------------------
-- Script parameters
----------------------------------------------------------------------------------------------------------
package.loadlib("core.so", "*")
local Socket = require "socket"
local Basexx = require "basexx"
 
local MaxIP='192.168.1.209'
local MaxPort = 62910
local useWMT = false --Set to true if there is a wall mounted thermostat in every room
local interval = 5 --Polling interval in minutes, possible range 1-59. Cube doesn't seem to like too frequent communication, 5 minutes is a safe value
local DomoticzPort = 8080
 
local Rooms   = {}
local Devices = {}
local Room_nums = {}
 
function age(timestring)
  t = {}
  t.year = string.sub(timestring,1,4)
  t.month = string.sub(timestring,6,7)
  t.day = string.sub(timestring,9,10)
  t.hour = string.sub(timestring,12,13)
  t.min = string.sub(timestring,15,16)
  t.sec = string.sub(timestring,18,19)
  return os.difftime(os.time(),os.time(t))
end
 
function maxCmd_H(data)
--   print('H='..data)
end
 
function maxCmd_M(data)
   i = 0
   j = 0
 
    while true do    -- find next comma
      i = string.find(data, ",", i+1)
      if not i then break end
     j = i
    end
 
   s   = data:sub(j+1)
   dec = Basexx.from_base64(s)
   num_rooms = string.byte(dec,3)
   pos=4
 
   for i=1, num_rooms do
      room_num = string.byte(dec, pos)
      name_len = string.byte(dec, pos+1)
      pos  = pos+2
      name = dec:sub(pos, pos+name_len-1)
      pos  = pos+name_len
      adr  = Basexx.to_hex(dec:sub(pos, pos+2))
      Rooms[room_num] = name
      pos = pos+3
   end
 
   num_devs = string.byte(dec, pos)
   for i=1, num_devs do
      dtype = string.byte(dec, pos+1)
      adr   = Basexx.to_hex(dec:sub(pos+2, pos+4))
      snum  = dec:sub(pos+5, pos+14)
      name_len = string.byte(dec, pos+15)
      pos  = pos+16
      name = dec:sub(pos, pos+name_len-1)
      pos  = pos+name_len
      room_num = string.byte(dec, pos)
      Room_nums[adr] = room_num
      Devices[adr] = name
   end
 
end
 
function maxCmd_C(data)
--   print('C='..data)
end
 
function maxCmd_L(data)
   pos = 1
   dec = Basexx.from_base64(data)
   L_hex = Basexx.to_hex(dec)
   L_len = string.len(L_hex)
 
   while (pos < L_len) do
 
      s = L_hex:sub(pos,(pos+1))
      data_len  = tonumber(s,16) + 1
      hex  = L_hex:sub(pos,pos+(data_len*2))
      adr  = hex:sub(3,8)
      room_num = string.format("%02X", Room_nums[adr])
      room = Rooms[Room_nums[adr]]
      name = Devices[adr]
      if not name then name=adr end
      valve_info = tonumber(hex:sub(13,14),16)
      batt = bit32.extract(valve_info,7,1)
      bst  = bit32.extract(valve_info,3,1)
      mode = bit32.extract(valve_info,0,2)
 
      if (batt==0) then sbat="OK" else sbat="Low" end
      if (mode==0) then smode="Auto" elseif (mode==1) then smode="Manual"
      elseif (mode==2) then smode="Holiday" elseif (mode==3) then smode="Boost" end
 
      if (data_len == 13) then   -- WallMountedThermostat (dev_type 3)
        valve_pos = -1
        s = hex:sub(17,18)
        setpoint = tonumber(s,16) / 2
        s = hex:sub(23,26)
        temp = tonumber(s,16) / 10
        dtype = "Thermostat"
      elseif (data_len == 12) then -- HeatingThermostat (dev_type 1 or 2)
        s = hex:sub(15,16)
        valve_pos = tonumber(s,16)
        s = hex:sub(17,18)
        setpoint = tonumber(s,16) / 2
        if (mode ~= 2) then
          s = hex:sub(19,22)
          temp = tonumber(s,16) / 10
        else
          temp = 0
        end
        dtype = "Valve"
      end
 
      --Following two lines correct temperatures over 25.5 degrees, since e.g. 26 degrees is reported as 0.5 degrees
      --This is due to the fact that temperatures seem to be stored as two Hex characters only (= max 255 in decimal)
      --Pending better solution
      if temp < 5 then temp = temp + 25.5 end
      if setpoint > 50 then setpoint = setpoint - 64 end
 
      -- Update virtual devices in Domoticz and update MAX! setpoints if necessary
 
      print(dtype.."  "..name.."  Setpoint="..setpoint.."  Temp="..temp.."  Valve pos="..valve_pos)
      if dtype == "Valve" and name:sub(-5,-1) ~= "-Sens" then
        table.insert(commandArray, { ['UpdateDevice'] = otherdevices_idx[name]..'|0|'..valve_pos})   
        if not useWMT then --Use valve to update temperature and synchronize setpoints
          name = name:sub(1,-5) .. "-Stat"  -- set thermostat name to valve name with "-Stat" instead of "-Rad" suffix
          setpoint_Domoticz = tonumber(otherdevices_svalues[name])
          if setpoint_Domoticz ~= setpoint then
            if age(otherdevices_lastupdate[name]) > interval * 60 then --Domoticz thermostat value must be updated
              table.insert(commandArray, { ['OpenURL'] = 'http://127.0.0.1:'..DomoticzPort..'/json.htm?type=command&param=udevice&idx='..otherdevices_idx[name]..'&nvalue=0&svalue='..setpoint})
              print('Domoticz setpoint ' .. name .. ' updated')
            else --Max! setpoint must be updated
              MaxCmdSend(adr, room_num, "manual", setpoint_Domoticz)
              print('MAX! setpoint ' .. name .. ' updated')
            end
          end
        end
      elseif dtype == "Thermostat" then
        table.insert(commandArray, { ['UpdateDevice'] = otherdevices_idx[room]..'|0|'..temp})
        setpoint_Domoticz = tonumber(otherdevices_svalues[name])
        if setpoint_Domoticz ~= setpoint then
          if age(otherdevices_lastupdate[name]) > interval * 60 then --Domoticz thermostat value must be updated
            table.insert(commandArray, { ['OpenURL'] = 'http://127.0.0.1:'..DomoticzPort..'/json.htm?type=command&param=udevice&idx='..otherdevices_idx[name]..'&nvalue=0&svalue='..setpoint})
            print('Domoticz setpoint ' .. name .. ' updated')
          else --Max! setpoint must be updated
            MaxCmdSend(adr, room_num, "manual", setpoint_Domoticz)
            print('MAX! setpoint ' .. name .. ' updated')
          end
        end   
      end
 
      pos = pos + (data_len*2)
   end
end
 
 
function MaxCmdSend(id, room, mode, setpoint)
 
   bits  = setpoint * 2
   smode = string.upper(mode)
   if smode == 'MANUAL' then
      bits = 64 + bits
   elseif smode == 'BOOST' then
      bits = 192 + bits
   elseif smode == 'VACATION' then
      bits = 128 + bits
   end
 
   hex = "000440000000"..id..room..string.format("%x",bits)
   sendStr = Basexx.to_base64(Basexx.from_hex(hex))
   i, status = tcp:send("s:"..sendStr.."\r\n")
 
   if not i then
      print("MAX TCP send failed - "..status)
      return
   end
end
 
 
commandArray = {}
 
local m = os.date('%M')
if (m % interval == 0) and (m ~= 0) then
 
  tcp = Socket.connect(MaxIP, MaxPort)
  if not tcp then
    print("Socket connect failed for "..MaxIP..':'..MaxPort)
    return
  end
  tcp:settimeout(2)
 
  while true do
    s, status, partial = tcp:receive()
    if (status) then
      print("TCP receive - "..status)
     break
    end
 
    local line = (s or partial)
    local cmd  = line:sub(1,1)
    local data = line:sub(3)
 
    if (cmd == 'H') then
      status = maxCmd_H(data)
      if status == 'Error' then break end
    elseif (cmd == 'M') then
      maxCmd_M(data)
    elseif (cmd == 'C') then
      maxCmd_C(data)
    elseif (cmd == 'L') then
      maxCmd_L(data)
      break
    end
  end
 
  tcp:close()
 
end
 
return commandArray