![](https://img.shields.io/github/license/codenamenuke/wordpress-ansible-role) ![](https://img.shields.io/badge/ansible%20score-5%2F5-brightgreen)

WordPress Role
=========
Ansible role for installing & configuring WordPress with Apache2 server on Ubuntu Systems.

Role Variables
--------------
This role only fetches MySQL user, password and DB name as variables from `defaults/main.yml`. You can create a separate vars.yml or a vars folder or directly mention your specific vars inside the main playbook and pass encrypted variables using Ansible Vault.

```yaml
my_sql_db: wordpress
my_sql_user: wordpress
my_sql_password: randompassword
```

Dependencies
------------
This role does not have any dependencies. All of the required dependencies are installed within the role.

Example Playbook
----------------
Here is an example Playbook.

```yaml
- hosts: wordpress
  gather_facts: False

  roles:
    - wordpress
```

Contributing
------------
If you find any bugs, issues or improvement opportunities, feel free to open issues or contact me.

Disclaimer
----------
This role can alter system configurations by installing software. I can not and will not guarantee that it works as intended. Any damage or misconfiguration caused shall be your sole resposnsibility. Please study the role carefully before using.

License
-------
MIT

Author Information
------------------
© 2023. Nyukeit. [nyukeit.dev](https://nyukeit.dev)
