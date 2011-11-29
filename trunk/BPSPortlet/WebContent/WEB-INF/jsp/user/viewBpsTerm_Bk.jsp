<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="portlet" uri="http://java.sun.com/portlet"%>
<portlet:defineObjects />
<html>
<head>
<script type="text/javascript">
function <portlet:namespace/>downloadFile(_hotLink){ 
 	var src = "http://localhost:8081/BPSDownloadServlet/DownloadServlet?"+_hotLink;
 	 
    var div = document.createElement("div");
    document.body.appendChild(div);
    div.innerHTML = "<iframe width='0' height='0' scrolling='no' frameborder='0' src='" + src + "'></iframe>";
	  // Create an IFRAME.
	//var _form =document.getElementById('downloadAdminform');
 	//_form.submit();
} 
</script>
</head>
<body>
	<table width="100%" align="center" border="0" cellspacing="0"
		cellpadding="0">
		<tr>
			<td height="30" colspan="2"><span
				style="color: #030; font-size: 12px;" align="left"><strong>You
						are in:</strong> <a href="index.html">Home</a> > <a href='<portlet:renderURL><portlet:param name="action" value="list"/></portlet:renderURL>'>BPS
						Term and Difinition</a> > ${bpsUserForm.bpsTerm.bptTerm}</span>
			</td>
		</tr>
<!-- 		<tr height="50"> -->
<!-- 			<td align="left"><img -->
<%-- 				src="<%=request.getContextPath()%>/images/term.gif"> --%>
<!-- 			</td> -->
<%-- 			<td align="right"><a href='<portlet:renderURL><portlet:param name="action" value="viewBpsTerm"/><portlet:param name="bptId" value="${bpsUserForm.bpsTerm.bptId}"/><portlet:param name="mode" value="edit"/></portlet:renderURL>'><img --%>
<%-- 					src="<%=request.getContextPath()%>/images/btn_comment.gif" --%>
<!-- 					width="128" height="25"> -->
<!-- 			</a> -->
<!-- 			</td> -->
<!-- 		</tr> -->
		<tr>
			<td height="30" colspan="2" align="left"><span
				style="color: #030; font-size: 16px;"><strong>${bpsUserForm.bpsTerm.bptTerm}</strong></span>
			</td>
		</tr>
		<tr>
			<td height="30" colspan="2" align="left"><span
				style="color: #030; font-size: 12px;"><strong>Category:</strong> ${bpsUserForm.bpsTerm.bpsGroup.bpgGroupName} | <strong>Source:</strong> ${bpsUserForm.bpsTerm.bptSource} | <strong>Update:</strong>${bpsUserForm.bpsTerm.bptCreateDate} by ${bpsUserForm.bpsTerm.bptCreateBy}</span>
			</td>
		</tr>
		<tr>
			<td height="30" colspan="2" align="left"><a href='<portlet:renderURL><portlet:param name="action" value="viewBpsTerm"/><portlet:param name="bptId" value="${bpsUserForm.bpsTerm.bptId}"/><portlet:param name="mode" value="edit"/></portlet:renderURL>'>
				<img src="<%=request.getContextPath()%>/images/btn_comment.gif" width="128" height="25">
				</a>
			</td>
		</tr>
		<tr>
			<td height="40" colspan="2" align="left"><span
				style="color: #030; font-size: 12px;"><c:out value="${bpsUserForm.bpsTerm.bptShortDesc}" escapeXml="false" /></span>
			</td>
		</tr>
		<tr>
			<td height="30" colspan="2" align="left"><span
				style="color: #030; font-size: 12px;"><c:out value="${bpsUserForm.bpsTerm.bptDefinition}" escapeXml="false" /></span>
			</td>
		</tr>
		<tr height="50"></tr>
		<tr>
			<td height="30" colspan="2" align="left"><span
				style="color: #030; font-size: 12px;">Attachment</span>
			</td>
		</tr>
		<tr><td colspan="2"><hr></td></tr>
		<tr>
			<td width="25%" align="left">
				<ul>
					<c:forEach items="${resultList.resultListObj}" var="item">
						<c:set value="${item.bpafFileSize/1024}" var="fileSize"></c:set>
                       	<jsp:useBean id="fileSize"  type="java.lang.Double" /> 
						<%float tmp = Math.round(fileSize.doubleValue()*10)/10; %>
						<li><a href='javascript: downloadFile("${item.bpafHotLink}")'>&nbsp;${item.bpafFileName}</a><br><%= tmp%> KB</li>
					</c:forEach>
				</ul></td>
		</tr>
		<tr height="50"></tr>
		
<!-- 		<tr> -->
<!-- 			<td colspan="2" valign="top"> -->
<!-- 				<table width="100%" id="box-table-a" border="0" cellspacing="2" -->
<!-- 					cellpadding="0" style="border: 1px solid #132C00"> -->
<!-- 					<tr> -->
<!-- 						<th height="25" align="left" bgcolor="#3DB0B5"><span -->
<%-- 							style="padding-left: 5px;">${bpsUserForm.bpsTerm.bptTerm}</span> --%>
<!-- 						</th> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<%-- 						<td width="25%"><span style="padding: 5px;"><c:out value="${bpsUserForm.bpsTerm.bptDefinition}" escapeXml="false" /></span> --%>
<!-- 						</td> -->
<!-- 					</tr> -->
<!-- 				</table> <br> -->
<!-- 				<table width="100%" id="box-table-a" border="0" cellspacing="2" -->
<!-- 					cellpadding="0" style="border: 1px solid #132C00"> -->
<!-- 					<tr> -->
<!-- 						<th height="25" align="left" bgcolor="#3DB0B5"><span -->
<!-- 							style="padding-left: 5px;">Attachments</span> -->
<!-- 						</th> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td width="25%"> -->
<!-- 							<ul> -->
<%-- 								<c:forEach items="${resultList.resultListObj}" var="item"> --%>
<%-- 									<li><a href='javascript: downloadFile("${item.bpafHotLink}")'>&nbsp;${item.bpafFileName}</a></li> --%>
<%-- 								</c:forEach> --%>
<!-- 							</ul></td> -->
<!-- 					</tr> -->
<!-- 				</table></td> -->
<!-- 		</tr> -->
		<tr>
			<td width="50%" height="30" align="left"><span
				style="color: #030; font-size: 12px;"><a href='<portlet:renderURL><portlet:param name="action" value="list"/></portlet:renderURL>'>< Back to Home</a></span>
			</td>
			<td width="50%">&nbsp;</td>
		</tr>
	</table>
</body>
</html>