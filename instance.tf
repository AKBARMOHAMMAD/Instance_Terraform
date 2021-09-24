resource "aws_instance" "Jenkins_server" {
    ami = var.ami
    instance_type = "t2.micro"
    subnet_id = aws_subnet.pub-sub-1.id
    security_groups = [aws_security_group.SG.id]
    key_name = "AKBAR-KEY"
    #user_data = file("userdata.sh")
    count = 1

    tags = {
      Name = "Jenkins_server"
    }
    provisioner "remote-exec" {
        connection {
          type = "ssh"
          user = "ec2-user"
          private_key = tls_private_key.AKBAR-KEY.private_key_pem
          host = aws_instance.Jenkins_server[0].public_ip
        }
        inline = [
          "sudo yum update -y",
          "sudo yum install java-1.8* -y",
          "sudo cd /opt",
          "sudo wget https://dlcdn.apache.org/maven/maven-3/3.8.2/binaries/apache-maven-3.8.2-bin.tar.gz ",
          "sudo tar -xvzf apache-maven-3.8.2-bin.tar.gz",
          "sudo mv apache-maven-3.8.2 /opt/maven ",
          "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",
          "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key",
          "sudo amazon-linux-extras install epel -y",
          "sudo yum install jenkins -y",
          "sudo systemctl start jenkins",
          #"sudo cat /var/lib/jenkins/secrets/initialAdminPassword",
        ]
      
    }
  
}