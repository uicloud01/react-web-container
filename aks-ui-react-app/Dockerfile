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

# Second stage: Create Nginx directories, set ownership, and configure Nginx
FROM centos:7.5.1804

# Create a new user 'nginx' with UID/GID 1001
RUN useradd -r -u 1001 nginx

# Install Nginx (if not already installed)
RUN yum update -y && \
    yum install -y epel-release && \
    yum install -y nginx

# Remove default Nginx configuration (if it exists)
RUN if [ -f /etc/nginx/nginx.conf ]; then rm /etc/nginx/nginx.conf; fi

# Copy the custom Nginx configuration to the container
COPY ./.nginx/nginx.conf /etc/nginx/nginx.conf

# Create the Nginx web root directory
RUN mkdir -p /usr/share/nginx/html

# Set the ownership to the nginx user
RUN chown -R nginx:nginx /usr/share/nginx/html

# Copy the built React app from the build-stage to the Nginx web root directory
COPY --from=ui-build /react-ui/build/ /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx with the 'nginx' user
CMD ["nginx", "-g", "daemon off;"]