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

## Talks and conferences

### Twitch

Follow my development streams of software, video games, mobile applications and websites on [my Twitch channel](https://www.twitch.tv/patrickpremartin) or as replays on [Serial Streameur](https://serialstreameur.fr/planning-api.html) mostly in French.

## Using this software

[Visit the software website](https://planningapi.olfsoftware.fr) to find out more about how it works, access videos and articles, find out about the different versions available and their features, contact user support...

## Source code installation

To download this code repository, we recommend using "git", but you can also download a ZIP file directly from [its GitHub repository](https://github.com/DeveloppeurPascal/Planning-API).

This project uses dependencies in the form of sub-modules. They will be absent from the ZIP file. You'll have to download them by hand.

* [DeveloppeurPascal/librairies](https://github.com/DeveloppeurPascal/librairies) must be installed in the ./lib-externes/librairies subfolder.

## Compatibility

As an [Embarcadero MVP](https://www.embarcadero.com/resources/partners/mvp-directory), I benefit from the latest versions of [Delphi](https://www.embarcadero.com/products/delphi) and [C++ Builder](https://www.embarcadero.com/products/cbuilder) in [RAD Studio](https://www.embarcadero.com/products/rad-studio) as soon as they are released. I therefore work with these versions.

Normally, my libraries and components should also run on at least the current version of [Delphi Community Edition](https://www.embarcadero.com/products/delphi/starter).

There's no guarantee of compatibility with earlier versions, even though I try to keep my code clean and avoid using too many of the new ways of writing in it (type inference, inline var and multiline strings).

If you detect any anomalies on earlier versions, please don't hesitate to [report them](https://github.com/DeveloppeurPascal/Planning-API/issues) so that I can test and try to correct or provide a workaround.

## License to use this code repository and its contents

This source code is distributed under the [AGPL 3.0 or later license](https://choosealicense.com/licenses/agpl-3.0/).

You are generally free to use the contents of this code repository anywhere, provided that:
* you mention it in your projects
* distribute the modifications made to the files supplied in this project under the AGPL license (leaving the original copyright notices (author, link to this repository, license) which must be supplemented by your own)
* to distribute the source code of your creations under the AGPL license.

If this license doesn't suit your needs, you can purchase the right to use this project under the [Apache License 2.0](https://choosealicense.com/licenses/apache-2.0/) or a dedicated commercial license ([contact the author](https://developpeur-pascal.fr/nous-contacter.php) to explain your needs).

These source codes are provided as is, without warranty of any kind.

Certain elements included in this repository may be subject to third-party usage rights (images, sounds, etc.). They are not reusable in your projects unless otherwise stated.

## How to ask a new feature, report a bug or a security issue ?

If you want an answer from the project owner the best way to ask for a new feature or report a bug is to go to [the GitHub repository](https://github.com/DeveloppeurPascal/Planning-API) and [open a new issue](https://github.com/DeveloppeurPascal/Planning-API/issues).

If you found a security issue please don't report it publicly before a patch is available. Explain the case by [sending a private message to the author](https://developpeur-pascal.fr/nous-contacter.php).

You also can fork the repository and contribute by submitting pull requests if you want to help. Please read the [CONTRIBUTING.md](CONTRIBUTING.md) file.

## Support the project and its author

If you think this project is useful and want to support it, please make a donation to [its author](https://github.com/DeveloppeurPascal). It will help to maintain the code and binaries.

You can use one of those services :

* [GitHub Sponsors](https://github.com/sponsors/DeveloppeurPascal)
* [Liberapay](https://liberapay.com/PatrickPremartin)
* [Patreon](https://www.patreon.com/patrickpremartin)
* [Paypal](https://www.paypal.com/paypalme/patrickpremartin)

or if you speack french you can [subscribe to Zone Abo](https://zone-abo.fr/nos-abonnements.php) on a monthly or yearly basis and get a lot of resources as videos and articles.
