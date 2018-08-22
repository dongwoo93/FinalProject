package kh.sns.dto;

public class MessengerDTO {
	private int message_seq;
	private String sender;
	private String receiver;
	private String message;
	private String message_date;
	
	public MessengerDTO() {
		
	}
	
	public MessengerDTO(int message_seq, String sender, String receiver, String message, String message_date) {
		super();
		this.message_seq = message_seq;
		this.sender = sender;
		this.receiver = receiver;
		this.message = message;
		this.message_date = message_date;
	}

	public int getMessage_seq() {
		return message_seq;
	}

	public void setMessage_seq(int message_seq) {
		this.message_seq = message_seq;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getMessage_date() {
		return message_date;
	}

	public void setMessage_date(String message_date) {
		this.message_date = message_date;
	}
	
	
}
