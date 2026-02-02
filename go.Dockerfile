
FROM golang:1.25.6-alpine

ENV GOPROXY=http://host.docker.internal:3142

RUN apk add --update protobuf-dev protobuf git
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
  