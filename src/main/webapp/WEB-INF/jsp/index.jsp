<%--
  Created by IntelliJ IDEA.
  User: WDD
  Date: 2019/6/15
  Time: 10:25
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
            <input class="layui-input" name="bname" id="bname" autocomplete="off"  placeholder="请输入书名">
        </div>
        <div class="layui-inline">
            <input class="layui-input" name="author" id="author" autocomplete="off" placeholder="请输入作者">
        </div>
        <div class="layui-inline">
            <div class="layui-input-block">
                <select name="cid" id="cid">
                    <option value="">请选择书本类别</option>
                    <c:forEach items="${category}" var="ctg">
                        <option value="${ctg.cid}">${ctg.cname}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <button class="layui-btn" data-type="reload">搜索</button>
        <a style="margin-left: 70px" class="layui-btn layui-btn-normal" onclick="add();">添加图书</a>
    </div>
</div>





<table class="layui-hide" id="demo" lay-filter="test"></table>

<%--<div class="layui-tab-item layui-show">--%>
    <%--<div id="pageDemo"></div>--%>
<%--</div>--%>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-sm" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-sm" lay-event="del">删除</a>
</script>

<script src="${APP_path}/js/layui.js"></script>
<script>


    layui.config({
        version: '1554901098009' //为了更新 js 缓存，可忽略
    });


    function add(){//添加

        layer.open({
            type: 2,
            title: '添加图书',
            skin: 'layui-layer-demo', //加上边框
            area: ['800px', '600px'], //宽高
            content: '${APP_PATH}/library/addBook.do'
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
            ,url: '${APP_path}/library/listBook.do' //数据接口
            ,title: '图书表'
            ,page: true
            ,limit: 5
            ,limits: [5,10,15,20]
            ,cols: [[ //表头
                {type: 'checkbox', fixed: 'left'}
                ,{field: 'book_id', title: '书本编号', width:150, sort: true}
                ,{field: 'name', title: '书名', width:200}
                ,{field: 'author', title: '作者', width: 200, sort: true}
                ,{field: 'publish', title: '出版社', width:200, sort: true}
                ,{field: 'ISBN', title: 'ISBN', width: 150, sort: true}
                ,{field: 'pubdate', title: '出版日期', width: 120, sort: true}
                ,{field: 'stock', title: '库存', width: 100}
                ,{field: 'price', title: '价格', width: 100, sort: true}
                // ,{field: 'introduction', title: '简介', width:150}
                ,{fixed: 'right', width: 200, align:'center', toolbar: '#barDemo'}
            ]]
            //用于搜索结果重载
            ,id: 'testReload'
        });
        var $ = layui.$, active = {
            reload: function(){
                var bname = $('#bname');
                var author = $('#author');
                var cid = $('#cid');
                //执行重载
                table.reload('testReload', {
                    //一定要加不然乱码
                    method: 'post'
                    ,page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {
                        //bname表示传到后台的参数,bname.val()表示具体数据
                        bname: bname.val(),
                        author: author.val(),
                        cid: cid.val()
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
                    del(data.book_id,obj,index);
                });
            } else if(layEvent === 'edit'){
                edit(data);
            }
        });
        //后边两个参数仅仅是因为要执行动态删除dom
        function del(book_id,obj,index){

            $.ajax({
                url:'${APP_path}/library/delBook.do?book_id='+book_id,
                dataType:'json',
                type:'post',
                success:function (data) {
                    if (data.success){
                        obj.del(); //删除对应行（tr）的DOM结构
                        layer.close(index);
                    }else{
                        layer.msg(data.message);
                    }
                }
            })
        }


        function edit(data){//修改

            layer.open({
                type: 2,
                title: '修改图书信息',
                skin: 'layui-layer-demo', //加上边框
                area: ['800px', '600px'], //宽高
                method: 'post',
                content: '${APP_PATH}/library/editBook.do?'
                +'book_id='+data.book_id
            });
        }

        function find(data){
            layer.open({
                type: 2,
                title: '查看图书信息',
                skin: 'layui-layer-demo', //加上边框
                area: ['800px', '600px'], //宽高
                method: 'post',
                content: '${APP_PATH}/library/findBook.do?'
                +'book_id='+data.book_id
            });
        }

    });



</script>
</body>
</html>
