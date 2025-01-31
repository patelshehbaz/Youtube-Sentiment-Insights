#!/bin/bash
set -e  # Exit immediately if any command fails

echo "Updating system..."
sudo yum update -y

echo "Installing Docker..."
sudo amazon-linux-extras install docker -y

echo "Starting Docker service..."
sudo service docker start

echo "Adding ec2-user to the docker group..."
sudo usermod -a -G docker ec2-user

echo "Pulling Docker image..."
sudo docker pull shehbaz1994/youtube-sentiment-analysis:${docker_image_tag}

echo "Running Docker container..."
sudo docker run -d -p 80:5001 shehbaz1994/youtube-sentiment-analysis:${docker_image_tag}



# sudo yum update -y
# sudo amazon-linux-extras install docker -y
# sudo service docker start
# sudo usermod -a -G docker ec2-user
# sudo docker pull shehbaz1994/youtube-sentiment-analysis:${docker_image_tag}
# sudo docker run -d -p 80:5001 shehbaz1994/youtube-sentiment-analysis:${docker_image_tag}