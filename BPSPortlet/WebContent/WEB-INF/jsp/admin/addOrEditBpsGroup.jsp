<%@include file="../include.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<portlet:actionURL var="formAction">
	<portlet:param name="action" value="saveBpsGroup" />
</portlet:actionURL>
<form:form modelAttribute="bpsAdminForm" action="${formAction}"
	method="post">
	<table width="100%">
		<tr>
			<td align="left">Group Name:</td>
			<td align="left"><form:input path="bpsGroup.bpgGroupName" maxlength="200"/></td>
		</tr>
		<tr>
			<td align="left"></td>
			<td align="left"><input type="submit" value="Save"></td>
		</tr>
		<tr>
			<td align="left"><a
			href='<portlet:renderURL><portlet:param name="action" value="manageBpsGroup"/></portlet:renderURL>'> &lt;&lt;Back </a></td>
			<td align="left"></td>
		</tr>
	</table>
	<form:hidden path="mode"/>
	<form:hidden path="bpsGroup.bpgId"/>
</form:form>
</body>
</html>