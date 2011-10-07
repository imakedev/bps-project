<%@include file="../include.jsp"%>
<%@page import="th.co.vlink.xstream.common.VResultMessage"%>
<%@page import="th.co.vlink.utils.Pagging"%>
<%@page import="th.co.vlink.bps.util.Paging"%>
<%@page import="th.co.vlink.bps.form.BpsAdminForm"%>
<%@page contentType="text/html; charset=utf-8"%>
<html>
<head>
<c:url var="url" value="/" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src='${url}js/jquery-1.6.4.min.js'></script>
<script src='${url}js/jquery.highlight-3.js'></script>
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="${url}css/style.css" />
<style type="text/css">
.highlight { background-color: yellow }
</style>
<script>
	var _range_text=500;
	$(document).ready(function() {
	  // Handler for .ready() called.
	  var bptTerm = $("#bptTerm").val();
	  if(bptTerm!=''){
			$('span[class^=_highlight_term]').each(function(){
				$(this).highlight(bptTerm);
			});
	  }
	//  _sort_bptSource_asc
	  $('img[class^=_sort_]').each(function(){ 
		  $(this).attr("style","cursor: pointer;display: none;");
	  });
	  var orderColumn = $("#orderColumn").val();
	  var orderBy = $("#orderBy").val()=="asc"?"desc":"asc"; 
	  if("bpsGroup.bpgGroupName"==orderColumn){
		  $("#_sort_bpsGroup_"+orderBy).attr("style","cursor: pointer;");
	  }else
	  	$("#_sort_"+orderColumn+"_"+orderBy).attr("style","cursor: pointer;");
	 if(bptTerm!='')
	  $('._highlight_def').each(function(){  
		  var _indexOf_text = $(this).text().toLowerCase().indexOf(bptTerm.toLowerCase()); 
		  var _offset=parseInt((_indexOf_text/_range_text),10);
		  var _max_offset=parseInt(($(this).text().length/_range_text),10);
		  var _length_text=bptTerm.length;
		  var _startIndex=parseInt((_range_text*_offset),10);
		  var _endIndex=parseInt((_range_text*(_offset+1)),10);
		  if((_indexOf_text+_length_text)>=_endIndex){
			  _endIndex=_indexOf_text+_length_text;
		  }
		  var newText=$(this).text().substring(_startIndex,_endIndex)+((_max_offset==_offset)?"":"...");
		  if(_offset>0)
			  newText="..."+newText;
		  $(this).text(newText);
		  $(this).highlight(bptTerm); 
	  });
      var _indexChar = $("#indexChar").val();
      $('a[class^=team_index_]').each(function(){ 
			var className=$(this).attr("class");  
			if(className.split("_")[2]==_indexChar.toUpperCase()){
				$(this).attr("style","font-style:italic;color: black;text-decoration: none;");
			}
		});
	});
	function checkSorting(_id){ 
		var haveSorting=false;
		var _order="desc";
		var _count=0;
		$('img[id^=_sort_'+_id+'_]').each(function(){ 
			  var _style= $(this).attr("style");
			//  alert(_style);
			  if(_style.indexOf("display: none")!=-1){
				 // alert("id is ==> "+$(this).attr("id"));
				  var ids=$(this).attr("id").split("_");// _sort_bptTerm_asc
				  haveSorting=true;
				 // alert("length="+ids.length)
				  _order=ids[3]=="asc"?"desc":"asc";
				  _count++;
			  } 
		  });
		if(_count==2)
			_order="asc";
		//alert(_count)
		//_sort_bptTerm_desc
		//hidden_sort_bptDefinition_asc
		//alert($("#hidden_sort_"+_id+"_"+_order).val())
		//alert("#hidden_sort_"+_id+"_"+_order)
		goToIndex($("#hidden_sort_"+_id+"_"+_order).val());
	}
	function goToIndex(_index){
		//alert(_index)
		window.location.href = _index;
	}
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

<form:form  modelAttribute="bpsAdminForm" name="bpsAdminForm" method="post"  action="${formAction}">
<form:hidden path="command" id="command"/> 
<form:hidden path="indexChar" id="indexChar"/>
<form:hidden path="orderColumn" id="orderColumn"/>
<form:hidden path="orderBy" id="orderBy"/>
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
			%> 
			<%--
			<a
				href='<portlet:renderURL><portlet:param name="action" value="manageBpsTerm"/><portlet:param name="bptIndexChar" value="<%= indexChar[i]%>"/></portlet:renderURL>'
				class="team">
			 --%>
			 <a
				href='#'
				class="team_index_<%=indexChar[i]%>" onclick="goToIndex('<portlet:renderURL><portlet:param name="action" value="manageBpsTerm"/><portlet:param name="indexChar" value="<%= indexChar[i]%>"/></portlet:renderURL>')">
				<%--if("B".equals(indexChar[i])){
				
				<span class="team_index" style="font-style:italic;color: black;text-decoration: none;"><%= indexChar[i] %></span>
				--%>
				<%--
				}else{
				--%>
					<%=indexChar[i]%>
				<%--
				}--%> 
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
<portlet:renderURL var="_sort_bptTerm_desc">
	<portlet:param name="action" value="manageBpsTerm"/>
	<portlet:param name="indexChar" value="${bpsAdminForm.indexChar}"/>
	<portlet:param name="bptTerm" value="${bpsAdminForm.bptTerm}"/> 
	<portlet:param name="bpgId" value="${bpsAdminForm.bpgId}"/>
	<portlet:param name="searchBy" value="${bpsAdminForm.searchBy}"/>
	<portlet:param name="orderBy" value="desc"/>
	<portlet:param name="orderColumn" value="bptTerm"/>
</portlet:renderURL>
<portlet:renderURL var="_sort_bptTerm_asc"> 
	<portlet:param name="action" value="manageBpsTerm"/>
	<portlet:param name="indexChar" value="${bpsAdminForm.indexChar}"/>
	<portlet:param name="bptTerm" value="${bpsAdminForm.bptTerm}"/> 
	<portlet:param name="bpgId" value="${bpsAdminForm.bpgId}"/>
	<portlet:param name="searchBy" value="${bpsAdminForm.searchBy}"/>
	<portlet:param name="orderBy" value="asc"/>
	<portlet:param name="orderColumn" value="bptTerm"/>
</portlet:renderURL>
<portlet:renderURL var="_sort_bptDefinitionSearch_desc"> 
	<portlet:param name="action" value="manageBpsTerm"/>
	<portlet:param name="indexChar" value="${bpsAdminForm.indexChar}"/>
	<portlet:param name="bptTerm" value="${bpsAdminForm.bptTerm}"/> 
	<portlet:param name="bpgId" value="${bpsAdminForm.bpgId}"/>
	<portlet:param name="searchBy" value="${bpsAdminForm.searchBy}"/>
	<portlet:param name="orderBy" value="desc"/>
	<portlet:param name="orderColumn" value="bptDefinitionSearch"/>
</portlet:renderURL>
<portlet:renderURL var="_sort_bptDefinitionSearch_asc">
	<portlet:param name="action" value="manageBpsTerm"/>
	<portlet:param name="indexChar" value="${bpsAdminForm.indexChar}"/>
	<portlet:param name="bptTerm" value="${bpsAdminForm.bptTerm}"/> 
	<portlet:param name="bpgId" value="${bpsAdminForm.bpgId}"/>
	<portlet:param name="searchBy" value="${bpsAdminForm.searchBy}"/>
	<portlet:param name="orderBy" value="asc"/>
	<portlet:param name="orderColumn" value="bptDefinitionSearch"/>
</portlet:renderURL>
<portlet:renderURL var="_sort_bpsGroup_desc">  
	<portlet:param name="action" value="manageBpsTerm"/>
	<portlet:param name="indexChar" value="${bpsAdminForm.indexChar}"/>
	<portlet:param name="bptTerm" value="${bpsAdminForm.bptTerm}"/> 
	<portlet:param name="bpgId" value="${bpsAdminForm.bpgId}"/>
	<portlet:param name="searchBy" value="${bpsAdminForm.searchBy}"/>
	<portlet:param name="orderBy" value="desc"/>
	<portlet:param name="orderColumn" value="bpsGroup.bpgGroupName"/>
</portlet:renderURL>
<portlet:renderURL var="_sort_bpsGroup_asc">
	<portlet:param name="action" value="manageBpsTerm"/>
	<portlet:param name="indexChar" value="${bpsAdminForm.indexChar}"/>
	<portlet:param name="bptTerm" value="${bpsAdminForm.bptTerm}"/> 
	<portlet:param name="bpgId" value="${bpsAdminForm.bpgId}"/>
	<portlet:param name="searchBy" value="${bpsAdminForm.searchBy}"/>
	<portlet:param name="orderBy" value="asc"/>
	<portlet:param name="orderColumn" value="bpsGroup.bpgGroupName"/>
</portlet:renderURL>
<portlet:renderURL var="_sort_bptSource_desc">
	<portlet:param name="action" value="manageBpsTerm"/>
	<portlet:param name="indexChar" value="${bpsAdminForm.indexChar}"/>
	<portlet:param name="bptTerm" value="${bpsAdminForm.bptTerm}"/> 
	<portlet:param name="bpgId" value="${bpsAdminForm.bpgId}"/>
	<portlet:param name="searchBy" value="${bpsAdminForm.searchBy}"/>
	<portlet:param name="orderBy" value="desc"/>
	<portlet:param name="orderColumn" value="bptSource"/>
</portlet:renderURL>
<portlet:renderURL var="_sort_bptSource_asc">
	<portlet:param name="action" value="manageBpsTerm"/>
	<portlet:param name="indexChar" value="${bpsAdminForm.indexChar}"/>
	<portlet:param name="bptTerm" value="${bpsAdminForm.bptTerm}"/> 
	<portlet:param name="bpgId" value="${bpsAdminForm.bpgId}"/>
	<portlet:param name="searchBy" value="${bpsAdminForm.searchBy}"/>
	<portlet:param name="orderBy" value="asc"/>
	<portlet:param name="orderColumn" value="bptSource"/>
</portlet:renderURL>
<input type="hidden" id="hidden_sort_bptTerm_desc" value="${_sort_bptTerm_desc}" >
<input type="hidden" id="hidden_sort_bptTerm_asc" value="${_sort_bptTerm_asc}" >
<input type="hidden" id="hidden_sort_bptDefinitionSearch_desc" value="${_sort_bptDefinitionSearch_desc}" >
<input type="hidden" id="hidden_sort_bptDefinitionSearch_asc" value="${_sort_bptDefinitionSearch_asc}" >
<input type="hidden" id="hidden_sort_bpsGroup_desc" value="${_sort_bpsGroup_desc}" >
<input type="hidden" id="hidden_sort_bpsGroup_asc" value="${_sort_bpsGroup_asc}" >
<input type="hidden" id="hidden_sort_bptSource_desc" value="${_sort_bptSource_desc}" >
<input type="hidden" id="hidden_sort_bptSource_asc" value="${_sort_bptSource_asc}" >
    
				<table width="100%" id="box-table-a" border="0" cellspacing="2"
					cellpadding="0" style="border: 1px solid #132C00">
					<tr>
						<th width="25%" height="25" align="center" bgcolor="#3DB0B5"><span  style="cursor: pointer;" onclick="checkSorting('bptTerm')">Term&nbsp;</span><img id="_sort_bptTerm_desc" 
							src="${url}images/up.png" style="cursor: pointer;display: none" onclick="goToIndex('${_sort_bptTerm_desc}')"/><img id="_sort_bptTerm_asc" src="${url}images/down.png" style="cursor: pointer;display: none;" onclick="goToIndex('${_sort_bptTerm_asc}')"/>
						</th>
						<th width="26%" align="center" bgcolor="#3DB0B5"><span  style="cursor: pointer;" onclick="checkSorting('bptDefinitionSearch')">Difinition&nbsp;</span><img id="_sort_bptDefinitionSearch_desc" 
							src="${url}images/up.png" style="cursor: pointer;display: none" onclick="goToIndex('${_sort_bptDefinitionSearch_desc}')"/><img id="_sort_bptDefinitionSearch_asc" src="${url}images/down.png" style="cursor: pointer;display: none" onclick="goToIndex('${_sort_bptDefinitionSearch_asc}')"/>
						</th>
						<th width="26%" align="center" bgcolor="#3DB0B5"><span  style="cursor: pointer;" onclick="checkSorting('bpsGroup')">Categoty&nbsp;</span><img id="_sort_bpsGroup_desc"
							src="${url}images/up.png" style="cursor: pointer;display: none" onclick="goToIndex('${_sort_bpsGroup_desc}')"/><img  id="_sort_bpsGroup_asc" src="${url}images/down.png" style="cursor: pointer;display: none" onclick="goToIndex('${_sort_bpsGroup_asc}')"/>
						</th>
						<th width="17%" align="center" bgcolor="#3DB0B5"><span  style="cursor: pointer;" onclick="checkSorting('bptSource')">Source&nbsp;</span><img id="_sort_bptSource_desc"
							src="${url}images/up.png" style="cursor: pointer;display: none" onclick="goToIndex('${_sort_bptSource_desc}')"/><img id="_sort_bptSource_asc" src="${url}images/down.png" style="cursor: pointer;display: none" onclick="goToIndex('${_sort_bptSource_asc}')"/>
						</th>
						<th width="6%" align="center" bgcolor="#3DB0B5">&nbsp;</th>
					</tr>
					<c:if test="${bpsTerms.maxRow != 0}">
						<c:forEach items="${bpsTerms.resultListObj}" var="bpsTerm" varStatus="loop">  
								  	<tr valign="top">
								  		<td>
								  			<portlet:renderURL var="urlView">
                         						<portlet:param name="action" value="viewBpsTerm"/> 
                         						<portlet:param name="bptId" value="${bpsTerm.bptId}"/>                            
                      						</portlet:renderURL>
								  		<a href="${urlView}" class="team"><span class="_highlight_term"><c:out value="${bpsTerm.bptTerm}"/></span></a>
										</td>
										<td><span class="_highlight_def"><c:out value="${bpsTerm.bptDefinition}" escapeXml="false"/></span></td>										
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
				<%
			VResultMessage resultMessage = (VResultMessage)request.getAttribute("bpsTerms"); 
				BpsAdminForm bpsAdminForm = (BpsAdminForm) request
					.getAttribute("bpsAdminForm");
			int pageNo = 1;
			int pageSize = 20;
			int total_page = 1;
			if (resultMessage != null && resultMessage.getMaxRow() != null) {
				Pagging paging = bpsAdminForm.getBpsTerm().getPagging();
				if (paging != null) {
					pageNo = paging.getPageNo();
					pageSize = paging.getPageSize();
					int totalResult = Integer.parseInt(resultMessage.getMaxRow());
					if (totalResult % pageSize != 0) {
						Double d = Math.floor(totalResult / pageSize);
						total_page = d.intValue() + 1;
					} else {
						Double d = Math.floor(totalResult / pageSize);
						total_page = d.intValue()!=0?d.intValue():1;
					}
				}
			}
		%> <%-- =Paging.getPaging(pageNo, pageSize, total_page,
					request.getContextPath()) --%>
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