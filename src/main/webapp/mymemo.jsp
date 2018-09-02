<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="include/top.jsp"%>
<link  href="http://fonts.googleapis.com/css?family=Reenie+Beanie:regular" rel="stylesheet" type="text/css">
<style>
*{
  margin:0;
  padding:0;
}
#wrapper{
  font-family:arial,sans-serif;
  font-size:100%;
  color:#fff;
  width: 100%;
  /* background-image: linear-gradient(rgba(255,255,255,0.5), rgba(255,255,255,0.5)), url('resources/images/memo_background.jpg');
  background-repeat: no-repeat;
  background-position: center;
  background-size:cover; */
  margin: 0 auto;
}
#ul-wrapper {
width: 70%;
margin: 0 auto;
}
.memotitle, .memocontent{
  font-size:100%;
  font-weight:normal;
}
.memoul, .memoli{
  list-style:none;
}
.memoul{
  overflow:hidden;
  padding:3em;
}
.memoul li a{
  text-decoration:none;
  color:#000 !important;
  background:#ffc;
  display:block;
  height:20em;
  width:20em;
  padding:1em;
  -moz-box-shadow:5px 5px 7px rgba(33,33,33,1);
  -webkit-box-shadow: 5px 5px 7px rgba(33,33,33,.7);
  box-shadow: 5px 5px 7px rgba(33,33,33,.7);
  -moz-transition:-moz-transform .15s linear;
  -o-transition:-o-transform .15s linear;
  -webkit-transition:-webkit-transform .15s linear;
}
.memoul li{
  margin:2em;
  float:left;
}
.memoul li h2{
  font-size:140%;
  font-weight:bold;
  padding-bottom:10px;
}
.memoul li p{
  font-family:"Reenie Beanie",arial,sans-serif;
  font-size:220%;
}
.memoul li a{
/*   -webkit-transform: rotate(-6deg);
  -o-transform: rotate(-6deg);
  -moz-transform:rotate(-6deg); */
}
.memoul li:nth-child(even) a{
/*   -o-transform:rotate(4deg);
  -webkit-transform:rotate(4deg);
  -moz-transform:rotate(4deg); */
  position:relative;
  top:5px;
  background:#FCE4EC;
}
.memoul li:nth-child(3n) a{
/*   -o-transform:rotate(-3deg);
  -webkit-transform:rotate(-3deg);
  -moz-transform:rotate(-3deg); */
  position:relative;
  top:-5px;
  background:#FAFAFA;
}
.memoul li:nth-child(5n) a{
/*   -o-transform:rotate(5deg);
  -webkit-transform:rotate(5deg);
  -moz-transform:rotate(5deg); */
  position:relative;
  top:-10px;
}
.memoul li a:hover,.memoul li a:focus{
  box-shadow:10px 10px 7px rgba(0,0,0,.7);
  -moz-box-shadow:10px 10px 7px rgba(0,0,0,.7);
  -webkit-box-shadow: 10px 10px 7px rgba(0,0,0,.7);
  -webkit-transform: scale(1.25);
  -moz-transform: scale(1.25);
  -o-transform: scale(1.25);
  position:relative;
  z-index:5;
}
/* .topA {
color: white;
} */

/* #memotable {
    background-color: #0000006b;
} */
</style>
<script>
function check(e) {
	var height = $(e).height();
	var curlength = $(e).text().length;
	console.log(curlength);
	if(height > 195) {
		var result = $(e).text().substr(0, curlength-10);
		alert("글자수를 초과하였습니다");
		$(e).text("");
	}
}
function addNote() {

	var myvar = '<li class="memoli">'+
	'      <a>'+
	'        <h2 class="memotitle">제목'+
	'        </h2>'+
	'        <p class="memocontent" onkeydown="check(this);">내용</p>'+
	'      </a>'+
	'    </li>';
	
	$(".memoul").append(myvar);
	$('.memotitle').last().attr('contenteditable','true');
	$('.memocontent').last().attr('contenteditable','true');
	$('.memotitle').last().focus();
	$('#ul-wrapper').animate({scrollTop: $('#ul-wrapper').prop("scrollHeight")}, 500);
}
</script>

