<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="include/top.jsp"%>
    <link rel="stylesheet" type="text/css" href="resources/css/search.css">
    <div id="allwrapper">
		<div id="centerwrapper">
			<div class="container" id="contents">

				<!-- choose문 시작하는 지점 -->
				<c:choose>
					<c:when test="${result.size() > 0}">

						<div class="card-columns">
							<c:forEach var="result" items="${result}" varStatus="status">
								<div class="card">
									<h4 class="card-title" id="searchTop">
										<img
											src="https://scontent-icn1-1.cdninstagram.com/vp/7c370096e65b401d7c23388739c4f142/5C09D614/t51.2885-19/s150x150/37329457_1608380405938260_7561205846328213504_n.jpg"
											width="30" class="rounded-circle"> <a>${result.id}
											<i id="icon" class="far fa-bookmark"></i>
											<i id="icon" class="far fa-heart"></i>
										</a> <a href="#">팔로우</a>
									</h4>
									<c:forEach begin="0" end="0" var="media" items="${result2[status.index]}">
										<a href="#"> <!--src='AttachedMedia/${media.system_file_name}'-->
											<img class="card-img-top"
											src='AttachedMedia/${media.system_file_name}'
											alt="Card image cap"></a>
									</c:forEach>
								</div>
							</c:forEach>
						</div>
					</c:when>

					<c:otherwise>
						<h1>검색 결과가 없습니다.</h1>
					</c:otherwise>

				</c:choose>
				<!-- choose문 끝나는 지점 -->
			</div>
		</div>
		</div>
      <%@ include file="include/bottom.jsp"%>