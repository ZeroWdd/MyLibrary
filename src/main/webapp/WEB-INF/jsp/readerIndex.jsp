<%--
  Created by IntelliJ IDEA.
  User: WDD
  Date: 2019/6/15
  Time: 19:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>图书管理系统</title>

    <style>
        .demo-carousel{height: 200px; line-height: 200px; text-align: center;}
    </style>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <jsp:include page="/WEB-INF/jsp/common/header.jsp" flush="true"/>

    <!-- 搜索条件表单 -->
    <div class="demoTable layui-form">
        <div class="layui-inline">
            <input class="layui-input" name="reader_id" id="reader_id" autocomplete="off"  placeholder="请输入读者ID">
        </div>
        <div class="layui-inline">
            <input class="layui-input" name="rname" id="rname" autocomplete="off" placeholder="请输入姓名">
        </div>
        <button class="layui-btn" data-type="reload">搜索</button>
        <a  style="margin-left: 70px"  class="layui-btn layui-btn-normal" onclick="add();">添加读者</a>
    </div>
</div>





<table class="layui-hide" id="demo" lay-filter="test"></table>

<div class="layui-tab-item layui-show">
    <div id="pageDemo"></div>
</div>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-sm" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-sm" lay-event="del">删除</a>
</script>
<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;

    });
    var url = "${APP_PATH}/"
</script>

<script src="${APP_PATH}/js/layui.js"></script>
<%--<script src="${APP_PATH}/js/reader/CRUDreader.js"></script>--%>
<script>


    layui.config({
        version: '1554901098009' //为了更新 js 缓存，可忽略
    });

    function add(){//添加

        layer.open({
            type: 2,
            title: '添加读者',
            skin: 'layui-layer-demo', //加上边框
            area: ['800px', '500px'], //宽高
            content: '${APP_PATH}/reader/addReader.htm'
        });
    }


    layui.use(['laydate', 'laypage', 'layer', 'table', 'carousel', 'upload', 'element', 'slider'], function(){
        var laydate = layui.laydate //日期
            ,laypage = layui.laypage //分页
            ,layer = layui.layer //弹层
            ,table = layui.table //表格
            ,carousel = layui.carousel //轮播
            ,upload = layui.upload //上传
            ,element = layui.element //元素操作
            ,slider = layui.slider //滑块


        //执行一个 table 实例
        table.render({
            elem: '#demo'
            ,height: 550
            ,url: '${APP_PATH}/reader/listReader.do' //数据接口
            ,title: '图书表'
            ,page: true
            ,limit: 6
            ,limits: [5,10,15,20]
            ,cols: [[ //表头
                {type: 'checkbox', fixed: 'left'}
                ,{field: 'reader_id', title: '读者ID', width:150, sort: true}
                ,{field: 'name', title: '姓名', width:150}
                ,{field: 'sex', title: '性别', width: 150}
                ,{field: 'birthday', title: '生日', width:200, sort: true}
                ,{field: 'address', title: '地址', width: 300}
                ,{field: 'telephone', title: '电话', width: 120}
                ,{field: 'card_state', title: '读者可借图书', width: 150}
                ,{fixed: 'right', title: '操作',width: 200, align:'center', toolbar: '#barDemo'}
            ]]
            //用于搜索结果重载
            ,id: 'testReload'
        });
        var $ = layui.$, active = {
            reload: function(){
                var reader_id = $('#reader_id');
                var rname = $('#rname');
                //执行重载
                table.reload('testReload', {
                    //一定要加不然乱码
                    method: 'post'
                    ,page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {
                        //bname表示传到后台的参数,bname.val()表示具体数据
                        reader_id: reader_id.val(),
                        rname: rname.val(),
                    }
                });
            }
        };
        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });


        //监听行工具事件
        table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'detail'){
                find(data);
            } else if(layEvent === 'del'){
                layer.confirm('真的删除行么', function(index){
                    del(data.reader_id,obj,index);
                });
            } else if(layEvent === 'edit'){
                edit(data);
            }
        });
//后边两个参数仅仅是因为要执行动态删除dom
        function del(id,obj,index){

            $.ajax({
                url:'${APP_PATH}/reader/delReader.do?id='+id,
                dataType:'json',
                type:'post',
                success:function (data) {
                    if (data.success){
                        obj.del(); //删除对应行（tr）的DOM结构
                        layer.close(index);
                    }else{
                        layer.msg(data.success);
                    }
                }
            })
        }


        function edit(data){//修改

            layer.open({
                type: 2,
                title: '修改图书信息',
                skin: 'layui-layer-demo', //加上边框
                area: ['800px', '500px'], //宽高
                method: 'post',
                content: '${APP_PATH}/reader/editReader.do?'
                +'id='+data.id
            });
        }

        function find(data){
            layer.open({
                type: 2,
                title: '查看读者信息',
                skin: 'layui-layer-demo', //加上边框
                area: ['800px', '500px'], //宽高
                method: 'post',
                content: '${APP_PATH}/reader/findReader.do?'
                +'id='+data.id
            });
        }
    });



</script>
</body>
</html>
