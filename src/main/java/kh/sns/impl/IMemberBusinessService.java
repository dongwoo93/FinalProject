package kh.sns.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.sns.dto.MemberBusinessDTO;
import kh.sns.interfaces.MemberBusinessDAO;
import kh.sns.interfaces.MemberBusinessService;

@Service
public class IMemberBusinessService implements MemberBusinessService {
	
	@Autowired	private MemberBusinessDAO mbdao; 

	@Override
	public int insertAnMemberBiz(MemberBusinessDTO mbiz) throws Exception {
		return mbdao.insertAnMemberBiz(mbiz);
	}

	@Override
	public int delteAnMemberBiz(MemberBusinessDTO mbiz) throws Exception {
		return mbdao.delteAnMemberBiz(mbiz);
	}

	@Override
	public int updateAnMemberBiz(MemberBusinessDTO mbiz) throws Exception {
		return mbdao.updateAnMemberBiz(mbiz);
	}

	@Override
	public MemberBusinessDTO selectAnMemberBiz(int memberBizSeq) throws Exception {
		return mbdao.selectAnMemberBiz(memberBizSeq);
	}
	
	@Override
	public MemberBusinessDTO selectAnMemberBiz(String memberId) throws Exception {
		return mbdao.selectAnMemberBiz(memberId);
	}

	@Override
	public List<MemberBusinessDTO> getAllMemberBiz() throws Exception {
		return mbdao.getAllMemberBiz();
	}

	@Override
	public List<MemberBusinessDTO> getMemberBizByRange(int start, int end) throws Exception {
		return mbdao.getMemberBizByRange(start, end);
	}
	
}
