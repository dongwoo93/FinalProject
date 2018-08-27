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
	public int insertMessage(MessengerDTO dto) throws Exception{
		String sql = "insert into messenger values(messenger_seq.nextval,?,?,?,default,default) ";
		return template.update(sql,dto.getSender(),dto.getReceiver(),dto.getMessage());
	} 
	
	@Override
	public List<MessengerDTO> selectmessenger(String receiver,String sender) throws Exception{
		String sql = "select * from messenger where (receiver=? and sender=?) or (receiver=? and sender=?) order by message_seq";
		
		return template.query(sql, new String[] {receiver,sender,sender,receiver}, new RowMapper<MessengerDTO>() {

			@Override
			public MessengerDTO mapRow(ResultSet rs, int arg1) throws SQLException {
				MessengerDTO dto = new MessengerDTO(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getInt(6));   
				return dto;
			}
			
		});
	}
	
	@Override
	public List<MessengerDTO> currentMessenger(String id) throws Exception{
		String sql = "select * from messenger where message_seq in(select max(message_seq) from messenger where (sender=?) or (receiver=?) group by sender, receiver) order by message_seq";
		
		return template.query(sql, new String[] {id,id}, new RowMapper<MessengerDTO>() {

			@Override
			public MessengerDTO mapRow(ResultSet rs, int arg1) throws SQLException {
				MessengerDTO dto = new MessengerDTO(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getInt(6));   
				return dto;
			} 
			
		});
	}
	
	@Override
	public String getNickname(String id) throws Exception{
		String sql = "select nickname from member where id = ?";
		return template.query(sql, new Object[] {id}, new RowMapper<String>() {
			@Override
			public String mapRow(ResultSet rs, int rowNum) throws SQLException {
				String tmp = rs.getString(1);
				return tmp;
			}
		}).get(0);
		
	}
	
	@Override
	public int deleteMessenger(String id,String friendid) throws Exception{
		String sql = "delete from messenger where (sender=? and receiver=?) or (sender=? and receiver=?)";
		return template.update(sql,id,friendid,friendid,id);
	} 
	
	@Override
    public int getNotReadMsg(String id,String friendid) throws Exception{
       String sql = "select count(read) from messenger where (sender = ?) and (receiver=?) and (read=1)";
       return template.query(sql, new Object[] {friendid,id}, new RowMapper<Integer>() {
         
          public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {
             return rs.getInt(1);
          }
       }).get(0);
       
    }
	
	@Override
	public int setRead(String id,String friendid) throws Exception{
		String sql = "update messenger set read=0 where (sender=?) and (receiver=?) and (read=1)";
		return template.update(sql,friendid,id);
	}
	
	@Override
    public int getTotalMessage(String id) throws Exception{
       String sql = "select count(read) from messenger where (receiver=?) and (read=1)";
       return template.query(sql, new Object[] {id}, new RowMapper<Integer>() {
         
          public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {
             return rs.getInt(1);
          }
       }).get(0);
       
    }

}
