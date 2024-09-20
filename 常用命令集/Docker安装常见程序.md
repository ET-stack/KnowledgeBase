### 安装docker

```
# 首先，使用yum remove docker* 移除之前安装的docker
yum remove docker*
# 配置yum源
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
# 下面这个命令是将软件包信息提前在本地缓存一份，用来提高搜索安装软件的速度
sudo yum makecache fast
# 安装docker
sudo yum install -y docker-ce docker-ce-cli containerd.io
# 启动Docker服务
systemctl start docker
# 设置开机自动启动
systemctl enable docker
# 测试
docker run hello-world
# 卸载的命令

sudo yum remove docker-ce docker-ce-cli containerd.io
# 软件卸载后，Docker默认的工作路径是/var/lib/docker 需要执行rm命令把这个工作路径删除
rm -rf /var/lib/docker
# 阿里云镜像加速配置
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://g090nq5l.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker

```



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

docker run --name some-elasticsearch -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" -d docker.elastic.co/elasticsearch/elasticsearch:8.14.2

docker run --name elasticsearch -p 9200:9200 -p 9300:9300 \
  -v ./elasticsearch/data:/usr/share/elasticsearch/data \
  -e "discovery.type=single-node" \
  -d docker.elastic.co/elasticsearch/elasticsearch:8.14.2
```

### **docker安装rabbitmq:3.12.2-management**

```
docker pull swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/rabbitmq:3.13.3-management
docker tag  swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/rabbitmq:3.13.3-management  docker.io/rabbitmq:3.13.3-management

docker run --name some-rabbitmq -p 5672:5672 -p 15672:15672 -d rabbitmq:3.13.3-management
#将rabbitmq的data和config做映射
docker run -d --name some-rabbit -v ./rabbitmq/data:/var/lib/rabbitmq -v /rabbitmq/config:/etc/rabbitmq rabbitmq:3.13.3-management

docker run -d  --name some-rabbit -v ./rabbitmq/data:/var/lib/rabbitmq -p 5672:5672 -p 15672:15672  rabbitmq:3.13.3-management

默认账户：guest
密码：guest
```

