# Affichage du planning

Pour afficher le planning attaché à un serveur vous devez :
* charger le script getPlanningAPI.js depuis le serveur
* appeler la fonction getPlanningAPI() en lui passant l'URL de l'API et le code de traitement du résultat

Si votre serveur d'API est sur http://localhost/WebPlanningAPI, mettez ce code dans votre page :

```HTML
<script src="https://zone-abo.fr/planning/getPlanningAPI.js"></script>
```

puis quelque part en JavaScript vous n'avez plus qu'à interroger le serveur et traiter sa réponse :

```HTML
<script>
	getPlanningAPI('http://localhost/WebPlanningAPI', (tabEvents) => {
		console.log(tabEvents);
	});
</script>
```

Bien entendu console.log() est un exemple, mais à vous de traiter le tableau des objets correspondant aux événements de planning en fonction de votre moteur d'affichage de page ou à la main. S'il vous faut des exemples de code vous en trouverez sur [ce dépôt](https://github.com/DeveloppeurPascal/Tests-AJAX-JavaScript) et bien entendu dans le fichier "exemple.html" ci-joint.