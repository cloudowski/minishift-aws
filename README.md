# Minishift on AWS EC2 instance

This setup creates ec2 instance that is ready for a single node minishift
installation.

# Quickstart

* Initialize terraform

```
terraform init
```

* Run `create.yaml` playbook (Ansible >= 2.5 required - terraform module is
  used)

```
ansible-playbook create.yaml
```

* Run minishift command printed by the last ansible step


