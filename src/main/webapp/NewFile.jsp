<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include/top.jsp"%>
<link rel="stylesheet" type="text/css" href="resources/css/search.css">


<div id="allwrapper">
	<div id="centerwrapper">
		<div class="container" id="contents">

<c:choose>
<c:when test="${result.size() <0}">
	<h1>검색 결과가 없습니다.</h1>
</c:when>
<c:when test="${result.size() >4 }">
		<div class="card-columns">
<c:forEach var="result" items="${result}" varStatus="status">
					<div class="card" id="card">
						<h4 class="card-title" id="searchTop">
							<img src="루이.jpg" alt="Card image cap" width="30" height="30" class="rounded-circle">
								<a id="ids" href="board.bo?id=${result.id}&cat=1">${result.id}</a>
									<!-- 북마크 -->  
								<c:choose> 
										<c:when test="${bookmark.containsKey(result.board_seq)}">

												<i value="${result.board_seq}" id="mark"
													class="far fa-bookmark icon pointer" style="display: none;"
													onclick="markit(this)"></i>
												<i value="${result.board_seq}"
													style="font-weight: bold; color: #00B8D4;" id="markcancel"
													class="far fa-bookmark icon pointer"
													onclick="unmarkit(this)"></i>

											</c:when>
											<c:otherwise>  

												<i value="${result.board_seq}" id="mark"
													class="far fa-bookmark icon pointer" onclick="markit(this)"></i>
												<i value="${result.board_seq}"
													style="font-weight: bold; color: #00B8D4; display: none;"
													id="markcancel" class="far fa-bookmark icon pointer"
													onclick="unmarkit(this)"></i>

											</c:otherwise>
									    </c:choose>   
									
									<!-- 좋아요 -->
									<c:choose>
										<c:when test="${result3.containsKey(result.board_seq)}">
											<i value="${result.board_seq}" style="cursor: pointer; display: none;" 
												id="likeit" class="far fa-heart icon mr-1" onclick="likeit(this)"></i>
											<i value="${result.board_seq}" style="color: red; cursor: pointer;" 
												id="likecancel" class="fas fa-heart" onclick="unlikeit(this)"></i>
											<!-- 좋아요 카운트 -->
											<c:choose>
												<c:when test="${result4[result.board_seq] != null}">
													<p id="p">
														<i value="${result.board_seq}" id="count${result.board_seq}">
															<c:out value="${result4[result.board_seq]}"/>명이 좋아합니다
														</i>
													</p>
												</c:when>
													<c:otherwise>
														<p id="p">
															<i value="${result.board_seq}" id="count${result.board_seq}">
																<c:out value="${result4[result.board_seq]}"/>
															</i>
														</p>
													</c:otherwise>
											</c:choose>
										</c:when>
											<c:otherwise>   
												<i value="${result.board_seq}" style="cursor: pointer;" id="likeit" 
													class="far fa-heart icon mr-1" 
													onclick="likeit(this)"></i>
			                   					<i value="${result.board_seq}" style="color: red; display: none; cursor: pointer;" 
			                   						id="likecancel" class="fas fa-heart" 
			                   						onclick="unlikeit(this)"></i>
												<!-- 좋아요 카운트 -->
												<c:choose>
													<c:when test="${result4[result.board_seq] != null}">
														<p id="p">
															<i value="${result.board_seq}" id="count${result.board_seq}">
																<c:out value="${result4[result.board_seq]}"/>명이 좋아합니다
															</i>
														</p>
													</c:when>
														<c:otherwise>
															<p id="p">
																<i value="${result.board_seq}" id="count${result.board_seq}">
																	<c:out value="${result4[result.board_seq]}"/>
																</i>
															</p>
														</c:otherwise>
												</c:choose>
											</c:otherwise>
									</c:choose>	
							</h4> <div class="dropdown-divider"  id="modifydiv"></div>
								<!-- 태그,글 보이기 -->
								<div class="hidden" style="padding-left: 5px" id="hidden${result.board_seq}">
									<script> $("#myContents${result.board_seq}").attr("style","overflow:visible"); </script>
										<p id="myContents${result.board_seq}">${result.contents}</p>
											<script>    
												var text = $("#myContents${result.board_seq}").html();  
												var regex = /(#[^#\s,;]+)/gi  ;              
												var newtxt;
				  								if(txt != null) {
				  									 newtxt = txt.replace(regex, "<a onclick='tag(this)' style='color:red ; cursor: pointer;'>"+"$1"+"</a>");
				  								}        
			  							        $("#myContents${result.board_seq}").html(newtxt);
											</script>
								</div>
									<!-- 이미지 -->
								<c:forEach begin="0" end="0" var="media" items="${result2[status.index]}">
									<a href="#" > <!--src='AttachedMedia/${media.system_file_name}'-->
										<img class="card-img-top" id="card"
											src='AttachedMedia/${media.system_file_name}' 
											alt="Card image cap">
									</a>
								</c:forEach>
					</div>
				</c:forEach>
				</div>
</c:when>
<c:otherwise>  
<div class="row">
<c:forEach var="result" items="${result}" varStatus="status">
<div class="col-md-4">            
					<div class="card" id="card">
						<h4 class="card-title" id="searchTop">
							<img src="루이.jpg" alt="Card image cap" width="30" height="30" class="rounded-circle">
								<a id="ids" href="board.bo?id=${result.id}&cat=1">${result.id}</a>
									<!-- 북마크 -->  
								<c:choose> 
										<c:when test="${bookmark.containsKey(result.board_seq)}">

												<i value="${result.board_seq}" id="mark"
													class="far fa-bookmark icon pointer" style="display: none;"
													onclick="markit(this)"></i>
												<i value="${result.board_seq}"
													style="font-weight: bold; color: #00B8D4;" id="markcancel"
													class="far fa-bookmark icon pointer"
													onclick="unmarkit(this)"></i>

											</c:when>
											<c:otherwise>  

												<i value="${result.board_seq}" id="mark"
													class="far fa-bookmark icon pointer" onclick="markit(this)"></i>
												<i value="${result.board_seq}"
													style="font-weight: bold; color: #00B8D4; display: none;"
													id="markcancel" class="far fa-bookmark icon pointer"
													onclick="unmarkit(this)"></i>

											</c:otherwise>
									    </c:choose>   
									
									<!-- 좋아요 -->
									<c:choose>
										<c:when test="${result3.containsKey(result.board_seq)}">
											<i value="${result.board_seq}" style="cursor: pointer; display: none;" 
												id="likeit" class="far fa-heart icon mr-1" onclick="likeit(this)"></i>
											<i value="${result.board_seq}" style="color: red; cursor: pointer;" 
												id="likecancel" class="fas fa-heart" onclick="unlikeit(this)"></i>
											<!-- 좋아요 카운트 -->
											<c:choose>
												<c:when test="${result4[result.board_seq] != null}">
													<p id="p">
														<i value="${result.board_seq}" id="count${result.board_seq}">
															<c:out value="${result4[result.board_seq]}"/>명이 좋아합니다
														</i>
													</p>
												</c:when>
													<c:otherwise>
														<p id="p">
															<i value="${result.board_seq}" id="count${result.board_seq}">
																<c:out value="${result4[result.board_seq]}"/>
															</i>
														</p>
													</c:otherwise>
											</c:choose>
										</c:when>
											<c:otherwise>   
												<i value="${result.board_seq}" style="cursor: pointer;" id="likeit" 
													class="far fa-heart icon mr-1" 
													onclick="likeit(this)"></i>
			                   					<i value="${result.board_seq}" style="color: red; display: none; cursor: pointer;" 
			                   						id="likecancel" class="fas fa-heart" 
			                   						onclick="unlikeit(this)"></i>
												<!-- 좋아요 카운트 -->
												<c:choose>
													<c:when test="${result4[result.board_seq] != null}">
														<p id="p">
															<i value="${result.board_seq}" id="count${result.board_seq}">
																<c:out value="${result4[result.board_seq]}"/>명이 좋아합니다
															</i>
														</p>
													</c:when>
														<c:otherwise>
															<p id="p">
																<i value="${result.board_seq}" id="count${result.board_seq}">
																	<c:out value="${result4[result.board_seq]}"/>
																</i>
															</p>
														</c:otherwise>
												</c:choose>
											</c:otherwise>
									</c:choose>	
							</h4> <div class="dropdown-divider"  id="modifydiv"></div>
								<!-- 태그,글 보이기 -->
								<div class="hidden" style="padding-left: 5px" id="hidden${result.board_seq}">
									<script> $("#myContents${result.board_seq}").attr("style","overflow:visible"); </script>
										<p id="myContents${result.board_seq}">${result.contents}</p>
											<script>    
												var text = $("#myContents${result.board_seq}").html();  
												var regex = /(#[^#\s,;]+)/gi  ;              
												var newtxt;
				  								if(txt != null) {
				  									 newtxt = txt.replace(regex, "<a onclick='tag(this)' style='color:red ; cursor: pointer;'>"+"$1"+"</a>");
				  								}        
			  							        $("#myContents${result.board_seq}").html(newtxt);
											</script>
								</div>
									<!-- 이미지 -->
								<c:forEach begin="0" end="0" var="media" items="${result2[status.index]}">
									<a href="#" > <!--src='AttachedMedia/${media.system_file_name}'-->
										<img class="card-img-top" id="card"
											src='AttachedMedia/${media.system_file_name}' 
											alt="Card image cap">
									</a>
								</c:forEach>
					</div>
					</div>
	
				</c:forEach>
</div>

</c:otherwise>
</c:choose>


</div> <!-- container -->
</div>  <!-- centerwrapperr -->
</div> <!-- allwrapper -->






			<%@ include file="include/bottom.jsp"%>