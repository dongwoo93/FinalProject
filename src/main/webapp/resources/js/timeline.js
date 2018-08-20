	function follow() {
		
	}
	
	function unFollow(id1, id2) {
		var id = id1;
		var targetId = id2;
		$.ajax({
    		url : "deletefollow.do",
    		type : "post",
    		data : {
    			id : id,
    			targetId : targetId,
    		},
    		success : function(resp) {
    			alert(resp);
    			$(location).attr("href","feed.bo");
    			
    		},
    		error : function() {
    			console.log("에러 발생!");
    			}
    		})
	}
	
	function copyToClipboard(value) {
		$("#changeBoardModal").modal('hide');
		var tempInput = document.createElement("input");
	    tempInput.style = "position: absolute; left: -1000px; top: -1000px";
	    tempInput.value = value;
	    document.body.appendChild(tempInput);
	    tempInput.focus();
	    tempInput.select();
	    document.execCommand("copy");
	    document.body.removeChild(tempInput);
	    alert("링크를 클립보드에 복사했습니다.");
	}
	
	function reportToAdmin(seq, code) {
		var b_seq = seq;
		var report_code = code;
		var comment = $("#reportcomment").val();
	    	$.ajax({
	    		url : "send.admin",
	    		type : "post",
	    		data : {
	    			boardSeq : b_seq,
	    			reportCode : report_code,
	    			reportersComment : comment
	    		},
	    		success : function(resp) {
	    			alert(resp);
	    			$("#changeBoardModal").modal("hide");
	    		},
	    		error : function() {
	    			console.log("에러 발생!");
	    			}
	    		})
	}
	
	function blockMember(id1, id2) {
		var id = id1;
		var targetId = id2;
		$.ajax({
    		url : "block.mem",
    		type : "post",
    		data : {
    			id : id,
    			target_id : targetId
    		},
    		success : function(resp) {
    			alert(resp);
    			$("#changeBoardModal").modal("hide");
    			
    		},
    		error : function() {
    			console.log("에러 발생!");
    		}
		})
    			
	}

	var board_seq;
    var board_id;
    
    function modal0(e) {
    	var myvar = '<div class="modal-dialog modal-dialog-centered" role="document">'+
    	'  			<input type=hidden id=modalseq>'+
    	'  			    <div class="modal-content cons">'+
    	'               <div class="modal-body">'+
    	'                  <a class="dropdown-item mo1" onclick="goBoard()">게시물로 이동</a>'+
    	'                  <div class="dropdown-divider" ></div>'+
    	'                  <a class="dropdown-item mo1" onclick="modal2(this)">부적절한 컨텐츠 신고</a>'+
    	'                  <div class="dropdown-divider" ></div>'+
    	'                  <a class="dropdown-item mo1" onclick="copyToClipboard(&#34;http://localhost:8080/controller/oneBoard.do?board_seq='+board_seq+'&#34;)">링크 복사</a>'+
    	'                  <div class="dropdown-divider" ></div> '+
    	'                  <a class="dropdown-item mo1" onclick="unFollow(&#34;'+currentId+'&#34;,&#34;'+board_id+'&#34;)">팔로우 취소</a>   '+
    	'                  '+
    	'               </div>'+
    	'               <div class="modal-footer">'+
    	'                  <button type="button" class="btn btn-outline-primary footertbtn"'+
    	'                     data-dismiss="modal">Close</button>'+
    	'               </div>'+
    	'            </div>'+
    	'         '+
    	'   </div>';
    	
    	$("#changeBoardModal").html(myvar);
    	
    	$("#modalseq").val(board_seq);
    	$("#modalid").val(board_id);
    }
    
    function modal(e) {
    	board_seq = $(e).attr("value").split(":")[0];
		board_id = $(e).attr("value").split(":")[1];
    	var myvar = '<div class="modal-dialog modal-dialog-centered" role="document">'+
    	'  			<input type=hidden id=modalseq>'+
    	'  			    <div class="modal-content cons">'+
    	'               <div class="modal-body">'+
    	'                  <a class="dropdown-item mo1" onclick="goBoard()">게시물로 이동</a>'+
    	'                  <div class="dropdown-divider" ></div>'+
    	'                  <a class="dropdown-item mo1" onclick="modal2(this)">부적절한 컨텐츠 신고</a>'+
    	'                  <div class="dropdown-divider" ></div>'+
    	'                  <a class="dropdown-item mo1" onclick="copyToClipboard(&#34;http://localhost:8080/controller/oneBoard.do?board_seq='+board_seq+'&#34;)">링크 복사</a>'+
    	'                  <div class="dropdown-divider" ></div> '+
    	'                  <a class="dropdown-item mo1" onclick="unFollow(&#34;'+currentId+'&#34;,&#34;'+board_id+'&#34;)">팔로우 취소</a>   '+
    	'                  '+
    	'               </div>'+
    	'               <div class="modal-footer">'+
    	'                  <button type="button" class="btn btn-outline-primary footertbtn"'+
    	'                     data-dismiss="modal">Close</button>'+
    	'               </div>'+
    	'            </div>'+
    	'         '+
    	'   </div>';
    	
    	$("#changeBoardModal").html(myvar);
    	
    	$("#modalseq").val(board_seq);
    	$("#modalid").val(board_id);
    	$("#changeBoardModal").modal();
    }
    
    function modal2(e) {
    	var myvar = '<div class="modal-dialog modal-dialog-centered" role="document">'+
    	'               <input type=hidden id=modalid>'+
    	'  			    <div class="modal-content cons">'+
    	'  			    <div class="modal-header">'+
    	'  			    <button onclick="modal0(this)" type="button" class="btn btn-outline-primary headbtn">&#60;</button>'+
    	'          			<h5 class="modal-title titletext">신고</h4>'+
    	'        		</div>'+
    	'               <div class="modal-body mbody">'+
    	'                <div><h6 id="report-head" style="color: #999;">이 게시물을 신고하는 이유를 선택하세요. 신고자 정보는 <span style="color: #000; font-weight: 600;">'+board_id+'</span>님에게 공개되지 않습니다.</h6></div>'+
    	'                  <a class="dropdown-item mo item" onclick="modal3(this)">그냥 마음에 들지 않습니다</a>'+
    	'                  <a class="dropdown-item mo item"  onclick="reportToAdmin(&#34;'+board_seq+'&#34;,&#34;1&#34;)">스팸입니다</a>'+
    	'                  <a class="dropdown-item mo item" onclick="modal4(this)">신체 노출, 나체 게시물 및 음란물</a>'+
    	'                  <a class="dropdown-item mo item" onclick="modal5(this)">편파적 발언 및 상징</a>'+
    	'                  <a class="dropdown-item mo item" onclick="modal6(this)">기타</a>'+
    	'                  '+
    	'               </div>'+
    	'               <div class="modal-footer">'+
    	'                  <button type="button" class="btn btn-outline-primary footertbtn"'+
    	'                     data-dismiss="modal">Close</button>'+
    	'               </div>'+
    	'            </div>'+
    	'        </div>';
    	$("#changeBoardModal").html(myvar);
    		

    }
    function modal3(e) {

    	var myvar = '<div class="modal-dialog modal-dialog-centered" role="document">'+
    	'  			<input type=hidden id=modalid>'+
    	'  			    <div class="modal-content cons">'+
    	'  			    <div class="modal-header">'+
    	'  			    <button onclick="modal2(this)" type="button" class="btn btn-outline-primary headbtn">&#60;</button>'+
    	'          			<h5 class="modal-title titletext">신고</h4>'+
    	'        		</div>'+
    	'               <div class="modal-body mbody">'+
    	'                <div>'+
    	'                <p style="font-weight: bold;">이 프로필이 마음에 들지 않으시나요?</p>'+
    	'                <p class="p_text"><span style="color: #000; font-weight: 600;">'+board_id+'</span>님의 팔로우를 취소하면 상대방의 사진, 동영상 또는 스토리가 회원님의 피드에 더 이상 표시되지 않습니다.</p>'+
    	'                </div>'+
    	'                <button onclick="unFollow(&#34;'+currentId+'&#34;,&#34;'+board_id+'&#34;)" type="button" class="btn btn-primary" style="width: 100%">팔로우 취소</button>'+
    	'                <br>'+
    	'                <br>'+
    	'               <div class="dropdown-divider" ></div>   '+
    	'                  <p class="p_text"><span style="color: #000; font-weight: 600;">'+board_id+'</span>님이 회원님의 사진, 동영상 또는 스토리를 볼 수 없게 하거나 Instagram에서 회원님을 검색할 수 없도록 하려면 차단하세요.</p>'+
    	'                  <button type="button" class="btn btn-primary" style="width: 100%" onclick="blockMember(&#34;'+currentId+'&#34;,&#34;'+board_id+'&#34;)">차단</button>'+
    	'                  '+
    	'               </div>'+
    	'               <div class="modal-footer">'+
    	'                  <button type="button" class="btn btn-outline-primary footertbtn"'+
    	'                     data-dismiss="modal">Close</button>'+
    	'               </div>'+
    	'            </div>'+
    	'         '+
    	'   </div>';
    		

    	$("#changeBoardModal").html(myvar);
    }
    
    function modal4(e) {

    	var myvar = '<div class="modal-dialog modal-dialog-centered" role="document">'+
    	'  			<input type=hidden id=modalid>'+
    	'  			    <div class="modal-content cons">'+
    	'  			    <div class="modal-header">'+
    	'  			    <button onclick="modal2(this)" type="button" class="btn btn-outline-primary headbtn">&#60;</button>'+
    	'          			<h5 class="modal-title titletext">신고</h4>'+
    	'        		</div>'+
    	'               <div class="modal-body mbody">'+
    	'                <div style="text-align: left;">'+
    	'                <p style="color: #262626; font-weight: 600; margin-bottom: 8px;">나체 이미지 또는 음란물로 신고할까요?</p>'+
    	'                <p class="p_text" style="margin-bottom: 8px;">삭제 대상:</p>'+
    	'                <ul class="p_text" style="list-style-type: disc; margin: 0 0 8px -5px;">'+
    	'                <li style="margin-bottom: 8px;">성관계가 포함된 사진 또는 동영상</li>'+
    	'                <li style="margin-bottom: 8px;">성관계, 성기 또는 완전히 노출된 둔부의 확대 게시물</li>'+
    	'                <li style="margin-bottom: 8px;">아동의 나체 또는 부분 나체가 포함된 게시물</li>'+
    	'                </ul>'+
    	'                <p class="p_text" style="margin-bottom: 8px;">다른 사람의 게시물을 신고해도 신고자에 대한 정보는 공개되지 않습니다.</p>'+
    	'                <p class="p_text" style="margin-bottom: 8px;">누군가 위급한 위험 상황에 처해 있다면 신속하게 현지 응급 서비스 기관에 연락하세요.</p>'+
    	'                <textarea id="reportcomment" class="form-control" aria-label="With textarea"></textarea>'+
    	'                <br>'+
    	'                <button type="button" class="btn btn-primary" style="width: 100%" onclick="reportToAdmin(&#34;'+board_seq+'&#34;,&#34;2&#34;)">제출</button>'+
    	'                </div>'+
    	'               </div>'+
    	'               <div class="modal-footer">'+
    	'                  <button type="button" class="btn btn-outline-primary footertbtn"'+
    	'                     data-dismiss="modal">Close</button>'+
    	'               </div>'+
    	'            </div>'+
    	'         '+
    	'   </div>';
    		

    	$("#changeBoardModal").html(myvar);
    }
    
    function modal5(e) {
    	var myvar = '<div class="modal-dialog modal-dialog-centered" role="document">'+
    	'  			<input type=hidden id=modalid>'+
    	'  			    <div class="modal-content cons">'+
    	'  			    <div class="modal-header">'+
    	'  			    <button onclick="modal2(this)" type="button" class="btn btn-outline-primary headbtn">&#60;</button>'+
    	'          			<h5 class="modal-title titletext">신고</h4>'+
    	'        		</div>'+
    	'               <div class="modal-body mbody">'+
    	'                <div style="text-align: left;">'+
    	'                <p style="color: #262626; font-weight: 600; margin-bottom: 8px;">편파적 발언 또는 상징으로 신고할까요?</p>'+
    	'                <p class="p_text" style="margin-bottom: 8px;">삭제 대상:</p>'+
    	'                <ul class="p_text" style="list-style-type: disc; margin: 0 0 8px -5px;">'+
    	'                <li style="margin-bottom: 8px;">나치 상징(하켄크로이츠)이나 백인 우월주의를 나타내는 손 모양 등 편파적 발언 또는 상징에 관한 사진</li>'+
    	'                <li style="margin-bottom: 8px;">폭력을 조장하거나 사람의 정체성을 바탕으로 공격하는 내용의 게시물</li>'+
    	'                <li style="margin-bottom: 8px;">신체적 상해, 절도 또는 기물 파손에 대한 협박</li>'+
    	'                </ul>'+
    	'                <p class="p_text" style="margin-bottom: 8px;">다른 사람의 게시물을 신고해도 신고자에 대한 정보는 공개되지 않습니다.</p>'+
    	'                <p class="p_text" style="margin-bottom: 8px;">누군가 위급한 위험 상황에 처해 있다면 신속하게 현지 응급 서비스 기관에 연락하세요.</p>'+
    	'                <textarea id="reportcomment" class="form-control" aria-label="With textarea"></textarea>'+
    	'                <br>'+
    	'                <button type="button" class="btn btn-primary" style="width: 100%" onclick="reportToAdmin(&#34;'+board_seq+'&#34;,&#34;3&#34;)">제출</button>'+
    	'                </div>'+
    	'               </div>'+
    	'               <div class="modal-footer">'+
    	'                  <button type="button" class="btn btn-outline-primary footertbtn"'+
    	'                     data-dismiss="modal">Close</button>'+
    	'               </div>'+
    	'            </div>'+
    	'         '+
    	'   </div>';
    		

    	$("#changeBoardModal").html(myvar);
    }
    
    function modal6(e) {

    	var myvar = '<div class="modal-dialog modal-dialog-centered" role="document">'+
    	'  			<input type=hidden id=modalseq>'+
    	'  			    <div class="modal-content cons">'+
    	'  			    <div class="modal-header">'+
    	'  			    <button onclick="modal2(this)" type="button" class="btn btn-outline-primary headbtn">&#60;</button>'+
    	'          			<h5 class="modal-title titletext">신고</h4>'+
    	'        		</div>'+
    	'               <div class="modal-body mbody"> '+
    	'                  <a class="dropdown-item mo" onclick="modal7(this)">폭력 또는 폭력 위협</a>'+
    	'                  <div class="dropdown-divider" ></div>'+
    	'                  <a class="dropdown-item mo" onclick="modal8(this)">마약 판매 및 홍보</a>'+
    	'                  <div class="dropdown-divider" ></div>'+
    	'                  <a class="dropdown-item mo" onclick="modal9(this)">괴롭힘 및 따돌림</a>'+
    	'                  <div class="dropdown-divider" ></div> '+
    	'                  <a class="dropdown-item mo" onclick="modal10(this)">지적 재산권 침해</a>'+
    	'                  <div class="dropdown-divider" ></div> '+
    	'                  <a class="dropdown-item mo" onclick="modal11(this)">스스로 신체적 상해를 입히는 행위</a> '+
    	'                  '+
    	'               </div>'+
    	'               <div class="modal-footer">'+
    	'                  <button type="button" class="btn btn-outline-primary footertbtn"'+
    	'                     data-dismiss="modal">Close</button>'+
    	'               </div>'+
    	'            </div> '+
    	'   </div>';
    	
    	$("#changeBoardModal").html(myvar);
    }
    
    function modal7(e) {
    	var myvar = '<div class="modal-dialog modal-dialog-centered" role="document">'+
    	'  			<input type=hidden id=modalid>'+
    	'  			    <div class="modal-content cons">'+
    	'  			    <div class="modal-header">'+
    	'  			    <button onclick="modal6(this)" type="button" class="btn btn-outline-primary headbtn">&#60;</button>'+
    	'          			<h5 class="modal-title titletext">신고</h4>'+
    	'        		</div>'+
    	'               <div class="modal-body mbody">'+
    	'                <div style="text-align: left;">'+
    	'                <p style="color: #262626; font-weight: 600; margin-bottom: 8px;">폭력 또는 폭력 위협으로 신고하시겠어요?</p>'+
    	'                <p class="p_text" style="margin-bottom: 8px;">삭제 대상:</p>'+
    	'                <ul class="p_text" style="list-style-type: disc; margin: 0 0 8px -5px;">'+
    	'                <li style="margin-bottom: 8px;">극단적이고 사실적인 폭력 장면의 사진 또는 동영상</li>'+
    	'                <li style="margin-bottom: 8px;">폭력을 조장하거나 종교, 인종/문화적 또는 성적 배경을 바탕으로 상대방을 공격하는 게시물</li>'+
    	'                <li style="margin-bottom: 8px;">신체적 상해, 절도, 기물 파손 또는 금전적 피해에 대한 협박</li>'+
    	'                </ul>'+
    	'                <p class="p_text" style="margin-bottom: 8px;">다른 사람의 게시물을 신고해도 신고자에 대한 정보는 공개되지 않습니다.</p>'+
    	'                <p class="p_text" style="margin-bottom: 8px;">누군가 위급한 위험 상황에 처해 있다면 신속하게 현지 응급 서비스 기관에 연락하세요.</p>'+
    	'                <textarea id="reportcomment" class="form-control" aria-label="With textarea"></textarea>'+
    	'                <br>'+
    	'                <button type="button" class="btn btn-primary" style="width: 100%" onclick="reportToAdmin(&#34;'+board_seq+'&#34;,&#34;4&#34;)">제출</button>'+
    	'                </div>'+
    	'               </div>'+
    	'               <div class="modal-footer">'+
    	'                  <button type="button" class="btn btn-outline-primary footertbtn"'+
    	'                     data-dismiss="modal">Close</button>'+
    	'               </div>'+
    	'            </div>'+
    	'         '+
    	'   </div>';
    		

    	$("#changeBoardModal").html(myvar);
    }
    
    function modal8(e) {
    	var myvar = '<div class="modal-dialog modal-dialog-centered" role="document">'+
    	'  			<input type=hidden id=modalid>'+
    	'  			    <div class="modal-content cons">'+
    	'  			    <div class="modal-header mbody">'+
    	'  			    <button onclick="modal6(this)" type="button" class="btn btn-outline-primary headbtn">&#60;</button>'+
    	'          			<h5 class="modal-title titletext">신고</h4>'+
    	'        		</div>'+
    	'               <div class="modal-body">'+
    	'                <div style="text-align: left;">'+
    	'                <p style="color: #262626; font-weight: 600; margin-bottom: 8px;">마약 판매 또는 홍보로 신고할까요?</p>'+
    	'                <p class="p_text" style="margin-bottom: 8px;">삭제 대상:</p>'+
    	'                <ul class="p_text" style="list-style-type: disc; margin: 0 0 8px -5px;">'+
    	'                <li style="margin-bottom: 8px;">중독성이 강한 약물 또는 마약 남용을 조장하는 게시물</li>'+
    	'                <li style="margin-bottom: 8px;">마약을 판매하거나 배포하려는 게시물</li>'+
    	'                </ul>'+
    	'                <p class="p_text" style="margin-bottom: 8px;">다른 사람의 게시물을 신고해도 신고자에 대한 정보는 공개되지 않습니다.</p>'+
    	'                <p class="p_text" style="margin-bottom: 8px;">누군가 위급한 위험 상황에 처해 있다면 신속하게 현지 응급 서비스 기관에 연락하세요.</p>'+
    	'                <textarea id="reportcomment" class="form-control" aria-label="With textarea"></textarea>'+
    	'                <br>'+
    	'                <button type="button" class="btn btn-primary" style="width: 100%" onclick="reportToAdmin(&#34;'+board_seq+'&#34;,&#34;5&#34;)">제출</button>'+
    	'                </div>'+
    	'               </div>'+
    	'               <div class="modal-footer">'+
    	'                  <button type="button" class="btn btn-outline-primary footertbtn"'+
    	'                     data-dismiss="modal">Close</button>'+
    	'               </div>'+
    	'            </div>'+
    	'         '+
    	'   </div>';
    		

    	$("#changeBoardModal").html(myvar);
    }
    
    function modal9(e) {
    	var myvar = '<div class="modal-dialog modal-dialog-centered" role="document">'+
    	'  			<input type=hidden id=modalid>'+
    	'  			    <div class="modal-content cons">'+
    	'  			    <div class="modal-header">'+
    	'  			    <button onclick="modal6(this)" type="button" class="btn btn-outline-primary headbtn">&#60;</button>'+
    	'          			<h5 class="modal-title titletext">신고</h4>'+
    	'        		</div>'+
    	'               <div class="modal-body mbody">'+
    	'                <div style="text-align: left;">'+
    	'                <p style="color: #262626; font-weight: 600; margin-bottom: 8px;">괴롭힘 또는 따돌림으로 신고하시겠어요?</p>'+
    	'                <p class="p_text" style="margin-bottom: 8px;">삭제 대상:</p>'+
    	'                <ul class="p_text" style="list-style-type: disc; margin: 0 0 8px -5px;">'+
    	'                <li style="margin-bottom: 8px;">폭력 행사 위협이 담긴 게시물</li>'+
    	'                <li style="margin-bottom: 8px;">타인을 모욕하거나 수치스럽게 할 의도가 담긴 콘텐츠</li>'+
    	'                <li style="margin-bottom: 8px;">협박 또는 괴롭힘을 목적으로 개인 정보 공유</li>'+
    	'                </ul>'+
    	'                <p class="p_text" style="margin-bottom: 8px;">다른 사람의 게시물을 신고해도 신고자에 대한 정보는 공개되지 않습니다.</p>'+
    	'                <p class="p_text" style="margin-bottom: 8px;">누군가 위급한 위험 상황에 처해 있다면 신속하게 현지 응급 서비스 기관에 연락하세요.</p>'+
    	'                <textarea id="reportcomment" class="form-control" aria-label="With textarea"></textarea>'+
    	'                <br>'+
    	'                <button type="button" class="btn btn-primary" style="width: 100%" onclick="reportToAdmin(&#34;'+board_seq+'&#34;,&#34;6&#34;)">제출</button>'+
    	'                </div>'+
    	'               </div>'+
    	'               <div class="modal-footer">'+
    	'                  <button type="button" class="btn btn-outline-primary footertbtn"'+
    	'                     data-dismiss="modal">Close</button>'+
    	'               </div>'+
    	'            </div>'+
    	'         '+
    	'   </div>';
    		

    	$("#changeBoardModal").html(myvar);
    }
    
    function modal10(e) {
    	var myvar = '<div class="modal-dialog modal-dialog-centered" role="document">'+
    	'  			<input type=hidden id=modalid>'+
    	'  			    <div class="modal-content cons">'+
    	'  			    <div class="modal-header">'+
    	'  			    <button onclick="modal6(this)" type="button" class="btn btn-outline-primary headbtn">&#60;</button>'+
    	'          			<h5 class="modal-title titletext">신고</h4>'+
    	'        		</div>'+
    	'               <div class="modal-body mbody">'+
    	'                <div style="text-align: left;">'+
    	'                <p style="color: #262626; font-weight: 600; margin-bottom: 8px;">지적 재산권 침해로 신고할까요?</p>'+
    	'                <p class="p_text" style="margin-bottom: 8px;">저작권 및 상표권을 침해하는 게시물은 삭제됩니다. 만약 누군가 자신의 허가 없이 사진을 도용하거나 사칭하는 경우에도 해당 콘텐츠는 삭제되며, 도용 및 사칭한 계정은 비활성화될 수 있습니다. 지적 재산권 침해 신고에 대한 자세한 정보는 고객 센터를 방문하세요.</p>'+
    	'                <textarea id="reportcomment" class="form-control" aria-label="With textarea"></textarea>'+
    	'                <br>'+
    	'                <button type="button" class="btn btn-primary" style="width: 100%" onclick="reportToAdmin(&#34;'+board_seq+'&#34;,&#34;7&#34;)">제출</button>'+
    	'                </div>'+
    	'               </div>'+
    	'               <div class="modal-footer">'+
    	'                  <button type="button" class="btn btn-outline-primary footertbtn"'+
    	'                     data-dismiss="modal">Close</button>'+
    	'               </div>'+
    	'            </div>'+
    	'         '+
    	'   </div>';
    		

    	$("#changeBoardModal").html(myvar);
    }
    
    function modal11(e) {
    	var myvar = '<div class="modal-dialog modal-dialog-centered" role="document">'+
    	'  			<input type=hidden id=modalid>'+
    	'  			    <div class="modal-content cons">'+
    	'  			    <div class="modal-header">'+
    	'  			    <button onclick="modal6(this)" type="button" class="btn btn-outline-primary headbtn">&#60;</button>'+
    	'          			<h5 class="modal-title titletext">신고</h4>'+
    	'        		</div>'+
    	'               <div class="modal-body mbody">'+
    	'                <div style="text-align: left;">'+
    	'                <p style="color: #262626; font-weight: 600; margin-bottom: 8px;">스스로 신체적 상해를 입히는 행위로 신고하시겠어요?</p>'+
    	'                <p class="p_text" style="margin-bottom: 8px;">자살, 자해, 섭식 장애를 포함하여 스스로 신체적 상해를 입히는 행위를 유도하거나 조장하는 게시물은 삭제됩니다. 또한 스스로 신체적 상해를 입히는 당사자의 신분을 노출하여 공격하거나 조롱하는 게시물도 삭제될 수 있습니다.</p>'+
    	'                <p class="p_text" style="margin-bottom: 8px;">다른 사람의 게시물을 신고해도 신고자에 대한 정보는 공개되지 않습니다.</p>'+
    	'                <p class="p_text" style="margin-bottom: 8px;">누군가 위급한 위험 상황에 처해 있다면 신속하게 현지 응급 서비스 기관에 연락하세요.</p>'+
    	'                <textarea id="reportcomment" class="form-control" aria-label="With textarea"></textarea>'+
    	'                <br>'+
    	'                <button type="button" class="btn btn-primary" style="width: 100%" onclick="reportToAdmin(&#34;'+board_seq+'&#34;,&#34;8&#34;)">제출</button>'+
    	'                </div>'+
    	'               </div>'+
    	'               <div class="modal-footer">'+
    	'                  <button type="button" class="btn btn-outline-primary footertbtn"'+
    	'                     data-dismiss="modal">Close</button>'+
    	'               </div>'+
    	'            </div>'+
    	'         '+
    	'   </div>';
    		

    	$("#changeBoardModal").html(myvar);
    }