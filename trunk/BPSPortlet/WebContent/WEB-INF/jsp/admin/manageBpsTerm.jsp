<%@include file="../include.jsp"%> 
<%@page contentType="text/html; charset=utf-8"%>
<html>
<head>
<c:url var="url" value="/" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${url}css/jquery-ui/jquery-ui-1.8.custom.css" type="text/css">
<link rel="stylesheet" href="${url}css/ui.selectmenu.css" type="text/css">
<script src='${url}js/jquery-1.6.4.min.js' type="text/javascript"></script>
<script src="${url}css/jquery-ui/jquery-ui-1.8.custom.min.js" type="text/javascript"></script>
<script src='${url}js/jquery.highlight-3.js'></script>
<script src='${url}js/ui.selectmenu.js' type="text/javascript"></script>
<script type="text/javascript"
        src="${url}dwr/interface/BpsAdminAjax.js"></script> 
<script type="text/javascript"
        src="${url}dwr/engine.js"></script> 
<script type="text/javascript"
        src="${url}dwr/util.js"></script>
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
		label,select,.ui-select-menu { float: left; margin-right: 10px;}
		select { width: 200px; }  
		.ui-widget{font-family: Tahoma;font-size: 12px; }
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
	var _pageSizeG=10;
	var pageBetweenG=10;
	/*
	$(document).ready(function() {
		$("#bptlId_input").keypress(function(event) {
	  	  if ( event.which == 13 ) {
	  	     event.preventDefault();
	  	   <portlet:namespace />doSearch('1');
	  	   }
	  });
		<portlet:namespace />doSearch('init','1');
	});
	*/
	$(document).ready(function() {
	  // Handler for .ready() called.
	  $("#bptTerm").keypress(function(event) {
	  	  if ( event.which == 13 ) {
	  	     event.preventDefault();
	  	   <portlet:namespace />doSearch('1');
	  	   }
	  });
	   $("input:button").button();
	 //  $("input:submit[value!=Search]").button();
	  $('select#searchBy').selectmenu({style:'dropdown'});
	  $('select#bpgId').selectmenu({style:'dropdown'});
	  <portlet:namespace />doSearch('1'); 	 
	
	 
	});
	function checkSorting(_id){ 
		var haveSorting=false;
		var _order="desc";
		var _count=0;
		$('img[id^=_sort_'+_id+'_]').each(function(){ 
			  var _style= $(this).attr("style");
			  if(_style.indexOf("display: none")!=-1){
				  var ids=$(this).attr("id").split("_");// _sort_bptTerm_asc
				  haveSorting=true;
				  _order=ids[3]=="asc"?"desc":"asc";
				  _count++;
			  } 
		  });
		if(_count==2)
			_order="asc";
		goToIndex($("#hidden_sort_"+_id+"_"+_order).val());
	}
	function goToIndex(_index){
		//alert(_index)
		window.location.href = _index;
	}
	function <portlet:namespace />doGoPage(_url, mode) {
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
	function <portlet:namespace/>doAction(_mode,_id){
		  if(_mode=='delete'){
			$( "#dialog-message" ).html("Would you like to delete ?");
			$( "#dialog-message" ).dialog({
				title:"Delete Term",
				modal: true,
				show: 'slide' ,
			//	hide: "explode",
				buttons: [
					          {
				              text: "Ok",
				              click: function() {  
				            	  $(this).dialog("close");
				            	  $(this).dialog( "destroy" );
				            	  BpsAdminAjax.deleteBpsTerm(_id,{
				      				callback:function(data){ 
						            	<portlet:namespace />doSearch('1');
				      				}				            	  				            				            	  
				            	 }); 
				              }
				          },
				          {
				              text: "Cancel",
				              click: function() { 
				            	  $(this).dialog("close");
				            	  $(this).dialog( "destroy" );
				          	  }
				          }
				      ]
			}); 
		  }else{
			  $("#bptId").val(_id);
			  $("#command").val(_mode);
			  document.bpsAdminForm.submit();
		  }
		}
	function <portlet:namespace />setHighlight(){
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
	     // var _indexChar = $("#indexChar").val();
	}
	function <portlet:namespace />doSearch(_pageIndex){
		//alert($("#bptlId_H").val()) 
		var pagging={pageSize:_pageSizeG,pageNo:_pageIndex};
		//alert(pageStr)
		var bpsTerm;
			var isNumber=true;
			//$("#bptlId_input").val(jQuery.trim($("#bptlId_input").val()));
			//if($("#bptlId_input").val().length>0)
			//	isNumber=<portlet:namespace />isNumber($("#bptlId_input").val());  
	//	 alert($("select[id=bpgId]").val());
		if(isNumber){
				var vcriteria={
						orderBy:"asc",
						orderColumn:"BPT_TERM",
						value:$("#bptTerm").val(),
						key:$("select[id=searchBy]").val()
				};
			var bpsGroup;
			if($("select[id=bpgId]").val()!="0"){
				bpsGroup={bpgId:$("select[id=bpgId]").val()};
			}else{
				bpsGroup={};
			}
				bpsTerm={
					bptTerm:$("#bptTerm").val(),
					vcriteria:vcriteria,		
					bpsGroup:bpsGroup,
					pagging:pagging
					};
		 }
			else{
				$( "#dialog-message" ).html("Please insert numeric ");
				$( "#dialog-message" ).dialog({
					title:"Message ",
					modal: true,
					show: 'slide' ,
				//	hide: "explode",
					buttons: [
						          {
					              text: "Ok",
					              click: function() {  
					            	  $(this).dialog("close");
					            	  $(this).dialog( "destroy" ); 
					              }
					          }
					      ]
				}); 
				return false;
			} 	
			//alert($("#bptlId_input").val()) 
		var str="<table width=\"100%\" id=\"box-table-a\" border=\"0\" cellspacing=\"2\" "+
		"	cellpadding=\"0\" style=\"border: 1px solid #132C00\">"+
		"	<tr>"+
		"		<th width=\"25%\" height=\"25\" align=\"center\" bgcolor=\"#3DB0B5\">Term</th>"+
		"		<th width=\"26%\" align=\"center\" bgcolor=\"#3DB0B5\">Definition</th>"+
		"		<th width=\"26%\" align=\"center\" bgcolor=\"#3DB0B5\">Category</th>"+
		"		<th width=\"17%\" align=\"center\" bgcolor=\"#3DB0B5\">Source</th>"+
		"		<th width=\"6%\" align=\"center\" bgcolor=\"#3DB0B5\">&nbsp;</th>"+
		"	</tr> ";
		var loadingStr=str+"<tr>"+
		"	<td colspan=\"5\" align=\"center\" height=\"25\" class=\"content\"><img src=\"${url}images/ajax_loading.gif\"/></td>"+
		"</tr></table>"; 
		$("#content_element").html(loadingStr);
		BpsAdminAjax.searchBpsTerm(bpsTerm,{
			callback:function(data){
				//alert(data) 
				var pageStr="";
				if(data!=null && data.length==2 && data[0].length>0){ 
					var bpsTerm=data[0];
					var maxSize=data[1]; 
					pageStr= <portlet:namespace/>calculationPaging(_pageIndex,maxSize,_pageSizeG,pageBetweenG);
					for(var i=0;i<bpsTerm.length;i++){
						str=str+"<tr valign=\"top\">"+
								"<td><a  style=\"cursor: pointer;\" onclick=\"<portlet:namespace/>doAction('view','"+bpsTerm[i].bptId+"');\"  class=\"team\"><span class=\"_highlight_term\">"+bpsTerm[i].bptTerm+"</span></a></td>"+
								"<td><span class=\"_highlight_def\">"+bpsTerm[i].bptDefinition+"</span></td>"+
								"<td>"+bpsTerm[i].bpsGroup.bpgGroupName+"</td>"+ 
								"<td>"+bpsTerm[i].bptSource+"</td>"+
								"<td align=\"center\">"+
								"<img style=\"cursor: pointer;\" onclick=\"<portlet:namespace/>doAction('edit','"+bpsTerm[i].bptId+"');\" src=\"${url}images/edit.png\" width=\"16\" height=\"16\" >"+
								"<img style=\"cursor: pointer;\" onclick=\"<portlet:namespace/>doAction('delete','"+bpsTerm[i].bptId+"');\"  src=\"${url}images/delete.png\" width=\"16\"	height=\"16\"></td>"; 
						str=str+"</tr>";
					}  
				}else{
					str=str+"<tr>"+
							"	<td colspan=\"5\" align=\"center\" height=\"25\" class=\"content\">ไม่พบข้อมูล</td>"+
							"</tr>";
				}
				str=str+"</table>";
				$("#content_element").html(str);
				$("#_pagination").html(pageStr); 
				<portlet:namespace />setHighlight();
			}
		}); 
	}
	function <portlet:namespace/>calculationPaging(_pageIndex,obj_size,_pageSize,pageBetween){
		var pagingScript_recordCount=parseInt(obj_size, 10);;//totalRecord;
		var pagingScript_recordPerPage=parseInt(_pageSize,10);//pageSize;//RECORD_PERPAGE;
		       		
		var plus = pagingScript_recordCount%pagingScript_recordPerPage!=0?1:0;
		var pagingScript_pageCount=parseInt((pagingScript_recordCount/pagingScript_recordPerPage),10)+plus;
		
		//alert("pagingScript_pageCount="+pagingScript_pageCount)
		var pageNo=parseInt(_pageIndex,10);
		var startIndex =pageNo-parseInt((pageBetween/2),10);
		var endIndex = pageNo+(parseInt((pageBetween/2),10)-1); 
		//alert("startIndex="+startIndex)
		var page_plus=pageBetween-((endIndex-startIndex)+1);
			endIndex=endIndex+page_plus;
		var lock_start=pagingScript_pageCount-pageBetween+1;
		var lock_end=pageBetween;
		       		//if(<pageBetween)
		       // check startIndex and endIndex
		 //alert("lock_start="+lock_start+",lock_end="+lock_end)
		if(startIndex<1)
		   startIndex = 1;
		if(startIndex<lock_start)
		   startIndex=lock_start;
		       
		if(endIndex>pagingScript_pageCount)        		
		    endIndex = pagingScript_pageCount;
		if(endIndex>lock_end)
		    endIndex=lock_end;
		       	
		 var havePrev=false;
		 var haveNext=false;	
		if(pageNo!=1)
	       		havePrev=true;
	    if(pageNo!=pagingScript_pageCount)
	       		haveNext=true; 
		var pageStr="<ul>";
	   if(havePrev)
		   pageStr=pageStr+"<li><a href=\"javascript: <portlet:namespace />doSearch('1')\" class=\"prevnext\">«</a>&nbsp;</li>"+
		   					"<li><a href=\"javascript: <portlet:namespace />doSearch('"+(pageNo-1)+"')\" class=\"prevnext\">previous</a>&nbsp;</li>";
	   for(var k=startIndex;k<=endIndex;k++ ){
		   if(k==pageNo) 
		  	 pageStr = pageStr+"<li><a class=\"currentpage\">"+k+"</a>&nbsp;</li>";
		  else
			 pageStr = pageStr+"<li><a href=\"javascript: <portlet:namespace />doSearch('"+k+"')\">"+k+"</a>&nbsp;</li>";
	    } 
	   if(haveNext)
		   pageStr=pageStr+"<li><a href=\"javascript: <portlet:namespace />doSearch('"+(pageNo+1)+"')\" class=\"prevnext\">next</a>&nbsp;</li>"+
		   					"<li><a href=\"javascript: <portlet:namespace />doSearch('"+pagingScript_pageCount+"')\" class=\"prevnext\">»</a></li>";
	   pageStr=pageStr+"</ul>";
		 
			return pageStr;
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
<div id="dialog-message" title="Message">
	<p>
		 
	</p>
</div>
<portlet:renderURL var="urlAdd">
    	<portlet:param name="action" value="addOrEditBpsTerm"/>
    		<portlet:param name="mode" value="add"/>
    		<portlet:param name="bptId" value="0"/> 
</portlet:renderURL>
<portlet:actionURL var="formAction">
    <portlet:param name="action" value="doSubmit"/>
</portlet:actionURL> 
<portlet:renderURL var="homeURL">
    <portlet:param name="action" value="list"/>
</portlet:renderURL>
<form:form  modelAttribute="bpsAdminForm" name="bpsAdminForm" method="post"  action="${formAction}">
<form:hidden path="command" id="command"/> 
<form:hidden path="indexChar" id="indexChar"/>
<form:hidden path="orderColumn" id="orderColumn"/>
<form:hidden path="orderBy" id="orderBy"/>
<form:hidden path="bptId" id="bptId"/>

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
	    				<td><input type="button" name="button_search" id="button_search" value="Search" class="ui-button-cop" onclick="<portlet:namespace />doSearch('1')"/></td>
					</tr>
				</table>   
				</div>
			</td>
			<td width="20%" align="right" height="20"><input type="button"
							name="button_add" id="button_add" value=" Add " class="ui-button-cop" onclick='<portlet:namespace />doGoPage("${urlAdd}","add")'/>  
			</td>
		</tr>
		 
		<tr>
			<td colspan="2" valign="top"> 
			  <span id="content_element"> 
				</span>
				<%-- 
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
										<img   style="cursor: pointer;" onclick='return <portlet:namespace />doGoPage("${urlEdit}","edit")' src="${url}images/edit.png" width="16"
											height="16" >
											<img style="cursor: pointer;" onclick='return <portlet:namespace />doGoPage("${urlDelete}","delete")' src="${url}images/delete.png" width="16" 
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
				</table>
				 --%>
			</td>
		</tr> 
		<tr> 
			<td width="100%" colspan="2">
				<div class="pagination" id="_pagination">  
				</div>
			</td>
		</tr> 
	</table> 
</form:form>
</body>
</html>