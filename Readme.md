

# Protobuf compiler for docker builds

## Setup

Add submodule "protoc" to **Proto files repository** (`my_project`).

```
- my_project

    - protoc        (this repository - git submodule)
        - go.yml    (go compiler)
        - swift.yml (swift compiler)
        - dart, py, etc ...

    - "schema"      (PROTO_SOURCES_DIR)
        - *.proto

    - "generated/go"          (PROTOC_PATH_GO for go compiler)
    - "generated/swift"       (PROTOC_PATH_SWIFT for swift compiler)
    - dart,py, etc..

    - docker-compose.yml    (config, see example below)
```

Use **docker-compose.yml** in `your_project` to define containers with mounted `/source`:

```yml

x-protoc:
  &x-protoc
  volumes:
      - ./:/source:rw
  environment:
    PROTO_SOURCES_DIR: ./schema
    PROTOC_PATH_SWIFT: generated/swift
    PROTOC_PATH_GO: generated/go
    PROTOC_PATH_PY: generated/py
    PROTOC_PATH_DART: generated/dart

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


  py:
    extends:
      file: protoc/py.yml
      service: protoc-py-better
    <<: *x-protoc
```

Once, pull images (to avoid build):

        $ docker-compose pull

## Usage

Generate files with:

        $ docker-compose up