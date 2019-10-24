FROM alpine

ARG AWS_CLI_VERSION

RUN echo "cli version $AWS_CLI_VERSION"

RUN exit -1