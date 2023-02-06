# Installing WordPress on EC2 using Terraform and Ansible
Automating Wordpress install using `terraform init` to create an EC2 instance, dynamically add the host IP to Ansible inventory file and run an Ansible playbook that installs dependencies and downloads and extracts Wordpress, creates MySQL DB and user and populates the `wp-config.php` file automatically. 

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
Remember to use your own AWS credentials in the TF file.

Upon successful run, you should see your EC2 instance with a public IP address. Visit this address in your browser to see the WordPress setup screen.

## Contributing
I am in the process of learning a lot of tools, so if you find opportunities for improvement of code, or bugs, kindly open issue or contact me. 
