<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div class="right">
	<div class="location">
		<strong>你现在所在的位置是:</strong> <span>用户管理页面 >> 用户添加页面</span>
	</div>
	<div class="providerAdd">
		<form action="/SuperMarket/action/UpdateUser" method="post"
			name="userDetail">
			<input type="hidden" name="update" id="operation" value="update" />
			<input type="hidden" name="id" value="${userDetail.id }" /> <input
				type="hidden" name="oldUserName" id="oldUserName"
				value="${userDetail.name }" />
			<div>
				<label for="userName">用户名称：</label> <input type="text"
					name="userName" id="userName" value="${userDetail.name }" /> <span>*请输入用户名称</span>
			</div>
			<div>
				<label>用户性别：</label> <select name="sex">
					<option value="男" selected>男</option>
					<option value="女" ${userDetail.sex=="女"?selected:"" }>女</option>
				</select> <span></span>
			</div>
			<div>
				<label for="data">出生日期：</label> <input type="text" name="date"
					id="date"
					value="<fmt:formatDate pattern="yyyy-MM-dd" value="${userDetail.birth}"/>"
					class="Wdate"
					onClick="WdatePicker({
					dateFmt:'yyyy-MM-dd',
					minDate:'{%y-100}-%M-%d',
					maxDate:'{%y-10}-%M-%d'})" />
				<span>*</span>
			</div>
			<div>
				<label for="phone">用户电话：</label> <input type="text" name="phone"
					id="phone" value="${userDetail.mobile }" /> <span>*</span>
			</div>
			<div>
				<label for="address">用户地址：</label> <input type="text" name="address"
					id="address" value="${userDetail.address }" />
			</div>
			<div>
				<label for="role">用户角色：</label> 
				<select name="role" <c:if test="${sessionScope.roleid eq 2 }">disabled="disabled"</c:if>>
					<c:forEach var="role" varStatus="status"
						items="${requestScope.roleList }">
						<option value="${role.rid }"
							<c:if test="${userDetail.rid eq role.rid }">
								<c:out value="selected"></c:out>
							</c:if>>
							${role.rname }</option>
					</c:forEach>
				</select>
			</div>
			<div class="providerAddBtn">
				<input type="button" value="保存" onclick="check()" /> <input
					type="button" value="返回" onclick="history.back(-1)" />
			</div>
		</form>
	</div>
</div>
<script type="text/javascript"
	src="/SuperMarket/jsp/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="/SuperMarket/jsp/js/addUser.js"></script>

