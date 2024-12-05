
FROM python:3.9.21-alpine

RUN apk update
RUN apk add protobuf-dev 

ADD py-better.pip-freeze .
RUN pip install -r py-better.pip-freeze