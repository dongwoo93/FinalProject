package kh.sns.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.OnClose;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.springframework.stereotype.Controller;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;


//POJO - Plain Old Java Object

@Controller
@ServerEndpoint("/websocket")
public class WebSocket{
	public static Map<String,Session> onlineUser = new HashMap<>();
	
	private HttpSession httpSession;
	
	private String id = null; 
    
    public void setId(String id) {
    	this.id = id;
    	
    }

	public void setHttpSession(HttpSession httpSession) {
		if (this.httpSession != null) {
			throw new IllegalStateException("HttpSession has already been set!");
		}

		this.httpSession = httpSession;
	}
	@OnOpen
	public void handleOpen(Session session) {
		onlineUser.put(id,session);
	}
	
	@OnClose
	public void handleClose(Session session) {

	}
	
	public void handleError(Throwable t) {
		
	}
}
