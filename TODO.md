# TODO list

* implémenter une récupération du planning Twitch (de préférence en automatique depuis le serveur, mais possible en interactif avec choix des sessions à reprendre)

* ajouter WARNING sur utilisation des codes sources sans modification des clés publiques et privées

* ajouter un module de suppression des données ou filtrer l'envoi des informations en ne conservant que les événements futurs (filtrage côté serveur qui impliquerait que le format JSON soit connu, pas une bonne idée, de préférence à faire sur le module d'affichage en JS qui sait ce qu'on traite)

* fournir un accès ICS à la liste des evénements (pour import automatique dans les calendriers de type Gmail, ou Apple) avec filtrage sur le type (ce qui implique que la date et l'heure soient dans un format connu et que le fuseau horaire puisse être indiqué quelque part)

* faire une extension sous forme de panel pour la bio Twitch afin d'afficher les points intéressants du planning dessus

* activer un cache sur le programme events.php qui retourne la liste des événements disponibles
=> modifier le serveur pour pouvoir appeler le programme avec et sans cache
=> modifier le client Delphi pour utiliser la version sans cache du programme
=> modifier le cache lors de chaque opération de mise à jour

* pouvoir trier les événements dans le planning actuel
=> ajouter un numéro d'ordre au niveau des événements
=> prendre en charge le numéro d'ordre lors de l'envoi des informations depuis le serveur (cache ou en direct)
=> pouvoir trier les éléments dans la liste sur le programme de saisie
=> dans les scripts d'interrogation, traiter les infos dans l'ordre


## src-prog-maj : programme de mise à jour des données (en Delphi)

* sur la saisie du type, modifier le champ de saisie pour proposer une liste des types existant déjà dans la base de données et pouvoir librement en choisir un ou ajouter un autre
* traiter le onAfterSave de TPlanning
* éventuellement trier la liste des évenements sur l'écran principal (tri par libellé, date, type ou autre ?)
* gérer style sombre
* gérer style clair
* ajouter un écran de paramétrage
* enregistrer les modifications en local tant qu'elles n'ont pas été synchronisées avec le serveur
* lors du chargement du programme, charger la liste depuis le serveur et/ou en local pour les choses modifiées

* ajouter doc sur la configuration du code source pour une version de production personnalisée
* ajouter page d'infos sur Delphi (téléchargement, doc, formation)

* ajouter une fonction d'export (pour backup)
* ajouter une fonction d'import (pour récupération depuis un backup)

* donner la possibilité de gérer plusieurs serveurs différents si on veut utiliser le même programme plutôt que tout avoir en dur dans l'exe directement

* lorsque des modifications ont été faites sur des événements du planning, le signaler dans la liste tant qu'elles ne sont pas remontées au serveur

* ne pas autoriser la fermeture du programme si des modifications sont en attente d'envoi au serveur sans confirmation de l'utlisateur

* modifier le bouton "save" en "synchro"

* signaler sur le bouton "save/synchro" qu'une synchronisation est nécessaire (des modifications sont en attente)

* ajouter un écran de paramétrage permettant de saisir un serveur et ses clés de token pour pouvoir distribuer le logiciel en version compilée (par exemple sur CodeCanyon)

* ajouter un écran "à propos" sur la version compilée/commercialisée du projet

* ajouter un export des fichiers sources PHP/JS préconfigurés sur la version compilée du projet (avec génération intégrée des token) sous forme d'assistant d'installation/paramétrage

* permettre de trier les informations dans la liste

* savoir qu'on a fait des modifications sur le formulaire actuellement affiché et traiter son enregistrement en cas de changement de rubrique ou fermeture du programme

* inciter à synchroniser les données en cas de fermeture si des mises à jour sont en attente

* publier une version avec options du programme avec saisie clés API sans les avoir en dur dans les codes sources (pour ceux qui n'auraient pas les sources ou Delphi pour compiler)

* mettre la version compilée du programme en vente sur itch.io

* mettre la version compilée du programme en vente sur Gumroad

* mettre en place le site https://planningapi.olfsoftware.fr

* ajouter un bouton "recharger" pour réinitialiser la liste avec ce qui se trouve actuellement sur le serveur

* bogue : lorsqu'on referme le panel d'un item il reste sélectionné, ce qui empêche de le réafficher s'il n'y a pas d'autre item dans la liste pour se déplacer, il vaudrait mieux le désélectionner à la fermeture.

## src-serveur : programmes de mise à jour et de gestion de l'API (en PHP)

* sur l'API de récupération de la liste, modifier le filtre afin de proposer un CONTAINS ou EQUAL
* sur l'API de récupération de la liste, modifier le filtre afin de pouvoir indiquer plusieurs mots-clés dedans (séparés par des virgules)

* ajouter doc sur la configuration du code source pour une version de production personnalisée

* sur la récupération de la liste des données (events.php) gérer un cache pour les accès depuis JavaScript et le désactiver depuis le programme de mise à jour

## src-visu : scripts JS d'interrogation des données de l'API
