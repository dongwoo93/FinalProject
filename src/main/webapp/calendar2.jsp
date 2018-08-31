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
$(document).on('show.bs.modal', '.modal', function () {
    var zIndex = 1040 + (10 * $('.modal:visible').length);
    $(this).css('z-index', zIndex);
    setTimeout(function() {
        $('.modal-backdrop').not('.modal-stack').css('z-index', zIndex - 1).addClass('modal-stack');
    }, 0);
});
function showmodimodal(e) {
	var currentEv = $("#calTitle").text();
	var start = $("#hiddenStart").text();
	var end = $("#hiddenEnd").text();
	$("#modifyEventModal").modal();
	$("#eventName2").val(currentEv);
	$("#eventDueDate2").val("");
}

function myAlertBottom(msg){
	$("#alertmsg").text(msg);
	  $(".myAlert-bottom").fadeIn();
	  setTimeout(function(){
	    $(".myAlert-bottom").fadeOut(); 
	  }, 2000);
	}

function deleteEvent() {
	var id = $('#hiddenid').val();
	$.ajax({
        url : "delete.cal",
        type : "post",
        data : {
           id : id
        },
        success : function(resp) {
        	if(resp == 0) {
        		alert("삭제에 실패 하였습니다");
        		$('#calendar').fullCalendar('unselect');
        	}else {
        		$("#calModal").modal("hide");
        		$('#calendar').fullCalendar('removeEvents', id);
        		myAlertBottom("일정이 삭제 되었습니다");
        	}
        },
        error : function() {
           console.log("에러 발생!");
           }
        })
}

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
	  
	  $('#submitButton2').on('click', function(e){
		  var content = $('#eventName2').val();
		  if(content == "") {
			  alert("내용을 입력해주세요");
			  return;
		  }
          // We don't want this to act as a link so cancel the link action
          e.preventDefault();

          doSubmit2();
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
            		myAlertBottom("일정이 등록 되었습니다");
            	}
            },
            error : function() {
                console.log("에러 발생!");
                }
        });
      $("#createEventModal").modal('hide');
      
     }
    
    function doSubmit2(){
    	var seq = $("#hiddenid").val();
    	var content = $('#eventName2').val();
    	var startEnd = $("#eventDueDate2").val();
    	var startTime = startEnd.split(' - ')[0];
    	var endTime = startEnd.split(' - ')[1];
    	var eventData;
    	$.ajax({
            url: 'update.cal',
            type: 'post',
            data : {
            	seq : seq,
            	date_start : startTime,
            	date_end : endTime,
            	content : content
             },
            success: function (data) {
            	if(data == 0) {
            		alert("등록에 실패 하였습니다");
            	}
            	eventData = {
        				id: seq,
        	            title: event.title,
        	            start: event.start,
        	            end: event.end
        	          };
            	$('#calendar').fullCalendar('removeEvents', seq);
            	$("#calendar").fullCalendar('renderEvent',
      		          {
      						id: seq,
      		              title: content,
      		              start: new Date(startTime),
      		              end: new Date(endTime)
      		          },
      		          true);
            	$("#modifyEventModal").modal("hide");
            	$("#calModal").modal('hide');
              	myAlertBottom("일정이 변경 되었습니다");
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
            		myAlertBottom("일정이 등록 되었습니다");
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
    	  if($(this).css("background-color")== "rgb(255, 0, 0)") {
    		  $("#calHeader").css("background-color", "red");
    	  }else {
    		  $("#calHeader").css("background-color", "#3a87ad");
    	  }
    	  $(".fc-event").removeAttr("href");
    	  $("#hiddenid").val(event.id);
    	  $("#calModal").modal("show");
    	  $("#calTitle").text(event.title);
    	  $("#hiddenStart").text(event.start.format());
    	  $("#hiddenEnd").text(event.end.format());
    	  $("#timecontent").text(event.start.format("YYYY년 MM월 DD일, a hh:mm")+' ~ ' +event.end.format("YYYY년 MM월 DD일, a hh:mm"));
    	    
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
    	            	myAlertBottom("일정이 변경 되었습니다");
    	            },
    	            error : function() {
    	                console.log("에러 발생!");
    	                }
    	        });
    	    }

    	  },
    	  /* eventDragStop: function(event,jsEvent) {

    		    var trashEl = jQuery('#calendarTrash');
    		    var ofs = trashEl.offset();

    		    var x1 = ofs.left;
    		    var x2 = ofs.left + trashEl.outerWidth(true);
    		    var y1 = ofs.top;
    		    var y2 = ofs.top + trashEl.outerHeight(true);

    		    if (jsEvent.pageX >= x1 && jsEvent.pageX<= x2 &&
    		        jsEvent.pageY >= y1 && jsEvent.pageY <= y2) {
    		    	if (!confirm("일정을 삭제 하시겠습니까?")) {
    		    	}else {
    		    		$('#calendar').fullCalendar('removeEvents', event.id);
    		    	}
    		        
    		    }
    		}, */
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
    	            	myAlertBottom("일정이 변경 되었습니다");
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

