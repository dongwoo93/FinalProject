package kh.sns.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.sns.interfaces.Member_TagsDAO;
import kh.sns.interfaces.Member_TagsService;

@Service
public class IMember_TagsService implements Member_TagsService{
	
	@Autowired
	private Member_TagsDAO dao;
}
