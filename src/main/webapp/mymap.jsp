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
   		width:70%; 
	}
</style>
<script type="text/javascript" src="/resources/js/html2canvas.js"></script>

<div id="allwrapper" style="margin-top: 50px;">
	<div id="centerwrapper">
		<div id="contents" class="container">
			<div style="float:left;"><h2><b>나의 지도</b></h2></div>
			<div class="mb-2" style="float:right;"><i class="fas fa-share-square fa-3x" style="cursor:pointer;" id="sharebt"></i><i class="fas fa-cog fa-3x ml-2" style="cursor:pointer;" id="setup"></i></div>
			<div id="map"></div>
			<script>
				var pin = [];
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
				
				var clusterStyles = [
					  { 
					    textColor: 'pink',   
					    url: 'heart.png',
					    height: 50,
					    width: 50
					  } 
					];
				var mcOptions = {
					    gridSize: 50,
					    styles: clusterStyles,
					    maxZoom: 15
					};        
				
				function initMap() {
					var infowindow = new google.maps.InfoWindow();
					
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
			        	marker = new google.maps.Marker({
			                position: new google.maps.LatLng(pin[i][1], pin[i][2]),
			                map: map,
			                title: pin[i][0],
				            animation: google.maps.Animation.DROP
			              });
			        	
			        	markers.push(marker);

			            google.maps.event.addListener(marker, 'click', (function(marker, i) {
			                return function() {
			                	$.ajax({
					                url: "getBoard.do", 
					                type: "get",
					                data: {id:"${sessionScope.loginId}",lat:pin[i][1],lng:pin[i][2]},    
					                success: function(response) {
					                	var content = "<ul class='list-group' style='width:250px;'><li class='list-group-item' style='background-color:#ccc;'>"+pin[i][0]+"</li>";
					                	for(var k = 0 ; k<response[0].length;k++){
					                		content  = content + "<a href='oneBoard.do?"+response[0][k].board_seq+"'><li class='list-group-item d-flex justify-content-between align-items-center'><p id='list'>" + response[0][k].contents+"</p><span class='badge badge-pill'><img src='AttachedMedia/"+response[1][k]+"' style='width:50px; height:50px;'></span><div style=''>"+response[0][k].writedate.split(" ")[0]+"</div></li></a>";
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
			       
			        addMarkerWithTimeout(i * 200);
				    var markerCluster = new MarkerClusterer(map,markers,mcOptions);
			    }
				

			      function addMarkerWithTimeout(timeout) {
			        window.setTimeout(function() {markers}, timeout);
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
			            //URL of Google Static Maps.
			            var staticMapUrl = "https://maps.googleapis.com/maps/api/staticmap";
			 
			            //Set the Google Map Center.
			            staticMapUrl += "?center=" + map.center.lat() + "," + map.center.lng();
			 
			            //Set the Google Map Size.
			            staticMapUrl += "&size=1110x700";
			 
			            //Set the Google Map Zoom.
			            staticMapUrl += "&zoom=" + map.zoom;
			            
			           //Set the Google Map Type.
			            staticMapUrl += "&maptype=" + mapOptions.mapTypeId;
			            
			            for (var i = 0; i < markers.length; i++) {   
			            	console.log(markers[i].getPosition());   
			                staticMapUrl += "&markers=icon:http://172.30.1.44/pin.png|" + markers[i].getPosition().lat()+ "," + markers[i].getPosition().lng();
			            }
			 			      
			            staticMapUrl += "&key=AIzaSyC3SwWm3c4UTbg1SPZD4hHj4E9tz30W2eY"; 
			            //Save the Image Url of Google Map.
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
			        <h5 class="modal-title" id="exampleModalLabel">지도 공유하기</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body" id="modalbody">
			        <img id="mapimg" src="" style="width:480px; height:500px;">
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			        <button type="button" class="btn btn-primary">Save changes</button>
			      </div>
			    </div>
			  </div>
			</div>
			
<!-- 			설정모달 -->
			
			<div class="modal fade" id="setupModal" tabindex="-1" role="dialog" aria-labelledby="setupModalLabel" aria-hidden="true">
			  <div class="modal-dialog modal-dialog-centered" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="setupModalLabel"><i class="fas fa-cog mr-2"></i>지도 설정</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body" id="modalbody2">
			        <img id="mapimg" src="" style="width:480px; height:500px;">
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			        <button type="button" class="btn btn-primary">Save changes</button>
			      </div>
			    </div>
			  </div>
			</div>
		</div>
	</div>
	
</div>


<%@ include file="include/bottom.jsp"%>