#!/bin/bash
mongod --config /opt/mongod.conf
tail -f /dev/null # lenh nay de treo shell -> khong thoat container 