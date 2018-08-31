package kh.sns.interfaces;

import java.util.List;

public interface SearchDAO {
	
	public List<String> trend() throws Exception;
	public int insertSearch(String id,String keyword) throws Exception;
}
