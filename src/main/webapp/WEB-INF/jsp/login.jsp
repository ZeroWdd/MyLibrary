<%--
  Created by IntelliJ IDEA.
  User: WDD
  Date: 2019/6/14
  Time: 20:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>图书管理系统登录</title>
    <link rel="stylesheet" href="${APP_PATH}/css/layui.css">
    <link rel="stylesheet" href="${APP_PATH}/css/style.css">
    <link rel="stylesheet" href="${APP_PATH}/css/modules/layer/default/layer.css">
    <script src="${APP_PATH}/js/layui.js"></script>
</head>
<body>

<div class="login-main">
    <header class="layui-elip">图书管理系统登录</header>
    <form class="layui-form" action="${APP_PATH}/library/list.action" method="post">
        <div class="layui-input-inline">
            <input type="text" name="name" required lay-verify="required" placeholder="学号" autocomplete="off"
                   class="layui-input">
        </div>
        <div class="layui-input-inline">
            <input type="password" name="password" required lay-verify="required" placeholder="密码" autocomplete="off"
                   class="layui-input">
        </div>
        <div class="layui-input-inline">
            <select name="access" id="access" lay-verify="required">
                <option value="">请选择权限</option>
                <option value="0" >管理员</option>
                <option value="1" >读者</option>
            </select>
        </div>

        <div class="layui-input-inline login-btn">
            <button lay-submit lay-filter="login" class="layui-btn">登录</button>
        </div>
        <hr/>
        <p><a href="${APP_PATH}/toRegister.htm" class="fl">立即注册</a><a href="javascript:;" onclick="forgetpsw();" class="fr">忘记密码？</a></p>
    </form>
</div>



<script type="text/javascript">
    layui.use(['form','layer','jquery'], function () {

        // 操作对象
        var form = layui.form;
        var $ = layui.jquery;

        form.on('submit(login)',function (data) {
            $.ajax({
                url:'${APP_PATH}/doLogin.do',
                data:data.field,
                dataType:'json',
                type:'post',
                success:function (data) {
                    if (data.status == '0'){
                        location.href = "${APP_PATH}/library/index.do";
                    }else if (data.status == '1') {
                        location.href = "${APP_PATH}/library/frontIndex.htm";
                    }else if (data.status == '2'){
                        layer.msg(data.message);
                    }else{
                        //服务器异常
                        layer.msg(data.message);
                    }
                }
            })
            return false;
        })
    });
    function forgetpsw(){
        layer.msg('联系管理员(1710031565)或到图书馆进行重置');
    }
</script>
</body>
</html>
