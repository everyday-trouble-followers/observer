# Observer

Obserber is built with Elastic Stack.  
It uses Elasticsearch, Kibana, APM, and can scale easily.

## Terraform Execution Environment

- Terraform Version: v0.14.5 (changeable)
- Using Remote Development with VSCode and Docker Desktop.
  - Look at `.devcontainer/devcontainer.json`
  - You can change Terraform version by setting `build.args.TERRAFORM_VERSION`
  - To exec terraform in the container, you must set `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` and `AWS_DEFAULT_REGION` on the host's environment variables.

## Implementation procedure.

1. Initialize terraform.
```
$ terraform init
```

2. Create and swithce terraform workspace.
```
$ terraform workspace new staging
Created and switched to workspace "staging"!
...

$ terraform workspace list
  default
* staging
```

3. Set terraform variables. Here, they are set in staging directory. `terraform.tfvars` is prepared in staging directory, **and you prepare ip.tfvars in staging directory.** `ip.tfvars` is ignored by `.gitignore`
```
# ip.tfvars

# set your global ip to monitor with kiban. 
ingress_management_cidr_blocks = [ "xxx.xxx.xxx.xxx/32", "xxx.xxx.xxx.xxx/32" ]

# set server ips.
ingress_function_cidr_blocks = [ "xxx.xxx.xxx.xxx/32", "xxx.xxx.xxx.xxx/32" ]
```

4. Exec terraform plan.
```
$ terraform plan -var-file=staging/terraform.tfvars -var-file=st
aging/ip.tfvars
```

5. Exec terrafrom apply. When it is completed, ssh connection infomation and kibana url are outputed in console. It may be better to set `local exec` to write ssh information in ssh config.
```
$ terraform apply -var-file=staging/terraform.tfvars -var-file=st
aging/ip.tfvars
...

Do you want to perform these actions in workspace "staging"?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

...

Outputs:

kibana-login = [
  "http://ec2-xxx-xxx-xxx-xxx.ap-northeast-1.compute.amazonaws.com:5601",
]
ssh-apm = [
  "ssh -i ~/.ssh//observer-staging.id_rsa ec2-user@xxx-xxx-xxx-xxx.ap-northeast-1.compute.amazonaws.com",
]
ssh-elasticsearch = [
  "ssh -i ~/.ssh//observer-staging.id_rsa ec2-user@-xxx-xxx-xxx-xxx.ap-northeast-1.compute.amazonaws.com",
]
ssh-kibana = [
  "ssh -i ~/.ssh//observer-staging.id_rsa ec2-user@-xxx-xxx-xxx-xxx.ap-northeast-1.compute.amazonaws.com",
]
```