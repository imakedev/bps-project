<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="portlet" uri="http://java.sun.com/portlet"%>
<%@ page import="java.util.List" %>
<portlet:defineObjects />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet"
	href="<%=request.getContextPath()%>/ckeditor/_samples/sample.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
<script type="text/javascript"
        src="<%=request.getContextPath()%>/dwr/interface/BpsUserAjax.js"></script> 
<script type="text/javascript"
        src="<%=request.getContextPath()%>/dwr/engine.js"></script> 
<script type="text/javascript"
        src="<%=request.getContextPath()%>/dwr/util.js"></script>	
<script type="text/javascript">

	String.prototype.trim = function() {
		return this.replace(/^\s+|\s+$/g,"");
	}

	function selectDetail(input) {
		if(input == 'revisedDiv') {
			document.getElementById('proposedDiv').style.display = 'none';
			document.getElementById('revisedDiv').style.display = '';
		} else {
			document.getElementById('revisedDiv').style.display = 'none';
			document.getElementById('proposedDiv').style.display = '';
		}
	}
	
	function saveBtsTerm() {
		var subjectMail = document.getElementById('mailSubject').value;
		if(subjectMail.trim().length == 0) {
			alert("Please enter Subject.");
			return false;
		}
		var fromMail = "";
		var toMail = "";
		/*var textArea = CKEDITOR.instances.editor1.getData();
		var re = /(<([^>]+)>)/gi;
		var textSearch = textArea.replace(re, "");*/
		
		var bpt_term = document.getElementById('term').value;
		if(bpt_term.trim().length == 0) {
			alert("Please enter Term.");
			return false;
		} 
		
		var selectGroup = document.getElementById('bpgGroupId');
		var bpgId = selectGroup.options[selectGroup.selectedIndex].value;
		if(bpgId == '0') {
			alert("Please select Category.");
			return false;
		}
		var editor_data = CKEDITOR.instances.editor1;
		var child_count=editor_data.document.getBody().getChildCount();
		var str="";
		for(var i=0;i<child_count;i++){
			str=str+editor_data.document.getBody().getChild( i).getText();
		} 
		var textSearch = str;
		var default_value = "0";
		
		var bpt_source_ref = document.getElementById('sourceRef').value;
		
		var userCreate = document.getElementById('userCreate').value;
		
		var bpsTerm = {
				bptId : default_value,
				bptStatus : default_value,
				bptTerm : bpt_term,
				bptDefinition : editor_data.getData(),
				bptDefinitionSearch : textSearch,
				bptSourceRef : bpt_source_ref,
				bptCreateBy : userCreate,
				bpsGroup : {
					bpgId : bpgId
				}
		};
		BpsUserAjax.saveOrUpdateBpsTerm(bpsTerm, bpgId, handle_Complete);
	}
	
	function handle_Complete(result) {
		if(result != null || result > 0) {
			alert("Data has been send.");
		}
	}
	
</script>
</head>
<body>

