package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.Member_CalendarDTO;

public interface Member_CalendarService {
	public String getCalendarSeq() throws Exception;
	public int insertCalendar(Member_CalendarDTO dto) throws Exception;
	public List<Member_CalendarDTO> selectCalendar(String id) throws Exception;
	public int updateCalendar(Member_CalendarDTO dto) throws Exception;
	public int deleteCalendar(String seq) throws Exception;
}
