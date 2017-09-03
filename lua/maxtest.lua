--maxtest.lua
 
package.loadlib("core.so", "*")
local Socket = require "socket"
local Basexx = require "basexx"
 
-- Enter your cube name or ip address and port here
--MaxIP='192.168.1.5'
MaxIP='192.168.1.209'
MaxPort=62910
 
local Rooms   = {}
local Devices = {}
 
function maxCmd_H(data)
--   print('H='..data)
end
 
function maxCmd_M(data)
   i = 0
   j = 0
 
    while true do    -- find 'next' comma
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
      name = dec:sub(pos, pos+name_len)
      pos  = pos+name_len
      adr  = Basexx.to_hex(dec:sub(pos, pos+2))
      Rooms[adr] = name
      pos = pos+3
   end
 
   print("Rooms\n-----")
   for adr, name in pairs(Rooms) do
      print(name, adr)
   end
 
   num_devs = string.byte(dec, pos)
   for i=1, num_devs do
 
      dtype = string.byte(dec, pos+1)
      adr   = Basexx.to_hex(dec:sub(pos+2, pos+4))
      snum  = dec:sub(pos+5, pos+14)
      name_len = string.byte(dec, pos+15)
      pos  = pos+16
      name = dec:sub(pos, pos+name_len)
      pos  = pos+name_len
      room_num = string.byte(dec, pos)
      Devices[adr] = name
   end
 
   print("\nDevices\n-------")
      for adr, name in pairs(Devices) do
      print(name, adr)
   end
 
end
 
function maxCmd_C(data)
--   print('C='..data)
end
 
function maxCmd_L(data)
print("\nDevice status\n-------------")
   pos = 1
   dec = Basexx.from_base64(data)
   L_hex = Basexx.to_hex(dec)
   L_len = string.len(L_hex)
 
   while (pos < L_len) do
 
      s = L_hex:sub(pos,(pos+1))
      data_len  = tonumber(s,16) + 1
      hex  = L_hex:sub(pos,pos+(data_len*2))
      adr  = hex:sub(3,8)
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
         s = hex:sub(25,26)
         temp = tonumber(s,16) / 10
         dtype = "Thermostat"
      elseif (data_len == 12) then -- HeatingThermostat (dev_type 1 or 2)
         s = hex:sub(15,16)
         valve_pos = tonumber(s,16)
         s = hex:sub(17,18)
         setpoint = tonumber(s,16) / 2
         s = hex:sub(21,22)
         temp = tonumber(s,16) / 10
         dtype = "Valve    "
      end
print(dtype, name, "Setpoint="..setpoint, "Temp="..temp, "Valve pos="..valve_pos, "Battery="..sbat, "Mode="..smode)
      pos = pos + (data_len*2)
   end
end
 
local tcp = Socket.connect(MaxIP, MaxPort)
 
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
      maxCmd_H(data)
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