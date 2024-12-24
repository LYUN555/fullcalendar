package com.example.app.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.app.vo.Calendar;
@Mapper
public interface CalendarMapper {

	public List<Calendar> selectCalendarList();

}
