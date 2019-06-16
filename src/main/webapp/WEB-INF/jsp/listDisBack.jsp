<%--
  Created by IntelliJ IDEA.
  User: WDD
  Date: 2019/6/16
  Time: 16:41
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: hasee
  Date: 2019/6/1
  Time: 15:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>读者未还图书</title>
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
            <div class="layui-input-block">
                <select name="state" id="state">
                    <option value="">请选择归还状态</option>
                    <option value="2">未还</option>
                    <option value="1">已还</option>
                </select>
            </div>
        </div>
        <button class="layui-btn" data-type="reload"   lay-filter="reset" >搜索</button>
    </div>


</div>


<table class="layui-hide" id="demo" lay-filter="test"></table>

<div class="layui-tab-item layui-show">
    <div id="pageDemo"></div>
</div>

<script type="text/html" id="barDemo">
    {{#  if(d.state =="2"){ }}
    <p style="color:limegreen;font-size:1.3em;">未还</p>
    {{#  } }}
    {{#  if(d.state =="1"){ }}
    <p style="color:red;font-size:1.3em;" >已还</p>
    {{#  } }}
</script>
<div id="testDiv"></div>
<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;

    });
    var url = "${APP_PATH}/"
</script>

<script src="${APP_PATH}/js/layui.js"></script>
<script>


    layui.config({
        version: '1554901098009' //为了更新 js 缓存，可忽略
    });


    layui.use(['laydate', 'laypage', 'layer', 'table', 'carousel', 'upload', 'element', 'slider','laytpl'], function(){
        var laydate = layui.laydate //日期
            ,laypage = layui.laypage //分页
            ,layer = layui.layer //弹层
            ,table = layui.table //表格
            ,carousel = layui.carousel //轮播
            ,upload = layui.upload //上传
            ,element = layui.element //元素操作
            ,slider = layui.slider //滑块
            ,laytpl = layui.laytpl




        //执行一个 table 实例
        table.render({
            elem: '#demo'
            ,height: 550
            ,url: '${APP_PATH}/listDisBackBook.do' //数据接口
            ,title: '图书表'
            ,page: true
            ,limit: 6
            ,limits: [5,10,15,20]
            ,cols: [[ //表头
                {type: 'checkbox', fixed: 'left'}
                ,{field: 'reader_id', title: '借阅号', width:200, sort: true}
                ,{field: 'book_id', title: '图书ID', width: 200}
                ,{field: 'bookName', title: '书名', width: 300}
                ,{field: 'lend_date', title: '借阅时间', width:200, sort: true}
                ,{field: 'back_date', title: '最晚归还时间', width: 200}
                ,{field: 'fine', title: '产生罚款罚款', width: 100,templet: function(d){
                    return d.fine=="0"?'':'<a style="font-size:1.5em;color: red;font-weight: bold">'+d.fine+'元</a>';
                }}
                ,{fixed: 'right', title: '操作',width: 200, align:'center', toolbar: '#barDemo'}
            ]]

            //用于搜索结果重载
            ,id: 'testReload'
        });
        var $ = layui.$, active = {
            reload: function(){
                var bname = $('#bname');
                var state = $('#state');
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
                        state: state.val()
                    }
                });
            }
        };
        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });


    });

</script>
</body>
</html>
