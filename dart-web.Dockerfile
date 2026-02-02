FROM dart:3.10.8

# APT caching
ENV DEBIAN_FRONTEND=noninteractive
ENV http_proxy="" HTTP_PROXY="" https_proxy="" HTTPS_PROXY=""
RUN echo 'Acquire::http::Proxy "http://host.containers.internal:3142";' > /etc/apt/apt.conf.d/01proxy
RUN echo 'Acquire::https::Proxy "false";' >> /etc/apt/apt.conf.d/01proxy
RUN apt update

# Install protoc and the dart-protoc-plugin with grpc-web support
RUN apt install -y protobuf-compiler
RUN dart pub global activate protoc_plugin

# Activate grpc-web support (for browser compatibility)
# The protoc_plugin by default uses gRPC, we need web support
# To use gRPC-Web in Dart, we need to use the web transport
ENV PATH="$PATH:$HOME/.pub-cache/bin"

# Note: The gRPC-Web compatibility is handled via the grpc package configuration
# when generating for web targets. The protoc_plugin automatically generates
# compatible code that can use either native gRPC or gRPC-Web transports.
