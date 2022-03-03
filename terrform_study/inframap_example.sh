cat deploy_ec2_elb/terraform.tfstate.backup | /root/inframap/inframap prune --tfstate | /root/inframap/inframap generate --tfstate | graph-easy > inframap_example.sh


       im_out.tcp/80->80

  |
  |
  v

        aws_lb.example


     im_out.tcp/8080->8080

  |
  |
  v

 aws_autoscaling_group.example