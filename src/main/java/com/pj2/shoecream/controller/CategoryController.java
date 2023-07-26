package com.pj2.shoecream.controller;

import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pj2.shoecream.service.CategoryService;

@Controller
public class CategoryController {

    @Autowired
    private CategoryService service;
    
    @ResponseBody
    @GetMapping("getMcList")
    public String getMcList(
        @RequestParam(value = "lc_code") int code) {
      System.out.println(code);
      List<Map<String, Object>> mc_category = service.getMcList(code);
      JSONArray jsonArray = new JSONArray(mc_category);
      return jsonArray.toString(); 
    }
    
    @ResponseBody
    @GetMapping("getScList")
    public String getScList(
        @RequestParam(value = "mc_code") int code) {
      System.out.println("small"+code);
      List<Map<String, Object>> sc_category = service.getScList(code);
      JSONArray jsonArray = new JSONArray(sc_category);
      return jsonArray.toString(); 
    }
}
