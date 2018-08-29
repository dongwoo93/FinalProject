package kh.sns.controller;

import java.awt.image.BufferedImage;
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

import javax.imageio.ImageIO;
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

import kh.sns.dto.BoardBusinessDTO;
import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_BookmarkDTO;
import kh.sns.dto.Board_CommentDTO;
import kh.sns.dto.Board_LikeDTO;
import kh.sns.dto.Board_MediaDTO;
import kh.sns.dto.FollowInfo;
import kh.sns.dto.MemberBusinessDTO;
import kh.sns.dto.Profile_ImageDTO;
import kh.sns.interfaces.BoardService;
import kh.sns.interfaces.Board_BookmarkService;
import kh.sns.interfaces.Board_CommentService;
import kh.sns.interfaces.Board_LikeService;
import kh.sns.interfaces.MemberBusinessService;
import kh.sns.interfaces.MemberService;
import kh.sns.interfaces.Member_BlockService;
import kh.sns.interfaces.Member_FollowService;
import kh.sns.interfaces.ProfileService;

@Controller
public class BoardController {

	@Autowired	private BoardService boardService;
	@Autowired	private Board_CommentService board_commentService;
	@Autowired	private Board_LikeService board_likeService;
	@Autowired	private Board_BookmarkService board_bookmarkService;
	@Autowired	private Member_BlockService member_blockService;
	@Autowired	private Member_FollowService member_followService;
	@Autowired	private ProfileService profileService;
	@Autowired	private MemberBusinessService mBizService;
	@Autowired	private MemberService memService;

