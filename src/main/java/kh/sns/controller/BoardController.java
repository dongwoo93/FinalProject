package kh.sns.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import kh.sns.interfaces.BoardService;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;

}
