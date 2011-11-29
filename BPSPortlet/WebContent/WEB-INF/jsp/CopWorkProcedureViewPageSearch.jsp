<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" session="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="portlet" uri="http://java.sun.com/portlet"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="javax.portlet.RenderRequest"%>
<%@ page import="javax.portlet.RenderResponse"%>
<portlet:defineObjects />
<html>
<head>

<script
	src='<%=request.getContextPath()%>/dwr/interface/CopWorkProcedureAjax.js'></script>
<script src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script src='<%=request.getContextPath()%>/dwr/util.js'></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="GENERATOR" content="CopWorkProcedure Application Developer">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style_copWork.css"
	type="text/css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/jquery-ui/jquery-ui-1.8.custom.css" />
<script type="text/JavaScript"
	src="<%=request.getContextPath()%>/js/jquery-1.4.2.js"></script>
<script type="text/JavaScript"
	src="<%=request.getContextPath()%>/css/jquery-ui/jquery-ui-1.8.custom.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#button2').click(function(){
			$('#showSearch').attr("style","display:none");
			$('#search_by').removeAttr("checked");
			resetFormForm();

		});
		auto();
    	function auto(){
    		var Name=[];
	    	CopWorkProcedureAjax.getCopWorkByName(handleResultAuto);
	    	function handleResultAuto(resultData){
		    	var resultObj = resultData[0];
				for (var i = 0; i < resultObj.length; i++) {
					Name.push(resultObj[i].title);
				}
				$("#search").autocomplete({
           			 source: Name
        		});
			}
    	}
	    $('#search').keyup(function() {
		    	auto();
	    	
	    });
	});
