<%--
  Created by IntelliJ IDEA.
  User: WDD
  Date: 2019/6/15
  Time: 12:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>添加图书页面</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
    <link rel="stylesheet" href="${APP_path}/css/layui.css"  media="all">
    <link rel="${APP_path}/css/modules/laydate/default/laydate.css" >
    <link rel="stylesheet" href="${APP_path}/css/style.css">
    <link rel="stylesheet" href="${APP_path}/css/modules/layer/default/layer.css">
    <script src="${APP_path}/js/laydate.js"></script> <!-- 要在layui 的前边不然时间插件失效 -->
    <script src="${APP_path}/js/layui.js" ></script>
    <style>
        body{padding: 20px;}
        .demo-input{padding-left: 10px; height: 38px; min-width: 262px; line-height: 38px; border: 1px solid #e6e6e6;  background-color: #fff;  border-radius: 2px;}
        .demo-footer{padding: 50px 0; color: #999; font-size: 14px;}
        .demo-footer a{padding: 0 5px; color: #01AAED;}
    </style>
</head>
<body>
<form class="layui-form" action="${APP_path}/library/submitAddBook.action" method="post" id="addbook" lay-filter="example">
    <div class="layui-form-item">

        <div class="layui-inline">
            <label class="layui-form-label">书名：</label>
            <div class="layui-input-inline">
                <input type="hidden" name="book_id" value="${bookinfo.book_id}">
                <input type="text" name="name" lay-verify="required" value="${bookinfo.name}" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">作者：</label>
            <div class="layui-input-inline">
                <input type="text" name="author" lay-verify="required" value="${bookinfo.author}" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">价格：</label>
            <div class="layui-input-inline">
                <input type="text" name="price" lay-verify="required" value="${bookinfo.price}" autocomplete="off" class="layui-input">
            </div>
        </div>
        <%-- 		<fmt:formatDate value="${test}" pattern="yyyy-MM-dd"/>  --%>
        <div class="layui-inline">
            <label class="layui-form-label">出版日期：</label>
            <div class="layui-input-inline">
                <input type="text" name="pubdate" lay-verify="required" value="${bookinfo.pubdate}" autocomplete="off" class="layui-input" id="test1">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">出版社：</label>
            <div class="layui-input-inline">
                <input type="text" name="publish" lay-verify="required" value="${bookinfo.publish}" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">ISBN：</label>
            <div class="layui-input-inline">
                <input type="text" name="ISBN" lay-verify="required" value="${bookinfo.ISBN}" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">库存：</label>
            <div class="layui-input-inline">
                <input type="text" name="stock" lay-verify="required" value="${bookinfo.stock}" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <!-- 两个变量都来自后台,下拉框回显需要用到 -->
            <c:set  var="bcid" value="${bookinfo.cid}" />
            <label class="layui-form-label">书本类别：</label>
            <div class="layui-input-block" >
                <select name="cid" id="class_id" lay-verify="required">
                    <option value="">请选择书本类别</option>
                    <c:forEach items="${category}" var="ctg">
                        <option value="${ctg.cid}" <c:if test="${ctg.cid==bcid}">selected</c:if>>${ctg.cname}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
    </div>

    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">语言：</label>
            <div class="layui-input-block">
                <select name="language" id="language" lay-verify="required">
                    <option value="">请选择书本语言</option>
                    <option value="中文" <c:if test="${bookinfo.language=='中文'}">selected</c:if>>中文</option>
                    <option value="英语" <c:if test="${bookinfo.language=='英语'}">selected</c:if>>英语</option>
                </select>
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">书本描述：</label>
        <div class="layui-input-block">
            <textarea style="width:600px; height:150px" placeholder="请输入书本描述" name="introduction"  lay-verify="required"  class="layui-textarea">${bookinfo.introduction}</textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <c:if test="${bookinfo==null}"><!-- 查看是没有添加按钮的 -->
            <button class="layui-btn" lay-submit="" lay-filter="addbook">立即添加</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </c:if>
            <!-- 修改需要修改按钮是没有添加按钮的 -->
            <c:if test="${code==1}">
                <button class="layui-btn" lay-submit="" lay-filter="updatebook">立即修改</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </c:if>
        </div>
    </div>
</form>

<script>
    lay('#version').html('-v'+ laydate.v);

    //执行一个laydate实例
    laydate.render({
        elem: '#test1' //指定元素
    });
</script>

<script type="text/javascript">
    layui.use(['form','layer','jquery'], function () {
        // 操作对象
        var form = layui.form;
        var $ = layui.jquery;
        //添加ajax表单提交
        form.on('submit(addbook)',function (data) {
//            if(!new RegExp("^[0-9]*$").test(data.field.price)){
//                layer.msg("价格必须是数字");
//                return false;
//            }
            if(!new RegExp("^[0-9]*$").test(data.field.stock)){
                layer.msg("库存必须是数字!");
                return false;
            }
            $.ajax({
                url:'${APP_path}/library/submitAddBook.do',
                data:data.field,
                dataType:'json',
                type:'post',
                success:function (data) {
                    if (data.success){
                        layer.msg(data.message);
                        layer.alert(data.message,function(){
                            window.parent.location.reload();//刷新父页面
                            parent.layer.close(index);//关闭弹出层
                        });
                    }else{
                        layer.msg(data.message);
                    }
                }
            })
            return false;
        }),

        //修改ajax表单提交
        form.on('submit(updatebook)',function (data) {
//            if(!new RegExp("^[0-9]*$").test(data.field.price)){
//                layer.msg("价格必须是数字");
//                return false;
//            }
            if(!new RegExp("^[0-9]*$").test(data.field.stock)){
                layer.msg("库存必须是数字!");
                return false;
            }

            $.ajax({
                url:'${APP_path}/library/updateBook.do',
                data:data.field,
                dataType:'json',
                type:'post',
                success:function (data) {
                    if (data.success){
                        layer.alert(data.message,function(){
                            window.parent.location.reload();//刷新父页面
                            parent.layer.close(index);//关闭弹出层
                        });
                    }else{
                        layer.msg(data.message);
                    }
                }
            })
            return false;
        })


    });
</script>


</body>
</html>
