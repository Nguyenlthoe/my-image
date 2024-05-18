- B1: Khởi tạo config server ở thư mục replica-set
- B2: Cấu hình 2 cụm replica-set để làm 2 shard. 
- B3: Khởi động mongos cho Sharded Cluster:
    ```
    mongos --configdb cf/mongodb-server-cf-1:27017,mongodb-server-cf-2:27017,mongodb-server-cf-3:27017 --bind_ip localhost,mongodb-server-cf-1 --port 27018 --keyFile mongo-key    
    ```
- B4: Sử dụng mongosh để thêm 2 shard vào cluster
    ```
    mongosh --host mongodb-server-cf-1 --port 27018
    ```
    ```
    db.runCommand( { addShard: "rs1/mongodb-server-r1-3:27017,mongodb-server-r1-2:27017,mongodb-server-r1-1:27017>" } )
    ```
    ```
    db.runCommand( { addShard: "rs1/mongodb-server-r2-3:27017,mongodb-server-r2-2:27017,mongodb-server-r2-1:27017" } )
    ```
- B5: Xem thông tin của shard theo lệnh <b>sh.status()</b> sẽ có thông tin như sau:

    ```
    shardingVersion
    { _id: 1, clusterId: ObjectId('664819c3df85bb4534c76f60') }
    ---
    shards
    [
    {
        _id: 'rs1',
        host: 'rs1/mongodb-server-r1-1:27017,mongodb-server-r1-2:27017,mongodb-server-r1-3:27017',
        state: 1,
        topologyTime: Timestamp({ t: 1716006877, i: 2 })
    },
    {
        _id: 'rs2',
        host: 'rs2/mongodb-server-r2-1:27017,mongodb-server-r2-2:27017,mongodb-server-r2-3:27017',
        state: 1,
        topologyTime: Timestamp({ t: 1716006895, i: 2 })
    }
    ]
    ---
    active mongoses
    [ { '7.0.8': 1 } ]
    ---
    autosplit
    { 'Currently enabled': 'yes' }
    ---
    balancer
    {
    'Currently enabled': 'yes',
    'Failed balancer rounds in last 5 attempts': 0,
    'Currently running': 'no',
    'Migration Results for the last 24 hours': 'No recent migrations'
    }
    ---
    databases
    [
    {
        database: { _id: 'config', primary: 'config', partitioned: true },
        collections: {
        'config.system.sessions': {
            shardKey: { _id: 1 },
            unique: false,
            balancing: true,
            chunkMetadata: [ { shard: 'rs1', nChunks: 1 } ],
            chunks: [
            { min: { _id: MinKey() }, max: { _id: MaxKey() }, 'on shard': 'rs1', 'last modified': Timestamp({ t: 1, i: 0 }) }
            ],
            tags: []
        }
        }
    }
    ]

    ```