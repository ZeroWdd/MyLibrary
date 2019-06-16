<%--
  Created by IntelliJ IDEA.
  User: WDD
  Date: 2019/6/16
  Time: 12:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>图书管理系统</title>

    <style>
        .demo-carousel {
            height: 200px;
            line-height: 200px;
            text-align: center;
        }
    </style>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <jsp:include page="/WEB-INF/jsp/common/header.jsp" flush="true"/>

    <!-- 搜索条件表单 -->
    <div class="demoTable layui-form">
        <div class="layui-inline">
            <input class="layui-input" name="bname" id="bname" autocomplete="off" placeholder="请输入书名">
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
    </div>
</div>


<table class="layui-hide" id="demo" lay-filter="test"></table>

<div class="layui-tab-item layui-show">
    <div id="pageDemo"></div>
</div>
<script type="text/html" id="barDemo">
    <%-- 必须使用 button--%>
    <button class="layui-btn layui-btn-normal layui-btn-sm lend" lay-event="lend">借阅</button>
    <%--	<button class="layui-btn layui-btn-sm lend layui-btn-disabled" lay-event="lend" disabled="disabled">已借阅</button>--%>


</script>
<script>
    //JavaScript代码区域
    layui.use('element', function () {
        var element = layui.element;

    });
</script>

<script src="${APP_PATH}/js/layui.js"></script>
<script>


    layui.config({
        version: '1554901098009' //为了更新 js 缓存，可忽略
    });


    layui.use(['laydate', 'laypage', 'layer', 'table', 'carousel', 'upload', 'element', 'slider'], function () {
        var laydate = layui.laydate //日期
            , laypage = layui.laypage //分页
            , layer = layui.layer //弹层
            , table = layui.table //表格
            , carousel = layui.carousel //轮播
            , upload = layui.upload //上传
            , element = layui.element //元素操作
            , slider = layui.slider //滑块


        //执行一个 table 实例
        table.render({
            elem: '#demo'
            , height: 550
            , url: '${APP_PATH}/library/listBook.do' //数据接口
            , title: '图书表'
            , page: true
            , limit: 5
            , limits: [5, 10, 15, 20]
            , cols: [[ //表头
                {type: 'checkbox', fixed: 'left'}
                , {field: 'book_id', title: '书本编号', width: 150, sort: true}
                , {field: 'name', title: '书名', width: 200}
                , {field: 'author', title: '作者', width: 200, sort: true}
                , {field: 'publish', title: '出版社', width: 200, sort: true}
                , {field: 'ISBN', title: 'ISBN', width: 150, sort: true}
                , {field: 'pubdate', title: '出版日期', width: 120, sort: true}
                , {field: 'stock', title: '库存', width: 100}
                , {field: 'price', title: '价格', width: 100, sort: true}
                , {fixed: 'right', title: '操作',width: 200, align: 'center', toolbar: '#barDemo'}
            ]]

            //用于搜索结果重载
            , id: 'testReload'
        });
        var $ = layui.$, active = {
            reload: function () {
                var bname = $('#bname');
                var author = $('#author');
                var cid = $('#cid');
                //执行重载
                table.reload('testReload', {
                    //一定要加不然乱码
                    method: 'post'
                    , page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    , where: {
                        //bname表示传到后台的参数,bname.val()表示具体数据
                        bname: bname.val(),
                        author: author.val(),
                        cid: cid.val(),
                    }
                });
            }
        };
        $('.demoTable .layui-btn').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });


        //监听行工具事件
        table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                , layEvent = obj.event; //获得 lay-event 对应的值
            if (layEvent === 'lend') {
                layer.confirm('确认借阅此书吗?', function (index) {
                    lend(obj, index, data);
                });
            }
        });

//后边两个参数仅仅是因为要执行动态删除dom
        function lend(obj, index, data1) {
            $.ajax({
                url: '${APP_PATH}/library/lendBook.do?'
                + 'book_id=' + data1.book_id,
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    if (data.status == '1') {

                        //当前行数
                        var i = $("tr").index(obj.tr) - 1;
                        //获取当前dom
                        var dom = $('.lend').eq(i);
                        if (dom.hasClass('layui-btn-normal')) {
                            dom.removeClass('layui-btn-normal');
                            //变为禁用
                            dom.addClass('layui-btn-disabled');
                            //去除点击事件
                            dom.attr("disabled", "disabled");
                            dom.html('已借阅');
                        }
                        //更新库存
                        obj.update({
                            stock: data1.stock - 1
                        });
                        layer.close(index);

                    } else if (data.status == '0') {
                        layer.msg('您已经借过该图书!', {icon: 5});
                    }else if (data.status == '3') {
                        layer.msg('您已经达到借书上限!', {icon: 5});
                    }else{
                        layer.msg('该图书库存不足!', {icon: 5});
                    }
                }
            })


        }
    });


</script>
</body>
</html>