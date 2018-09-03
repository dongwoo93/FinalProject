<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include/top.jsp"%>
<style>
	#map{
		width:100%;
		height:700px;
	}
	
	.cluster{
		color:red;
	}
	
	#list{
		overflow: hidden;    
   	 	text-overflow: ellipsis;
   		white-space: nowrap;
   		width:20%; 
	}
	
	.clusterimg{
		width:80px; 
		height:70px;
		cursor:pointer;
	}
	
	.clusterimg:hover{
		border:1px solid #ccc;
	}
	
	.pinimg{
		width:80px; 
		height:70px;
		cursor:pointer;
	}
	
	.pinimg:hover{
		border:1px solid #ccc;
	}
</style>
<script type="text/javascript" src="/resources/js/html2canvas.js"></script>





<div id="allwrapper" style="margin-top: 50px;">


<div class="container">
			<br>
				<div class="tagmenu">
						<div class="row">
							<div class="col-md-12">
								<table class="table">
									<thead>
										<tr>
											<th class="text-center" style="width:180px;font-family: NANUMBARUNPENR !important;box-shadow: 0 0px 0px 0 rgba(0, 0, 0, 0.2), 0 0px 1px 0 rgba(0, 0, 0, 0.19);"><a
												href="mymap.bo" style="font-weight:bold;font-family: NANUMBARUNPENR !important;font-size:14px;">지도</a></th>
											<th class="text-center" style="width:180px;font-family: NANUMBARUNPENR !important;box-shadow: 0 0px 0px 0 rgba(0, 0, 0, 0.2), 0 0px 1px 0 rgba(0, 0, 0, 0.19);"><a
												href="calendar.bo" style="font-family: NANUMBARUNPENR !important;font-size:14px;">일정</a></th>
											<th class="text-center" style="width:180px;font-family: NANUMBARUNPENR !important;box-shadow: 0 0px 0px 0 rgba(0, 0, 0, 0.2), 0 0px 1px 0 rgba(0, 0, 0, 0.19);"><a 
												href="goNote.memo" style="font-family: NANUMBARUNPENR !important;font-size:14px;">메모</a></th>
											<th class="text-center" style="width:180px;font-family: NANUMBARUNPENR !important;box-shadow: 0 0px 0px 0 rgba(0, 0, 0, 0.2), 0 0px 1px 0 rgba(0, 0, 0, 0.19);"><a 
												href="" style="font-weight:bold;font-family: NANUMBARUNPENR !important;font-size:14px;">기록</a></th>	
										</tr>
									</thead>
								</table>
							</div>
						</div>
					</div>
				</div>


	<div id="centerwrapper">
		<div id="contents" class="container">
			<div class="mb-2" style="float:right;"><i class="fas fa-share-square fa-2x" style="cursor:pointer; color:#6c757d;" id="sharebt"></i><i class="fas fa-cog fa-2x ml-2" style="cursor:pointer; color:#6c757d;" id="setup"></i></div>
			<div id="map"></div>  
			<script>    
				var pin = [];
				var mypin = "${mymap.pinimg}";
				var mycluster = "${mymap.clusterimg}";
			</script>
			<c:forEach var="p" items="${pin}" varStatus="status">
				<script>
					var lat = parseFloat("${p.location_latitude}");
					var lng = parseFloat("${p.location_longitude}");
					var place = "${p.location_name}";
					var index = parseInt("${status.index}");
					var board_seq = "${p.board_seq}";
					
					pin.push([place,lat,lng,board_seq]);
				</script>
			</c:forEach>
			
			<script>
				var map;
				var markers = [];
				var marker;
				var mapOptions;
				var clusterStyles;
				
				function initMap() {
					var infowindow = new google.maps.InfoWindow();
					
					
					var image = {
					          url: mypin,
					};

					mapOptions = {
							  center: {lat: 36.082402, lng: 128.088226},
					          zoom: 7.1,   
					          mapTypeControl: false,
					          streetViewControl: false,
					          fullscreenControl: false
			            };
					map = new google.maps.Map(document.getElementById('map'), mapOptions);
					clearMarkers();
					
			        for (var i = 0; i < pin.length; i++) {
			        	if(mypin == "resources/images/pin/basicpin1.png"){
			        		marker = new google.maps.Marker({
				                position: new google.maps.LatLng(pin[i][1], pin[i][2]),
				                map: map,
				                title: pin[i][0],
					            animation: google.maps.Animation.DROP
				              });
			        	}else{
			        		marker = new google.maps.Marker({
				                position: new google.maps.LatLng(pin[i][1], pin[i][2]),
				                map: map,
				                title: pin[i][0],
				                icon:image,
					            animation: google.maps.Animation.DROP
				              });
			        	}
			        	markers.push(marker);

			            google.maps.event.addListener(marker, 'click', (function(marker, i) {
			                return function() {
			                	$.ajax({
					                url: "getBoard.do", 
					                type: "get",
					                data: {id:"${sessionScope.loginId}",lat:pin[i][1],lng:pin[i][2]},    
					                success: function(response) {
					                	var content = "<ul class='list-group' style='width:350px; font-weight:bold;font-family: NANUMBARUNPENR !important;font-size: 14px;'><li class='list-group-item' style='background-color:#f3f3f3; '>"+pin[i][0]+"</li>";
					                	for(var k = 0 ; k<response[0].length;k++){
					                		content  = content + "<a href='oneBoard.do?"+response[0][k].board_seq+"'><li class='list-group-item d-flex justify-content-between align-items-center'><p id='list' class='mb-0'>" + response[0][k].contents+"</p><span class='badge badge-pill'><img src='AttachedMedia/"+response[1][k]+"' style='width:50px; height:50px; margin-left:100px;'></span><div style=''>"+response[0][k].writedate.split(" ")[0]+"</div></li></a>";
					                	}
					                	content = content + "</ul>";
					                	infowindow.setContent(content);
						                infowindow.open(map, marker);  
					                },
					                error: function() {
					                    console.log("에러 발생");
					                },
					                complete: function(){
					                    console.log("AJAX 종료");
					                }
					            });
			                  
			                }
			            })(marker, i));
			            
			        }
			       
			        if(mycluster == "https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m"){
						 var markerCluster = new MarkerClusterer(map,markers,{imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});
					}
					else {
						clusterStyles = [
							  { 
							    textColor: 'black',   
							    url: mycluster,
							    height: 50,
							    width: 50
							  } 
							];
						var mcOptions = {
							    gridSize: 50,
							    styles: clusterStyles,
							    maxZoom: 15
							}; 
						 var markerCluster = new MarkerClusterer(map,markers,mcOptions);
					}
					
			       
			    }

			      function clearMarkers() {
			        for (var i = 0; i < markers.length; i++) {
			          markers[i].setMap(null);
			        }
			        markers = [];
			      }
			      
			      $("#sharebt").click(function(){
			    	  Export();
			    	  
			    	  $("body").attr("style","opacity:0.3;");
			 
			    	  setTimeout(function(){
			    		  $("body").attr("style","");
			    	  },200);       
			    	  
			    	  $('#exampleModal').modal('show'); 
			      })
			      
			      function Export() {
			            var staticMapUrl = "https://maps.googleapis.com/maps/api/staticmap";
			 
			            staticMapUrl += "?center=" + map.center.lat() + "," + map.center.lng();
			 
			            staticMapUrl += "&size=1110x700";
			 
			            staticMapUrl += "&zoom=" + map.zoom;
			            
			            staticMapUrl += "&maptype=" + mapOptions.mapTypeId;
			            
			            for (var i = 0; i < markers.length; i++) {   
			            	console.log(markers[i].getPosition());   
			                staticMapUrl += "&markers=color:red|" + markers[i].getPosition().lat()+ "," + markers[i].getPosition().lng();
			            }
			 			      
			            staticMapUrl += "&key=AIzaSyC3SwWm3c4UTbg1SPZD4hHj4E9tz30W2eY"; 
			            $("#mapimg").attr("src",staticMapUrl);
			        }
			      
			      $("#setup").click(function(){
			    	  $('#setupModal').modal('show'); 
			      })
			      
			</script>
			<script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js"></script>
			<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC3SwWm3c4UTbg1SPZD4hHj4E9tz30W2eY&libraries=places&callback=initMap" async defer></script>
			