#calBody {
	font-size: 1.2rem;
}

#timediv {
	display: flex;
}

#timecontent {
	padding-left: 20px;
}

#calTitle {
	padding-top: 50px;
	padding-left: 50px;
	padding-bottom: 10px;
	color: white;
}

#closeCal {
	font-size: 2.2rem;
	color: white;
}

.calicon {
	color: white;
	font-size: 2rem;
	margin-right: 20px;
	display:inline-block;
}

.calicon:hover {
	color: black;
}

#calHeader {
	background-color: #3a87ad;
}

.myAlert-bottom {
	position: absolute;
    max-width: 300px;
    /* min-height: 300px; */
    /* background: #063; */
    bottom: 0px;
    right: 25%;
    left: 50%;
    margin-left: -150px;
}

</style>
</head>
<body>
	<div id='calendar'></div>
	<!-- <div id="calendarTrash" class="calendar-trash"><img src="resources/images/trash.png" /></div> -->
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
	
	<!-- Modal -->
	<div id="modifyEventModal" class="modal fade">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h3 style="font-weight: bold;">일정 수정</h3>
				</div>

				<div id="modalBody" class="modal-body">
					<label for="eventName">일정</label>
					<div class="form-group">
						<input class="form-control" type="text" placeholder="내용을 입력하세요"
							id="eventName2">
					</div>

					<label for="eventDueDate">날짜</label>
					<div class="form-group">
						<div class="input-group date" data-provide="datepicker">
							<input type="text" id="eventDueDate2" name="datetimes"
								class="form-control">
							<div class="input-group-addon">
								<span class="glyphicon glyphicon-calendar"></span>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
					<button type="submit" class="btn btn-primary" id="submitButton2">Save</button>
				</div>
			</div>
		</div>
	</div>
	

	<!-- The Modal -->
	<div class="modal" id="calModal">
		<input id="hiddenid" type="hidden" value="">
		<input id="hiddenStart" type="hidden" value="">
		<input id="hiddenEnd" type="hidden" value="">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">

				<!-- Modal Header -->
				<div id="calHeader" class="modal-header">
					<h4 id="calTitle" class="modal-title"></h4>
					<div>
					<i onclick="showmodimodal(this)" class="fas fa-pencil-alt calicon" title="수정"></i>
						<i onclick="deleteEvent()" class="far fa-trash-alt calicon" title="삭제"></i>
						
						<button type="button" id="closeCal" class="close"
							data-dismiss="modal">&times;</button>
					</div>
				</div>

				<!-- Modal body -->
				<div id="calBody" class="modal-body">
					<div id="timediv">
						<div id="clockdiv">
							<i class="far fa-clock"></i>
						</div>
						<div id="timecontent"></div>
					</div>
					<div></div>
				</div>

			</div>
		</div>
	</div>
	<div class="myAlert-bottom alert alert-primary" style="display: none;">
		<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
		<span id="alertmsg"></span>
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
