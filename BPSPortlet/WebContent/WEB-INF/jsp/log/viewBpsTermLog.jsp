<%@include file="../include.jsp"%>
<%@page contentType="text/html; charset=utf-8"%>
<html>
<head>
<c:url var="url" value="/" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src='${url}js/jquery-1.6.4.min.js'></script>
<script src='${url}js/jquery.highlight-3.js'></script>
<script type="text/javascript" src="${url}js/tabber.js"></script>
<script type="text/javascript" src="${url}js/jquery.dateFormat-1.0.js"></script>
<link type="text/css" rel="stylesheet"
	href="${url}ckeditor/_samples/sample.css" />
<script type="text/javascript"
	src="${url}ckeditor/ckeditor.js"></script>
<script type="text/javascript"
        src="${url}dwr/interface/BpsLogAjax.js"></script> 
<script type="text/javascript"
        src="${url}dwr/engine.js"></script> 
<script type="text/javascript"
        src="${url}dwr/util.js"></script>
<link rel="stylesheet" href="${url}css/example.css" TYPE="text/css"
					MEDIA="screen"> 
<title>Insert title here</title>
<script>
$(document).ready(function() { 
	//alert($("#bptlId_H").val());
	<portlet:namespace/>loadContent();
});
function <portlet:namespace/>loadContent(){  
	var img_loading="<img id=\"loading_ajax\" src=\"${url}images/ui-anim_basic_16x16.gif\"/>";
	var str_error="<strong>Have Error</strong>";	
	var str_term;
	var str_cate;
	var str="<table width=\"100%\" id=\"box-table-a\" border=\"0\" cellspacing=\"2\" cellpadding=\"0\" style=\"border: 1px solid #132C00\">";
	var loading_str=str+"<tr>"+
						"	<td  align=\"center\">"+
						"		<img src=\"${url}images/ajax_loading.gif\"/>"+						
						"	</td>"+
						"</tr></table>";
	$("#_element_content").html(loading_str);
	$("#_element_term").html(img_loading);
	$("#_element_cate").html(img_loading);
	BpsLogAjax.findBpsTermLogById($("#bptlId_H").val(),{
		callback:function(data){
			if(data!=null){
				str=str+"<tr>"+
						"	<th height=\"25\" align=\"left\" bgcolor=\"#3DB0B5\"><span style=\"padding-left: 5px;\">"+data.bptTerm+"</span>"+
						"	</th>"+
						"</tr>"+
						"<tr>"+
						"	<td width=\"25%\"><span style=\"padding: 5px;\">"+data.bptShortDesc+"</span>"+
						"	</td>"+
						"</tr>"+
						"<tr>"+
						"	<td width=\"25%\"><span style=\"padding: 5px;\"><textarea cols=\"50\" id=\"editor1\" name=\"editor1\" rows=\"10\">"+data.bptDefinition+"</textarea></span>"+
						"	</td>"+
						"</tr>";
				str_term="<strong>You are in:</strong>"+
						"	<a href=\""+$("#homeURL").val()+"\">Home</a> > BANPU Term and Definition > "+data.bptTerm+"";
				str_cate="<strong>Category:</strong>"+
						 ""+data.bpsGroup.bpgGroupName+" | <strong>Source:</strong> "+data.bptSource+" |<strong>Updated: </strong>"+$.format.date(data.bptCreateDate,"dd~MM~yyyy hh:mm:ss")+" <strong>by</strong> "+data.bptCreateBy+"";
			}else{
				str=str+"<tr>"+
				"	<th height=\"25\" align=\"left\" bgcolor=\"#3DB0B5\">"+
				"		Have Error "+
				"	</th>"+
				"</tr>";
				str_term=str_error;
				str_cate=str_error;
			}
			str=str+"</table>";
			$("#_element_content").html(str);
			$("#_element_term").html(str_term);
			$("#_element_cate").html(str_cate); 
			<portlet:namespace/>initEditor();
		}
	});
	
}
function <portlet:namespace/>initEditor(){ 
	CKEDITOR.replace('editor1', { 
toolbar : [
			{ name: 'document', items : [ 'Source','-','Preview','-'] }, 
			{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike',] },
			{ name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ] },
			{ name: 'links', items : [ 'Link','Unlink'] },
			{ name: 'insert', items : [ 'Image','Table','HorizontalRule','Smiley','SpecialChar','PageBreak' ] },
			'/',
			{ name: 'styles', items : [ 'Styles','Format','Font','FontSize' ] },
			{ name: 'colors', items : [ 'TextColor','BGColor' ] } 
		]
	}); 
}
function <portlet:namespace/>downloadFile(_hotLink){ 
 //	var src = "http://localhost:8081/BPSDownloadServlet/DownloadServlet?"+_hotLink;
 	var src = "http://10.2.0.94:10000/BPSDownloadServlet/DownloadServlet?"+_hotLink; 
    var div = document.createElement("div");
    document.body.appendChild(div);
    div.innerHTML = "<iframe width='0' height='0' scrolling='no' frameborder='0' src='" + src + "'></iframe>";
	  // Create an IFRAME.
	//var _form =document.getElementById('downloadAdminform');
 	//_form.submit();
} 
</script>
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
</head> 
<portlet:renderURL var="homeURL">
    <portlet:param name="action" value="list"/>
</portlet:renderURL>
<body>
<form action="post">
<input type="hidden" id="bptlId_H" value="${bptlId}">
<input type="hidden" id="homeURL" value="${homeURL}">
<table width="950" align="center" border="0" cellspacing="0" cellpadding="0">
 <tr>
	<td>&nbsp;</td>
	<td align="right">&nbsp;</td>
 </tr>
 <tr>
    <td height="30" colspan="2"><span style="color:#030; font-size:12px;" id="_element_term"></span></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td align="right"></td>
  </tr>
 <tr>
    <td height="30" colspan="2"><span style="color:#030; font-size:12px;" id="_element_cate"></span></td>
  </tr>
  <tr>
    <td height="30" align="right" colspan="2"><span style="color:#030; font-size:12px;"></span></td>
  </tr> 
		<tr>
			<td colspan="2" valign="top">
				<span id="_element_content"></span>
				
			</td>
		</tr> 
</table>
</form>
</body>
</html>