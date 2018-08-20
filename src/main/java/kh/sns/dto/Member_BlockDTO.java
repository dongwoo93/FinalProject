package kh.sns.dto;

public class Member_BlockDTO {
	private String id, target_id, block_date;

	public Member_BlockDTO() {
		super();
	}

	public Member_BlockDTO(String id, String target_id, String block_date) {
		super();
		this.id = id;
		this.target_id = target_id;
		this.block_date = block_date;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTarget_id() {
		return target_id;
	}

	public void setTarget_id(String target_id) {
		this.target_id = target_id;
	}

	public String getBlock_date() {
		return block_date;
	}

	public void setBlock_date(String block_date) {
		this.block_date = block_date;
	}
	
	

}
