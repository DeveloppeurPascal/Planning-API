// serveur_url is the url of the server
// callback is a function with one parameter : the array of planning events
function getPlanningAPI(serveur_url, callback) {
    // https://developer.mozilla.org/fr/docs/Web/API/XMLHttpRequest
    const request = new XMLHttpRequest();
    request.open('GET', serveur_url+'/events.php', true);
    request.onload = afterevent;
    request.responseType = 'json';
    request.send();

    function afterevent() {
        // console.log(request.response);
		let liste = request.response;
		liste.sort(function(a,b) {
			if (! (a.order)) {
				a.order = -1;
			}
			if (! (b.order)) {
				b.order = -1;
			}
			// console.log (a.order);
			return a.order - b.order;
		});
		callback(liste);
    }
}