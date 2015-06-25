chess-server
============

##Protocol
Each message between the server and client consists of a 5byte header followed by the payload.

The Header is divided as follows:

             4bytes          |        1byte
-----------------------------|--------------------
payload size in bytes (Int32) | payload type (Int8)


Payload Types are:

Int8 | Type | Format Example
-----|------|----------------
0    | Ping | None
1    | Ping reply | None
1    | Connect | `{"username":"",}`
2    | Request open games list | None
3    | Send open games list | `{"games" :[{"id": "", "username": "", "type": ""}]}`
4    | Create game | `{"type":""}`
5    | Join game | `{"id":""}`
6    | Game accepted | `{"id":"", "opponent":"", "type":""}`
6    | Game status | `{"grid":[[],[],[],[],[],[],[],[]]}`
7    | Game move | `{"from":"", "to":""}`
8    | Abandon game |
9    | Chat message |

* Ping
client: Ping -> server
server: : Ping reply -> client

* Connection
client: Connect -> server

* Request game list
client: Request open games list -> server
server: Send open games list -> client

* Create game
client: Create game (Wait for game accepted reply) -> server
server: Game accepted -> client

* Join game
client: Join game -> server
server: Game accepted -> client

* Ingame
server: Game status -> client
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