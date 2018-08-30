package kh.sns.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.sns.dto.Member_CalendarDTO;
import kh.sns.interfaces.Member_CalendarDAO;
import kh.sns.interfaces.Member_CalendarService;

@Service
public class IMember_CalendarService implements Member_CalendarService {
	
	@Autowired
	private Member_CalendarDAO dao;

	@Override
	public int insertCalendar(Member_CalendarDTO dto) throws Exception {
		return dao.insertCalendar(dto);
	}

	@Override
	public List<Member_CalendarDTO> selectCalendar(String id) throws Exception {
		return dao.selectCalendar(id);
	}

	@Override
	public int updateCalendar(Member_CalendarDTO dto) throws Exception {
		return dao.updateCalendar(dto);
	}

	@Override
	public String getCalendarSeq() throws Exception {
		return dao.getCalendarSeq();
	}

	@Override
	public int deleteCalendar(String seq) throws Exception {
		return dao.deleteCalendar(seq);
	}
	
}
