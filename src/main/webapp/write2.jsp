<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="include/top.jsp"%>
    <link rel="stylesheet" href="resources/css/instagram.css">
    <link rel="stylesheet" type="text/css" href="resources/css/write.css">
<script>
        // var filesArr = Array.prototype.slice.call(files);

        //        var index = 0;
        //        filesArr.forEach(function(f) {
        //            selImages.push(f);
        //
        //            if (input.files && input.files[index]) {
        //                var reader = new FileReader();
        //
        //                reader.onload = function(e) {
        //                  // $('#frontImage').attr('src', e.target.result);
        //                    $('frontImage').append(index)
        //                }
        //                reader.readAsDataURL(input.files[index]);
        //          }
        //        })

        //   }
        
         function imageInfo(obj){                 
                  
                  console.log(obj.width);
                  console.log(obj.height);
                  console.log(obj.naturalWidth);
                  console.log(obj.naturalHeight);
                  
              }
        
        var maxHeight = 0;
        function staticSetMaxImageHeight(obj) {
            console.log(obj.height );
            if ( maxHeight <= obj.height ){
                maxHeight = obj.height ;
                
            }
            console.log("mxh: " + maxHeight);
        }
        

        $(document).ready(function() {
        	console.log('3344433353');
        	        	
        	  <!-- 000000000000000000000000000000000000000000 -->        	  
              function getCaretPosition(editableDiv) {   
                  var caretPos = 0, sel, range;   
                  if (window.getSelection) {   
                    sel = window.getSelection();   
                    if (sel.rangeCount) {   
                      range = sel.getRangeAt(0);   
                    
                      // console.log("childs: " + range.commonAncestorContainer.parentNode.parentNode.childNodes.length)
                      if (range.commonAncestorContainer.parentNode.parentNode == editableDiv) { 
                        caretPos = range.endOffset;
                       // console.log("caretPos: " + caretPos)
               
        				
        				var i = range.commonAncestorContainer.parentNode.parentNode.childNodes.length - 1;
                        var isEqualOrLower = false;
        				while(i >= 0){
        					if($(range.commonAncestorContainer.parentNode.parentNode.childNodes[i]).text() != $(range.commonAncestorContainer).text()){
        						i--;
        						continue;
        					} else {
        						while( i >= 0 ){
        							var $impl = $(range.commonAncestorContainer.parentNode.parentNode.childNodes[i - 1])
                              	 // console.log($impl.text());
                          		  caretPos += $impl.text().length
                          		  i--;
        						}
        						break;
        					}
        				}             	  
                        
                      }                       
                    }
                    
                      
                  } else if (document.selection && document.selection.createRange) {   
                    range = document.selection.createRange();   
                    if (range.parentElement() == editableDiv) {  
                    	
                      var tempEl = document.createElement("span");   
                      editableDiv.insertBefore(tempEl, editableDiv.firstChild);   
                      var tempRange = range.duplicate();   
                      tempRange.moveToElementText(tempEl);   
                      tempRange.setEndPoint("EndToEnd", range);   
                      caretPos = tempRange.text.length;   
                    }   
                  }
   
                  return caretPos;   
                }
              
              
   
              var update = function() {   
                  $('#caretposition').val(getCaretPosition(this));   
                };    
                
      
              $('#editorDiv').on("mousedown mouseup keydown keyup", update);         
             
   			
              var map = {16: false, 32: false}; 
              $("#editorDiv").keyup(function(e){   
            	   
                  if ( (e.keyCode === 32 ) || (e.keyCode === 13 ) ) {   
                         map[e.keyCode] = true;     
                         
                         if(parseInt($('#caretposition').val()) == 0){
                        	 // alert('뭐?')                        	 
                         } else if (parseInt($('#caretposition').val()) == $('#editorDiv').text().length){
                        	 // alert( parseInt($('#caretposition').val()) + ":" +  $('#editorDiv').text().length);
                         } else {
                        	 // alert('임마?')
                        	 return;
                         }
                         
                         
                         var regex = /(#[^#\s,;<>.]+)/gi;  
                             if(regex){      
                            	 var newtxt = "<span class=fugue>" + $('#editorDiv').text().replace(regex, "</span><span class=text-danger>" + "$1" + "</span><span class=fugue>") + "</span>"
                            	 									  
       							 // console.log($('#editorDiv').text().length);   
                             	// console.log(newtxt)   
                              newtxt += "<kz></kz>"   
                              $('#editorDiv').html(newtxt)  
                                 var el = document.getElementById("editorDiv");   
                                 console.log("childNodes: " + el.childNodes.length); 
                                 var range = document.createRange();   
                                 var sel = window.getSelection();   
                                 range.setStart(el.lastChild, 0);   
                                 range.collapse(false);   
                                 sel.removeAllRanges();   
                                 sel.addRange(range);                         
       
                                 $('#editorDiv').focusout();   
                                 $('#editorDiv').focus();
                         if( parseInt($('#caretposition').val()) == $('#editorDiv').text().length ){
                        	 
                         }
   
                         }   
                  }   
                 })/* .keyup(function(e){   
                    if(e.keyCode === 32){   
                       map[e.keyCode] = false;             
   
                      }
                    console.log($('#editorDiv').text().length);
   
                 }); */   
              <!-- 000000000000000000000000000000000000000000 -->  
   
              $('#submitbutton').click(function(){   
                // alert('전송')   
                if($('#fileSelect').val() == '' || $('#fileSelect').val() == null){
                	alert('사진은 1개 이상 필요합니다.')
                	return;
                }
            	var length = $('.imgWidth100').length;
              	var filterOutput = "";
              	for(i = 0; i < length; i++){
              		filterOutput += $('.imgWidth100').eq(i).attr('class').replace("imgWidth100", ";").replace(" ", "")
              	}
                $('#contentsHidden').val($('#editorDiv').text())   
                $('#filtersHidden').val(filterOutput)  
                $('#frm').submit();   
              });
   
			
            $("#searchfriend").keyup(function(){
            	 var searchtext = $(this).val();
            	 $("#friendlist *").remove();
            	 $.ajax({
                     url: "searchfriend.do", // 처리할 페이지(서블릿) 주소
                     type: "get",
                     data: {searchtext: searchtext},    // 리퀘스트 parameter 보내기 {키값, 변수명(value)}
                     success: function(response) {
                         console.log("AJAX Request 성공");
                         console.log(response.length)
                         for(var i=0;i<response.length;i++){
                        	 $("#friendlist").append("<li class='nav-item friendlist pl-2' onclick='tag_friend(this)'>"+response[i]+"</li>");
                         }
                     },
                     error: function() {
                         console.log("에러 발생");
                     },
                     complete: function(){
                         console.log("AJAX 종료");
                     }
                 });
            });
            
            $("#personmodalbt").click(function(){
         	   var textValue = $(".tags li").length;
         	   alert(textValue);
         	   $("#person *").remove();
         	   $("#person").append("<ul class='tag' onclick='personmodal()' style='cursor: pointer;'></ul>")

         	   for(var i = 1; i<textValue+1;i++){
		            
                var realValue = $(".tags li:nth-child("+i+")").attr("id");
               		 $(".tag").append('<li class="addedTag">' + realValue + '<input type="hidden" value="' + realValue + '" name="tags[]"></li>');
               		$('#personModal').modal('hide');
                }
         	   
         	   $("#searchfriend").val("");
            });
            
            
      
           	   
        	
            $('#fileSelect').change(function() {
                $('#attachDivInner').html('');
                readImage(this);
            })

            var selImages = [];
                   
  
            function readImage(input) {
            	
            	var d = new Date();
            	
                var files = input.files;
                console.log(files);
                for (i = 0; i < files.length; i++) {
                    console.log(files[i])
                    if (files[i].size > 1024 * 1024 * 10) {
                        alert('10MB 초과');
                        continue;
                    }

                    if (input.files && input.files[i]) {
                        var reader = new FileReader();
                        
                        if (i == 0) {
                            reader.onload = function(e) {  
                                $('#attachDivInner').append("<div class='carousel-item active'><img src='" + e.target.result + "' class='imgWidth100' onload='javascript:staticSetMaxImageHeight(this)'></div>");
                                //alert('fileLength 1')
                            	$("[id*='filterPreviewImg_']").attr("src", e.target.result);
                                
                            }
                            
                        } else {
                            reader.onload = function(e) {
                                
                                $('#attachDivInner').append("<div class='carousel-item'><img src='" + e.target.result + "' class='imgWidth100' onload='javascript:staticSetMaxImageHeight(this)'></div>");                            
                             	
                            }                          
                        }   
                        
                        
                    }

                    reader.readAsDataURL(input.files[i]);
                    console.log(reader);     
                    
                }  
            }  
            
            $('#leftCarouselBtn').click(function(){
            	// alert('left')
            	setTimeout(function(){
            		var src = $('.active').find('img').attr('src');
            		$("[id*='filterPreviewImg_']").attr("src", src)
            	}, 700);
            	
            })
            $('#rightCarouselBtn').click(function(){
            	// alert('right')
            	setTimeout(function(){
            		var src = $('.active').find('img').attr('src');
            		$("[id*='filterPreviewImg_']").attr("src", src)
            	}, 700);
            	

            })
            
           $('#testButton').click(function(){           	
            	console.log($('.imgWidth100'))
            	
            	// alert(output)
            	
            	console.log($('#fileSelect').val());

            })
        });
    
    </script>


    <div id="allwrapper">
		<form id=frm action='writeProc.bo' method=post enctype="multipart/form-data">
			<!-- form 시작 -->
			<div id="centerwrapper" class="pt-3">
				<div class="container" id="contents">
					<div class="row">
						<div class="col-md-7 align-self-center">
							<!-- -->
<!-- 							<input type="file" class="btn" multiple=multiple id="fileSelect" -->
<!-- 								name="filename[]"> <i class="far fa-images"></i> -->
							<!-- -->
							<!--                        <img class="d-block img-fluid" src="https://pingendo.github.io/templates/sections/assets/gallery_14.jpg" style="width: 100%;" id='frontImage'>-->

								<div class="filebox">  
								<input type="file" class="btn btn-light"  multiple id="fileSelect"
								name="filename[]"> <i class="far fa-images"></i>
								</div>
								

							<div id="attachDiv" style="height: 600px;">
								<div id="carouselAttachDiv" class="carousel slide "
									data-ride="carousel" data-interval="false">
									<div class="carousel-inner" id=attachDivInner></div>
									<a id=leftCarouselBtn class="carousel-control-prev" href="#carouselAttachDiv"
										role="button" data-slide="prev"> <span
										class="carousel-control-prev-icon" aria-hidden="true"></span>
										<span class="sr-only">Previous</span>
									</a> <a id=rightCarouselBtn class="carousel-control-next" href="#carouselAttachDiv"
										role="button" data-slide="next"> <span
										class="carousel-control-next-icon" aria-hidden="true"></span>
										<span class="sr-only">Next</span>
									</a>
								</div>

							</div>


							<div id="filter">
								<div id="carouselExampleControls" class="carousel slide "
									data-ride="carousel" data-interval="false">

									<div class="carousel-inner">
										<c:forEach var="i" items="${filter}" varStatus="status">
											  <c:choose>
						                          <c:when test = "${status.index == 0}">
						                        
						                              <div class="carousel-item active">
						                                 <div class="row">
						                              
						                        </c:when>
						                        <c:when test = "${(status.index %4 == 0) && (status.index != 0)}">
						                        
						                              <div class="carousel-item">
						                                 <div class="row">
						                              
						                        </c:when>
						                        </c:choose>
											<div class="col-md-3 col-6 p-1">
												<a id="${i}"> <img
													class="d-block img-fluid ${i}"
													src="https://pingendo.github.io/templates/sections/assets/gallery_2.jpg" id='filterPreviewImg_${i}'>
												</a>
												<p class="text-center">${i}</p>
											</div>
											<c:choose>
												<c:when test="${(status.index%4 == 3) || (status.index == 40)}">
													</div>
													</div>
												</c:when>
											</c:choose>
									
									<a class="carousel-control-prev" href="#carouselExampleControls"
										role="button" data-slide="prev"> <span
										class="carousel-control-prev-icon" aria-hidden="true"></span> <span
										class="sr-only">Previous</span>
									</a> <a class="carousel-control-next" href="#carouselExampleControls"
										role="button" data-slide="next"> <span
										class="carousel-control-next-icon" aria-hidden="true"></span> <span
										class="sr-only">Next</span>
									</a>
								
								
								<script>
									$("#${i}").click(function(){
										$("#attachDivInner .active img").attr("class","${i} imgWidth100");
									});
								</script>
								</c:forEach>
								</div>
								</div>
							</div>

							
						</div>
						<div class="col-md-5" id="writeform">
							<div class="card">
		<!-- 글쓰기 칸 -->
								<div class="card-body" contenteditable="true" id="editorDiv"></div>
								<input type=hidden id="caretposition" value="0">
								<input type=hidden name=contents id=contentsHidden> 
								<input type=hidden name=filters id=filtersHidden>
								<ul class="list-group list-group-flush">
									<li class="list-group-item"><i
										class="fas fa-map-marker-alt tagicon mr-3"></i><a
										onclick="placemodal()" style="cursor: pointer;" id="place">위치
											태그하기</a></li>
									<li class="list-group-item" id="person"><i
										class="fas fa-users tagicon mr-2 pr-1"></i><a
										onclick="personmodal()" style="cursor: pointer;">사람 태그하기</a></li>
		
								</ul>
							</div>
							<div class="py-3">
								<button type="button" id="submitbutton">
									<i class="fas fa-arrow-right fa-2x"></i>
								</button>
								<button type=button id="testButton">테스트</button>
							</div>
						</div>
					</div>
				</div>
				
			</div>
	
	</form>
	</div>
	<!-- form 끝 -->

	<script>
		function personmodal() {
			$("#friendlist *").remove();
			$.ajax({
                url: "searchfriend.do", // 처리할 페이지(서블릿) 주소
                type: "get",
                data: {searchtext: ""},    // 리퀘스트 parameter 보내기 {키값, 변수명(value)}
                success: function(response) {
                    console.log("AJAX Request 성공");
                    console.log(response.length)
                    for(var i=0;i<response.length;i++){
                   	 $("#friendlist").append("<li class='nav-item friendlist pl-2' onclick='tag_friend(this)'>"+response[i]+"</li>");
                    }
                },
                error: function() {
                    console.log("에러 발생");
                },
                complete: function(){
                    console.log("AJAX 종료");
                }
            });   
			$('#personModal').modal('show');
		                            
		}
		</script>

	<!--       위치태그하기 Modal부분-->
	<div id="placeModal" class="modal fade bd-example-modal-lg"
		tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
		aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">
						<i class="fas fa-map-marker-alt tagicon mr-2"></i>위치 태그하기
					</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div id="pac-container">
						<input id="pac-input" type="text" placeholder="Enter a location">
					</div>
					<div id="map"></div>
				</div>
				<div class="modal-footer">
					<p>핀클릭시 장소 태그</p>
				</div>
			</div>
		</div>
	</div>
	<!--        위치태그하기 Modal 끝-->

	<!--       사람태그하기 Modal부분-->
	<div id="personModal" class="modal fade" tabindex="-1" role="dialog"
		aria-labelledby="myLargeModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">
						<i class="fas fa-users tagicon mr-2"></i>사람 태그하기
					</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" id="persondagmodal">
					<div class="row">
						<div class="col-5">
							<input type="text" class="form-control mb-2" placeholder="friend"
								id="searchfriend">
							<ul class="nav nav-pills flex-column" id="friendlist">
								<script>
	                           function tag_friend(e){
		                           var text = $(e).text();
		                           var index = 1;
		                           var textValue = $(".tags li").length;
		                           for(var i = 1; i<textValue+1;i++){
		            
			                           var realValue = $(".tags li:nth-child("+i+")").attr("id");
		                        	   if(realValue == text){
		                        		   alert("이미 태그한 친구입니다.");
		                        		   index++;
		                        		   break;
		                        	   }
		                           }
		                           
		                           if(index == 1){
		                        	   $(".tags").append('<li class="addedTag" id="'+text+'">' + text + '<span class="tagRemove" onclick="$(this).parent().remove();">x</span><input type="hidden" value="' + text + '" name="tags[]"></li>');
		                           }
		                        
	                           }
	                           
	                           $('.tagRemove').click(function(event) {
	                                event.preventDefault();
	                                $(this).parent().remove();
	                            });
	                           
	                           
	                           </script>
							</ul>
						</div>
						<div class="col-7">
							<div class="tab-content">
								<ul class="tags">

								</ul>
							</div>
						</div>
					</div>

				</div>
				<div class="modal-footer">
					<button id="personmodalbt">확인</button>
				</div>
			</div>
		</div>
		<script
			src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC3SwWm3c4UTbg1SPZD4hHj4E9tz30W2eY&libraries=places&callback=initAutocomplete"
			async defer></script>
	</div>
	<!--        사람태그하기 Modal 끝-->

	<script>
      var map;
      var i = 1;
      function placemodal() {
          
          $('#placeModal').modal('show');
          if(i == 1){
              if (navigator.geolocation) {
                  navigator.geolocation.getCurrentPosition(function(position) {
                        var pos = {
                          lat: position.coords.latitude,
                          lng: position.coords.longitude
                        };

                        map.setCenter(pos);
                  });
                } else {
                  alert("현재위치를 표시할 수 없습니다.");
                }
          }
          
          i++;
      }
      
      
      
      function initAutocomplete() {
          map = new google.maps.Map(document.getElementById('map'), {
          center: {lat: -33.8688, lng: 151.2195},
          zoom: 13,
          mapTypeControl: false,
          streetViewControl: false,
          fullscreenControl: false
        });
          
        var input = document.getElementById('pac-input');
        var searchBox = new google.maps.places.SearchBox(input);
        map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
          
        var infowindow = new google.maps.InfoWindow();
        var infowindowContent = document.getElementById('infowindow-content');
        infowindow.setContent(infowindowContent);

        map.addListener('bounds_changed', function() {
          searchBox.setBounds(map.getBounds());
        });

        var markers = [];

        searchBox.addListener('places_changed', function() {
          var places = searchBox.getPlaces();
          document.getElementById('pac-input').value = "";

          if (places.length == 0) {
            alert("해당하는 위치가 없습니다.");
            return;
          }

          markers.forEach(function(marker) {
            marker.setMap(null);
          });
            
          markers = [];

          var bounds = new google.maps.LatLngBounds();
          places.forEach(function(place) {
            if (!place.geometry) {
              console.log("Returned place contains no geometry");
              return;
            }
              
            var marker = new google.maps.Marker({
              map: map,
              title: place.name,
              position: place.geometry.location
            });

            markers.push(marker);

            if (place.geometry.viewport) {
              bounds.union(place.geometry.viewport);
            } else {
              bounds.extend(place.geometry.location);
            } 
            
             marker.addListener('click', function() {
                  $("#place").text(place.name);
                  var pos1 = {
                    lat: marker.getPosition().lat(),
                    lng: marker.getPosition().lng()
                  };
                  
                  
                  map.setCenter(pos1);
                  $('#placeModal').modal('hide');
             });
          });
         
          map.fitBounds(bounds);
        });
      }

    </script>
    <%@ include file="include/bottom.jsp"%>