package protocol

import ()

type MsgType int

const (
	ConnectionMsg = iota
	JoinMsg
	MoveMsg
	ChatMsg
)

type Move struct {
}
