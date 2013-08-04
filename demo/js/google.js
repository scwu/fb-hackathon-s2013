// Enter a client ID for a web application from the Google Developer Console.
// The provided clientId will only work if the sample is run directly from
// https://google-api-javascript-client.googlecode.com/hg/samples/authSample.html
// In your Developer Console project, add a JavaScript origin that corresponds to the domain
// where you will be running the script.
var clientId = '201630759555.apps.googleusercontent.com';

// Enter the API key from the Google Develoepr Console - to handle any unauthenticated
// requests in the code.
// The provided key works for this sample only when run from
// https://google-api-javascript-client.googlecode.com/hg/samples/authSample.html
// To use in your own application, replace this API key with your own.
var apiKey = 'AIzaSyAF5O-QreoLDTOYa4eEuBg3JbxbSfTavvY';

// To enter one or more authentication scopes, refer to the documentation for the API.
var scopes = 'https://www.googleapis.com/auth/calendar';

// Use a button to handle authentication the first time.
function handleClientLoad() {
  gapi.client.setApiKey(apiKey);
  window.setTimeout(checkAuth,1);
}

function checkAuth() {
  gapi.auth.authorize({client_id: clientId, scope: scopes, immediate: true}, handleAuthResult);
}


function handleAuthResult(authResult) {
  var authorizeButton = document.getElementById('authorize-button');
  if (authResult && !authResult.error) {
    authorizeButton.style.visibility = 'hidden';
    makeApiCall();
  } else {
    authorizeButton.style.visibility = '';
    authorizeButton.onclick = handleAuthClick;
  }
}

function handleAuthClick(event) {
  gapi.auth.authorize({client_id: clientId, scope: scopes, immediate: false}, handleAuthResult);
  return false;
}

// Load the API and make an API call.  Display the results on the screen.
function makeApiCall() {
  gapi.client.load('calendar', 'v3', function() {
    var request = gapi.client.calendar.events.list({
      'calendarId': 'primary',
      'timeMin': (new Date()).toISOString(),
      'singleEvents': true,
      'timeZone': 'UTC'
    });
    request.execute(function(resp) {

      for (var i = 0; i < resp.items.length; i++) {
        if (resp.items[i].summary) {
          var evt = resp.items[i];

          var eventDiv = document.createElement('div');

          var summary = document.createElement('h2');
          summary.appendChild(document.createTextNode(evt.summary));

          var location = document.createElement('h3');
          location.appendChild(document.createTextNode(evt.location));

          eventDiv.appendChild(summary);
          eventDiv.appendChild(location);

          if (evt.location) {
            addAddress(evt.location);
          }

          $('#calendar').fullCalendar('renderEvent', googleToEvent(evt), true);

          document.getElementById('content').appendChild(eventDiv);
        }
      }

      // $('#calendar').fullCalendar('rerenderEvents');
    });
  });
}

function googleToEvent(gevent) {
  var evt = {};

  if (gevent.start.dateTime) {
    evt.start = (new Date(gevent.start.dateTime)).toISOString();
    evt.allDay = false;
  } else if (gevent.start.date) {
    evt.start = (new Date(gevent.start.date)).toISOString();
    evt.allDay = true;
  }

  if (gevent.endTimeUnspecified) {
    evt.allDay = false;
  } else if (gevent.end.dateTime) {
    evt.end = (new Date(gevent.end.dateTime)).toISOString();
    evt.allDay = false;
  } else if (gevent.end.date) {
    evt.end = (new Date(gevent.end.date)).toISOString();
    evt.allDay = true;
  }

  evt.title = gevent.summary;

  return evt;
}
