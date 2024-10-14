resource "aws_key_pair" "aws_key" {
  key_name   = "aws_key"
  public_key = file("/home/user1/awskey.pem.pub")
}