<!-- 			공유하기 modal -->
			<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog modal-dialog-centered" role="document">  
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" style="font-weight:bold;font-family: NANUMBARUNPENR !important;font-size: 14px;" id="exampleModalLabel"><i class="fas fa-share-square mr-2"></i>지도 공유하기</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body" id="modalbody">
			        <img id="mapimg" src="" style="width:480px; height:500px;">
			      </div>
			      <div class="modal-footer">
			      	 <button type="button" class="btn btn-light text-dark" style="font-weight:bold;font-family: NANUMBARUNPENR !important;font-size: 14px;" id="shareokbt">공유하기</button>
			        <button type="button" class="btn btn-light text-dark" style="font-weight:bold;font-family: NANUMBARUNPENR !important;font-size: 14px;" data-dismiss="modal">취소</button>
			      </div>
			    </div>  
			  </div>
			</div>  
			
<!-- 			설정모달 -->
			
			<div class="modal fade" id="setupModal" tabindex="-1" role="dialog" aria-labelledby="setupModalLabel" aria-hidden="true">
			  <div class="modal-dialog modal-dialog-centered" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="setupModalLabel" style="font-weight:bold;font-family: NANUMBARUNPENR !important;font-size: 14px;"><i class="fas fa-cog mr-2"></i>지도 설정</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body" id="modalbody2">
			      	<div class="card mb-3">
					  <div class="card-header">
					    Cluster 설정
					  </div>
					  <div class="card-body row">
					  	<div style="width:100%; height:20px;" class="mb-3">
					  		<div class="col-3">
						      <p class="text-center" style="float:left;">현재 cluster</p>
						    </div>
						    
						    <div class="col-9">
						      <p class="text-center" >Custom cluster</p>
						    </div>  
					  	</div>
					  	<div style="width:100%; height:110px;">
						    <div class="col-3" style="border-right:0.9px solid #ccc; height:100px; float:left;">
						      <c:choose>
						      	<c:when test="${mymap.clusterimg == 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'}">
						      		<img src="resources/images/cluster/basiccluster.png" style="width:80px; height:70px;" id="currentcluster">
						      	</c:when>
						      	<c:otherwise>
						      		<img src="${mymap.clusterimg }" style="width:80px; height:70px;" id="currentcluster">
						      	</c:otherwise>
						      </c:choose>
						    </div>
						    
						    <div class="col-9" style="height:110px; overflow-x:scroll; white-space:nowrap">
						      <img src="resources/images/cluster/basiccluster.png" class="mr-3 clusterimg">
						      <img src="resources/images/cluster/circleicon.png" class="mr-3 clusterimg">
						      <img src="resources/images/cluster/heart.png" class="mr-3 clusterimg">
						      <img src="resources/images/cluster/hearticon2.png" class="mr-3 clusterimg">
						      <img src="resources/images/cluster/staricon.png" class="mr-3 clusterimg">
						      <img src="resources/images/cluster/simpleheart.png" class="mr-3 clusterimg">
						      <img src="resources/images/cluster/captinamericaicon.png" class="clusterimg">
						    </div>
					    </div>
					  </div>
					</div>
					
					<div class="card">
					  <div class="card-header">
					    MyPin 설정
					  </div>
					  <div class="card-body row">
					    <div style="width:100%; height:20px;" class="mb-3">
					  		<div class="col-3">
						      <p class="text-center" style="float:left;">현재 Pin</p>
						    </div>
						    
						    <div class="col-9">
						      <p class="text-center" >Custom Pin</p>
						    </div>  
					  	</div>
					  	<div style="width:100%; height:100px;">
						    <div class="col-3" style="border-right:0.9px solid #ccc; height:100px; float:left;">
  						      <img src="${mymap.pinimg }" style="width:60px; height:70px;" class="ml-2" id="currentpin">
						    </div>
						    
						    <div class="col-9" style="height:100px; overflow-x:scroll; white-space:nowrap">
						      <img src="resources/images/pin/basicpin1.png"  style="width:60px;" class="mr-3 pinimg">
						      <img src="resources/images/pin/flagpin2.png" class="mr-3 pinimg">
						      <img src="resources/images/pin/heartpin12.png" class="mr-3 pinimg">
						      <img src="resources/images/pin/heartpin22.png" class="mr-3 pinimg">
						      <img src="resources/images/pin/koreapin2.png" class="mr-3 pinimg">
						      <img src="resources/images/pin/starpin2.png" class="mr-3 pinimg">
						    </div>
					    </div>
					  </div> 
					</div>  
					<div class="mt-3 text-center modal-footer">
						<button type="button" class="btn btn-light text-dark" style="font-weight:bold;font-family: NANUMBARUNPENR !important;font-size: 14px;" id="okbt">적용하기</button>
			        	<button type="button" class="btn btn-light text-dark" style="font-weight:bold;font-family: NANUMBARUNPENR !important;font-size: 14px;" data-dismiss="modal">취소</button>
					</div>
			      </div>
			    </div>
			  </div>
			</div>
		</div>
	</div>
	
