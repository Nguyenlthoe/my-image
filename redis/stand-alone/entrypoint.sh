#!/bin/bash
redis-server --daemonize yes

tail -f /dev/null # lenh nay de treo shell -> khong thoat container 