### **docker安装镜像**

```
sudo tee /etc/docker/daemon.json <<EOF
{
    "registry-mirrors": ["https://dockerhub.icu"]
}
EOF

sudo systemctl daemon-reload
sudo systemctl restart docker
```

### docker 镜像搜索（除官网外

```
https://docker.aityp.com/image/docker.io/minio/minio:RELEASE.2024-07-15T19-02-30Z
```

### docker安装minio

```
docker pull swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/minio/minio:RELEASE.2024-07-15T19-02-30Z

docker tag  swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/minio/minio:RELEASE.2024-07-15T19-02-30Z  docker.io/minio/minio:RELEASE.2024-07-15T19-02-30Z

docker run -p 9000:9000 -p 9001:9001 --name myMinio -d -e "MINIO_ACCESS_KEY=admin" -e "MINIO_SECRET_KEY=12345678" -e "MINIO_BROWSER=on" -v ./data:/data -v ./config:/root/.minio  docker.io/minio/minio:RELEASE.2024-07-15T19-02-30Z server /data --console-address ":9001"

访问http://ip:9001/login
```

### docker安装elasticsearch:8.14.2

```
docker pull swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.elastic.co/elasticsearch/elasticsearch:8.14.2
docker tag  swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.elastic.co/elasticsearch/elasticsearch:8.14.2  docker.elastic.co/elasticsearch/elasticsearch:8.14.2

docker run --name some-elasticsearch -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" -d elasticsearch:8.8.1

```

### **docker安装rabbitmq:3.12.2-management**

```
docker pull swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/library/rabbitmq:3.12.2-management-linuxarm64
docker tag  swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/library/rabbitmq:3.12.2-management-linuxarm64  docker.io/library/rabbitmq:3.12.2-management

docker run --name some-rabbitmq -p 5672:5672 -p 15672:15672 -d rabbitmq:3.12.2-management

默认账户：guest
密码：guest
```

