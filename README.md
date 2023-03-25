# Planning-API

Server and client programs for managing a simple schedule with a consultation API.

This project has been developed live on Twitch. Replays and additional information are available on :

* [Serial Streamer](https://serialstreameur.fr/planning-api.html) if you want to see the full replays
* [Pascal Developer](https://developpeur-pascal.fr/planning-api.html) for the Delphi part (update program, use of the API)
* [Web developer tips](https://trucs-de-developpeur-web.fr/planning-api.html) for the web client (JavaScript) and server (PHP) parts

This code repository contains a project developed in Object Pascal language under Delphi. You don't know what Delphi is and where to download it ? You'll learn more [on this web site](https://delphi-resources.developpeur-pascal.fr/).

## src-prog-maj : data update program (in Delphi)

The data update interface is developed as a FireMonkey application in Delphi. It can run on Windows, Mac and Linux (but also on Android&iOS tablets if needed).

You can use [the free Community Edition of Delphi](https://www.embarcadero.com/products/delphi/starter) to compile this program for your personal use, [the Academic version of RAD Studio](https://www.embarcadero.com/development-tools-for-education) if you are in education or [one of the editions dedicated to professional users](https://www.embarcadero.com/products/delphi).

## src-serveur : programs for updating and managing the API (in PHP)

The server manages the CRUD on the planning data and stores them without database (directly in JSON).

A program allows the interrogation of the data for their display on a web site or elsewhere in the form of REST API in JSON.

This folder also contains the script getPlanningAPI.js which allows to retrieve the content of a schedule.

## src-visu : JS scripts for querying API data

Example of HTML pages using the script to consult the data of a planning hosted on a server.

Examples used for blogs like https://developpeur-pascal.fr and https://trucs-de-developpeur-web.fr

## Processed data

The data managed by these programs are planning information in the time zone of the site (no control, no timezone conversion).

Data stored in JSON :

```JSON
[
	{
		uid : ID of the event in the list (unique value)
		label : label of the event
		type : type of event (conference, training, Twitch, webinar)
		startdate : date
		starttime : start time
		stoptime : end time
		language : language
		url : Internet address of the event
		url_thumb : Internet address of a picture for the event
		order : order number of the event in the list (used for sorting)
		comment : a comment for this event
	}
]
```

All the fields are in string form, without validity check.

## API entry points

Updates can only be made from a program identified in the server with a public key and private keys for each API call.

All texts must be encoded in UTF-8. This is the encoding used by the output server.

**You can use the programs provided on this repository for testing, but if you go to production CHANGE THE TOKEN on the Delphi and PHP side! (and don't publish them anywhere, of course)**

### API keys for modifications

* auth_token => public key passed on each modification call
* add_token => private signing key (known in hard on server and client side)
* change_token => private signing key (known in hard on server and client side)

### List of events in the schedule

GET url/events.php

Input parameters:
* type: optional, string, type of event we want the list of
	
Output: 
* if http status code = 200, then JSON array as string with schedule events as objects
* otherwise, error text

### Send changed events

POST url/changedevents.php

Input parameters:
* auth : string, authorization key (public)
* events : string, JSON array of objects of modified elements
* v: string, signature of the call (including a private key)
	
Output: 
* if http status code = 200, then JSON array as string with IDs of events whose modification was taken into account.
* otherwise, error text

### Send a new event

POST url/newevent.php

Input parameters:
* auth : string, authorization key (public)
* event : string, JSON object of the event to add
* v: string, signature of the call (including a private key)
	
Output: 
* if http status code = 200, then string corresponding to the unique key of the new element
* otherwise, error text

### Deleting an event

POST url/rmvevent.php

Input parameters:
* auth : string, authorization key (public)
* id : string, uid of the event to delete
* v : string, signature of the call (including a private key)
	
Output: 
* if http status code = 200, delete done
* if http status code = 404, unknown event on the server
* otherwise, text of the error

## Install

To download this project you better should use "git" command but you also can download a ZIP from [its GitHub repository](https://github.com/DeveloppeurPascal/Planning-API).

**Warning :** if the project has submodules dependencies they wont be in the ZIP file. You'll have to download them manually.

## Dependencies

This project depends on :

* [DeveloppeurPascal/librairies](https://github.com/DeveloppeurPascal/librairies) is expected in folder ./lib-externes/librairies

## How to ask a new feature, report a bug or a security issue ?

If you want an answer from the project owner the best way to ask for a new feature or report a bug is to go to [the GitHub repository](https://github.com/DeveloppeurPascal/Planning-API) and [open a new issue](https://github.com/DeveloppeurPascal/Planning-API/issues).

If you found a security issue please don't report it publicly before a patch is available. Explain the case by [sending a private message to the author](https://developpeur-pascal.fr/nous-contacter.php).

You also can fork the repository and contribute by submitting pull requests if you want to help. Please read the [CONTRIBUTING.md](CONTRIBUTING.md) file.

## Dual licensing model

This project is distributed under [AGPL 3.0 or later](https://choosealicense.com/licenses/agpl-3.0/) license.

If you want to use it or a part of it in your projects but don't want to share the sources or don't want to distribute your project under the same license you can buy the right to use it under the [Apache License 2.0](https://choosealicense.com/licenses/apache-2.0/) or a dedicated license ([contact the author](https://developpeur-pascal.fr/nous-contacter.php) to explain your needs).

## Support the project and its author

If you think this project is useful and want to support it, please make a donation to [its author](https://github.com/DeveloppeurPascal). It will help to maintain the code and binaries.

You can use one of those services :

* [GitHub Sponsors](https://github.com/sponsors/DeveloppeurPascal)
* [Liberapay](https://liberapay.com/PatrickPremartin)
* [Patreon](https://www.patreon.com/patrickpremartin)
* [Paypal](https://www.paypal.com/paypalme/patrickpremartin)

or if you speack french you can [subscribe to Zone Abo](https://zone-abo.fr/nos-abonnements.php) on a monthly or yearly basis and get a lot of resources as videos and articles.
