

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
    - "generated/go"          (PROTO_GEN_PATH for go compiler)
    - "generated/swift"       (PROTO_GEN_PATH for swift compiler)
    - docker-compose.yml
```

Use **docker-compose.yml** in `your_project` to define containers with mounted `/source`:

```yml

services:

  # Protobuf code generation for docker builds
  # See: https://github.com/akasandra/protoc

  go:
    extends:
      file: protoc/go.yml
      service: protoc-go
    volumes:
      - ./:/source:rw

  swift:
    extends:
      file: protoc/swift.yml
      service: protoc-swift
    volumes:
      - ./:/source:rw

```

Create `.env` file for **compose** commands:

```env
PROTOC_PATH="schema"

PROTOC_PATH_GO="generated/go"
PROTOC_PATH_SWIFT="generated/swift"
```

Once, pull the repo (to avoid build):

        $ docker-compose pull

## Usage

Re-generate files with:

        $ docker-compose up