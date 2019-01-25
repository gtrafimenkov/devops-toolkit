provider "aws" {
    region = "eu-central-1"
}

resource "aws_instance" "u1804-test" {
    ami = "${data.aws_ami.dtk-u1804-latest.image_id}"
    instance_type = "t2.micro"
    key_name = "main-key"
    tags {
      Name = "u1804-test",
      Product = "dtk-test"
    }
}
