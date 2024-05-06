# syntax=docker/dockerfile:1

FROM golang:1.22 AS build

WORKDIR /app

# Add go.sum eventually
COPY go.mod ./

RUN go mod download

COPY *.go ./

RUN go build -o /hello-world

FROM gcr.io/distroless/base-debian11 AS release

WORKDIR /

COPY --from=build /hello-world /hello-world

USER nonroot:nonroot

ENTRYPOINT ["/hello-world"]
