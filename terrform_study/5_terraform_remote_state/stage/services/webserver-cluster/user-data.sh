#!/bin/bash

cat > index.html <<EOF
<h1>Hello, World</h1>
<p>DB address: ${data.terraform_remote_state.db.outputs.address}</p>
<p>DB port: ${data.terraform_remote_state.db.outputs.port}</p>
EOF


# <p>DB address: ${db_address}</p>
# <p>DB port: ${db_port}</p>

nohup busybox httpd -f -p ${server_port} &
