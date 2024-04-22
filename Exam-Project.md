# Altschool Semester 2 Exam Project
## LAMP Stack Deployment Project Update

`Automated provisioning of two Ubuntu Servers as shown in Vagrant file.`

![Vagrant file](./Screenshots/Automate%20server%20provisioning.png)

`Create a bashscript on master node to automate the deployment of a LAMP stack.`

## Steps in creating the LAMP stack deployment script

i. `Specify shebang, update repository, install apache2, add php ondrej repo and update server repo again.`

![Create script](./Screenshots/Create%20Bashsript.png)

ii. `Install PHP8.2 and it's dependencies necessary for laravel, Enable rewrite mode and restart Apache2.`

![Install PHP8.2](./Screenshots/Install%20PHP%20and%20dependencies.png)

iii. `Install Composer and move contents of default composer.phar to composer.`

![Install Composer](./Screenshots/Install%20composer.png)

iv. `Clone Laravel into /var/www directory, install composer dependencies in laravel folder and copy contents of default env file to .env`

![Clone Laravel](./Screenshots/Clone%20laravel%20into%20var-www%20directory.png)

v. `Configure your Apache server for Laravel, then enable your configuration and disable default configuration.`

![Configure Apache server for Laravel](./Screenshots/Configure%20Apache%20server%20for%20Laravel.png)

vi. `Install MySQL and create database.`

![Install MySQL and create database](./Screenshots/Install%20MySQL%20and%20create%20database.png)

vii. `Used sed command to edit database in Laravel directory.`

![Edit database in Laravel directory](./Screenshots/Use%20sed%20command%20to%20edit%20database%20files.png)

viii. `Finally, generate app_key value, create symbolic link, run database migrations, populate database with dummy content and restart apache service.`

![Generate app_key value](./Screenshots/Generate%20app%20key%20value.png)


`After creating the bashscript, I wrote an Ansible playbook to run the following tasks on the slavenode:`

a. Execute the bashsript.
b. Create a cron job to check the server’s uptime every 12 am.

## Steps in writing the playbook, having installed Ansible and all necessary dependencies

i. `First create a host inventory file stating the IP address of the target server`

![Host inventory file](./Screenshots/Host%20inventory%20file.png)

ii. `Generate ssh keys using the ssh-keygen command and copy same to target server using the ssh-copy-id user@hostname command`
![ssh-keygen](./Screenshots/ssh-keygen.png)
![ssh-copy-id](./Screenshots/ssh-copy-id.png)

iii. `Confirm the ssh connection to slavenode using Ansible ping`

![Ansible ping](./Screenshots/Ansible%20ping.png)

iv. `Create a .yml file and specify the name of the playbook, also specify your host(s) and tasks`

![Create .yml file](./Screenshots/Create%20playbook.png)

v. `After creating the .yml file, first copy the bashscript to slavenode and grant it necessary permissions`

![Copy script](./Screenshots/Copy%20script.png)

vi. `Then create a task to execute the script on target node`

![Execute script](./Screenshots/Execute%20script.png)

vii. ![Create cronjob task](./Screenshots/Create%20task%20for%20cronjob.png)

viii. `Run the playbook using the ansible-playbook command`

![Run playbook](./Screenshots/Run%20playbook.png)

ix. `After running the playbook, load your slave IP on your we browser to confirm accessibility`

![Check accessibility](./Screenshots/Verify%20PHP%20accessibility.png)

x. `Confirm if cronjob was created on slave node`

![Confirm crontab](./Screenshots/Confirm%20crontab.png)


