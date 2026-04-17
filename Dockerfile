FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 安装 Couchbase tools + rclone + gzip
RUN apt-get update && \
    apt-get install -y wget curl ca-certificates gnupg lsb-release gzip && \
    wget https://packages.couchbase.com/releases/couchbase-release/couchbase-release-1.0-amd64.deb && \
    dpkg -i couchbase-release-1.0-amd64.deb && \
    apt-get update && \
    apt-get install -y couchbase-server-community couchbase-tools && \
    curl https://rclone.org/install.sh | bash && \
    rm -rf /var/lib/apt/lists/*

# 工作目录
WORKDIR /backup

# 入口脚本
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
