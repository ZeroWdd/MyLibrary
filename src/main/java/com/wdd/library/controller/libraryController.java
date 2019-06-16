package com.wdd.library.controller;

import com.wdd.library.pojo.Book;
import com.wdd.library.pojo.Category;
import com.wdd.library.pojo.LendInfo;
import com.wdd.library.pojo.Reader;
import com.wdd.library.service.BookService;
import com.wdd.library.service.LendInfoSerivce;
import com.wdd.library.util.AjaxResult;
import com.wdd.library.util.Const;
import com.wdd.library.util.PageBean;
import com.wdd.library.util.StringUtil;
import org.activiti.engine.impl.util.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/library")
public class libraryController {

    @Autowired
    private BookService bookService;
    @Autowired
    private LendInfoSerivce lendInfoSerivce;


    @RequestMapping("/index")
    public String index(HttpSession session){
        //获取类别
        List<Category> categoryList = bookService.listCategory();
        session.setAttribute(Const.CATEGORY,categoryList);
        return "index";
    }

    //显示全部图书
    @RequestMapping(value = "/listBook")
    @ResponseBody
    public String listBook(@RequestParam(value = "page", defaultValue = "1") Integer pageno,
                           @RequestParam(value = "limit", defaultValue = "5") Integer pagesize,
                           String bname,String author,String cid,HttpSession session
                           ) {

        Map<String,Object> paramMap = new HashMap();
        paramMap.put("pageno",pageno);
        paramMap.put("pagesize",pagesize);
        //判断是否为空
        if(StringUtil.isNotEmpty(bname))  paramMap.put("bname",bname);
        if(StringUtil.isNotEmpty(author))  paramMap.put("author",author);
        if(StringUtil.isNotEmpty(cid))  paramMap.put("cid",Integer.parseInt(cid));
        PageBean<Book> pageBean = bookService.queryBookPage(paramMap);

        //获取类别
        List<Category> categoryList = bookService.listCategory();
        session.setAttribute(Const.CATEGORY,categoryList);

        // 转化为json
        //List<Book> list = bookService.listAllBook(pageBean);
        //PageBean pb=bookService.getPb();
        // 讲json发送给浏览器
        // list转成json
        JSONObject obj = new JSONObject();
        // Layui table 组件要求返回的格式
        obj.put("code", 0);
        obj.put("msg", "");
        obj.put("count",pageBean.getTotalsize());
        obj.put("data", pageBean.getDatas());

        return obj.toString();

    }

    //添加图书页面
    @RequestMapping("/addBook")
    public String addbook() {
        return "book/addBook";
    }


    //添加图书
    @RequestMapping("/submitAddBook")
    @ResponseBody
    public AjaxResult submitAddBook(Book book) {
        AjaxResult ajaxResult = new AjaxResult();
        try{
            bookService.addBook(book);
            ajaxResult.setSuccess(true);
            ajaxResult.setMessage("添加成功");
        }catch (Exception e){
            e.printStackTrace();
            ajaxResult.setSuccess(false);
            ajaxResult.setMessage("添加失败");
        }
        return ajaxResult;
    }

    //跳转修改页面
    @RequestMapping("/editBook")
    public String editBook(String book_id,Model model) {
        Book book = bookService.selectById(Integer.parseInt(book_id));
        model.addAttribute("bookinfo",book);
        model.addAttribute("code",1);
        return "book/addBook";
    }

    //修改图书
    @RequestMapping("/updateBook")
    @ResponseBody
    public AjaxResult updateBook(Book book) {
        AjaxResult ajaxResult = new AjaxResult();
        try{
            bookService.updateBook(book);
            ajaxResult.setSuccess(true);
            ajaxResult.setMessage("添加成功");
        }catch (Exception e){
            e.printStackTrace();
            ajaxResult.setSuccess(false);
            ajaxResult.setMessage("添加失败");
        }
        return ajaxResult;
    }

    //图书查看页面跳转
    @RequestMapping("/findBook")
    public String findBook(String book_id,Model model) {
        Book book = bookService.selectById(Integer.parseInt(book_id));
        model.addAttribute("bookinfo",book);
        return "book/addBook";
    }


    //删除图书
    @RequestMapping("/delBook")
    @ResponseBody
    public AjaxResult delBook(String book_id) {
        AjaxResult ajaxResult = new AjaxResult();
        try{
            bookService.delBook(Integer.parseInt(book_id));
            ajaxResult.setSuccess(true);
            ajaxResult.setMessage("添加成功");
        }catch (Exception e){
            e.printStackTrace();
            ajaxResult.setSuccess(false);
            ajaxResult.setMessage("添加失败");
        }
        return ajaxResult;
    }


    //跳转读者借阅界面readerIndex.jsp
    @RequestMapping("/frontIndex")
    public String frontIndex() {
        return "frontIndex";
    }

    @RequestMapping("/lendBook")
    @ResponseBody
    public AjaxResult borrowBook(Integer book_id,HttpSession session) {
        AjaxResult ajaxResult = new AjaxResult();

        Reader reader = (Reader)session.getAttribute(Const.READER);
        //判断库存是否足够
        Book book = bookService.selectById(book_id);
        if (book.getStock()==0){
            ajaxResult.setStatus("2");
            return ajaxResult;
        }

        //判断该读者是否已经借过该图书
        LendInfo lendInfo = new LendInfo();
        lendInfo.setBook_id(book_id);
        lendInfo.setReader_id(reader.getReader_id());
        if (lendInfoSerivce.isLended(lendInfo)){
            ajaxResult.setStatus("0");
            return ajaxResult;
        }
        //判断是否达到借书上限
        Integer cardState = lendInfoSerivce.cardState(reader.getReader_id());
        if (cardState.equals(reader.getCard_state())){
            ajaxResult.setStatus("3");
            return ajaxResult;

        }
        lendInfoSerivce.lendBook(lendInfo);
        ajaxResult.setStatus("1");
        return ajaxResult;
    }

}
