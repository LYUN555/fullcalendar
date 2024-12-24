package com.example.app.rest;

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

	@GetMapping("/scheduleList")
	public List<Calendar> calendarList() {
		List<Calendar> list = calendarService.getCalendarList();
		return list;
	}
}
