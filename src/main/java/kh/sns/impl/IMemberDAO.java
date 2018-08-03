package kh.sns.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import kh.sns.interfaces.MemberDAO;

@Repository
public class IMemberDAO implements MemberDAO {
	
	@Autowired
	private JdbcTemplate template;

}
