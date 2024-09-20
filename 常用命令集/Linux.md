Centos7.9

图形化关闭命令

```
systemctl set-default multi-user.target
systemctl get-default
```

防火墙禁用自启动

```
执行开机禁用防火墙自启命令 systemctl disable firewalld.service


防火墙随系统开启启动 systemctl enable firewalld.service
```

Debian12-使用清华源

```
https://mirrors.tuna.tsinghua.edu.cn/help/debian/
```

Centos7使用阿里云源

```
备份
cd /etc/yum.repos.d/
mkdir repo_bak
mv *.repo repo_bak/
下载阿里云源
wget http://mirrors.aliyun.com/repo/Centos-7.repo
yum clean all
yum makecache
```



