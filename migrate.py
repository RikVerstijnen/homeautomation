#!/usr/bin/env python3

import requests
import json
import csv
from influxdb import InfluxDBClient
import time

def load_data(id, start, end):
    url = "https://emoncms.org/feed/data.json?id=" + id \
        + "&start=" + start \
        + "&end=" + end \
        + "&interval=25000&apikey=8e3aab86de5cbd7455bfc27da051d0f7"
    print (url)
    r = requests.get(url)
    r = r.json()
    return r

def main():

    host = '192.168.1.200'
    port = '8086'
    user = 'homeassistant'
    password = 'Rickyboy22'
    dbname = 'homeassistant'

    client = InfluxDBClient(host, port, user, password, dbname)


    # feed_id = ['217314','217321','217324','217326','217328']
    # measurement = ['m3','°C','°C','°C','°C']
    # entity = ['gas_consumption','temperature','temperatuur_badkamer_temperature','temperatuur_buiten_temperature','temperatuur_slaapkamer_morris_temperature']

    # feed_id = ['217331','217332','217333','217334','217336','217337','217338','217340','217341']
    # measurement = ['m3/h','lux','%','kWh','kWh','kWh','V','W','W']
    # entity = ['hourly_gas_consumption','luminance','relative_humidity','keukenboiler__energy','diepvries__energy','boiler_energy','boiler_voltage','boiler_power','diepvries__power']

    # feed_id = ['217342','217343','217345','217346','217349','217350','221784','221786']
    # measurement = ['kWh','kWh','kWh','kWh','W','kWh','kWh','kWh']
    # entity = ['power_consumption_low','power_consumption_normal','power_production_low','power_production_normal','power_generation','energy_generation','power_consumption_total','power_production_total']

    feed_id = ['87783','87784','87787','89113','90610','90614','90608','129145','130216','130217','130218','217184']
    measurement = ['W','W','W','°C','°C','°C','°C','W','kWh','kWh','kWh','m3']
    entity = ['keukenboiler__power','diepvries__power','boiler_power','temperature','temperatuur_buiten_temperature','temperatuur_badkamer_temperature','temperatuur_slaapkamer_morris_temperature','power_generation','power_production_total','energy_generation','power_consumption_total','gas_consumption']

    for i in range (len(feed_id)):
        # data = load_data(feed_id[i],"1520001780000","1532287385000")
        data = load_data(feed_id[i],"1438456985000","1509564185000")
        prevvalue = None
        for j in range (len(data)):
            timestamp = str(time.strftime("%Y-%m-%dT%H:%M:%SZ", time.localtime(data[j][0]/1000)))
            value = data[j][1]
            if (value != None) and (value != prevvalue):
                json_body = [
                    {
                        "measurement": measurement[i],
                        "tags": {
                            "domain_id": "sensor",
                            "entity_id": entity[i]
                        },
                        "time": timestamp,
                        "fields": {
                            "value": value
                        }
                    }
                ]
                # print(timestamp + "," + str(value))
                try:
                    result = client.write_points(json_body)
                except:
                    print(result)
            prevvalue = value

if __name__ == '__main__':
    main()
