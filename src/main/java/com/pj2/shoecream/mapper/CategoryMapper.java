package com.pj2.shoecream.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface CategoryMapper {

  List<Map<String, Object>> selectLcList();

  List<Map<String, Object>> selectMcList(int code);

  List<Map<String, Object>> selectScList(int code);

}
