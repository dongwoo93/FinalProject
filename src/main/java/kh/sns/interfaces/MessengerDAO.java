package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.MessengerDTO;

public interface MessengerDAO {
	public int insertMessage(MessengerDTO dto);

	public List<MessengerDTO> selectmessenger(String receiver, String sender);

}
