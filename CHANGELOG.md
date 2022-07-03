# 20220703

## Interface de paramétrage du planning (Delphi)

* ajouter une recherche à la liste des événements
* ajouter WARNING sur utilisation des codes sources sans modification des clés publiques et privées
* bogue : lorsqu'on referme le panel d'un item il reste sélectionné, ce qui empêche de le réafficher s'il n'y a pas d'autre item dans la liste pour se déplacer, il vaudrait mieux le désélectionner à la fermeture.
* renommage du bouton "save" en "send changes"
* ajout d'une fonction sur le planning actuel afin de savoir si un élément a été ajouté, modifié ou supprimé (en gros, si on doit envoyer quelque chose au serveur)
* mise en surbrillance du bouton "send changes" lorsqu'une mise à jour a été faite dans le planning jusqu'à ce qu'elle soit transmise au serveur.
* annulation du statut "modifié" des nouveaux éléments une fois envoyés au serveur
* prise en charge uniquement du statut isChanged dans la fonction hasChanged (isDeleted n'atant jamais repassé à false après envoi au serveur)
* demande de confirmation d'abandon à la fermeture du programme si des modifications n'ont pas encore été envoyées au serveur
* traiter le onAfterSave de TPlanning (en le faisant depuis l'interface principale plutôt que la classe, c'est de la triche mais ça passe)
* ajout d'un numéro d'ordre dans chaque événement de planning
* ajout de la fonction de tri des événements du planning
* tri des éléments du planning avant affichage de la liste
* ajout du numéro d'ordre en saisie dans les fiches des événements

## Exemple d'interprétation du planning pour affichage sur une page web (JavaScript)

* ajout d'un tri des données par leur numéro d'ordre avant de transmettre la liste reçue du serveur à la fonction de callback lors du téléchargement du planning

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
