chess-server
============

##Protocol
Each message between the server and client consists of a 5byte header followed by the payload.

The Header is divided as follows:

             4bytes          |        1byte
-----------------------------|--------------------
payload size in bytes (Int32) | payload type (Int8)


Payload Types are:

Int8  | Type                        | Format Example
------|-----------------------------|----------------
0     | Ping                        | None
1     | Connect                     | `{"username":"","password":""}`
2     | Connection Reply            | `{"status":"", "token":""}`
3     | Request Open Games List     | None
4     | Send Open Games List        | `{"games" :[{"id": "", "username": "", "type": ""}]}`
5     | Create Game                 | `{"type":""}`
6     | Join Game                   | `{"id":""}`
7     | Game PreGame Status         | `{"id":"", "opponent":"", "type":""}` Note: "opponent" can be empty if no opponent has joined yet
8     | Accept Game                 | `{"id":""}`
9     | Reject Game                 | `{"id":""}`
10    | Game State                  | `{"grid":[[],[],[],[],[],[],[],[]]}`
11    | Game Move                   | `{"from":"", "to":""}`
12    | Abandon Game                |
13    | Chat Message                |
14    | Generic Result              | `{"status":"", "error":""}`

* Ping
client: Ping -> server
server: : Ping reply -> client

* Connection
client: Connect -> server

* Request game list
client: Request open games list -> server
server: Send open games list -> client

* Create game
client: Create game (Wait for an opponent to join) -> server
server: Game PreGame Status -> client
client: Accept Game -> server

* Join game
client: Join game -> server
server: Game PreGame Status -> client
client: Accept Game -> server

* Ingame
server: Game state -> client
client: Game move -> server
or
server: Game move -> client
...
client1: Abandon game -> server
server: Game status -> client2

* Chat
Note: chat messages can be set at any time during a game
client: Chat message -> server
server: Chat message -> client

##Build

This project uses [gb](http://getgb.io/).
```bash
go get github.com/constabulary/gb/...
```

The json is generated using [ffjson](https://github.com/pquerna/ffjson).
```bash
go get -u github.com/pquerna/ffjson
ffjson file.go
```