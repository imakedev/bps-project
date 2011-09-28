<%@page import="th.co.vlink.xstream.common.VResultMessage"%>
<%@page import="th.co.vlink.utils.Pagging"%>
<%@page import="th.co.vlink.bps.util.Paging"%>
<%@page import="th.co.vlink.bps.form.BpsUserForm"%>
<%@page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="portlet" uri="http://java.sun.com/portlet"%>
<portlet:defineObjects />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/style.css" />
	
<script type="text/javascript">
	function clickPage(pageNo) {
		document.getElementById("pageNo").value = pageNo;
		document.forms['bpsUserForm'].submit();
	}
</script>
</head>
<body>
<table width="100%" align="center" border="0" cellspacing="0"
	cellpadding="0">
	<tr>
		<td height="30" colspan="2"><span
			style="color: #030; font-size: 12px;"><strong>You are
		in:</strong> Home > BPS Term and Difinition</span></td>
	</tr>
	  <tr>
	    <td align="left"><img src="<%=request.getContextPath()%>/images/term.gif"></td>
	    <td align="right"><a href="#"><img src="<%=request.getContextPath()%>/images/btn_admin.gif" width="65" height="25"></a></td>
	  </tr>
	<tr>
		<td colspan="2" height="30">
		<div class="team" style="padding-left: 10px;">
		<%
			String[] indexChar = { "A", "B", "C", "D", "E", "F", "G", "H", "I",
					"J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U",
					"V", "W", "X", "Y", "Z" };
			for (int i = 0; i < indexChar.length; i++) {
		%> <a
			href='<portlet:renderURL><portlet:param name="action" value="list"/><portlet:param name="bptIndexChar" value="<%= indexChar[i]%>"/></portlet:renderURL>'
			class="team"><%=indexChar[i]%></a> <%
 	}
 %>
		</div>
		</td>
	</tr>
	<tr>
		<td width="50%" height="30" align="left">
		<div style="padding-top: 5px;">
		<form
			action='<portlet:actionURL><portlet:param name="action" value="searchBpsTerm"/></portlet:actionURL>'
			method="post" name="bpsUserForm"><strong style="padding-left: 5px;">Search:</strong>
		<input name="textfield" type="text" id="textfield" size="30"
			value="${bpsUserForm.bpsTerm.bptTerm}"> <select name="select" id="select">
			<option value="1" selected>By Term</option>
			<option value="2">By Difinition</option>
			<option value="3">By All</option>
		</select> <select name="select2" id="select2">
			<option value="0" selected>--Select Category--</option>
			<c:forEach items="${resultListGroup.resultListObj}" var="groupItem">
				<option value="${groupItem.bpgId}">${groupItem.bpgGroupName}</option>
			</c:forEach>
		</select> <input type="hidden" name="pageNo" id="pageNo" value="1"></form>
		</div>
		</td>
		<td width="50%" height="30" align="right"><a href='<portlet:renderURL><portlet:param name="action" value="viewBpsTerm"/><portlet:param name="bptId" value="0"/><portlet:param name="mode" value="add"/></portlet:renderURL>'><img src="<%=request.getContextPath()%>/images/New.gif"></a></td>
	</tr>
	<tr>
		<td colspan="2" height="15"></td>
	</tr>
	<tr>
		<td colspan="2" valign="top">
		<table width="100%" id="box-table-a" border="0" cellspacing="2"
			cellpadding="0" style="border: 1px solid #132C00">
			<tr>
				<th width="25%" height="25" align="center" bgcolor="#3DB0B5">Term&nbsp;<img
					src="<%=request.getContextPath()%>/images/up.png"><img
					src="<%=request.getContextPath()%>/images/down.png"></th>
				<th width="26%" align="center" bgcolor="#3DB0B5">Difinition&nbsp;<img
					src="<%=request.getContextPath()%>/images/up.png"><img
					src="<%=request.getContextPath()%>/images/down.png"></th>
				<th width="26%" align="center" bgcolor="#3DB0B5">Categoty&nbsp;<img
					src="<%=request.getContextPath()%>/images/up.png"><img
					src="<%=request.getContextPath()%>/images/down.png"></th>
				<th width="17%" align="center" bgcolor="#3DB0B5">Source&nbsp;<img
					src="<%=request.getContextPath()%>/images/up.png"><img
					src="<%=request.getContextPath()%>/images/down.png"></th>
				<th width="6%" align="center" bgcolor="#3DB0B5">&nbsp;</th>
			</tr>
			<c:if test="${resultList.maxRow != 0}">
			<c:forEach items="${resultList.resultListObj}" var="item">
				<tr>
					<td><a href='<portlet:renderURL><portlet:param name="action" value="viewBpsTerm"/><portlet:param name="bptId" value="${item.bptId}"/><portlet:param name="mode" value="view"/></portlet:renderURL>' class="team">${item.bptTerm}</a>
					</td>
					<td>${item.bptDefinition}</td>
					<td>${item.bpsGroup.bpgGroupName}</td>
					<td>${item.bptSource}</td>
					<td align="center"><a href='<portlet:renderURL><portlet:param name="action" value="viewBpsTerm"/><portlet:param name="bptId" value="${item.bptId}"/><portlet:param name="mode" value="edit"/></portlet:renderURL>'><img
						src="<%=request.getContextPath()%>/images/btn_edit.gif"></a></td>
				</tr>
			</c:forEach>
			<tr>
<!-- 		<td colspan="2" width="50%" height="30"><span -->
<!-- 			style="color: #030; font-size: 12px;">< Back to Home</span></td> -->
		<td colspan="5" width="100%" align="right">
		<div class="pagination">
		<%
			VResultMessage resultMessage = (VResultMessage)request.getAttribute("resultList"); 
			BpsUserForm bpsUserForm = (BpsUserForm) request
					.getAttribute("bpsUserForm");
			int pageNo = 1;
			int pageSize = 20;
			int total_page = 1;
			if (resultMessage != null && resultMessage.getMaxRow() != null) {
				Pagging paging = bpsUserForm.getBpsTerm().getPagging();
				if (paging != null) {
					pageNo = paging.getPageNo();
					pageSize = paging.getPageSize();
					int totalResult = Integer.parseInt(resultMessage.getMaxRow());
					if (totalResult % pageSize != 0) {
						Double d = Math.floor(totalResult / pageSize);
						total_page = d.intValue() + 1;
					} else {
						Double d = Math.floor(totalResult / pageSize);
						total_page = d.intValue()!=0?d.intValue():1;
					}
				}
			}
		%> <%=Paging.getPaging(pageNo, pageSize, total_page,
					request.getContextPath())%>
		</div>
		</td>
	</tr>
			</c:if>
			<c:if test="${resultList.maxRow == 0}">
				<tr>
					<td colspan="5" align="center" height="25" class="content">ไม่พบข้อมูล</td>
				</tr>
				<tr><td colspan="5" height="30" align="left"><span style="color: #030; font-size: 12px;">< Back to Home</span></td>
				</tr>
			</c:if>
		</table>
		</td>
	</tr>
</table>
</body>
</html>