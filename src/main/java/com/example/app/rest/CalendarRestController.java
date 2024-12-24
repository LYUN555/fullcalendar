package com.example.app.rest;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.app.service.CalendarService;
import com.example.app.vo.Calendar;

@RestController
public class CalendarRestController {
	
	@Autowired
	private CalendarService calendarService;

	  @GetMapping("/scheduleCalList")
	    public List<Calendar> getScheduleList() {
	        List<Calendar> scheduleList = new ArrayList<>();

	        // 더미 데이터
	        scheduleList.add(new Calendar(1, 101, 1, "회의", "팀 회의", "2024-12-25T10:00", "2024-12-26T23:59"));
	        scheduleList.add(new Calendar(2, 102, 2, "행사", "송년회", "2024-12-28T18:00", "2024-12-30T23:00"));
	        scheduleList.add(new Calendar(3, 103, 3, "점검", "서버 점검", "2024-12-30T01:00", "2024-12-30T05:00"));

	        return scheduleList;
	    }
}
