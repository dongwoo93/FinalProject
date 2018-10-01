package kh.sns.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import kh.sns.dto.MemberDTO;
import kh.sns.dto.MessengerDTO;
import kh.sns.dto.Profile_ImageDTO;
import kh.sns.interfaces.MemberService;
import kh.sns.interfaces.MessengerService;
import kh.sns.interfaces.ProfileService;
import kh.sns.websocket.WebSocket;

@Controller
public class MessengerController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MessengerService messengerService;
	
	@Autowired	private ProfileService profileService;
	
	
	@RequestMapping("/dmfriendlist.do")
	public void searchFriend(HttpServletResponse response, @RequestParam("searchtext") String searchtext, HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		System.out.println("dm 친구목록 들어옴");
		ModelAndView mav = new ModelAndView();
		String id = (String)  session.getAttribute("loginId");
		List<MemberDTO> list = null;
		List<MemberDTO> onlinefriendlist = new ArrayList<>();
		List<MemberDTO> offlinefriendlist = new ArrayList<>();
		List<String> onlinefriendimg = new ArrayList<>();
		List<String> offlinefriendimg = new ArrayList<>();
		
//		/standard.jpg
		try {
			list = memberService.selectfollowlist(id,searchtext);
			System.out.println("해당하는거잘찾았냐");
			
			for(MemberDTO tmp : list) {
				String image = profileService.selectOneProfileImage(tmp.getId());
				String allowstatus = profileService.getOneProfile(tmp.getId()).getIs_allow_status();
				if(WebSocket.onlineUser.containsKey(tmp.getId())) {
		               if(allowstatus.equals("n")) {
		                  offlinefriendlist.add(tmp);
		               }
		               else {
		                  onlinefriendlist.add(tmp);
		               }
		               if(image == ""){
		                  onlinefriendimg.add("DefaultProfile.jpg");
		               }
		               else{
		                  onlinefriendimg.add(image);
		               }
		            }
				else {
					offlinefriendlist.add(tmp);
					if(image == ""){
						offlinefriendimg.add("DefaultProfile.jpg");
					}
					else{
						offlinefriendimg.add(image);
					}
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}

		
		
		try {
			List<Object> object = new ArrayList<>();
			object.add(onlinefriendlist);
			object.add(offlinefriendlist);
			object.add(onlinefriendimg);
			object.add(offlinefriendimg);
			new Gson().toJson(object, response.getWriter());
		}catch(Exception e1) {
			e1.printStackTrace();
		}
	}
	
	@RequestMapping("/selectUserId.do")
	public void selectUserId(HttpServletResponse response, @RequestParam("nickname") String nickname, HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		System.out.println("아이디찾기들어옴");
		ModelAndView mav = new ModelAndView();
		MemberDTO dto = null;
		String imgname = null;
		List<String> result = new ArrayList<>();
		try {
			dto = memberService.selectUserId(nickname);
			imgname = profileService.selectOneProfileImage(dto.getId());
			
			result.add(dto.getId());
			result.add(imgname);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		try {
			new Gson().toJson(result, response.getWriter());
			
		}catch(Exception e1) {
			e1.printStackTrace();
		}
	}
	
	@RequestMapping("/insertMessage.do")
	public void insertMessage(HttpServletResponse response, @RequestParam("message") String message,@RequestParam("receiver") String receiver,@RequestParam("sender") String sender, HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		ModelAndView mav = new ModelAndView();
		MessengerDTO dto = new MessengerDTO(0,sender,receiver,message,"",1);
		int result = 0;
		try {
			result = messengerService.insertMessage(dto);
			if(result == 1) {
				SimpleDateFormat  format2 = new SimpleDateFormat("yyyy-MM-dd#a hh:mm:ss");
				Date to = new Date();
				new Gson().toJson(format2.format(to), response.getWriter());
			}else {
				new Gson().toJson("전송실패", response.getWriter());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
		
	@RequestMapping("/selectmessenger.do")
	public void selectmessenger(HttpServletResponse response,@RequestParam("receiver") String receiver,@RequestParam("sender") String sender, HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		ModelAndView mav = new ModelAndView();
		SimpleDateFormat  format1 = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		SimpleDateFormat  format2 = new SimpleDateFormat("yyyy-MM-dd#a hh:mm:ss");
		List<MessengerDTO> message = new ArrayList<>();
		try {
			message = messengerService.selectmessenger(receiver,sender);
			for(MessengerDTO tmp : message) {
				Date to = format1.parse(tmp.getMessage_date());
				tmp.setMessage_date(format2.format(to));
			}
			new Gson().toJson(message, response.getWriter());
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/currentMessenger.do")
	public void currentMessenger(HttpServletResponse response,@RequestParam("id") String id, HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		ModelAndView mav = new ModelAndView();
		List<MessengerDTO> list = new ArrayList<>();
		Map<String,MessengerDTO> message = new HashMap<>();
		String receiver = null;
		String nickname = null;
		int count = 0;
		try {
			list = messengerService.currentMessenger(id);
			for(MessengerDTO tmp : list) {
				System.out.println("1" + tmp);
				if(tmp.getSender().equals(id)) {
					receiver = tmp.getReceiver();
				}else {
					receiver = tmp.getSender();		
				}
				count = messengerService.getNotReadMsg(id,receiver);
				nickname = messengerService.getNickname(receiver);
				for(MessengerDTO tmp2 : list) {
					if(receiver.equals(tmp2.getReceiver()) || receiver.equals(tmp2.getSender())) {
						if(tmp.getMessage_seq() > tmp2.getMessage_seq()) {
							message.put(receiver,new MessengerDTO(tmp.getMessage_seq(),receiver,nickname,tmp.getMessage(),tmp.getMessage_date(),count));
						}
						else {
							message.put(receiver,new MessengerDTO(tmp2.getMessage_seq(),receiver,nickname,tmp2.getMessage(),tmp2.getMessage_date(),count));
						}
					}
				}
			}
			
			new Gson().toJson(message, response.getWriter());
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/deleteMessenger.do")
	public void deleteMessenger(HttpServletResponse response,@RequestParam("id") String id,@RequestParam("friendid") String friendid, HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		ModelAndView mav = new ModelAndView();
		int result = 0;
		try {
			result = messengerService.deleteMessenger(id,friendid);
			new Gson().toJson(result, response.getWriter());
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/setRead.do")
	public void setRead(HttpServletResponse response,@RequestParam("id") String id,@RequestParam("friendid") String friendid, HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		ModelAndView mav = new ModelAndView();
		int result = 0;
		try {
			result = messengerService.setRead(id,friendid);
			new Gson().toJson(result, response.getWriter());
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/getTotalMessage.do")
	public void getTotalMessage(HttpServletResponse response,@RequestParam("id") String id,HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		ModelAndView mav = new ModelAndView();
		int result = 0;
		try {
			result = messengerService.getTotalMessage(id);
			new Gson().toJson(result, response.getWriter());
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
