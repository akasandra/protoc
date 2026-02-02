
FROM golang:1.25.6-alpine

# Go module proxy caching
# ENV GOPROXY=http://host.containers.internal:3142

# APK caching
# ENV http_proxy=http://host.containers.internal:3142
# RUN apk update 

RUN apk add --no-cache protobuf protobuf-dev

RUN go install github.com/golang/protobuf/protoc-gen-go@v1.5.4
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2