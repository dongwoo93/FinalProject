var board_seq;
    var board_id;
    
    function modal(e) {
    	
    	var myvar = '<div class="modal-dialog modal-dialog-centered" role="document">'+
    	'  			<input type=hidden id=modalseq>'+
    	'  			    <div class="modal-content">'+
    	'               <div class="modal-body">'+
    	'               <div class="dropdown-divider" ></div>  '+
    	'                  <a class="dropdown-item mo1" href="#">게시물로 이동</a>'+
    	'                  <div class="dropdown-divider" ></div>'+
    	'                  <a class="dropdown-item mo1" onclick="modal2(this)">부적절한 컨텐츠 신고</a>'+
    	'                  <div class="dropdown-divider" ></div>'+
    	'                  <a class="dropdown-item mo1" href="#">링크 복사</a>'+
    	'                  <div class="dropdown-divider" ></div> '+
    	'                  <a class="dropdown-item mo1" href="#">팔로우 취소</a>   '+
    	'                  '+
    	'               </div>'+
    	'               <div class="modal-footer">'+
    	'                  <button type="button" class="btn btn-secondary"'+
    	'                     data-dismiss="modal">Close</button>'+
    	'               </div>'+
    	'            </div>'+
    	'         '+
    	'   </div>';
    	
    	$("#changeBoardModal").html(myvar);
    	board_seq = $(e).attr("value").split(":")[0];
		board_id = $(e).attr("value").split(":")[1];
    	$("#modalseq").val(board_seq);
    	$("#modalid").val(board_id);
    	$("#changeBoardModal").modal();
    }
    
    function modal2(e) {
    	var myvar = '<div class="modal-dialog modal-dialog-centered" role="document">'+
    	'               <input type=hidden id=modalid>'+
    	'  			    <div class="modal-content">'+
    	'  			    <div class="modal-header">'+
    	'          			<h4 class="modal-title">신고</h4>'+
    	'        		</div>'+
    	'               <div class="modal-body">'+
    	'                <div><h6 id="report-head" style="color: #999;">이 게시물을 신고하는 이유를 선택하세요.<br> 신고자 정보는 <span style="color: #000; font-weight: 600;">'+board_id+'</span>님에게 공개되지 않습니다.</h6></div>'+
    	'               <div class="dropdown-divider" ></div>   '+
    	'                  <a class="dropdown-item mo" onclick="modal3(this)">그냥 마음에 들지 않습니다</a>'+
    	'                  <div class="dropdown-divider" ></div>'+
    	'                  <a class="dropdown-item mo"  href="#">스팸입니다</a>'+
    	'                  <div class="dropdown-divider" ></div>'+
    	'                  <a class="dropdown-item mo" onclick="modal4(this)">신체 노출, 나체 게시물 및 음란물</a>'+
    	'                  <div class="dropdown-divider" ></div> '+
    	'                  <a class="dropdown-item mo" href="#">편파적 발언 및 상징</a>'+
    	'                  <div class="dropdown-divider" ></div> '+
    	'                  <a class="dropdown-item mo" href="#">기타</a>'+
    	'                  '+
    	'               </div>'+
    	'               <div class="modal-footer">'+
    	'                  <button type="button" class="btn btn-secondary"'+
    	'                     data-dismiss="modal">Close</button>'+
    	'               </div>'+
    	'            </div>'+
    	'        </div>';
    	$("#changeBoardModal").html(myvar);
    		

    }
    function modal3(e) {

    	var myvar = '<div class="modal-dialog modal-dialog-centered" role="document">'+
    	'  			<input type=hidden id=modalid>'+
    	'  			    <div class="modal-content">'+
    	'  			    <div class="modal-header">'+
    	'          			<h4 class="modal-title">신고</h4>'+
    	'        		</div>'+
    	'               <div class="modal-body">'+
    	'                <div>'+
    	'                <p style="font-weight: bold;">이 프로필이 마음에 들지 않으시나요?</p>'+
    	'                <p class="p_text"><span style="color: #000; font-weight: 600;">'+board_id+'</span>님의 팔로우를 취소하면 상대방의 사진, 동영상 또는 스토리가 회원님의 피드에 더 이상 표시되지 않습니다.</p>'+
    	'                </div>'+
    	'                <button type="button" class="btn btn-primary" style="width: 100%">팔로우 취소</button>'+
    	'                <br>'+
    	'                <br>'+
    	'               <div class="dropdown-divider" ></div>   '+
    	'                  <p class="p_text"><span style="color: #000; font-weight: 600;">'+board_id+'</span>님이 회원님의 사진, 동영상 또는 스토리를 볼 수 없게 하거나 Instagram에서 회원님을 검색할 수 없도록 하려면 차단하세요.</p>'+
    	'                  <button type="button" class="btn btn-primary" style="width: 100%">차단</button>'+
    	'                  '+
    	'               </div>'+
    	'               <div class="modal-footer">'+
    	'                  <button type="button" class="btn btn-secondary"'+
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
    	'  			    <div class="modal-content">'+
    	'  			    <div class="modal-header">'+
    	'          			<h4 class="modal-title">신고</h4>'+
    	'        		</div>'+
    	'               <div class="modal-body">'+
    	'                <div style="text-align: left;">'+
    	'                <p style="color: #262626; font-weight: 600; margin-bottom: 8px;">나체 이미지 또는 음란물로 신고할까요?</p>'+
    	'                <p class="p_text" style="margin-bottom: 8px;">삭제 대상:</p>'+
    	'                <ul class="p_text" style="list-style-type: disc; margin: 0 0 8px 0;">'+
    	'                <li style="margin-bottom: 8px;">성관계가 포함된 사진 또는 동영상</li>'+
    	'                <li style="margin-bottom: 8px;">성관계, 성기 또는 완전히 노출된 둔부의 확대 게시물</li>'+
    	'                <li style="margin-bottom: 8px;">아동의 나체 또는 부분 나체가 포함된 게시물</li>'+
    	'                </ul>'+
    	'                <p class="p_text" style="margin-bottom: 8px;">다른 사람의 게시물을 신고해도 신고자에 대한 정보는 공개되지 않습니다.</p>'+
    	'                <p class="p_text" style="margin-bottom: 8px;">누군가 위급한 위험 상황에 처해 있다면 신속하게 현지 응급 서비스 기관에 연락하세요.</p>'+
    	'                <button type="button" class="btn btn-primary" style="width: 100%">제출</button>'+
    	'                </div>'+
    	'               </div>'+
    	'               <div class="modal-footer">'+
    	'                  <button type="button" class="btn btn-secondary"'+
    	'                     data-dismiss="modal">Close</button>'+
    	'               </div>'+
    	'            </div>'+
    	'         '+
    	'   </div>';
    		

    	$("#changeBoardModal").html(myvar);
    }