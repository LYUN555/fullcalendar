package com.example.app.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Calendar {

	
	private int scheduleNo;
    private int empNo;
    private int typeNo;
    private String scheduleTitle;
    private String description;
    private String startDate;
    private String endDate;
}
