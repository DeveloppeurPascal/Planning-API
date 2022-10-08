# Planning-API

Server and client programs for managing a simple schedule with a consultation API.

This project has been developed live on Twitch. Replays and additional information are available on :

* [Serial Streamer](https://serialstreameur.fr/planning-api.html) if you want to see the full replays
* [Pascal Developer](https://developpeur-pascal.fr/planning-api.html) for the Delphi part (update program, use of the API)
* [Web developer tips](https://trucs-de-developpeur-web.fr/planning-api.html) for the web client (JavaScript) and server (PHP) parts

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
		order : order number of the event in the list (used for sorting)
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
* otherwise, text of the er