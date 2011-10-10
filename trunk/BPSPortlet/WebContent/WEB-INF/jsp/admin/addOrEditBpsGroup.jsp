<%@include file="../include.jsp"%>
<%@page contentType="text/html; charset=utf-8"%>
<html>
<head>
<c:url var="url" value="/" />
<script src='${url}js/jquery-1.6.4.min.js'></script>
<script type="text/javascript"
        src="${url}dwr/interface/BpsAdminAjax.js"></script> 
<script type="text/javascript"
        src="${url}dwr/engine.js"></script> 
<script type="text/javascript"
        src="${url}dwr/util.js"></script> 
<link rel="stylesheet" type="text/css"
	href="${url}css/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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
function <portlet:namespace />doActionCheck(_mode){
	var agree ;
	//alert(_urlDelete)
	if(_mode == 'edit')
		agree = confirm(" Would you like to edit Categoty? ");
	else
		agree = confirm(" Would you like to add Categoty? ");
	if (agree){ 
		var bpgGroupName= jQuery.trim($("#bpgGroupName").val());
		BpsAdminAjax.checkDuplicateGroup(jQuery.trim(bpgGroupName),{
			callback:function(data){
				if(data!=0){ // have data
					if(_mode == 'edit')
						alert(" Can't Edit , Duplicate value ");
					else
						alert(" Can't Add , Duplicate value ");
				}else{
					if(_mode == 'edit')
						$("#button_edit").click();
					else
						$("#button_save").click();
				}
			}
		});
	}
	else{
		return false ;
	} 
	
}
function <portlet:namespace />doAction(_command,_mode){
	//alert(_command+","+_mode);
	var command = document.getElementById("command");
	//alert(nfaqId.value+","+command.value);
	command.value=_command;
	/*
	var agree ;
	//alert(_urlDelete)
	if(_mode == 'edit')
		agree = confirm(" Would you like to edit Categoty? ");
	else
		agree = confirm(" Would you like to add Categoty? ");
	if (agree){
	//window.location.href = _urlDelete;
		return true ;
	}
	else{
		return false ;
	} 
	*/
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
			<td><img src="${url}images/term.gif">
			</td>
			<td align="right">&nbsp;</td>
		</tr>
		<tr>
			<td height="30" colspan="2"><span
				style="color: #030; font-size: 12px;"><strong>You
						are in:</strong> <a href="${fn:escapeXml(homeURL)}">Home</a> > <a href="${fn:escapeXml(backURL)}">BPS
						Term and Difinition</a> >
						<c:if test="${mode=='add'}">Add</c:if>
						<c:if test="${mode=='edit'}">Edit</c:if>  
						BPS Term and Difinition</span>
			</td>
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
							<td width="87%" align="left"><form:input path="bpsGroup.bpgGroupName" id="bpgGroupName" size="45"/>  
							</td>
						</tr> 
						<tr>
						<td width="13%">&nbsp;</td>
						<td width="87%" align="left" height="20">
						<c:if test="${mode=='add'}">
							<input type="submit" style="display: none;"
							name="button_save" id="button_save" value=" Submit "  onclick='return <portlet:namespace />doAction("doSave","add")' />
							<input id="button_save_check" type="button" value=" Submit " onclick='<portlet:namespace />doActionCheck("add")'/>
							<%--
							 onclick='<portlet:namespace />doAction("doSave","add")'
							 --%>
						</c:if>
						<c:if test="${mode=='edit'}">
							<input type="submit" style="display: none;"
							name="button_edit" id="button_edit" value=" Submit  " onclick='return <portlet:namespace />doAction("doSave","edit")' />
							<input id="button_edit_check" type="button" value=" Submit " onclick='<portlet:namespace />doActionCheck("edit")'/>
						</c:if>  	 
						</td>
					</tr>
					</table> 
				</form>
			</td>
		</tr>
	</table>
</form:form>
</body>
</html>