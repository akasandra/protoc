
FROM golang:1.23.3-alpine

RUN apk add --update protobuf-dev protobuf git
RUN go install github.com/golang/protobuf/protoc-gen-go@v1.5.4
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2

VOLUME /source

RUN mkdir -p /out/go
  