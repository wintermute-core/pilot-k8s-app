FROM golang:1.18 as builder
RUN mkdir /build
ADD app/ /build/
WORKDIR /build
RUN go env -w GO111MODULE=on
ENV GOOS=linux
ENV CGO_ENABLED=0
RUN go mod download
RUN go build -a -o k8s-app .

FROM alpine:3.14
COPY --from=builder /build/k8s-app .

ENTRYPOINT [ "./k8s-app" ]
