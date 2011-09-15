<%@include file="../include.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<table width="70%">
	<tr>
		<td align="right"><a
			href='<portlet:renderURL><portlet:param name="action" value="addOrEditBpsGroup"/><portlet:param name="mode" value="add"/></portlet:renderURL>'>Add</a></td>
	</tr>
	<tr>
		<td>
		<table width="70%" align="center">
			<tr bgcolor="black">
				<td align="center">No.</td>
				<td align="center">Group Name</td>
				<td align="center">Edit</td>
				<td align="center">Delete</td>
			</tr>
			<c:if test="${resultList ne null && resultList.resultListObj ne null}">
				<c:forEach items="${resultList.resultListObj}" var="item" varStatus="itemCount">
			<tr>
				<td align="center">${itemCount.count}</td>
				<td align="left">${item.bpgGroupName}</td>
				<td align="center"><a href="#">Edit</a></td>
				<td align="center"><a href='<portlet:renderURL><portlet:param name="action" value="deleteBpsGroup"/><portlet:param name="bpgId" value="${item.bpgId}"/></portlet:renderURL>'>Delete</a></td>
			</tr>
				</c:forEach>
			</c:if>
			<c:if test="${resultList eq null || resultList.resultListObj eq null}">
			<tr>
				<td align="center" colspan="4">Data not found.</td>
			</tr>
			</c:if>
		</table>
		</td>
	</tr>
</table>
</body>
</html>