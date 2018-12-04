# Minishift on AWS EC2 instance

This setup creates ec2 instance that is ready for a single node minishift
installation.

There's a [Minikube](https://github.com/cloudowski/minikube-aws) version with
Kubernetes available too.

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

* Log in to your openshift using **https://EC2_HOSTNAME:8443** - your hostname
  can be found in `terraform output` or in the last phase of minishift
installation

# Cleaning up

Just run `destroy.yaml` playbook.

# Troubleshooting

In case encountering the following error

```
Error starting the VM: Error starting stopped host: generic driver does not support start
```

remove your `~/.minishift` dir and retry.

# Configuration

Use `*.auto.tfvars` to define variables for terraform. See [variables.tf](variables.tf) to see available options.

For example - to change SSH key create `mykey.auto.tfvars` file, e.g.

```
echo 'ssh_pubkey_path = "~/.ssh/my_other_key.pub"' > mykey.auto.tfvars
```
