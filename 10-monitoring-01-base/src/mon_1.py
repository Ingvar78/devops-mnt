#!/usr/bin/env python3

import os
import json
import psutil
from datetime import tzinfo, timedelta, datetime

log_file_name = '/tmp/log/'+str(datetime.now().strftime("%y-%m-%d-awesome-monitoring.log"))
timestamp = (datetime.now() - datetime(1970, 1, 1)) / timedelta(seconds=1)

if not os.path.isfile(log_file_name):
    with open(log_file_name, 'w+') as file:
        file.write('')
else:
    with open(log_file_name, 'a') as file:
        file.write(str({
        "Timestamp":timestamp,
        "CPU Load":psutil.cpu_percent(),
        "Load Average":psutil.getloadavg(),
        "Root fs free space":psutil.disk_usage('/').free,
        "Memory available":psutil.virtual_memory().available,
        "Memory available %":psutil.virtual_memory().available * 100 / psutil.virtual_memory().total,
        "Memory used %":psutil.virtual_memory().percent,
        "Swap Free":psutil.swap_memory().free,
        "Swap Use %":psutil.swap_memory().percent
        })+"\n")