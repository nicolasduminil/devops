#!/bin/bash
cat > index.html <<EOF
<h1>Hello, World</h1>
<p>DB address: ${db_host_name}</p>
<p>DB port: ${db_port_number}</p>
EOF
nohup busybox httpd -f -p "${httpd_server_port}" &
