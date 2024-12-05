

# Protbuf compiler for docker builds

## Setup

Add submodule "protoc" to **Proto files repository** (`your_project`).

```
- your_project
    - protoc        (this repository - git submodule)
        - go.yml    (go compiler)
        - swift.yml (swift compiler)
    - "schema"      (PROTOC_PATH)
        - *.proto
    - "generated/go"          (PROTOC_PATH_GO for go compiler)
    - "generated/swift"       (PROTOC_PATH_SWIFT for swift compiler)
    - docker-compose.yml
```

Use **docker-compose.yml** in `your_project` to define containers with mounted `/source`:

```yml

x-protoc:
  &x-protoc
  volumes:
      - ./:/source:rw
  environment:
    PROTO_PATH: schema/ # >>> /source/schema
    PROTOC_PATH_GO: generated/go
    PROTOC_PATH_SWIFT: generated/swift

services:

  # Protobuf code generation for docker builds
  # See: https://github.com/akasandra/protoc

  go:
    extends:
      file: protoc/go.yml
      service: protoc-go
    <<: *x-protoc


  swift:
    extends:
      file: protoc/swift.yml
      service: protoc-swift
    <<: *x-protoc
```

Once, pull images (to avoid build):

        $ docker-compose pull

## Usage

Generate files with:

        $ docker-compose up