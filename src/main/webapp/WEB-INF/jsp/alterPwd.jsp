<%--
  Created by IntelliJ IDEA.
  User: WDD
  Date: 2019/6/16
  Time: 11:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改密码</title>
    <link rel="stylesheet" href="${APP_PATH}/css/layui.css">
    <link rel="stylesheet" href="${APP_PATH}/css/style.css">
    <link rel="stylesheet" href="${APP_PATH}/css/modules/layer/default/layer.css">
    <script src="${APP_PATH}/js/layui.js" ></script>
</head>
<body>
<div class="login-main">
    <!-- 表单选项 -->
    <div style="padding: 15px;">
        <form class="layui-form" action="${APP_PATH}/alterpwd.action" method="post">

            <div class="layui-input-inline">
                <div class="layui-inline" style="width: 85%">
                    <input type="password" id="user" required  lay-verify="required" placeholder="原密码" autocomplete="off" class="layui-input">
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
                    <input type="hidden" name="state" value="${state}">
                    <input type="password" id="pwd" name="password" required  lay-verify="required" placeholder="新密码" autocomplete="off" class="layui-input">
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
                    <input type="password" id="rpwd"  required  lay-verify="required" placeholder="重复新密码" autocomplete="off" class="layui-input">
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
            <div class="layui-input-inline login-btn" style="width: 85%">
                <button type="submit" lay-submit lay-filter="sub" class="layui-btn">点击修改</button>
            </div>
        </form>
    </div>

    <script>
        lay('#version').html('-v'+ laydate.v);

        //执行一个laydate实例
        laydate.render({
            elem: '#test1' //指定元素
        });
    </script>
    <script type="text/javascript">
        layui.use(['form','jquery','layer'], function () {
            var form   = layui.form;
            var $      = layui.jquery;
            var layer  = layui.layer;

            //添加表单失焦事件
            //验证表单
            $('#user').blur(function() {
                var user = $(this).val();
                $.ajax({
                    url:'${APP_PATH}/checkPwd.do?',
                    type:'post',
                    dataType:'json',
                    data:{password:user,state:${state}},
                    //验证用户名是否可用
                    success:function(data){
                        if (data.success) {
                            $('#ri').removeAttr('hidden');
                            $('#wr').attr('hidden','hidden');
                        } else {
                            $('#wr').removeAttr('hidden');
                            $('#ri').attr('hidden','hidden');
                            layer.msg(data.message, {icon: 5});
                            form.render();
                        }

                    }
                })

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
                $.ajax({
                    url:'${APP_PATH}/alterpwd.do',
                    data:data.field,
                    dataType:'json',
                    type:'post',
                    success:function(data){
                        if (data.success) {
                            layer.alert(data.message,function(){
                                window.parent.location.href = "${APP_PATH}/toLogin.htm";//刷新父页面
                                parent.layer.close(index);//关闭弹出层
                            });
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

