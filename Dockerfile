# Use the official Python image with version 3.8 as the base image
FROM python:3.8

# Set the working directory within the container
WORKDIR /mail_app

# Copy the requirements file to the container
COPY requirements.txt .

# Install any Python dependencies
RUN pip install --no-cache-dir -r requirements.txt
# Install MySQL client library and netcat
RUN apt-get update && apt-get install -y default-libmysqlclient-dev netcat

# Copy your Flask application code into the container
COPY . .

# Expose the port your Flask app will run on
EXPOSE 5000

# Install MySQL client library
RUN apt-get update && apt-get install -y default-libmysqlclient-dev

# Set environment variables for MySQL connection
ENV MYSQL_HOST=mysql
ENV MYSQL_PORT=3306
ENV MYSQL_USER=root
ENV MYSQL_PASSWORD=Pitagora007#1
ENV MYSQL_DB=micro_lecturi

# Wait for MySQL to be ready before starting the Flask app
CMD ["sh", "-c", "until nc -z $MYSQL_HOST $MYSQL_PORT; do echo 'Waiting for MySQL to start...'; sleep 1; done; python mail_app.py"]
