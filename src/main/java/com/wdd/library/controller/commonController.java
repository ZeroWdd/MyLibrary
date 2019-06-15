package com.wdd.library.controller;

import com.wdd.library.pojo.Admin;
import com.wdd.library.pojo.Reader;
import com.wdd.library.service.AdminService;
import com.wdd.library.service.ReaderService;
import com.wdd.library.util.AjaxResult;
import com.wdd.library.util.Const;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
public class commonController {

    @Autowired
    private ReaderService readerService;
    @Autowired
    private AdminService adminService;

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


    //添加读者
    @RequestMapping("/submitAddReader")
    @ResponseBody
    public AjaxResult submitAddreader(Reader reader) {
        AjaxResult ajaxResult = new AjaxResult();
        try{
            readerService.addReader(reader);
            ajaxResult.setSuccess(true);
            ajaxResult.setMessage("注册成功");
        }catch(Exception e){
            e.printStackTrace();
            ajaxResult.setSuccess(false);
            ajaxResult.setMessage("注册失败");
        }
        return ajaxResult;
    }


    //登录
    @RequestMapping("/doLogin")
    @ResponseBody
    public AjaxResult list(String name, String password, String access, HttpSession session){
        AjaxResult ajaxResult = new AjaxResult();
        try{
            if(access.equals("0")){
                //管理员
                Admin ad = new Admin();
                ad.setName(name);
                ad.setPassword(Integer.parseInt(password));
                Admin admin = adminService.select(ad);
                if(admin != null){
                    session.setAttribute(Const.ADMIN,admin);
                    ajaxResult.setStatus("0");
                }else{
                    ajaxResult.setStatus("2");
                    ajaxResult.setMessage("用户名或密码错误");
                }
            }else{
                //读者
                Reader rd = new Reader();
                rd.setReader_id(Integer.parseInt(name));
                rd.setPassword(Integer.parseInt(password));
                Reader reader = readerService.select(rd);
                if(reader != null){
                    session.setAttribute(Const.READER,reader);
                    ajaxResult.setStatus("1");
                }else{
                    ajaxResult.setStatus("2");
                    ajaxResult.setMessage("用户名或密码错误");
                }
            }
        }catch (Exception e){
            e.printStackTrace();
            ajaxResult.setStatus("3");
            ajaxResult.setMessage("服务器异常,请改天登录");
        }

        return ajaxResult;
    }

    //推出
    @RequestMapping("/loginout")
    public String loginout(HttpSession session){
        session.invalidate();
        return "login";
    }
}
