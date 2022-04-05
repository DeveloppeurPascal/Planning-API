Dans l'entête des pages du site, ajouter cette ligne pour charger le script de téléchargement des données du planning :
<script src="https://zone-abo.fr/planning/getPlanningAPI.js"></script>

L'appel du script se fait sous cette forme :
<script>
	getPlanningAPI('http://localhost/WebPlanningAPI', (tabEvents) => {
		console.log(tabEvents);
	});
</script>
