<%@include file="../include.jsp"%>
<%@page contentType="text/html; charset=utf-8"%>
<html>
<head>
<c:url var="url" value="/" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src='${url}js/jquery-1.6.4.min.js'></script>
<script src='${url}js/jquery.highlight-3.js'></script>
<script type="text/javascript" src="${url}js/tabber.js"></script>
<link rel="stylesheet" href="${url}css/example.css" TYPE="text/css"
					MEDIA="screen"> 
<title>Insert title here</title>
<script>
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
<portlet:renderURL var="backURL">
    <portlet:param name="action" value="manageBpsTerm"/>
</portlet:renderURL>
<portlet:renderURL var="homeURL">
    <portlet:param name="action" value="list"/>
</portlet:renderURL>
<body>
<table width="950" align="center" border="0" cellspacing="0" cellpadding="0">
 <tr>
    <td height="30" colspan="2"><span style="color:#030; font-size:12px;"><strong>You are in:</strong> <a href="${fn:escapeXml(homeURL)}">Home</a> > <a href="${fn:escapeXml(backURL)}">BPS Term and Difinition</a> > ${bpsTerm.bptTerm}</span></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td align="right"></td>
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
						<th height="25" align="left" bgcolor="#3DB0B5"><span
							style="padding-left: 5px;">${bpsTerm.bptTerm}</span>
						</th>
					</tr>
					<tr>
						<td width="25%"><span style="padding: 5px;"><c:out value="${bpsTerm.bptDefinition}" escapeXml="false"/></span>
						</td>
					</tr>
				</table> 
				<table width="100%" id="box-table-a" border="0" cellspacing="2"
					cellpadding="0" style="border: 1px solid #132C00">
					<tr>
						<th height="25" align="left" bgcolor="#3DB0B5"><span
							style="padding-left: 5px;">Attachments</span>
						</th>
					</tr>
					<tr>
						<td width="25%">
							<div class="tabber">

								<div class="tabbertab">
									<h2>Attachments</h2>
									<c:if test="${!empty bpsAttachFiles}">
											<ul> 
												<c:forEach items="${bpsAttachFiles.resultListObj}" var="bpsAttachFile" varStatus="loop">   
												<c:set value="${bpsAttachFile.bpafFileSize/1024}" var="fileSize"></c:set>
                       		 					<jsp:useBean id="fileSize"  type="java.lang.Double" /> 
												<%float tmp = Math.round(fileSize.doubleValue()*10)/10; %>
													<span id="_element_img_${bpsAttachFile.bpafId}"><li><a id="_element_file_${bpsAttachFile.bpafId}" style="cursor: pointer;" onclick='<portlet:namespace />downloadFile("<c:out value="${bpsAttachFile.bpafHotLink}"/>")'>&nbsp;${bpsAttachFile.bpafFileName}</a> (<%=tmp %>&nbsp;KB) </li></span>												 
												</c:forEach>
											</ul>
									</c:if>
								</div>




							</div></td>
					</tr>
				</table></td>
		</tr>
	<%--
	<tr>
    <td width="50%" height="30"><span style="color:#030; font-size:12px;">< Back to Home</span></td>
    <td width="50%">&nbsp;</td>
   </tr>
    --%>
</table>
</body>
</html>