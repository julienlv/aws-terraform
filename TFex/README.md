Example qui crée
 
Un vpc relié à internet avec un réseau privé 10.42.1.0/24
Une instance avec sa keypair et son groupe de sécurité
(ssh + http) et son script d'init

# Étape 1 : créer la paire de clefs

~~~~
cd ssh-keys
./generate_keys
~~~~

# Étape 2 : initialiser et lancer le plan Terraform

~~~~
cd ../Tf
terraform init
terraform plan
terraform apply
~~~~

# Étape 3 : se connecter à l'instance

~~~~
./go
~~~~

# Étape 4 : pour tout supprimer

~~~~
terraform destroy
~~~~
