//跳转修改页面
$("#update").bind("click",function(){
	var proId=$("#proId").val();
	window.location="providerUpdate.html";
});
//删除
$("#del").bind("click",function(){
	var proId=$("#proId").val();
		if(confirm("确认删除？")){
			window.location="providerList.html";
		}
});
