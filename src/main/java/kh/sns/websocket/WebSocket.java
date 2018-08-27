package kh.sns.websocket;

import java.util.HashMap;
import java.util.Map;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;


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
		String receiver = message.split("뇽뇽뇽뇽123뇽뇽뇽뇽")[0];
		System.out.println("receiver : " + receiver);
		String msg = message.split("뇽뇽뇽뇽123뇽뇽뇽뇽")[1];
		System.out.println("msg : " + msg);
		for(String tmp : onlineUser.keySet()) {
			if(tmp.equals(receiver)) {
				System.out.println(tmp);
				onlineUser.get(tmp).getBasicRemote().sendText(msg);
			}
		}
	}

	@OnClose
	public void handleClose(Session session) {
		String userid = session.getRequestParameterMap().get("loginId").get(0);
		onlineUser.remove(userid);
	}

	public void handleError(Throwable t) {
	}
}