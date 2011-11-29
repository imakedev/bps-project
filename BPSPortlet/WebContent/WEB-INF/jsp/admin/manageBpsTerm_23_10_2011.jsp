<%@include file="../include.jsp"%>
<%@page import="th.co.vlink.xstream.common.VResultMessage"%>
<%@page import="th.co.vlink.utils.Pagging"%>
<%@page import="th.co.vlink.bps.util.Paging"%>
<%@page import="th.co.vlink.bps.form.BpsAdminForm"%>
<%@page import="javax.portlet.PortletURL"%>
<%@page contentType="text/html; charset=utf-8"%>
<html>
<head>
<c:url var="url" value="/" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${url}css/jquery-ui/jquery-ui-1.8.custom.css" type="text/css">
<link rel="stylesheet" href="${url}css/ui.selectmenu.css" type="text/css">
<script src='${url}js/jquery-1.6.4.min.js' type="text/javascript"></script>
<script src="${url}js/redmond/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
<script src='${url}js/jquery.highlight-3.js'></script>
<script src='${url}js/ui.selectmenu.js' type="text/javascript"></script>
<title>Insert title here</title>
<%--
<link rel="stylesheet" type="text/css"
	href="${url}css/style.css" />
	--%>
<link rel="stylesheet" type="text/css"
	href="${url}css/style_cos.css" />
<style type="text/css">
		/*demo styles 
		body {font-size: 62.5%; font-family:"Verdana",sans-serif; margin: 70px 10px;}
		fieldset { border:0;  margin-bottom: 40px;}	
		*/
		label,select,.ui-select-menu { float: left; margin-right: 10px; }
		select { width: 200px; } 
</style>
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
<style type="text/css"> 
.highlight { background-color: yellow }
</style>

