#!/bin/bash

#script to clone a PHP application from GitHub,
#install all necessary packages, and configure Apache web server and MySQL. 

#funtion storing message
show_message() {
  echo "-----> $1"
}

# Function to install packages
install_packages() {
  show_message "Updating package lists..."
  sudo apt-get update

  show_message "Installing packages..."
  sudo apt-get -y install apache2 mysql-server php libapache2-mod-php php-mysql git
}


#cloning php application from github
clone_repository(){
    local repo_url= "https://github.com/laravel/laravel"
    local app_dir="/var/www/html/your-app"

    show_message "Cloning the PHP application from GitHub..."
    git clone "$repo_url" "$app_dir"
}


#configuring mysql
configure_mysql() {
  local root_password="Tobzy2021"
  local db_name="tobi_exam"
  local db_user="master"
  local db_password="Tobzy2021"

  show_message "Configuring MySQL..."
  sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY '$root_password';"
  sudo mysql -e "CREATE DATABASE $db_name;"
  sudo mysql -e "CREATE USER '$db_user'@'localhost' IDENTIFIED BY '$db_password';"
  sudo mysql -e "GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user'@'localhost';"
  sudo mysql -e "FLUSH PRIVILEGES;"
}

#configuring apache
configure_apache() {
  show_message "Configuring Apache to serve the PHP application..."
  sudo sed -i 's/DocumentRoot \/var\/www\/html/DocumentRoot /var/www/html/your-app/' /etc/apache2/sites-available/000-default.conf
  sudo systemctl restart apache2
}         

set_file_permissions() {
  local app_dir="/var/www/html/your-app"

  display_message "Setting file permissions for the application directory..."
  sudo chown -R www-data:www-data "$app_dir"
  sudo chmod -R 755 "$app_dir"
}

# Main script
show_message "Starting provisioning script..."

install_packages
clone_repository
configure_mysql
configure_apache
set_file_permissions

show_message "Provisioning script completed!"