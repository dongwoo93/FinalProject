<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="include/top.jsp"%>
    <link rel="stylesheet" type="text/css" href="resources/css/myarticle.css">
    <script src="resources/js/myarticle.js"></script>
    
    <c:if test="${result.size() > 0}">
	<script> var list= []; </script>
	<c:forEach var="tmp" items="${result}" varStatus="status">
			<script>    
			list.push("${tmp.board_seq}");    
			
			</script>
		</c:forEach>
 </c:if>
    
    <div id="allwrapper">
   

	  <div class="container my">
			<div class="profile">
				<div class="profile-image">
					<img src="https://images.unsplash.com/photo-1513721032312-6a18a42c8763?w=152&h=152&fit=crop&crop=faces">
<!-- 					  <img src="http://lorempixel.com/150/150/people/" class="hoverZoomLink"> -->
				</div>
	
				<div class="profile-user-settings">
					<h2 class="profile-user-name">${result[0].id}</h2>
					<div class="profile-edit-btn" id="toMy">프로필편집</div>
					<div class="profile-settings-btn"><i class="far fa-times-circle" id="logout"></i></div>
<!-- 					<button id="logout" type="button" class="btn btn-outline-danger">로그아웃</button> -->
				</div>
	
				<div class="profile-stats">
					<ul>
						<li><span class="profile-stat-count">164</span> 게시글</li>
						<li><span class="profile-stat-count">188</span> 팔로워</li>
						<li><span class="profile-stat-count">206</span> 팔로우</li>
					</ul>
				</div>
	
				<div class="profile-bio">
					<p><span class="profile-real-name">멋쟁이</span>&nbsp;&nbsp;난 오늘도 고독을 즐긴다..</p>
				</div>
			</div>
		</div>
		
		
		
    <div class="tagmenu">
      <div class="row">
        <div class="col-md-12">
          <table class="table">
            <thead>
              <tr>
                <th class="text-center">게시물</th>
                <th class="text-center">태그됨</th>
              </tr>
            </thead>
          </table>
        </div>
      </div>
    </div>

		
	
<div class="container my">

     <div class="gallery">
      <c:if test="${result.size() != 0}">

			
		
		        <c:forEach var="tmp" items="${result}" varStatus="status">
		
			
				<div class="gallery-item" id="${tmp.board_seq}">  
<%-- 				<img src='https://images.unsplash.com/photo-1511765224389-37f0e77cf0eb?w=500&h=500&fit=crop' class='gallery-image' id="${tmp.board_seq}">    --%>
					 <img src="https://pingendo.github.io/templates/sections/assets/gallery_girl.jpg" class="img-fluid"> 
				
				 
<%-- 					<div class="gallery-item-info" id="item${tmp.board_seq}"> --%>
						<div class="gallery-item-info">        
						<ul>
							<li class="gallery-item-likes"><i class="fas fa-heart"></i> 18</li>
							<li class="gallery-item-comments"><i class="fas fa-comment"></i> 2</li>
						</ul>
					</div>
				
				
				<script>
					
  
                       $("#${tmp.board_seq}").click(function() {
                    	   $("#prev").val(${result[status.index-1].board_seq}); 
                    	   $("#next").val(${result[status.index+1].board_seq}); 
                    	   $("#hidden").val(${result[status.index].board_seq});
                          	$("#boardmodal").modal();                	   
                       });
                        
//                        $("#modify${tmp.board_seq}").click(function() {
//                     	   $("#seq").val(${tmp.board_seq});  
//                           	$("#boardmodal").modal();                       	   
//                        });

						
//                        $("seq1").click(function() {             	      
//                          	$("#boardmodal").modal('show');                   	   
//                        });
           
					</script>
				
			
				</div>
			
		<!-- <script>
			num++;
		</script> -->
		</c:forEach>
		
		
      </c:if>
  
	
	</div>			
	
<!-- 			<div class="spinner"></div> -->
	
		</div>
	

	</div>
	
	<div class="modal fade" id="boardmodal" role="dialog"> 
		    <div class="modal-dialog" role="document">
		    
		    <div class="modal-content">
