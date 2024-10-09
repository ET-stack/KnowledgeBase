1. **获取集群状态**:
   ```sh
   kubectl cluster-info
   ```

2. **查看集群中的节点**:
   ```sh
   kubectl get nodes
   ```

3. **查看所有命名空间中的资源对象**:
   ```sh
   kubectl get all --all-namespaces
   ```

4. **查看特定类型的资源对象**:
   ```sh
   kubectl get pods # 查看 Pod 列表
   kubectl get deployments # 查看 Deployment 列表
   kubectl get services # 查看 Service 列表
   ```

5. **查看资源的详细信息**:
   ```sh
   kubectl describe pod <pod-name> # 查看 Pod 详细信息
   ```

6. **创建资源**:
   ```sh
   kubectl apply -f <file.yaml> # 从文件创建资源
   ```

7. **删除资源**:
   ```sh
   kubectl delete pod <pod-name> # 删除特定 Pod
   kubectl delete -f <file.yaml> # 删除文件中定义的所有资源
   ```

8. **扩展资源**:
   ```sh
   kubectl scale deployment <deployment-name> --replicas=3 # 扩展 Deployment 到 3 个副本
   ```

9. **日志**:
   ```sh
   kubectl logs <pod-name> # 获取 Pod 的日志
   kubectl logs -f <pod-name> # 跟踪 Pod 的日志
   ```

10. **进入容器**:
    ```sh
    kubectl exec -it <pod-name> -- /bin/sh # 进入 Pod 的容器内部
    ```

11. **端口转发**:
    ```sh
    kubectl port-forward <pod-name> <local-port>:<container-port> # 将集群中的容器端口转发到本地端口
    ```

12. **配置和设置**:
    ```sh
    kubectl config view # 查看当前的 kubeconfig 文件内容
    kubectl config use-context <context-name> # 切换上下文
    ```

13. **Rolling update**:
    ```sh
    kubectl rollout status deployment <deployment-name> # 查看 Deployment 的滚动更新状态
    ```

14. **Rollback**:
    ```sh
    kubectl rollout undo deployment <deployment-name> # 回滚到最后一个稳定的版本
    ```

15. **查看集群事件**:
    ```sh
    kubectl get events # 查看集群中的事件
    ```

16. **创建服务**:
    ```sh
    kubectl expose deployment <deployment-name> --type=LoadBalancer --port=80 --target-port=8080 # 为 Deployment 创建服务
    ```

17. **编辑资源**:
    ```sh
    kubectl edit deployment <deployment-name> # 编辑 Deployment 配置
    ```

18. **查看资源使用情况**:
    ```sh
    kubectl top pod # 查看 Pod 的资源使用情况
    ```

19. **查看集群的资源配额和限制**:
    ```sh
    kubectl describe quota # 查看资源配额
    kubectl describe limitrange # 查看资源限制
    ```

20. **查看网络策略**:
    ```sh
    kubectl get networkpolicies # 查看网络策略
    ```

这些命令覆盖了 Kubernetes 资源的大部分管理任务。要了解更多命令和选项，可以使用 `kubectl help` 或者 `kubectl <command> --help` 查看具体命令的帮助信息。