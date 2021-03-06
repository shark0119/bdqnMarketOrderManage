<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

共${pager.totalCount }条记录&nbsp;&nbsp; ${pager.pageIndex }/
<span id="totalPage">${pager.totalPage }</span>
页
<c:choose>
	<c:when test="${pager.pageIndex == 1 }">首页&nbsp;	上一页</c:when>
	<c:otherwise>
		<a href="javascript:jump(1, ${pager.pageSize })">首页</a>&nbsp;	
				<a href="javascript:jump(${pager.pageIndex }-1, ${pager.pageSize })">上一页</a>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${pager.pageIndex == pager.totalPage }">下一页&nbsp;	末页</c:when>
	<c:otherwise>
		<a href="javascript:jump(${pager.pageIndex }-0+1, ${pager.pageSize })">下一页</a>&nbsp;	
				<a href="javascript:jump(${pager.totalPage }, ${pager.pageSize })">末页</a>
	</c:otherwise>
</c:choose>
页数:
<input type="text" id="page" name="page" size="1" />
<input type="button" id="GO" value="GO" />
<input type="hidden" value="${pager.pageIndex }" name="pageIndex" />
<input type="hidden" value="${pager.pageSize }" name="pageSize" />
&nbsp; &nbsp; &nbsp;
请输入每页显示的个数:
<input type="text" name="setPageSize" id="setPageSize" value="" size="1" >

<script type="text/javascript">
	function jump(p, s) {
		var form = document.dividePage;
		with (form) {
			pageIndex.value = p;
			pageSize.value = s;
			submit();
		}
	}
	$("#GO").click(function() {
		var $hidden = $(":input:hidden");
		var page = $("#page").val();
		if (page == null || page === "") {
			alert("页数不能为空");
		} else if (page.match(/^\d+$/)) {
			var i = $("#totalPage").text();
			if (page > i) {
				alert("输入无效，必须小于最大页数");
				$("#page").focus();
			} else {
				jump(page, $hidden[1].value);
			}
		} else
			alert("页数必须为整数");
	});
</script>
