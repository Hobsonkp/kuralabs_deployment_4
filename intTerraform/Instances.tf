# INSTANCE
resource "aws_instance" "web_server02" {
  ami                    = "ami-08c40ec9ead489470"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.pri_subnet1.id
  vpc_security_group_ids = [aws_security_group.web_ssh2.id]

  key_name = "ssh1"
  
  user_data = "${file("deploy.sh")}"
  
  tags = {
    "Name" : "dep4Gunicorn"
  }

  depends_on = [aws_nat_gateway.nat_gateway_prob]
  
}

resource "aws_instance" "web_server01" {
  ami                    = "ami-08c40ec9ead489470"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.pub_subnet1.id
  vpc_security_group_ids = [aws_security_group.web_ssh.id]

  key_name = "ssh1"

  user_data = <<-EOF
  #!/bin/bash
  sudo apt update 
  sleep 3
  sudo apt -y install default-jre
  sleep 3
  sudo apt -y install python3-pip
  sleep 3
  sudo apt -y install python3.10-venv
  sleep 3
  sudo apt -y install nginx
  sleep 3
  sed -i "s/# First attempt to serve request as file, then/proxy_pass http:\/\/${aws_instance.web_server02.private_ip}:8000;/" /etc/nginx/sites-enabled/default
  sed -i "s/# as directory, then fall back to displaying a 404./proxy_set_header Host \$host;/" /etc/nginx/sites-enabled/default
  sed -i "s/try_files \$uri \$uri\/ \=404;/proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;/" /etc/nginx/sites-enabled/default
  sleep 3
  sudo systemctl start nginx
  sleep 3
  sudo systemctl restart nginx
  EOF
  
  tags = {
    "Name" : "dep4Nginx"
  }
  depends_on = [aws_instance.web_server02]
}

