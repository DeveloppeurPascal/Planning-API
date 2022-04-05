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
		callback(request.response);
    }
}