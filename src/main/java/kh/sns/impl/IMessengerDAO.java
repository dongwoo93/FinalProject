package kh.sns.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import kh.sns.dto.MemberDTO;
import kh.sns.dto.MessengerDTO;
import kh.sns.interfaces.MessengerDAO;

@Repository
public class IMessengerDAO implements MessengerDAO{
	
	@Autowired
	private JdbcTemplate template;

	@Override
	public int insertMessage(MessengerDTO dto) {
		String sql = "insert into messenger values(messenger_seq.nextval,?,?,?,default) ";
		return template.update(sql,dto.getSender(),dto.getReceiver(),dto.getMessage());
	}
	
	@Override
	public List<MessengerDTO> selectmessenger(String receiver,String sender){
		String sql = "select * from messenger where (receiver=? and sender=?) or (receiver=? and sender=?) order by message_seq";
		
		return template.query(sql, new String[] {receiver,sender,sender,receiver}, new RowMapper<MessengerDTO>() {

			@Override
			public MessengerDTO mapRow(ResultSet rs, int arg1) throws SQLException {
				MessengerDTO dto = new MessengerDTO(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5));   
				return dto;
			}
			
		});
	}

}
