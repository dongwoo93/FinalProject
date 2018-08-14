package kh.sns.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Arrays;
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
import kh.sns.dto.Board_CommentDTO;
import kh.sns.dto.Board_MediaDTO;
import kh.sns.interfaces.BoardService;
import kh.sns.interfaces.Board_CommentService;
import kh.sns.interfaces.Board_LikeService;
import kh.sns.interfaces.ProfileService;

@Controller
public class BoardController {

	@Autowired
	private BoardService boardService;
	@Autowired
	private Board_CommentService board_commentService;
	@Autowired
	private ProfileService profileService;
	@Autowired
	private Board_LikeService board_likeService;
	
	@RequestMapping("/feed.bo")
	public ModelAndView toFeed(HttpSession seesion) {

		List<BoardDTO> list = new ArrayList<BoardDTO>();
		List<Board_CommentDTO> list1 = new ArrayList<>();
		Map<Integer,List<Board_CommentDTO>> commentlist = new HashMap<>();
		String id = (String) seesion.getAttribute("loginId"); 
		try {
			list = boardService.getFeed(id);
			list1 = board_commentService.getFeedComment(id);
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

		}catch(Exception e) {
			e.printStackTrace();
		}	
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", list);
		mav.addObject("commentresult",commentlist);
		mav.setViewName("timeline2.jsp");	
		return mav;
	}
	
	@RequestMapping("/board.bo")
	public ModelAndView getBoard(HttpSession session, String id) throws Exception{
		ModelAndView mav = new ModelAndView();
//		String id = (String) session.getAttribute("loginId");
		List<BoardDTO> result = boardService.getBoard(id);
		List<Board_MediaDTO> result2 = new ArrayList<>();
		for(int i = 0; i < result.size(); i++) {
			result2.add(boardService.search2(result.get(i).getBoard_seq()).get(0));
		}
		String boardCount = boardService.boardCount(id);
		int followerCount = boardService.getFollowerCount(id);
		int followingCount = boardService.getFollowingCount(id);
		mav.addObject("result", result);
		mav.addObject("result2", result2);
		mav.addObject("boardCount", boardCount);
		mav.addObject("followerCount", followerCount);
		mav.addObject("followingCount", followingCount);
		mav.setViewName("myarticle3.jsp");
		return mav;
	}
	
	@RequestMapping("/boardView.bo")
	public void getBoardModal(HttpServletResponse response, String seq) throws Exception{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		BoardDTO result = boardService.getBoardModal(seq);
		List<Board_MediaDTO> result2 =boardService.search2(Integer.parseInt(seq));
		List<Object> result3 = new ArrayList<>();
		result3.add(result);
		result3.add(result2);
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
		List<int[]> result4 = board_likeService.selectLikeAll();
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
	
	
	
	//search
//	@RequestMapping("/search2.bo")
//	public ModelAndView search2(HttpSession session, String search2) throws Exception{
//		ModelAndView mav = new ModelAndView();
//		List<Board_MediaDTO> media = boardService.search2(search2);
//		mav.addObject("media", media);
//		mav.setViewName("search.jsp");
//		return mav;
//	}
	
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
		
		for(MultipartFile mf : mfList) {
			try {
				
				String originalName = mf.getOriginalFilename(); 
				
				// 시스템 파일명(임시)
				String fileName = originalName.substring(0, originalName.lastIndexOf('.'));
				String ext = originalName.substring(originalName.lastIndexOf('.')); // 확장자
				String saveFileName = fileName + "_" + (int)(Math.random() * 10000) + ext;
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
				
				fileList.add(new Board_MediaDTO(0, 0, "p", originalName, saveFileName));				
				
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
		mav.setViewName("feed.bo");
		return mav;
	}
	
	@RequestMapping("/idunno.test")
	public ModelAndView writeProcBoard(HttpServletRequest request) {		
		
		System.out.println(request.getSession().getServletContext().getRealPath("AttachedMedia"));
		
		try {
			profileService.toggleProfileCheckbox(profileService.getOneProfile("yukirinu"), "is_allow_sms");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	


}
