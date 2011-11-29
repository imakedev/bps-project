<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Uploadify Example Script</title>
<link href="uploads/uploadify.css" type="text/css" rel="stylesheet" />
<link rel="stylesheet" href="css/jquery-ui/jquery-ui-1.8.custom.css"
	type="text/css">
	<script type="text/javascript" src="uploads/jquery-1.4.2.min.js"></script>
	<script type="text/javascript" src="uploads/swfobject.js"></script>
	<script type="text/javascript"
		src="uploads/jquery.uploadify.v2.1.4.min.js"></script>
	<script src="css/jquery-ui/jquery-ui-1.8.custom.min.js"
		type="text/javascript"></script>
	<script src="js/Countdown.js" type="text/javascript"></script>
	<script type="text/javascript" src="ckeditor/ckeditor.js"></script>
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

#custom_file_uploadUploader {
	width: 120px;
	height: 30px;
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
	<style id="styles" type="text/css">
.cke_button_myDialogCmd .cke_icon {
	display: none !important;
}

.cke_button_myDialogCmd .cke_label {
	display: inline !important;
}
</style>
	<script type="text/javascript">
		var indexG = 0;
		$(document).ready(function() {

		});
		function countDown() {
			$('#countdown').countDown({
				startNumber : 1,
				callBack : function(me) {
					callData();
				}
			});

		}
		
		function CallToUpload() {
			$('#custom_file_upload').uploadifyUpload();
			//alert("aa")
			/*
			$('.cke_dialog_ui_hbox_first').click(function() {
				$('#custom_file_upload').uploadifyUpload();
				
				
			//	CKEDITOR.dialog.cancelButton;
			});
			*/
		}

		function callData() {
			$('.cke_dialog_ui_vbox_child')
					.html(
							'<div id="status-message">Select some files to upload:</div><div id="custom-queue"></div><input id="custom_file_upload" type="file" name="Filedata" />');
			initUploadImg();

			$('.cke_dialog_ui_hbox_first').children('a').attr("href", "#");

		}
		function initUploadImg() {

			$('#custom_file_upload')
					.uploadify(
							{
								'uploader' : 'uploads/uploadify.swf',
								'script' : 'UploadAction',
								'cancelImg' : 'uploads/cancel.png',
								//'folder'         : 'uploads',
								'multi' : true,
								'auto' : false,
								'width' : 50,
								'height' : 50,
								'fileExt' : '*.jpg;*.gif;*.png',
								'fileDesc' : 'Image Files (.JPG, .GIF, .PNG)',
								'queueID' : 'custom-queue',
								//'queueSizeLimit' : 3,
								//'simUploadLimit' : 3,
								'sizeLimit' : 102400,
								'removeCompleted' : true,
								// 'scriptData'  : {'firstName':'Chatchai','age':30},
								'onSelectOnce' : function(event, data) {
									//  alert("onSelectOnce")
									imageIdG = "";
									$('#status-message')
											.text(
													data.filesSelected
															+ ' files have been added to the queue.');
								},
								'onAllComplete' : function(event, data) {
									//  alert("onAllComplete")
									$('#status-message').text(
											data.filesUploaded
													+ ' files uploaded, '
													+ data.errors + ' errors.');
								},
								'onComplete' : function(event, ID, fileObj,
										response, data) {
									var obj = jQuery.parseJSON(response);
								//	alert(obj.id)
									/* imageIdG = obj.id;
									var editor2 = CKEDITOR.instances["bptDefinition"]; //alert(editor2) // [obj]
									var selection = editor2.getSelection();//alert(selection) // [obj]
									var text = selection.getNative();//alert(text) // ""
									var ranges = selection.getRanges();// alert(ranges) //[obj]
									var type = selection.getType();// alert(type) // 2 
									//			alert(imageIdG)
									var newElement = CKEDITOR.dom.element
											.createFromHtml('<img alt="" src="http://10.2.0.94:10000/BPSDownloadServlet/DownloadServlet?id='
													+ imageIdG + '" />');
									ranges[0].deleteContents();
									ranges[0].insertNode(newElement);
									ranges[0].selectNodeContents(newElement); */
									//$("#dialog-upload").dialog("close");
									//$("#dialog-upload").dialog("destroy");
									CKEDITOR.dialog.getCurrent().hide();
								},
								'onError' : function(event, ID, fileObj,
										errorObj) {
									imageIdG = "";
									alert(errorObj.type + ' Error: '
											+ errorObj.info);
								}
							});
		}
		//init();
		function uploadImg() {

			$("#dialog-upload").dialog({
				title : "Upload Image",
				modal : true,
				show : 'slide',
				height : 300,
				width : 460,
				buttons : [ {
					text : "Ok",
					click : function() {
						goToUpload()
						//$('#custom_file_upload').uploadifyUpload();

						//  agree= true; 
					}
				}, {
					text : "Cancel",
					click : function() {
						$(this).dialog("close");
						$(this).dialog("destroy");

					}
				} ]
			});
			//initUploadImg();
			//init();
		}

		function init() {
			//if(top.uploadDone) top.uploadDone(); //top means parent frame.

			document.getElementById("file_upload_form").onsubmit = function() {
				document.getElementById("file_upload_form").target = "upload_target";
				document.getElementById("upload_target").onload = uploadDone; //This function should be called when the iframe has compleated loading
				// That will happen when the file is completely uploaded and the server has returned the data we need.
			}

		}

		function uploadDone() { //Function will be called when iframe is loaded
			alert("uploadDone")
			var ret = frames['upload_target'].document
					.getElementsByTagName("body")[0].innerHTML;
			var ret2 = frames['upload_target'].document
					.getElementsByTagName("pre")[0].innerHTML;
			//var data = eval("("+ret+")"); //Parse JSON // Read the below explanations before passing judgment on me
			var data = eval("(" + ret2 + ")");
			alert(data.aoe);
			document.getElementById("image_details").innerHTML = (indexG++)
					+ "";
			if (data.success) { //This part happens when the image gets uploaded.
				document.getElementById("image_details").innerHTML = "<img src='image_uploads/" + data.file_name + "' /><br />Size: "
						+ data.size + " KB";

			} else if (data.failure) { //Upload failed - show user the reason.
				alert("Upload Failed: " + data.failure);
			}
		}
	</script>
