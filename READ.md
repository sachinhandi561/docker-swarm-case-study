# Steps:
## Assumptions:
 - terraform version 0.11.14
 - Ansible version: 2.9.1

1. Download the repo or unzip the file.
2. Open variables.tf file and update the below information.
   - Region -->ap-south-1(Default)
   - AMI Id --> Keep same if region is ap-south-1
   - subnet --> Change as per your VPC.
   - public key path ---> By default it will check the public key in the /home/user/.ssh/ folder.
3. Initialize terraform
   ```terraform init```
4. Apply Terraform 
   ```terraform apply```
5. Once everything is done it will show the output.like below


Outputs:

MASTER = 13.126.119.190
WORKER1 = 13.233.119.232
WORKER2 = 15.206.147.247
WORKER3 = 13.232.3.74
WORKER4 = 13.233.6.29

### Terraform:
 - Terraform will create below resources.
   1. 1 Master
   2. 4 Workers
   3. ELB 
    3.1 Healthcheck on tcp 22
    3.2 Listener on 22/22377/80 port
   4. Security Group
6. Update the hosts file accordingly.
9. Run ansible-playbook
   ``` ansible-playbook playbook.yml ```
### Ansible:
 - Ansible will provision below resources.
   1. Configure Docker Swarm Master if Master is already not configured.
   2. Create tokens for worker.
   3. Add all 4 workers in Docker Swarm cluster.
   4. Copy docker-compose file from localhost to master server
   5. Create Docker stack based on ansible-module docker_stack with above compose file.
