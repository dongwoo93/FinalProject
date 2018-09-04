<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include/top.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="resources/js/top.js"></script>
<link
	href="http://fonts.googleapis.com/css?family=Reenie+Beanie:regular"
	rel="stylesheet" type="text/css">
<style>
@CHARSET "UTF-8";

@font-face { font-family: 'NANUMBARUNPENR'; src: url("../fonts/NANUMBARUNPENR.TTF") format('truetype'); }
@font-face { font-family: 'NANUMPEN'; src: url("../fonts/NANUMPEN.TTF") format('truetype'); }




* {
	margin: 0;
	padding: 0;
}

#wrapper {
	font-family: arial, sans-serif;
	font-size: 100%;
	color: black;
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

.memotitle, .memocontent {
	font-size: 100%;
	font-weight: normal;
}

.memoul, .memoli {
	list-style: none;
	font-weight:bold;
	font-family: NANUMBARUNPENR !important;
}

.memoul {
	overflow: hidden;
	padding: 3em;
}

.memoul li a {
	text-decoration: none;
	color: #000 !important;
	background: #ffc;
	display: block;
	height: 20em;
	width: 20em;
	padding: 1em;
	-moz-box-shadow: 5px 5px 7px rgba(33, 33, 33, 1);
	-webkit-box-shadow: 5px 5px 7px rgba(33, 33, 33, .7);
	box-shadow: 5px 5px 7px rgba(33, 33, 33, .7);
	-moz-transition: -moz-transform .15s linear;
	-o-transition: -o-transform .15s linear;
	-webkit-transition: -webkit-transform .15s linear;
}

.memoul li {
	margin: 2em;
	float: left;
}

.memoul li h2 {
	font-size: 140%;
	font-weight: bold;
	padding-bottom: 10px;
}

.memoul li div {
	font-size: 14px;
}

}
.memoul li a {
-webkit-transform: rotate(-6deg);
  -o-transform: rotate(-6deg);
  -moz-transform:rotate(-6deg);
	
}

.memoul li:nth-child(even) a {
-o-transform:rotate(4deg);
  -webkit-transform:rotate(4deg);
  -moz-transform:rotate(4deg);
	position: relative;
	top: 5px;
	background: #FCE4EC;
}

.memoul li:nth-child(3n) a {
	-o-transform:rotate(-3deg);
  -webkit-transform:rotate(-3deg);
  -moz-transform:rotate(-3deg);
	position: relative;
	top: -5px;
	background: #FAFAFA;
}

.memoul li:nth-child(5n) a {
-o-transform:rotate(5deg);
  -webkit-transform:rotate(5deg);
  -moz-transform:rotate(5deg);
	position: relative;
	top: -10px;
}

.memoul li a:hover, .memoul li a:focus {
	box-shadow: 10px 10px 7px rgba(0, 0, 0, .7);
	-moz-box-shadow: 10px 10px 7px rgba(0, 0, 0, .7);
	-webkit-box-shadow: 10px 10px 7px rgba(0, 0, 0, .7);
	-webkit-transform: scale(1.25);
	-moz-transform: scale(1.25);
	-o-transform: scale(1.25);
	position: relative;
	z-index: 5;
}

.fa-trash:hover, .fa-pencil-alt {
cursor: pointer;
}

.fa-trash:hover, .fa-pencil-alt:hover {
	color: brown;
}
/* .topA {
color: white;
} */

/* #memotable {
    background-color: #0000006b;
} */



</style>
<script>
$(document).ready(function() {

})

