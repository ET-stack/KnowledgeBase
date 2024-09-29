# 使用官方 Go 运行时作为基础镜像
FROM swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/library/golang:1.22.5 as builder

WORKDIR /build
COPY main.go .
RUN go build -o cicd-test-go main.go
CMD ["./cicd-test-go"]