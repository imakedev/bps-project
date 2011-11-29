<%@include file="../include.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function goToPage(_url){
	//alert(_url)
	window.location.href=_url;
}
</script>
</head>
<body>
<portlet:renderURL var="linka">
    <portlet:param name="action" value="manageBpsTerm"/>
</portlet:renderURL>
<portlet:renderURL var="linkb">
    <portlet:param name="action" value="manageBpsGroup"/>
</portlet:renderURL>

<table width="100%">
<tr>
	<td><a href="${fn:escapeXml(linka)}">Manage Term x</a></td>
</tr>
<tr>
	<td><span onclick='goToPage("${linkb}")' style="cursor: pointer;text-decoration: underline;">Manage Groupcc</span></td>
</tr>
</table>
</body>
</html>