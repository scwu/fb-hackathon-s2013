$(document).ready(function() {

    // page is now ready, initialize the calendar...
    var calendar = $('#calendar'),
    	events = [];
    $('#calendar').fullCalendar({
        // put your options and callbacks here
        editable: true,
        defaultView: 'agendaWeek',
        ignoreTimezone: false,
        selectable: true,
        select: function(startDate, endDate, allDay, jsEvent, view) {
        	var duration = endDate - startDate;
        	duration = duration / 1800000;
        	console.log(duration);
        	var evt = {
        		title: "",
        		allDay: false,
        		start: startDate,
        		end: endDate,
        	};
        	calendar.fullCalendar('renderEvent', evt, true);
        	console.log(evt);
        	events.push(evt);
        	console.log(events);
        }
    });

});