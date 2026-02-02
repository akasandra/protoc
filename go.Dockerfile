
FROM golang:1.25.6-alpine

RUN apk add --update protobuf-dev protobuf git
RUN go install github.com/golang/protobuf/protoc-gen-go@v1.5.4
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2
  