

# Protobuf compiler for Compose

## Setup

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

    # Settings for generation
    # See: https://github.com/akasandra/protoc

    PROTO_SOURCES_DIR: ./schema
    PROTOC_PATH_SWIFT: generated/swift
    PROTOC_PATH_GO: generated/go
    PROTOC_PATH_PY: generated/py
    PROTOC_PATH_DART: generated/dart
    PROTOC_PATH_DART: generated/dart-web

services:

  # Compiler containers

  go:
    extends:
      file: protoc/go.yml
      service: protoc-go
    <<: *x-protoc

  py:
    extends:
      file: protoc/py.yml
      service: protoc-py-better
    <<: *x-protoc

  swift:
    extends:
      file: protoc/swift.yml
      service: protoc-swift
    <<: *x-protoc

  dart:
    extends:
      file: protoc/dart.yml
      service: protoc-dart
    <<: *x-protoc
```

Pull images to avoid build:

        $ docker-compose pull

## Usage

Generate files with:

        $ docker-compose up

# Versions

 - Python
   - 3.12 
   - betterproto2==1.0
   - pydantic models mode, pydantic==2.12.5
   - [Docs](https://betterproto.github.io/python-betterproto2)
   - Server/CLient functions are **async**

  - Dart
    - 3.10.8
    - Native gRPC: Standard `protoc_plugin` for native platforms
    - gRPC-Web: Same bindings with XHR browser transport (requires Envoy proxy)

  - Swift
    - 5.9.2 (Xcode 15.2 compatible)

  - Go
    - 1.25.6

  Using an incompatible version on the generator (compiler) vs. the user app may be not supported or won't work, better pin user code to the listed versions