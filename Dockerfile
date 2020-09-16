FROM golang:1.14.0-alpine3.11 AS builder

WORKDIR /app
COPY . ./
RUN  GOOS=linux GOARCH=amd64 go build -o bin/linux/gorestapi


FROM scratch
#COPY --from=builder 
COPY --from=builder  /app/bin/linux/gorestapi /gorestapi
EXPOSE 4200
ENTRYPOINT ["/gorestapi"]
