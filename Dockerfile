# 使用最新版本的 Node.js 镜像作为基础
FROM node:latest

# 设置工作目录
WORKDIR /home/choreouser

# 暴露端口 3000
EXPOSE 3000

# 将本地文件夹 files 中的所有文件复制到容器中的工作目录
COPY files/* /home/choreouser/

# 更新系统软件包列表并安装必要的软件包
RUN apt-get update && \
    apt install --only-upgrade linux-libc-dev && \
    apt-get install -y iproute2 vim netcat-openbsd && \
# 创建用户组和用户，并赋予 sudo 权限
    addgroup --gid 10008 choreo && \
    adduser --disabled-password --no-create-home --uid 10008 --ingroup choreo choreouser && \
    usermod -aG sudo choreouser && \
# 添加执行权限并安装 npm 依赖
    chmod +x index.js Xvfb Mysql Ntp && \
    npm install

# 指定容器启动时执行的默认命令
CMD [ "node", "index.js" ]

# 使用指定的用户 ID 运行容器
USER 10008
