FROM centos:7.5.1804 AS ui-build

COPY package.json package-lock.json ./

RUN yum install -y epel-release

RUN yum update -y 

RUN yum install curl -y

RUN curl -sL https://rpm.nodesource.com/setup_14.x | bash 

RUN yum install -y nodejs

RUN yum install npm

RUN npm run build

#RUN npm install && mkdir /react-ui && mv ./node_modules ./react-ui

#WORKDIR /react-ui

#COPY . .

#RUN npm run build

#RUN yum install -y nginx

#COPY ./.nginx/nginx.conf /etc/nginx/nginx.conf

#RUN rm -rf /usr/share/nginx/html/*

#COPY --from=ui-builder-ui /react-ui/build /usr/share/nginx/html

#EXPOSE 3080 80

#ENTRYPOINT ["nginx", "-g", "daemon off;"]