<div id="wrapper">
<div class="container">
			<br>
				<div class="tagmenu">
						<div class="row">
							<div class="col-md-12">
								<table id="memotable" class="table">
									<thead>
										<tr>
											<th class="text-center" style="width:180px;font-family: NANUMBARUNPENR !important;box-shadow: 0 0px 0px 0 rgba(0, 0, 0, 0.2), 0 0px 1px 0 rgba(0, 0, 0, 0.19);"><a
											class="topA" href="mymap.jsp" style="font-family: NANUMBARUNPENR !important;font-size:14px;">지도</a></th>
											<th class="text-center" style="width:180px;font-family: NANUMBARUNPENR !important;box-shadow: 0 0px 0px 0 rgba(0, 0, 0, 0.2), 0 0px 1px 0 rgba(0, 0, 0, 0.19);"><a
											class="topA" href="calendar2.jsp" style="font-family: NANUMBARUNPENR !important;font-size:14px;">일정</a></th>
											<th class="text-center" style="width:180px;font-family: NANUMBARUNPENR !important;box-shadow: 0 0px 0px 0 rgba(0, 0, 0, 0.2), 0 0px 1px 0 rgba(0, 0, 0, 0.19);"><a 
											class="topA" href="" style="font-family: NANUMBARUNPENR !important;font-size:14px;">메모</a></th>
											<th class="text-center" style="width:180px;font-family: NANUMBARUNPENR !important;box-shadow: 0 0px 0px 0 rgba(0, 0, 0, 0.2), 0 0px 1px 0 rgba(0, 0, 0, 0.19);"><a 
											class="topA" href="" style="font-family: NANUMBARUNPENR !important;font-size:14px;">기록</a></th>	
										</tr>
									</thead>
								</table>
							</div>
						</div>
					</div>
				</div>
<div id="ul-wrapper">4
<div style="text-align: center;">
<button type="button" class="btn btn-success" onclick="addNote()">메모 추가</button>
</div>
<ul class="memoul">
    <li class="memoli">
      <a>
        <h2 id="title1" class="memotitle">Title #2
        <i class="fas fa-trash" style="float: right;"></i>
        <i class="fas fa-pencil-alt" style="float: right; margin-right: 15px;"></i>
        </h2>
        <p class="memocontent">Text Content #1</p>
      </a>
    </li>
    <li class="memoli">
      <a>
        <h2 class="memotitle">Title #2
        <i class="fas fa-trash" style="float: right;"></i>
        <i class="fas fa-pencil-alt" style="float: right; margin-right: 15px;"></i>
        </h2>
        <p class="memocontent">Text Content #2</p>
      </a>
    </li>
    <li class="memoli">
      <a>
        <h2 class="memotitle">Title #2
        <i class="fas fa-trash" style="float: right;"></i>
        <i class="fas fa-pencil-alt" style="float: right; margin-right: 15px;"></i>
        </h2>
        <p class="memocontent">Text Content #3</p>
      </a>
    </li>
    <li class="memoli">
      <a>
        <h2 class="memotitle">Title #2
        <i class="fas fa-trash" style="float: right;"></i>
        <i class="fas fa-pencil-alt" style="float: right; margin-right: 15px;"></i>
        </h2>
        <p class="memocontent">Text Content #4</p>
      </a>
    </li>
    <li class="memoli">
      <a>
        <h2 class="memotitle">Title #2
        <i class="fas fa-trash" style="float: right;"></i>
        <i class="fas fa-pencil-alt" style="float: right; margin-right: 15px;"></i>
        </h2>
        <p class="memocontent">Text Content #5</p>
      </a>
    </li>
    <li class="memoli">
      <a>
        <h2 class="memotitle">Title #2
        <i class="fas fa-trash" style="float: right;"></i>
        <i class="fas fa-pencil-alt" style="float: right; margin-right: 15px;"></i>
        </h2>
        <p class="memocontent">Text Content #6</p>
      </a>
    </li>
    <li class="memoli">
      <a>
        <h2 class="memotitle">Title #2
        <i class="fas fa-trash" style="float: right;"></i>
        <i class="fas fa-pencil-alt" style="float: right; margin-right: 15px;"></i>
        </h2>
        <p class="memocontent">Text Content #2</p>
      </a>
    </li>
    <li class="memoli">
      <a>
        <h2 class="memotitle">Title #2
        <i class="fas fa-trash" style="float: right;"></i>
        <i class="fas fa-pencil-alt" style="float: right; margin-right: 15px;"></i>
        </h2>
        <p class="memocontent">Text Content #7</p>
      </a>
    </li>
    <li class="memoli">
      <a>
        <h2 class="memotitle">Title #2
        <i class="fas fa-trash" style="float: right;"></i>
        <i class="fas fa-pencil-alt" style="float: right; margin-right: 15px;"></i>
        </h2>
        <p class="memocontent">Text Content #8</p>
      </a>
    </li>
  </ul>
  </div>
  </div>
<%@ include file="include/bottom.jsp"%>