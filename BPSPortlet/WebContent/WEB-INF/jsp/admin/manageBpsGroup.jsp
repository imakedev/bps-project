<%@include file="../include.jsp"%> 
<%@page contentType="text/html; charset=utf-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function <portlet:namespace />doAction(_url,mode){ 
	if(mode=='delete'){
		var agree  = confirm("Would you like to delete ?");
		if (agree){
			window.location.href = _url; 
		}
		else{ 
		}
	}else{
  		window.location.href=_url; 	
	}
}
</script>
</head>
<body>
<table width="70%">
	<tr>
		<td align="right">
		 <portlet:renderURL var="urlAdd">
    				<portlet:param name="action" value="addOrEditBpsGroup"/>
    				<portlet:param name="mode" value="add"/>
    				<portlet:param name="bpgId" value="0"/>
    	</portlet:renderURL>
				  	<label >
				    	<input type="button" name="button" id="button" value=".: Add :." onclick='<portlet:namespace />doAction("${fn:escapeXml(urlAdd)}","add")'/>&nbsp; 
					</label> 
			
	</tr>
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="2" cellpadding="0" style="border:1px solid #132C00">
			<tr>
    			<th height="25" align="center" bgcolor="#3DB0B5"  >Categoty </th>
  			</tr>
  			<tr>
    			<td  valign="top" >
    				<table width="100%"  id="box-table-a" border="0" cellspacing="2" cellpadding="0">
						<c:if test="${resultList ne null && resultList.resultListObj ne null}">
							<c:forEach items="${resultList.resultListObj}" var="item" varStatus="itemCount"> 
								<tr>
   				 					<td width="90%" align="left"><span>Country</span></td>
    								<td width="10%" align="left">Edit | Delete</td>
    							</tr>
  						
  						<tr>
    				</table>
				</td>
    		</tr>
		</table>
			<c:if test="${resultList ne null && resultList.resultListObj ne null}">
				<c:forEach items="${resultList.resultListObj}" var="item" varStatus="itemCount">
			<tr>
				<td align="center">${itemCount.count}</td>
				<td align="left">${item.bpgGroupName}</td>
				<td align="center"> 
				<portlet:actionURL var="urlDelete">
					<portlet:param name="action" value="deleteBpsGroup"/>
                    <portlet:param name="bpgId" value="${category.pmcateId}"/>                            
                </portlet:actionURL>
                <portlet:renderURL var="urlEdit">
               		<portlet:param name="action" value="addOrEditBpsGroup"/>
                	<portlet:param name="mode" value="edit"/>
               		<portlet:param name="bpgId" value="${category.pmcateId}"/>                            
                </portlet:renderURL>
                <span style="cursor: pointer;text-decoration: underline;" onclick='<portlet:namespace />doAction("${fn:escapeXml(urlEdit)}","edit")'>
			          			Edit 
			    </span>
			   |
			   <span style="cursor: pointer;text-decoration: underline;" onclick='<portlet:namespace />doAction("${fn:escapeXml(urlDelete)}","delete")'>
			   					Delete
			   </span>
			   </td>
			</tr>
				</c:forEach>
			</c:if>
			<c:if test="${resultList eq null || resultList.resultListObj eq null}">
			<tr>
				<td align="center" colspan="4">Data not found.</td>
			</tr>
			</c:if>
		</table>
		</td>
	</tr>
</table>
</body>
</html>