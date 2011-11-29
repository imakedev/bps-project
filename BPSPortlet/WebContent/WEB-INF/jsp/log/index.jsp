<%@include file="../include.jsp" %>
<%@page contentType="text/html; charset=utf-8"%>
<html>
<head>
<c:url var="url" value="/" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${url}css/jquery-ui/jquery-ui-1.8.custom.css" type="text/css">
<script src='${url}js/jquery-1.6.4.min.js' type="text/javascript"></script>
<script src="${url}css/jquery-ui/jquery-ui-1.8.custom.min.js" type="text/javascript"></script>
<script type="text/javascript"
        src="${url}dwr/interface/BpsLogAjax.js"></script> 
<script type="text/javascript"
        src="${url}dwr/engine.js"></script> 
<script type="text/javascript"
        src="${url}dwr/util.js"></script>
<link rel="stylesheet" type="text/css"
	href="${url}css/style_cos.css" />
<title>Insert title here</title>
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
<script>
var _pageSizeG=10;
var pageBetweenG=10;
$(document).ready(function() {
	 $("input:button").button();
	$("#bptlId_input").keypress(function(event) {
  	  if ( event.which == 13 ) {
  	     event.preventDefault();
  	   <portlet:namespace />doSearch('doSearch','1');
  	   }
  });
	var location_href=window.location.href;
  if(location_href.indexOf("?id=")!=-1){
	  var id=location_href.split("?id=")[1];
	  $("#bptlId_H").val(id);
	  $("#bptlId_input").val(id);
  }
	<portlet:namespace />doSearch('init','1');
});
function <portlet:namespace/>isNumber(n) {
	  return !isNaN(parseFloat(n)) && isFinite(n);
}
function goToPage(_url){
	//alert(_url)
	window.location.href=_url;
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
	   pageStr=pageStr+"<li><a href=\"javascript: <portlet:namespace />doSearch('doSearch','1')\" class=\"prevnext\">«</a>&nbsp;</li>"+
	   					"<li><a href=\"javascript: <portlet:namespace />doSearch('doSearch','"+(pageNo-1)+"')\" class=\"prevnext\">previous</a>&nbsp;</li>";
   for(var k=startIndex;k<=endIndex;k++ ){
	   if(k==pageNo) 
	  	 pageStr = pageStr+"<li><a class=\"currentpage\">"+k+"</a>&nbsp;</li>";
	  else
		 pageStr = pageStr+"<li><a href=\"javascript: <portlet:namespace />doSearch('doSearch','"+k+"')\">"+k+"</a>&nbsp;</li>";
    } 
   if(haveNext)
	   pageStr=pageStr+"<li><a href=\"javascript: <portlet:namespace />doSearch('doSearch','"+(pageNo+1)+"')\" class=\"prevnext\">next</a>&nbsp;</li>"+
	   					"<li><a href=\"javascript: <portlet:namespace />doSearch('doSearch','"+pagingScript_pageCount+"')\" class=\"prevnext\">»</a></li>";
   pageStr=pageStr+"</ul>";
	 
		return pageStr;
}
function <portlet:namespace/>doAction(_mode,_id){
  if(_mode=='delete'){
	$( "#dialog-message" ).html("Would you like to delete ?");
	$( "#dialog-message" ).dialog({
		title:"Delete Log",
		modal: true,
		show: 'slide' ,
		//hide: "explode",
		buttons: [
			          {
		              text: "Ok",
		              click: function() {  
		            	  $(this).dialog("close");
		            	  $(this).dialog( "destroy" );
		            	  BpsLogAjax.deleteBpsTermLog(_id,{
		      				callback:function(data){ 
				            	<portlet:namespace />doSearch('doSearch','1');
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
	  $("#bptlId").val(_id);
	  document.bpsAdminLogForm.submit();
  }
}
function <portlet:namespace />doSearch(_mode,_pageIndex){
	//alert($("#bptlId_H").val()) 
	var pagging={pageSize:_pageSizeG,pageNo:_pageIndex};
	//alert(pageStr)
	var bpsTermLog;
	if(_mode=='init'){
		var init_bptlId=($("#bptlId_H").val()!=null && $("#bptlId_H").val()!='null')?$("#bptlId_H").val():"";
		bpsTermLog={bptlId:init_bptlId,pagging:pagging};
	}else{
		var isNumber=true;
		$("#bptlId_input").val(jQuery.trim($("#bptlId_input").val()));
		if($("#bptlId_input").val().length>0)
			isNumber=<portlet:namespace />isNumber($("#bptlId_input").val());
		if(isNumber)
			bpsTermLog={bptlId:$("#bptlId_input").val(),pagging:pagging};
		else{
			$( "#dialog-message" ).html("Please insert numeric ");
			$( "#dialog-message" ).dialog({
				title:"Message ",
				modal: true,
				show: 'slide' ,
				//hide: "explode",
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
	}
	var str="<table width=\"100%\" id=\"box-table-a\" border=\"0\" cellspacing=\"2\" "+
	"	cellpadding=\"0\" style=\"border: 1px solid #132C00\">"+
	"	<tr>"+
	"		<th width=\"6%\" height=\"25\" align=\"center\" bgcolor=\"#132C00\" style=\"color:#FFF;\">Log id</th>"+
	"		<th width=\"25%\" height=\"25\" align=\"center\" bgcolor=\"#132C00\" style=\"color:#FFF;\">Term</th>"+
	"		<th width=\"26%\" align=\"center\" bgcolor=\"#132C00\" style=\"color:#FFF;\">Definition</th>"+
	"		<th width=\"20%\" align=\"center\" bgcolor=\"#132C00\" style=\"color:#FFF;\">Category</th>"+
	"		<th width=\"17%\" align=\"center\" bgcolor=\"#132C00\" style=\"color:#FFF;\">Source</th>"+
	"		<th width=\"6%\" align=\"center\" bgcolor=\"#132C00\" style=\"color:#FFF;\">&nbsp;</th>"+
	"	</tr> ";
	var loadingStr=str+"<tr>"+
	"	<td colspan=\"6\" align=\"center\" height=\"25\" class=\"content\"><img src=\"${url}images/ajax_loading.gif\"/></td>"+
	"</tr></table>"; 
	$("#content_element").html(loadingStr);
	BpsLogAjax.searchBpsTermLog(bpsTermLog,{
		callback:function(data){
			//alert(data) 
			var pageStr="";
			if(data!=null && data.length==2 && data[0].length>0){ 
				var bpsTerm=data[0];
				var maxSize=data[1]; 
				pageStr= <portlet:namespace/>calculationPaging(_pageIndex,maxSize,_pageSizeG,pageBetweenG);
				for(var i=0;i<bpsTerm.length;i++){
					str=str+"<tr valign=\"top\">";
					str=str+"<td><span style=\"cursor: pointer;\" onclick=\"<portlet:namespace/>doAction('view','"+bpsTerm[i].bptlId+"');\">"+bpsTerm[i].bptlId+"</span></td>"+
							"<td>"+bpsTerm[i].bptTerm+"</td>"+
							"<td>"+bpsTerm[i].bptDefinition+"</td>"+
							"<td>"+bpsTerm[i].bpsGroup.bpgGroupName+"</td>"+ 
							"<td>"+bpsTerm[i].bptSource+"</td>"+
							"<td align=\"center\">"+
						//	"<img style=\"cursor: pointer;\" onclick=\"<portlet:namespace/>doAction('view','"+bpsTerm[i].bptlId+"');\" src=\"${url}images/edit.png\" width=\"16\" height=\"16\" >"+
							"<img style=\"cursor: pointer;\" onclick=\"<portlet:namespace/>doAction('delete','"+bpsTerm[i].bptlId+"');\"  src=\"${url}images/delete.png\" width=\"16\"	height=\"16\"></td>"; 
					str=str+"</tr>";
				}  
			}else{
				str=str+"<tr>"+
						"	<td colspan=\"6\" align=\"center\" height=\"25\" class=\"content\">ไม่พบข้อมูล</td>"+
						"</tr>";
			}
			str=str+"</table>";
			$("#content_element").html(str);
			$("#_pagination").html(pageStr); 
			
		}
	}); 
}
</script>
</head>
<body>
<div id="dialog-message" title="Message">
	<p>
		 
	</p>
</div>
<portlet:actionURL var="formAction">
    <portlet:param name="action" value="doSubmit"/>
</portlet:actionURL> 
<form:form  modelAttribute="bpsAdminLogForm" name="bpsAdminLogForm" method="post"  action="${formAction}">
<form:hidden path="command" id="command"/>
<form:hidden path="bptlId" id="bptlId"/>
<input type="hidden" id="bptlId_H" value="<%=request.getParameter("id")%>"/> 
<table width="100%" align="center" border="0" cellspacing="0"
		cellpadding="0">
		<tr> 
			<td height="30" colspan="2"><span
				style="color: #030; font-size: 12px;"><strong>You
						are in:</strong> Home >> Banpu term and definition >> Comment & Request Notification </span>
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
						<td><strong style="padding-left: 5px;">Search (Log id):</strong><input type="text" id="bptlId_input"/> </td>
						<td>
							 <input type="button" name="button_search" id="button_search" value="Search" onClick="<portlet:namespace />doSearch('doSearch','1')"/>
	    				</td>
	    				<td>
	    					 
	    				</td>
	    				<td></td>
					</tr>
				</table>   
				</div>
			</td>
			<td width="20%" align="right" height="20">  
			</td>
		</tr> 
		<tr>
			<td colspan="2" valign="top"> 
			    <span id="content_element"> 
				</span>
			</td>
		</tr>
		<tr>
			<td colspan="2" valign="top">
				<div class="pagination" id="_pagination"> 
				</div>
			</td>
		</tr>
	</table>
</form:form>
</body>
<script> 
</script>
</html>