</script>
<script type="text/javascript">
	function resetFormForm(){
		var st='<table width="100%" align="center" border="0" cellspacing="0" cellpadding="0">';
		st=st+'<tr><td height="20" valign="top" width="12%"><strong>Select:</strong></td><td align="left" width="868">';
		st=st+'<select	name="country" id="country"><option value="0">--Country--</option><option value="Thailand">Thailand</option><option value="China">China</option><option value="Indonesia">Indonesia</option></select>';
		st=st+'<select name="type" id="type"><option value="0">--Type--</option><c:forEach items="${listTypes}" var="listType"	varStatus="status">';
		st=st+'<option value="${listType.copTypeID}">${listType.copTypeName}</option></c:forEach></select>';
		st=st+'<select name="bu" id="bu"><option value="0">--BU--</option><c:forEach items="${listBus}" var="listBu" varStatus="status">';
		st=st+'<option value="${listBu.copBuID}">${listBu.copBuName}</option></c:forEach></select>';
		st=st+'<select name="departmant" id="departmant"><option value="0">--Departmant--</option><c:forEach items="${listDepartments}" var="listDepartment" varStatus="status">';
		st=st+'<option value="${listDepartment.copDepartmentID}">${listDepartment.copDepartmentName}</option></c:forEach></select>';
		st=st+'<select name="division"	id="division"><option value="0">--Division--</option><c:forEach items="${listDivisions}" var="listDivision" varStatus="status">';
		st=st+'<option value="${listDivision.copDivisionID}">${listDivision.copDivisionName}</option></c:forEach></select>';
		st=st+'<select name="chain" id="chain"><option value="0">--Value Chain--</option><c:forEach items="${listValueChains}" var="listValueChain" varStatus="status">';
		st=st+'<option value="${listValueChain.copValueChainID}">${listValueChain.copValueChainName}</option></c:forEach></select>';
		st=st+'<select name="coreProcess" id="coreProcess"><option value="0">--Core Process--</option><c:forEach items="${listCoreProcesss}" var="listCoreProcess"	varStatus="status">';
		st=st+'<option value="${listCoreProcess.copCoreProcessID}">${listCoreProcess.copCoreProcessName}</option></c:forEach></select>';
		st=st+'<select name="subProcess" id="subProcess"><option value="0">--Sub Process--</option><c:forEach items="${listSubProcesss}" var="listSubProcess" varStatus="status">';
		st=st+'<option value="${listSubProcess.copSubProcessID}">${listSubProcess.copSubProcessName}</option></c:forEach></select></td></tr></table>';
		
		document.getElementById('showSearch').innerHTML=st;
	
	}
	function fncchange(){

		var search_by = document.getElementById('search_by');
		var showSearch = document.getElementById('showSearch');
		var search=document.getElementById('search').value;
		if(search_by.checked == true){
			showSearch.style.display='block';
		}  
		if(search_by.checked == false){
			showSearch.style.display='none';
			resetFormForm();
			document.getElementById('search').value=search;
			return false;
		}  
	}
	function chk(ev) {
		var key;
		ev = ev || event;
		key = ev.keyCode;
		if (key == 13) {
			searchCopWork(1 , 10 , '');
			return false;
		}
		return true;
	}
	function searchCopWork(nowPage , recordPerPage , totalRecord){

		var keyword = document.getElementById('search').value;
		var countryName = document.getElementById('country').value;
		var typeName = document.getElementById('type').value;
		var buName = document.getElementById('bu').value;
		var departmentName = document.getElementById('departmant').value;
		var divisionName = document.getElementById('division').value;
		var valueChainName = document.getElementById('chain').value;
		var coreProcessName = document.getElementById('coreProcess').value;
		var subProcessName = document.getElementById('subProcess').value;		
		CopWorkProcedureAjax.searchCopWorkByID(nowPage , recordPerPage , totalRecord , keyword ,countryName,typeName,buName,departmentName,divisionName,valueChainName,coreProcessName,subProcessName, handleResult);
	}
	function sortingCopWorkList(name , type , nowPage , recordPerPage , totalRecord){
		var keyword = document.getElementById('search').value;
		var countryName = document.getElementById('country').value;
		var typeName = document.getElementById('type').value;
		var buName = document.getElementById('bu').value;
		var departmentName = document.getElementById('departmant').value;
		var divisionName = document.getElementById('division').value;
		var valueChainName = document.getElementById('chain').value;
		var coreProcessName = document.getElementById('coreProcess').value;
		var subProcessName = document.getElementById('subProcess').value;
		CopWorkProcedureAjax.sortingCopWorkList(name , type , keyword ,countryName,typeName,buName,departmentName,divisionName,valueChainName,coreProcessName,subProcessName, nowPage , recordPerPage , totalRecord , handleResult);
	
	}
	
	function handleResult(resultAll){
		var resultObj = resultAll[0];
		var index=0;
		var up ="<%=request.getContextPath()%>/images/up.png";
		var down ="<%=request.getContextPath()%>/images/down.png";
		var upName="onclick=\"sortingCopWorkList('Name' , 'asc' ,1 , 10 , '')\" ";
		var downName="onclick=\"sortingCopWorkList('Name' , 'desc' ,1 , 10 , '')\" ";
		var upTypeName="onclick=\"sortingCopWorkList('TypeName' , 'asc' ,1 , 10 , '')\" ";
		var downTypeName="onclick=\"sortingCopWorkList('TypeName' , 'desc' ,1 , 10 , '')\" ";
		var upLastUpdate="onclick=\"sortingCopWorkList('DivisionName' , 'asc' ,1 , 10 , '')\" ";
		var downLastUpdate="onclick=\"sortingCopWorkList('DivisionName' , 'desc' ,1 , 10 , '')\" ";
		var upTitleName="onclick=\"sortingCopWorkList('Title' , 'asc' ,1 , 10 , '')\" ";
		var downTitleName="onclick=\"sortingCopWorkList('Title' , 'desc' ,1 , 10 , '')\" ";
		var upUserName="onclick=\"sortingCopWorkList('SubProcessName' , 'asc' ,1 , 10 , '')\" ";
		var downUserName="onclick=\"sortingCopWorkList('SubProcessName' , 'desc' ,1 , 10 , '')\" ";
		var st = '<table width="100%" border="0" cellspacing="2" cellpadding="0" style="border:1px solid #abc762" id="DIV_BOX_TABLE">';
		st=st+'<tr><th width="20%" align="center">Name <img src="'+up+'" '+upName+' /><img src="'+down+'" '+downName+' /></th><th width="20%" align="center" style="margin-left:10px">Title <img src="'+up+'" '+upTitleName+' /><img src="'+down+'" '+downTitleName+' /></th>';
		st=st+'<th width="20%" align="center" style="margin-left:10px">Type <img src="'+up+'" '+upTypeName+' /><img src="'+down+'" '+downTypeName+' /></th><th width="20%" align="center" style="margin-left:10px">Division <img src="'+up+'" '+upLastUpdate+' /><img src="'+down+'" '+downLastUpdate+' /></th>';
		st=st+'<th width="20%" align="center" style="margin-left:10px">Sub Process <img src="'+up+'" '+upUserName+' /><img src="'+down+'" '+downUserName+' /></th></tr>';	
	
		for (var i = 0; i < resultObj.length; i++) {
			index = i+1;
			var copID="'"+resultObj[i].copID+"'";
			var copName="'"+resultObj[i].fileFieldName+"'";
			var changeActive='';
			var statusName='';
			st=st+'<tr><td width="20%" align="left"><span class="copWrap_Name"><a href="'+resultObj[i].fileFieldURL+'">'+resultObj[i].fileFieldName+'</a></span></td>';
			st=st+'<td width="20%" align="left" style="margin-left:10px"><span class="copWrap_Title">'+resultObj[i].title+'</span></td>';
			st=st+'<td width="20%" align="left" style="margin-left:10px">'+resultObj[i].typeName+'</td>';
			st=st+'<td width="20%" align="left" style="margin-left:10px">'+resultObj[i].divisionName+'</td>';
			st=st+'<td width="20%" align="left" style="margin-left:10px">'+resultObj[i].subProcessName+'</td>';
			st=st+'</tr>';
			
		}
		st=st+'</table>';
		document.getElementById('OrganizationChart').innerHTML = st;
	 	document.getElementById('paggingDiv').innerHTML = '<div class="pagination">'+resultAll[1]+'</div>';
	 	document.getElementById('totalDiv').innerHTML = '<strong>Total: </strong>'+resultAll[2];	
	
	}