</div>
<script>

	$("#shareokbt").click(function(){
		var mapimg = $("#mapimg").attr("src");
		$(location).attr("href","shareMap.bo?mapurl="+encodeURIComponent(mapimg));
	})
	
	$(".clusterimg").click(function(){
		var clickimg = $(this).attr("src");
		var currentimg = $("#currentcluster").attr("src");
		if(clickimg == currentimg){
			alert("현재 적용되어 있는 이미지 입니다.");
		}
		else{
			$("#currentcluster").attr("src",clickimg);
				
		}
	})
	
	$(".pinimg").click(function(){
		var clickimg = $(this).attr("src");
		var currentimg = $("#currentpin").attr("src");
		if(clickimg == currentimg){
			alert("현재 적용되어 있는 이미지 입니다.");
		}
		else{
			$("#currentpin").attr("src",clickimg);
		}
	})
	
	$("#okbt").click(function(){
		var currentcluster = $("#currentcluster").attr("src");
		var currentpin = $("#currentpin").attr("src");
		if(currentcluster == "resources/images/cluster/basiccluster.png"){
			currentcluster = "https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m";
		}
		
			
		if(currentcluster == mycluster && currentpin == mypin){
			alert("현재 클러스터 와 핀 이미지와 일치합니다.");
		}else if(currentcluster == mycluster){
			var result = confirm("핀 이미지를 변경하시겠습니까 ?");  
			if(result){
				$(location).attr("href","setMyMap.bo?cluster="+currentcluster+"&pin="+currentpin);
			}
		}else if(currentpin == mypin){
			var result = confirm("클러스터 이미지를 변경하시겠습니까 ?");
			if(result){
				$(location).attr("href","setMyMap.bo?cluster="+currentcluster+"&pin="+currentpin);
			}   
		}
		else {
			var result = confirm("변경 사항을 저장하시겠습니까 ?");
			if(result){
				$(location).attr("href","setMyMap.bo?cluster="+currentcluster+"&pin="+currentpin);
			}
		}
		
		
	})
</script>

<%@ include file="include/bottom.jsp"%>