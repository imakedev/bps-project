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
</head>
<body>
	<table width="100%" align="center" border="0" cellspacing="0"
		cellpadding="0">
		<tr>
			<td height="30" colspan="2"><span
				style="color: #030; font-size: 12px;"><strong>You
						are in:</strong> Home > BPS Term and Difinition</span>
			</td>
		</tr>
		<!--   <tr> -->
		<!--     <td>&nbsp;</td> -->
		<!--     <td align="right"><a href="BPSTerm_admin_add.html"><img src="images/btn_admin.gif" width="65" height="25"></a></td> -->
		<!--   </tr> -->
		<tr>
			<td colspan="2" height="30"><div class="team"
					style="padding-left: 10px;">
					<%
						String[] indexChar = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};
						for(int i=0;i<indexChar.length;i++) {
					%>
							<a href='<portlet:renderURL><portlet:param name="action" value="list"/><portlet:param name="bptIndexChar" value="<%= indexChar[i]%>"/></portlet:renderURL>' class="team"><%= indexChar[i]%></a> 
					<%		
						}
					%>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2" height="30">
				<div style="padding-top: 5px;">
					<form action='<portlet:actionURL><portlet:param name="action" value="searchBpsTerm"/></portlet:actionURL>' method="post">
						<strong style="padding-left: 5px;">Search:</strong> <input
							name="textfield" type="text" id="textfield" size="30" value="${bpsTerm.bptTerm}"> <select
							name="select" id="select">
							<option value="1" selected>By Term</option>
							<option value="2">By Difinition</option>
							<option value="3">By All</option>
						</select> <select name="select2" id="select2">
							<option value="0" selected>--Select Category--</option>
							<c:forEach items="${resultListGroup.resultListObj}"
								var="groupItem">
								<option value="${groupItem.bpgId}">${groupItem.bpgGroupName}</option>
							</c:forEach>
						</select>
						<input type="hidden" name="pageNo" id="pageNo" value="1">
					</form>
				</div></td>
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
							src="<%=request.getContextPath()%>/images/down.png">
						</th>
						<th width="26%" align="center" bgcolor="#3DB0B5">Difinition&nbsp;<img
							src="<%=request.getContextPath()%>/images/up.png"><img
							src="<%=request.getContextPath()%>/images/down.png">
						</th>
						<th width="26%" align="center" bgcolor="#3DB0B5">Categoty&nbsp;<img
							src="<%=request.getContextPath()%>/images/up.png"><img
							src="<%=request.getContextPath()%>/images/down.png">
						</th>
						<th width="17%" align="center" bgcolor="#3DB0B5">Source&nbsp;<img
							src="<%=request.getContextPath()%>/images/up.png"><img
							src="<%=request.getContextPath()%>/images/down.png">
						</th>
						<th width="6%" align="center" bgcolor="#3DB0B5">&nbsp;</th>
					</tr>
					<c:if test="${resultList.maxRow == 0}">
						<tr>
							<td colspan="5" align="center" height="25" class="content">ไม่พบข้อมูล</td>
						</tr>
					</c:if>
					<c:forEach items="${resultList.resultListObj}" var="item">
						<tr>
							<td><a href="BPSTerm02_detail.html" class="team">${item.bptTerm}</a>
							</td>
							<td>${item.bptDefinition}</td>
							<td>${item.bpsGroup.bpgGroupName}</td>
							<td>${item.bptSource}</td>
							<td align="center"><img src="<%= request.getContextPath()%>/images/btn_edit.gif" width="16"
								height="16"><img src="images/delete.png" width="16"
								height="16">
							</td>
						</tr>
					</c:forEach>
				</table></td>
		</tr>
		<tr>
			<td width="50%" height="30"><span
				style="color: #030; font-size: 12px;">< Back to Home</span>
			</td>
			<td width="50%" align="right">
				<div class="pagination">
					<a href="#" class="prevnext disablelink"><< previous</a> <a
						href="#" class="currentpage">1</a> <a href="#">2</a> <a href="#">3</a>
					<a href="#">4</a> <a href="#">5</a> <a href="#">6</a> <a href="#">7</a>
					<a href="#">8</a> <a href="#">9</a> <a href="#">15</a> <a href="#">16</a>
					<a href="#" class="prevnext">next >></a>
				</div>
			</td>
		</tr>
	</table>
</body>
</html>