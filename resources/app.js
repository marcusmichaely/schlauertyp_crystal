(function (global) {
	var elements = {};

	var updateMessage = function (response) {
		var path = response.url.match(/https?:\/\/.+?(\/.*)/)[1];
		var title = response.message + ' - Schlauer Typ';
		history.replaceState(history.state, title, path);
		document.title = title;
		elements.message.innerHTML = response.message;
	};

	var updateTweetLink = function (response) {
		var href = elements.tweet.getAttribute('href').match(/(.*)http/)[1];
		href += encodeURIComponent(response.url);
		elements.tweet.setAttribute('href', href);
	};

	var sendRequest = function (path, callback) {
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState !== 4 || this.status !== 200) return;
			callback(JSON.parse(this.responseText));
		};
		xhttp.open('GET', path, true);
		xhttp.setRequestHeader('Accept', 'application/json');
		xhttp.send();
	};

	var handleRefresh = function (event) {
		event.preventDefault();
		var path = elements.refreshLink.getAttribute('href');
		sendRequest(path, function (response) {
			updateMessage(response);
			updateTweetLink(response);
		});

	};

	var initEvents = function () {
		elements.refreshLink.onclick = handleRefresh;
	};

	var findElements = function () {
		elements.refreshLink = document.getElementById('reload');
		elements.tweet = document.getElementById('tweet');
		elements.message = document.getElementById('message');
	};

	var bootstrap = function () {
		findElements();
		initEvents();
	};

	document.addEventListener('DOMContentLoaded', bootstrap);
})(window);
