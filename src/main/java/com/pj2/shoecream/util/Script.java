package com.pj2.shoecream.util;

import java.io.UnsupportedEncodingException;

public class Script { // 벡엔드단 Script
	
	private static String processMessage(String msg) {
	    if (msg.contains("mem_id=")) {
	        String errorMessage = msg.substring(msg.indexOf('=') + 1);
	        errorMessage = errorMessage.replace("}", "");
	        return errorMessage;
	    }
	    return msg;
	}
	
    public static String back(String msg) {
    	msg = processMessage(msg);
        String encodedMsg = "";
        try {
            encodedMsg = java.net.URLEncoder.encode(msg, "UTF-8").replace("+", "%20");
        } catch (UnsupportedEncodingException ex) {
            ex.printStackTrace();
        }
        StringBuffer sb = new StringBuffer();
        sb.append("<script>");
        sb.append("alert(decodeURIComponent('" + encodedMsg + "'));");
        sb.append("history.back();");
        sb.append("</script>");
        return sb.toString();
    }
}
