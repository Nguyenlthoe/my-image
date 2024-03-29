1. Khởi tạo cluster
redis-cli -a "package1107" --cluster create 172.25.0.2:7000 172.25.0.3:7000 172.25.0.4:7000 --cluster-replicas 0