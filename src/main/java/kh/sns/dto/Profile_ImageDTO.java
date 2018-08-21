package kh.sns.dto;

public class Profile_ImageDTO {
	private String id, original_file_name, system_file_name, is_selected , apply_date;

	public Profile_ImageDTO() {
		super();
	}

	public Profile_ImageDTO(String id, String original_file_name, String system_file_name, String is_selected, String apply_date) {
		super();
		this.id = id;
		this.original_file_name = original_file_name;
		this.system_file_name = system_file_name;
		this.is_selected = is_selected;
		this.apply_date = apply_date;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getOriginal_file_name() {
		return original_file_name;
	}

	public void setOriginal_file_name(String original_file_name) {
		this.original_file_name = original_file_name;
	}

	public String getSystem_file_name() {
		return system_file_name;
	}

	public void setSystem_file_name(String system_file_name) {
		this.system_file_name = system_file_name;
	}

	public String getIs_selected() {
		return is_selected;
	}

	public void setIs_selected(String is_selected) {
		this.is_selected = is_selected;
	}

	public String getApply_date() {
		return apply_date;
	}

	public void setApply_date(String apply_date) {
		this.apply_date = apply_date;
	}

	
	
	
}
