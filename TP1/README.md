# TP 1 - Installation d'un serveur web sur une instance

### Création d'une instance Ubuntu18.04 LTS sur AWS 

On crée une nouvelle paire de clés (firstkeypair.pem) et on la sauvegarde afin qu'on puisse se connecter en SSH à l'instance.

### On se connecte en SSH à l'instance avec la paire de clés 
~~~~
$ ssh -i chemin/vers/firstkeypair.pem ubuntu@ip_publique_de_l'instance
~~~~

### Mise à jour des paquets 
~~~~
$ ubuntu@ip_publique_de_l'instance:~$ sudo apt -y update && sudo -y apt upgrade
~~~~

### Installation d'Apache2 et vérification du fonctionnement
~~~~
$ ubuntu@ip_publique_de_l'instance:~$ sudo apt -y install apache2
$ ubuntu@ip_publique_de_l'instance:~$ sudo wget -O - http://localhost/
~~~~
* ##### Installation de w3m qui est un navigateur web via un terminal (ou une console) afin de visualiser le site 
~~~~
$ ubuntu@ip_publique_de_l'instance:~$ sudo apt -y install w3m
$ ubuntu@ip_publique_de_l'instance:~$ sudo w3m http://localhost/
~~~~

On voit le site sur l'instance via la connexion SSH.