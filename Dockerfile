FROM registry.cn-hangzhou.aliyuncs.com/liuyi778/nginx-npm
LABEL authors="坐公交也用券"
LABEL HOME="https://gitee.com/liumou_site"
LABEL PROJECT="https://github.com/LiuYuYang01/ThriveX-Blog"
LABEL BUILD_DATE="2025-01-14"
ENV TZ=Asia/Shanghai
ARG HTML_VERSION=2.1.5
ENV HTML_VERSION=${HTML_VERSION}
# 定义后端地址
ARG BACKEND_HOST
# 定义后端端口
ARG BACKEND_PORT=9004
ENV BACKEND_PORT=${BACKEND_PORT}
# 定义管理后台地址
ARG ADMIN_HOST
# 设置apt不交互
ENV DEBIAN_FRONTEND=noninteractive
# 设置APT不显示详情
ENV DEBCONF_NONINTERACTIVE_SEEN=true
# 设置时区
RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
# 设置工作目录
WORKDIR /thrive
# 复制所有文件到工作目录
COPY ../package*.json .
COPY docker/thrive.conf /etc/nginx/conf.d/default.conf
COPY docker/run.sh /thrive/run.sh
COPY src /thrive/src
COPY public /thrive/public
COPY *s /thrive/
COPY p* /thrive/
# 安装依赖
RUN npm install
# 修改权限
RUN chmod 777 /thrive/run.sh

# 暴露应用运行的端口
EXPOSE 80

CMD ["/thrive/run.sh"]