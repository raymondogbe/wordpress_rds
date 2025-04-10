#This is what the terraform apply would showcase after it finish running. 
# For each does not support splat, therefore, you should use list.

output "instance_publicIP" {
  description = "EC2 instance Public IP"
  #value       = [for instance in aws_instance.ERPLY : instance.public_ip]
  value = aws_instance.wp_instance.public_ip
}

output "instance_publicDNS" {
  description = "EC2 instance Public DNS"
  #value = [for instance in aws_instance.ERPLY: instance.public_dns]
  value = aws_instance.wp_instance.public_dns
  #value = aws_instance.ERPLY[*].public_dns
}

output "redis_output" {
  value = aws_elasticache_cluster.wp_redis.id
}
output "elasticache_cluster_endpoint" {
  value = aws_elasticache_cluster.wp_redis.arn
}

# RDS Endpoint output
output "rds_endpoint" {
  value = aws_db_instance.wordpress_db.endpoint
}

output "database_name" {
  value = aws_db_instance.wordpress_db.db_name
}

output "db_username" {
  value = aws_db_instance.wordpress_db.username
}

output "db_password" {
  value     = aws_db_instance.wordpress_db.password
  sensitive = true
}

output "redis_endpoint" {
  value = aws_elasticache_cluster.wp_redis.cache_nodes[0].address
}

output "redis_port" {
  value = aws_elasticache_cluster.wp_redis.cache_nodes[0].port # This will be 6379 based on your configuration
}

/*
output name {
  value       = ""
  sensitive   = true
  description = "description"
  depends_on  = []
}
*/

/*
output "aws_ami_from_instance" {
  description = "AMI from EC2 Instance"
  value       = aws_ami_from_instance.new_ami
}
*/
/*
output "s3_bucket_id" {
  description = "The name of the bucket."
  value       = try(aws_s3_bucket.example1.id, "") #aws_s3_bucket_policy.example1.id, 
}

*/

/*

output "s3_bucket_id" {
  description = "The name of the bucket."
  value       = try(aws_s3_bucket_policy.this[0].id, aws_s3_bucket.this[0].id, "")
}


output "s3_bucket_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = try(aws_s3_bucket.this[0].arn, "")
}

output "s3_bucket_bucket_domain_name" {
  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com."
  value       = try(aws_s3_bucket.this[0].bucket_domain_name, "")
}

output "s3_bucket_bucket_regional_domain_name" {
  description = "The bucket region-specific domain name. The bucket domain name including the region name, please refer here for format. Note: The AWS CloudFront allows specifying S3 region-specific endpoint when creating S3 origin, it will prevent redirect issues from CloudFront to S3 Origin URL."
  value       = try(aws_s3_bucket.this[0].bucket_regional_domain_name, "")
}

output "s3_bucket_hosted_zone_id" {
  description = "The Route 53 Hosted Zone ID for this bucket's region."
  value       = try(aws_s3_bucket.this[0].hosted_zone_id, "")
}

output "s3_bucket_lifecycle_configuration_rules" {
  description = "The lifecycle rules of the bucket, if the bucket is configured with lifecycle rules. If not, this will be an empty string."
  value       = try(aws_s3_bucket_lifecycle_configuration.this[0].rule, "")
}

output "s3_bucket_policy" {
  description = "The policy of the bucket, if the bucket is configured with a policy. If not, this will be an empty string."
  value       = try(aws_s3_bucket_policy.this[0].policy, "")
}

output "s3_bucket_region" {
  description = "The AWS region this bucket resides in."
  value       = try(aws_s3_bucket.this[0].region, "")
}

output "s3_bucket_website_endpoint" {
  description = "The website endpoint, if the bucket is configured with a website. If not, this will be an empty string."
  value       = try(aws_s3_bucket_website_configuration.this[0].website_endpoint, "")
}

output "s3_bucket_website_domain" {
  description = "The domain of the website endpoint, if the bucket is configured with a website. If not, this will be an empty string. This is used to create Route 53 alias records."
  value       = try(aws_s3_bucket_website_configuration.this[0].website_domain, "")
}

*/