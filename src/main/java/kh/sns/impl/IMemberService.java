package kh.sns.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.sns.dto.MemberDTO;
import kh.sns.dto.ProfileDTO;
import kh.sns.interfaces.MemberDAO;
import kh.sns.interfaces.MemberService;
import kh.sns.interfaces.ProfileDAO;

@Service
public class IMemberService implements MemberService{

	@Autowired
	private MemberDAO dao;

	@Autowired
	private ProfileDAO pdao;


	@Override
	public int loginMem(MemberDTO dto) {
		return this.dao.loginMem(dto);

	}

	@Override
	public MemberDTO getOneMember(String id) throws Exception {

		return dao.getOneMember(id);
	}

	// @트랜잭셔널
	@Override
	public int updateOneMemberProfile(MemberDTO member, ProfileDTO profile) throws Exception {
		int result1 = dao.updateOneMemberProfile(member);
		int result2 = pdao.updateOneAdvancedProfile(profile);
		return result1 * result2;
	}

	@Override
	public int updateOneMemberPassword(MemberDTO member) throws Exception {		
		return dao.updateOneMemberPassword(member);
	}

	@Override
	public int checkEmailDuplicated(String email, String currentUserId) throws Exception {
		return dao.checkEmailDuplicated(email, currentUserId);
	}


	@Override
	public int signUp(MemberDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return this.dao.signUp(dto);
	}


	@Override
	public int insertProfile(String id) throws Exception {
		// TODO Auto-generated method stub
		return this.dao.insertProfile(id);
	}


	@Override
	public int isIdExist(String id) {
		// TODO Auto-generated method stub
		return dao.isIdExist(id);
	}



	@Override
	public int isNickExist(String nick) {
		// TODO Auto-generated method stub
		return dao.isNickExist(nick);
	}



	@Override
	public int isEmailExist(String email) {
		// TODO Auto-generated method stub
		return dao.isEmailExist(email);
	}

	@Override
	public int findPw(MemberDTO dto) {
		// TODO Auto-generated method stub

		return dao.findPw(dto);
	}

	@Override
	public String changePass(String id) throws Exception {
		// TODO Auto-generated method stub
		return dao.changePass(id);
	}

	@Override
	public List<MemberDTO> findId(String name,String email) throws Exception{
		// TODO Auto-generated method stub
		return dao.findId(name, email);
	}


	@Override
	public List<MemberDTO> selectfriendlist(String id,String searchtext) throws Exception{
		return this.dao.selectfriendlist(id,searchtext);
	}

	@Override
	public List<MemberDTO> findMember(String searchtext) throws Exception {
		return dao.findMember(searchtext);
	}

	@Override
	public List<MemberDTO> selectfollowlist(String id,String searchtext) throws Exception{
		return this.dao.selectfollowlist(id,searchtext);
	}

	// My_aticle
	@Override
	public List<MemberDTO> myNick_Id(String id) throws Exception {
		// TODO Auto-generated method stub
		return dao.myNick_Id(id);
	}



	//	@Override
	//	public boolean isIdExist(String id) {
	//		
	//		return this.isIdExist(id);
	//	}

	@Override
	public MemberDTO selectUserId(String nickname) throws Exception {

		return dao.selectUserId(nickname);
	}

	@Override
	// @Transactional
	public int updateDisabledInfo(MemberDTO member, boolean isToggleToNo) throws Exception {
		if(isToggleToNo) {
			member.setIsDisabledAccount("n");
			return dao.updateDisabledInfo(member);
		} else {			
			int pwd_result = dao.checkIdPwd(member);
			System.out.println(member.getPw());
			System.out.println(pwd_result);
			int udiResult = 0;
			member.setIsDisabledAccount("y");
			if(pwd_result > 0) {
				udiResult = dao.updateDisabledInfo(member);
			} 			
			return pwd_result * udiResult;
		}
		
		
	}

	@Override
	public String extractEmail(String id) throws Exception {
		// TODO Auto-generated method stub
		
		return dao.extractEmail(id);
	}


}

