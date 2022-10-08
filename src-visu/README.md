# Displaying the schedule

To display the schedule attached to a server you must :
* load the getPlanningAPI.js script from the server
* call the getPlanningAPI() function and pass it the URL of the API and the code to process the result

If your API server is on http://localhost/WebPlanningAPI, put this code in your :

```HTML
<script src="https://zone-abo.fr/planning/getPlanningAPI.js"></script>
```

then somewhere in JavaScript you just have to query the server and process its response :

```HTML
<script>
	getPlanningAPI('http://localhost/WebPlanningAPI', (tabEvents) => {
		console.log(tabEvents);
	});
</script>
```

Of course console.log() is an example, but it's up to you to process the array of objects corresponding to the schedule events according to your page display engine or by hand. If you need code examples you will find them on [this repository](https://github.com/DeveloppeurPascal/Tests-AJAX-JavaScript) and of course in the attached "example.html" file.