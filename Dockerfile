FROM centos:7.5.1804 AS ui-build
WORKDIR /usr/src/app
RUN yum install -y epel-release
RUN yum update -y 

RUN yum install -y nodejs

RUN yum install -y npm
CMD ["npm", "-v"]
RUN npm run build

#COPY package.json package-lock.json ./

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