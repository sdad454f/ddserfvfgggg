# 文件名：Dockerfile.backup
FROM debian:12-slim

ENV DEBIAN_FRONTEND=noninteractive

# 基础工具：bash + gzip + curl + ca-certificates
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      bash \
      ca-certificates \
      curl \
      gzip \
      default-mysql-client \
      unzip && \
    rm -rf /var/lib/apt/lists/*

# 安装 rclone 二进制
RUN set -e; \
    curl -s -L https://downloads.rclone.org/rclone-current-linux-amd64.zip -o /tmp/rclone.zip; \
    unzip -qq /tmp/rclone.zip -d /tmp; \
    cp /tmp/rclone-*-linux-amd64/rclone /usr/bin/rclone; \
    chmod 755 /usr/bin/rclone; \
    rm -rf /tmp/rclone*

# 默认 shell
SHELL ["/bin/bash", "-c"]

CMD ["bash"]
