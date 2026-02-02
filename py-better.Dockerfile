
FROM python:3.12-alpine

# APK caching
# ENV http_proxy=http://host.containers.internal:3142
# ENV https_proxy=http://host.containers.internal:3142
RUN apk update 

RUN apk add --no-cache protobuf-dev 

# PIP caching
env PIP_INDEX_URL=http://host.containers.internal:5000/index PIP_TRUSTED_HOST=host.containers.internal 

ADD py-better.pip-freeze .
RUN pip install -r py-better.pip-freeze

ENV PATH=$PATH:/usr/local/bin
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib