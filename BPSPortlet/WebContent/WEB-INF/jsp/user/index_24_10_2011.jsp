<%@page import="th.co.vlink.xstream.common.VResultMessage"%>
<%@page import="th.co.vlink.utils.Pagging"%>
<%@page import="th.co.vlink.bps.util.Paging"%>
<%@page import="th.co.vlink.bps.form.BpsUserForm"%>
<%@page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="portlet" uri="http://java.sun.com/portlet"%>
<portlet:defineObjects />
<c:url var="url" value="/" />
<link rel="stylesheet" type="text/css" 	href="<%=request.getContextPath()%>/css/style.css" />
<link rel="stylesheet" href="${url}css/redmond/jquery-ui-1.8.16.custom.css" type="text/css">
<link rel="stylesheet" href="${url}css/ui.selectmenu.css" type="text/css">
<script src='${url}js/jquery-1.6.4.min.js' type="text/javascript"></script>
<script src="${url}js/redmond/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
<script src='${url}js/ui.selectmenu.js' type="text/javascript"></script>
<script src='<%=request.getContextPath()%>/js/jquery.highlight-3.js'></script>

<style type="text/css">
.highlight { background-color: yellow }
</style>
<style type="text/css">
/*demo styles 
body {font-size: 62.5%; font-family:"Verdana",sans-serif; margin: 70px 10px;}
fieldset { border:0;  margin-bottom: 40px;}	
*/
label,select,.ui-select-menu { float: left; margin-right: 10px; }
select { width: 200px; } 
</style>
<script type="text/javascript">

String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g,"");
}

	function clickPage(pageNo) {
		document.getElementById("pageNo").value = pageNo;
		document.forms['bpsUserForm'].submit();
	}
	
	function sortFunction(sortBy, sortOrder) {
		//alert("sortBy : "+sortBy);
		//alert("sortOrder : "+sortOrder);
		document.getElementById('sortBy').value=sortBy;
		document.getElementById('sortOrder').value=sortOrder;
		document.forms['bpsUserForm'].submit();
	}
</script>

<table width="100%" align="center" border="0" cellspacing="0"	cellpadding="0">
	<tr>
		<td height="30" colspan="2" align="left"><span
			style="color: #030; font-size: 12px;"><strong>You are
		in:</strong> <a href="/wps/myportal/COS">Home</a> > Banpu Term and Definition</span></td>
	</tr>
