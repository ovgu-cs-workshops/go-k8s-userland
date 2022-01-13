FROM golang:1.17-alpine as builder
RUN apk update && apk add build-base git
WORKDIR /app
COPY go-k8s-userland/go.mod .
COPY go-k8s-userland/go.sum .
RUN go mod download
COPY go-k8s-userland .
RUN GOOS=linux GOARCH=amd64 go build -ldflags '-linkmode=external "-extldflags=-static"'
RUN cp git-userland /bin
