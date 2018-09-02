package kh.sns.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import kh.sns.interfaces.SearchDAO;

@Repository
public class ISearchDAO implements SearchDAO {
 

	@Autowired
	private JdbcTemplate template;

	@Override
	public List<String> trend() throws Exception {  
		String sql = "select keyword from search where to_char(searchdate,'yyyymmdd') = to_char(sysdate,'yyyymmdd') group by keyword order by count(keyword)";
		return template.query(sql, new RowMapper<String>() {  

			@Override
			public String mapRow(ResultSet rs, int rowNum) throws SQLException {
				return rs.getString("keyword");
			}
			
		});
	} 
	
	public int insertSearch(String id,String keyword) throws Exception {
		String sql = "insert into search values(?,default)";
		return template.update(sql, keyword);
	}
	
}
