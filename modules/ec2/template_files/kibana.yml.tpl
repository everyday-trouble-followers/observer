#cloud-config

packages:
  - git
  - vim

timezone: "Asia/Tokyo"

runcmd:
  - curl -L -O https://artifacts.elastic.co/downloads/kibana/kibana-${elastic_version}-x86_64.rpm
  - shasum -a 512 kibana-${elastic_version}-x86_64.rpm 
  - rpm --install kibana-${elastic_version}-x86_64.rpm
  - rm -f kibana-${elastic_version}-x86_64.rpm
  - sed -i -e '/^#server.port.*/s//server.port:\ ${kibana_server_port}/g' /etc/kibana/kibana.yml > /dev/null
  - sed -i -e '/^#server.host.*/s//server.host:\ ${kibana_server_host}/g' /etc/kibana/kibana.yml > /dev/null
  - sed -i -e '/^#server.name.*/s//server.name:\ ${kibana_server_name}/g' /etc/kibana/kibana.yml > /dev/null
  - sed -i -e '/^#elasticsearch.hosts.*/s//elasticsearch.hosts:\ ${kibana_elasticsearch_hosts}/g' /etc/kibana/kibana.yml > /dev/null
  - systemctl start kibana
  - systemctl enable kibana

power_state:
  delay: "+7"
  mode: reboot
  message: Bye Bye
  timeout: 30