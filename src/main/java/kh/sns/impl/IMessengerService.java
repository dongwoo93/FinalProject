package kh.sns.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.sns.dto.MessengerDTO;
import kh.sns.interfaces.MessengerDAO;
import kh.sns.interfaces.MessengerService;

@Service
public class IMessengerService implements MessengerService{
	
	@Autowired
	private MessengerDAO dao;

	@Override
	public int insertMessage(MessengerDTO dto) throws Exception{
		return this.dao.insertMessage(dto);
	}
	
	@Override
	public List<MessengerDTO> selectmessenger(String receiver,String sender) throws Exception{
		return this.dao.selectmessenger(receiver,sender);
	}
	
	@Override
	public List<MessengerDTO> currentMessenger(String id) throws Exception{
		return this.dao.currentMessenger(id);
	}
	
	@Override
	public String getNickname(String id) throws Exception{
		return this.dao.getNickname(id);
	}
	
	@Override
	public int deleteMessenger(String id,String friendid) throws Exception{
		return this.dao.deleteMessenger(id,friendid);
	}
	
	@Override
	public int getNotReadMsg(String id,String friendid) throws Exception{
		return this.dao.getNotReadMsg(id,friendid);
	}
	
	@Override
	public int setRead(String id,String friendid) throws Exception{
		return this.dao.setRead(id,friendid);
	}
	
	@Override
	public int getTotalMessage(String id) throws Exception{
		return this.dao.getTotalMessage(id);
	}
}