<%
/*com.ibm.portal.puma.User user = (com.ibm.portal.puma.User) request.getAttribute("com.ibm.portal.puma.request-user");
String userCreate = "";
String userMail = "";
if(user != null) {
	userCreate = user.get("uid");
	userMail = user.get("mail");
	List list = user.getGroups();
	if(list != null && list.size() > 0) {
		int size = list.size();
		for(int i=0;i<size;i++) {
			com.ibm.wps.puma.Group groupElement = (com.ibm.wps.puma.Group)list.get(i);
			if(groupElement.getName() != null) {
				
			}
		}
	}
}*/
%>
	<c:if test="${mode eq 'add'}">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="center" style="background-color: #FFF;">
			<tr>
				<td>
					<table width="100%" border="0" cellspacing="2" cellpadding="0">
						<tr>
							<td>
								<form action="" method="get">
									<table width="100%" border="0" cellspacing="3" cellpadding="0">
										<tr>
											<td height="30" colspan="2"  align="left"
												style="background-color: #132C00; font-weight: bold; color: #FFF;">&nbsp;New
												BPS Terms and Definitions</td>
										</tr>
										<tr>
											<td width="19%" height="19" class="h_achieve" align="left">To:</td>
											<td width="81%" align="left"><label> <input name="mailTo"
													type="text" id="mailTo" value="COS Staff" size="50"
													class="readonly" readonly="readonly"> </label>
											</td>
										</tr>
										<tr>
											<td class="h_achieve" align="left">From:</td>
											<td><input name="mailFrom" type="text"  align="left"
												class="readonly" id="mailFrom" value="name" size="50"
												readonly="readonly">
											</td>
										</tr>
										<tr>
											<td class="h_achieve" align="left">Subject:</td>
											<td align="left"><input name="mailSubject" type="text" id="textfield3"
												size="50">
											</td>
										</tr>
										<tr>
											<td colspan="2"><hr>
											</td>
										</tr>
										<tr>
											<td class="h_achieve" align="left">Term:</td>
											<td align="left"><input name="term" type="text" id="term"
												size="50">
											</td>
										</tr>
										<tr>
											<td class="h_achieve" align="left">Category:</td>
											<td align="left">
											<select name="bpsGroupId" id="bpgGroupId">
											<option  label="---Select Category--" value="0"/>
											<c:if test="${resultListGroup ne null && not empty resultListGroup.resultListObj}">
												<c:forEach items="${resultListGroup.resultListObj}" var="groupItem">
													<option  label="${groupItem.bpgGroupName}" value="${groupItem.bpgId}"/>
												</c:forEach>
											</c:if>
	    					</select>
											</td>
										</tr>
										<tr>
											<td class="h_achieve" align="left">Source / Referance:</td>
											<td align="left"><input name="sourceRef" type="text" id="sourceRef"
												size="50">
											</td>
										</tr>
										<tr>
											<td class="h_achieve" align="left">Detail:</td>
											<td align="left"><textarea cols="50" id="editor1" name="editor1" rows="10"></textarea><script type="text/javascript">
		CKEDITOR.replace('editor1');
	</script>
											</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td align="left"><label> <input type="button" name="button"
													id="button" value="Send mail" onclick="saveBtsTerm()"> <input type="reset"
													name="button2" id="button2" value="Cancel"> </label>
											</td>
										</tr>
									</table>
									<input name="userCreate" type="hidden" id="userCreate">
								</form>
							</td>

						</tr>
					</table></td>
			</tr>
			<tr>
			<td height="30" align="left"><span
				style="color: #030; font-size: 12px;"><a href='<portlet:renderURL><portlet:param name="action" value="list"/></portlet:renderURL>'>< Back to Home</a></span>
			</td>
		</tr>
		</table>
	</c:if>
	<c:if test="${mode eq 'edit'}">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="center" style="background-color: #FFF;">
			<tr>
				<td>
					<table width="100%" border="0" cellspacing="2" cellpadding="0">
						<tr>
							<td>
								<form action="" method="get">
									<table width="100%" border="0" cellspacing="3" cellpadding="0">
										<tr>
											<td height="30" colspan="2" align="left"
												style="background-color: #132C00; font-weight: bold; color: #FFF;">&nbsp;Request
												to modify BPS Term and Definition</td>
										</tr>
										<tr>
											<td width="19%" height="19" class="h_achieve" align="left">To:</td>
											<td width="81%"><label> <input name="mailTo"
													type="text" id="mailTo" value="COS Staff" size="50"
													class="readonly" readonly="readonly"> </label>
											</td>
										</tr>
										<tr>
											<td class="h_achieve" align="left">From:</td>
											<td><input name="mailFrom" type="text"
												class="readonly" id="mailFrom" value="name" size="50"
												readonly="readonly">
											</td>
										</tr>
										<tr>
											<td class="h_achieve" align="left">Subject:</td>
											<td><input name="mailSubject" type="text" id="mailSubject"
												size="50">
											</td>
										</tr>
										<tr>
											<td colspan="2"><hr>
											</td>
										</tr>
										<tr>
											<td class="h_achieve" align="left">Term:</td>
											<td align="left"><input name="term" type="text" id="term"
												value="${bpsUserForm.bpsTerm.bptTerm}" size="50" class="readonly"
												readonly="readonly">
											</td>
										</tr>
										<tr>
											<td class="h_achieve" align="left">Category:</td>
											<td align="left">
											<select name="bpsGroupId" id="bpgGroupId">
											<option  label="---Select Category--" value="0"/>
											<c:if test="${resultListGroup ne null && not empty resultListGroup.resultListObj}">
												<c:forEach items="${resultListGroup.resultListObj}" var="groupItem">
													<c:if test="${bpsUserForm.bpsTerm.bpsGroup ne null && bpsUserForm.bpsTerm.bpsGroup.bpgId eq groupItem.bpgId}">
					<option value="${groupItem.bpgId}" selected="selected">${groupItem.bpgGroupName}</option>
				</c:if>
				<c:if test="${bpsUserForm.bpsTerm.bpsGroup ne null && bpsUserForm.bpsTerm.bpsGroup.bpgId ne groupItem.bpgId}">
					<option value="${groupItem.bpgId}">${groupItem.bpgGroupName}</option>
				</c:if>
												</c:forEach>
											</c:if>
	    					</select>
											</td>
										</tr>
										<tr>
											<td class="h_achieve" align="left">Source / Referance:</td>
											<td align="left"><input name="sourceRef" type="text" id=""sourceRef""
												size="50">
											</td>
										</tr>
										<tr>
											<td height="25">&nbsp;</td>
											<td class="h_achieve" align="left"><a href="javascript: selectDetail('proposedDiv')">Proposed change</a> |
												<a href="javascript: selectDetail('revisedDiv')">Revised version</a>
											</td>
										</tr>
										<tr>
											<td class="h_achieve" align="left">Detail:</td>
											<td align="left"><div id="proposedDiv"><textarea cols="50" id="editor1" name="editor1" rows="10"></textarea><script type="text/javascript">
		CKEDITOR.replace('editor1');
	</script></div><div id="revisedDiv" style="display: none"><textarea cols="50" id="editor2" name="editor2" rows="10"><c:out value="${bpsUserForm.bpsTerm.bptDefinition}" escapeXml="true" /></textarea><script type="text/javascript">
		CKEDITOR.replace('editor2');
	</script></div>
											</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td align="left"><label> <input type="button" name="button"
													id="button" value="Send mail" onclick="saveBtsTerm()"> <input type="reset"
													name="button2" id="button2" value="Cancel"> </label>
											</td>
										</tr>
									</table>
									<input name="userCreate" type="hidden" id="userCreate">
								</form>
							</td>
						</tr>
					</table></td>
			</tr>
			<tr>
			<td height="30"><span
				style="color: #030; font-size: 12px;"><a href='<portlet:renderURL><portlet:param name="action" value="list"/></portlet:renderURL>'>< Back to Home</a></span>
			</td>
		</tr>
		</table>
	</c:if>
</body>
</html>