	@RequestMapping("/feed.bo")
	public ModelAndView toFeed(HttpServletResponse response, HttpServletRequest request, HttpSession seesion) {
		ModelAndView mav = new ModelAndView();
		String id = (String) seesion.getAttribute("loginId");

		List<BoardDTO> list = new ArrayList<BoardDTO>();
		List<Board_CommentDTO> list1 = new ArrayList<>();
		Map<Integer,List<Board_CommentDTO>> commentlist = new HashMap<>();
		List<Integer> like = new ArrayList<>();
		Map<Integer,String> maplike = new HashMap<>();
		List<Integer> mark = new ArrayList<>();
		Map<Integer,String> mapmark = new HashMap<>();
		List<List<Board_MediaDTO>> media = new ArrayList<>();
		List<Profile_ImageDTO> profile_image = new ArrayList<>(); 
		Map<String, String> getAllProfilePic = new HashMap<>();
		List<FollowInfo> follow_list = new ArrayList<>();

		List<Integer> maxImgHeight = new ArrayList<>();


		try {
			follow_list = member_followService.toFeed(id);
		} catch (Exception e1) {

			e1.printStackTrace();
		}

		try {
			list = boardService.getFeed(id);
			for(int i = 0; i < list.size(); i++) {
				media.add(boardService.search2(list.get(i).getBoard_seq()));
			} 
		//	String realPath = request.getSession().getServletContext().getRealPath("/AttachedMedia/"); 


//			for(List<Board_MediaDTO> mlist : media) { 
//				double max = 0;
//				for(Board_MediaDTO dto : mlist) {
//					BufferedImage bimg = ImageIO.read(new File(realPath+dto.getSystem_file_name()));
//					double height = bimg.getHeight();
//					double width = bimg.getWidth();
//					height = 600*height/width;   
//					System.out.println("height : " + height);
//					if(max<height) { 
//						max = height;
//					}
//
//				}
//				maxImgHeight.add((int)max);   
//				System.out.println("max:" + max);     
//			}


			list1 = board_commentService.getFeedComment(id);
			like = board_likeService.searchLike(id);
			mark = board_bookmarkService.searchMark(id);

			profile_image = profileService.getAllProfileImage();

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

			for(Profile_ImageDTO dto : profile_image) {
				getAllProfilePic.put(dto.getId(),dto.getSystem_file_name());

			};



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
		mav.addObject("profile_pic",getAllProfilePic);
		mav.addObject("result3", follow_list);
		mav.addObject("follow_size", follow_list.size()/5);
		System.out.println(follow_list.size()/5); 

		mav.addObject("maxImgHeight",maxImgHeight);
		mav.setViewName("timeline2.jsp");


		return mav;
	}
	@RequestMapping("/board.bo")
	public ModelAndView getBoard(HttpSession session, HttpServletResponse response, String id, String cat) throws Exception{

		ModelAndView mav = new ModelAndView();
		String sessionid= (String)session.getAttribute("loginId");
		List<BoardDTO> result = new ArrayList<>();

		boolean isBlock = member_blockService.isBlock(sessionid,id);
		boolean isFollow = member_followService.isFollow(sessionid,id);
		boolean isNotPublic = profileService.isNotPublic(id);

		String boardCount = boardService.boardCount(id);
		int followerCount = member_followService.getFollowerCount(id);
		int followingCount = member_followService.getFollowingCount(id);
		List<int[]> likecnt = board_likeService.selectLikeCount();
		Map<Integer, Integer> likecount = new HashMap<>();
		List<int[]> commentcnt = board_commentService.selectCommentCount();
		Map<Integer, Integer> commentcount = new HashMap<>();
		List<Profile_ImageDTO> profileImg = profileService.selectProfileImage(id);

		// NickName
		String memNick = memService.myNick_Id(id).get(0).getNickname();
		// introduce
		String memIntro = profileService.selectIntro(id).get(0).getIntroduce();

		for(int[] tmp : likecnt) {
			likecount.put(tmp[0],tmp[1]);
		}

		for(int[] tmp : commentcnt) {
			commentcount.put(tmp[0],tmp[1]);
		}

		if(cat.equals("1")) {
			result = boardService.getBoard(id);
		}
		else if(cat.equals("2")) {
			List<int[]> seqArr = boardService.myBookmark(id);
			for(int i = 0; seqArr.size() > i; i++) {
				result.add(boardService.oneBoard(Integer.toString(seqArr.get(i)[0])));
			}
		}
		List<Board_MediaDTO> result2 = new ArrayList<>();
		for(int i = 0; i < result.size(); i++) {
			result2.add(boardService.search2(result.get(i).getBoard_seq()).get(0));
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
		mav.addObject("memNick", memNick);   // 닉네임
		mav.addObject("memIntro", memIntro); // 소개

		//		String id = (String) session.getAttribute("loginId");

		mav.addObject("pageid", id);
		return mav;
	}

	@RequestMapping("/boardView.bo")
	public void getBoardModal(HttpSession session, HttpServletResponse response, HttpServletRequest request, String seq) throws Exception{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		String id = (String)session.getAttribute("loginId");  
		BoardDTO result = boardService.getBoardModal(seq);    
		if(result.getContents() == null) {
			result.setContents(" "); 
		}

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
		

		String realPath = request.getSession().getServletContext().getRealPath("/AttachedMedia/"); 
 
		double maxheight = 0;
		double maxwidth = 0;
		for(Board_MediaDTO dto : result2) {
			BufferedImage bimg = ImageIO.read(new File(realPath+dto.getSystem_file_name()));
			double height = bimg.getHeight();
			double width = bimg.getWidth();

			if(width>700) {
				
			}
		}
		System.out.println(maxheight + " : " + maxwidth);  
		
		result3.add(maxheight);
		result3.add(maxwidth);

		new Gson().toJson(result3,response.getWriter());

	}   



	@RequestMapping("/boardDelete.bo")
	public ModelAndView deleteBoard(HttpSession session, HttpServletResponse response, int seq) throws Exception {
		ModelAndView mav = new ModelAndView();
		int result = boardService.deleteBoard(seq);
		String id = (String) session.getAttribute("loginId");
		mav.setViewName("redirect:board.bo?id="+id+"&cat=1");
		return mav;	
	}


	@RequestMapping("/boardModify.bo")
	public void modifyBoard(HttpSession seesion, HttpServletResponse response, BoardDTO dto) throws Exception {
		int result = boardService.modifyBoard(dto);
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(result);
		response.getWriter().flush();
		response.getWriter().close();
	}


	//Search(검색)
	@RequestMapping("/search.bo")
	public ModelAndView search(HttpSession session, String search) throws Exception{
		ModelAndView mav = new ModelAndView();
		String id = (String)session.getAttribute("loginId");

		List<BoardDTO> result = boardService.search(search);		// 전체 글
		List<List<Board_MediaDTO>> result2 = new ArrayList<>();		// 사진 
		List<Integer> result3 = board_likeService.searchLike(id);	// 좋아요
		List<Integer> mark = new ArrayList<>();
		Map<Integer,String> mapmark = new HashMap<>();
		mark = board_bookmarkService.searchMark(id);
		for(int tmp : mark) {
			mapmark.put(tmp, "y");
		}
		//////////////////////////////
		List<int[]> result4 = board_likeService.selectLikeCount();	// 조회

		Map<Integer,String> map = new HashMap<>();					// 누를때 맵
		Map<Integer,Integer> countlike = new HashMap<>();			// 조회 맵

		// 사진
		for(int i = 0;i < result.size(); i++) { 
			result2.add(boardService.search2(result.get(i).getBoard_seq()));
		}

		// 누를때
		for(int tmp : result3) {
			map.put(tmp, "y");
		}

		// 조회
		for(int[] list : result4) {
			countlike.put(list[0], list[1]);
		}
		
		for(BoardDTO dto : result) {
			if(dto.getContents() == null) {
				dto.setContents(" ");  
			}
		}

		System.out.println("사이즈 : " + result.size());
		mav.addObject("result", result);		// 검색어
		mav.addObject("result2", result2);		// 사진
		mav.addObject("result3", map);			// 누를때
		mav.addObject("result4",countlike);		// 조회
		mav.addObject("bookmark", mapmark);
		mav.setViewName("search2.jsp");
		return mav;
	}

	//tour(둘러보기)
	@RequestMapping("/tour.bo")
	public ModelAndView goTour(HttpSession session, String cat) throws Exception {
		ModelAndView mav = new ModelAndView();
		String id = (String)session.getAttribute("loginId");
		String category = null;

		List<BoardDTO> result = new ArrayList<>(); 					// 전체 글
		List<List<Board_MediaDTO>> result2 = new ArrayList<>();		// 사진 
		List<Integer> result3 = board_likeService.searchLike(id);	// 좋아요 
		List<int[]> result4 = board_likeService.selectLikeCount();	// 조회

		Map<Integer,String> map = new HashMap<>();					// 누를때 맵
		Map<Integer,Integer> countlike = new HashMap<>();			// 조회 맵

		List<Integer> mark = new ArrayList<>();
		Map<Integer,String> mapmark = new HashMap<>();
		mark = board_bookmarkService.searchMark(id);
		for(int tmp : mark) {
			mapmark.put(tmp, "y");
		}

		// 최신글
		if(cat.equals("1")) {
			result = boardService.getAllBoard();
			category = "최신글";
		}

		// 좋아요 
		else if(cat.equals("2")) {
			category = "좋아요 순";
			List<int[]> seqArr = board_likeService.bestLike();
			for(int i = 0; seqArr.size() > i; i++) {
				result.add(boardService.oneBoard(Integer.toString(seqArr.get(i)[0])));
			}
		}

		// 인기 태그
		else if(cat.equals("3")) {
			category = "인기 태그 순";
			List<String[]> tagArr = boardService.selectTagCount();
			for(int i = 0; i < tagArr.size(); i++) {
				for( int j = 0; j < tagArr.get(i)[2].split(",").length; j++) {
					result.add(boardService.oneBoard(tagArr.get(i)[2].split(",")[j]));
					System.out.println(tagArr.get(i)[2].split(",")[j]);
				}
			}
		}

		// 사진
		for(int i = 0;i < result.size(); i++) { 
			result2.add(boardService.search2(result.get(i).getBoard_seq()));
		}

		// 누를때
		for(int tmp : result3) {
			map.put(tmp, "y");
		}

		// 조회
		for(int[] list : result4) {
			countlike.put(list[0], list[1]);
		}
		mav.addObject("bookmark", mapmark);
		mav.addObject("category", category);	// 카테고리
		mav.addObject("result", result);		// 전체 
		mav.addObject("result2", result2);		// 사진 
		mav.addObject("result3", map);			// 누를때
		mav.addObject("result4",countlike);		// 조회
		mav.setViewName("tour.jsp");
		return mav;
	}

	@RequestMapping("/mypage.bo")
	public ModelAndView toMypage(HttpSession seesion, HttpServletResponse response){
		ModelAndView mav = new ModelAndView();
		return mav;
	}

	@RequestMapping("/write.board")
	public ModelAndView writeBoard(HttpSession session, HttpServletResponse response) {
		String id = (String)session.getAttribute("loginId");
		ModelAndView mav = new ModelAndView();
		if(id != null) {
			System.out.println("@@WRITE BOARD");

			List<String> filter = new ArrayList<>(Arrays.asList("filter-1977","filter-aden","filter-amaro","filter-ashby","filter-brannan",
					"filter-brooklyn","filter-charmes","filter-clarendon","filter-crema","filter-dogpatch",
					"filter-earlybird","filter-gingham","filter-ginza","filter-hefe","filter-helena","filter-hudson",
					"filter-inkwell","filter-kelvin","filter-juno","filter-lark","filter-lofi","filter-ludwig",
					"filter-maven","filter-mayfair","filter-moon","filter-nashville","filter-perpetua","filter-poprocket",
					"filter-reyes","filter-rise","filter-sierra","filter-skyline","filter-slumber","filter-stinson",
					"filter-sutro","filter-toaster","filter-valencia","filter-vesper","filter-walden","filter-willow","filter-xpro-ii"));

			MemberBusinessDTO memberBiz = null;
			try {
				memberBiz = mBizService.selectAnMemberBiz(session.getAttribute("loginId").toString());
			} catch(IndexOutOfBoundsException e) {
				System.err.println("This is not business account!!");
			} catch (Exception e) {
				e.printStackTrace();
			}			

			mav.setViewName("write2.jsp"); 
			mav.addObject("memberBiz", memberBiz);
			mav.addObject("filter", filter);

		} else {
			mav.setViewName("redirect:main.jsp");
		}

		return mav;
	}

	@RequestMapping("/writeProc.bo")
	public ModelAndView writeProcBoard(
			HttpSession seesion,
			HttpServletRequest request,
			@RequestParam("contents") String contents,
			@RequestParam("filename[]") MultipartFile files,
			@RequestParam("enableBiz") String enableBiz,
			@RequestParam("moreInfoWebsite") String moreInfoWebsite,
			@RequestParam("isWebsitePurposeOfPurchase") String isWebsitePurposeOfPurchase,
			@RequestParam("costPerMille") String costPerMille,
			@RequestParam("remainedPublicExposureCount") String remainedPublicExposureCount,
			@RequestParam("costPerClick") String costPerClick,
			HttpServletResponse response) {	

		MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) request;		
		List<MultipartFile> mfList = mhsr.getFiles("filename[]");		
		List<Board_MediaDTO> fileList = new ArrayList<Board_MediaDTO>();

		/*테스트용 에코 코드*/
		/*System.out.println(request.getParameter("filters"));
		System.out.println("enableBiz: " + enableBiz);
		System.out.println("moreInfoWebsite: " + moreInfoWebsite);
		System.out.println("isWebsitePurposeOfPurchase: " + isWebsitePurposeOfPurchase);
		System.out.println("costPerMille: " + costPerMille);
		System.out.println("remainedPublicExposureCount: " + remainedPublicExposureCount);
		System.out.println("costPerClick: " + costPerClick);*/

		boolean isBizEnabled = enableBiz.equalsIgnoreCase("y") ? true : false;
		BoardBusinessDTO bbiz = null;
		if(isBizEnabled) {
			bbiz = new BoardBusinessDTO();
			bbiz.setCostPerClick(Integer.parseInt(costPerClick));
			bbiz.setCostPerMille(Integer.parseInt(costPerMille));
			bbiz.setIsWebsitePurposeOfPurchase(isWebsitePurposeOfPurchase);
			bbiz.setMoreInfoWebsite(moreInfoWebsite);
			bbiz.setRemainedPublicExposureCount(Integer.parseInt(remainedPublicExposureCount.replace(",", "")));			

		}


		String[] filterList = null;
		if(request.getParameter("filters") != null)
			filterList = request.getParameter("filters").split(";");


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
				boardService.insertNewArticle(new BoardDTO(0, contents, request.getSession().getAttribute("loginId").toString(), "", "", ""), fileList, bbiz);
			} else {
				// 잘못된 접근과 관련된 코드..
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
	public void getOneArticleAjax(HttpServletRequest request, HttpServletResponse response, HttpSession seesion) throws Exception {
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
	public void getOneCommentAjax(HttpServletRequest request, HttpServletResponse response, HttpSession seesion) throws Exception {
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
	public ModelAndView oneBoard(String board_seq , HttpSession session, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		String id = (String) session.getAttribute("loginId");
		if(id != null) {
			BoardDTO a = null;
			List<Board_CommentDTO> result = null;
			List<List<Board_MediaDTO>> media = new ArrayList<>();

			Board_LikeDTO like = null;
			Board_BookmarkDTO bookmark = null;



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
		}else {
			mav.setViewName("redirect:main.jsp");
		}

		return mav;

	}

	@RequestMapping("/follow.do")
	public void insertFollowInfo(FollowInfo fi, HttpServletResponse response, HttpSession seesion) throws Exception {
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
	@RequestMapping("/calendar.bo")
	public String goCalendar(HttpSession session){
		return "redirect:calendar.jsp";   
	}

	@RequestMapping("/deletefollow.do")
	public void deleteFollowInfo(FollowInfo fi, HttpServletResponse response, HttpSession seesion) throws Exception {
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


	@RequestMapping("/followerlist.do")
	public ModelAndView followerList(HttpServletResponse response, HttpServletRequest request, HttpSession session, String id) throws Exception {
		ModelAndView mav = new ModelAndView();
		String sessionid = (String) session.getAttribute("loginId");
		List<Profile_ImageDTO> profile_image = new ArrayList<>(); 
		Map<String, String> getAllProfilePic = new HashMap<>();
		List<FollowInfo> follow_list = new ArrayList<>();
		List<Boolean> isFollowList = new ArrayList<>();
		System.out.println(sessionid);
		System.out.println(id);
		try {
			follow_list = member_followService.followerList(id);
		} catch (Exception e1) {

			e1.printStackTrace();  
		}
		
		for(int i = 0; i < follow_list.size(); i++) {
			isFollowList.add(member_followService.isFollow(sessionid,follow_list.get(i).getId()));
		}
		
		
		
		
		profile_image = profileService.getAllProfileImage();


		for(Profile_ImageDTO dto : profile_image) {

			getAllProfilePic.put(dto.getId(),dto.getSystem_file_name());

		};

		mav.addObject("isFollow", isFollowList);	
		mav.addObject("profile_pic",getAllProfilePic);
		mav.addObject("result1", follow_list);
		mav.setViewName("follow.jsp");
		mav.addObject("pageid", id);

		return mav;	
	}



	@RequestMapping("/followlist.do")
	public ModelAndView followList(HttpServletResponse response, HttpServletRequest request, HttpSession seesion , String id) throws Exception {
		ModelAndView mav = new ModelAndView();
		String sessionid = (String) seesion.getAttribute("loginId");
		List<Profile_ImageDTO> profile_image = new ArrayList<>(); 
		Map<String, String> getAllProfilePic = new HashMap<>();
		List<FollowInfo> follow_list = new ArrayList<>();
		List<Boolean> isFollowList = new ArrayList<>();
		try {
	         follow_list = member_followService.followList(id);
	      } catch (Exception e1) {
	         
	         e1.printStackTrace();  
	      }
		
		for(int i = 0; i < follow_list.size(); i++) {
			isFollowList.add(member_followService.isFollow(sessionid,follow_list.get(i).getTargetId()));
		}
		
		profile_image = profileService.getAllProfileImage();


		for(Profile_ImageDTO dto : profile_image) {
			getAllProfilePic.put(dto.getId(),dto.getSystem_file_name());

		};
		
		mav.addObject("isFollow", isFollowList);
		mav.addObject("profile_pic",getAllProfilePic);
		mav.addObject("result", follow_list);
		mav.addObject("pageid", id);
		mav.setViewName("follow.jsp");


		return mav;	
	}

}
