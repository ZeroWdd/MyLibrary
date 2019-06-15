function add(){//添加
	 
	layer.open({
	  type: 2,
	  title: '添加图书',
	  skin: 'layui-layer-demo', //加上边框
	  area: ['800px', '600px'], //宽高
	  content: 'https://blog.csdn.net/a10039/article/details/80494350'
	  });
}



function edit(data){//修改
	 
	layer.open({
		  type: 2,
		  title: '修改图书信息',
		  skin: 'layui-layer-demo', //加上边框
		  area: ['800px', '600px'], //宽高
		  method: 'post',
		  content: 'library/editBook.action?'
			  +'book_id='+data.book_id
			  +'&name='+data.name
			  +'&author='+data.author
			  +'&publish='+data.publish
			  +'&ISBN='+data.ISBN
			  +'&introduction='+data.introduction
			  +'&language='+data.language
			  +'&price='+data.price
			  +'&pubdate2='+data.pubdate//这里赋值给String类型的时间字段
			  +'&class_id='+data.category.cid
			  +'&stock='+data.stock
			
		  });
}

function find(data){
	layer.open({
		  type: 2,
		  title: '查看图书信息',
		  skin: 'layui-layer-demo', //加上边框
		  area: ['800px', '600px'], //宽高
		  method: 'post',
		  content: 'library/findBook.action?'
			  +'name='+data.name
			  +'&author='+data.author
			  +'&publish='+data.publish
			  +'&ISBN='+data.ISBN
			  +'&introduction='+data.introduction
			  +'&language='+data.language
			  +'&price='+data.price
			  +'&pubdate2='+data.pubdate//这里赋值给String类型的时间字段
			  +'&class_id='+data.category.cid
			  +'&stock='+data.stock
			
		  });
}

