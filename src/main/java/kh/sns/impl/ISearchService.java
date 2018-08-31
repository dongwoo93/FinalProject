package kh.sns.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.sns.interfaces.SearchDAO;
import kh.sns.interfaces.SearchService;

@Service
public class ISearchService implements SearchService {

	@Autowired
	private SearchDAO dao;
	
	@Override
	public List<String> trend() throws Exception {
		return dao.trend();
	}
	
	public int insertSearch(String keyword) throws Exception{
		return dao.insertSearch(keyword);
	}
}
