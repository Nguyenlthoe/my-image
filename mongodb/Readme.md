# Note
## Cài đặt SCRAM Authentication cho access control

- Truy cập shell mongo:
    ```
    mongosh
    ```
- Truy cập db admin: 
    ```
    use admin
    ```
- Tạo user admin (passwordPrompt giúp nhập password): 
    ```
    db.createUser(
        {
            user: "myUserAdmin",
            pwd: passwordPrompt(), // or cleartext password
            roles: [
                { role: "userAdminAnyDatabase", db: "admin" },
                { role: "readWriteAnyDatabase", db: "admin" }
            ]
        }
    )
    ```
- Restart server để  nhận access control:
    ```
    db.adminCommand( { shutdown: 1 } )
    ```
- Start mongodb:
    ```
    mongod --dbpath /var/lib/mongo --logpath /var/log/mongodb/mongod.log --fork --auth
    ```