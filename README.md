# Planning-API

Programmes serveur et client de gestion d'un planning simple avec API de consultation.

Ce projet a fait l'objet d'un développement en live sur Twitch. Les rediffusions et des informations complémentaires sont disponibles sur :

* [Serial Streameur](https://serialstreameur.fr/planning-api.html) si vous voulez voir les replays complets
* [Développeur Pascal](https://developpeur-pascal.fr/planning-api.html) pour la partie Delphi (programme de mise à jour, utilisation de l'API)
* [Trucs de développeur web](https://trucs-de-developpeur-web.fr/planning-api.html) pour les parties client web (JavaScript) et serveur (PHP)

## src-prog-maj : programme de mise à jour des données (en Delphi)

L'interface de mise à jour des données est développée sous forme d'application FireMonkey en Delphi. Elle peut tourner sur Windows, Mac et Linux (mais aussi sur tablettes Android&iOS si nécessaire).

## src-serveur : programmes de mise à jour et de gestion de l'API (en PHP)

Le serveur gère le CRUD sur les données du planning et les stocke sans base de données (directement en JSON).

Un programme permet l'interrogation des données pour leur affichage sur un site oueb ou ailleurs sous forme d'API REST en JSON.

Lors de son interrogation, le programme va aussi vérifier régulièrement le planning Twitch pour en incorporer les informations lorsqu'elles sont demandées.

Ce dossier contient également le script getPlanningAPI.js qui permet de rapatrier le contenu d'un planning.

## src-visu : scripts JS d'interrogation des données de l'API

Exemple de pages HTML utilisant le script de consultation des données d'un planning hébergé sur un serveur.

Exemples utilisés pour les blogs comme https://developpeur-pascal.fr et https://trucs-de-developpeur-web.fr

## Données traitées

Les données gérées par ces programmes sont des informations de planning dans le fuseau horaire du site (et non celui de l'internaute les consultant).

Données stockées en JSON :

[
	{
		uid : ID de l'évenement dans la liste (valeur unique)
		label : libellé de l'évenement
		type : type d'événement (conférence, formation, Twitch, webinaire)
		startdate : date
		starttime : heure de début
		stoptime : heure de fin
		language : langue
		url : adresse Internet de l'évenement
		order : numéro d'ordre de l'événement dans la liste (utilisé pour les tris)
	}
]

Tous les champs sont sous forme de chaîne de caractères, sans contrôle de validité.

## Points d'entrée de l'API

Les mises à jour ne peuvent se faire que depuis un programme identifié dans le serveur avec une clé publique et des clés privées pour chaque appel d'API.

Tous les textes doivent être encodés en UTF-8. C'est l'encodage utilisé par le serveur en sortie.

**Vous pouvez utiliser les programmes fournis sur ce dépôt en test, mais si vous passez en production CHANGEZ LES TOKEN côté Delphi et PHP ! (et ne les publiez nulle part, bien entendu)**

### Clés d'API pour les modifications

auth_token => clé publique passée lors de chaque appel de modification
add_token => clé de signature privée (connue en dur côté serveur et côté client)
change_token => clé de signature privée (connue en dur côté serveur et côté client)

### Liste des événements du planning

GET url/events.php

Paramètres en entrée :
	type : facultatif, string, type d'événement dont on veut la liste
	
Sortie : 
	- si http status code = 200, alors tableau JSON sous forme de chaîne de caractères avec les événements du planning sous forme d'objets
	- sinon, texte de l'erreur

### Envoi d'événements modifiés

POST url/changedevents.php

Paramètres en entrée :
	auth : string, clé d'autorisation (publique)
	events : string, tableau JSON d'objets des éléments modifiés
	v : string, signature de l'appel (incluant une clé privée)
	
Sortie : 
	- si http status code = 200, alors tableau JSON sous forme de chaîne de caractères avec les ID des événements dont la modification a été prise en compte
	- sinon, texte de l'erreur

### Envoi d'un nouvel événement

POST url/newevent.php

Paramètres en entrée :
	auth : string, clé d'autorisation (publique)
	event : string, objet JSON de l'événement à ajouter
	v : string, signature de l'appel (incluant une clé privée)
	
Sortie : 
	- si http status code = 200, alors chaîne de caractères correspondant à la clé unique du nouvel élément
	- sinon, texte de l'erreur

### Suppression d'un événement

POST url/rmvevent.php

Paramètres en entrée :
	auth : string, clé d'autorisation (publique)
	id : string, uid de l'événement à supprimer
	v : string, signature de l'appel (incluant une clé privée)
	
Sortie : 
	- si http status code = 200, suppression effectuée
	- si http status code = 404, événment inconnu sur le serveur
	- sinon, texte de l'erreur
