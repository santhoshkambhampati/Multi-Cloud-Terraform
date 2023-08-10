provider "aws" {
  region = "us-east-1"
  aws_access_key_id = YOUR_ACCESS_KEY
  aws_secret_access_key = YOUR_SECRET_KEY
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"  
  instance_type = "t2.micro"
}

output "aws_instance_ip" {
  value = aws_instance.example.public_ip
}
