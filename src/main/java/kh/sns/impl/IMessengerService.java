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
	public int insertMessage(MessengerDTO dto) {
		return this.dao.insertMessage(dto);
	}
	
	@Override
	public List<MessengerDTO> selectmessenger(String receiver,String sender) {
		return this.dao.selectmessenger(receiver,sender);
	}
	
	@Override
	public List<MessengerDTO> currentMessenger(String id) {
		return this.dao.currentMessenger(id);
	}
}
