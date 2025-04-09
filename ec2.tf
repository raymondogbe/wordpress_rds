
# This data source would help you get the latest ami for your ec2 instance provisioning
data "aws_ami" "amzlinux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-gp2"] #Take an ami from launch instance in console and go under "AMI" to search to get the name
    #al2023-ami-2023.0.20230503.0-kernel-6.1-x86_64 This is for AL 2023
    #amzn2-ami-kernel-5.10-hvm-2.0.20230418.0-x86_64-gp2 This is for HVM
    #[ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}


/*
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

*/

/*
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}
*/
locals {
  phpconfig = templatefile("files/wp-config.php", {
    db_port        = aws_db_instance.wordpress_db.port
    db_host        = aws_db_instance.wordpress_db.address
    db_user        = var.username
    db_pass        = var.password
    db_name        = var.dbname
    redis_endpoint = aws_elasticache_cluster.wp_redis.cache_nodes[0].address
    redis_port     = aws_elasticache_cluster.wp_redis.cache_nodes[0].port
  })
}

/* data "template_file" "phpconfig" {
  template = file("files/wp-config.php")

  vars = {
    db_port = aws_db_instance.wordpress_db.port
    db_host = aws_db_instance.wordpress_db.address
    db_user = var.username
    db_pass = var.password
    db_name = var.db_name
  }
} */


resource "aws_instance" "wp_instance" {
  ami = data.aws_ami.amzlinux2.id
  #ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  #instance_type          = var.instance_type_list[2]
  key_name               = var.key-name
  availability_zone      = var.availability_zone[0]
  vpc_security_group_ids = [aws_security_group.wp_sg.id]
  subnet_id              = aws_subnet.public_subnet1.id
  #subnet_ids              = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]
  user_data = file("wp.sh") #file("install_applications.sh")

  #count = 1
  tags = {
    Name = "wp_instance"
    #Name = "ERPLY-${count.index}"
  }

  depends_on = [
    aws_db_instance.wordpress_db,

  ]

  provisioner "file" {
    content = local.phpconfig
    #content     = data.template_file.phpconfig.rendered
    destination = "/tmp/wp-config.php"

    connection {
      type        = "ssh"
      user        = "ec2-user" #"ubuntu"
      private_key = file("calkeypair.pem")
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "while [ ! -d /var/www/html ]; do sleep 60; echo 'Waiting for Apache installation to complete...'; done",
      "sudo chown -R ec2-user:ec2-user /var/www/html",
      "sudo cp /tmp/wp-config.php /var/www/html/"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user" #"ubuntu"
      private_key = file("calkeypair.pem")
      host        = self.public_ip
    }
  }

  /* provisioner "remote-exec" {
    inline = [
      "sudo yum install http -y",
      "sudo yum install php -y",
      "sudo systemctl start httpd",
      "sudo systemctl start php",
      "cd /var/www/html",
      "sudo wget https://wordpress.org/latest.zip",
      "sudo unzip latest.zip"
    ]
  } */
  /*
  provisioner "remote-exec" {

    inline = [

      "sudo apt update",

      #"sudo apt install -y apache2 mysql-client php libapache2-mod-php php-mysql",
      "sudo apt install -y apache2 mysql-client php libapache2-mod-php php-mysql php-xml php-mbstring",


      "sudo systemctl enable apache2",

      "sudo systemctl start apache2",

      "sudo wget https://wordpress.org/latest.tar.gz",

      "tar -zxvf latest.tar.gz",

      "sudo mv wordpress /var/www/html/wordpress",

      "sudo chown -R www-data:www-data /var/www/html/wordpress",

      "sudo chmod -R 755 /var/www/html/wordpress",

      "sudo systemctl restart apache2"

    ]

  }*/

}




resource "aws_instance" "wp_instance2" {
  ami = data.aws_ami.amzlinux2.id
  #ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  #instance_type          = var.instance_type_list[2]
  key_name               = var.key-name
  availability_zone      = var.availability_zone[1]
  vpc_security_group_ids = [aws_security_group.wp_sg.id]
  subnet_id              = aws_subnet.public_subnet2.id
  #subnet_ids              = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]
  user_data = file("wp.sh") #file("install_applications.sh")

  #count = 1
  tags = {
    Name = "wp_instance2"
    #Name = "ERPLY-${count.index}"
  }

  depends_on = [
    aws_db_instance.wordpress_db,
  ]

  provisioner "file" {
    content = local.phpconfig
    #content     = data.template_file.phpconfig.rendered
    destination = "/tmp/wp-config.php"

    connection {
      type        = "ssh"
      user        = "ec2-user" #"ubuntu"
      private_key = file("calkeypair.pem")
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "while [ ! -d /var/www/html ]; do sleep 60; echo 'Waiting for Apache installation to complete...'; done",
      "sudo chown -R ec2-user:ec2-user /var/www/html",
      "sudo cp /tmp/wp-config.php /var/www/html/",
      #"sudo chown www-data:www-data /var/www/html/wp-config.php",
      #"sudo chmod 640 /var/www/html/wp-config.php",
    ]


    connection {
      type        = "ssh"
      user        = "ec2-user" #"ubuntu"
      private_key = file("calkeypair.pem")
      host        = self.public_ip
    }
  }

  /* provisioner "remote-exec" {
    inline = [
      "sudo yum install http -y",
      "sudo yum install php -y",
      "sudo systemctl start httpd",
      "sudo systemctl start php",
      "cd /var/www/html",
      "sudo wget https://wordpress.org/latest.zip",
      "sudo unzip latest.zip"
    ]
  } */
  /*
  provisioner "remote-exec" {

    inline = [

      "sudo apt update",

      #"sudo apt install -y apache2 mysql-client php libapache2-mod-php php-mysql",
      "sudo apt install -y apache2 mysql-client php libapache2-mod-php php-mysql php-xml php-mbstring",


      "sudo systemctl enable apache2",

      "sudo systemctl start apache2",

      "sudo wget https://wordpress.org/latest.tar.gz",

      "tar -zxvf latest.tar.gz",

      "sudo mv wordpress /var/www/html/wordpress",

      "sudo chown -R www-data:www-data /var/www/html/wordpress",

      "sudo chmod -R 755 /var/www/html/wordpress",

      "sudo systemctl restart apache2"

    ]

  }*/

}


/****
resource "aws_route53_zone" "my_zone" {
  name = "mydomain.com"
}

resource "aws_route53_record" "www_mydomain_com" {
  zone_id = "${aws_route53_zone.my_zone.zone_id}"
  name    = "www.mydomain.com"
  type    = "A"
  ttl     = "300"
  records = ["192.0.2.44"]
}
***/





/*
///////
provider "aws" {
  region = "us-west-1"
}

resource "aws_eks_cluster" "erply_test_cluster" {
  name     = "erply-test-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = aws_subnet.public.*.id
  }

  version = "1.29"
}

resource "aws_eks_node_group" "worker_nodes" {
  cluster_name    = aws_eks_cluster.erply_test_cluster.name
  node_group_name = "worker-nodes"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = aws_subnet.public.*.id

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  instance_types = ["t2.small"]

  depends_on = [
    aws_eks_cluster.erply_test_cluster
  ]
}

resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role" "eks_node_role" {
  name = "eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSCNIPolicy"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
  count = 2

  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)

  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index}"
  }
}
/////////

*/

