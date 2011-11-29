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
<c:url var="url" value="/" />
<link rel="stylesheet" href="${url}css/jquery-ui/jquery-ui-1.8.custom.css" type="text/css">
<link rel="stylesheet" href="${url}css/ui.selectmenu.css" type="text/css">
<script src='${url}js/jquery-1.6.4.min.js' type="text/javascript"></script>
<script src="${url}css/jquery-ui/jquery-ui-1.8.custom.min.js" type="text/javascript"></script>
<script src='${url}js/ui.selectmenu.js' type="text/javascript"></script>
<link type="text/css" rel="stylesheet"
	href="${url}ckeditor/_samples/sample.css" />
<script type="text/javascript"
	src="${url}ckeditor/ckeditor.js"></script>
<script type="text/javascript"
        src="${url}dwr/interface/BpsLogAjax.js"></script> 
<script type="text/javascript"
        src="${url}dwr/interface/BpsUserAjax.js"></script> 
<script type="text/javascript"
        src="${url}dwr/engine.js"></script> 
<script type="text/javascript"
        src="${url}dwr/util.js"></script>	

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
$(document).ready(function() {
	  // Handler for .ready() called.
	  $("input:button").button();
	  $("input:reset").button(); 
	  $('select#bpgGroupId').selectmenu({style:'dropdown'});
	  var location_href=window.location.href;
	  if(location_href.indexOf("?id=")!=-1){
		  location_href=location_href.split("?");
		  var param=location_href[1].split("&");
		  var id=param[0].split("=")[1];
		  var mode=param[1].split("=")[1];
		  <portlet:namespace/>loadContent(id,mode);
	  }
});
	String.prototype.trim = function() {
		return this.replace(/^\s+|\s+$/g,"");
	}

	function selectDetail(input) {
		if(input == 'revisedDiv') {
			document.getElementById('proposedDiv').style.display = 'none';
			document.getElementById('revisedDiv').style.display = '';
			document.getElementById('proposedLink').style.color = 'blue';
			document.getElementById('revisedLink').style.color = 'gray';
		} else {
			document.getElementById('revisedDiv').style.display = 'none';
			document.getElementById('proposedDiv').style.display = '';
			document.getElementById('proposedLink').style.color = 'gray';
			document.getElementById('revisedLink').style.color = 'blue';
		}
	}
	function <portlet:namespace/>loadContent(id,mode){  
		BpsLogAjax.findBpsTermLogById(id,{
			callback:function(data){
				if(data!=null){
					var  str=""+
					"<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"	align=\"center\" style=\"background-color: #FFF;\">"+
					" <tr>"+
					"	<td>"+
					"		<table width=\"100%\" border=\"0\" cellspacing=\"2\" cellpadding=\"0\">"+
					"			<tr>"+
					"				<td>"+
					"				<form action=\"\" method=\"get\">"+
					"					<table width=\"100%\" border=\"0\" cellspacing=\"3\" cellpadding=\"0\">"+
					"						<tr>"+
					"							<td height=\"30\" colspan=\"2\" align=\"left\""+
					"								style=\"background-color: #132C00; font-weight: bold; color: #FFF;\">&nbsp;"+
					""+((mode=="request_new")?"Request for New Term":"Comment to COS")+"</td>"+
					"						</tr>"+
					"						<tr>"+
					"							<td width=\"19%\" height=\"19\" class=\"h_achieve\" align=\"left\">To:</td>"+
					"							<td width=\"81%\"><label> <input name=\"mailTo\""+
					"									type=\"text\" id=\"mailTo\" value=\"COS Staff\" size=\"50\""+
					"									class=\"readonly\" disabled=\"disabled\"> </label>"+
					"							</td>"+
					"						</tr>"+
					"						<tr>"+
					"							<td class=\"h_achieve\" align=\"left\">From:</td>"+
					"							<td><input name=\"mailFrom\" type=\"text\""+
					"								class=\"readonly\" id=\"mailFrom\" value=\""+data.bptMailForm+"\" size=\"50\""+
					"								disabled=\"disabled\">"+
					"							</td>"+
					"						</tr>"+
					"						<tr>"+
					"							<td class=\"h_achieve\" align=\"left\">Subject:</td>"+
					"							<td><input name=\"mailSubject\" type=\"text\" id=\"mailSubject\""+
					"								size=\"50\" class=\"readonly\" disabled=\"disabled\" value=\""+data.bptMaiilSubject+"\"/>"+
					"							</td>"+
					"						</tr>"+
					"						<tr>"+
					"							<td colspan=\"2\"><hr>"+
					"							</td>"+
					"						</tr>"+
					"						<tr>"+
					"							<td class=\"h_achieve\" align=\"left\">Term:</td>"+
					"							<td align=\"left\"><input name=\"term\" type=\"text\" id=\"term\""+
					"								value=\""+data.bptTerm+"\" size=\"50\" class=\"readonly\""+
					"								disabled=\"disabled\"/>"+
					"							</td>"+
					"						</tr>"+
					"						<tr>"+
					"							<td class=\"h_achieve\" align=\"left\">Category:</td>"+
					"							<td align=\"left\"><input name=\"cate\" type=\"text\" id=\"cate\""+
					"								value=\""+data.bpsGroup.bpgGroupName+"\" size=\"50\" class=\"readonly\""+
					"								disabled=\"disabled\"/>"+
					"							</td>"+
					"						</tr>"+
					"						<tr valign=\"\"top\">"+
					"							<td class=\"h_achieve\" align=\"left\">Source / Reference:</td>"+
					"							<td align=\"left\"><input name=\"bptSource\" type=\"text\" id=\"bptSource\" value=\""+data.bptSource+"\""+ 
					"								size=\"50\"/>"+
					"							</td>"+
					"						</tr>"+
					"						<tr valign=\"top\">"+
					"							<td class=\"h_achieve\" align=\"left\">Definition:</td>"+
					"							<td align=\"left\"><textarea name=\"shortDesc\" id=\"shortDesc\""+
					"								cols=\"80\" rows=\"3\">"+data.bptShortDesc+"</textarea>"+
					"							</td>"+
					"						</tr>"+ 
					"						<tr>"+
					"							<td class=\"h_achieve\" align=\"left\" valign=\"top\">Detail:</td>"+
					"							<td align=\"left\"> "+
					"						<span style=\"padding: 5px;\"><textarea cols=\"50\" id=\"editor1\" name=\"editor1\" rows=\"10\">"+data.bptDefinition+"</textarea></span>"+
					"							</td>"+
					"						</tr>"+
					"						<tr>"+
					"							<td>&nbsp;</td>"+
					"							<td>&nbsp;</td>"+
					"						</tr>"+
					"						<tr>"+
					"							<td>&nbsp;</td>"+
					"							<td align=\"left\"><label>   </label>"+
					"							</td>"+
					"						</tr>"+
					"					</table>"+
					//"					<input name=\"userCreate\" type=\"hidden\" id=\"userCreate\" value=\""+obj+"\">"+
					"				</form>"+
					"			</td>"+
					"		</tr>"+
					"	</table></td>"+
				"</tr>"+
				"<tr>"+
				"<td height=\"30\">"+ 
			
				"</td>"+
			"</tr>"+
			"</table>";
				}else{
					 
				}
				$("#content_element").html(str); 
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
</head>
<body> 
<form action="" method="post">
<input type="hidden" id="bptlId_H" value="">
</form>
<span id="content_element"></span> 
</body>
</html>