<!--   				 &nbsp;&nbsp; <i class="fas fa-angle-double-left text-black" id="hidden" style="font-size:40px;"></i> -->
<!--   				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!--   				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!--   				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!--   				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!--   				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!--   				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!--   				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!--   				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!--   				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!--   				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!--   				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;				 -->
<!--   				 <i class="fas fa-angle-double-right text-black"  style="font-size:40px;"></i> -->


				<button id="goNext" class="btn btn-outline-primary">&#62;</button>
				<button id="goPrev" class="btn btn-outline-primary">&#60;</button>
 			</div>
		
		  	 
		  	 
		  	  <br><br>
		      <div class="modal-content">
		    
		        	<div class="gallery-item" id="picture">  
		       		  <img src="https://pingendo.github.io/templates/sections/assets/gallery_girl.jpg" class="img-fluid">
		        	</div>
		        	
		      </div>
		      
		      <div class="modal-content">
		    
<!-- 		        	<div class="bg-white" id="seq"></div> -->
<!-- 		        	<div class="bg-white" id="seq1"></div> -->
		        	
		    		 <div class="hidden" id="hidden"></div>
		    		 <div class="hidden" id="prev"></div>
		    		 <div class="hidden" id="next"></div>
		        	
		        	  	
		        	<div class="bg-white" id="a">
		        	  	<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				          <a class="navbar-brand " href="#">
				            <i class="far fa-heart icon"></i>
				          </a>
				           <a class="navbar-brand " href="#">
				              <i class="far fa-comment icon"></i>
				          </a>   
				           <a class="navbar-brand " href="#">
				             <i class="far fa-bookmark icon"></i> 
				          </a>        
		        	  </div>
		        	  	
		        	  	
				<div id="board" class="bg-white">
			        	<br>
			          <div class="profile-image"> 	 
			              <img class="ml-3 mr-2" src="https://images.unsplash.com/photo-1513721032312-6a18a42c8763?w=30&amp;h=30&amp;fit=crop&amp;crop=faces">
			          		<div id="modalid"></div>   		
			          </div>      
				      	  			 	              
					   <br>
					   <br>
		       		
		     
		       		<input id="seq" type=hidden name=board_seq>
		            <div id="articlecontents" class="mt-2 mx-3 pb-2"> 
                    <div class="bg-black" id="modalcontents"></div>					
					</div>

              	</div>   
          
	
              <div class="py-2 bg-white">     	
               
                <input type="text" placeholder="댓글 달기..." class="ml-2 pl-2" id="comment">   	  
                   
		   <c:choose>
			<c:when test="${result[0].id == sessionScope.loginId}">
              
		          <div class="btn-group bg-white">
		            <button class="btn dropdown-toggle bg-white" data-toggle="dropdown"> </button>
		            <div class="dropdown-menu">
		              <a class="dropdown-item" href="#">보관</a>
		              <div class="dropdown-divider" id="modifydiv"></div>
		              <a class="dropdown-item" id="modify" href="#">수정</a>
		              <div class="dropdown-divider"></div>
		              <a class="dropdown-item" id="modifysubmitbtn" href="#">수정완료</a>
		              <div class="dropdown-divider"></div>
		              <a class="dropdown-item"  name=delete id="delete" href="#">삭제</a>
		              <div class="dropdown-divider"></div>
		              <a class="dropdown-item" href="#">부적절한콘텐츠신고</a>
		            </div>
		          </div>
        
        	<script>
				
			</script>
	         
	         </c:when>
				<c:otherwise>  
					<div class="btn-group bg-white">
		            <button class="btn dropdown-toggle bg-white" data-toggle="dropdown"> </button>
		            <div class="dropdown-menu">
		              <a class="dropdown-item" href="#">보관</a>	              
		              <div class="dropdown-divider"></div>
		              <a class="dropdown-item" href="#">부적절한콘텐츠신고</a> 
		            </div>
		          </div>
		          
		          
				
		           </c:otherwise>
			</c:choose>
								

              		</div>
		         </div>	
		              
		      </div>
		    </div>
	<%@ include file="include/bottom.jsp"%>