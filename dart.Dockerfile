FROM dart:3.10.8

# APT caching
ENV DEBIAN_FRONTEND=noninteractive
ENV http_proxy="" HTTP_PROXY="" https_proxy="" HTTPS_PROXY=""
RUN echo 'Acquire::http::Proxy "http://host.containers.internal:3142";' > /etc/apt/apt.conf.d/01proxy
RUN echo 'Acquire::https::Proxy "false";' >> /etc/apt/apt.conf.d/01proxy
RUN apt update

# Install protoc and the dart-protoc-plugin
RUN apt install -y protobuf-compiler
RUN dart pub global activate protoc_plugin
ENV PATH="$PATH":"/root/.pub-cache/bin"