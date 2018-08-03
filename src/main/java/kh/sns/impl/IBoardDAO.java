package kh.sns.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import kh.sns.interfaces.BoardDAO;

@Repository
public class IBoardDAO implements BoardDAO  {
	
	@Autowired
	private JdbcTemplate template;

}
