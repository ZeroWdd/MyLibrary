package com.wdd.library.controller;

import com.wdd.library.service.ReaderService;
import com.wdd.library.util.AjaxResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class commonController {

    @Autowired
    private ReaderService readerService;

    //跳转登录界面
    @RequestMapping("/toLogin")
    public String login(){
        return "login";
    }

    //跳转注册界面
    @RequestMapping("/toRegister")
    public String toRegister(){
        return "register";
    }

    //注册是查询是否存在该读者
    @RequestMapping("/checkReader")
    @ResponseBody
    public AjaxResult checkreader(Integer reader_id) {
        AjaxResult ajaxResult = new AjaxResult();
        int count=readerService.checkReader(reader_id);
        if(count==0){
            ajaxResult.setSuccess(true);
        }else{
            ajaxResult.setSuccess(false);
            ajaxResult.setMessage("当前学号已被注册!");
        }
        return ajaxResult;
    }
}
