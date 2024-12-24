package com.example.app.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.app.mapper.CalendarMapper;
import com.example.app.vo.Calendar;

@Service
public class CalendarService {
	@Autowired
	private CalendarMapper calendarMapper;

	public List<Calendar> getCalendarList() {
		return calendarMapper.selectCalendarList();
	}

	
}
