<%--
  Created by IntelliJ IDEA.
  User: WDD
  Date: 2019/6/15
  Time: 17:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="${APP_PATH}/js/layui.js"></script>
    <title>图书类别</title>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <jsp:include page="/WEB-INF/jsp/common/header.jsp" flush="true"/>

    <div style="padding-left: 200px;">
        <a class="layui-btn layui-btn-normal" onclick="addType();">添加类别</a>
        <table class="layui-hide" id="demo" lay-filter="test"></table>

        <div class="layui-tab-item layui-show">
            <div id="pageDemo"></div>
        </div>
    </div>
</div>

    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-sm" lay-event="edit">编辑</a>
        <a class="layui-btn layui-btn-danger layui-btn-sm" lay-event="del">删除</a>
    </script>
    <script src="${APP_PATH}/js/layui.js"></script>
    <script type="text/javascript">
        layui.use(['laypage', 'layer', 'table', 'element','jquery'], function(){
            laypage = layui.laypage //分页
                ,layer = layui.layer //弹层
                ,table = layui.table //表格
                ,element = layui.element; //元素操作
            var $ = layui.jquery;

            //执行一个 table 实例
            table.render({
                elem: '#demo'
                ,height: 550
                ,url: '${APP_PATH}/type/bookTypeList.do' //数据接口
                ,title: '图书表'
                ,cols: [[ //表头
                    {field: 'cname', title: '类别名称', width:300, align:'center'}
                    ,{fixed: 'right',title:'操作', width: 300, align:'center', toolbar: '#barDemo'}
                ]]
            });
            //监听行工具事件
            table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
                var data = obj.data //获得当前行数据
                    ,layEvent = obj.event; //获得 lay-event 对应的值
                if(layEvent === 'edit'){
                    editBookType(data);
                } else if(layEvent === 'del'){
                    layer.confirm('真的删除行么', function(index){
                        del(data.cid,obj,index);
                    });
                }
            });




            //prompt层
            //value用于数据回显
            function editBookType(data1){
                layer.prompt({title: '修改类别',value:data1.cname, formType: 2}, function(text, index){
                    layer.close(index);
                    $.ajax({
                        url:'${APP_PATH}/type/editBookType.do',
                        data:{'cid':data1.cid,'cname':text},
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

                });
            }
            //删除图书类别
            function del(cid,obj,index){

                $.ajax({
                    url:'${APP_PATH}/type/delBookType.do?cid='+cid,
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

        });
        function addType(){
            layui.use(['laypage', 'layer', 'table', 'element','jquery'], function(){
                layer = layui.layer //弹层
                    ,element = layui.element; //元素操作
                var $ = layui.jquery;
                layer.prompt({title: '添加类别', formType: 2}, function(text, index){
                    layer.close(index);
                    $.ajax({
                        url:'${APP_PATH}/type/addBookType.do',
                        data:{'cname':text},
                        dataType:'json',
                        type:'post',
                        success:function (data) {
                            if (data.success){
//                                layer.alert(data.message,function(){
//                                    window.parent.location.reload();//刷新父页面
//                                    parent.layer.close(index);//关闭弹出层
//                                });
                                window.location.reload();
                            }else{
                                layer.msg(data.message);
                            }
                        }
                    })

                });
            });
        }
    </script>
</body>
</html>