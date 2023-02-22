# Installing WordPress on EC2 using Terraform and Ansible

Automating Wordpress install using `terraform init` to create an EC2 instance, dynamically add the host IP to Ansible inventory file and run an Ansible playbook that installs dependencies and downloads and extracts Wordpress, creates MySQL DB and user and populates the `wp-config.php` file automatically.

Update: Updated to use the singular Wordpress role from here [Ansible-Galaxy](https://galaxy.ansible.com/codenamenuke/wordpress)
> Note: The Terraform execution will create a dynamic inventory file in the local folder that will be used by Ansible.
> Note: Terraform does not recommend creating tls_private_key as the keys are stored in the Terraform state file unencrypted. Generate a key pair directly from your EC2 Dashboard.

## Pre-requisites

Edit the Ansible Configuration file with the following:

```ini
[defaults]
interpreter_python = /usr/bin/python3
host_key_checking = False
```

> Remember to use your own AWS credentials in the TF file.

## Alternate Repo for Ansible Role only

If you wish to only use the Ansible role to install WordPress without using Terraform and EC2, it can be done in one of two ways:

### Ansible Galaxy

```bash
ansible-galaxy install codenamenuke.wordpress
```

### Git Clone

```bash
git clone https://github.com/codenamenuke/wordpress-ansible-role.git
```

## How to use

```bash
git clone https://github.com/codenamenuke/wordpress-ansible-setup.git
```

Execute Terraform inside folder

```bash
terraform init
terraform validate
terraform apply
```

Upon successful run, you should see your EC2 instance with a public IP address. Visit this address in your browser to see the WordPress setup screen.

## Contributing

I am in the process of learning a lot of tools, so if you find opportunities for improvement of code, or bugs, kindly open issue or contact me.
