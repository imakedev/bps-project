<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:url var="url" value="/" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script	src='${url}dwr/interface/KMVideoAjax.js'></script>
<script src='${url}dwr/engine.js'></script>
<script src='${url}dwr/util.js'></script>
<%-- 
<script src="http://ajax.googleapis.com/ajax/libs/dojo/1.6.1/dojo/dojo.xd.js" type="text/javascript"></script>
--%>  
<link rel="stylesheet" type="text/css" href='${url}css/style_photo.css'/>
<script>
	var _user_id="<%=request.getUserPrincipal().getName()%>@pttep.com";
	var _path="${url}";
	var _keyword="";
	var pageBetween=10;
	var pageSizeG=5;
//	alert(_user_id)
	function goto_media_page(_pmcateId){
		//window.location.href="";
		var command = document.getElementById("command");
		var pmcateId = document.getElementById("pmcateId");
		command.value="viewCategory";
		pmcateId.value=_pmcateId;
	//document.getElementById('videoFrom').submit();
		//document.categoryAdminForm.submit()
		//document.forms[0].submit();
		//document.forms["videoFrom"].submit();
		//alert("go go");
		document.forms.videoFrom.submit();
	}
	function goto_page(url){
		window.location.href=url;
	}
	function test(){
		//alert("test")
		var command = document.getElementById("command");
		//	var pmcateId = document.getElementById("pmcateId");
			command.value="viewCategory";
		return true;
	}
	function loadCateByPaging(_pageIndex,_pageSize,_type,_elementId){
		//alert("_pageIndex="+_pageIndex+",_pageSize="+_pageSize+",_type="+_type+",_elementId="+_elementId);
		var keyword = document.getElementById("keyword").value;
		_keyword= keyword; 
		var cate={ 
				pmcateName:keyword,
				pttepMediaType:{pmtId:_type},
				paging:{pageNo:_pageIndex,pageSize:_pageSize},
				userRequest:_user_id
				}; 
		KMVideoAjax.searchPttepMediaCateByPaging(cate,{
			 callback:function(data){ 
				 if(data!=null){
					 document.getElementById(_elementId).innerHTML="";
						var objs=data[0];
						var obj_size=data[1];
						var _thumbnail="";
						var str="<td colspan=\"5\"><table align=\"left\" cellspacing=\"15\" cellpadding=\"0\" ><tr>";
						if(objs!=null && objs.length>0){
							for(var j=0;j<objs.length;j++)
							{
								if(objs[j].pmcCoverEntryId!=null && objs[j].pmcCoverEntryId.length>0)
									_thumbnail="<img  style=\"cursor: pointer;\" onClick=\"goto_media_page('"+objs[j].pmcateId+"')\" src=\"http://hq-kmvd1.pttep.com/p/101/sp/10100/thumbnail/entry_id/"+objs[j].pmcCoverEntryId+"\"  width=\"155\" height=\"100\" border=\"0\" />";
								else
									_thumbnail="<img  style=\"cursor: pointer;\" onClick=\"goto_media_page('"+objs[j].pmcateId+"')\" src=\""+_path+"/images/Thumbnail.jpg\"  width=\"155\" height=\"100\" border=\"0\" />";
								str=str+"<td width=\"235px\" align=\"center\" style=\"padding-top: 20px;\">"+
										" <div style=\"width:155px;\" >"+									 
										""+_thumbnail+							 
										" </div>"+
										" <br/>"+
										" <div>"+
										" <strong>"+
										"	<span style=\"cursor: pointer;text-decoration: underline;\" onClick=\"goto_media_page('"+objs[j].pmcateId+"')\">"+objs[j].pmcateName+"</span>"+
										" </strong>["+objs[j].pttepMediaPermission.pmpName+"]<br>"+objs[j].totalsEntry+"  Videos"+
										" </div>"+
										"</td>";
								cate=objs[j].pttepMediaType.pmtDesc;								 
							}
							str=str+"</tr></table></td>";
							str="<table align=\"left\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"padding-top: 40px;\">"+
							 "	<tr>"+
							 "		<td height=\"25\" colspan=\"5\" style=\"border-bottom: #06C 2px dotted;padding-left: 10px;\">"+
							 "			<strong class=\"h_photo\">"+
							 "				"+cate+"	"+
							 "			</strong"+
							 "		</td>"+
							 "	</tr>"+
							 "	<tr>"+str;
					var pagingScript_recordCount=parseInt(obj_size, 10);;//totalRecord;
					var pagingScript_recordPerPage=parseInt(_pageSize,10);//pageSize;//RECORD_PERPAGE;
					       		
					var plus = pagingScript_recordCount%pagingScript_recordPerPage!=0?1:0;
					var pagingScript_pageCount=parseInt((pagingScript_recordCount/pagingScript_recordPerPage),10)+plus;
					var pageNo=parseInt(_pageIndex,10);
					var startIndex =pageNo-parseInt((pageBetween/2),10);
					var endIndex = pageNo+(parseInt((pageBetween/2),10)-1); 
					//alert("startIndex="+startIndex)
					var page_plus=pageBetween-((endIndex-startIndex)+1);
						endIndex=endIndex+page_plus;
					var lock_start=pagingScript_pageCount-pageBetween+1;
					var lock_end=pageBetween;
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
			    	   pageStr=pageStr+"<li><a href=\"javascript: loadCateByPaging('1' , '"+pageSizeG+"','"+_type+"','"+_elementId+"')\" class=\"prevnext\">« First</a></li>"+
			    	   					"<li><a href=\"javascript: loadCateByPaging('"+(pageNo-1)+"' , '"+pageSizeG+"','"+_type+"','"+_elementId+"')\" class=\"prevnext\">« Previous</a></li>";
				   for(var k=startIndex;k<=endIndex;k++ ){
					   if(k==pageNo) 
					  	 pageStr = pageStr+"<li><a class=\"currentpage\">"+k+"</a></li>";
					  else
						 pageStr = pageStr+"<li><a href=\"javascript: loadCateByPaging('"+k+"' , '"+pageSizeG+"','"+_type+"','"+_elementId+"')\">"+k+"</a></li>";
				    }
				   if(haveNext)
			    	   pageStr=pageStr+"<li><a href=\"javascript: loadCateByPaging('"+(pageNo+1)+"' , '"+pageSizeG+"','"+_type+"','"+_elementId+"')\" class=\"prevnext\">Next »</a></li>"+
			    	   					"<li><a href=\"javascript: loadCateByPaging('"+pagingScript_pageCount+"' , '"+pageSizeG+"','"+_type+"','"+_elementId+"')\" class=\"prevnext\">Last »</a></li>";
				   pageStr=pageStr+"</ul>";
					str=str+"</tr>"+
									"<tr>"+
									"	<td colspan=\"5\">&nbsp;</td>"+
									"</tr>"+
									"<tr>"+
									"	<td align=\"left\" style=\"padding-left: 10px;\">"+
									"		<strong>Total:</strong>"+
									"			"+obj_size+" Categories"+
									"	</td>"+
									"	<td align=\"right\" style=\"padding-right: 10px;\" colspan=\"4\">"+
									"		<div class=\"pagination\">"+ pageStr+ 
									"		</div>"+
									"	</td>"+
									"</tr>"+
								"</table>";
							document.getElementById(_elementId).innerHTML=str;
						}
				 }
			 }
			});
		
	}	function loadCate(_pageIndex,_pageSize,_type){
		//alert(_pageIndex)
		var keyword = document.getElementById("keyword").value;
		var pmtId = document.getElementById("pmtId").value;
		_keyword= keyword;
		 
		var cate={ 
				pmcateName:keyword,
				pttepMediaType:{pmtId:pmtId},
				paging:{pageNo:_pageIndex,pageSize:_pageSize},
				userRequest:_user_id
				}; 
		KMVideoAjax.searchPttepMediaCate(cate,{
			 callback:function(data){ 
				 if(data!=null){
					 //alert(data)
					//if(pmtId=='0'){ // set all element , size =3
						document.getElementById("mediaCopElement").innerHTML="";
						document.getElementById("mediaCoiElement").innerHTML="";
						document.getElementById("mediaMyPersonalElement").innerHTML="";
						for(var i=0;i<data.length;i++){
							var objs_outer=data[i];
							var cate="";
							var elementId="" ; 
							var elementType=0; 
							var objs=objs_outer[0];
							var obj_size=objs_outer[1];
							var _thumbnail="";
							//alert("obj_size="+objs.length);
							var str="<td colspan=\"5\"><table align=\"left\" cellspacing=\"15\" cellpadding=\"0\" ><tr>";
						if(objs!=null && objs.length>0){
							for(var j=0;j<objs.length;j++)
							{
								if(objs[j].pmcCoverEntryId!=null && objs[j].pmcCoverEntryId.length>0)
									_thumbnail="<img  style=\"cursor: pointer;\" onClick=\"goto_media_page('"+objs[j].pmcateId+"')\" src=\"http://hq-kmvd1.pttep.com/p/101/sp/10100/thumbnail/entry_id/"+objs[j].pmcCoverEntryId+"\"  width=\"155\" height=\"100\" border=\"0\" />";
								else
									_thumbnail="<img  style=\"cursor: pointer;\" onClick=\"goto_media_page('"+objs[j].pmcateId+"')\" src=\""+_path+"/images/Thumbnail.jpg\"  width=\"155\" height=\"100\" border=\"0\" />";
							//	str=str+"<td width=\"20%\" align=\"center\" style=\"padding-top: 20px;\">"+
								str=str+"<td width=\"235px\" align=\"center\" style=\"padding-top: 20px;\">"+
										" <div style=\"width:155px;\" >"+									 
										""+_thumbnail+							 
										" </div>"+
										" <br/>"+
										" <div>"+
										" <strong>"+
										"	<span style=\"cursor: pointer;text-decoration: underline;\" onClick=\"goto_media_page('"+objs[j].pmcateId+"')\">"+objs[j].pmcateName+"</span>"+
										" </strong>["+objs[j].pttepMediaPermission.pmpName+"]<br>"+objs[j].totalsEntry+"  Videos"+
										" </div>"+
										"</td>";
								cate=objs[j].pttepMediaType.pmtDesc;
								var pmtId_result=objs[j].pttepMediaType.pmtId;
								elementType=pmtId_result;
								if(pmtId_result==1){
									elementId="mediaCopElement";
								}else if(pmtId_result==2){
									//cate="My Personal";
									elementId="mediaCoiElement";
								}else if(pmtId_result==3){
									//cate="My Personal";
									elementId="mediaMyPersonalElement";
								}
							}
							str=str+"</tr></table></td>";
							str="<table align=\"left\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"padding-top: 40px;\">"+
							//str="<table align=\"left\"   cellspacing=\"0\" cellpadding=\"0\" style=\"padding-top: 40px;\">"+
							 "	<tr>"+
							 "		<td height=\"25\" colspan=\"5\" style=\"border-bottom: #06C 2px dotted;padding-left: 10px;\">"+
							 "			<strong class=\"h_photo\">"+
							 "				"+cate+"	"+
							 "			</strong"+
							 "		</td>"+
							 "	</tr>"+
							 "	<tr>"+str;
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
				  //  alert("page_plus="+page_plus+",have Prev = "+havePrev+",have Next = "+haveNext+",startIndex = "+startIndex+
				  //  		",endIndex = "+endIndex+",max page = "+pagingScript_pageCount+",pageNo = "+pageNo);
				   // alert(elementId)
					var pageStr="<ul>";
			       if(havePrev)
			    	   pageStr=pageStr+"<li><a href=\"javascript: loadCateByPaging('1' , '"+pageSizeG+"','"+elementType+"','"+elementId+"')\" class=\"prevnext\">« First</a></li>"+
			    	   					"<li><a href=\"javascript: loadCateByPaging('"+(pageNo-1)+"' , '"+pageSizeG+"','"+elementType+"','"+elementId+"')\" class=\"prevnext\">« Previous</a></li>";
				   for(var k=startIndex;k<=endIndex;k++ ){
					   if(k==pageNo) 
					  	 pageStr = pageStr+"<li><a class=\"currentpage\">"+k+"</a></li>";
					  else
						 pageStr = pageStr+"<li><a href=\"javascript: loadCateByPaging('"+k+"' , '"+pageSizeG+"','"+elementType+"','"+elementId+"')\">"+k+"</a></li>";
				    }
				   if(haveNext)
			    	   pageStr=pageStr+"<li><a href=\"javascript: loadCateByPaging('"+(pageNo+1)+"' , '"+pageSizeG+"','"+elementType+"','"+elementId+"')\" class=\"prevnext\">Next »</a></li>"+
			    	   					"<li><a href=\"javascript: loadCateByPaging('"+pagingScript_pageCount+"' , '"+pageSizeG+"','"+elementType+"','"+elementId+"')\" class=\"prevnext\">Last »</a></li>";
				   pageStr=pageStr+"</ul>";
					str=str+"</tr>"+
									"<tr>"+
									"	<td colspan=\"5\">&nbsp;</td>"+
									"</tr>"+
									"<tr>"+
									"	<td align=\"left\" style=\"padding-left: 10px;\">"+
									"		<strong>Total:</strong>"+
									"			"+obj_size+" Categories"+
									"	</td>"+
									"	<td align=\"right\" style=\"padding-right: 10px;\" colspan=\"4\">"+
									"		<div class=\"pagination\">"+ pageStr+
								/*
									"			<ul>"+
									"				<li><a href=\"javascript: loadCateByPaging('1' , '5')\" class=\"prevnext disablelink\">« First</a></li>"+
									"				<li><a href=\"javascript: loadCateByPaging('1' , '5')\" class=\"prevnext disablelink\">« Previous</a></li>"+
									"				<li><a href=\"javascript: loadCateByPaging('1' , '5')\" class=\"currentpage\">1</a></li>"+
									"				<li><a href=\"javascript: loadCateByPaging('1' , '5')\">2</a></li>"+
									"				<li><a href=\"javascript: loadCateByPaging('1' , '5')\" class=\"prevnext\">Next »</a></li>"+
									"				<li><a href=\"javascript: loadCateByPaging('1' , '5')\" class=\"prevnext\">Last »</a></li>"+
									"			</ul>"+
									*/
									"		</div>"+
									"	</td>"+
									"</tr>"+
								"</table>";
							//	alert(str)
							document.getElementById(elementId).innerHTML=str;
						}
					}
				 
				 }
			 }
		});
	}
	dojo.ready(function(){
		//alert("aa") 
		loadCate('1','5','0');
		  
    });
