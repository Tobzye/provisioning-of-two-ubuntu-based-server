## Deploy Laravel and Set up Postgresql

# Objective:

**1. Automate the provisioning of two Ubuntu-based servers, named “Master” and “Slave”, using Vagrant.**
- to automate the provisioning of two ubuntu based server, i entered the command 'vagrant init' a vagrant file named 'vagrantfile' was automatically created in my folder, next i cleared the whole input in the vagrant file then i start writing the automation file. <br> i configured the first ubuntu server and named it 'Master', i set it hostname, Os, network, provider, memory and provision it to run a bash script 'lamp.sh'. <br> next i configured the second ubuntu server named 'Slave' giving it a hostname, Os, network, provider, memory amd provision set to run an ansible playbook 'slaveprovision.yml'.

**2. On the Master node, create a bash script to automate the deployment of a LAMP (Linux, Apache, MySQL, PHP) stack.**
- with the master node linked to a bash script 'lamp.sh', i automated the deployment of LAMP (Linux, Apache, MySQL, PHP) stack. <br> First step was to write a function to echo messages.

**3. This script should clone a PHP application from GitHub, install all necessary packages, and configure Apache web server and MySQL.**
- next was to create a function 'install_packages' which will run a message to the console, install the required packages and get updates.
- then i wrote a function 'clone_repository' to clone a php application from a github repository to a specified directory, which was intiated by the command git clone ("$repo_url" "$app_dir").
- to configure mysql i wrote a function 'configure_mysql', inside this i created variables to store rootpassword, database name, database user and database password. then i used the variables in this automation commands...

        1. sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH' mysql_native_password' BY '$root_password';" ---- to reset the MySQL root password on Ubuntu or Debian systems. <br> -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH' mysql_native_password' BY '$root_password';": This is the SQL query that is passed to the MySQL server. The ALTER USER statement is used to modify an existing MySQL user.

        2. sudo mysql -e "CREATE DATABASE $db_name;" ---- command creates a new database in the MySQL server.

        3. sudo mysql -e "CREATE USER '$db_user'@'localhost' IDENTIFIED BY '$db_password';" ---- creates a new MySQL user.

        4. sudo mysql -e "GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user'@'localhost';" ---- used to grant database permissions to a specific user in MySQL.

        5. sudo mysql -e "FLUSH PRIVILEGES;" ---- used to reload the grant tables into memory, ensuring that any changes made to user privileges since the server was last restarted are immediately recognized by the MySQL server. This is useful in scenarios where you've modified the privileges of a user or role and want those changes to take effect immediately, without having to restart the MySQL server.

- for apache web server, in the function 'configure_apache', i used these commands...

        1. sudo sed -i 's/DocumentRoot \/var\/www\/html/DocumentRoot /var/www/html/your-app/' /etc/apache2/sites-available/000-default.conf ---- 
        This command modifies the Apache web server configuration file. sed -i 's/DocumentRoot /var/www/html/DocumentRoot /var/www/html/your-app/': sed is a stream editor for filtering and transforming text. The -i option specifies that the changes should be made directly in the file, rather than being printed to the standard output. The command between the single quotes ('s/DocumentRoot \/var\/www\/html/DocumentRoot /var/www/html/your-app/') is a substitution command. It tells sed to find all occurrences of "DocumentRoot /var/www/html" in the file and replace them with "DocumentRoot /var/www/html/your-app". <br>  /etc/apache2/sites-available/000-default.conf: This is the path to the Apache configuration file that contains the DocumentRoot directive. By modifying this file, you are changing the default directory where Apache serves files.

        2. sudo systemctl restart apache2 - used to restart the Apache2 web server service on a Linux system .

- then in 'set_file_permissions' function, i made use of the sudo, chmod, chown command to set some permissions for the directory holding the php app github clone.

- lastly i initiated the functions.

**4. Using an Ansible playbook:**

**Execute the bash script on the Slave node and verify that the PHP application is accessible through the VM’s IP address (take screenshot of this as evidence)**
- in the ansible playbook connected to the slave node, The tasks carried out by the play book are:

    - Executing the bash script to deploy the laravel application
    - Debug script execution result
    - Creating cron jobs to check the server up time

**Create IAM users with minimal privileges for instructors to view instances, firewall rules, and logical networks. If sharing SSH keys is required, do so privately.**
...