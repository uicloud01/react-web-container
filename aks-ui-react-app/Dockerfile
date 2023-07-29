FROM centos:7.5.1804 as ui-build

COPY package.json package-lock.json ./
RUN yum update -y && \
    yum install -y epel-release curl && \
    curl -sL https://rpm.nodesource.com/setup_14.x | bash && \
    yum install -y nodejs-14.* && \
    npm install

RUN mkdir /react-ui
RUN mv ./node_modules ./react-ui

WORKDIR /react-ui
COPY . .

RUN npm run build

RUN yum install -y nginx && \
    rm -rf /etc/nginx/conf.d/default.conf && \
    rm -rf /usr/share/nginx/html/*

COPY ./.nginx/nginx.conf /etc/nginx/nginx.conf

RUN cp -r /react-ui/build/ /usr/share/nginx/html

# Create a new user 'nginx' with UID/GID 1001
RUN useradd -r -u 1001 nginx

# Change ownership of the Nginx directories to the 'nginx' user
RUN chown -R nginx:nginx /etc/nginx /var/log/nginx /var/cache/nginx /var/run/nginx

# Switch to the 'nginx' user before running Nginx
#USER nginx

EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]