</script></head>
<body>
<portlet:renderURL var="urlManage">
	<portlet:param name="action" value="manageCategory"/>
</portlet:renderURL>
<portlet:actionURL var="formAction"><portlet:param name="action" value="doSubmit"/></portlet:actionURL> 
<form:form  name="videoFrom" modelAttribute="videoFrom" method="POST" action="${formAction}">
<form:hidden path="command" id="command"/>
<form:hidden path="pmcateId" id="pmcateId"/>  
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="20%">You are in: My Video</td>
				  	<td width="80%" align="right">				  	  
					    <label>
					    <%--
					    ${fn:escapeXml(url1)}
					     --%>
					    	<input  type="button" name="button" id="button" value="Manage Category" onClick='goto_page("${fn:escapeXml(urlManage)}")'/>
					    	<%--
					    	 <input  type="button" name="button" id="button" value="Manage Category" onClick="goto_page('${urlManage}')"/>
					    	  --%>
					    </label>
					    <%-- 
					    <input  type="submit" name="submit" id="submit" value="Manage Categor 2 " onClick="return test()"/>
					    <a href="<portlet:renderURL><portlet:param name="action" value="viewCategory"/></portlet:renderURL>">Test</a>
					    --%>
				  	</td>
				</tr>
				<tr>
					<td width="20%"><h2>My Videos</h2> </td>
					<td width="80%" align="right">
						<label>
	    					<b>Category Name :</b>
	    				</label> &nbsp;	
	    				<input type="text" name="keyword"   value="" id="keyword" />
						&nbsp;						<label>
	    					<b>Type :</b>
	    				</label> &nbsp;	
	    				<form:select path="pmtId" id="pmtId">
	    					<form:option  label="--- Select Type ---" value="0"/>
	    					<form:options items="${listCateTypes}" itemValue="pmtId"  itemLabel="pmtName"/>
	    				</form:select> 
	    				&nbsp;	
	    				<input type="button" name="button" id="button" value="Search" onclick="loadCate('1' , '5','0')"/> 
					</td>
				</tr>
				<tr>
					<td colspan="2">
							<span id="mediaMyPersonalElement"></span>
					 		<span id="mediaCopElement"></span>
					 		<span id="mediaCoiElement"></span>					 									
	 				</td>
	 			</tr>
				 
			</table>
		</form:form> 
	</body></html>