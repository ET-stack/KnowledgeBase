要将 Spring Boot JAR 包部署到 Minikube 上，您可以按照以下步骤进行操作：

1. 安装 Minikube：确保您已经在本地计算机上安装了 Minikube
2. 启动 Minikube：在命令行界面中，使用以下命令启动 Minikube：

   ```
   minikube start
   OR
   minikube start --image-mirror-country='cn' --kubernetes-version=v1.23.8 --force
   ```

   这将启动一个本地的 Kubernetes 集群。

3. 构建 Docker 镜像：将您的 Spring Boot JAR 包构建为 Docker 镜像。在命令行界面中，进入您的 Spring Boot 项目目录，并使用以下命令构建 Docker 镜像：

   在这之前需要创建Dockerfile
   ```
        FROM openjdk:8-jre-slim
        WORKDIR /app
        COPY k8s-demo-0.0.1-SNAPSHOT.jar app.jar
        EXPOSE 8080
        CMD ["java", "-jar", "app.jar"]
    ```
   ```
   docker build -t k8s-demo:v1.0 .
   ```

   将 `your-image-name` 替换为您的镜像名称，`tag` 替换为您的镜像标签。请确保在命令的末尾有一个点，表示 Docker 上下文是当前目录。

1. 运行 Docker 镜像：使用以下命令在 Minikube 中运行 Docker 镜像：

   ```
   kubectl run k8s-demo --image=k8s-demo:v1.0 --port=8080
   ```

   将 `your-deployment-name` 替换为您的部署名称，`your-image-name:tag` 替换为您之前构建的 Docker 镜像的名称和标签。
要创建部署（Deployment），您需要定义一个包含有关应用程序部署和管理的配置的 YAML 文件。以下是一个示例的 Deployment 配置文件：

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: k8s-demo
spec:
  replicas: 3
  selector:
    matchLabels:
      app: k8s-demo
  template:
    metadata:
      labels:
        app: k8s-demo
    spec:
      containers:
        - name: k8s-demo
          image: your-image:tag
          ports:
            - containerPort: 8080
```

在上述示例中，您需要根据您的应用程序和环境进行适当的调整：

- `metadata.name`：指定部署的名称，这里为 "k8s-demo"。
- `spec.replicas`：指定要创建的副本数量。
- `spec.selector.matchLabels` 和 `spec.template.metadata.labels`：用于标识部署所管理的 Pod 的标签。
- `spec.template.spec.containers`：定义要在 Pod 中运行的容器的配置。您需要指定容器的名称、映像名称和标签。
- `spec.template.spec.containers.ports`：指定容器暴露的端口。

根据您的实际需求，您可能还需要在 Deployment 配置中添加其他配置，例如资源限制、环境变量等。

保存 Deployment 配置文件为 `deployment.yaml`（或其他任意名称），然后使用 `kubectl` 命令来创建部署：

```
kubectl apply -f deployment.yaml
```

上述命令将根据配置文件创建 Deployment 对象，并将其应用到 Kubernetes 集群中。请确保在运行命令之前设置正确的上下文，以便连接到正确的 Kubernetes 集群。

创建成功后，您可以使用 `kubectl get deployments` 命令来验证部署是否已成功创建。

如果您需要进一步的帮助，请提供更多关于您的应用程序和环境的详细信息，以便我能够更好地指导您。




2. 暴露服务：使用以下命令将服务暴露给外部访问：

   ```
   kubectl expose  deployment  k8s-demo --type=LoadBalancer
   ```

   这将为您的服务创建一个外部访问的负载均衡器。

3. 查看服务：运行以下命令以获取服务的 IP 地址和端口号：

   ```
   minikube service k8s-demo
   ```

   将 `your-deployment-name` 替换为您之前创建的部署的名称。此命令将打开浏览器，并显示服务的 IP 地址和端口号。

现在，您的 Spring Boot 应用程序应该已经成功部署到 Minikube 上。您可以使用浏览器或其他工具访问 Minikube 集群中的服务。