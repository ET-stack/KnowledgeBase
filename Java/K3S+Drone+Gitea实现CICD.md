### **流程概述**

1. **代码推送到仓库**：你将代码推送到版本控制仓库（例如 Gogs、Gitea、GitHub 等），仓库会通过 Webhook 通知 Drone。
2. **Drone 自动拉取代码并启动构建**：Webhook 触发 Drone，Drone 会拉取最新代码并根据 `.drone.yml` 文件中的定义进行构建、测试、打包等任务。
3. **部署流程**：通过 `deployment.yaml`，Drone 可以使用 Kubernetes 或者其他工具将新版本的服务自动部署到目标环境中。

首先前置条件，服务器需要安装docker和Gitea

安装K3S

```
curl -sfL https://get.k3s.io | sh -
```

```text
国内用户专属连接
curl -sfL https://rancher-mirror.rancher.cn/k3s/k3s-install.sh | INSTALL_K3S_MIRROR=cn sh -
```

安装Drone

```
docker pull drone/drone:2.24.0
```

```
国内用户专属（如果docker拉不了或者觉得太慢可以去这个网站搜索https://docker.aityp.com/）搜索镜像s
docker pull swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/drone/drone:2.24.0
docker tag  swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/drone/drone:2.24.0  docker.io/drone/drone:2.24.0
```

下载Drone-runner-docker

```
docker pull drone/drone-runner-docker:1.8.3
```

```
国内用户专属
docker pull swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/drone/drone-runner-docker:1.8.3
docker tag  swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/drone/drone-runner-docker:1.8.3  docker.io/drone/drone-runner-docker:1.8.3
```

docker一定要配置镜像地址，阿里云的不行，不然drone下不来git其他组件

```
sudo mkdir -p /etc/docker

sudo tee /etc/docker/daemon.json <<-'EOF'
{

    "registry-mirrors": [

    	"https://dockerpull.com",

        "https://docker.anyhub.us.kg",

        "https://dockerhub.jobcher.com",

        "https://dockerhub.icu",

        "https://docker.awsl9527.cn"

    ]

}
EOF

sudo systemctl daemon-reload && sudo systemctl restart docker
```



### 运行Drone

```
  docker run \
  --volume=/var/run/docker.sock:/var/run/docker.sock \
  --env=DRONE_GITEA_SERVER=http://192.168.8.177:3000 \
  --env=DRONE_GITEA_CLIENT_ID=e3c498aa-678e-4a08-8776-1683539c1fa5 \
  --env=DRONE_GITEA_CLIENT_SECRET=gto_z4ncgbhrg6pq5md7q652jw7d2qs2mcudrd5nz7xw4xl4gmlvsquq \
  --env=DRONE_RPC_SECRET=5e73accfc0ebcb83a6ce999ec6000b33 \
  --env=DRONE_SERVER_HOST=192.168.10.32:3080 \
  --env=DRONE_SERVER_PROTO=http \
  --env=DRONE_USER_CREATE=username:root,admin:true \
  --publish=3080:80 \
  --publish=443:443 \
  --restart=always \
  --detach=true \
  --name=drone \
  drone/drone:2.24.0


todo: http://192.168.8.177:3000 是你的gitea地址 
	  a0bb2ef7-6425-4f6f-be33-f22388fc12cd 是你gitea生成的id
	  gto_tsahkmjn6gwpfd7y4fh5hbifx3b7jz6tlgareg3ly653oezqahpq 是你的gitea生成的客户端密钥
	  192.168.9.198:3080 是你的服务器ip加访问端口和下面的publish对应
	  DRONE_RPC_SECRET 是 Drone Server 和 Drone Agents 之间通信的共享密钥，可以自定义生成，也可以用工具生成，先下来，后续要用
	  
清理docker的drone
sudo docker stop drone
sudo docker rm drone
sudo rm -rf /var/lib/drone  
```

![image-20240911134803909](C:\Users\xiao\AppData\Roaming\Typora\typora-user-images\image-20240911134803909.png)

![image-20240911134828077](C:\Users\xiao\AppData\Roaming\Typora\typora-user-images\image-20240911134828077.png)

![image-20240911165852410](C:\Users\xiao\AppData\Roaming\Typora\typora-user-images\image-20240911165852410.png)

执行

```
  docker run --detach \
  --volume=/var/run/docker.sock:/var/run/docker.sock \
  --env=DRONE_RPC_PROTO=http \
  --env=DRONE_RPC_HOST=192.168.10.32:3080 \
  --env=DRONE_RPC_SECRET=5e73accfc0ebcb83a6ce999ec6000b33 \
  --env=DRONE_RUNNER_CAPACITY=2 \
  --env=DRONE_RUNNER_NAME=my-first-runner \
  --publish=3000:3000 \
  --restart=always \
  --name=runner \
  drone/drone-runner-docker:1.8.3
```



示例 `.drone.yml` 文件（适用于私有 Git 仓库和本地 k3s）

```
kind: pipeline
type: docker
name: springboot-ci-k3s

steps:
  # 1. 拉取私有仓库的代码
  - name: clone
    image: alpine/git
    environment:
      GIT_USERNAME:
        from_secret: git_username
      GIT_PASSWORD:
        from_secret: git_password
    commands:
      - git clone https://your-private-git-repo.git
      - cd your-private-git-repo

  # 2. 构建 Spring Boot 项目
  - name: build
    image: maven:3.8.5-jdk-11
    commands:
      - mvn clean install -DskipTests

  # 3. 构建 Docker 镜像并推送到私有 Docker Registry
  - name: docker-build
    image: plugins/docker
    settings:
      repo: your-private-registry.local/springboot-app
      tags: latest
      registry: your-private-registry.local
      username:
        from_secret: registry_username
      password:
        from_secret: registry_password
      dockerfile: Dockerfile

  # 4. 部署到 k3s 集群
  - name: deploy
    image: bitnami/kubectl
    environment:
      KUBECONFIG:
        from_secret: kubeconfig
    commands:
      - kubectl set image deployment/springboot-app springboot-app=your-private-registry.local/springboot-app:latest
      - kubectl rollout restart deployment/springboot-app


```

