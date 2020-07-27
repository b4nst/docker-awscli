FROM python:3.7-alpine3.9

LABEL maintainer="Bastien Arata <bastyen.a@gmail.com>" \
    python-version=3.7

ENV PATH="/root/.local/bin:$PATH"
ENV PYTHONIOENCODING=UTF-8

RUN apk add --no-cache jq groff

ARG AWS_CLI_VERSION

RUN pip install --user awscli==$AWS_CLI_VERSION

ENTRYPOINT [ "aws" ]
