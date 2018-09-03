<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="include/top.jsp"%>
    <script src="resources/js/top.js"></script>
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
        
        document.addEventListener('keydown', function(event) {
        	console.log($( document.activeElement )[0].tagName);
        	    if (event.keyCode === 13 && $( document.activeElement )[0].tagName != "DIV") {
        	        event.preventDefault();
        	    }
        	}, true);
        
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
        	
        	
        	
        	console.log('Vulkan');
        	var globalBizFormEnabled = false;
        	        	  	  
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
            	   
                  if ( (e.keyCode === 32 )  ) {   
                         map[e.keyCode] = true;     
                         
                         if(parseInt($('#caretposition').val()) == 0){
                        	 // alert('뭐?')                        	 
                         } else if (parseInt($('#caretposition').val()) >= $(this).text().length - 3){	// 고친 부분 1
                        	 // alert( parseInt($('#caretposition').val()) + ":" +  $('#editorDiv').text().length);
                         } else {
                        	 // alert('임마?')
                        	 return;
                         }
                         
                         
                         var regex = /(#[^#\s,;<>.]+)/gi;  
                             if(regex){      // 고친 부분 2 text() -> innerText
                            	 var newtxt = "<span class=fugue>" + this.innerText.replace(regex, "</span><span class=text-danger>" + "$1" + "</span><span class=fugue>") + "</span>"
                            	 									  
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
                
                <c:if test="${ memberBiz ne null }">
	                if($('#enableBiz') != null && $('#enableBiz').is(":checked")){
	                	$('#shifted_enableBiz').val($('#enableBiz').is(":checked") ? "y" : "n")
	                	$('#shifted_moreInfoWebsite').val($('#moreInfoWebsite').val())
	                	$('#shifted_isWebsitePurposeOfPurchase').val($('#isWebsitePurposeOfPurchase').is(":checked") ? "y" : "n")
	                	$('#shifted_exposureRange').val($('#exposureRange').val())
	                	$('#shifted_exposureCount').val($('#exposureCount').val())
	                	$('#shifted_costPerClick').val($('#costPerClick').val())
	                }
                </c:if>
                
                
            	var length = $('.imgWidth100').length;
              	var filterOutput = "";
              	for(i = 0; i < length; i++){
              		filterOutput += ($('.imgWidth100').eq(i).attr('id') + ":")
              		filterOutput += $('.imgWidth100').eq(i).attr('class').replace("imgWidth100", ";").replace(" ", "")
              	}
                $('#contentsHidden').val($('#editorDiv').text());
                $('#filtersHidden').val(filterOutput);
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
            
            $("#personmodalbt").click(function(e){
         	   var textValue = $(".tags li").length;
         	   if(textValue == 0){
         		   var tag = $("#person .tagicon").text();  
         		   console.log(tag);  
         		   if(tag == ""){
         			   $("#person *").remove();
         			   $("#person").append("<i class='fas fa-users tagicon mr-2 pr-1'></i><a onclick='personmodal()' style='cursor: pointer;''>사람 태그하기</a>")
         		   }
         		  $('#personModal').modal('hide');
         	   }else{
         		  
             	   $("#person *").remove();
             	   $("#person").append("<ul class='tag' onclick='personmodal()' style='cursor: pointer;'></ul>")

             	   for(var i = 2; i<textValue+2;i++){
    		            
                    var realValue = $(".tags li:nth-child("+i+")").attr("id");
                   		 $(".tag").append('<li class="addedTag mb-2">' + realValue + '<input type="hidden" value="' + realValue + '" name="tags[]"></li>');
                   		 $('#personModal').modal('hide');
                    }
             	   
             	   $("#searchfriend").val("");  
         	   }
         	  
            });
            
            
      
           	   
        	
            $('#fileSelect').change(function() {
                $('#attachDivInner').html('');
                readImage(this);
            })

            var selImages = [];
                   
            var globalChase = 1;
  
            function readImage(input) {
            	
            	var d = new Date();
            	
                var files = input.files;
                console.log(files);
                
                for (i = 0; i < files.length; i++) {
                   /*  console.log(files[i])
                    if (files[i].size > 1024 * 1024 * 10) {
                        alert('10MB 초과');
                        continue;
                    }

                    if (input.files && input.files[i]) {
                        var reader = new FileReader();
                        
                        if (i == 0) {
                            reader.onload = async function(e) {
                                $('#attachDivInner').append("<div class='carousel-item active'><img src='" + e.target.result + "' class='imgWidth100' onload='javascript:staticSetMaxImageHeight(this)'></div>");
                                //alert('fileLength 1')
                            	$("[id*='filterPreviewImg_']").attr("src", e.target.result);
                                
                            }
                            
                        } else {
                        		reader.onload = async function(e) {
                                  	 $('#attachDivInner').append("<div class='carousel-item'><img src='" + e.target.result + "' class='imgWidth100' onload='javascript:staticSetMaxImageHeight(this)'></div>" );                            
                                	
                               
                               }
                                                     
                        }                       
                        
                    }

                    reader.readAsDataURL(input.files[i]);
                    console.log(reader); */     
                    
                	(function(file) {
                		console.log(files[i])
                        var name = file.name;
                        var reader = new FileReader();
                        var isFirst = '';
                        
                        if(i == 0)	isFirst = 'active';
                        
                        
                        	reader.onload = function(e) {  
                                // get file content  
                                $('#attachDivInner').append("<div class='carousel-item "+isFirst+"'><img src='" + e.target.result + "' class='imgWidth100' id='"+name+"'></div>");                       
                               }
                        
                        
                       		reader.readAsDataURL(file);
                    })(files[i]);
                    
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
            
            <c:if test="${ memberBiz ne null }">
	            // 비즈니스 창 최초 로딩시
	            $("#rangeSpan").text ($("#exposureRange").val());
	            $('#exposureCount').val(Number($("#exposureRange").val () * 500).toLocaleString('ko'))
	            $('#costPerClick').val( 200 * ( 1-($("#exposureRange").val()/500) ) )
	            $('#totalCost').val(Number($("#exposureRange").val() * $("#exposureRange").val () * 500 * 1.2).toLocaleString('ko'))
	            
	            // 변화할때마다
	            $("#exposureRange").bind("change", function (event)
	 			 {
				    $("#rangeSpan").text ($(this).val());
				    $('#exposureCount').val(Number($(this).val () * 500).toLocaleString('ko'))
				    $('#costPerClick').val( 200 * (1-($(this).val()/500)) )
				    $('#totalCost').val(Number($(this).val() * $(this).val () * 500 * 1.2).toLocaleString('ko'))
				    
				 });
	            
	            $( "#bizform input" ).prop( "disabled", true );
	            $("#enableBiz").change(function(){
	            	if($("#enableBiz").is(":checked")){
	            		$( "#bizform input" ).prop( "disabled", false );
	            		globalBizFormEnabled = true;
	            	}
	            	else{
	            		$( "#bizform input" ).prop( "disabled", true );
	            		globalBizFormEnabled = false;
	            	}
	            	
	            })
            </c:if>
        });
    
    </script>


    <div id="allwrapper">
		<form id=frm action='writeProc.bo' method=post enctype="multipart/form-data">
			<!-- form 시작 -->
			<div id="centerwrapper" class="pt-3">
				<div class="container" id="contents">
					<span style="font-family: NANUMBARUNPENR !important;font-size: 15px;background-color: #F5F4F4;">Picture</span>
					<div class="row">
						<div class="col-md-7 align-self-center">
	

							<div id="attachDiv" style="height: 600px;">
								<div id="carouselAttachDiv" class="carousel slide "
									data-ride="carousel" data-interval="false">
									<div class="carousel-inner" id=attachDivInner></div>
									<br>
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
								
							<div class="card" style="border: 5px solid #eff1f4;font-family: NANUMBARUNPENR !important;font-size: 14px;">
							
							<!-- 글쓰기 칸 -->
							<span style="font-family: NANUMBARUNPENR !important;font-size: 14px;background-color: #F5F4F4;">Contents</span>
								<div class="card-body" contenteditable="true" id="editorDiv" style="overflow:auto; white-space: pre-line;" ></div>
								<input type=hidden id="caretposition" value="0">
								<input type=hidden name=contents id=contentsHidden> 
								<input type=hidden name=filters id=filtersHidden>
								<ul class="list-group list-group-flush">
									<li class="list-group-item" style="border: 3px solid #eff1f4;"><i
										class="fas fa-map-marker-alt tagicon mr-3"></i><a
										onclick="placemodal()" style="cursor: pointer;" id="place">위치
											태그하기</a><input type="hidden" id="lat" name="lat"><input type="hidden" id="lng" name="lng"><input type="hidden" id="placetag" name="place"></li>
											
									<li class="list-group-item" style="border: 3px solid #eff1f4;">
									<i class="far fa-images"></i>
									&nbsp;&nbsp;<input type="file" class="" multiple id="fileSelect" name="filename[]"> 									
									</li>		
											
									<li class="list-group-item"  style="border: 3px solid #eff1f4;" id="person"><i
										class="fas fa-users tagicon mr-2 pr-1"></i><a
										onclick="personmodal()" style="cursor: pointer;">사람 태그하기</a></li>
									
								<c:if test="${ memberBiz ne null }">
									<li class="list-group-item" style="border: 3px solid #eff1f4;"><i
										class="fas fa-users tagicon mr-2 pr-1"></i><a
										onclick="bizModal()" style="cursor: pointer;"> <span class="badge badge-pill badge-warning">biz</span> 비즈니스 설정하기</a></li>
								</c:if>
								</ul>
							</div>
							<div class="py-3 text-right">
								<button type="button" id="submitbutton" style="font-family: NANUMBARUNPENR !important;font-size: 14px;background-color: #F5F4F4;">등록하기			
								</button>
							</div>
						</div>
					</div>
													<input type=hidden id=shifted_enableBiz value="n" name="enableBiz">
													<input type=hidden id=shifted_moreInfoWebsite value="" name="moreInfoWebsite">
													<input type=hidden id=shifted_isWebsitePurposeOfPurchase value="n" name="isWebsitePurposeOfPurchase">
													<input type=hidden id=shifted_exposureRange value="" name="costPerMille">
													<input type=hidden id=shifted_exposureCount value="" name="remainedPublicExposureCount">
													<input type=hidden id=shifted_costPerClick value="" name="costPerClick">
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
		aria-labelledby="myLargeModalLabel" aria-hidden="true"  style="font-family: NANUMBARUNPENR !important;font-size: 14px;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" style="font-family: NANUMBARUNPENR !important;font-size: 14px;">
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
		                        	   $(".tags").append('<li class="addedTag" id="'+text+'">' + text + '<span class="tagRemove" onclick="$(this).parent().remove();">x</span></li>');
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
									<br> &nbsp;
								</ul>
							</div>
						</div>
					</div>

				</div>
				<div class="modal-footer" id="personmodalbt">					
					<button type="button" class="btn btn-light text-dark" style="font-weight:bold;font-family: NANUMBARUNPENR !important;font-size: 14px;">태그완료</button>
				</div>
			</div>
		</div>

	</div>
	<!--        사람태그하기 Modal 끝-->
			
	<c:if test="${ memberBiz ne null }">
	<!--       비즈니스 설정 Modal부분-->
	<div id="bizModal" class="modal fade" tabindex="-1" role="dialog"
		aria-labelledby="myLargeModalLabel" aria-hidden="true" style="font-family: NANUMBARUNPENR !important;font-size: 14px;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" style="font-family: NANUMBARUNPENR !important;font-size: 14px;">
						게시물 홍보하기
					</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" id="bizmodal">
				
					<div class="row">
						<div class="col-12">
							<fieldset class="form-group">
						      <legend style="font-family: NANUMBARUNPENR !important;font-size: 14px;">게시물을 홍보하여 비즈니스 성장을 도모하기</legend>
						      <div class="form-check">
						        <label class="form-check-label">
						          <input id="enableBiz" class="form-check-input" type="checkbox" value="y" style="font-family: NANUMBARUNPENR !important;font-size: 14px;" >
						         이 게시물을 홍보합니다.
						        </label>
						      </div>

						    </fieldset>

						</div>
					</div>
<!-- 					<div class="row"><hr></div> -->
					<form id="bizform">
					<div class="row">
						<div class="col-12">							
						    
						    <div class="form-group">
							  <label class="col-form-label" for="moreInfoWebsite" style="font-family: NANUMBARUNPENR !important;font-size: 14px;">더 알아보기(혹은 구매하기) 웹 사이트 주소</label>
							  <input type="text" class="form-control" placeholder="http://example.com/?shopid=12" id="moreInfoWebsite">
							  <small class="form-text text-muted" style="font-family: NANUMBARUNPENR !important;font-size: 14px;">주소를 입력하시면 게시물에 링크가 제공됩니다. 원하지 않으실 경우 공란으로 비워주세요.</small>
							</div>
					
							<fieldset class="form-group">
						      <!-- <legend>특정 상품의 판매를 목적으로 하는 페이지</legend> -->
						      <div class="form-check">
						        <label class="form-check-label">
						          <input class="form-check-input" type="checkbox" id="isWebsitePurposeOfPurchase" style="font-family: NANUMBARUNPENR !important;font-size: 14px;">
						          페이지가 특정 상품의 판매를 목적으로 하는 경우 이 체크란을 반드시 클릭해주세요. 
						        </label>
						      </div>

						    </fieldset>
						   						
						   						
						  					 	<datalist id="tickmarks">
								    				<c:forEach var="i" begin="10" end="100" step="10">
								    					<option value="${ i }">
								    				</c:forEach>							    						
								    			</datalist>
						    
						      <div class="form-group" style="font-family: NANUMBARUNPENR !important;font-size: 14px;">
							    <label for="formControlRange">1회 노출단가 결정: ￦<span id="rangeSpan">50</span>  </label>
							    <input type="range" class="form-control-range" id="exposureRange" min="10" max="100" value="50" step="10" list="tickmarks" >
							   						 
							    <small id="exposureRange" class="form-text text-muted">범위는 ￦10 ~ ￦100 내에서 설정 가능하며, 단가가 높을수록 추가 혜택이 높아집니다.</small> 
							    					
							  </div>
							  
							  <div class="form-group" style="font-family: NANUMBARUNPENR !important;font-size: 14px;">
								  <fieldset>
								    <label class="control-label" for="exposureCount">총 노출횟수</label>
								    <input class="form-control" id="exposureCount" type="text" placeholder="Readonly input here…" readonly >
								    <small  class="form-text text-muted">총 노출횟수는 노출단가에 의해 결정되며 다음 공식으로 산정됩니다. [노출단가 * 500]</small> 
								  </fieldset>
								</div>
							  
							    <div class="form-group" style="font-family: NANUMBARUNPENR !important;font-size: 14px;">
								  <fieldset>
								    <label class="control-label" for="costPerClick">클릭당 단가(￦)</label>
								    <input class="form-control" id="costPerClick" type="text" placeholder="Readonly input here…" readonly >
								    <small class="form-text text-muted">클릭당 단가는 노출단가에 의해 결정되며 다음 공식으로 산정됩니다. [200 * (1 - 노출단가 / 500)]</small> 
								  </fieldset>
								</div>
								
								<div class="form-group" style="font-family: NANUMBARUNPENR !important;font-size: 14px;">
								  <fieldset>
								    <label class="control-label" for="costPerClick">총 결제금액(￦)</label>
								    <input class="form-control" id="totalCost" type="text" placeholder="Readonly input here…" readonly >
								    <small class="form-text text-muted">총 결제금액은 다음 공식으로 산정됩니다.[총 노출단가 + 보증비 20% 가산],
								    	<br>광고가 거부된 경우 총 결제금액은 매월 첫째 주 월요일에 일괄 환급되며,
								    	<br>광고가 허용된 겨우 보증비는 광고 집행이 정상적으로 종료되었을 때 환급됩니다.</small> 
								  </fieldset>
								</div>
						</div>
					</div>
					</form>
			
				</div>
				<div class="modal-footer">
					<button id="bizconfirm" class="btn btn-light text-dark" style="font-weight:bold;font-family: NANUMBARUNPENR !important;" data-dismiss="modal">확인</button>
					
				</div>
			</div>
		</div>
	</div>
	</c:if>
	<!--        비즈니스설정 Modal 끝-->
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC3SwWm3c4UTbg1SPZD4hHj4E9tz30W2eY&libraries=places&callback=initAutocomplete" async defer></script>

	<script>
      var map;
      var i = 1;
      function placemodal() {
          
          $('#placeModal').modal('show');
//           if(i == 1){
//               if (navigator.geolocation) {
//                   navigator.geolocation.getCurrentPosition(function(position) {
//                         var pos = {
//                           lat: position.coords.latitude,
//                           lng: position.coords.longitude
//                         };

//                         map.setCenter(pos);
//                   });
//                 } else {
//                   alert("현재위치를 표시할 수 없습니다.");
//                 }
//           }
          
          i++;
      }
      
      
      
      function initAutocomplete() {
          map = new google.maps.Map(document.getElementById('map'), {
          center: {lat: 36.082402, lng: 128.088226},
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
                  $("#placetag").val(place.name);
                  var pos1 = {
                    lat: marker.getPosition().lat(),
                    lng: marker.getPosition().lng()
                  };
                  
                  $("#lat").val(pos1.lat);
                  $("#lng").val(pos1.lng);
                  
                  map.setCenter(pos1);
                  $('#placeModal').modal('hide');
             });
          });
         
          map.fitBounds(bounds);
        });
      }
      
      function bizModal() {
          
          $('#bizModal').modal('show');
          
      }
      

    </script>
    <%@ include file="include/bottom.jsp"%>