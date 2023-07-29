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

# Create Nginx directories and set ownership
RUN mkdir -p /usr/share/nginx/html && \
    chown -R nginx:nginx /usr/share/nginx

# Install Nginx (if not already installed)
RUN yum update -y && \
    yum install -y epel-release && \
    yum install -y nginx

# Remove default Nginx configuration (if it exists)
RUN if [ -f /etc/nginx/conf.d/default.conf ]; then rm /etc/nginx/conf.d/default.conf; fi

# Switch to the root user temporarily to copy the files
USER root

# Copy the built React app from the build-stage to the Nginx web root directory
COPY --from=ui-build /react-ui/build/ /usr/share/nginx/html

# Set the ownership to the nginx user ID and group ID
RUN chown -R 1001:1001 /usr/share/nginx/html

# Switch back to the nginx user
USER 1001

# Copy custom Nginx configuration (if needed)
# COPY ./.nginx/nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]