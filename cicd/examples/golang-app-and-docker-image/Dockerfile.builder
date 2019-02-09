# SPDX-License-Identifier: MIT
# Copyright (c) 2019 Gennady Trafimenkov

FROM golang:1-alpine as builder

RUN apk add --update --no-cache build-base git

WORKDIR /src

COPY . /src

RUN go mod download
RUN go build -o /bin/app .

FROM alpine:latest

RUN apk add --update --no-cache ca-certificates

COPY --from=builder /bin/app /bin/app

ENTRYPOINT ["/bin/app"]
