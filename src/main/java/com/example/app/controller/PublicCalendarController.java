package com.example.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PublicCalendarController {

	@GetMapping({"/calendar","/"})
	public String publicCalendar() {
		return "calendar";
	}
}
