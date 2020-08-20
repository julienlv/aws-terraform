# TP 2 - Installation d'une infra pour WordPress

### Création de 2 instances Ubuntu18.04 LTS sur AWS 

* ####  Instance WordPress (en 172.31.48.58)

Lorsque l'instance est créée, on se connecte en SSH.

On met à jour les paquets 
~~~~
ubuntu@ip-172-31-48-58:~$ sudo apt -y update && sudo -y apt upgrade
~~~~

On installe Apache2 
~~~~
ubuntu@ip-172-31-48-58:~$ sudo apt -y install apache2
~~~~

On installe PHP
~~~~
ubuntu@ip-172-31-48-58:~$ sudo apt -y install php
~~~~

On installe WordPress et le configurer 
~~~~
ubuntu@ip-172-31-48-58:~$ wget https://fr.wordpress.org/wordpress-latest-fr_FR.zip
~~~~
Avoir unzip au préable : sudo apt install unzip
~~~~
ubuntu@ip-172-31-48-58:~$ sudo unzip wordpress-latest-fr_FR.zip -d /var/www 
ubuntu@ip-172-31-48-58:~$ sudo chown www-data:www-data /var/www/wordpress -R
ubuntu@ip-172-31-48-58:~$ sudo chmod -R -wx,u+rwX,g+rX,o+rX /var/www/wordpress
~~~~
Configuration pour la connexion avec MariaDB
~~~~
ubuntu@ip-172-31-48-58:~$ cd /var/www/wordpress
ubuntu@ip-172-31-48-58:/var/www/wordpress$ sudo vi wp-config-sample.php
define( 'DB_NAME', 'wordpress' );
define( 'DB_USER', 'ubuntu' );
define( 'DB_PASSWORD', 'root' );
define( 'DB_HOST', '172.31.51.160:3306' );
define( 'DB_CHARSET', 'utf8' );
~~~~
* #### Instance MariaDB (en 172.31.51.160)
On met à jour les paquets 
~~~~
ubuntu@ip-172-31-51-160:~$ sudo apt -y update && sudo -y apt upgrade
~~~~
On installe MariaDB
~~~~
ubuntu@ip-172-31-51-160:~$ sudo apt install mariadb-server -y
~~~~
Sécurisation de la base de données 
~~~~
ubuntu@ip-172-31-51-160:~$ sudo mysql_secure_installation
~~~~
Configuration de la base de donées pour Wordpress
~~~~
ubuntu@ip-172-31-51-160:~$ sudo mysql_secure_installation
ubuntu@ip-172-31-51-160:~$ sudo mysql
MariaDB [(none)]> CREATE DATABASE wordpress CHARACTER SET UTF8 COLLATE UTF8_BIN;
MariaDB [(none)]> CREATE USER 'ubuntu'@'%' IDENTIFIED BY 'wordpress';
MariaDB [(none)]> GRANT ALL PRIVILEGES ON wordpress.* TO ubuntu@172.31.48.58 IDENTIFIED by "wordpress";
MariaDB [(none)]> FLUSH PRIVILEGES;
~~~~
Ajout de n'importe quelle source
~~~~
ubuntu@ip-172-31-57-160:~$ sudo vi /etc/mysql/mariadb.conf.d/50-server.cnf
# Instead of skip-networking the default is now to listen only on
# localhost which is more compatible and is not less secure.
bind-address            = 0.0.0.0
~~~~

* #### Groupe de sécurité
On configure une règle entrante sur les 2 instances pour la communication 

Pour l'instance WordPress (en 172.31.48.58)
Ajouter Tout le trafic - Tous - Tout les ports - Source 172.31.51.160/0

Pour l'instance MariaDB (en 172.31.51.160)
Ajouter Tout le trafic - Tous - Tout les ports - Source 172.31.48.58/0

De plus, on ajoute une règle entrante pour l'affichage du Wordpress depuis l'extérieur
Ajouter HTTP - TCP - Port 80 - Source 0.0.0.0/0

Nous pouvons désormais accéder au site


