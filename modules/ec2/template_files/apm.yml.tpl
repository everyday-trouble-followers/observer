#cloud-config

packages:
  - git
  - vim

timezone: "Asia/Tokyo"

runcmd:
  - curl -L -O https://artifacts.elastic.co/downloads/apm-server/apm-server-${elastic_version}-x86_64.rpm
  - rpm -vi apm-server-${elastic_version}-x86_64.rpm
  - rm -f apm-server-${elastic_version}-x86_64.rpm
  - sed -i -e '/apm-server/,/  host:.*/ s/  host:.*/  host:\ "${apm_server_host}"/' /etc/apm-server/apm-server.yml > /dev/null
  - sed -i -e '/output.elasticsearch:/,/  hosts:.*/ s/  hosts:.*/  hosts:\ ${apm_output_elasticsearch_hosts}/' /etc/apm-server/apm-server.yml > /dev/null
  - systemctl start apm-server
  - systemctl enable apm-server

power_state:
  delay: "+7"
  mode: reboot
  message: Bye Bye
  timeout: 30