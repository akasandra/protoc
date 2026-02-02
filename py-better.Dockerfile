
FROM python:3.12-alpine

RUN apk update
RUN apk add protobuf-dev 

ADD py-better.pip-freeze .
RUN pip install -r py-better.pip-freeze