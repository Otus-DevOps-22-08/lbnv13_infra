#!/bin/env python3
import json
import os


#get data from Yandex Cloud
stream = os.popen('yc compute instances list --format json')
stream_out = json.loads(stream.read())


#empty dict
data ={'_meta':
            {
                'hostvars': {},
            }}

def getdata():
    for instance in stream_out:
        group = instance['name'].replace('reddit-', '')
        name = '{}server'.format(group)
        ip_addr =instance['network_interfaces'][0]['primary_v4_address']['one_to_one_nat']['address']
        data['_meta']['hostvars'].update({name: {'ansible_host': ip_addr}})
        data.update({group: {'hosts': [name]}})

FILE = './inventory.json'

getdata()
def return_json():
    print(json.dumps(data))
    return json.dumps(data)

with open(FILE, 'w') as file:
    file.write(json.dumps(data))
    file.close()

if __name__ == '__main__':
    return_json()
