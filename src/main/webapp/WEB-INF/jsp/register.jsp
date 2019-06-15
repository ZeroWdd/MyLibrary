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
    <title>注册界面</title>
    <link rel="stylesheet" href="${APP_PATH}/css/layui.css">
    <link rel="stylesheet" href="${APP_PATH}/css/style.css">
    <link rel="stylesheet" href="${APP_PATH}/css/modules/layer/default/layer.css">
    <script src="${APP_PATH}/js/laydate.js"></script> <!-- 要在layui 的前边不然时间插件失效 -->
    <script src="${APP_PATH}/js/layui.js" ></script>
</head>
<body>
<div class="login-main">
    <header class="layui-elip" style="width: 82%;;margin-top:40px">注册页</header>
    <!-- 表单选项 -->
    <form class="layui-form" action="${APP_PATH}/library/submitAddReader.action" method="post">
        <div class="layui-input-inline">
            <div class="layui-inline" style="width: 85%">
                <input type="text" id="user" name="reader_id" required  lay-verify="required" placeholder="请输入学号" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-inline">
                <i class="layui-icon" id="ri" style="color: green;font-weight: bolder;" hidden></i>
            </div>
            <div class="layui-inline">
                <i class="layui-icon" id="wr" style="color: red; font-weight: bolder;" hidden>ဆ</i>
            </div>
        </div>
        <!-- 密码 -->
        <div class="layui-input-inline">
            <div class="layui-inline" style="width: 85%">
                <input type="password" id="pwd" name="password" required  lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
            </div>
            <!-- 对号 -->
            <div class="layui-inline">
                <i class="layui-icon" id="pri" style="color: green;font-weight: bolder;" hidden></i>
            </div>
            <!-- 错号 -->
            <div class="layui-inline">
                <i class="layui-icon" id="pwr" style="color: red; font-weight: bolder;" hidden>ဆ</i>
            </div>
        </div>
        <!-- 确认密码 -->
        <div class="layui-input-inline">
            <div class="layui-inline" style="width: 85%">
                <input type="password" id="rpwd"  required  lay-verify="required" placeholder="请确认密码" autocomplete="off" class="layui-input">
            </div>
            <!-- 对号 -->
            <div class="layui-inline">
                <i class="layui-icon" id="rpri" style="color: green;font-weight: bolder;" hidden></i>
            </div>
            <!-- 错号 -->
            <div class="layui-inline">
                <i class="layui-icon" id="rpwr" style="color: red; font-weight: bolder;" hidden>ဆ</i>
            </div>
        </div>
        <div class="layui-input-block">
            <div class="layui-inline" style="width: 85%">
                <input type="radio" name="sex" value="男" title="男">
                <input type="radio" name="sex" value="女" title="女" checked>
            </div>
        </div>
        <div class="layui-input-inline">
            <div class="layui-inline" style="width: 85%">
                <input type="text" name="telephone" required lay-verify="required" placeholder="电话" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-input-inline">
            <div class="layui-inline" style="width: 85%">
                <input type="text" name="name" required lay-verify="required" placeholder="姓名" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-input-inline">
            <div class="layui-inline" style="width: 85%">
                <input type="text" name="address" required lay-verify="required" placeholder="地址" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-input-inline">
            <div class="layui-inline" style="width: 85%">
                <div class="layui-input-inline">
                    <input type="text" name="birthday" lay-verify="required" placeholder="出生日期" autocomplete="off" class="layui-input" id="test1">
                </div>
            </div>
        </div>
        <div class="layui-input-inline login-btn" style="width: 85%">
            <button type="submit" lay-submit lay-filter="sub" class="layui-btn">注册</button>
        </div>
        <hr style="width: 85%" />
        <p style="width: 85%"><a href="${APP_PATH}/toLogin.htm" class="fl">已有账号？立即登录</a></p>
    </form>
</div>

<script>
    //执行一个laydate实例
    laydate.render({
        elem: '#test1', //指定元素
        trigger: 'click'
    });
</script>
<script type="text/javascript">
    layui.use(['form','jquery','layer'], function () {
        var form   = layui.form;
        var $      = layui.jquery;
        var layer  = layui.layer;

        layer.tips('学号就是借阅号哦!', '#user');
        //添加表单失焦事件
        //验证表单
        $('#user').blur(function() {
            var user = $(this).val();

            //alert(user);
            $.ajax({
                url:'${APP_PATH}/checkReader.do',
                type:'post',
                dataType:'json',
                data:{reader_id:user},
                //验证用户名是否可用
                success:function(data){
                    if (data.success) {
                        $('#ri').removeAttr('hidden');
                        $('#wr').attr('hidden','hidden');
                    } else {
                        $('#wr').removeAttr('hidden');
                        $('#ri').attr('hidden','hidden');
                        layer.msg(data.message)

                    }

                }
            })

        });
        // you code ...
        // 为密码添加正则验证
        $('#pwd').blur(function() {
            var reg = /^[\w]{1,12}$/;
            if(!($('#pwd').val().match(reg))){
                //layer.msg('请输入合法密码');
                $('#pwr').removeAttr('hidden');
                $('#pri').attr('hidden','hidden');
                layer.msg('请输入合法密码');
            }else {
                $('#pri').removeAttr('hidden');
                $('#pwr').attr('hidden','hidden');
            }
        });

        //验证两次密码是否一致
        $('#rpwd').blur(function() {
            if($('#pwd').val() != $('#rpwd').val()){
                $('#rpwr').removeAttr('hidden');
                $('#rpri').attr('hidden','hidden');
                layer.msg('两次输入密码不一致!');
            }else {
                $('#rpri').removeAttr('hidden');
                $('#rpwr').attr('hidden','hidden');
            };
        });

        //
        //添加表单监听事件,提交注册信息
        form.on('submit(sub)', function(data) {
            if(!new RegExp("^1\\d{10}$").test(data.field.telephone)){
                layer.msg("请输入11位电话号码");
                return false;
            }
            if(!new RegExp("^[0-9]*$").test(data.field.reader_id)){
                layer.msg("学号为数字哦!");
                return false;
            }
            $.ajax({
                url:'${APP_PATH}/submitAddReader.do',
                data:data.field,
                dataType:'json',
                type:'post',
                success:function(data){
                    if (data.success) {
                        layer.msg(data.message);
                        location.href = "${APP_PATH}/toLogin.htm";
                    }else {
                        layer.msg(data.message);
                    }
                }
            })
            //防止页面跳转
            return false;
        });

    });
</script>
</body>
</html>