<!-- 	  <tr> -->
<%-- 	    <td align="left"><img src="<%=request.getContextPath()%>/images/term.gif"></td> --%>
<%-- 	    <td align="right"><a href="#"><img src="<%=request.getContextPath()%>/images/btn_admin.gif" width="65" height="25"></a></td> --%>
<!-- 	  </tr> -->
	<tr>
		<td colspan="2" height="30" align="left">
		<div class="team" style="padding-left: 10px;">
		<%
			BpsUserForm bpsUserForm = (BpsUserForm) request.getAttribute("bpsUserForm");
			String selectedIndex = "";
			if(bpsUserForm != null && bpsUserForm.getBpsTerm() != null && bpsUserForm.getBpsTerm().getBptIndexChar() != null) {
				selectedIndex = bpsUserForm.getBpsTerm().getBptIndexChar();
			}
			String[] indexChar = { "A", "B", "C", "D", "E", "F", "G", "H", "I",
					"J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U",
					"V", "W", "X", "Y", "Z" };
			for (int i = 0; i < indexChar.length; i++) {
				if(selectedIndex.equalsIgnoreCase(indexChar[i])) {
		%>
		
			<strong><%=indexChar[i]%></strong>
		<%
				} else {
		%>
		<a
			href='<portlet:renderURL><portlet:param name="action" value="list"/><portlet:param name="bptIndexChar" value="<%= indexChar[i]%>"/></portlet:renderURL>' class="team"><%=indexChar[i]%></a>
		<%			
				}
			}
		%> 
		</div>
		</td>
	</tr>
	<tr>
		<td width="80%" height="30" align="left">
		<div style="padding-top: 5px;">
		<table cellspacing="5" cellpadding="5">
			<tr>
				<td>
					<form	action='<portlet:actionURL><portlet:param name="action" value="searchBpsTerm"/></portlet:actionURL>'
						method="post" name="bpsUserForm"><strong style="padding-left: 5px;">Search:</strong>
						<input name="textfield" type="text" id="textfield" size="30"
							value="${bpsUserForm.bpsTerm.bptTerm}">
				</td>
				<td>
			 		<select name="select" id="select">
						<c:if test="${bpsUserForm.bpsTerm.vcriteria.key eq '1'}">
							<option value="1" selected="selected">By Term</option>
						</c:if>
						<c:if test="${bpsUserForm.bpsTerm.vcriteria.key ne '1'}">
							<option value="1">By Term</option></c:if>
						<c:if test="${bpsUserForm.bpsTerm.vcriteria.key eq '2'}"><option value="2" selected="selected">By Definition</option></c:if>
						<c:if test="${bpsUserForm.bpsTerm.vcriteria.key ne '2'}"><option value="2">By Definition</option></c:if>
						<c:if test="${bpsUserForm.bpsTerm.vcriteria.key eq '3'}"><option value="3" selected="selected">By All</option></c:if>
						<c:if test="${bpsUserForm.bpsTerm.vcriteria.key ne '3'}"><option value="3">By All</option></c:if>
					</select> 
				</td>
				<td>	
					<select name="select2" id="select2">
						<c:if test="${bpsUserForm.bpsTerm.bpsGroup eq null}">
							<option value="0" selected="selected">--Select Category--</option>
						</c:if>
						<c:if test="${bpsUserForm.bpsTerm.bpsGroup ne null}">
							<option value="0" selected>--Select Category--</option>
						</c:if>
						<c:forEach items="${resultListGroup.resultListObj}" var="groupItem">
							<c:if test="${bpsUserForm.bpsTerm.bpsGroup ne null && bpsUserForm.bpsTerm.bpsGroup.bpgId eq groupItem.bpgId}">
								<option value="${groupItem.bpgId}" selected="selected">${groupItem.bpgGroupName}</option>
							</c:if>
							<c:if test="${bpsUserForm.bpsTerm.bpsGroup ne null && bpsUserForm.bpsTerm.bpsGroup.bpgId ne groupItem.bpgId}">
								<option value="${groupItem.bpgId}">${groupItem.bpgGroupName}</option>
							</c:if>
						</c:forEach>
					</select> 
				</td>
				<td>
					<input type="submit" value="Search"><input type="hidden" name="pageNo" id="pageNo" value="1"><input type="hidden" value="asc" name="sortOrder" id="sortOrder">
					<input type="hidden" value="bptTerm" name="sortBy" id="sortBy"><input type="hidden" value="<%= selectedIndex%>" name="indexChar" id="indexChar"></form>
				</td>
			</tr>
		</table>   
		</div>
		</td>
		<td width="20%" height="30" align="right"><a href='<portlet:renderURL><portlet:param name="action" value="viewBpsTerm"/><portlet:param name="bptId" value="0"/><portlet:param name="mode" value="add"/></portlet:renderURL>'><img src="<%=request.getContextPath()%>/images/New.gif"></a></td>
	</tr>
	<tr>
		<td colspan="2" height="15"></td>
	</tr>
	<tr>
		<td colspan="2" valign="top">
		<table width="100%" id="box-table-a" border="0" cellspacing="2"
			cellpadding="0" style="border: 1px solid #132C00;">
			<tr>
				<th width="25%" height="25" align="center" bgcolor="#3DB0B5">Term&nbsp;<a href="javascript: sortFunction('bptTerm','asc')"><img
					src="<%=request.getContextPath()%>/images/up.png"></a><a href="javascript: sortFunction('bptTerm','desc')"><img
					src="<%=request.getContextPath()%>/images/down.png"></a></th>
				<th width="26%" align="center" bgcolor="#3DB0B5" >Definition&nbsp;<a href="javascript: sortFunction('bptDefinition','asc')"><img
					src="<%=request.getContextPath()%>/images/up.png"></a><a href="javascript: sortFunction('bptDefinition','desc')"><img
					src="<%=request.getContextPath()%>/images/down.png"></a></th>
				<th width="26%" align="center" bgcolor="#3DB0B5" >Category&nbsp;<a href="javascript: sortFunction('bpsGroup','asc')"><img
					src="<%=request.getContextPath()%>/images/up.png"></a><a href="javascript: sortFunction('bpsGroup','desc')"><img
					src="<%=request.getContextPath()%>/images/down.png"></a></th>
				<th width="17%" align="center" bgcolor="#3DB0B5" >Source&nbsp;<a href="javascript: sortFunction('bptSource','asc')"><img
					src="<%=request.getContextPath()%>/images/up.png"></a><a href="javascript: sortFunction('bptSource','desc')"><img
					src="<%=request.getContextPath()%>/images/down.png"></a></th>
