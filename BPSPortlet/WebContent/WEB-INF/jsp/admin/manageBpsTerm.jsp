<%@include file="../include.jsp"%>
<%@page contentType="text/html; charset=utf-8"%>
<html>
<head>
<c:url var="url" value="/" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src='${url}js/jquery-1.6.4.min.js'></script>
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="${url}css/style.css" />
<script>
	function <portlet:namespace />doAction(_url, mode) {
		if (mode == 'delete') {
			var agree = confirm("Would you like to delete ?");
			if (agree) {
				window.location.href = _url;
			} else {
			}
		} else {
			window.location.href = _url;
		}
	}
</script>
</head>
<body>
<portlet:renderURL var="urlAdd">
    	<portlet:param name="action" value="addOrEditBpsTerm"/>
    		<portlet:param name="mode" value="add"/>
    		<portlet:param name="bptId" value="0"/> 
</portlet:renderURL>
<portlet:renderURL var="formAction">
    <portlet:param name="action" value="manageBpsTerm"/>
</portlet:renderURL> 
<form:form  modelAttribute="bpsAdminForm" method="post"  action="${formAction}">
<form:hidden path="command" id="command"/>
	<table width="100%" align="center" border="0" cellspacing="0"
		cellpadding="0">
		<tr> 
			<td height="30" colspan="2"><span
				style="color: #030; font-size: 12px;"><strong>You
						are in:</strong> Home > BPS Term and Difinition</span>
			</td>
		</tr>
		<tr> 
			 <td align="left"><img src="${url}images/term.gif"></td>
	    	 <td align="right">
	    	 <%--
	    	 <a href="#"><img src="${url}images/btn_admin.gif" width="65" height="25">
	    	  --%></a>
	    	 </td>
		</tr>

		<tr>
			<td colspan="2"><div class="team" style="padding-left: 10px;">
			<%
				String[] indexChar = { "A", "B", "C", "D", "E", "F", "G", "H", "I",
					"J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U",
					"V", "W", "X", "Y", "Z" };
				for (int i = 0; i < indexChar.length; i++) {
			%> <a
				href='<portlet:renderURL><portlet:param name="action" value="list"/><portlet:param name="bptIndexChar" value="<%= indexChar[i]%>"/></portlet:renderURL>'
				class="team">
				<%if("B".equals(indexChar[i])){
				%>
				<span style="font-style:italic;color: black;text-decoration: none;"><%=indexChar[i]%></span>
				<%
				}else{
				%>
					<%=indexChar[i]%>
				<%
				}%> 
				</a> <%
 				}
 			%> 
				</div>
			</td>
		</tr>
		<tr>
			<td width="50%">
				<div style="padding-top: 5px;"> 
						<strong style="padding-left: 5px;">Search:</strong> <form:input path="bptTerm" id="bptTerm"/>
						<form:select path="searchBy" id="searchBy">
	    					<form:option  label="By Term" value="1"/>
	    					<form:option  label="By Difinition" value="2"/>
	    					<form:option  label="By All" value="3"/>
	    				</form:select>  
						<form:select path="bpgId" id="bpgId">
	    					<form:option  label="---Select Category--" value="0"/>
	    					<form:options items="${listCates}" itemValue="bpgId"  itemLabel="bpgGroupName"/>
	    				</form:select>  
	    				<input type="submit" name="button_search" id="button_search" value="Search"/>
						<%--
						 <select name="select2" id="select2">
							<option value="0" selected>--Select Category--</option>
							<option value="1">Category1</option>
							<option value="2">Category2</option>
						</select>
						 --%> 
				</div></td>
				<td width="50%" align="right" height="20"><input type="button"
							name="button_add" id="button_add" value=" Add " onclick='<portlet:namespace />doAction("${urlAdd}","add")'/>  
				</td>
		</tr>
		 
		<tr>
			<td colspan="2" valign="top">
				<!--//-->
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
				<table width="100%" id="box-table-a" border="0" cellspacing="2"
					cellpadding="0" style="border: 1px solid #132C00">
					<tr>
						<th width="25%" height="25" align="center" bgcolor="#3DB0B5">Term&nbsp;<img
							src="${url}images/up.png" style="cursor: pointer;"><img src="${url}images/down.png" style="cursor: pointer;">
						</th>
						<th width="26%" align="center" bgcolor="#3DB0B5">Difinition&nbsp;<img
							src="${url}images/up.png" style="cursor: pointer;"><img src="${url}images/down.png" style="cursor: pointer;">
						</th>
						<th width="26%" align="center" bgcolor="#3DB0B5">Categoty&nbsp;<img
							src="${url}images/up.png" style="cursor: pointer;"><img src="${url}images/down.png" style="cursor: pointer;">
						</th>
						<th width="17%" align="center" bgcolor="#3DB0B5">Source&nbsp;<img
							src="${url}images/up.png" style="cursor: pointer;"><img src="${url}images/down.png" style="cursor: pointer;">
						</th>
						<th width="6%" align="center" bgcolor="#3DB0B5">&nbsp;</th>
					</tr>
					<c:if test="${bpsTerms.maxRow != 0}">
						<c:forEach items="${bpsTerms.resultListObj}" var="bpsTerm" varStatus="loop">  
								  	<tr>  
								  		<td><a href="BPSTerm02_detail.html" class="team"><c:out value="${bpsTerm.bptTerm}"/></a>
										</td>
										<td><c:out value="${bpsTerm.bptDefinition}" escapeXml="false"/></td>
										<td><c:out value="${bpsTerm.bpsGroup.bpgGroupName}"/></td> 
										<td><c:out value="${bpsTerm.bptSource}"/></td>
										<td align="center">
										<portlet:actionURL var="urlDelete">
                         						<portlet:param name="action" value="deleteBpsTerm"/>
                         						<portlet:param name="bptId" value="${bpsTerm.bptId}"/>                            
                      						</portlet:actionURL>
                      						<portlet:renderURL var="urlEdit">
                         						<portlet:param name="action" value="addOrEditBpsTerm"/>
                         						<portlet:param name="mode" value="edit"/>
                         						<portlet:param name="bptId" value="${bpsTerm.bptId}"/>                            
                      						</portlet:renderURL> 
										<img   style="cursor: pointer;" onclick='return <portlet:namespace />doAction("${urlEdit}","edit")' src="${url}images/edit.png" width="16"
											height="16" style="cursor: pointer;">
											<img style="cursor: pointer;" onclick='return <portlet:namespace />doAction("${urlDelete}","delete")' src="${url}images/delete.png" width="16" style="cursor: pointer;"
											height="16">
										</td>										
									</tr>	
								</c:forEach>
					</c:if>
					<c:if test="${bpsTerms.maxRow == 0}">
						<tr>
							<td colspan="5" align="center" height="25" class="content">ไม่พบข้อมูล</td>
						</tr>
					</c:if>
					<%--
					<tr>
						<td><a href="BPSTerm02_detail.html" class="team">xxx</a>
						</td>
						<td>xxxx 200 ตัวอักษร</td>
						<td>xxxx</td>
						<td>xxxx</td>
						<td align="center"><img src="${url}images/edit.png" width="16"
							height="16" style="cursor: pointer;"><img src="${url}images/delete.png" width="16" style="cursor: pointer;"
							height="16">
						</td>
					</tr>
					 --%>
					 
				</table></td>
		</tr>
		<tr> 
			<td width="100%" colspan="2">
				<div class="pagination">
				<%--
					<ul>
						<li><a href="#" class="prevnext disablelink">« previous</a>
						</li>
						<li><a href="#" class="currentpage">1</a>
						</li>
						<li><a href="#">2</a>
						</li>
						<li><a href="#">3</a>
						</li>
						<li><a href="#">4</a>
						</li>
						<li><a href="#">5</a>
						</li>
						<li><a href="#">6</a>
						</li>
						<li><a href="#">7</a>
						</li>
						<li><a href="#">8</a>
						</li>
						<li><a href="#">9</a>…</li>
						<li><a href="#">15</a>
						</li>
						<li><a href="#">16</a>
						</li>
						<li><a href="#" class="prevnext">next »</a>
						</li>
					</ul>
					 --%>
				</div>
			</td>
		</tr>
	</table>
</form:form>
</body>
</html>