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

# Switch to the 'nginx' user before running Nginx
USER nginx

# Copy the built React app from the build-stage to the Nginx web root directory
RUN cp -r /react-ui/build/ /usr/share/nginx/html

EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]