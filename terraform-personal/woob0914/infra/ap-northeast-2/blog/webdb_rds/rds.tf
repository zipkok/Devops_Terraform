resource "aws_db_instance" "my-db" {
    identifier                = "my-db"
    allocated_storage         = 20
    storage_type              = "gp2"
    engine                    = "mariadb"
    engine_version            = "10.6.7"
    instance_class            = "db.t3.micro"
    name                      = "my_db"
    username                  = "admin"
    password                  = "xxxxxxxx"
    port                      = 3306
    publicly_accessible       = false
    availability_zone         = "ap-northeast-2d"
    security_group_names      = []
    vpc_security_group_ids    = ["sg-0c2fcc58ef7165fd5"]
    db_subnet_group_name      = "default"
    parameter_group_name      = "default.mariadb10.6"
    multi_az                  = false
    backup_retention_period   = 7
    backup_window             = "16:00-16:30"
    maintenance_window        = "sun:19:57-sun:20:27"
    final_snapshot_identifier = "my-db-final"
}