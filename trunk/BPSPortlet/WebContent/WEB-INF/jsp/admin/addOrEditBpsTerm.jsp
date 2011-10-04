<%@include file="../include.jsp"%>
<%@page contentType="text/html; charset=utf-8"%>
<html>
<head>
<c:url var="url" value="/" />
<script src='${url}js/jquery-1.6.4.min.js'></script>
<link rel="stylesheet" type="text/css"
	href="${url}css/style.css" />
<link rel="stylesheet" type="text/css"
	href="${url}css/example.css" />
<link type="text/css" rel="stylesheet"
	href="${url}ckeditor/_samples/sample.css" />
<script type="text/javascript"
	src="${url}ckeditor/ckeditor.js"></script>
<script type="text/javascript"
	src="${url}js/tabber.js"></script>
<script type="text/javascript"
        src="${url}dwr/interface/BpsAdminAjax.js"></script> 
<script type="text/javascript"
        src="${url}dwr/engine.js"></script> 
<script type="text/javascript"
        src="${url}dwr/util.js"></script> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

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

function setChoice(_id){
	
}
function clearFile(spanId){
	//$("#"+elementId).val("");
	var agree = confirm(" Would you like to delete file ? ");
	if (agree){
		BpsAdminAjax.deleteBpsAttachFile(spanId,{
			callback:function(data){ 
				 if(data!=null){
					 $("#_element_img_"+spanId).html("");
					 $("#_element_file_"+spanId).html("");
				 }
			}
		}); 
	 }
}
function <portlet:namespace />doAction(_command,_mode){
	//alert(_command+","+_mode);
	var command = document.getElementById("command");
	//alert(nfaqId.value+","+command.value);
	command.value=_command;
	var agree ;
	//alert(_urlDelete)
	if(_mode == 'edit')
		agree = confirm(" Would you like to edit Term and Definition? ");
	else
		agree = confirm(" Would you like to add Term and Definition? ");
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
<portlet:renderURL var="backURL">
    <portlet:param name="action" value="manageBpsTerm"/>
</portlet:renderURL>
<portlet:actionURL var="formAction">
    <portlet:param name="action" value="saveBpsTerm"/>
</portlet:actionURL>
<portlet:renderURL var="homeURL">
    <portlet:param name="action" value="list"/>
</portlet:renderURL>
<body>
<form:form  name="bpsAdminForm" modelAttribute="bpsAdminForm" method="post" action="${formAction}"  enctype="multipart/form-data">
<form:hidden path="command" id="command"/>
	<table width="100%" align="center" border="0" cellspacing="0"
		cellpadding="0">
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
			<td><img src="${url}images/term.gif">
			</td>
			<td align="right">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2">&nbsp;</td>
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
					<table width="100%" border="0" cellspacing="5" cellpadding="0">
						<tr>
							<th width="13%" height="25" align="left">Term:</th>
							<td width="87%" align="left">
								<form:input path="bpsTerm.bptTerm" size="45"/> 
							</td>
						</tr>
						<tr>
							<th valign="top" align="left">Definiion:</th>
							<td align="left" valign="top">
							<form:textarea path="bpsTerm.bptDefinition" id="bptDefinition" rows="10" cols="80"/> 
							<script type="text/javascript">
									CKEDITOR.replace('bptDefinition');
							</script>
							<%--
							<textarea name="" cols="80"
									rows="8">A wiki (Listeni/ˈwɪki/ wik-ee) is a website that allows the creation and editing of any number of interlinked web pages via a web browser using a simplified markup language or a WYSIWYG text editor.[1][2][3] Wikis are typically powered by wiki software and are often used collaboratively by multiple users. Examples include community websites, corporate intranets, knowledge management systems, and note services. The software can also be used for personal notetaking.

Wikis serve different purposes. Some permit control over different functions (levels of access). For example editing rights may permit changing, adding or removing material. Others may permit access without enforcing access control. Other rules can be imposed for organizing content.</textarea>
 	--%>
							</td>
						</tr>
						<tr>
							<th width="13%" height="25" align="left">Category:</th>
							<td width="87%" align="left">
							<form:select path="bpsTerm.bpsGroup.bpgId" id="bpgId">
	    						<form:option  label="---Select Category--" value="0"/>
	    						<form:options items="${listCates}" itemValue="bpgId"  itemLabel="bpgGroupName"/>
	    					</form:select> 
							 &nbsp; <a
								href="<portlet:renderURL><portlet:param name="action" value="manageBpsGroup"/></portlet:renderURL>">Manage Category</a>
							</td>
						</tr>
						<tr>
							<th height="25" align="left">Source / Refence:</th>
							<td align="left"><form:input path="bpsTerm.bptSource" size="45"/>
							</td>
						</tr>
						<tr>
							<th height="25" align="left">Attachments:</th>
							<td align="left">
							<label> <input type="file" name="file0"/>  <img	src="${url}images/plus.png" alt="Add more file" style="cursor: pointer;" onclick="clearFile('x')" /><br/>
							<input type="file" name="file1"/> 
							</label>
							</td>
						</tr>
						<tr>
							<th height="25" align="left">&nbsp;</th>
							<td align="left"><span style="padding-top: 5px;">
							<c:if test="${mode=='add'}">
								<input type="submit"
									name="button_add" id="button_add" value="Save &amp; Publish"  onclick='return <portlet:namespace />doAction("doSave","add")' />
							 
							</c:if>
							<c:if test="${mode=='edit'}">
								<input type="submit"
								name="button_add" id="button_add" value="Save &amp; Publish" onclick='return <portlet:namespace />doAction("doSave","edit")' />
							</c:if>  
							</span>
							</td>
						</tr>

					</table>
					 
					<%--
					<script type="text/javascript">
						/* Optional: Temporarily hide the "tabber" class so it does not "flash"
						 on the page as plain HTML. After tabber runs, the class is changed
						 to "tabberlive" and it will appear. */

						document
								.write('<style type="text/css">.tabber{display:none;}<\/style>');
					</script>
					 --%>
					 <c:if test="${mode=='edit'}">
					<table width="100%" id="box-table-a" border="0" cellspacing="2"
						cellpadding="0" style="border: 1px solid #132C00">
						<tr>
							<th height="25" align="left" bgcolor="#3DB0B5"><span
								style="padding-left: 5px;">&nbsp;</span>
							</th>
						</tr>
						<tr>
							<td width="25%">
								<div class="tabber">


									<div class="tabbertab">
										<h2>Attachments</h2>
										<%--
										<c:set value="${vwntcdownload.ndFileSize/1024}" var="fileSize"></c:set>
                       		 			<jsp:useBean id="fileSize"  type="java.lang.Double" />
                       		 			 --%>
										<%-- float tmp = Math.round(fileSize.doubleValue()*10)/10; 
											out.println(tmp+" KB"); 
										--%>  
										<c:if test="${!empty bpsAttachFiles}">
											<ul> 
												<c:forEach items="${bpsAttachFiles.resultListObj}" var="bpsAttachFile" varStatus="loop">   
												<c:set value="${bpsAttachFile.bpafFileSize/1024}" var="fileSize"></c:set>
                       		 					<jsp:useBean id="fileSize"  type="java.lang.Double" /> 
												<%float tmp = Math.round(fileSize.doubleValue()*10)/10; %>
													<span id="_element_img_${bpsAttachFile.bpafId}"><li><a id="_element_file_${bpsAttachFile.bpafId}" style="cursor: pointer;" onclick='<portlet:namespace />downloadFile("<c:out value="${bpsAttachFile.bpafHotLink}"/>")'>&nbsp;${bpsAttachFile.bpafFileName}</a> (<%=tmp %>&nbsp;KB) <img src="${url}images/delete_file.png" alt="delete file" style="cursor: pointer;" onclick="clearFile('${bpsAttachFile.bpafId}')" /></li></span>												 
												</c:forEach>
											</ul>
										</c:if>
										</div>



									<div class="tabbertab">
										<h2>version</h2>
										<table width="98%" align="center" border="0" cellspacing="2"
											cellpadding="0">
											<c:if test="${!empty bpsTermVersions}">
											<tr>
												<td width="20%" height="20" align="center"><strong>version</strong>
												</td>
												<td width="40%" align="center"><strong>date</strong>
												</td>
												<td width="40%">&nbsp;</td>
											</tr> 
												<c:forEach items="${bpsTermVersions.resultListObj}" var="bpsTermVersion" varStatus="loop">   
													<tr>
														<td height="20"><form:radiobutton path="bpsTerm.bptVersionNumber" value="1" onclick='setChoice("1")'/>version 2</td>
														<td>6/08/2011 1:45:30 PM</td>
														<td>wpsadmin current</td>
													</tr>												 
												</c:forEach>  
											<c:if test="${bpsTermVersions.maxRow!=0}">
											<tr>
												<td height="30"><span style="padding-top: 5px;">
														<input name="input3" type="button" value="Save Version">
												</span>
												</td>
												<td>&nbsp;</td>
												<td>&nbsp;</td>
											</tr>
											</c:if>
											</c:if> 
										</table>

									</div>

								</div>

								<div style="padding-top: 5px;"></div></td>
						</tr>
					</table>
					</c:if>
				</td>
		</tr>
		<%--
		<tr>
			<td width="50%" height="30"><span
				style="color: #030; font-size: 12px;">< Back to Home</span>
			</td>
			<td width="50%">&nbsp;</td>
		</tr>
		 --%>
	</table>
</form:form>
</body>
</html>