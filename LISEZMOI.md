# Planning-API

Programmes serveur et client de gestion d'un planning simple avec API de consultation.

Ce projet a fait l'objet d'un développement en live sur Twitch. Les rediffusions et des informations complémentaires sont disponibles sur :

* [Serial Streameur](https://serialstreameur.fr/planning-api.html) si vous voulez voir les replays complets
* [Développeur Pascal](https://developpeur-pascal.fr/planning-api.html) pour la partie Delphi (programme de mise à jour, utilisation de l'API)
* [Trucs de développeur web](https://trucs-de-developpeur-web.fr/planning-api.html) pour les parties client web (JavaScript) et serveur (PHP)

Ce dépôt de code contient un projet développé en langage Pascal Objet sous Delphi. Vous ne savez pas ce qu'est Dephi ni où le télécharger ? Vous en saurez plus [sur ce site web](https://delphi-resources.developpeur-pascal.fr/).

## src-prog-maj : programme de mise à jour des données (en Delphi)

L'interface de mise à jour des données est développée sous forme d'application FireMonkey en Delphi. Elle peut tourner sur Windows, Mac et Linux (mais aussi sur tablettes Android&iOS si nécessaire).

Vous pouvez utiliser [la version Community Edition gratuite de Delphi](https://www.embarcadero.com/products/delphi/starter) pour compiler ce programme pour votre usage personnel, [la version Academic de RAD Studio](https://www.embarcadero.com/development-tools-for-education) si vous êtes dans l'enseignement ou l'[une des éditions dédiées aux utilisateurs professionnels](https://www.embarcadero.com/products/delphi).

## src-serveur : programmes de mise à jour et de gestion de l'API (en PHP)

Le serveur gère le CRUD sur les données du planning et les stocke sans base de données (directement en JSON).

Un programme permet l'interrogation des données pour leur affichage sur un site oueb ou ailleurs sous forme d'API REST en JSON.

Ce dossier contient également le script getPlanningAPI.js qui permet de rapatrier le contenu d'un planning.

## src-visu : scripts JS d'interrogation des données de l'API

Exemple de pages HTML utilisant le script de consultation des données d'un planning hébergé sur un serveur.

Exemples utilisés pour les blogs comme https://developpeur-pascal.fr et https://trucs-de-developpeur-web.fr

## Données traitées

Les données gérées par ces programmes sont des informations de planning dans le fuseau horaire du site (et non celui de l'internaute les consultant).

Données stockées en JSON :

```JSON
[
	{
		uid : ID de l'événement dans la liste (valeur unique)
		label : libellé de l'évenement
		type : type d'événement (conférence, formation, Twitch, webinaire)
		startdate : date
		starttime : heure de début
		stoptime : heure de fin
		language : langue
		url : adresse Internet de l'événement
		url_thumb : adresse Internet d'une image pour cet événement
		order : numéro d'ordre de l'événement dans la liste (utilisé pour les tris)
		comment : commentaire associé à l'événement
	}
]
```

Tous les champs sont sous forme de chaîne de caractères, sans contrôle de validité.

## Points d'entrée de l'API

Les mises à jour ne peuvent se faire que depuis un programme identifié dans le serveur avec une clé publique et des clés privées pour chaque appel d'API.

Tous les textes doivent être encodés en UTF-8. C'est l'encodage utilisé par le serveur en sortie.

**Vous pouvez utiliser les programmes fournis sur ce dépôt en test, mais si vous passez en production CHANGEZ LES TOKEN côté Delphi et PHP ! (et ne les publiez nulle part, bien entendu)**

### Clés d'API pour les modifications

* auth_token => clé publique passée lors de chaque appel de modification
* add_token => clé de signature privée (connue en dur côté serveur et côté client)
* change_token => clé de signature privée (connue en dur côté serveur et côté client)

### Liste des événements du planning

GET url/events.php

Paramètres en entrée :
* type : facultatif, string, type d'événement dont on veut la liste
	
Sortie : 
* si http status code = 200, alors tableau JSON sous forme de chaîne de caractères avec les événements du planning sous forme d'objets
* sinon, texte de l'erreur

### Envoi d'événements modifiés

POST url/changedevents.php

Paramètres en entrée :
* auth : string, clé d'autorisation (publique)
* events : string, tableau JSON d'objets des éléments modifiés
* v : string, signature de l'appel (incluant une clé privée)
	
Sortie : 
* si http status code = 200, alors tableau JSON sous forme de chaîne de caractères avec les ID des événements dont la modification a été prise en compte
* sinon, texte de l'erreur

### Envoi d'un nouvel événement

POST url/newevent.php

Paramètres en entrée :
* auth : string, clé d'autorisation (publique)
* event : string, objet JSON de l'événement à ajouter
* v : string, signature de l'appel (incluant une clé privée)
	
Sortie : 
* si http status code = 200, alors chaîne de caractères correspondant à la clé unique du nouvel élément
* sinon, texte de l'erreur

### Suppression d'un événement

POST url/rmvevent.php

Paramètres en entrée :
* auth : string, clé d'autorisation (publique)
* id : string, uid de l'événement à supprimer
* v : string, signature de l'appel (incluant une clé privée)
	
Sortie : 
* si http status code = 200, suppression effectuée
* si http status code = 404, événment inconnu sur le serveur
* sinon, texte de l'erreur

## Installation

Pour télécharger ce projet il est recommandé de passer par "git" mais vous pouvez aussi télécharger un ZIP directement depuis [son dépôt GitHub](https://github.com/DeveloppeurPascal/Planning-API).

**Attention :** si le projet utilise des dépendances sous forme de sous modules ils seront absents du fichier ZIP. Vous devrez les télécharger à la main.

## Dépendances

Ce dépôt de code dépend des dépôts suivants :

* [DeveloppeurPascal/librairies](https://github.com/DeveloppeurPascal/librairies) doit se trouver dans le dossier ./lib-externes/librairies

## Comment demander une nouvelle fonctionnalité, signaler un bogue ou une faille de sécurité ?

Si vous voulez une réponse du propriétaire de ce dépôt la meilleure façon de procéder pour demander une nouvelle fonctionnalité ou signaler une anomalie est d'aller sur [le dépôt de code sur GitHub](https://github.com/DeveloppeurPascal/Planning-API) et [d'ouvrir un ticket](https://github.com/DeveloppeurPascal/Planning-API/issues).

Si vous avez trouvé une faille de sécurité n'en parlez pas en public avant qu'un correctif n'ait été déployé ou soit disponible. [Contactez l'auteur du dépôt en privé](https://developpeur-pascal.fr/nous-contacter.php) pour expliquer votre trouvaille.

Vous pouvez aussi cloner ce dépôt de code et participer à ses évolutions en soumettant vos modifications si vous le désirez. Lisez les explications dans le fichier [CONTRIBUTING.md](CONTRIBUTING.md).

## Modèle de licence double

Ce projet est distribué sous licence [AGPL 3.0 ou ultérieure] (https://choosealicense.com/licenses/agpl-3.0/).

Si vous voulez l'utiliser en totalité ou en partie dans vos projets mais ne voulez pas en partager les sources ou ne voulez pas distribuer votre projet sous la même licence, vous pouvez acheter le droit de l'utiliser sous la licence [Apache License 2.0](https://choosealicense.com/licenses/apache-2.0/) ou une licence dédiée ([contactez l'auteur](https://developpeur-pascal.fr/nous-contacter.php) pour discuter de vos besoins).

## Supportez ce projet et son auteur

Si vous trouvez ce dépôt de code utile et voulez le montrer, merci de faire une donation [à son auteur](https://github.com/DeveloppeurPascal). Ca aidera à maintenir le projet (codes sources et binaires).

Vous pouvez utiliser l'un de ces services :

* [GitHub Sponsors](https://github.com/sponsors/DeveloppeurPascal)
* [Liberapay](https://liberapay.com/PatrickPremartin)
* [Patreon](https://www.patreon.com/patrickpremartin)
* [Paypal](https://www.paypal.com/paypalme/patrickpremartin)

ou si vous parlez français vous pouvez [vous abonner à Zone Abo](https://zone-abo.fr/nos-abonnements.php) sur une base mensuelle ou annuelle et avoir en plus accès à de nombreuses ressources en ligne (vidéos et articles).
