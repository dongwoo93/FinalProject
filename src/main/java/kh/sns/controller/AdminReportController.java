package kh.sns.controller;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import kh.sns.dto.AdminReportDTO;
import kh.sns.dto.AdminReportOutputSet;
import kh.sns.dto.AdminReportResultCode;
import kh.sns.dto.BoardBusinessDTO;
import kh.sns.dto.JQueryPieChartVO;
import kh.sns.dto.MemberBusinessDTO;
import kh.sns.interfaces.AdminReportsService;
import kh.sns.interfaces.BoardBusinessService;
import kh.sns.interfaces.MemberBusinessService;

@Controller
public class AdminReportController {
	
	@Autowired	AdminReportsService ars;
	@Autowired	MemberBusinessService mbs;
	@Autowired	BoardBusinessService bbs;
	
	@RequestMapping("/report.admin")
	public ModelAndView reportManagementMain(HttpSession session) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		// 나중에 관리 권한을 가진 사람들만 접속되도록 변경
		if(session.getAttribute("loginId") == null) {
			mav.setViewName("redirect:에러페이지");
			return mav;
		}
		
		List<JQueryPieChartVO> pieList = ars.getAdminReportProcessedForPieChartVO(1);
		pieList.forEach(System.out::println);
		
		List<AdminReportResultCode> resultList = ars.getResultCodeList();
		resultList.forEach(System.out::println);
		
		List<Integer> acceptedCounts = ars.getAllAcceptedCounts();
		
		AdminReportOutputSet aros = ars.getAllReports();
		
		mav.addObject("list", aros.getReportList());
		mav.addObject("code", aros.getCodeList());
		mav.addObject("result", aros.getResultList());
		mav.addObject("pieChartObject", new Gson().toJson(pieList));
		mav.addObject("resultList", resultList);
		mav.addObject("acceptedCounts", acceptedCounts);
		mav.setViewName("admin_report.jsp");
		return mav;
	}
	
	@RequestMapping("/chartRenew.ajax")
	public void reportManagementMain(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		List<JQueryPieChartVO> list = ars.getAdminReportProcessedForPieChartVO(Integer.parseInt(request.getParameter("chart")));
		new Gson().toJson(list, response.getWriter());
		
	}
	
	@RequestMapping("/manageAnReport.ajax")
	public void manageAnReportAjax(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		
		int reportSeq = Integer.parseInt(request.getParameter("reportSeq"));
		int resultCode = Integer.parseInt(request.getParameter("resultCode"));
		String managerComment = request.getParameter("managerComment");
		
		AdminReportDTO report = ars.getOneReport(reportSeq);
		report.setResultCode(resultCode);
		report.setAdminComment(managerComment);
		
		System.out.println(reportSeq + "(" + resultCode + "): "  + managerComment);
		System.out.println(report);		
		
		PrintWriter xout = response.getWriter();
		xout.print(ars.manageAnReport(report));
		
	}
	
	@RequestMapping("/idunno.test")
	public void writeProcBoard(HttpServletRequest request, HttpServletResponse response) {			
		
		try {
			PrintWriter out = response.getWriter(); 
			List<MemberBusinessDTO> list = mbs.getAllMemberBiz();
			
			list.forEach(out::println);

		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@RequestMapping("/send.admin")
	public void sendReport(HttpServletResponse response, AdminReportDTO dto) throws Exception {
		response.setCharacterEncoding("UTF-8");
		int result = ars.insertAnReport(dto);
		if (result == 1) {
			response.getWriter().print("신고가 완료되었습니다.");
		}else {
			response.getWriter().print("신고에 실패하였습니다.");
		}
		response.getWriter().flush();
		response.getWriter().close();
	}
	
	@RequestMapping("/manageAd.admin")
	public ModelAndView manageAdvertisement(HttpSession session) throws Exception {
		
		List<BoardBusinessDTO> bbiz = bbs.getAllBoardBiz();
		List<JQueryPieChartVO> defaultAdPie = ars.getAdminReportProcessedForPieChartVO(21);
		
		ModelAndView mav = new ModelAndView();
		
		// 나중에 관리 권한을 가진 사람들만 접속되도록 변경
		if(session.getAttribute("loginId") == null) {
			mav.setViewName("redirect:에러페이지");
			return mav;
		}
		
		mav.setViewName("admin_manage_ad.jsp");
		mav.addObject("pieChartObject", new Gson().toJson(defaultAdPie));
		mav.addObject("bList", bbiz);
		return mav;
	}
	
	@RequestMapping("/evaluateAnAd.admin")
	public ModelAndView manageAnAdvertisement(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int boardBizSeq = Integer.parseInt(request.getParameter("boardBizSeq"));
		String isAllowed = request.getParameter("isAllowed");
		String evalMessage = request.getParameter("evalMessage");
		
		BoardBusinessDTO bbiz = new BoardBusinessDTO();
		bbiz.setIsAllowed(isAllowed);
		bbiz.setRejectedMessage(evalMessage);
		bbiz.setBoardBizSeq(boardBizSeq);
		
		int result = bbs.updateAnEvaluationResult(bbiz);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:manageAd.admin");
		mav.addObject("evalResult", result);
		return mav;

	}
	
	@RequestMapping("/redirectAdUrl")
	public ModelAndView redirectAdurl(String r, int bizseq) {
		ModelAndView mav = new ModelAndView();
		System.out.println(r);
		System.out.println(bizseq);
		try {
			BoardBusinessDTO bbiz = bbs.selectAnBoardBiz(bizseq);
			int currentCount = bbiz.getClickCount();
			bbiz.setClickCount(currentCount + 1);
			int result = bbs.updateClickCount(bbiz);
			System.out.println(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(r.startsWith("https://") || r.startsWith("http://")) {
			mav.setViewName("redirect:" + r);
		} else {
			mav.setViewName("redirect:http://" + r);
		}
		
		return mav;
			
	}
	
	
}
