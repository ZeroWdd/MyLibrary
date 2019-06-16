package com.wdd.library.service;

import com.wdd.library.pojo.LendInfo;
import com.wdd.library.util.PageBean;

import java.util.Map;

public interface LeadInfoSerivce {
    PageBean<LendInfo> queryLeadInfoPage(Map<String, Object> paramMap);

    void backBook(Map<String, Object> ret);
}
