chess-server
============

##Protocol
Each message is preceeded by 8 bytes which describes the length of
the message.

Each connection to the server starts with a handshake