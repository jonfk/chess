package protocol

import ()

type MsgType int

const (
	Ping = iota
	Connect
	ConnectionReply
	RequestOpenGamesList
	SendOpenGamesList
	CreateGame
	JoinGame
	GamePreGameStatus
	AcceptGame
	RejectGame
	GameState
	GameMove
	AbandonGame
	ChatMessage
	GenericResult
)

type PingMsg struct {
}

type ConnectMsg struct {
}

type ConnectionReplyMsg struct {
}

type RequestOpenGamesListMsg struct {
}

type SendOpenGamesListMsg struct {
}

type CreateGameMsg struct {
}

type JoinGameMsg struct {
}

type GamePreGameStatus struct {
}

type AcceptGameMsg struct {
}

type RejectGameMsg struct {
}

type GameAcceptedMsg struct {
}

type GameStateMsg struct {
}

type GameMoveMsg struct {
}

type AbandonGameMsg struct {
}

type ChatMessageMsg struct {
}

type GenericResultMsg struct {
}
