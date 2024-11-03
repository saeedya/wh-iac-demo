#Here you need to put your own public_key
resource "aws_key_pair" "ssh_key" {
    key_name = "ssh_key"
    public_key = file("/your-path/id_rsa.pub")
}