<!-- 				<th width="6%" align="center" bgcolor="#3DB0B5">&nbsp;</th> -->
			</tr>
			<c:if test="${resultList.maxRow != 0}">
			<c:forEach items="${resultList.resultListObj}" var="item">
				<tr >
					<td width="25%" align="left" valign="top"><a href='<portlet:renderURL><portlet:param name="action" value="viewBpsTerm"/><portlet:param name="bptId" value="${item.bptId}"/><portlet:param name="mode" value="view"/></portlet:renderURL>' class="team"><span class="_highlight">${item.bptTerm}</span></a>
					</td>
					<td width="26%" align="left" valign="top"><span class="_highlight">${item.bptShortDesc}</span></td>
					<td width="26%" align="left" valign="top">${item.bpsGroup.bpgGroupName}</td>
					<td width="17%" align="left" valign="top">${item.bptSource}</td>
				</tr>
			</c:forEach>
			<tr>
		<td colspan="4" width="100%" align="right">
		<div class="pagination">
		<%
			VResultMessage resultMessage = (VResultMessage)request.getAttribute("resultList"); 
			int pageNo = 1;
			int pageSize = 20;
			int total_page = 1;
			if (resultMessage != null && resultMessage.getMaxRow() != null) {
				Pagging paging = bpsUserForm.getBpsTerm().getPagging();
				if (paging != null) {
					pageNo = paging.getPageNo();
					pageSize = paging.getPageSize();
					int totalResult = Integer.parseInt(resultMessage.getMaxRow());
					if (totalResult % pageSize != 0) {
						Double d = new Double(Math.floor(totalResult / pageSize));
						total_page = d.intValue() + 1;
					} else {
						Double d =  new Double(Math.floor(totalResult / pageSize));
						total_page = d.intValue()!=0?d.intValue():1;
					}
				}
			}
		%> 
		 <%-- Page:=Paging.getPaging(pageNo, pageSize, total_page,
					request.getContextPath()) --%>
		</div>
		</td>
	</tr>
			</c:if>
			<c:if test="${resultList.maxRow == 0}">
				<tr>
					<td colspan="5" align="center" height="25" class="content">Data not found.</td>
				</tr>
				<tr><td colspan="5" height="30" align="left"><span style="color: #030; font-size: 12px;">< Back to Home</span></td>
				</tr>
			</c:if>
		</table>
		</td>
	</tr>
</table>
<script type="text/javascript">
$(document).ready(function() {
var higilight_keyword = $("#textfield").val();
if(higilight_keyword.trim().length > 0) {
	$('._highlight').highlight(higilight_keyword);
}
$("input:button").button();
$("input:submit").button();
$('select#select').selectmenu({style:'dropdown'});
$('select#select2').selectmenu({style:'dropdown'});
});
</script>
