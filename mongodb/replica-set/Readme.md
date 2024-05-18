# Các bước khởi tạo:

- B1. Khởi chạy các container  
    ```
    docker compose -f mongo-replica.yaml up -d
    ```
- B2. Truy cập vào bash 1 trong các container  
    ```
    docker exec -it mongodb-server-cf-1 bash
    ```
- B3. Vào mongosh, và dùng db admin.
- B4. Khởi tạo cụm sử dụng:  
    ```
    rs.initiate( 
        { _id : "cf",
            members: [ 
                { _id: 1, host:"mongodb-server-cf-1:27017" },
                { _id: 2, host: "mongodb-server-cf-2:27017" },
                { _id: 3, host: "mongodb-server-cf-3:27017" } 
            ] 
        })
    ```
- B5. Tạo authenticaion lần đầu:
    ```
    db.createUser(
        {
            user: "admin",
            pwd: passwordPrompt(), // or cleartext password
            roles: [
                { role: "userAdminAnyDatabase", db: "admin" },
                { role: "readWriteAnyDatabase", db: "admin" },
                { role: "root", db: "admin"}
            ]
        }
    )
    ```

- B6. Cài đặt read, write concern: 
    ```
    db.adminCommand({ 
        "setDefaultRWConcern": 1,
        "defaultWriteConcern": { "w": 2 },
        "defaultReadConcern": { "level": "majority" } 
    })
    ```    
- B7. Nếu muốn tạo 1 arbiter, lúc khởi tạo sẽ bớt 1 container để làm arbiter và thực hiện chạy lệnh sau ở cuối cùng:
    ```
    rs.addArb("mongodb-server-cf-3:27017")
    ```
- B8. Các lệnh xem cấu hình:
    ```
    rs.conf()
    ```
    ```
    db.adminCommand({  getDefaultRWConcern: 1 })
    ```