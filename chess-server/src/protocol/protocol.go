package protocol

import (
	"bytes"
	"encoding/binary"
	"fmt"
	"io"
	"net"
)

// To convert Big Endian binary format of a 4 byte integer to int32
func FromBytes(b []byte) (int32, error) {
	buf := bytes.NewReader(b)
	var result int32
	err := binary.Read(buf, binary.BigEndian, &result)
	return result, err
}

// To convert an int32 to a 4 byte Big Endian binary format
func ToBytes(i int32) ([]byte, error) {
	buf := new(bytes.Buffer)
	err := binary.Write(buf, binary.BigEndian, i)
	return buf.Bytes(), err
}

func WriteMsg(conn net.Conn, payload []byte) error {
	// Send the size of the message to be sent
	bytes, err := ToBytes(int32(len(payload)))
	if err != nil {
		return err
	}
	_, err = conn.Write(bytes)
	if err != nil {
		return err
	}
	// Send the message
	_, err = conn.Write(payload)
	if err != nil {
		return err
	}
	return nil
}

func ReadMsg(conn net.Conn) ([]byte, error) {
	// Make a buffer to hold length of data
	lenBuf := make([]byte, 4)
	_, err := conn.Read(lenBuf)
	if err != nil {
		return nil, err
	}
	lenData, err := FromBytes(lenBuf)
	if err != nil {
		return nil, err
	}

	// Make a buffer to hold incoming data.
	buf := make([]byte, lenData)
	reqLen := 0
	// Keep reading data from the incoming connection into the buffer until all the data promised is
	// received
	for reqLen < int(lenData) {
		tempreqLen, err := conn.Read(buf[reqLen:])
		reqLen += tempreqLen
		if err != nil {
			if err == io.EOF {
				return nil, fmt.Errorf("Received EOF before receiving all promised data.")
			}
			return nil, fmt.Errorf("Error reading: %s", err.Error())
		}
	}
	return buf, nil
}
