<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Uploadify Example Script</title>
<link href="uploads/uploadify.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="uploads/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="uploads/swfobject.js"></script>
    <script type="text/javascript" src="uploads/jquery.uploadify.v2.1.4.min.js"></script>
     <style type="text/css">
        #custom-demo .uploadifyQueueItem {
  background-color: #FFFFFF;
  border: none;
  border-bottom: 1px solid #E5E5E5;
  font: 11px Verdana, Geneva, sans-serif;
  height: 50px;
  margin-top: 0;
  padding: 10px;
  width: 350px;
}
#custom-demo .uploadifyError {
  background-color: #FDE5DD !important;
  border: none !important;
  border-bottom: 1px solid #FBCBBC !important;
}
#custom-demo .uploadifyQueueItem .cancel {
  float: right;
}
#custom-demo .uploadifyQueue .completed {
  color: #C5C5C5;
}
#custom-demo .uploadifyProgress {
  background-color: #E5E5E5;
  margin-top: 10px;
  width: 100%;
}
#custom-demo .uploadifyProgressBar {
  background-color: #0099FF;
  height: 3px;
  width: 1px;
}
#custom-demo #custom-queue {
  border: 1px solid #E5E5E5;
  height: 213px;
margin-bottom: 10px;
  width: 370px;
}
</style>
    <script type="text/javascript">
    $(document).ready(function() { 
    $('#custom_file_upload').uploadify({
    	  'uploader'       : 'uploads/uploadify.swf',
    	  'script'         : 'UploadAction',
    	  'cancelImg'      : 'uploads/cancel.png',
    	  'folder'         : 'uploads',
    	  'multi'          : true,
    	  'auto'           : false,
    	  'fileExt'        : '*.jpg;*.gif;*.png',
    	  'fileDesc'       : 'Image Files (.JPG, .GIF, .PNG)',
    	  'queueID'        : 'custom-queue',
    	  'queueSizeLimit' : 3,
    	  'simUploadLimit' : 3,
    	  'sizeLimit'   : 102400,
    	  'removeCompleted': true,
    	  'scriptData'  : {'firstName':'Chatchai','age':30},
    	  'onSelectOnce'   : function(event,data) {
    		  alert("onSelectOnce")
    	      $('#status-message').text(data.filesSelected + ' files have been added to the queue.');
    	    },
    	  'onAllComplete'  : function(event,data) {
    		  alert("onAllComplete")
    	      $('#status-message').text(data.filesUploaded + ' files uploaded, ' + data.errors + ' errors.');
    	    },
    	   'onComplete'  : function(event, ID, fileObj, response, data) {
    		   var obj = jQuery.parseJSON(response);
    		   alert( obj.aoe);
    	        alert('There are ' + data.fileCount + ' files remaining in the queue.'+', return from server '+response);
    	      },
    	    'onError'     : function (event,ID,fileObj,errorObj) {
    	        alert(errorObj.type + ' Error: ' + errorObj.info);
    	      }
    	});	
	});
    </script>

<%--
<link href="css/default.css" rel="stylesheet" type="text/css" />
<link href="css/uploadify.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="scripts/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="scripts/swfobject.js"></script>
<script type="text/javascript" src="scripts/jquery.uploadify.v2.1.0.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#uploadify2").uploadify({
		'uploader'       : 'scripts/uploadify.swf',
		'script'         : 'UploadAction',
		'cancelImg'      : 'cancel.png',
		'folder'         : 'uploads',
		'queueID'        : 'fileQueue',
		'auto'           : true,
		//'multi': true,
		'multi'          : true
	});
	$("#uploadify").uploadify({
		'uploader': 'scripts/uploader.swf',
		'cancelImg': 'cancel.png',
		'script': 'scripts/uploadify.php',
		'folder': 'uploads',
		'multi': true,
		'buttonText': 'Select Files',
		'checkScript': 'scripts/check.php',
		'displayData': 'speed',
		'simUploadLimit': 2
	});
});
</script>
 --%>
</head> 
<body>
<div class="demo-box">
        <div id="status-message">Select some files to upload:</div>

<div id="custom-queue"></div>
<input id="custom_file_upload" type="file" name="Filedata" />      
<a href="javascript:$('#custom_file_upload').uploadifyUpload()">Start Upload</a> |  <a href="javascript:$('#custom_file_upload').uploadifyClearQueue()">Clear Queue</a>
<a href="javascript:jQuery('#custom_file_upload').uploadifyClearQueue()">Cancel All Uploads</a></p>
 
  </div>
      
<!-- 
    <input id="file_upload" name="file_upload" type="file" />

 
<div id="fileQueue"></div>
<input type="file" name=custom_file_upload id=custom_file_upload />
<p>
 -->
</body>
</html>
