FROM python:3.7-alpine3.9

LABEL maintainer="Bastien Arata <bastyen.a@gmail.com>" \
    python-version=3.7

ENV PATH="/root/.local/bin:$PATH"
ENV PYTHONIOENCODING=UTF-8

RUN apk add --no-cache jq

ARG GITHUB_REF

RUN pip install --user awscli==$(echo $GITHUB_REF | sed -e "s/refs\/tags\///g")

ENTRYPOINT [ "aws" ]