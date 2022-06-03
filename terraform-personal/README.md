# 디렉터리 구조
modules
- aws
    - v1 (Deprecated)
    - v2
        - aws_instance 
        - aws_instance_with_alb (Attach ALB to AWS Instance)
        - aws_instance_with_eip (Attach EIP to AWS Instance)
        - aws_security_group
- infra
    - aws
        - ap-northeast-2
            - blog
                - ec2
                - alb
                - rds
            - comm_security_group
        - global
            - cloudfront
            - route53
            - s3 (Common S3 Storage)

