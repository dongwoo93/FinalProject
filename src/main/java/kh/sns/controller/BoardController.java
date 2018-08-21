package kh.sns.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_BookmarkDTO;
import kh.sns.dto.Board_CommentDTO;
import kh.sns.dto.Board_LikeDTO;
import kh.sns.dto.Board_MediaDTO;
import kh.sns.dto.FollowInfo;
import kh.sns.dto.Profile_ImageDTO;
import kh.sns.interfaces.BoardService;
import kh.sns.interfaces.Board_BookmarkService;
import kh.sns.interfaces.Board_CommentService;
import kh.sns.interfaces.Board_LikeService;
import kh.sns.interfaces.Member_BlockService;
import kh.sns.interfaces.Member_FollowService;
import kh.sns.interfaces.ProfileService;

@Controller
public class BoardController {

	@Autowired
	private BoardService boardService;
	@Autowired
	private Board_CommentService board_commentService;

	@Autowired
	private Board_LikeService board_likeService;
	@Autowired
	private Board_BookmarkService board_bookmarkService;
	@Autowired
	private Member_BlockService member_blockService;
	
	@Autowired
	private Member_FollowService member_followService;
	
	@RequestMapping("/feed.bo")
	public ModelAndView toFeed(HttpSession seesion) {
		ModelAndView mav = new ModelAndView();
		String id = (String) seesion.getAttribute("loginId");
		if(id != null) {
			List<BoardDTO> list = new ArrayList<BoardDTO>();
			List<Board_CommentDTO> list1 = new ArrayList<>();
			Map<Integer,List<Board_CommentDTO>> commentlist = new HashMap<>();
			List<Integer> like = new ArrayList<>();
			Map<Integer,String> maplike = new HashMap<>();
			List<Integer> mark = new ArrayList<>();
			Map<Integer,String> mapmark = new HashMap<>();
			List<List<Board_MediaDTO>> media = new ArrayList<>();
			 
			try {
				list = boardService.getFeed(id);
				for(int i = 0; i < list.size(); i++) {
					media.add(boardService.search2(list.get(i).getBoard_seq()));
				}
				list1 = board_commentService.getFeedComment(id);
				like = board_likeService.searchLike(id);
				mark = board_bookmarkService.searchMark(id);
				
				Set<Integer> seqlist = new HashSet<>();
			for(Board_CommentDTO dto : list1) {	
				seqlist.add(dto.getBoard_seq());
				commentlist.put(dto.getBoard_seq(), new ArrayList<>());
		
			}  
			for(Board_CommentDTO dto : list1) {
				for(int seq : seqlist) {
					if(dto.getBoard_seq() == seq ) {
						commentlist.get(seq).add(dto);  
					} 
				}
			}
			
			
			for(int tmp : like) {
				maplike.put(tmp, "y");
			}
			
			for(int tmp : mark) {
				mapmark.put(tmp, "y");
			}

			}catch(Exception e) {
				e.printStackTrace();
			}	  
			mav.addObject("result", list);
			mav.addObject("result2", media);
			mav.addObject("like", maplike);
			mav.addObject("bookmark", mapmark);
			mav.addObject("commentresult",commentlist);
			mav.setViewName("timeline2.jsp");
		}else {
			mav.setViewName("redirect:main.jsp");
		}
			
		return mav;
	}
	
	@RequestMapping("/board.bo")
	public ModelAndView getBoard(HttpSession session, String id) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		String sessionid= (String)session.getAttribute("loginId");
		
//		String id = (String) session.getAttribute("loginId");
		List<BoardDTO> result = boardService.getBoard(id);
		
