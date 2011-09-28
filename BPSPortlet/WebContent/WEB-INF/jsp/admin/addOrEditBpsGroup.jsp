<%@include file="../include.jsp"%>
<%@page contentType="text/html; charset=utf-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>
#box-table-a {
	font-size: 12px;
	margin: 0px;
	width: 100%;
	text-align: left;
	border-collapse: collapse;
}

#box-table-a th {
	font-size: 13px;
	font-weight: bold;
	padding: 8px;
	background: #132C00;
	border-top: 4px solid #859D48;
	border-bottom: 1px solid #fff;
	color: #FFF;
}

#box-table-a td {
	padding: 8px;
	background: #e8edff;
	border-bottom: 1px solid #fff;
	color: #000;
	border-top: 1px solid transparent;
	height: 25px;
	border: 1px solid #3DB0B5;
}

#box-table-a tr:hover td {
	background: #d0dafd;
}

table#box-table-a a {
	color: #003399;
	text-decoration: none;
	font-family: Tahoma;
	font-size: 12px;
	font-weight: bold;
}

table#box-table-a a:link,table.links a:visited {
	color: #004a5d;
	font-family: Tahoma;
	font-size: 12px;
	font-weight: bold;
}

table#box-table-a a:hover {
	color: #758D39;
	font-family: Tahoma;
	font-size: 12px;
	font-weight: bold;
	text-decoration: underline;
}
</style>
<script>
function <portlet:namespace />doAction(_command,_mode){
	//alert(_command+","+_mode);
	var command = document.getElementById("command");
	//alert(nfaqId.value+","+command.value);
	command.value=_command;
	var agree ;
	//alert(_urlDelete)
	if(_mode == 'edit')
	agree = confirm(" Would you like to edit member? ");
	else
	agree = confirm(" Would you like to add member? ");
	if (agree){
	//window.location.href = _urlDelete;
		return true ;
	}
	else{
		return false ;
	} 
		return true;//false;
	}
</script>
</head>
<body>
<portlet:renderURL var="backURL">
    <portlet:param name="action" value="manageBpsGroup"/>
</portlet:renderURL>
<portlet:actionURL var="formAction">
    <portlet:param name="action" value="saveBpsGroup"/>
</portlet:actionURL>
<portlet:renderURL var="homeURL">
    <portlet:param name="action" value="list"/>
</portlet:renderURL>
<form:form  name="bpsAdminForm" modelAttribute="bpsAdminForm" method="post" action="${formAction}">
<form:hidden path="command" id="command"/>
<form:hidden path="bpsGroup.bpgId" id="bpgId" /> 
	<table width="950" align="center" border="0" cellspacing="0"
		cellpadding="0">
		<tr>
			<td height="30" colspan="2"><span
				style="color: #030; font-size: 12px;"><strong>You
						are in:</strong> <a href="${fn:escapeXml(homeURL)}">Home</a> > <a href="${fn:escapeXml(manageBpsGroup)}">BPS
						Term and Difinition</a> >
						<c:if test="${mode=='add'}">Add</c:if>
						<c:if test="${mode=='add'}">Edit</c:if>  
						BPS Term and Difinition</span>
			</td>
		</tr>
		<tr>
			<td><img src="images/term.gif">
			</td>
			<td align="right">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2" valign="top">
				<!--//--> 
				<form action="" method="get" enctype="multipart/form-data">
					<table width="100%" border="0" cellspacing="5" cellpadding="0">
						<tr>
							<th width="13%" height="25" align="left">Category Name:</th>
							<td width="87%" align="left"><form:input path="bpsGroup.bpgGroupName" size="45"/>  
							</td>
						</tr> 
						<tr>
						<td width="13%">&nbsp;</td>
						<td width="87%" align="left" height="20"><input type="submit"
							name="button_add" id="button_add" value=" Submit " onclick='<portlet:namespace />doAction("${urlAdd}","add")'/>  
						</td>
					</tr>
					</table> 
				</form>
			</td>
		</tr>
		<tr>
			<td width="50%" height="30"><span
				style="color: #030; font-size: 12px;">< Back to Home</span>
			</td>
			<td width="50%">&nbsp;</td>
		</tr>
	</table>
</form:form>
</body>
</html>