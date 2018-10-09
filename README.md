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

* Run minishift command printed in the last ansible step


# Troubleshooting

In case encountering the following error

```
Error starting the VM: Error starting stopped host: generic driver does not support start
```

remove your `~/.minishift` dir and retry.
