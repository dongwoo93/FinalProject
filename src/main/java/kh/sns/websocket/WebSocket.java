package kh.sns.websocket;

import java.util.HashMap;
import java.util.Map;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.springframework.beans.factory.annotation.Autowired;

import kh.sns.dto.MemberDTO;
import kh.sns.interfaces.MemberService;


//POJO - Plain Old Java Object

@ServerEndpoint(value = "/websocket")
public class WebSocket{
	public static Map<String,Session> onlineUser = new HashMap<>();
	

	@OnOpen
	public void handleOpen(Session session) {
		String userid = session.getRequestParameterMap().get("loginId").get(0);
		onlineUser.put(userid, session);
		System.out.println(userid + " : online");
	}

	@OnMessage
	public void handleMessage(String message) throws Exception{
		System.out.println(message);
		String receiver = message.split(":")[0];
		String msg = message.split(":")[1];

		for(String tmp : onlineUser.keySet()) {
			if(tmp.equals(receiver)) {
				onlineUser.get(tmp).getBasicRemote().sendText(msg);
			}
		}
	}

	@OnClose
	public void handleClose(Session session) {
	}

	public void handleError(Throwable t) {
	}
}
