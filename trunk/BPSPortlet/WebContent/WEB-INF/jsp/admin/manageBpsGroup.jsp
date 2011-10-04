<%@include file="../include.jsp"%>
<%@page contentType="text/html; charset=utf-8"%>
<html>
<head>
<c:url var="url" value="/" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src='${url}js/jquery-1.6.4.min.js'></script>
<link rel="stylesheet" type="text/css" href="${url}css/style_cos.css" />
<title>Insert title here</title>
<script>
	$(document).ready(function() {
	  // Handler for .ready() called. 
	});
	function <portlet:namespace />doAction(_url,mode) {		
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
	function <portlet:namespace />doDelete(_url) {
			var agree = confirm("Would you like to delete ?");
			if (agree) {
				window.location.href = _url;
			} else {
			}		 
	}
</script>
</head>
<body>
<portlet:renderURL var="urlAdd">
    	<portlet:param name="action" value="addOrEditBpsGroup"/>
    		<portlet:param name="mode" value="add"/>
    		<portlet:param name="bpgId" value="0"/> 
</portlet:renderURL>
<portlet:renderURL var="formAction">
    <portlet:param name="action" value="manageBpsGroup"/>
</portlet:renderURL> 
<portlet:renderURL var="homeURL">
    <portlet:param name="action" value="list"/>
</portlet:renderURL>
<form:form  modelAttribute="bpsAdminForm" method="post"  action="${formAction}">
<form:hidden path="command" id="command"/>

	<table width="950" align="center" border="0" cellspacing="0"
		cellpadding="0">
		<tr>
			<td height="30" colspan="2"><span
				style="color: #030; font-size: 12px;"><strong>You
						are in:</strong> <a href="${fn:escapeXml(homeURL)}">Home</a> > Corporate Work Procedure > Manage a Category</span>
			</td>
		</tr>
		<tr>
			<td><img src="${url}images/corporatew.gif" width="233" height="22">
			</td>
			<td align="right">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2"><table width="100%" border="0" cellspacing="2"
					cellpadding="0">
					<tr>
						<td height="20" colspan="3"><strong>Manage a Category
								for Corporate Work Procedure</strong>
						</td>
					</tr>
					<tr>
						<td width="100%" align="left" colspan="3" height="20"><strong>Category :</strong>
							<label><form:input path="bpgGroupName" id="bpgGroupName"/></label><input type="submit" name="button_search" id="button_search" value="Search">
						</td> 
					</tr>
					<tr>
						<td height="20">&nbsp;</td>
						<td align="right" height="20" colspan="2"><input type="button"
							name="button_add" id="button_add" value=" Add " onclick='<portlet:namespace />doAction("${urlAdd}","add")'/>  
						</td>
					</tr>
				</table>
			</td>
		</tr> 
		<tr>
			<td colspan="2" valign="top"> 
				<table width="100%" border="0" cellspacing="2" cellpadding="0"
					style="border: 1px solid #132C00">
					<tr>
						<th height="25" align="center" bgcolor="#3DB0B5">Categories
						</th>
					</tr>
					<tr>
						<td valign="top">
							<table width="100%" id="box-table-a" border="0" cellspacing="2"
								cellpadding="0">  
								 <c:forEach items="${bpsGroups.resultListObj}" var="bpsGroup" varStatus="loop">  
								  	<tr>  
										<td width="85%" align="left"><span><c:out value="${bpsGroup.bpgGroupName}"/></span></td>
										 	<portlet:actionURL var="urlDelete">
                         						<portlet:param name="action" value="deleteBpsGroup"/>
                         						<portlet:param name="bpgId" value="${bpsGroup.bpgId}"/>                            
                      						</portlet:actionURL>
                      						<portlet:renderURL var="urlEdit">
                         						<portlet:param name="action" value="addOrEditBpsGroup"/>
                         						<portlet:param name="mode" value="edit"/>
                         						<portlet:param name="bpgId" value="${bpsGroup.bpgId}"/>                            
                      						</portlet:renderURL> 
										<td width="15%" align="center"><span style="cursor: pointer;" onclick='<portlet:namespace />doAction("${urlEdit}","edit")'>Edit</span> | <span style="cursor: pointer;" onclick='<portlet:namespace />doAction("${urlDelete}","delete")'>Delete</span></td>
									</tr>	
								</c:forEach>				 
							</table></td>
					</tr>
				</table></td>
		</tr>
		<tr> 
			<td width="50%"><div class="pagination">
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
				</div></td>
		</tr>
	</table>
</form:form>
</body>
</html>