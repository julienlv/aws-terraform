# TP3 : modifier le plan pour créer deux instances et installer Wordpress

## Partir de TFex

L'objectif est de déployer deux instances, l'une installant et
configurant Apache2/PHP/Wordpress, l'autre MariaDB de façon
à ce que Wordpress soit fonctionnel 100% automatiquement.

Copiez ici les répertoire ssh-keys, Scripts et Tf (et ajouter au git)
(dans Tf ne copiez que go et les fichier `*tf`)

Supprimez les clefs `id_rsa*` du répertoire ssh-key si besoin.

Générer les clefs à nouveau.

~~~~
cp -r ../TFex/Scripts .
mkdir ssh-keys
cp ../TFex/generate_keys ssh-keys
cd ssh-keys
./generate_keys
cd ..
mkdir Tf
cp ../Tf/*tf ../Tf/go* Tf/
cd Tf
terraform init
~~~~

Modifier le plan terraform (instances.tf) pour créer deux instances
avec deux IP privées différentes. Nommez les instance de façons la
plus logique possible (en fonction de leur rôle).

Modifier le plan pour exécuter des scripts distincts : l'un qui installe
Apache2, PHP et Wordpress et les configure sur une instance et l'autre qui installe et
configure MariaDB sur l'autre.