</head>
<body>
	<div id="dialog-upload" title="Upload Image" style="display: none;">
		<p>
			<div class="demo-box">
				<div id="status-message1">Select some files to upload:</div>
				<div id="custom-queue1"></div>
				<input id="custom_file_upload1" type="file" name="Filedata" />
			</div>
		</p>
	</div>

	<textarea cols="80" id="editor1" name="editor1" rows="10">&lt;p&gt;This is some &lt;strong&gt;sample text&lt;/strong&gt;. You are using &lt;a href="http://ckeditor.com/"&gt;CKEditor&lt;/a&gt;.&lt;/p&gt;</textarea>
	<script type="text/javascript">
		var upload_Str = " Would you like to upload image file ? ";
		upload_Str="";
		//upload_Str='<div id="status-message">Select some files to upload:</div><div id="custom-queue"></div><input id="custom_file_upload" type="file" name="Filedata" />';
		var editor1 = CKEDITOR.replace('editor1', {
			toolbar : [ {
				name : 'basicstyles',
				items : [ 'Bold', 'Italic' ]
			}, {
				name : 'paragraph',
				items : [ 'NumberedList', 'BulletedList' ]
			}, {
				name : 'tools',
				items : [ 'Maximize', '-', 'About', '-', 'MyButton' ]
			} ]
		});
		editor1.on('pluginsLoaded', function(ev) {
			// If our custom dialog has not been registered, do that now.
			alert("pluginsLoaded")
			if (!CKEDITOR.dialog.exists('myDialog')) {
				alert("myDialog not exists")
				CKEDITOR.dialog.add('myDialog', function(api) {
					//	return uploadImg();
					var dialogDefinition = {
						title : 'Upload Img',
						minWidth : 390,
						minHeight : 130,
						contents : [ {
							id : 'tab1',
							label : 'Upload Image',
							title : 'Title',
							expand : true,
							padding : 0,
							elements : [ {

								id : 'linkType',
								type : 'html',
								html : upload_Str
							} ]
						} ],
						buttons : [ CKEDITOR.dialog.okButton,
								CKEDITOR.dialog.cancelButton ],
						onOk : function() {

							CallToUpload();
							return false;

						}

					};

					//countDown();
					//callData();
					return dialogDefinition;

				});

			}
			// Register the command used to open the dialog.
			editor1.addCommand('myDialogCmd', new CKEDITOR.dialogCommand(
					'myDialog'));
			// Add the a custom toolbar buttons, which fires the above
			// command.. 
			//	var iconPath = '${url}images/icon_upload.gif';
			editor1.ui.addButton('MyButton', {
				label : 'upload Img',
				command : 'myDialogCmd'
			//		icon: iconPath
			});
		});
		editor1.on('dialogShow', function(evt) {
			alert("dialog show name="+CKEDITOR.dialog.getCurrent().getName());
			if(CKEDITOR.dialog.getCurrent().getName()=='myDialog'){
				callData();
			}
		});
		//
	</script>
	<div id="countdown" style="display: none;"></div>
</body>
</html>
