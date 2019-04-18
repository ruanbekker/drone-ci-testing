FROM alpine
RUN apk add --no-cache git
CMD ["echo", "/test.txt"]
