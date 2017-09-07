layui.use(['layer','form','table'], function(){
	var $ = layui.jquery,
  		form = layui.form;
	  	//监听提交
		form.on('submit(submit)', function(data){
		  var values = data.field,
  	   		fm = data.form;
	  	   var index = layer.load(1); //换了种风格
	          $.post($(fm).attr('action'),values,function(data){
	          	layer.close(index); 
	          	if(data.code==200){
	          		parent.layer.msg('提交成功', {icon: 1});
	          		//刷新父table
	          		parent.layui.table.reload('table'); 
	                  // 获得frame索引
	                  var index2 = parent.layer.getFrameIndex(window.name);
	                  //关闭当前frame
	                  parent.layer.close(index2);
	          	}else{
	          		layer.msg(data.msg, {icon:2});
	          	}
	              
	          });
	      	return false;
	      });

});

