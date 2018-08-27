package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.MessengerDTO;

public interface MessengerService {
	public int insertMessage(MessengerDTO dto) throws Exception;
	public List<MessengerDTO> selectmessenger(String receiver,String sender) throws Exception;
	public List<MessengerDTO> currentMessenger(String id) throws Exception;
	public String getNickname(String id) throws Exception;
	public int deleteMessenger(String id,String friendid) throws Exception;
	public int getNotReadMsg(String id,String friendid) throws Exception;
	public int setRead(String id,String friendid) throws Exception;
	public int getTotalMessage(String id) throws Exception;
}
