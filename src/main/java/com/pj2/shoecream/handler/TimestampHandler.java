package com.pj2.shoecream.handler;

import java.sql.Timestamp;
import java.time.Instant;
import java.time.LocalDateTime;
import java.util.TimeZone;

public class TimestampHandler {

	
	// Timestamp 를 LocalDateTime 로 변환
	public LocalDateTime tStamp2Ldt(Timestamp timestamp) {
		if(timestamp == null) {
			return null;
		}
		return LocalDateTime.ofInstant(Instant.ofEpochSecond(timestamp.getTime())
				,TimeZone.getDefault().toZoneId());
	}
	
	
	// 날짜 문자열 시간 문자열 , 그리고 각각 구분되는 문자(ex 2022-03-21 일때 중간에 "-" 문자)
	// 를 입력받아 분리하고 LocalDateTime 으로 반환해주는 핸들러
	// 단! 날짜는 년,월,일 시간은 시,분,초 로 받음
	public LocalDateTime str2Ldt(String day,String daySplitStr,String time, String timeSplitStr) {
		if(day == null || daySplitStr == null || time == null || timeSplitStr == null
				|| day.equals("")|| daySplitStr.equals("")|| time.equals("")|| timeSplitStr.equals("")) {
			return null;
		}
		String[] daySplit = day.split(daySplitStr);
		String[] timeSplit = time.split(timeSplitStr);
		return LocalDateTime.of(
				Integer.parseInt(daySplit[0]), 
				Integer.parseInt(daySplit[1]),
				Integer.parseInt(daySplit[2]),
				Integer.parseInt(timeSplit[0]),
				Integer.parseInt(timeSplit[1]),
				Integer.parseInt(timeSplit[2].replace(".",""))
				);	
	}

}
