# # Use the official Dart SDK image as the base image
# FROM google/dart:latest

# # Set the working directory in the container to /app
# WORKDIR /app

# # Copy the contents of the current directory to the container's /app directory
# COPY . .

# # Install the Flutter SDK and dependencies
# RUN curl -sL https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.7.12-stable.tar.xz | tar xJ -C /usr/local
# ENV PATH "$PATH:/usr/local/flutter/bin"
# RUN flutter config --enable-web && flutter doctor && flutter pub get

# # Build the Flutter web application
# RUN flutter build web --release

# # Use NGINX as the web server and copy the built Flutter web application to the web root
# FROM nginx:stable-alpine
# COPY --from=0 /app/build/web /usr/share/nginx/html

# # Expose the default HTTP port
# EXPOSE 80

# CMD ["flutter", "run"]


FROM google/cloud-sdk:latest

WORKDIR /app

RUN flutter pub get

RUN flutter build web

EXPOSE 8080

CMD ["flutter", "run", "--release", "--host", "0.0.0.0", "--port", "8080"]