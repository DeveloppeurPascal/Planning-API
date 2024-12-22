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

## Présentations et conférences

### Twitch

Suivez mes streams de développement de logiciels, jeux vidéo, applications mobiles et sites web sur [ma chaîne Twitch](https://www.twitch.tv/patrickpremartin) ou en rediffusion sur [Serial Streameur](https://serialstreameur.fr/planning-api.html) la plupart du temps en français.

## Utiliser ce logiciel

[Consultez le site du logiciel](https://planningapi.olfsoftware.fr) pour en savoir plus sur son fonctionnement, accéder à des vidéos et articles, connaître les différentes versions disponibles et leurs fonctionnalités, contacter le support utilisateurs...

## Installation des codes sources

Pour télécharger ce dépôt de code il est recommandé de passer par "git" mais vous pouvez aussi télécharger un ZIP directement depuis [son dépôt GitHub](https://github.com/DeveloppeurPascal/Planning-API).

Ce projet utilise des dépendances sous forme de sous modules. Ils seront absents du fichier ZIP. Vous devrez les télécharger à la main.

* [DeveloppeurPascal/librairies](https://github.com/DeveloppeurPascal/librairies) doit être installé dans le sous dossier ./lib-externes/librairies

## Compatibilité

En tant que [MVP Embarcadero](https://www.embarcadero.com/resources/partners/mvp-directory) je bénéficie dès qu'elles sortent des dernières versions de [Delphi](https://www.embarcadero.com/products/delphi) et [C++ Builder](https://www.embarcadero.com/products/cbuilder) dans [RAD Studio](https://www.embarcadero.com/products/rad-studio). C'est donc dans ces versions que je travaille.

Normalement mes librairies et composants doivent aussi fonctionner au moins sur la version en cours de [Delphi Community Edition](https://www.embarcadero.com/products/delphi/starter).

Aucune garantie de compatibilité avec des versions antérieures n'est fournie même si je m'efforce de faire du code propre et ne pas trop utiliser les nouvelles façons d'écrire dedans (type inference, inline var et multilines strings).

Si vous détectez des anomalies sur des versions antérieures n'hésitez pas à [les rapporter](https://github.com/DeveloppeurPascal/Planning-API/issues) pour que je teste et tente de corriger ou fournir un contournement.

## Licence d'utilisation de ce dépôt de code et de son contenu

Ces codes sources sont distribués sous licence [AGPL 3.0 ou ultérieure](https://choosealicense.com/licenses/agpl-3.0/).

Vous êtes globalement libre d'utiliser le contenu de ce dépôt de code n'importe où à condition :
* d'en faire mention dans vos projets
* de diffuser les modifications apportées aux fichiers fournis dans ce projet sous licence AGPL (en y laissant les mentions de copyright d'origine (auteur, lien vers ce dépôt, licence) obligatoirement complétées par les vôtres)
* de diffuser les codes sources de vos créations sous licence AGPL

Si cette licence ne convient pas à vos besoins vous pouvez acheter un droit d'utilisation de ce projet sous la licence [Apache License 2.0](https://choosealicense.com/licenses/apache-2.0/) ou une licence commerciale dédiée ([contactez l'auteur](https://developpeur-pascal.fr/nous-contacter.php) pour discuter de vos besoins).

Ces codes sources sont fournis en l'état sans garantie d'aucune sorte.

Certains éléments inclus dans ce dépôt peuvent dépendre de droits d'utilisation de tiers (images, sons, ...). Ils ne sont pas réutilisables dans vos projets sauf mention contraire.

## Comment demander une nouvelle fonctionnalité, signaler un bogue ou une faille de sécurité ?

Si vous voulez une réponse du propriétaire de ce dépôt la meilleure façon de procéder pour demander une nouvelle fonctionnalité ou signaler une anomalie est d'aller sur [le dépôt de code sur GitHub](https://github.com/DeveloppeurPascal/Planning-API) et [d'ouvrir un ticket](https://github.com/DeveloppeurPascal/Planning-API/issues).

Si vous avez trouvé une faille de sécurité n'en parlez pas en public avant qu'un correctif n'ait été déployé ou soit disponible. [Contactez l'auteur du dépôt en privé](https://developpeur-pascal.fr/nous-contacter.php) pour expliquer votre trouvaille.

Vous pouvez aussi cloner ce dépôt de code et participer à ses évolutions en soumettant vos modifications si vous le désirez. Lisez les explications dans le fichier [CONTRIBUTING.md](CONTRIBUTING.md).

## Supportez ce projet et son auteur

Si vous trouvez ce dépôt de code utile et voulez le montrer, merci de faire une donation [à son auteur](https://github.com/DeveloppeurPascal). Ca aidera à maintenir le projet (codes sources et binaires).

Vous pouvez utiliser l'un de ces services :

* [GitHub Sponsors](https://github.com/sponsors/DeveloppeurPascal)
* [Liberapay](https://liberapay.com/PatrickPremartin)
* [Patreon](https://www.patreon.com/patrickpremartin)
* [Paypal](https://www.paypal.com/paypalme/patrickpremartin)

ou si vous parlez français vous pouvez [vous abonner à Zone Abo](https://zone-abo.fr/nos-abonnements.php) sur une base mensuelle ou annuelle et avoir en plus accès à de nombreuses ressources en ligne (vidéos et articles).
