chess-server
============

##Protocol
Each message is preceeded by 8 bytes which describes the length of
the message.

Each connection to the server starts with a handshake

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