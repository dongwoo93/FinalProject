package kh.sns.interfaces;

import java.util.List;

public interface SearchDAO {
	
	public List<String> trend() throws Exception;
	public int insertSearch(String keyword) throws Exception;
}
