package kh.sns.dto;

import java.util.List;

public class Board_Tags2DTO {
	private String tag;
	private String count;
	private List<String> seqArr;
	
	
	public Board_Tags2DTO() {
		super();
	}


	public String getTag() {
		return tag;
	}


	public void setTag(String tag) {
		this.tag = tag;
	}


	public String getCount() {
		return count;
	}


	public void setCount(String count) {
		this.count = count;
	}


	public List<String> getSeqArr() {
		return seqArr;
	}


	public void setSeqArr(List<String> seqArr) {
		this.seqArr = seqArr;
	}
	
	

}
