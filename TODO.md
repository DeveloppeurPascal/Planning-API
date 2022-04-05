# TODO list

* implémenter une récupération du planning Twitch (de préférence en automatique depuis le serveur, mais possible en interactif avec choix des sessions à reprendre)
* ajouter WARNING sur utilisation des codes sources sans modification des clés publiques et privées
* ajouter un module de suppression des données ou filtrer l'envoi des informations en ne conservant que les événements futurs (filtrage côté serveur qui impliquerait que le format JSON soit connu, pas une bonne idée, de préférence à faire sur le module d'affichage en JS qui sait ce qu'on traite)

* fournir un accès ICS à la liste des evénements (pour import automatique dans les calendriers de type Gmail, ou Apple)

## src-prog-maj : programme de mise à jour des données (en Delphi)

* ajouter le traitement de l'API de suppression lorsqu'elle sera mise en place
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

## src-serveur : programmes de mise à jour et de gestion de l'API (en PHP)

* ajouter le traitement de l'API de suppression lorsqu'elle sera mise en place
* sur l'API de récupération de la liste, modifier le filtre afin de proposer un CONTAINS ou EQUAL
* sur l'API de récupération de la liste, modifier le filtre afin de pouvoir indiquer plusieurs mots-clés dedans (séparés par des virgules)

* ajouter doc sur la configuration du code source pour une version de production personnalisée

* sur la récupération de la liste des données (events.php) gérer un cache pour les accès depuis JavaScript et le désactiver depuis le programme de mise à jour

## src-visu : scripts JS d'interrogation des données de l'API
