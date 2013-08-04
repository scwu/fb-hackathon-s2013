$(document).ready(function() {

    // page is now ready, initialize the calendar...

    $('#calendar').fullCalendar({
        // put your options and callbacks here
        editable: true,
        defaultView: 'agendaWeek',
        ignoreTimezone: false,
        selectable: true
    });

});