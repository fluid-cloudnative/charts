# golang:1.25.12-bookworm
FROM golang:1.25.12-bookworm@sha256:a9c020ee3d1508c7be5435c262434e3d3fc1d0e76a11afeb9ddae7d60bc86aa4 AS builder
WORKDIR /src
COPY main.go .
RUN CGO_ENABLED=0 go build -o /oss-emulator main.go

FROM scratch
COPY --from=builder /oss-emulator /oss-emulator
EXPOSE 9000
ENTRYPOINT ["/oss-emulator"]
