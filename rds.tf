#RDS instance

resource "aws_db_instance" "wordpress_db" {

  identifier = "wordpressdb"

  allocated_storage = 20

  storage_type = "gp2"

  engine = "mysql"

  engine_version = "8.0.32"

  instance_class = "db.t3.micro" #"db.t4g.micro" #"db.t2.micro"

  db_name  = var.dbname   #"wordpressdb"
  username = var.username #"admin"

  password          = var.password #"password"
  availability_zone = var.availability_zone[0]


  parameter_group_name   = "default.mysql8.0"
  db_subnet_group_name   = aws_db_subnet_group.wordpress_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  skip_final_snapshot    = true

  publicly_accessible = false

  tags = {

    "Name" = "wordpressdb"

  }

}