<script>
	var _range_text=200;
	$(document).ready(function() {
	  // Handler for .ready() called.
	  $("input:button").button();
	  $("input:submit").button();
	  var bptTerm = $("#bptTerm").val();
	  $('select#searchBy').selectmenu({style:'dropdown'});
	  $('select#bpgId').selectmenu({style:'dropdown'});
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
	  //alert(orderColumn)
	  //alert(orderBy)
	  /*
	  if("bpsGroup.bpgGroupName"==orderColumn){
		  $("#_sort_bpsGroup_"+orderBy).attr("style","cursor: pointer;");
	  }else
	  	$("#_sort_"+orderColumn+"_"+orderBy).attr("style","cursor: pointer;");
	  */
	 if(bptTerm!=''){
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
	 }else{
		 $('._highlight_def').each(function(){  
			 var newText=$(this).text().substring(0,200)+(($(this).text().length>200)?"...":""); 
			 $(this).text(newText);
		 });
	 }
      var _indexChar = $("#indexChar").val();
      /*
      $('a[class^=team_index_]').each(function(){ 
			var className=$(this).attr("class");  
			if(className.split("_")[2]==_indexChar.toUpperCase()){
				$(this).attr("style","font-style:italic;color: black;text-decoration: none;");
			}
		});
      */
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
 <%--
       String groupUsr = null;
       boolean userHasHRGroup = false;

       try {
               com.ibm.portal.puma.User portalUser = (com.ibm.portal.puma.User) request
               .getAttribute(com.ibm.portal.RequestConstants.REQUEST_USER_OBJECT);
               System.out.println("com.ibm.portal.RequestConstants.REQUEST_USER_OBJECT===>"+com.ibm.portal.RequestConstants.REQUEST_USER_OBJECT);
               System.out.println(portalUser.getID());
       		System.out.println(portalUser.getId());
       		System.out.println(portalUser.getUserID());
       		System.out.println(portalUser.get("mail"));
       		java.util.Enumeration aoe= portalUser.getAttributeNames();
    		while (aoe.hasMoreElements()) {
    			Object object = (Object) aoe.nextElement();
    			System.out.println("ooooooooo = "+object.getClass());
    		}
               if (portalUser != null) {
                       java.util.List list = portalUser.getGroups();
                       if (list != null && list.size() > 0) {
               int size = list.size();
               for (int i = 0; i < size; i++) {
                       com.ibm.wps.puma.Group groupElement = (com.ibm.wps.puma.Group) list.get(i);
                       if (groupElement.getName() != null) {
                               groupUsr = groupElement.getName();
                               if (groupUsr.equals("00_COS_WCM")) {
                       userHasHRGroup = true;
                               } else if (groupUsr.equals("00_COS")) {
                       userHasHRGroup = true;
                               } else if (groupUsr.equals("00_WPSAdmins")) {
                       userHasHRGroup = true;
                               }
                       }
               }
                       }

               }

       } catch (Exception e) {
               System.out.println("Exception");
       }
--%>
<portlet:renderURL var="urlAdd">
    	<portlet:param name="action" value="addOrEditBpsTerm"/>
    		<portlet:param name="mode" value="add"/>
    		<portlet:param name="bptId" value="0"/> 
</portlet:renderURL>
<portlet:renderURL var="formAction">
    <portlet:param name="action" value="manageBpsTerm"/>
</portlet:renderURL> 
<portlet:renderURL var="homeURL">
    <portlet:param name="action" value="list"/>
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
						are in:</strong> <a href="${fn:escapeXml(homeURL)}">Home</a> > Banpu Term and Definition (Administration)</span>
			</td>
		</tr>
		 
		<tr>
			<td colspan="2"><div class="team" style="padding-left: 10px;">
			<%--
				String[] indexChar = { "A", "B", "C", "D", "E", "F", "G", "H", "I",
					"J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U",
					"V", "W", "X", "Y", "Z" };
				for (int i = 0; i < indexChar.length; i++) {
			--%> 
			<%-- 
			 <a
				href='#'
				class="team_index_indexChar[i]" onClick="goToIndex('<portlet:renderURL><portlet:param name="action" value="manageBpsTerm"/><portlet:param name="indexChar" value="<%= indexChar[i]%>"/></portlet:renderURL>')">
					  =indexChar[i]  
				</a>
				 --%>
				 <%--
 				}
 			--%> 
				</div>
			</td>
		</tr>
		<tr>
			<td width="80%">
				<div style="padding-top: 5px;">
				<table cellspacing="5" cellpadding="5">
					<tr>
						<td><strong style="padding-left: 5px;">Search :</strong><form:input path="bptTerm" id="bptTerm"/> </td>
						<td>
							<form:select path="searchBy" id="searchBy">
	    					<form:option  label="By Term" value="1"/>
	    					<form:option  label="By Definition" value="2"/>
	    					<form:option  label="By All" value="3"/>
	    					</form:select>
	    				</td>
	    				<td>
	    					<form:select path="bpgId" id="bpgId">
	    					<form:option  label="--Select Category--" value="0"/>
	    					<form:options items="${listCates}" itemValue="bpgId"  itemLabel="bpgGroupName"/>
	    					</form:select> 
	    				</td>
	    				<td><input type="submit" name="button_search" id="button_search" value="Search"/></td>
					</tr>
				</table>   
				</div>
			</td>
			<td width="20%" align="right" height="20"><input type="button"
							name="button_add" id="button_add" value=" Add " onclick='<portlet:namespace />doAction("${urlAdd}","add")'/>  
			</td>
		</tr>
		 
		<tr>
			<td colspan="2" valign="top"> 
				<table width="100%" id="box-table-a" border="0" cellspacing="2"
					cellpadding="0" style="border: 1px solid #132C00">
					<tr>
						<th width="25%" height="25" align="center" bgcolor="#3DB0B5"><span  style="cursor: pointer;" onClick="checkSorting('bptTerm')">Term&nbsp;</span><img id="_sort_bptTerm_desc" 
							src="${url}images/up.png" style="cursor: pointer;display: none" onClick="goToIndex('${_sort_bptTerm_desc}')"/><img id="_sort_bptTerm_asc" src="${url}images/down.png" style="cursor: pointer;display: none;" onClick="goToIndex('${_sort_bptTerm_asc}')"/>
						</th>
						<th width="26%" align="center" bgcolor="#3DB0B5"><span  style="cursor: pointer;" onClick="checkSorting('bptDefinitionSearch')">Definition&nbsp;</span><img id="_sort_bptDefinitionSearch_desc" 
							src="${url}images/up.png" style="cursor: pointer;display: none" onClick="goToIndex('${_sort_bptDefinitionSearch_desc}')"/><img id="_sort_bptDefinitionSearch_asc" src="${url}images/down.png" style="cursor: pointer;display: none" onClick="goToIndex('${_sort_bptDefinitionSearch_asc}')"/>
						</th>
						<th width="26%" align="center" bgcolor="#3DB0B5"><span  style="cursor: pointer;" onClick="checkSorting('bpsGroup')">Category&nbsp;</span><img id="_sort_bpsGroup_desc"
							src="${url}images/up.png" style="cursor: pointer;display: none" onClick="goToIndex('${_sort_bpsGroup_desc}')"/><img  id="_sort_bpsGroup_asc" src="${url}images/down.png" style="cursor: pointer;display: none" onClick="goToIndex('${_sort_bpsGroup_asc}')"/>
						</th>
						<th width="17%" align="center" bgcolor="#3DB0B5"><span  style="cursor: pointer;" onClick="checkSorting('bptSource')">Source&nbsp;</span><img id="_sort_bptSource_desc"
							src="${url}images/up.png" style="cursor: pointer;display: none" onClick="goToIndex('${_sort_bptSource_desc}')"/><img id="_sort_bptSource_asc" src="${url}images/down.png" style="cursor: pointer;display: none" onClick="goToIndex('${_sort_bptSource_asc}')"/>
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
											height="16" >
											<img style="cursor: pointer;" onclick='return <portlet:namespace />doAction("${urlDelete}","delete")' src="${url}images/delete.png" width="16" 
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
				</table></td>
		</tr>
		<%
		 Object obj =  request.getAttribute("pageObj"); 
		th.co.vlink.utils.Pagging paging = (th.co.vlink.utils.Pagging)obj; 
		BpsAdminForm bpsAdminForm = (BpsAdminForm) request.getAttribute("bpsAdminForm");				 
		String bptTerm = bpsAdminForm.getBptTerm();
		String bpgId = bpsAdminForm.getBpgId();
		String searchBy = bpsAdminForm.getSearchBy();
		String orderBy = bpsAdminForm.getOrderBy();
		String orderColumn = bpsAdminForm.getOrderColumn();
		String indexChar_ = bpsAdminForm.getIndexChar();
		
		bptTerm=(bptTerm!=null&&bptTerm.trim().length()>0)?bptTerm.trim():"";
		bpgId=(bpgId!=null&&bpgId.trim().length()>0)?bpgId.trim():"0";
		searchBy=(searchBy!=null&&searchBy.trim().length()>0)?searchBy.trim():"0";
		orderBy=(orderBy!=null&&orderBy.trim().length()>0)?orderBy.trim():"asc";
		orderColumn=(orderColumn!=null&&orderColumn.trim().length()>0)?orderColumn.trim():"bptTerm";
		if(bptTerm.length()>0)
			indexChar_=bptTerm.substring(0, 1);
		else
			indexChar_=(indexChar_!=null&&indexChar_.trim().length()>0)?indexChar_.trim():"a";
			
			PortletURL _sort_bptTerm_desc_url = renderResponse.createRenderURL();
			_sort_bptTerm_desc_url.setParameter("action","manageBpsTerm");
			_sort_bptTerm_desc_url.setParameter("indexChar",indexChar_);
			_sort_bptTerm_desc_url.setParameter("bptTerm",bptTerm); 
			_sort_bptTerm_desc_url.setParameter("bpgId",bpgId); 
			_sort_bptTerm_desc_url.setParameter("searchBy","desc"); 					
			_sort_bptTerm_desc_url.setParameter("orderColumn","bptTerm");  
			
			PortletURL _sort_bptTerm_asc_url = renderResponse.createRenderURL();
			_sort_bptTerm_asc_url.setParameter("action","manageBpsTerm");
			_sort_bptTerm_asc_url.setParameter("indexChar",indexChar_);
			_sort_bptTerm_asc_url.setParameter("bptTerm",bptTerm); 
			_sort_bptTerm_asc_url.setParameter("bpgId",bpgId); 
			_sort_bptTerm_asc_url.setParameter("searchBy","asc"); 					
			_sort_bptTerm_asc_url.setParameter("orderColumn","bptTerm");  
			
			PortletURL _sort_bptDefinitionSearch_desc_url = renderResponse.createRenderURL();
			_sort_bptDefinitionSearch_desc_url.setParameter("action","manageBpsTerm");
			_sort_bptDefinitionSearch_desc_url.setParameter("indexChar",indexChar_);
			_sort_bptDefinitionSearch_desc_url.setParameter("bptTerm",bptTerm); 
			_sort_bptDefinitionSearch_desc_url.setParameter("bpgId",bpgId); 
			_sort_bptDefinitionSearch_desc_url.setParameter("searchBy","desc"); 					
			_sort_bptDefinitionSearch_desc_url.setParameter("orderColumn","bptDefinitionSearch");
			
			PortletURL _sort_bptDefinitionSearch_asc_url = renderResponse.createRenderURL();
			_sort_bptDefinitionSearch_asc_url.setParameter("action","manageBpsTerm");
			_sort_bptDefinitionSearch_asc_url.setParameter("indexChar",indexChar_);
			_sort_bptDefinitionSearch_asc_url.setParameter("bptTerm",bptTerm); 
			_sort_bptDefinitionSearch_asc_url.setParameter("bpgId",bpgId); 
			_sort_bptDefinitionSearch_asc_url.setParameter("searchBy","asc"); 					
			_sort_bptDefinitionSearch_asc_url.setParameter("orderColumn","bptDefinitionSearch");
		 
			PortletURL _sort_bpsGroup_desc_url = renderResponse.createRenderURL();
			_sort_bpsGroup_desc_url.setParameter("action","manageBpsTerm");
			_sort_bpsGroup_desc_url.setParameter("indexChar",indexChar_);
			_sort_bpsGroup_desc_url.setParameter("bptTerm",bptTerm); 
			_sort_bpsGroup_desc_url.setParameter("bpgId",bpgId); 
			_sort_bpsGroup_desc_url.setParameter("searchBy","desc"); 					
			_sort_bpsGroup_desc_url.setParameter("orderColumn","bpsGroup.bpgGroupName");
			
			PortletURL _sort_bpsGroup_asc_url = renderResponse.createRenderURL();
			_sort_bpsGroup_asc_url.setParameter("action","manageBpsTerm");
			_sort_bpsGroup_asc_url.setParameter("indexChar",indexChar_);
			_sort_bpsGroup_asc_url.setParameter("bptTerm",bptTerm); 
			_sort_bpsGroup_asc_url.setParameter("bpgId",bpgId); 
			_sort_bpsGroup_asc_url.setParameter("searchBy","asc"); 					
			_sort_bpsGroup_asc_url.setParameter("orderColumn","bpsGroup.bpgGroupName");
		 
			PortletURL _sort_bptSource_desc_url = renderResponse.createRenderURL();
			_sort_bptSource_desc_url.setParameter("action","manageBpsTerm");
			_sort_bptSource_desc_url.setParameter("indexChar",indexChar_);
			_sort_bptSource_desc_url.setParameter("bptTerm",bptTerm); 
			_sort_bptSource_desc_url.setParameter("bpgId",bpgId); 
			_sort_bptSource_desc_url.setParameter("searchBy","asc"); 					
			_sort_bptSource_desc_url.setParameter("orderColumn","bptSource");
			
			PortletURL _sort_bptSource_asc_url = renderResponse.createRenderURL();
			_sort_bptSource_asc_url.setParameter("action","manageBpsTerm");
			_sort_bptSource_asc_url.setParameter("indexChar",indexChar_);
			_sort_bptSource_asc_url.setParameter("bptTerm",bptTerm); 
			_sort_bptSource_asc_url.setParameter("bpgId",bpgId); 
			_sort_bptSource_asc_url.setParameter("searchBy","desc"); 					
			_sort_bptSource_asc_url.setParameter("orderColumn","bptSource"); 
			
		%>
		<c:if test="${bpsTerms.maxRow != 0}">
		<tr> 
			<td width="100%" colspan="2">
				<div class="pagination">
				<%  
					
				int PAGE_BETWEEN = 5;
		        int pagingScript_currentPage=paging.getPageNo();
				int pagingScript_recordCount=paging.getTotalRecord();
				int pagingScript_recordPerPage=paging.getPageSize();//RECORD_PERPAGE;
				
				int plus = pagingScript_recordCount%pagingScript_recordPerPage!=0?1:0;
				int  pagingScript_pageCount=new Double(Math.floor((pagingScript_recordCount)/pagingScript_recordPerPage)).intValue()+plus;
		 
				int startIndex =1;
				int endIndex = 0;
				if(pagingScript_currentPage-PAGE_BETWEEN>0){
					if(pagingScript_pageCount==pagingScript_currentPage)
						startIndex = pagingScript_currentPage- 4;//(PAGE_BETWEEN-1);
					else			 
						startIndex = pagingScript_currentPage- 2;//(PAGE_BETWEEN-1);
				} 
				if(pagingScript_pageCount>=(startIndex+5)){
					endIndex = startIndex+4;//(3-1);
				}else{
					endIndex = pagingScript_pageCount;
				}			
				String pagingScript_pageListStr="";				 
			 	String pagingScript_pagePrevStr=""; 
				String pagingScript_pageNextStr="";  
				String pagingScript_pagePrevFirstStr=""; 
				String pagingScript_pageNextEndStr=""; 
				String pagingScript_pageListStrReturn="";
				for(int j=startIndex;j<=endIndex;j++)
				{
			 	int pageRunner=j; 
					if(pageRunner>0 && pageRunner<=pagingScript_pageCount){
						if(pageRunner==pagingScript_currentPage){ 
								 pagingScript_pageListStr+="<li><strong class=\"currentpage\">"+pageRunner+"</strong></li>"; 
						}
						else{		
							PortletURL url = renderResponse.createRenderURL(); 
							url.setParameter("action","manageBpsTerm");
							url.setParameter("pageNo",pageRunner+"");
						 	url.setParameter("bptTerm",bptTerm);  
							url.setParameter("bpgId",bpgId);  
							url.setParameter("searchBy",searchBy);  
							url.setParameter("orderBy",orderBy);  
							url.setParameter("orderColumn",orderColumn);  
							url.setParameter("indexChar",indexChar_); 							
							pagingScript_pageListStr+="<li><a href=\""+url.toString()+"\" class=\"pager-next active\" title=\"Go to page "+pageRunner+"\">"+pageRunner+"</a></li>";								
						}
					}				 
				}		 
				if(startIndex>1){ 
					PortletURL first = renderResponse.createRenderURL();
					first.setParameter("action","manageBpsTerm");
					first.setParameter("pageNo","1"); 
					first.setParameter("bptTerm",bptTerm);  
					first.setParameter("bpgId",bpgId);  
					first.setParameter("searchBy",searchBy);  
					first.setParameter("orderBy",orderBy);  
					first.setParameter("orderColumn",orderColumn);  
					first.setParameter("indexChar",indexChar_);    
					PortletURL prev = renderResponse.createRenderURL();
					prev.setParameter("action","manageBpsTerm");
					prev.setParameter("pageNo",(pagingScript_currentPage-1)+""); 
					pagingScript_pageListStr="<li><a href=\""+first.toString()+"\" class=\"pager-first active\" title=\"Go to next page\">first </a><a href=\""+prev.toString()+"\" class=\"pager-prev active\" title=\"Go to next page\">prev </a></li>"+pagingScript_pageListStr;
				}
				if(endIndex<pagingScript_pageCount){ 
					PortletURL next = renderResponse.createRenderURL();
					next.setParameter("action","manageBpsTerm");
					next.setParameter("pageNo",(pagingScript_currentPage+1)+""); 
					next.setParameter("bptTerm",bptTerm);  
					next.setParameter("bpgId",bpgId);  
					next.setParameter("searchBy",searchBy);  
					next.setParameter("orderBy",orderBy);  
					next.setParameter("orderColumn",orderColumn);  
					next.setParameter("indexChar",indexChar_);    
					
					PortletURL end = renderResponse.createRenderURL();
					end.setParameter("action","manageBpsTerm");
					end.setParameter("pageNo",pagingScript_pageCount+"");
					end.setParameter("bptTerm",bptTerm);  
					end.setParameter("bpgId",bpgId);  
					end.setParameter("searchBy",searchBy);  
					end.setParameter("orderBy",orderBy);  
					end.setParameter("orderColumn",orderColumn);  
					end.setParameter("indexChar",indexChar_);    
				} 
				pageContext.setAttribute("pagingScript_pageListStr",pagingScript_pageListStr);
			 
		%> 
					<ul>
					<% if(pagingScript_recordCount!=0){%>
        	 				 <c:out value="${pagingScript_pageListStr}" escapeXml="false"></c:out>
         				<%} %>
         				<%--
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
						 --%>
					</ul>
				</div>
			</td>
		</tr>
		</c:if>
	</table> 
<input type="hidden" id="hidden_sort_bptTerm_desc" value="<%=_sort_bptTerm_desc_url %>" />
<input type="hidden" id="hidden_sort_bptTerm_asc" value="<%=_sort_bptTerm_asc_url %>" />
<input type="hidden" id="hidden_sort_bptDefinitionSearch_desc" value="<%=_sort_bptDefinitionSearch_desc_url%>" />
<input type="hidden" id="hidden_sort_bptDefinitionSearch_asc" value="<%=_sort_bptDefinitionSearch_asc_url%>" />
<input type="hidden" id="hidden_sort_bpsGroup_desc" value="<%=_sort_bpsGroup_desc_url%>" />
<input type="hidden" id="hidden_sort_bpsGroup_asc" value="<%=_sort_bpsGroup_asc_url%>" />
<input type="hidden" id="hidden_sort_bptSource_desc" value="<%=_sort_bptSource_desc_url%>" />
<input type="hidden" id="hidden_sort_bptSource_asc" value="<%=_sort_bptSource_asc_url%>" />
</form:form>
</body>
</html>