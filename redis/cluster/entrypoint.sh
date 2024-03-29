#!/bin/bash
redis-server /opt/redis-stable/redis.conf --daemonize yes 

tail -f /dev/null # lenh nay de treo shell -> khong thoat container 