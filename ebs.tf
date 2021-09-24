resource "aws_ebs_volume" "Akbar-ebs" {
    availability_zone = aws_instance.Jenkins_server[0].availability_zone
    size = 1
    tags = {
      Name = "Akbar-ebs"
    }
}

resource "aws_volume_attachment" "attach-ebs" {
    depends_on = [
      aws_ebs_volume.Akbar-ebs]
    device_name = "/dev/sdh"
    volume_id = aws_ebs_volume.Akbar-ebs.id
    instance_id = aws_instance.Jenkins_server[0].id
    force_detach = true
}