/**
 * 바이트수 반환  
 * 
 * @param el : tag jquery object
 * @returns {Number}
 */
 var finalLength = 0;
	function check(e, evt, cat) {
		console.log("최종 :" + finalLength);
	 var height = $(e).height();
	 var charLength = 0;
	 var str = $(e).text();
	 var ch1 = "";
	 
	 for(var i = 0; i < str.length; i++) {
			ch1 = str.charAt(i);
			if(escape(ch1).length > 4) {		
				charLength += 2;
			} else {
				charLength += 1;
			}
		}
	 console.log("길이 :" + charLength);
	evt = evt || window.event;
    var code = evt.keyCode;
    evt.stopPropagation();
	if (evt.keyCode === 13) {
		// insert 2 br tags (if only one br tag is inserted the cursor won't go to the next line)
	      document.execCommand('formatBlock', false, 'div');
	      // prevent the default behaviour of return key pressed
	      return false;
	    }
			var codeByte = 0;
		    for (var idx = 0; idx < $(e).text().length; idx++) {
		        var oneChar = escape($(e).text().charAt(idx));
		        if ( oneChar.length == 1 ) {
		            codeByte ++;
		        } else if (oneChar.indexOf("%u") != -1) {
		            codeByte += 2;
		        } else if (oneChar.indexOf("%") != -1) {
		            codeByte ++;
		        }
		    }
		    console.log("바이트 :" + codeByte);
		    if(cat == "title") {
		    	if (height > 20) {
			    	 var cut = str.substr(0,finalLength-1);
					    $(e).text(cut);
				}else {
					finalLength = charLength;
				}
		    }else {
		    	 if (height > 195) {
			    	 var cut = str.substr(0,finalLength-1);
					    $(e).text(cut);
				}else {
					finalLength = charLength;
				}
		    }
		   
 }
			
		

	function submit(e) {
		var titleElement = $(e).next().next();
		var contentElement = $(e).next().next().next();
		var title = titleElement.text();
		var content = contentElement.html();

		if(title == "" || content == "") {
			alert("내용을 입력해주세요");
			return;
		}
		$.ajax({
			type : "POST",
			url : "addNote.memo",
			data : {
				title : title,
				content: content
			},
			success : function(data) {
				if(data != 'false') {
					var myvar = '<i class="fas fa-trash" onclick="deleteNote(this,&#34;'+data+'&#34;)" style="float: right;"></i>'+
					'<i class="fas fa-pencil-alt" onclick="modifyNote(this, &#34;'+data+'&#34;)" style="float: right; margin-right: 15px;"></i>';
					
					titleElement.attr('contenteditable', 'false');
					contentElement.attr('contenteditable', 'false');
					titleElement.append(myvar);
					$(e).remove();
				}else {
					alert("저장 실패");
				}
			},
			error : function() {
				console.log("에러 발생");
			}
		})

	}
	
	function deleteNote(e, seq) {
		
		if(confirm("삭제 하시겠습니까?")) {
			var boardSeq = seq;
			$.ajax({
				type : "POST",
				url : "deleteNote.memo",
				data : {
					seq : boardSeq
				},
				success : function(data) {
					if(data > 0) {
						$(e).parent().parent().parent().fadeOut(400, function(){ $(this).remove();});;
					}else {
						alert("삭제 실패");
					}
				},
				error : function() {
					console.log("에러 발생");
				}
			})
		}
		
		
	}
	
