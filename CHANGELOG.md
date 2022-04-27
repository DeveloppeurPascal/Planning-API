# 20220427
* création d'une icône à partir du SVG https://stock.adobe.com/fr/images/calendar-event/499291756 grâce à Pic Mob Generator (https://gamolf.itch.io/pic-mob-generator)
* ajout de l'icône pour le programme Delphi
* mise à jour des informations de version (numéro build + package) dans le programme Delphi
* ajout de l'heure de fin en consultation dans la liste des événements affichée à l'écran du programme Delphi de mise à jour
* changer les infos lorsqu'on utilise le clavier pour se déplacer dans la liste
* pouvoir supprimer des événements :
=> modifier le programme client en ajoutant une option de suppression
=> modifier l'API
=> modifier le serveur pour prendre en charge la suppression
* correction de messages d'erreur en cas de problème réseau sur l'envoi des modifications du client vers le serveur
* ajout d'un contrôle de sécurité sur les ID des événements côté serveur afin de n'avoir que des caractères autorisés dans les ID qui servent aussi en noms de fichier (ajout FilterID() dans _functions.inc.php)

# 20220405
* débogage programme Delphi et corrections diverses
* correction ordre des paramètres dans la vérification des checksum sur les endpoints de mise à jour (chanedevents.php et newevent.php)
* correction du stockage et chargement des données dans les endpoints de mise à jour (chanedevents.php et newevent.php)
* création d'un script JavaScript commun pour accéder en Ajax (XmlHttpRequest) à la liste des événements d'un planning sur un serveur donné
* création d'un exemple d'utilisation de ce script dans une page HTML
* ajout d'un .htaccess d'interdiction d'accès dans le dossier de stockage sur le serveur (base de données NoSQL)
* ajout d'un .htaccess d'interdiction d'accès dans le dossier _PRIVE sur le serveur (configurations de production)
* mise en place du script sur https://zone-abo.fr
* activation du planning zone-Abo sur le blog https://developpeur-agk.fr/
* activation du planning zone-Abo sur le blog https://developpeur-pascal.fr/
* activation du planning zone-Abo sur le blog https://se-former-a-delphi.fr/
* activation du planning zone-Abo sur le blog https://trucs-de-developpeur-web.fr/
* activation du planning zone-Abo sur le blog https://trucs-de-sysadmin.fr/

# 20220404
* création du dépôt de code sur https://github.com/DeveloppeurPascal/Planning-API
* mise en place de la documentation
* définition de l'API
* création de la librairie Pascal de gestion de l'API et de la liste des événements du planning
* création programme Delphi pour interface graphique de mise à jour de la base de données des événements du planning
* développement des programmes serveur pour les points d'entrée de l'API
* mise à jour TODO list
