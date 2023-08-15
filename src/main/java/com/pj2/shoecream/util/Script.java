package com.pj2.shoecream.util;

import java.io.UnsupportedEncodingException;

public class Script { // 벡엔드단 Script
	
	private static String processMessage(String msg) {
	    String[] fields = {"mem_id=", "mem_nickname=", "mem_passwd=", "mem_name=", "mem_mtel=", "mem_email="};

	    for (String field : fields) {
	        if (msg.contains(field)) {
	            msg = msg.replace(field, "");
	        }
	    }
	    
	    msg = msg.replace("{", "").replace("}", "").replace(",", "").trim();
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
