
FROM swift:5.9.2 as builder

# APT caching
ENV DEBIAN_FRONTEND=noninteractive
ENV http_proxy="" HTTP_PROXY="" https_proxy="" HTTPS_PROXY=""
RUN echo 'Acquire::http::Proxy "http://host.containers.internal:3142";' > /etc/apt/apt.conf.d/01proxy
RUN echo 'Acquire::https::Proxy "false";' >> /etc/apt/apt.conf.d/01proxy
RUN apt update

RUN apt install -y libprotobuf-dev make

# TODO: tags 2.x is also available but requires Swift 6+
#RUN git clone --depth 1 --branch 1.25.0 https://github.com/grpc/grpc-swift.git --recurse-submodules --shallow-submodules
ADD grpc-swift grpc-swift

ENV SWIFTPM_CACHE_PATH=/swift-cache
VOLUME /swift-cache
VOLUME /grpc-swift/.build
RUN (cd grpc-swift && swift package resolve)

RUN (cd grpc-swift && swift build -j 12 -c release --product protoc-gen-swift)
RUN (cd grpc-swift && swift build -j 12 -c release --product protoc-gen-grpc-swift)

RUN (cd grpc-swift/.build/release/ && cp protoc-gen-swift protoc-gen-grpc-swift /usr/bin/.)

FROM swift:5.9.2-slim

# APT caching
COPY --from=builder /etc/apt/apt.conf.d/01proxy /etc/apt/apt.conf.d/01proxy
COPY --from=builder /var/lib/apt/lists /var/lib/apt/lists
ENV DEBIAN_FRONTEND=noninteractive
RUN apt install -y protobuf-compiler

COPY --from=builder /usr/bin/protoc-gen-swift /usr/bin/.
COPY --from=builder /usr/bin/protoc-gen-grpc-swift /usr/bin/.

RUN rm -rf .cache /var/lib/apt/lists/* /tmp/* /var/tmp/* && apt clean