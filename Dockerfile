FROM python:3.12-slim

# Create data directory
RUN mkdir -p /data

# Set working directory
WORKDIR /app

# Copy your files
COPY . .

# Make run.sh executable
RUN chmod +x run.sh

# Use your run.sh as entrypoint
ENTRYPOINT ["./run.sh"]