package com.example.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class PublicCalendarController {

	@GetMapping({"/calendar","/"})
	public String publicCalendar() {
		return "calendar";
	}
	
	@GetMapping("/calendarDetail")
	public String scheduleDetail(/*@RequestParam(name="scheduleNo") String scheduleNo, Model model*/) {
		//log.debug(Debug.PHA + "scheduleDetail controller scheduleNo--> " + scheduleNo + Debug.END);
		//
		// 일정 상세 조회
		//Schedule schedule =  scheduleService.getScheduleDetail(scheduleNo);
		//log.debug(Debug.PHA + "scheduleDetail controller schedule--> " + schedule + Debug.END);
		
		// model담아주기
		//model.addAttribute("scheduleOne", schedule);

		return "calendarDetail";
	}
}