function cancelNote(e) {
		
		if(confirm("작성을 취소하시겠습니까?")) {
			$(e).parent().parent().fadeOut(400, function(){ $(this).remove();});
		}
		
		
	}
	
	function updateNote(e,seq) {
		var boardSeq = seq;
		var titleElement = $(e).next();
		var contentElement = $(e).next().next();
		var title = titleElement.text();
		var content = contentElement.html();

			if(title == "" || content == "") {
				alert("내용을 입력해주세요");
				return;
			}
		
		
		$.ajax({
			type : "POST",
			url : "updateNote.memo",
			data : {
				seq: boardSeq,
				title : title,
				content: content
			},
			success : function(data) {
				if(data > 0) {
					var myvar = '<i class="fas fa-trash" onclick="deleteNote(this,&#34;'+boardSeq+'&#34;)" style="float: right;"></i>'+
					'<i class="fas fa-pencil-alt" onclick="modifyNote(this,&#34;'+boardSeq+'&#34;)" style="float: right; margin-right: 15px;"></i>';
					
					titleElement.attr('contenteditable', 'false');
					contentElement.attr('contenteditable', 'false');
					titleElement.append(myvar);
					$(e).remove();
				}else {
					alert("수정 실패");
				}
			},
			error : function() {
				console.log("에러 발생");
			}
		})
	}
	
	function modifyNote(e, seq) {
		var boardSeq = seq;
		$(e).parent().attr('contenteditable', 'true');
		$(e).parent().next().attr('contenteditable', 'true');
		$(e).parent().before('<i onclick="updateNote(this,&#34;'+boardSeq+'&#34;)" class="fas fa-check" style="float: right;font-size: 20px;color: darkgreen;cursor: pointer;"></i>');
		$(e).parent().focus();
		$(e).prev().remove();
		$(e).remove();
	}
	
	function addNote() {

		var myvar = '<li class="memoli">'
				+ '      <a>'
				+ '        <i onclick="submit(this)" class="fas fa-check" style="float: right;font-size: 20px;color: darkgreen;cursor: pointer;"></i>'
				+ '        <i onclick="cancelNote(this)" class="fas fa-times" style="float: right;font-size: 20px;color: red;cursor: pointer;margin-right: 15px;"></i>'
				+ '        <h2 onkeyup="check(this, event, &#34;title&#34;)"; class="memotitle">제목'
				+ '        </h2>'
				+ '        <div class="memocontent" onkeyup="check(this, event, &#34;content&#34;);">내용</div>'
				+

				'      </a>' + '    </li>';

		$(".memoul").prepend(myvar);
		$(".memoli").first().hide().slideDown(200, function() {
			$('.memotitle').first().attr('contenteditable', 'true');
			$('.memocontent').first().attr('contenteditable', 'true');
			$('.memotitle').first().focus();
		});
		
		$('#ul-wrapper').animate({
			scrollTop : $('#ul-wrapper').prop("scrollHeight")
		}, 500);
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
								<th class="text-center"
									style="width: 180px; font-family: NANUMBARUNPENR !important; box-shadow: 0 0px 0px 0 rgba(0, 0, 0, 0.2), 0 0px 1px 0 rgba(0, 0, 0, 0.19);"><a
									class="topA" href="mymap.bo"
									style="font-family: NANUMBARUNPENR !important; font-size: 14px;">지도</a></th>
								<th class="text-center"
									style="width: 180px; font-family: NANUMBARUNPENR !important; box-shadow: 0 0px 0px 0 rgba(0, 0, 0, 0.2), 0 0px 1px 0 rgba(0, 0, 0, 0.19);"><a
									class="topA" href="calendar.bo"
									style="font-family: NANUMBARUNPENR !important; font-size: 14px;">일정</a></th>  <!-- "calendar2.jsp" -->
								<th class="text-center"
									style="width: 180px; font-family: NANUMBARUNPENR !important; box-shadow: 0 0px 0px 0 rgba(0, 0, 0, 0.2), 0 0px 1px 0 rgba(0, 0, 0, 0.19);"><a
									class="topA" href="goNote.memo"
									style="font-family: NANUMBARUNPENR !important; font-size: 14px;">메모</a></th>
								<th class="text-center"
									style="width: 180px; font-family: NANUMBARUNPENR !important; box-shadow: 0 0px 0px 0 rgba(0, 0, 0, 0.2), 0 0px 1px 0 rgba(0, 0, 0, 0.19);"><a
									class="topA" href="my.log"
									style="font-family: NANUMBARUNPENR !important; font-size: 14px;">기록</a></th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
	</div>
	<div id="ul-wrapper">
		<div style="text-align: center;">
			
				<div class="jumbotron">
  <h1 class="display-3">Hello, ${ sessionScope.loginId }!</h1>
  <p class="lead">이 페이지에서는 당신이 SocialWired에서 활동했던 모든 활동 로그를 볼 수 있어요.</p>
  <hr class="my-4">
  <p>The quick brown fox jumps over the lazy dog. </p>
  <p class="lead">
    <a class="btn btn-primary btn-lg" href="#" role="button">더 자세히 보기</a>
  </p>
</div>
				
		</div>
		<div class="row">
			<div class=col-6>
				<h3>나의 가입일</h3>
				${ joinStr }
				<hr>
				<h3>로그인</h3>
				<c:forEach var="i" items="${ logins }">
					${ i }<br>
				</c:forEach>
				<hr>
				<h3>로그아웃</h3>
				<c:forEach var="i" items="${ logouts }">
					${ i }<br>
				</c:forEach>
				<hr>
				<h3>좋아요 로그</h3>
				<c:forEach var="i" items="${ likeList }" varStatus="st">
					<a href="oneBoard.do?board_seq=${ i.board_seq }">${ i.board_seq }</a> - ${fn:substring(likeTitles[st.index],0,30)}...
					<br><small>${ i.apply_date }</small><br>
				</c:forEach>
				<hr>
				<h3>찜콕 로그</h3>
				<c:forEach var="i" items="${ markList }" varStatus="st">
					<a href="oneBoard.do?board_seq=${ i.board_seq }">${ i.board_seq }</a> - ${fn:substring(markTitles[st.index],0,30)}...
					<br><small>${ i.apply_date }</small><br>
				</c:forEach>
				
			</div>
			<div class=col-6>
				<h3>검색 로그</h3>
				<c:forEach var="i" items="${ searches }" varStatus="st">
					<c:if test="${ (st.index+1) % 2 ne 0 }">
						${ i }: 
					</c:if>
					<c:if test="${ (st.index+1) % 2 eq 0 }">
						<a class=text-danger href="search.bo?search=${i}">#${ i }</a><br>
					</c:if>
				</c:forEach>
				<hr>
				<h3>팔로우 로그</h3>
				<c:forEach var="i" items="${ followList }">
					<a href="board.bo?id=${ i.targetId }&cat=1">${ i.targetId }</a> - ${ i.followDate }<br>
				</c:forEach>
				<hr>
				<h3>코멘트 로그</h3>
				<c:forEach var="i" items="${ commentList }">
					<a href="oneBoard.do?board_seq=${ i.board_seq }">${ i.comment_contents }</a> 
					- ${ i.writedate }<br>
				</c:forEach>
				<hr>
			</div>
		</div>
	</div>
</div>
<%@ include file="include/bottom.jsp"%>