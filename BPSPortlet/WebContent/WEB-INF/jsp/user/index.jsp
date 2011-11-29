<%@include file="../include.jsp"%>
<%@page import="th.co.vlink.xstream.common.VResultMessage"%>
<%@page import="th.co.vlink.utils.Pagging"%>
<%@page import="th.co.vlink.bps.util.Paging"%>
<%@page import="th.co.vlink.bps.form.BpsUserForm"%>
<%@page contentType="text/html; charset=utf-8"%> 
<c:url var="url" value="/" />
<link rel="stylesheet" href="${url}css/jquery-ui/jquery-ui-1.8.custom.css" type="text/css">
<link rel="stylesheet" href="${url}css/ui.selectmenu.css" type="text/css">
<script src='${url}js/jquery-1.6.4.min.js' type="text/javascript"></script>
<script src="${url}css/jquery-ui/jquery-ui-1.8.custom.min.js" type="text/javascript"></script>
<script src='${url}js/ui.selectmenu.js' type="text/javascript"></script>
<script src='${url}js/jquery.highlight-3.js'></script>
<script type="text/javascript"
        src="${url}dwr/interface/BpsUserAjax.js"></script> 
<script type="text/javascript"
        src="${url}dwr/engine.js"></script> 
<script type="text/javascript"
        src="${url}dwr/util.js"></script>
<link rel="stylesheet" type="text/css"
	href="${url}css/style_cos.css" />
