package com.wdd.library.dao;

import com.wdd.library.pojo.LendInfo;

import java.util.List;
import java.util.Map;

public interface LeadInfoMapper {
    List<LendInfo> queryList(Map<String, Object> paramMap);

    Integer queryCount(Map<String, Object> paramMap);

    void backbook(Map<String, Object> ret);
}