</script>
</head>
<body>
<div id="content">
<table width="97%" align="center" border="0" cellspacing="5"
	cellpadding="0" style="margin-left:10px;">
	<tr>
		<td valign="top">

		<table width="950" align="center" border="0" cellspacing="0"
			cellpadding="0">
			<tr>
				<td height="30" colspan="2"><span
					style="color:#030; font-size:12px;"><strong>You are
				in:</strong> Home >> Work Procedure </span></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td height="20" align="right"></td>
			</tr>

			<tr>
				<td height="25" colspan="2" align="left">
				<form id="form1" name="form1" method="get" action="">
				<table width="100%" border="0" cellspacing="2" cellpadding="0">
					<tr>
						<td width="12%"><strong>Search Title:</strong></td>
						<td width="92%" align="left" valign="top"><input
							name="search" type="text" id="search" size="50"
							onKeyPress="return chk(event)"></td>
					</tr>
					<tr>
						<td width="8%"></td>
						<td width="92%" align="left" valign="top"><label> <input
							type="checkbox" name="search_by" id="search_by"
							onclick='fncchange()' checked="checked" /> Advance Search </label></td>
					</tr>
					<tr>
						<td width="100%" colspan="2">
						<div id="showSearch">
						<table width="100%" align="center" border="0" cellspacing="0"
							cellpadding="0">
							<tr>
								<td height="20" valign="top" width="12%"><strong>Select:</strong></td>
								<td align="left" width="868"><select name="country"
									id="country">
									<option value="0">--Country--</option>
									<c:choose>
										<c:when test="${CountryName=='Thailand'}">
											<option value="Thailand" selected="selected">Thailand</option>
										</c:when>
										<c:otherwise>
											<option value="Thailand">Thailand</option>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${CountryName=='China'}">

											<option value="China" selected="selected">China</option>
										</c:when>
										<c:otherwise>
											<option value="China">China</option>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${CountryName=='Indonesia'}">

											<option value="Indonesia" selected="selected">Indonesia</option>
										</c:when>
										<c:otherwise>
											<option value="Indonesia">Indonesia</option>
										</c:otherwise>
									</c:choose>

								</select> <select name="type" id="type">
									<option value="0">--Type--</option>
									<c:forEach items="${listTypes}" var="listType"
										varStatus="status">
										<option value="${listType.copTypeID}">${listType.copTypeName}</option>
									</c:forEach>
								</select><select name="bu" id="bu">
									<option value="0">--BU--</option>
									<c:forEach items="${listBus}" var="listBu" varStatus="status">
										<c:choose>
											<c:when test="${listBu.copBuID==BuName}">
												<option value="${listBu.copBuID}" selected="selected">${listBu.copBuName}</option>
											</c:when>
											<c:otherwise>
												<option value="${listBu.copBuID}">${listBu.copBuName}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</select><select name="departmant" id="departmant">
									<option value="0">--Departmant--</option>
									<c:forEach items="${listDepartments}" var="listDepartment"
										varStatus="status">
										<c:choose>
											<c:when
												test="${listDepartment.copDepartmentID==DepartmentName}">
												<option value="${listDepartment.copDepartmentID}"
													selected="selected">${listDepartment.copDepartmentName}</option>
											</c:when>
											<c:otherwise>
												<option value="${listDepartment.copDepartmentID}">${listDepartment.copDepartmentName}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>

								</select><select name="division" id="division">
									<option value="0">--Division--</option>
									<c:forEach items="${listDivisions}" var="listDivision"
										varStatus="status">
										<c:choose>
											<c:when test="${listDivision.copDivisionID==DivisionName}">
												<option value="${listDivision.copDivisionID}"
													selected="selected">${listDivision.copDivisionName}</option>
											</c:when>
											<c:otherwise>
												<option value="${listDivision.copDivisionID}">${listDivision.copDivisionName}</option>
											</c:otherwise>
										</c:choose>

									</c:forEach>
								</select><select name="chain" id="chain">
									<option value="0">--Value Chain--</option>
									<c:forEach items="${listValueChains}" var="listValueChain"
										varStatus="status">
										<c:choose>
											<c:when
												test="${listValueChain.copValueChainID==ValueChainName}">
												<option value="${listValueChain.copValueChainID}"
													selected="selected">${listValueChain.copValueChainName}</option>
											</c:when>
											<c:otherwise>
												<option value="${listValueChain.copValueChainID}">${listValueChain.copValueChainName}</option>
											</c:otherwise>
										</c:choose>

									</c:forEach>
								</select><select name="coreProcess" id="coreProcess">
									<option value="0">--Core Process--</option>
									<c:forEach items="${listCoreProcesss}" var="listCoreProcess"
										varStatus="status">
										<c:choose>
											<c:when
												test="${listCoreProcess.copCoreProcessID==CoreProcessName}">
												<option value="${listCoreProcess.copCoreProcessID}"
													selected="selected">${listCoreProcess.copCoreProcessName}</option>
											</c:when>
											<c:otherwise>
												<option value="${listCoreProcess.copCoreProcessID}">${listCoreProcess.copCoreProcessName}</option>
											</c:otherwise>
										</c:choose>

									</c:forEach>
								</select><select name="subProcess" id="subProcess">
									<option value="0">--Sub Process--</option>
									<c:forEach items="${listSubProcesss}" var="listSubProcess"
										varStatus="status">
										<c:choose>
											<c:when
												test="${listSubProcess.copSubProcessID==SubProcessName}">
												<option value="${listSubProcess.copSubProcessID}"
													selected="selected">${listSubProcess.copSubProcessName}</option>
											</c:when>
											<c:otherwise>
												<option value="${listSubProcess.copSubProcessID}">${listSubProcess.copSubProcessName}</option>
											</c:otherwise>
										</c:choose>

									</c:forEach>
								</select></td>
							</tr>
						</table>
						</div>
						</td>
					</tr>


					<tr>
						<td height="20">&nbsp;</td>
						<td align="left" valign="top"><input type="button"
							name="button" id="button" value="Search"
							onclick="searchCopWork(1 , 10 ,'')" class="ui-button-cop">
						<input type="button" name="button2" id="button2" value="Reset"
							class="ui-button-cop"></td>
					</tr>
				</table>
				</form>
				</td>
			</tr>
			<tr>
				<td colspan="2" valign="top">
				<div id="OrganizationChart">
				<table width="100%" border="0" cellspacing="2" cellpadding="0"
					style="border:1px solid #abc762" id="DIV_BOX_TABLE">
					<tr>
						<th width="20%" align="center">Name <img
							src="<%=request.getContextPath()%>/images/up.png"
							onclick="sortingCopWorkList('Name' , 'asc' ,1 , 10 , '')" /><img
							src="<%=request.getContextPath()%>/images/down.png"
							onclick="sortingCopWorkList('Name' , 'desc' ,1 , 10 , '')" /></th>
						<th width="20%" align="center" style="margin-left:10px">Title
						<img src="<%=request.getContextPath()%>/images/up.png"
							onclick="sortingCopWorkList('Title' , 'asc' ,1 , 10 , '')" /><img
							src="<%=request.getContextPath()%>/images/down.png"
							onclick="sortingCopWorkList('Title' , 'desc' ,1 , 10 , '')" /></th>
						<th width="20%" align="center" style="margin-left:10px">Type
						<img src="<%=request.getContextPath()%>/images/up.png"
							onclick="sortingCopWorkList('TypeName' , 'asc' ,1 , 10 , '')" /><img
							src="<%=request.getContextPath()%>/images/down.png"
							onclick="sortingCopWorkList('TypeName' , 'desc' ,1 , 10 , '')" /></th>
						<th width="20%" align="center" style="margin-left:10px">Division
						<img src="<%=request.getContextPath()%>/images/up.png"
							onclick="sortingCopWorkList('DivisionName' , 'asc' ,1 , 10, '')" /><img
							src="<%=request.getContextPath()%>/images/down.png"
							onclick="sortingCopWorkList('DivisionName' , 'desc' ,1 , 10 , '')" /></th>
						<th width="20%" align="center" style="margin-left:10px">Sub
						Process <img src="<%=request.getContextPath()%>/images/up.png"
							onclick="sortingCopWorkList('SubProcessName' , 'asc' ,1 , 10 , '')" /><img
							src="<%=request.getContextPath()%>/images/down.png"
							onclick="sortingCopWorkList('SubProcessName' , 'desc' ,1 , 10 , '')" /></th>
					</tr>
					<c:forEach items="${listCops}" var="listCop" varStatus="status">
						<tr>
							<td width="20%" align="left"><span class="copWrap_Name"><a
								href="${listCop.fileFieldURL}">${listCop.fileFieldName}</a></span></td>
							<td width="20%" align="left" style="margin-left:10px"><span class="copWrap_Title">${listCop.title}</span></td>
							<td width="20%" align="left" style="margin-left:10px">${listCop.typeName}</td>
							<td width="20%" align="left" style="margin-left:10px">${listCop.divisionName}</td>
							<td width="20%" align="left" style="margin-left:10px">${listCop.subProcessName}</td>

						</tr>
					</c:forEach>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td height="25" colspan="2" style="padding-left:5px;" align="left">
				<div id="totalDiv"><strong>Total:</strong> <c:out
					value="${Total}"></c:out></div>

				</td>
			</tr>
			<tr>
				<td colspan="2" valign="top">
				<table width="100%" border="0" height="30" cellspacing="0"
					cellpadding="0">
					<tr>
						<td width="50%" style="padding-left:5px;" align="left"><a
							href="<portlet:renderURL>
                      					<portlet:param name="action" value="listCop"/>
									</portlet:renderURL>"><<
						Back to Home</a></td>
						<td width="50%" style=" padding-right:5px;" align="right">
						<div id="paggingDiv">
						<div class="pagination"><c:out value="${pagging}"
							escapeXml="false" /></div>
						</div>

						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>

</body>
</html>
