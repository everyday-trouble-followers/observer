#cloud-config

packages:
  - git
  - vim

timezone: "Asia/Tokyo"

# bootcmd:
#   - sed -i -e '/^-Xms.*/s//-Xms${elasticsearch_jvm_Xms}/g' /etc/elasticsearch/jvm.options > /dev/null
#   - sed -i -e '/^-Xmx.*/s//-Xmx${elasticsearch_jvm_Xmx}/g' /etc/elasticsearch/jvm.options > /dev/null
#   - 


runcmd:
  - curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${elastic_version}-x86_64.rpm
  - curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${elastic_version}-x86_64.rpm.sha512
  - shasum -a 512 -c elasticsearch-${elastic_version}-x86_64.rpm.sha512 
  - rpm --install elasticsearch-${elastic_version}-x86_64.rpm
  - rm -f elasticsearch-${elastic_version}-x86_64.rpm.sha512 
  - rm -f elasticsearch-${elastic_version}-x86_64.rpm
  - sed -i -e '/^-Xms.*/s//-Xms${elasticsearch_jvm_Xms}/g' /etc/elasticsearch/jvm.options > /dev/null
  - sed -i -e '/^-Xmx.*/s//-Xmx${elasticsearch_jvm_Xmx}/g' /etc/elasticsearch/jvm.options > /dev/null
  - sed -i -e '/^#cluster.name.*/s//cluster.name:\ ${elasticsearch_cluster_name}/g' /etc/elasticsearch/elasticsearch.yml > /dev/null
  - sed -i -e '/^#node.name.*/s//node.name:\ ${elasticsearch_node_name}/g' /etc/elasticsearch/elasticsearch.yml > /dev/null
  - sed -i -e '/^#network.host.*/s//network.host:\ ${elasticsearch_network_host}/g' /etc/elasticsearch/elasticsearch.yml > /dev/null
  - sed -i -e '/^#http.port.*/s//http.port:\ ${elasticsearch_http_port}/g' /etc/elasticsearch/elasticsearch.yml > /dev/null
  - sed -i -e '/^#discovery.seed_hosts.*/s//discovery.seed_hosts:\ ${elasticsearch_discovery_seed_hosts}/g' /etc/elasticsearch/elasticsearch.yml > /dev/null
  - sed -i -e '/^#cluster.initial_master_nodes.*/s//cluster.initial_master_nodes:\ ${elasticsearch_cluster_initial_master_nodes}/g' /etc/elasticsearch/elasticsearch.yml > /dev/null
  - systemctl start elasticsearch
  - systemctl enable elasticsearch

power_state:
  delay: "+7"
  mode: reboot
  message: Bye Bye
  timeout: 30