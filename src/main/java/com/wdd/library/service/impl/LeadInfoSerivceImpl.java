package com.wdd.library.service.impl;

import com.wdd.library.dao.LeadInfoMapper;
import com.wdd.library.pojo.LendInfo;
import com.wdd.library.service.LeadInfoSerivce;
import com.wdd.library.util.PageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class LeadInfoSerivceImpl implements LeadInfoSerivce {

    @Autowired
    private LeadInfoMapper leadInfoMapper;

    @Override
    public PageBean<LendInfo> queryLeadInfoPage(Map<String, Object> paramMap) {
        PageBean<LendInfo> pageBean = new PageBean<LendInfo>((Integer) paramMap.get("pageno"),(Integer) paramMap.get("pagesize"));

        Integer startIndex = pageBean.getStartIndex();
        paramMap.put("startIndex",startIndex);
        List<LendInfo> datas = leadInfoMapper.queryList(paramMap);
        pageBean.setDatas(datas);

        Integer totalsize = leadInfoMapper.queryCount(paramMap);
        pageBean.setTotalsize(totalsize);
        return pageBean;
    }

    @Override
    public void backBook(Map<String, Object> ret) {
        leadInfoMapper.backbook(ret);
    }
}
