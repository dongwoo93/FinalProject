<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include/top.jsp"%>
<link href='resources/fullcalendar/fullcalendar.min.css'
	rel='stylesheet' />
<link href='resources/fullcalendar/fullcalendar.print.min.css'
	rel='stylesheet' media='print' />
<script src='resources/fullcalendar/lib/moment.min.js'></script>
<script src='resources/fullcalendar/fullcalendar.min.js'></script>
<script src='resources/fullcalendar/locale/ko.js'></script>
<script src='resources/fullcalendar/gcal.min.js'></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<script>

  $(document).ready(function() {
	  
	  $('#submitButton').on('click', function(e){
		  var content = $('#eventName').val();
		  if(content == "") {
			  alert("내용을 입력해주세요");
			  return;
		  }
          // We don't want this to act as a link so cancel the link action
          e.preventDefault();

          doSubmit();
        });

    function doSubmit(){
    	var startEnd = $("#eventDueDate").val();
    	var startTime = startEnd.split(' - ')[0];
    	var endTime = startEnd.split(' - ')[1];
      $("#createEventModal").modal('hide');
      $("#calendar").fullCalendar('renderEvent',
          {
              title: $('#eventName').val(),
              start: new Date(startTime),
              end: new Date(endTime)

          },
          true);
     }

    $('#calendar').fullCalendar({
    	customButtons: {
    	    myCustomButton: {
    	      text: '일정 추가',
    	      click: function() {
    	    	  $('#createEventModal').modal('show');
    	      }
    	    }
    	  },
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
      },
      footer: {
    	  left: 'myCustomButton'
      },
      slotDuration: '00:10:00',
      slotLabelFormat: 'a h:mm',
      themeSystem: 'bootstrap4',
      nowIndicator: true,
      now: new Date(),
      defaultDate: new Date(),
      navLinks: true, // can click day/week names to navigate views
      selectable: true,
      selectHelper: true,
      select: function(start, end) {
        var title = prompt('Event Title:');
        var eventData;
        if (title) {
          eventData = {
            title: title,
            start: start,
            end: end
          };
          $('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
        }
        $('#calendar').fullCalendar('unselect');
      },
      editable: true,
      eventLimit: true, // allow "more" link when too many events
      eventClick: function(event) {
    	   
    	      return false;
    	    
    	  },
      eventDrop: function(event, delta, revertFunc) {

    	    alert(event.title + " was dropped on " + event.start.format() + " ~ " + event.end.format());

    	    if (!confirm("일정을 변경 하시겠습니까?")) {
    	      revertFunc();
    	    }

    	  },
      eventResize: function(event, delta, revertFunc) {

    	    alert(event.title + " end is now " + event.end.format());

    	    if (!confirm("일정을 변경 하시겠습니까?")) {
    	      revertFunc();
    	    }

    	  },
      googleCalendarApiKey: 'AIzaSyBLzmfo25SUyDaDRjI7wrhI1cyIhs6sYAc',
      eventSources : [
    	  {
    		  events: [
                  {
                      title: 'All Day Event',
                      start: '2018-03-01'
                    },
                    {
                      title: 'Long Event',
                      start: '2018-03-07',
                      end: '2018-03-10',
                      description: 'This is a cool event'
                    },
                    {
                      id: 999,
                      title: 'Repeating Event',
                      start: '2018-03-09T16:00:00',
                      description: 'This is a cool event'
                    },
                    {
                      id: 999,
                      title: 'Repeating Event',
                      start: '2018-03-16T16:00:00'
                    },
                    {
                      title: 'Conference',
                      start: '2018-03-11',
                      end: '2018-03-13'
                    },
                    {
                      title: 'Meeting',
                      start: '2018-03-12T10:30:00',
                      end: '2018-03-12T12:30:00'
                    },
                    {
                      title: 'Lunch',
                      start: '2018-03-12T12:00:00'
                    },
                    {
                      title: 'Meeting',
                      start: '2018-03-12T14:30:00'
                    },
                    {
                      title: 'Happy Hour',
                      start: '2018-03-12T17:30:00'
                    },
                    {
                      title: 'Dinner',
                      start: '2018-03-12T20:00:00'
                    },
                    {
                      title: 'Birthday Party',
                      start: '2018-03-13T07:00:00'
                    },
                    {
                      title: 'Click for Google',
                      url: 'http://google.com/',
                      start: '2018-03-28'
                    },
                    
                    ]
          	},
          	{
            	googleCalendarId: 'ko.south_korea#holiday@group.v.calendar.google.com',
            	color: 'red',
            editable: false
            }
          	
      ]
      
    });

  });

</script>
<style>
#calendar {
	max-width: 900px;
	margin: 0 auto;
	margin-top: 50px;
	font-size: 15px;
	font-family: "Lucida Grande", Helvetica, Arial, Verdana, sans-serif;
}

.fc-event, .fc-event:hover {
	color: #fff !important;
	text-decoration: none;
}
</style>
</head>
<body>

	<div id='calendar'></div>
	<!-- Modal -->
	<div id="createEventModal" class="modal fade">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h3 style="font-weight: bold;">일정 추가</h3>
				</div>

				<div id="modalBody" class="modal-body">
					<label for="eventName">일정</label>
					<div class="form-group">
						<input class="form-control" type="text" placeholder="내용을 입력하세요"
							id="eventName">
					</div>

					<label for="eventDueDate">날짜</label>
					<div class="form-group">
						<div class="input-group date" data-provide="datepicker">
							<input type="text" id="eventDueDate" name="datetimes"
								class="form-control">
							<div class="input-group-addon">
								<span class="glyphicon glyphicon-calendar"></span>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
					<button type="submit" class="btn btn-primary" id="submitButton">Save</button>
				</div>
			</div>
		</div>
	</div>


	<script>
$(function() {
  $('input[name="datetimes"]').daterangepicker({
	timePicker: true,
    startDate: moment().startOf('hour'),
    endDate: moment().startOf('hour').add(32, 'hour'),
    locale: {
      format: 'YYYY/MM/DD/ HH:mm',
      "daysOfWeek": [
          "일",
          "월",
          "화",
          "수",
          "목",
          "금",
          "토"
      ],
      "monthNames": [
          "1월",
          "2월",
          "3월",
          "4월",
          "5월",
          "6월",
          "7월",
          "8월",
          "9월",
          "10월",
          "11월",
          "12월"
      ]
    }
  });
});
</script>

</body>
</html>