		boolean isBlock = member_blockService.isBlock(sessionid,id);
		boolean isFollow = member_followService.isFollow(sessionid,id);
		boolean isNotPublic = profileService.isNotPublic(id);
		List<Board_MediaDTO> result2 = new ArrayList<>();
		for(int i = 0; i < result.size(); i++) {
			result2.add(boardService.search2(result.get(i).getBoard_seq()).get(0));
		}
		String boardCount = boardService.boardCount(id);
		int followerCount = member_followService.getFollowerCount(id);
		int followingCount = member_followService.getFollowingCount(id);
		List<int[]> likecnt = board_likeService.selectLikeCount();
		Map<Integer, Integer> likecount = new HashMap<>();
		List<int[]> commentcnt = board_commentService.selectCommentCount();
		Map<Integer, Integer> commentcount = new HashMap<>();
		List<Profile_ImageDTO> profileImg = profileService.selectProfileImage(id);
		
		for(int[] tmp : likecnt) {
			likecount.put(tmp[0],tmp[1]);
		}
		 
		for(int[] tmp : commentcnt) {
			commentcount.put(tmp[0],tmp[1]);
		}
		mav.addObject("result", result);
		mav.addObject("result2", result2);
		mav.addObject("boardCount", boardCount);
		mav.addObject("followerCount", followerCount);
		mav.addObject("followingCount", followingCount);
		mav.addObject("likecount", likecount); 
		mav.addObject("commentcount", commentcount); 
		mav.addObject("isBlock", isBlock); 
		mav.addObject("isFollow", isFollow);
		mav.addObject("isNotPublic", isNotPublic);  
		mav.addObject("profileImg", profileImg);
		mav.setViewName("myarticle3.jsp");
		mav.addObject("profileImg", profileImg);
		return mav;
	}
	
	@RequestMapping("/boardView.bo")
	public void getBoardModal(HttpSession session, HttpServletResponse response, String seq) throws Exception{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		String id = (String)session.getAttribute("loginId");  
		BoardDTO result = boardService.getBoardModal(seq);
		List<Board_MediaDTO> result2 =boardService.search2(Integer.parseInt(seq));  
		List<Board_CommentDTO> commentlist = board_commentService.getCommentList(Integer.parseInt(seq));
	
		List<Object> result3 = new ArrayList<>();
		Board_LikeDTO like = board_likeService.isLiked(id,Integer.parseInt(seq));
		Board_BookmarkDTO bookmark =  board_bookmarkService.isBookmarked(id, Integer.parseInt(seq));
		result3.add(result);
		result3.add(result2);
		result3.add(commentlist); 
		
		result3.add(like);
		result3.add(bookmark);
		new Gson().toJson(result3,response.getWriter());

	}
	

	@RequestMapping("/boardDelete.bo")
	public ModelAndView deleteBoard(HttpSession session, int seq) throws Exception {
		ModelAndView mav = new ModelAndView();
		int result = boardService.deleteBoard(seq);
		String id = (String) session.getAttribute("loginId");
		mav.setViewName("redirect:board.bo?id="+id);
		return mav;	
	}
	
	
	@RequestMapping("/boardModify.bo")
	public void modifyBoard(HttpServletResponse response, BoardDTO dto) throws Exception {
		int result = boardService.modifyBoard(dto);
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(result);
		response.getWriter().flush();
		response.getWriter().close();
	}
	
	
	//search
	@RequestMapping("/search.bo")
	public ModelAndView search(HttpSession session, String search) throws Exception{
		String id = (String)session.getAttribute("loginId");
		ModelAndView mav = new ModelAndView();
		System.out.println(search);
		List<BoardDTO> result = boardService.search(search);
		List<List<Board_MediaDTO>> result2 = new ArrayList<>();
		List<Integer> result3 = board_likeService.searchLike(id);
		List<int[]> result4 = board_likeService.selectLikeCount();
		Map<Integer,String> map = new HashMap<>();
		Map<Integer,Integer> countlike = new HashMap<>();
		
		for(int[] list : result4) {
			countlike.put(list[0], list[1]);
		}
	
		for(int tmp : result3) {
			map.put(tmp, "y");
		}
		
		for(int i = 0; i < result.size(); i++) {
			result2.add(boardService.search2(result.get(i).getBoard_seq()));
		}
		System.out.println("사이즈 : " + result.size());
		mav.addObject("result", result);
		mav.addObject("result2", result2);
		mav.addObject("result3", map);
		mav.addObject("result4",countlike);
		mav.setViewName("search2.jsp");
		return mav;
	}
	
	@RequestMapping("/mypage.bo")
	public ModelAndView toMypage(){
		ModelAndView mav = new ModelAndView();
		
		
		return mav;
	}
	
	@RequestMapping("/write.board")
	   public ModelAndView writeBoard() {
	      System.out.println("@@WRITE BOARD");
	      
	      List<String> filter = new ArrayList<>(Arrays.asList("filter-1977","filter-aden","filter-amaro","filter-ashby","filter-brannan",
          		"filter-brooklyn","filter-charmes","filter-clarendon","filter-crema","filter-dogpatch",
          		"filter-earlybird","filter-gingham","filter-ginza","filter-hefe","filter-helena","filter-hudson",
          		"filter-inkwell","filter-kelvin","filter-juno","filter-lark","filter-lofi","filter-ludwig",
          		"filter-maven","filter-mayfair","filter-moon","filter-nashville","filter-perpetua","filter-poprocket",
          		"filter-reyes","filter-rise","filter-sierra","filter-skyline","filter-slumber","filter-stinson",
          		"filter-sutro","filter-toaster","filter-valencia","filter-vesper","filter-walden","filter-willow","filter-xpro-ii"));
	      ModelAndView mav = new ModelAndView();
	      mav.addObject("filter", filter);
	      mav.setViewName("write2.jsp"); 
	      return mav;
	   }

	@RequestMapping("/writeProc.bo")
	public ModelAndView writeProcBoard(
			HttpServletRequest request,
			@RequestParam("contents") String contents,
			@RequestParam("filename[]") MultipartFile files) {
		
	
		
		MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) request;
		
		List<MultipartFile> mfList = mhsr.getFiles("filename[]");
		
		List<Board_MediaDTO> fileList = new ArrayList<Board_MediaDTO>();
		
		System.out.println(request.getParameter("filters"));
		
		String[] filterList = null;
		if(request.getParameter("filters") != null)
			filterList = request.getParameter("filters").split(";");
	
		
		int k = 0;
		for(MultipartFile mf : mfList) {
			try {
				
				String originalName = mf.getOriginalFilename(); 
				
				// 시스템 파일명(임시)
				String fileName = originalName.substring(0, originalName.lastIndexOf('.'));
				String ext = originalName.substring(originalName.lastIndexOf('.')); // 확장자
				String saveFileName = fileName + "_" + (int)(Math.random() * 10000) + ext;	// 나중에 네이밍 컨벤션 정해지면 바꿉니다.
				String realPath = request.getSession().getServletContext().getRealPath("/image/");
                   
                File f = new File(realPath);
                if(!f.exists()){
                   f.mkdir();
                }
          
				// 설정한 path에 파일저장(임시)
				// D:\Spring\workspace_spring\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\FinalProject\AttachedMedia				
				String complexPath = request.getSession().getServletContext().getRealPath("AttachedMedia");
				
				File serverFile = new File(complexPath + File.separator + saveFileName); 
				mf.transferTo(serverFile);	// HDD에 전송
				
				// 필터가 모든 사진에 하나도 적용이 안됐다면 catch가 실행됨
			
					String filter = null;
					
					for(String flt : filterList) {
						System.out.println(flt);
						
						if(originalName.equals(flt.split(":")[0])) {
							try {
								if(flt.split(":")[1] != null )
									filter = flt.split(":")[1];
							} catch(ArrayIndexOutOfBoundsException e) {
								System.err.println(e);
							}
							
						}
					}
					
					
					
					fileList.add(new Board_MediaDTO(0, 0, "p", originalName, saveFileName, filter, null, null));
						
				k++;
				
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		// 테스트용 (else는 나중에 삭제)
		try {
			if(request.getSession().getAttribute("loginId") != null) {
				boardService.insertNewArticle(new BoardDTO(0, contents, request.getSession().getAttribute("loginId").toString(), "", "", ""), fileList);
			} else {
				// 잘못된 접근
				boardService.insertNewArticle(new BoardDTO(0, contents, "yoon", "", "", ""), fileList);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		
		for(Board_MediaDTO m : fileList) {
			System.out.println(m.getOriginal_file_name());
			System.out.println(m.getSystem_file_name());
		}		
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:feed.bo");
		return mav;
	}	

	
	// AJAX
	@RequestMapping("/getOneArticle.ajax")
	public void getOneArticleAjax(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setCharacterEncoding("UTF8");
		response.setContentType("application/json");
		PrintWriter xout = response.getWriter();
		try {			
			System.out.println(request.getParameter("seq"));
			BoardDTO b = boardService.getBoardModal(request.getParameter("seq"));

			new Gson().toJson(b, xout);			
		} catch (IOException e) {
			e.printStackTrace();
		} catch (IndexOutOfBoundsException e) {
			xout.print("해당 글은 삭제됨");
		}
		
	}
	
	@RequestMapping("/getOneComment.ajax")
	public void getOneCommentAjax(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setCharacterEncoding("UTF8");
		response.setContentType("application/json");
		try {
			PrintWriter xout = response.getWriter();
			
			System.out.println(request.getParameter("comment_seq"));
			System.out.println(request.getParameter("board_seq"));
			
			BoardDTO b = boardService.getBoardModal(request.getParameter("board_seq"));
			Board_CommentDTO c = board_commentService.getOneComment(Integer.parseInt(request.getParameter("comment_seq")));
			
			System.out.println(b);
			System.out.println(c);
			
			Object[] output = new Object[2];
			output[0] = b;
			output[1] = c;

			new Gson().toJson(output, xout);
			
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	

	@RequestMapping("/oneBoard.do")
	public ModelAndView oneBoard(String board_seq , HttpSession session) {
		ModelAndView mav = new ModelAndView();
		BoardDTO a = null;
		List<Board_CommentDTO> result = null;
		List<List<Board_MediaDTO>> media = new ArrayList<>();
		
		Board_LikeDTO like = null;
		Board_BookmarkDTO bookmark = null;
		String id = (String) session.getAttribute("loginId");
		
		
		try {
		System.out.println(board_seq);
		
		a = boardService.oneBoard(board_seq);
		media.add(boardService.search2(a.getBoard_seq()));

		
		result = board_commentService.getCommentList(Integer.parseInt(board_seq));
		
		like = board_likeService.isLiked(id,Integer.parseInt(board_seq));
		
		bookmark =  board_bookmarkService.isBookmarked(id, Integer.parseInt(board_seq));
		
		}catch(Exception e) {
			System.out.println("oneboard.do");
			e.printStackTrace();
		}
		
		mav.setViewName("oneBoard.jsp");
		mav.addObject("b", a);
		mav.addObject("result", result);
		mav.addObject("result2", media);
		mav.addObject("like", like);
		mav.addObject("bookmark", bookmark);
		return mav;
		
	}
	
	@RequestMapping("/follow.do")
	public void insertFollowInfo(FollowInfo fi, HttpServletResponse response) throws Exception {
		response.setCharacterEncoding("UTF-8");
		int result = member_followService.insertFollowInfo(fi);
		if(result == 1) {
			response.getWriter().print("팔로우 완료");
		}else {
			response.getWriter().print("팔로우 실패");
		}
		
		response.getWriter().flush();
		response.getWriter().close();
		
	}
	
	@RequestMapping("/deletefollow.do")
	public void deleteFollowInfo(FollowInfo fi, HttpServletResponse response) throws Exception {
		response.setCharacterEncoding("UTF-8");
		int result = member_followService.deleteFollowInfo(fi);
		if(result == 1) {
			response.getWriter().print("팔로우 취소 완료");
		}else {
			response.getWriter().print("팔로우 취소 실패");
		}
		
		response.getWriter().flush();
		response.getWriter().close();
		
	}
	
}
