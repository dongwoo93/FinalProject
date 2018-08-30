<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include/top.jsp"%>
<style>
	#map{
		width:100%;
		height:800px;
	}
	
	.cluster{
		color:red;
	}
</style>
<script>
	
</script>

<div id="allwrapper" style="margin-top: 50px;">
	<div id="centerwrapper">
		<div id="contents" class="container">
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
					
					pin.push([place,lat,lng,index]);
				</script>
			</c:forEach>
			<script>
				var map;
				var markers = [];
				var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
				
				
				var clusterStyles = [
					  { 
					    textColor: 'white',   
					    url: 'hearticon.png',
					    height: 40,
					    width: 40
					  } 
					];
				var mcOptions = {
					    gridSize: 50,
					    styles: clusterStyles,
					    maxZoom: 15
					};        
				
				function initMap() {
					map = new google.maps.Map(document.getElementById('map'), {
				          center: {lat: 36.082402, lng: 128.088226},
				          zoom: 7.4,   
				          mapTypeControl: false,
				          streetViewControl: false,
				          fullscreenControl: false
				        });
					clearMarkers();
			        for (var i = 0; i < pin.length; i++) { 
			        	markers.push(new google.maps.Marker({
				            position:{lat: pin[i][1], lng: pin[i][2]},
				            map: map,
				            title: pin[i][0],
				            zIndex:pin[i][3],
				            animation: google.maps.Animation.DROP
				          }));
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
			      
				
			</script>
			<script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js"></script>
			<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC3SwWm3c4UTbg1SPZD4hHj4E9tz30W2eY&libraries=places&callback=initMap" async defer></script>
			
		</div>
	</div>
	
</div>


<%@ include file="include/bottom.jsp"%>