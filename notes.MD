

to connect vpn ' ssh  -i ~/.ssh/openvn openvnas@<public IP>
create ec2 instance
configure using ansible
stop the instance
take AMI --> Launch template
launch it using autoscaling

when traffic increase
use AMI to add the servers

target group
ALB rules


create ec2 instance
configure it using ansible
stop the server
take AMI --> with new version
delete the instance

create launch template
	ami, network, sg, etc.
create target group
create ASG using launch template and place them in TG
create rule in load balancer


create ansible server and provide backend ec2 instance
ansible can connect to it...

ansible used for push and pull notifications.


provisioners
	local and remote

I need to use remote provisioner, connection block

null resource and trigger

null resource --> It will not do anything, means it wont create any resource. But useful for provisioners
https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource

backend.sh creating its for : 
from local, using terraform need to copy in backend server. so creating backend.sh

file provisioner : it used for from local script(backend.sh) send to terraform

file provisioner :

https://developer.hashicorp.com/terraform/language/resources/provisioners/file

terraform to shell success

terraform apply success


terraform --> Shell --> Ansible

to send shell to ansible, using ansible pull cocept
https://github.com/jktr/ansible-pull-example

use taint command to forcing to to recreate 

if you have existing folder how can you make it as git repo
------------------------------------------------------------
we need to intialise git
git init

git branch -M main

aws ec2 terminate-instances --instance-ids instance-id1

to destroy resources from back:


for i in $(ls -dr */) ; do echo ${i%/}; cd  ${i%/} ; terraform destroy -auto-approve ; cd .. ; done


to apply resources from start 

for i in $(ls -d */) ; do echo ${i%/}; cd  ${i%/} ; terraform apply -auto-approve ; cd .. ; done

60-backend
$ terraform init
$ terraform plan

provisioner run only while instance create, provisioner will not run while update

so force to terraform to repeat again

so using taint command

taint command forcing to repeat resource

$ terraform taint null_resource.backend

it helps to rerun 

$ terraform plan

$ terraform apply -auto-approve

apply completed

open instance : backend

private IP address used to open server, since vpn active can open backend private ip.

ec2-user
DevOps321

$ netstat -lntp

8080

$ curl localhost:8080/health
$ curl -I localhost:8080/health
$ curl localhost:8080/transactions

$ mysql -h mysql.dev.vardhanglobal.online -u root -p Expense@App1

mysql > show databases;

mysql > use transactions;

mysql > show tables;

mysql > exit

adding a block to stop ec2 instances using terraform

https://stackoverflow.com/questions/64460706/how-to-stop-start-running-ec2-instance-via-terraform

resource "aws_ec2_instance_state" "test" {
  instance_id = aws_instance.test.id
  state       = "stopped"
}

paralelly run the resources, so adding dependency

 depends on =[null_resource.backend]

backend instance stopped

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ami_from_instance

$ terraform plan

$ terraform apply -auto-approve


resource "null_resource" "backend" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    instance_id = module.backend.id
  }

  provisioner "local-exec" {
      command = "aws ec2 terminate-instances --instance-ids ${module.backend.id}"
    
  }

  depends_on = [aws_ami_from_instance.backend]

}

$terraform plan


Create EC2
Configure EC2 Using ANsible and provisioner
	remote provisioner
	variables in terraform --> Shell script --> ansible-pull
stopped EC2
take AMI
delete the instance

LB, Listener, Default rule

target group
launch template

:8080/health

for i in 10-vpc 20-sg 30-bastion 40-rds 50-app-alb 50-vpn; do cd $i ; terraform apply -auto-approve ; cd ..; done
for i in 60-backend 70-acm 80-web-alb; do cd $i ; terraform apply -auto-approve ; cd ..; done
2 instances --> 60 80

backend.app-dev.vardhanglobal.online --> forward this backend target group

expense-dev.vardhanglobal.online --> expense website

aws lb target group

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group

aws launch template

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template

$ terraform plan -target=aws_launch_template.backend

$ terraform apply -target=aws_launch_template.backend

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy

Terraform: Taint
Purpose:

Tainting a resource marks it for recreation during the next terraform apply operation. This is useful when you want to forcefully destroy and recreate a resource without changing its configuration.

Command: You can taint a resource using:

terraform taint <resource>
Effect:

The resource will be destroyed and then recreated, even if there are no configuration changes. This can be useful when a resource becomes corrupted or you want to trigger a fresh start for it.

Dependency Impact:

When you taint a resource that has dependencies (other resources rely on it), those dependent resources might not be destroyed and recreated unless their configuration explicitly changes as a result of the tainted resource being recreated. Terraform will maintain the dependency order but will only recreate the tainted resource unless other dependent resources are also affected indirectly.

Terraform: Target
Purpose:

The -target flag is used to apply or destroy only specific resources in a Terraform configuration, bypassing others.

Command: You can specify a target using:

terraform apply -target=<resource>
Effect:

Terraform will only manage the targeted resource and ignore others during the plan and apply phases. This can be useful when you are debugging or deploying just a part of your infrastructure.

Dependency Impact:

This is where it gets tricky. When you use -target on a resource that has dependencies, Terraform might not properly handle the dependent resources. If the target resource depends on something else or has resources depending on it, those dependencies may be missed, leading to a broken or incomplete state.

NOTE: Even you target a specific resource terraform will still evaluate the desired infra and actual infra.

Best Practices: Use taint cautiously when you need to recreate a resource and want to ensure that all its dependencies are also properly handled by Terraform. Avoid using -target in production for complex infrastructures with multiple dependencies. It can break dependency chains and lead to an inconsistent state. It's more suited for debugging or when you know for sure that focusing on a specific resource won't affect others. If you have a complex dependency structure, it's usually better to let Terraform handle the entire graph of resources instead of trying to target specific ones.


EC2
configure
stop
AMI
delete instance
target group
launch template
auto scaling group
autoscaling group policy

ALB Rule

R53 --> ALB --> Listener --> Rule --> Target group --> Health Check --> Instance
0 1 2 3 4

backend.app-dev.daws81s.online

app-dev.daws81s.online

catalogue.app-dev.daws81s.online
user.app-dev.daws81s.online
shipping.app-dev.daws81s.online

zeal vora --> AWS security specialist

Rolling update
-----------------
4 instances --> 2 instances

1. stop all the backend services in all instances and update the application using ansible
2. create one new instance using new version, once this is up, delete one old instance	
	create second instance and delete one more old instance
	create third instance and delete one more old  instance
	create fourth instance and delete one more old instance
	
https/SSL/TLS --> certificates

We need domain

hdfcbank.com --> https://hdfcbank.com:443

they will check authorization of your domain

certificate provider

expense-dev.daws81s.online
expense-qa.daws81s.online

*.daws81s.online