<style type="text/css">
.highlight { background-color: yellow }
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
/*demo styles 
body {font-size: 62.5%; font-family:"Verdana",sans-serif; margin: 70px 10px;}
fieldset { border:0;  margin-bottom: 40px;}	
*/
label,select,.ui-select-menu { float: left; margin-right: 10px; }
select { width: 200px; } 
.ui-widget{font-family: Tahoma;font-size: 12px; }
</style>
<script type="text/javascript">
var _range_text=200;
var _pageSizeG=10;
var pageBetweenG=10;
//var _indexSearch="";
String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g,"");
} 
$(document).ready(function() {
	/*
	var higilight_keyword = $("#textfield").val();
	if(higilight_keyword.trim().length > 0) {
		$('._highlight').highlight(higilight_keyword);
	}
	*/
	$("#bptTerm").keypress(function(event) {
	  	  if ( event.which == 13 ) {
	  	     event.preventDefault();
	  	   <portlet:namespace />doSearch(null,'1','asc','BPT_TERM');
	  	   }
	  });
	$("input:button").button();
	//$("input:submit").button(); 
	$('select#searchBy').selectmenu({style:'dropdown'});
	$('select#bpgId').selectmenu({style:'dropdown'}); 
	<portlet:namespace/>initIndexChar();
	<portlet:namespace />doSearch(null,'1','asc','BPT_TERM');
	 
});  
	 
	function <portlet:namespace/>doAction(_mode,_id){ 
			  $("#bptId").val(_id);
			  $("#command").val(_mode);
			  document.bpsUserForm.submit(); 
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
		  //var orderColumn = $("#orderColumn").val();
		  //var orderBy = $("#orderBy").val()=="asc"?"desc":"asc"; 
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
	function <portlet:namespace />doSearch(_indexSearch,_pageIndex,_orderBy,_orderColumn){
		//alert($("#bptlId_H").val()) 
		var pagging={pageSize:_pageSizeG,pageNo:_pageIndex};
		//alert(_orderColumn)
		var bpsTerm;
			var isNumber=true;
			//$("#bptlId_input").val(jQuery.trim($("#bptlId_input").val()));
			//if($("#bptlId_input").val().length>0)
			//	isNumber=<portlet:namespace />isNumber($("#bptlId_input").val());  
	//	 alert($("select[id=bpgId]").val());
		if(isNumber){
			var bptTerm_val=$("#bptTerm").val();
			var indexChar_val=null;
			if(_indexSearch!=null){
				bptTerm_val="";
				indexChar_val=_indexSearch;
				$("#bptTerm").val("");
			}else{
				//indexChar_val="";
			}
				var vcriteria={
						orderBy:_orderBy,
						orderColumn:_orderColumn,
						value:bptTerm_val,
						key:$("select[id=searchBy]").val(),
						indexChar:indexChar_val
				};
			var bpsGroup;
			if($("select[id=bpgId]").val()!="0"){
				bpsGroup={bpgId:$("select[id=bpgId]").val()};
			}else{
				bpsGroup={};
			}
				bpsTerm={
					bptTerm:bptTerm_val,
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
		var str="<table width=\"100%\" id=\"box-table-a\" border=\"0\" cellspacing=\"2\" "+
		"	cellpadding=\"0\" style=\"border: 1px solid #132C00\">"+
		"	<tr>"+
		"		<th width=\"25%\" height=\"25\" align=\"center\" bgcolor=\"#3DB0B5\">Term&nbsp;<a href=\"javascript: <portlet:namespace />doSearch("+((indexChar_val==null)?"null":"'"+indexChar_val+"'")+",'1','asc','BPT_TERM')\"><img "+
		" src=\"${url}images/up.png\"></a><a href=\"javascript: <portlet:namespace />doSearch("+((indexChar_val==null)?"null":"'"+indexChar_val+"'")+",'1','desc','BPT_TERM')\"><img "+
		" src=\"${url}images/down.png\"></a></th>"+
	//	"		<th width=\"26%\" align=\"center\" bgcolor=\"#3DB0B5\">Definition&nbsp;<a href=\"javascript: <portlet:namespace />doSearch("+((indexChar_val==null)?"null":"'"+indexChar_val+"'")+",'1','asc','BPT_DEFINITION_SEARCH')\"><img "+
	//	" src=\"${url}images/up.png\"></a><a href=\"javascript: <portlet:namespace />doSearch("+((indexChar_val==null)?"null":"'"+indexChar_val+"'")+",'1','desc','BPT_DEFINITION_SEARCH')\"><img "+
	//	" src=\"${url}images/down.png\"></a></th>"+
		"		<th width=\"26%\" align=\"center\" bgcolor=\"#3DB0B5\">Definition&nbsp;</th>"+
		"		<th width=\"26%\" align=\"center\" bgcolor=\"#3DB0B5\">Category&nbsp;<a href=\"javascript: <portlet:namespace />doSearch("+((indexChar_val==null)?"null":"'"+indexChar_val+"'")+",'1','asc','BPG_GROUP_NAME')\"><img "+
		" src=\"${url}images/up.png\"></a><a href=\"javascript: <portlet:namespace />doSearch("+((indexChar_val==null)?"null":"'"+indexChar_val+"'")+",'1','desc','BPG_GROUP_NAME')\"><img "+
		" src=\"${url}images/down.png\"></a></th>"+
		"		<th width=\"17%\" align=\"center\" bgcolor=\"#3DB0B5\">Source&nbsp;<a href=\"javascript: <portlet:namespace />doSearch("+((indexChar_val==null)?"null":"'"+indexChar_val+"'")+",'1','asc','BPT_SOURCE')\"><img "+
		" src=\"${url}images/up.png\"></a><a href=\"javascript: <portlet:namespace />doSearch("+((indexChar_val==null)?"null":"'"+indexChar_val+"'")+",'1','desc','BPT_SOURCE')\"><img "+
		" src=\"${url}images/down.png\"></a></th>"+
		"	</tr> ";
		var loadingStr=str+"<tr>"+
		"	<td colspan=\"5\" align=\"center\" height=\"25\" class=\"content\"><img src=\"${url}images/ajax_loading.gif\"/></td>"+
		"</tr></table>"; 
		$("#content_element").html(loadingStr);
		BpsUserAjax.searchBpsTerm(bpsTerm,{
			callback:function(data){
				//alert(data) 
				var pageStr="";
				if(data!=null && data.length==2 && data[0].length>0){ 
					var bpsTerm=data[0];
					var maxSize=data[1]; 
					pageStr= <portlet:namespace/>calculationPaging(indexChar_val,_pageIndex,maxSize,_pageSizeG,pageBetweenG,_orderBy,_orderColumn);
					for(var i=0;i<bpsTerm.length;i++){
						str=str+"<tr valign=\"top\">"+
								"<td><a  style=\"cursor: pointer;\" onclick=\"<portlet:namespace/>doAction('view','"+bpsTerm[i].bptId+"');\"  class=\"team\"><span class=\"_highlight_term\">"+bpsTerm[i].bptTerm+"</span></a></td>"+
								"<td><span class=\"_highlight_def\">"+bpsTerm[i].bptDefinition+"</span></td>"+
								"<td>"+bpsTerm[i].bpsGroup.bpgGroupName+"</td>"+ 
								"<td>"+bpsTerm[i].bptSource+"</td>";
						str=str+"</tr>";
					}  
				}else{
					str=str+"<tr>"+
							"	<td colspan=\"4\" align=\"center\" height=\"25\" class=\"content\">ไม่พบข้อมูล</td>"+
							"</tr>";
				}
				str=str+"</table>";
				$("#content_element").html(str);
				$("#_pagination").html(pageStr); 
				<portlet:namespace />setHighlight();
			}
		}); 
		//substring(_startIndex,_endIndex)
		var _indexChar;
		if(_indexSearch!=null)
			_indexChar=_indexSearch;
		else
			_indexChar=(jQuery.trim(bptTerm_val).length>0)?jQuery.trim(bptTerm_val):"a";
		_indexChar=_indexChar.substring(0,1);
		//if(false)
		<portlet:namespace/>initIndexChar();
		 $('a[class^=team_index_]').each(function(){ 
				var className=$(this).attr("class");  
				if(className.split("_")[2]==_indexChar.toUpperCase()){
					$(this).attr("style","font-style:italic;color: black;text-decoration: none;");
				}
			});
	}
	function <portlet:namespace/>calculationPaging(indexChar_val,_pageIndex,obj_size,_pageSize,pageBetween,_orderBy,_orderColumn){
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
		   pageStr=pageStr+"<li><a href=\"javascript: <portlet:namespace />doSearch("+((indexChar_val==null)?"null":"'"+indexChar_val+"'")+",'1','"+_orderBy+"','"+_orderColumn+"')\" class=\"prevnext\">«</a>&nbsp;</li>"+
		   					"<li><a href=\"javascript: <portlet:namespace />doSearch("+((indexChar_val==null)?"null":"'"+indexChar_val+"'")+",'"+(pageNo-1)+"','"+_orderBy+"','"+_orderColumn+"')\" class=\"prevnext\">previous</a>&nbsp;</li>";
	   for(var k=startIndex;k<=endIndex;k++ ){
		   if(k==pageNo) 
		  	 pageStr = pageStr+"<li><a class=\"currentpage\">"+k+"</a>&nbsp;</li>";
		  else
			 pageStr = pageStr+"<li><a href=\"javascript: <portlet:namespace />doSearch("+((indexChar_val==null)?"null":"'"+indexChar_val+"'")+",'"+k+"','"+_orderBy+"','"+_orderColumn+"')\">"+k+"</a>&nbsp;</li>";
	    } 
	   if(haveNext)
		   pageStr=pageStr+"<li><a href=\"javascript: <portlet:namespace />doSearch("+((indexChar_val==null)?"null":"'"+indexChar_val+"'")+",'"+(pageNo+1)+"','"+_orderBy+"','"+_orderColumn+"')\" class=\"prevnext\">next</a>&nbsp;</li>"+
		   					"<li><a href=\"javascript: <portlet:namespace />doSearch("+((indexChar_val==null)?"null":"'"+indexChar_val+"'")+",'"+pagingScript_pageCount+"','"+_orderBy+"','"+_orderColumn+"')\" class=\"prevnext\">»</a></li>";
	   pageStr=pageStr+"</ul>";
		 
			return pageStr;
	}	
	function <portlet:namespace/>initIndexChar(){
		var indexChar = [ "A", "B", "C", "D", "E", "F", "G", "H", "I",
				"J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U",
				"V", "W", "X", "Y", "Z" ];
		var index_size=indexChar.length;
		var str="";
		for(var i=0;i<index_size;i++){
			str=str+"<a	href='#' class=\"team_index_"+indexChar[i]+"\" onClick=\"<portlet:namespace />doSearch('"+indexChar[i]+"','1','asc','BPT_TERM')\">"+indexChar[i]+"</a>";
		}
		$("#bptIndexChar_content").html(str);
	//	alert(indexChar.length);
		//bptIndexChar_content
	}
</script> 
<portlet:actionURL var="formAction">
    <portlet:param name="action" value="doSubmit"/>
</portlet:actionURL> 
<form:form  modelAttribute="bpsUserForm" name="bpsUserForm" method="post"  action="${formAction}">
<form:hidden path="command" id="command"/> 
<form:hidden path="indexChar" id="indexChar"/>
<form:hidden path="orderColumn" id="orderColumn"/>
<form:hidden path="orderBy" id="orderBy"/>
<form:hidden path="bptId" id="bptId"/>
<table width="100%" align="center" border="0" cellspacing="0"	cellpadding="0">
	<tr>
		<td height="30" colspan="2" align="left"><span
			style="color: #030; font-size: 12px;"><strong>You are
		in:</strong> <a href="/wps/myportal/COS">Home</a> > Banpu Term and Definition</span></td>
	</tr>
	<tr>
		<td colspan="2" height="30" align="left">
		<div class="team" style="padding-left: 10px;" id="bptIndexChar_content">
		</div>
		</td>
	</tr>
	<tr>
		<td width="80%" height="30" align="left">
		<div style="padding-top: 5px;">
		<table cellspacing="5" cellpadding="5">
			<tr>
				<td>
					<strong style="padding-left: 5px;">Search:</strong> 
						<input type="text" id="bptTerm"/> 
				</td>
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
				<td>
					<input type="button" name="button_search" id="button_search" value="Search" onclick="<portlet:namespace />doSearch(null,'1','asc','BPT_TERM')"/>
				
				</td>
			</tr>
		</table>   
		</div>
		</td>
		<td width="20%" height="30" align="right"><a href='<portlet:renderURL><portlet:param name="action" value="viewBpsTerm"/><portlet:param name="bptId" value="0"/><portlet:param name="mode" value="add"/></portlet:renderURL>'><img src="${url}images/btn_requestterm.gif"></a></td>
	</tr>
	<tr>
		<td colspan="2" height="15"></td>
	</tr>
	<tr>
		<td colspan="2" valign="top">
		<span id="content_element"> 
		</span>
		<%--
		<table width="100%" id="box-table-a" border="0" cellspacing="2"
			cellpadding="0" style="border: 1px solid #132C00;">
			<tr>
				<th width="25%" height="25" align="center" bgcolor="#3DB0B5">Term&nbsp;<a href="javascript: sortFunction('bptTerm','asc')"><img
					src="${url}images/up.png"></a><a href="javascript: sortFunction('bptTerm','desc')"><img
					src="${url}images/down.png"></a></th>
				<th width="26%" align="center" bgcolor="#3DB0B5" >Definition&nbsp;<a href="javascript: sortFunction('bptDefinition','asc')"><img
					src="${url}images/up.png"></a><a href="javascript: sortFunction('bptDefinition','desc')"><img
					src="${url}images/down.png"></a></th>
				<th width="26%" align="center" bgcolor="#3DB0B5" >Category&nbsp;<a href="javascript: sortFunction('bpsGroup','asc')"><img
					src="${url}images/up.png"></a><a href="javascript: sortFunction('bpsGroup','desc')"><img
					src="${url}images/down.png"></a></th>
				<th width="17%" align="center" bgcolor="#3DB0B5" >Source&nbsp;<a href="javascript: sortFunction('bptSource','asc')"><img
					src="${url}images/up.png"></a><a href="javascript: sortFunction('bptSource','desc')"><img
					src="${url}images/down.png"></a></th>
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
				<td colspan="4" width="100%" align="right"></td>
			</tr>
			</c:if>
			<c:if test="${resultList.maxRow == 0}">
				<tr>
					<td colspan="4" align="center" height="25" class="content">Data not found.</td>
				</tr>
				<tr><td colspan="4" height="30" align="left"><span style="color: #030; font-size: 12px;">< Back to Home</span></td>
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
