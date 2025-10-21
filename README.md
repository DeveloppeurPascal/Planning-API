# Planning API

[Cette page en français.](LISEZMOI.md)

Server and client programs for managing a simple schedule with a consultation API.

This project has been developed live on Twitch. Links, replays and additional information are available from [its website](https://planningapi.olfsoftware.fr/).

This code repository contains a project developed in Object Pascal language under Delphi. You don't know what Delphi is and where to download it ? You'll learn more [on this web site](https://delphi-resources.developpeur-pascal.fr/).

## Folder "src-prog-maj" : data update program (in Delphi)

The data update interface is developed as a FireMonkey application in Delphi. It can run on Windows, Mac and Linux (but also on Android&iOS tablets if needed).

## Folder "src-serveur" : programs for updating and managing the API (in PHP)

The server manages the CRUD on the planning data and stores them without database (directly in JSON).

A program allows the interrogation of the data for their display on a web site or elsewhere in the form of REST API in JSON.

This folder also contains the script getPlanningAPI.js which allows to retrieve the content of a schedule.

## Folder "src-visu" : JS scripts for querying API data

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

## Using this software

Visit [the Planning API website](https://planningapi.olfsoftware.fr) to download the compiled version, learn more about how it works, access videos and articles, find out about the different versions available and their features, contact user support...

## Talks and conferences

### Twitch

Follow my development streams of software, video games, mobile applications and websites on [my Twitch channel](https://www.twitch.tv/patrickpremartin) or as replays on [Serial Streameur](https://serialstreameur.fr) mostly in French.

## Source code installation

To download this code repository, we recommend using "git", but you can also download a ZIP file directly from [its GitHub repository](https://github.com/DeveloppeurPascal/Planning-API).

This project uses dependencies in the form of sub-modules. They will be absent from the ZIP file. You'll have to download them by hand.

* [DeveloppeurPascal/librairies](https://github.com/DeveloppeurPascal/librairies) must be installed in the ./lib-externes/librairies subfolder.

## Documentation and support

I use comments in [XMLDOC](https://docwiki.embarcadero.com/RADStudio/en/XML_Documentation_Comments) format in Delphi to document my projects. They are recognized by Help Insight, which offers real-time input help in the code editor.

I regularly use the [DocInsight](https://devjetsoftware.com/products/documentation-insight/) tool to enter them and check their formatting.

Documentation is exported in HTML by [DocInsight](https://devjetsoftware.com/products/documentation-insight/) or [PasDoc](https://pasdoc.github.io) to the /docs folder of the repository. You can also [access it online](https://developpeurpascal.github.io/Planning-API) through the hosting offered by GitHub Pages.

Further information (tutorials, articles, videos, FAQ, talks and links) can be found on [the project website](https://planningapi.olfsoftware.fr), [the Delphi project devlog](https://developpeur-pascal.fr/planning-api.html) or [the web project devlog](https://trucs-de-developpeur-web.fr/planning-api.html).

If you need explanations or help in understanding or using parts of this project in yours, please [contact me](https://developpeur-pascal.fr/nous-contacter.php). I can either direct you to an online resource, or offer you assistance in the form of a paid or free service, depending on the case. You can also contact me at a conference or during an online presentation.

## Compatibility

As an [Embarcadero MVP](https://www.embarcadero.com/resources/partners/mvp-directory), I benefit from the latest versions of [Delphi](https://www.embarcadero.com/products/delphi) and [C++ Builder](https://www.embarcadero.com/products/cbuilder) in [RAD Studio](https://www.embarcadero.com/products/rad-studio) as soon as they are released. I therefore work with these versions.

Normally, my libraries and components should also run on at least the current version of [Delphi Community Edition](https://www.embarcadero.com/products/delphi/starter).

There's no guarantee of compatibility with earlier versions, even though I try to keep my code clean and avoid using too many of the new ways of writing in it (type inference, inline var and multiline strings).

If you detect any anomalies on earlier versions, please don't hesitate to [report them](https://github.com/DeveloppeurPascal/Planning-API/issues) so that I can test and try to correct or provide a workaround.

## License to use this code repository and its contents

This source code is distributed under the [AGPL 3.0 or later](https://choosealicense.com/licenses/agpl-3.0/) license.

You are free to use the contents of this code repository anywhere provided :
* you mention it in your projects
* distribute the modifications made to the files provided in this AGPL-licensed project (leaving the original copyright notices (author, link to this repository, license) must be supplemented by your own)
* to distribute the source code of your creations under the AGPL license.

If this license doesn't suit your needs (especially for a commercial project) I also offer [classic licenses for developers and companies](https://planningapi.olfsoftware.fr).

Some elements included in this repository may depend on third-party usage rights (images, sounds, etc.). They are not reusable in your projects unless otherwise stated.

The source codes of this code repository as well as any compiled version are provided “as is” without warranty of any kind.

## How to ask a new feature, report a bug or a security issue ?

If you want an answer from the project owner the best way to ask for a new feature or report a bug is to go to [the GitHub repository](https://github.com/DeveloppeurPascal/Planning-API) and [open a new issue](https://github.com/DeveloppeurPascal/Planning-API/issues).

If you found a security issue please don't report it publicly before a patch is available. Explain the case by [sending a private message to the author](https://developpeur-pascal.fr/nous-contacter.php).

You also can fork the repository and contribute by submitting pull requests if you want to help. Please read the [CONTRIBUTING.md](CONTRIBUTING.md) file.

## Support the project and its author

If you think this project is useful and want to support it, please make a donation to [its author](https://github.com/DeveloppeurPascal). It will help to maintain this project and all others.

You can use one of those services :

* [GitHub Sponsors](https://github.com/sponsors/DeveloppeurPascal)
* Ko-fi [in French](https://ko-fi.com/patrick_premartin_fr) or [in English](https://ko-fi.com/patrick_premartin_en)
* [Patreon](https://www.patreon.com/patrickpremartin)
* [Liberapay](https://liberapay.com/PatrickPremartin)

You can buy an end user license for [my softwares](https://lic.olfsoftware.fr/products.php?lng=en) and [my video games](https://lic.gamolf.fr/products.php?lng=en) or [a developer license for my libraries](https://lic.developpeur-pascal.fr/products.php?lng=en) if you use them in your projects.

I'm also available as a service provider to help you use this or other projects, such as software development, mobile applications and websites. [Contact me](https://vasur.fr/about) to discuss.
