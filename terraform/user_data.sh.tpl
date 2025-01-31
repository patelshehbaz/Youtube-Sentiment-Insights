#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo docker pull shehbaz1994/youtube-sentiment-analysis:${docker_image_tag}
sudo docker run -d -p 80:5001 shehbaz1994/youtube-sentiment-analysis:${docker_image_tag}