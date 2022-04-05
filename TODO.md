# TODO list

* tester interface utilisateur et API
* développer le module client d'interrogation du planning
* faire programme d'exemple d'affichage sur une page web
* implémenter le module d'affichage sur les blogs et Zone-Abo
* ajouter WARNING sur utilisation des codes sources sans modification des clés publiques et privées
* implémenter une récupération du planning Twitch (de préférence en automatique depuis le serveur, mais possible en interactif avec choix des sessions à reprendre)
* ajouter un module de suppression des données ou filtrer l'envoi des informations en ne conservant que les événements futurs (filtrage côté serveur qui impliquerait que le format JSON soit connu, pas une bonne idée, de préférence à faire sur le module d'affichage en JS qui sait ce qu'on traite)

## src-prog-maj : programme de mise à jour des données (en Delphi)

* traiter le onAfterSave de TPlanning
* ajouter traitement API suppression
* éventuellement trier la liste des évenements sur l'écran principal (tri par libellé, date, type ou autre ?)
* gérer style sombre
* gérer style clair
* ajouter un écran de paramétrage
* enregistrer les modifications en local tant qu'elles n'ont pas été synchronisées avec le serveur
* lors du chargement du programme, charger la liste depuis le serveur et/ou en local pour les choses modifiées
* ajouter doc sur la configuration du code source pour une version de production personnalisée
* ajouter page d'infos sur Delphi (téléchargement, doc, formation)
* sur la saisie du type, modifier le champ de saisie pour proposer une liste des types existant déjà dans la base de données et pouvoir librement en choisir un ou ajouter un autre

## src-serveur : programmes de mise à jour et de gestion de l'API (en PHP)

* ajouter traitement API suppression
* ajouter doc sur la configuration du code source pour une version de production personnalisée
* ajouter htaccess sur dossier "_PRIVE"
* sur l'API de récupération de la liste, modifier le filtre afin de proposer un CONTAINS ou EQUAL
* sur l'API de récupération de la liste, modifier le filtre afin de pouvoir indiquer plusieurs mots-clés dedans (séparés par des virgules)

## src-visu : scripts JS d'interrogation des données de l'API
