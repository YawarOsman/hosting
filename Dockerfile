# Use the latest version of the Dart SDK as the base image
FROM google/dart

# Install Flutter
RUN git clone https://github.com/YawarOsman/hosting.git /usr/local/flutter
ENV PATH "$PATH:/usr/local/flutter/bin"

# Create a new app directory
WORKDIR /app

# Copy the pubspec files and download dependencies
COPY pubspec.* ./
RUN flutter pub get

# Copy the source code to the container
COPY . .

# Build the application for the web
RUN flutter build web --release

# Expose the default HTTP port
EXPOSE 8080

# Start the web server
CMD ["flutter", "run", "-d", "web-server", "--web-hostname", "0.0.0.0", "--web-port", "8080"]

