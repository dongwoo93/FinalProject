package kh.sns.interfaces;

import java.util.List;

public interface SearchService {
	
	public List<String> trend() throws Exception;
	public int insertSearch(String id,String keyword) throws Exception;

}
