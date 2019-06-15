package com.wdd.library.controller;

import com.wdd.library.pojo.Reader;
import com.wdd.library.service.ReaderService;
import com.wdd.library.util.AjaxResult;
import com.wdd.library.util.PageBean;
import com.wdd.library.util.StringUtil;
import org.activiti.engine.impl.util.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/reader")
public class ReaderController {

    @Autowired
    private ReaderService readerService;

    //跳转读者列表界面
    @RequestMapping("/readerIndex")
    public String readerIndex(){
        return "readerIndex";
    }

    //读者列表异步请求
    @RequestMapping("/listReader")
    @ResponseBody
    public String listCategory(@RequestParam(value = "page", defaultValue = "1") Integer pageno,
                               @RequestParam(value = "limit", defaultValue = "5") Integer pagesize,
                               String reader_id,String name) {

        Map<String,Object> paramMap = new HashMap();
        paramMap.put("pageno",pageno);
        paramMap.put("pagesize",pagesize);
        //判断是否为空
        if(StringUtil.isNotEmpty(reader_id))  paramMap.put("reader_id",Integer.parseInt(reader_id));
        if(StringUtil.isNotEmpty(name))  paramMap.put("name",name);
        PageBean<Reader> pageBean = readerService.listReader(paramMap);
        JSONObject obj = new JSONObject();
        obj.put("code", 0);
        obj.put("msg", "");
        obj.put("count",pageBean.getTotalsize());
        obj.put("data", pageBean.getDatas());
        return obj.toString();
    }

    //添加页面跳转
    @RequestMapping("/addReader")
    public String addreader() {
        return "/reader/addReader";
    }

    @RequestMapping("/editReader")
    public String editReader(Integer id,Model model) {
        Reader reader = readerService.selectById(id);
        model.addAttribute("reader",reader);
        model.addAttribute("code",1);
        return "/reader/addReader";
    }

    //修改读者信息
    @RequestMapping("/updateReader")
    @ResponseBody
    public AjaxResult updateReader(Reader reader) {
        AjaxResult ajaxResult = new AjaxResult();
        try{
            readerService.updateReader(reader);
            ajaxResult.setSuccess(true);
            ajaxResult.setMessage("添加成功");
        }catch (Exception e){
            e.printStackTrace();
            ajaxResult.setSuccess(false);
            ajaxResult.setMessage("添加失败");
        }
        return ajaxResult;
    }

    //显示读者信息
    @RequestMapping("/findReader")
    public String findReader(Integer id,Model model) {
        Reader reader = readerService.selectById(id);
        model.addAttribute("reader",reader);
        return "/reader/addReader";
    }

    //删除读者
    @RequestMapping("/delReader")
    @ResponseBody
    public AjaxResult delReader(Integer id) {
        AjaxResult ajaxResult = new AjaxResult();
        try{
            readerService.delReader(id);
            ajaxResult.setSuccess(true);
            ajaxResult.setMessage("添加成功");
        }catch (Exception e){
            e.printStackTrace();
            ajaxResult.setSuccess(false);
            ajaxResult.setMessage("添加失败");
        }
        return ajaxResult;
    }

}
