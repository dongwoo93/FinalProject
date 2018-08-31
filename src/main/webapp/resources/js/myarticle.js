   function follow(id1, id2) {
         var id = id1; 
         var targetId = id2; 
         $.ajax({ 
            url : "follow.do", 
            type : "post", 
            data : { 
               id : id, 
               targetId : targetId, 
            }, 
            success : function(resp) { 
               $("#cancelFollow").show(); 
               $("#follow").hide(); 
                
            }, 
            error : function() { 
               console.log("에러 발생!"); 
               } 
            }) 
      } 
       
      function unfollow(id1, id2) {
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
               $("#follow").show(); 
               $("#cancelFollow").hide(); 
                
            }, 
            error : function() { 
               console.log("에러 발생!"); 
               } 
            }) 
      } 

$(document).ready(function() {

   
   $("#logout").click(function() {
      $(location).attr("href", "logout.do");
   })

   $('#boardmodal').on('hidden.bs.modal', function () {
      $(".first").remove();
      $("#firstli").attr('class', 'active');
      $("#firstItem").attr('class', 'carousel-item active');
      if($("#carousel-indicators li:nth-child(2)").length) {
         $(".element").remove();
      }
   });
   
   /*$('#profileimage').on('hidden.bs.modal', function (e) {

      var myvar = '<div class="modal-dialog modal-lg">'+
      '      <div class="modal-content">'+
      '        <div class="modal-header">'+
      '          <h4 class="modal-title">프로필 이미지</h4>'+
      '          <button type="button" class="close" data-dismiss="modal">×</button>'+
      '        </div>'+
      '        <div class="modal-body">'+
      '          <input type=\'file\' onchange="readURL(this);" />'+
      '         <img id="profileimg" src="resources/images/Placeholder.png" alt="your image" />'+
      '        </div>'+
      '        <div class="modal-footer">'+
      '          <button type="button" class="btn btn-primary" data-dismiss="modal">적용</button>'+
      '          <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>'+
      '        </div>'+
      '      </div>'+
      '    </div>';
         
      $("#profileimage").html(myvar);

      })*/

	$("#toMy").click(function() {
		$(location).attr("href", "profile.member?cat=0");
	})
	
		

	
	$("#goNext").click(function() {
	
		   
		$(".first").remove();
		$("#firstli").attr('class', 'active');
		$("#firstItem").attr('class', 'carousel-item active');
		if($("#carousel-indicators li:nth-child(2)").length) {
			$(".element").remove();
		}  	
		var seq = $("#next").val();
		
	    $("#likeit").val(seq);
        $("#likecancel").val(seq); 
        $("#mark").val(seq);
        $("#markcancel").val(seq);
      var prevSeq;
      var nextSeq;
      for(var i = 0; i<list.length; i++) {
         if(seq == list[i]) {
            if(i==0) {
               $("#goPrev").hide();
               $("#goNext").show();
            }
            else if(i == (list.length-1)){
               $("#goNext").hide();
               $("#goPrev").show();
            } 
            else { 
               $("#goPrev").show(); 
               $("#goNext").show();

				}
				prevSeq = list[i-1];
				nextSeq = list[i+1];
				break;
			}
		}
		$.ajax({  
			type: "POST",
			url: "boardView.bo",
			data: {seq:seq},
			success: function(data)
			{
				  $(".modalall").attr("style","flex-direction: row; height: auto; width:"+(data[5]+300)+"px;");         
            	  $(".modalmedia").attr("style", "height: auto; width:"+parseInt(data[5])+"px; min-width:400px;");  
           	  
				if(data[1].length == 1) {
					$("#carousel-prev").hide();
					$("#carousel-next").hide();
				}else {
					$("#carousel-prev").show();
					$("#carousel-next").show();
				}
				$("#modalid").text(data[0].id);	        	   
				var txt = data[0].contents;
					var regex = /(#[^#\s,;]+)/gi  ;  
					var newtxt = data[0].contents;
					if(txt != null) {
						newtxt = txt.replace(regex, "<a onclick='tag(this)' style='color:red ; cursor: pointer;'>"+"$1"+"</a>");
					}
	         
               $("#modalcontents").html(newtxt);
            $("#seq").val(data[0].board_seq);
             $("#likeit").val(data[0].board_seq);
                 $("#likecancel").val(data[0].board_seq); 
                 $("#mark").val(data[0].board_seq);
                 $("#markcancel").val(data[0].board_seq);     
            $("#modalid2").text(data[0].id);      
            $("#prev").val(prevSeq); 
            $("#next").val(nextSeq);
            $("#firstItem").append("<img class='first' src='AttachedMedia/"+data[1][0].system_file_name+"' alt=''>");
            for(var i = 1; i < data[1].length; i++) {
               $("#carousel-indicators li:last-child").after("<li class='element' data-target='#demo' data-slide-to="+i+"></li>");
               $("#carousel-inner div:last-child").after("<div class='carousel-item element'><img class='element' src='AttachedMedia/"+data[1][i].system_file_name+"' alt=''></div>");

            }
                
                $(".commentline").remove();        
                for(var i =0; i<data[2].length; i++){       
                   
                    
                   var txt = data[2][i].comment_contents;   
                    var regex = /(#[^#\s,;]+)/gi  ;            
                    var newtxt = txt.replace(regex, "<a onclick='tag(this)' style='color:red ; cursor: pointer;'>"+"$1"+"</a>");        
                     
                   $("#articlecomment:last-child").append("<ul id='ul"+data[2][i].comment_seq+"' value='"+data[2][i].comment_seq+"' class='commentline navbar-nav' onmouseover = 'commentover(this)' onmouseleave='commentleave(this)'><li id='li1'><a href='' class='mr-2' id='commentid'>"+data[2][i].id+"</a></li><li id='li2'><div class='commenttxt txt' id='commenttxt"+data[2][i].comment_seq+"' style='word-wrap:break-word'>"+newtxt+"</div></li></ul>"
                        +"<ul id='ul2"+data[2][i].comment_seq+"' style='background-color:#E1F5FE; display:none;' class='commentline2 navbar-nav' onmouseover = 'commentover2(this)' onmouseleave='commentleave2(this)'><li id='li3' value='"+data[2][i].board_seq+"'><i class='far fa-trash-alt py-1 pointer' id='del"+data[2][i].comment_seq+"' value='"+data[2][i].comment_seq+"' onclick='delComment(this)'></i></li><li id='li4' value='"+data[2][i].board_seq+"'><i class='fas fa-pencil-alt py-1 pl-3 pointer' id='mod"+data[2][i].comment_seq+"' value='"+data[2][i].comment_seq+"' onclick='modComment(this)'></i><li></ul>");     
                }

                
                $("#likeit").attr("style", "display:none;");
                $("#likecancel").attr("style", "font-weight: bold; color: red; display:none; "); 
                if(data[3] != null) { 
                   $("#likecancel").attr("style", "font-weight: bold; color: red; ");   
                }else {
                   $("#likeit").attr("style", false);
                }
                
                
                $("#mark").attr("style", "display:none;");
                $("#markcancel").attr("style", "font-weight: bold; color: #00B8D4; display:none; "); 
                if(data[4] != null) { 
                   $("#markcancel").attr("style", "font-weight: bold; color: #00B8D4;");   
                }else {
                   $("#mark").attr("style", false);
                }
                
                var objDiv = document.getElementById("articlecomment");
                objDiv.scrollTop = 0;

         }
      });
   })    
         
   $("#goPrev").click(function() {
     
      $(".first").remove();
      $("#firstli").attr('class', 'active');
      $("#firstItem").attr('class', 'carousel-item active');
      if($("#carousel-indicators li:nth-child(2)").length) {
         $(".element").remove();
      }
      var seq = $("#prev").val();
      
      var prevSeq;
      var nextSeq;
      for(var i =0; i<list.length; i++) {
         if(seq == list[i]) {
            if(i==0) {
               $("#goPrev").hide();
               $("#goNext").show();
            }
            else if(i == (list.length-1)){
               $("#goNext").hide();
               $("#goPrev").show();
            } 
            else { 
               $("#goPrev").show(); 
               $("#goNext").show();

				}
				prevSeq = list[i-1];
				nextSeq = list[i+1];
				break;
			}
		}
		$.ajax({
			type: "POST",
			url: "boardView.bo",
			data: {seq:seq},
			success: function(data)
			{
				    
				  $(".modalall").attr("style","flex-direction: row; height: auto; width:"+(data[5]+300)+"px;");         
            	  $(".modalmedia").attr("style", "height: auto; width:"+parseInt(data[5])+"px; min-width:400px;");  
           	  
				if(data[1].length == 1) {
					$("#carousel-prev").hide();
					$("#carousel-next").hide();
				}else {
					$("#carousel-prev").show();
					$("#carousel-next").show();
				}
				$("#modalid").text(data[0].id);	 
				var txt = data[0].contents;
				var regex = /(#[^#\s,;]+)/gi;
				var newtxt = data[0].contents;     
				if(txt != null) {
					newtxt = txt.replace(regex, "<a onclick='tag(this)' style='color:red ; cursor: pointer;'>"+"$1"+"</a>");
				}
	          
               $("#modalcontents").html(newtxt);   
         
            $("#seq").val(data[0].board_seq);   
             $("#likeit").val(data[0].board_seq);
                 $("#likecancel").val(data[0].board_seq);   
                 $("#mark").val(data[0].board_seq);
                 $("#markcancel").val(data[0].board_seq);  
            $("#modalid2").text(data[0].id);    
            $("#prev").val(prevSeq); 
            $("#next").val(nextSeq);
            $("#firstItem").append("<img class='first' src='AttachedMedia/"+data[1][0].system_file_name+"' alt=''>");
            for(var i = 1; i < data[1].length; i++) {
               $("#carousel-indicators li:last-child").after("<li class='element' data-target='#demo' data-slide-to="+i+"></li>");
               $("#carousel-inner div:last-child").after("<div class='carousel-item element'><img class='element' src='AttachedMedia/"+data[1][i].system_file_name+"' alt=''></div>");

            }
               
                $(".commentline").remove();       
                for(var i =0; i<data[2].length; i++){  
                   
                     var txt = data[2][i].comment_contents;   
                      var regex = /(#[^#\s,;]+)/gi  ;            
                      var newtxt = txt.replace(regex, "<a onclick='tag(this)' style='color:red ; cursor: pointer;'>"+"$1"+"</a>");          
                   
                   $("#articlecomment:last-child").append("<ul id='ul"+data[2][i].comment_seq+"' value='"+data[2][i].comment_seq+"' class='commentline navbar-nav' onmouseover = 'commentover(this)' onmouseleave='commentleave(this)'><li id='li1'><a href='' class='mr-2' id='commentid'>"+data[2][i].id+"</a></li><li id='li2'><div class='commenttxt txt' id='commenttxt"+data[2][i].comment_seq+"' style='word-wrap:break-word'>"+newtxt+"</div></li></ul>"
                        +"<ul id='ul2"+data[2][i].comment_seq+"' style='background-color:#E1F5FE; display:none;' class='commentline2 navbar-nav' onmouseover = 'commentover2(this)' onmouseleave='commentleave2(this)'><li id='li3' value='"+data[2][i].board_seq+"'><i class='far fa-trash-alt py-1 pointer' id='del"+data[2][i].comment_seq+"' value='"+data[2][i].comment_seq+"' onclick='delComment(this)'></i></li><li id='li4' value='"+data[2][i].board_seq+"'><i class='fas fa-pencil-alt py-1 pl-3 pointer' id='mod"+data[2][i].comment_seq+"' value='"+data[2][i].comment_seq+"' onclick='modComment(this)'></i><li></ul>");      
                }
                   
                $("#likeit").attr("style", "display:none;");
                $("#likecancel").attr("style", "font-weight: bold; color: red; display:none; "); 
                if(data[3] != null) { 
                   $("#likecancel").attr("style", "font-weight: bold; color: red; ");   
                }else {
                   $("#likeit").attr("style", false);
                }
                
                
                $("#mark").attr("style", "display:none;");
                $("#markcancel").attr("style", "font-weight: bold; color: #00B8D4; display:none; "); 
                if(data[4] != null) { 
                   $("#markcancel").attr("style", "font-weight: bold; color: #00B8D4;");   
                }else {
                   $("#mark").attr("style", false);
                }
                
                var objDiv = document.getElementById("articlecomment");
                objDiv.scrollTop = 0;
            

         }
      });
   })
   
   $("#delete").click(function(){
      var seq = document.getElementById("hidden").value;  
      location.href = "boardDelete.bo?seq="+seq+"&cat=1";   

   })

   $("#modify").click(function(){
      $("#modalcontents").attr("contentEditable","true");
      $("#modalcontents").focus();

   })

	/*modifysubmitbtn*/
	
	
	$("#savebtn").click(function() {  
		if($('#inputimg').get(0).files.length != 0) {
			var formData = new FormData($("#fileForm")[0]);
			$.ajax({
				type:"POST",
				url:"uploadImg.profile",
				data: formData,
				processData : false,
	            contentType : false,
				success: function(data) {
					alert(data);
					location.reload();
				},
				error : function(error) {
	                console.log(error);
	                console.log(error.status);
	            }
			});
		}else {
			var fileName = $("#hiddenimgname").val();
			if(fileName == "") {
				alert("사진을 등록해주세요");
			}else {
				var id = $("#hiddenid").val();
				$.ajax({
					type:"POST",
					url:"updateImg.profile",
					data: {system_file_name:fileName, id:id},
					success: function(data) {
						alert(data);
						location.reload();
					},
					error : function(error) {
		                console.log(error);
		                console.log(error.status);
		            }
				});
			}
			
		}
		
	})
	

})

   function commentover(e) {    
       
   var comment_seq = $(e).attr("value");           
   var sessionid = $("#sessionid").val();
   var commentid = $(e).children().children().html();    
   $(e).attr("style","background-color:#E1F5FE");
   $("#commenttxt"+comment_seq).attr("style","word-wrap: break-word; background-color:#E1F5FE"); 
       
      if(sessionid == commentid) {   
         $(e).next().attr("style", "background-color:#E1F5FE;"); 
      }  
   
    }

function commentleave(e) {   
   var comment_seq = $(e).attr("value"); 
    
   $("#ul"+comment_seq).attr("style",false);            
   $("#commenttxt"+comment_seq).attr("style","word-wrap: break-word;");
   $(e).next().attr("style", "display:none; background-color:#E1F5FE;"); 
}

function commentover2(e) {             
   
   var comment_seq = $(e).prev().attr("value");           
   var sessionid = $("#sessionid").val();
   var commentid = $(e).prev().children().children().html();    
   $(e).prev().attr("style","background-color:#E1F5FE");
   $("#commenttxt"+comment_seq).attr("style","word-wrap: break-word; background-color:#E1F5FE"); 
    var modstate = $("#modstate"+comment_seq).val();
      
    if(modstate == "2"){     
       $("#del"+comment_seq).attr("style","color:#00B8D4");
       $("#mod"+comment_seq).attr("style","color:#00B8D4");
    }else if(modstate =="1") {
       $("#del"+comment_seq).attr("style",false);
       $("#mod"+comment_seq).attr("style",false);
       
    }
      if(sessionid == commentid) {     
         $(e).attr("style", "background-color:#E1F5FE;"); 
         
      }  
   
    }

function commentleave2(e) {   
   var comment_seq = $(e).prev().attr("value"); 
    
   $("#ul"+comment_seq).attr("style",false);            
   $("#commenttxt"+comment_seq).attr("style","word-wrap: break-word;");
   $(e).attr("style", "display:none; background-color:#E1F5FE;"); 
}    

   

function likeit(e) { 
   var board_seq = $(e).val();            
   var sessionid = $("#sessionid").val();
     
   $.ajax({  
      url : "like.bo",
      type : "get",  
      data : {
         board_seq : board_seq,
         id : sessionid,
         is_liked : "y"
      },
      success : function(resp) {    
    	  ws.send("like:"+resp);
         $(e).next().show();
         $(e).hide();
      },
      error : function() {
         console.log("에러 발생!");
         }
      })
}  

function unlikeit(e) {
   var board_seq = $(e).val();   
   var sessionid = $("#sessionid").val();   
   $.ajax({
      url : "like.bo",
      type : "get",
      data : {
         board_seq : board_seq,
         id : sessionid,
         is_liked : "n"
      },  
      success : function(resp) {
         $(e).prev().show();
         $(e).hide();
         
      },
      error : function() {
         console.log("에러 발생!");
         }
      })
}


function markit(e) {
   var board_seq = $(e).val();            
   var sessionid = $("#sessionid").val();
   $.ajax({
      url : "bookmark.bo",
      type : "get",
      data : {
         board_seq : board_seq,    
         id : "sessionid",
         is_marked : "y"
      },
      success : function(resp) {
         $(e).next().show();
         $(e).hide();
      },
      error : function() {
         console.log("에러 발생!");
         }
      })
}

function unmarkit(e) {
   var board_seq = $(e).val();            
   var sessionid = $("#sessionid").val();
   $.ajax({
      url : "bookmark.bo",
      type : "get",
      data : {
         board_seq : board_seq,
         id : "sessionid",
         is_marked : "n"
      },
      success : function(resp) {
         $(e).prev().show();
         $(e).hide();
         
         
         
         
      },
      error : function() {
         console.log("에러 발생!");
         }
      })
}

function delComment(e) {
   var board_seq = $(e).parent().attr("value");
   var comment_seq = $(e).attr("value");
   $.ajax({
          type: "POST",  
          url: "commentdel.co",      
          data: {board_seq:board_seq,comment_seq:comment_seq},
          success : function(cnt) {
             console.log(cnt);      
             $("#ul"+comment_seq).fadeOut(400,function() { $("#ul"+comment_seq).remove(); }); 
             $("#ul2"+comment_seq).fadeOut(400,function() { $("#ul2"+comment_seq).remove(); });   
                 
          }  
               
     }); //ajax 
}

/*function modComment*/

      
  