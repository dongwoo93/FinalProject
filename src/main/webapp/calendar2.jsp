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
    	var content = $('#eventName').val();
    	var startEnd = $("#eventDueDate").val();
    	var startTime = startEnd.split(' - ')[0];
    	var endTime = startEnd.split(' - ')[1];
    	$.ajax({
            url: 'insert.cal',
            type: 'post',
            data : {
            	date_start : startTime,
            	date_end : endTime,
            	content : content
             },
            success: function (data) {
            	if(data.result == 0) {
            		alert("등록에 실패 하였습니다");
            		$('#calendar').fullCalendar('unselect');
            	}else {
            		$("#calendar").fullCalendar('renderEvent',
            		          {
            						id: data.seq,
            		              title: content,
            		              start: new Date(startTime),
            		              end: new Date(endTime)
            		          },
            		          true);
            	}
            },
            error : function() {
                console.log("에러 발생!");
                }
        });
      $("#createEventModal").modal('hide');
      
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
        $.ajax({
            url: 'insert.cal',
            type: 'post',
            data : {
            	date_start : start.format(),
            	date_end : end.format(),
            	content : title
             },
            success: function (data) {
            	if(data.result == 0) {
            		alert("등록에 실패 하였습니다");
            		$('#calendar').fullCalendar('unselect');
            	}else {
            		eventData = {
            				id: data.seq,
            	            title: title,
            	            start: start,
            	            end: end
            	          };
            		$('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
            	}
            },
            error : function() {
                console.log("에러 발생!");
                }
        });
        
        }
        $('#calendar').fullCalendar('unselect');
      },
      editable: true,
      eventLimit: true, // allow "more" link when too many events
      eventClick: function(event) {
    	   
    	      return false;
    	    
    	  },
      eventDrop: function(event, delta, revertFunc) {
    	    if (!confirm("일정을 변경 하시겠습니까?")) {
    	      revertFunc();
    	    }else {
    	    	$.ajax({
    	            url: 'update.cal',
    	            type: 'post',
    	            data : {
    	            	seq: event.id,
    	            	date_start : event.start.format(),
    	            	date_end : event.end.format(),
    	            	content : event.title
    	             },
    	            success: function (data) {
    	            	if(data == 0) {
    	            		alert("등록에 실패 하였습니다");
    	            		revertFunc();
    	            	}
    	            },
    	            error : function() {
    	                console.log("에러 발생!");
    	                }
    	        });
    	    }

    	  },
      eventResize: function(event, delta, revertFunc) {

    	    if (!confirm("일정을 변경 하시겠습니까?")) {
    	      revertFunc();
    	    }else {
    	    	$.ajax({
    	            url: 'update.cal',
    	            type: 'post',
    	            data : {
    	            	seq: event.id,
    	            	date_start : event.start.format(),
    	            	date_end : event.end.format(),
    	            	content : event.title
    	             },
    	            success: function (data) {
    	            	if(data == 0) {
    	            		alert("등록에 실패 하였습니다");
    	            		revertFunc();
    	            	}
    	            },
    	            error : function() {
    	                console.log("에러 발생!");
    	                }
    	        });
    	    }

    	  },
      googleCalendarApiKey: 'AIzaSyBLzmfo25SUyDaDRjI7wrhI1cyIhs6sYAc',
      eventSources : [
    	  	{
    	  		 events: [
    	  		<c:forEach var='event' items='${result}'>
    	  	    { 	id: '${event.seq}',
    	  	    	title: '${event.content}',
    	  	    	start: '${event.date_start}',
    	  	    	end: '${event.date_end}'
    	  	    },
    	  	  </c:forEach>
    	  	    	{}
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
      format: 'YYYY-MM-DD HH:mm',
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
