package com.pj2.shoecream.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pj2.shoecream.service.AlramService;
import com.pj2.shoecream.vo.AlramVO;

@Controller
public class AlramController {
	
	@Autowired
	private AlramService service;
	
	
	private static final Logger logger = LoggerFactory.getLogger(AlramController.class);
	
	@ResponseBody
    @RequestMapping(value= "registerAlram", method = RequestMethod.POST, produces = "application/text; charset=UTF-8")
	public String registerAlram(AlramVO alram) {
		int insertCount = service.registerAlram(alram);
		if (insertCount > 0) {
			logger.info("알람 추가 완료");
			return "1";
		} else {
			logger.info("알람 추가 실패");
			return "0";
		}
	}
}
