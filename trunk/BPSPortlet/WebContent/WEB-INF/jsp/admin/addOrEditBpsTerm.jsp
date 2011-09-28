<%@include file="../include.jsp"%>
<%@page contentType="text/html; charset=utf-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<table width="950" align="center" border="0" cellspacing="0"
		cellpadding="0">
		<tr>
			<td height="30" colspan="2"><span
				style="color: #030; font-size: 12px;"><strong>You
						are in:</strong> <a href="index.html">Home</a> > <a href="BPSTerm01.html">BPS
						Term and Difinition</a> > Add BPS Term and Difinition</span>
			</td>
		</tr>
		<tr>
			<td><img src="images/term.gif">
			</td>
			<td align="right">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2" valign="top">
				<!--//-->
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
				<form action="" method="get">
					<table width="100%" border="0" cellspacing="5" cellpadding="0">
						<tr>
							<th width="13%" height="25" align="left">Term:</th>
							<td width="87%" align="left"><input type="text"
								value="wiki" size="45">
							</td>
						</tr>
						<tr>
							<th valign="top" align="left">Definiion:</th>
							<td align="left" valign="top"><textarea name="" cols="80"
									rows="8">A wiki (Listeni/ˈwɪki/ wik-ee) is a website that allows the creation and editing of any number of interlinked web pages via a web browser using a simplified markup language or a WYSIWYG text editor.[1][2][3] Wikis are typically powered by wiki software and are often used collaboratively by multiple users. Examples include community websites, corporate intranets, knowledge management systems, and note services. The software can also be used for personal notetaking.

Wikis serve different purposes. Some permit control over different functions (levels of access). For example editing rights may permit changing, adding or removing material. Others may permit access without enforcing access control. Other rules can be imposed for organizing content.</textarea>
							</td>
						</tr>
						<tr>
							<th width="13%" height="25" align="left">Category:</th>
							<td width="87%" align="left"><input type="text"
								value="wiki" size="45">&nbsp; <a
								href="BPSTerm_admin_managecat.html">Manage Category</a>
							</td>
						</tr>
						<tr>
							<th height="25" align="left">Source / Refence:</th>
							<td align="left"><input type="text" value="wiki"
								size="45">
							</td>
						</tr>
						<tr>
							<th height="25" align="left">Attachments:</th>
							<td align="left"><label> <input type="file"
									name="fileField2" id="fileField2"> </label>
							</td>
						</tr>
						<tr>
							<th height="25" align="left">&nbsp;</th>
							<td align="left"><span style="padding-top: 5px;">
									<input name="input2" type="button" value="Save &amp; Publish">
							</span>
							</td>
						</tr>

					</table>
					<script type="text/javascript" src="tabber.js"></script>
					<link rel="stylesheet" href="example.css" TYPE="text/css"
						MEDIA="screen">

					<script type="text/javascript">
						/* Optional: Temporarily hide the "tabber" class so it does not "flash"
						 on the page as plain HTML. After tabber runs, the class is changed
						 to "tabberlive" and it will appear. */

						document
								.write('<style type="text/css">.tabber{display:none;}<\/style>');
					</script>
					<table width="100%" id="box-table-a" border="0" cellspacing="2"
						cellpadding="0" style="border: 1px solid #132C00">
						<tr>
							<th height="25" align="left" bgcolor="#3DB0B5"><span
								style="padding-left: 5px;">&nbsp;</span>
							</th>
						</tr>
						<tr>
							<td width="25%">
								<div class="tabber">


									<div class="tabbertab">
										<h2>Attachments</h2>
										<ul>
											<li><a href="#">&nbsp;File Name.pdf</a> (25k)</li>
											<li><a href="#">&nbsp;File Name.pdf</a> (25k)</li>
											<li><a href="#">&nbsp;File Name.pdf</a> (25k)</li>
										</ul>
									</div>



									<div class="tabbertab">
										<h2>version</h2>
										<table width="98%" align="center" border="0" cellspacing="2"
											cellpadding="0">
											<tr>
												<td width="20%" height="20" align="center"><strong>version</strong>
												</td>
												<td width="40%" align="center"><strong>date</strong>
												</td>
												<td width="40%">&nbsp;</td>
											</tr>
											<tr>
												<td height="20"><input name="radio" type="radio"
													id="radio" value="radio" checked>version 2</td>
												<td>6/08/2011 1:45:30 PM</td>
												<td>wpsadmin current</td>
											</tr>
											<tr>
												<td height="20"><input name="radio" type="radio"
													id="radio2" value="radio"> version 1</td>
												<td>6/08/2011 1:45:30 PM</td>
												<td>wpsadmin</td>
											</tr>
											<tr>
												<td height="30"><span style="padding-top: 5px;">
														<input name="input3" type="button" value="Save Version">
												</span>
												</td>
												<td>&nbsp;</td>
												<td>&nbsp;</td>
											</tr>
										</table>

									</div>

								</div>

								<div style="padding-top: 5px;"></div></td>
						</tr>
					</table>
				</form></td>
		</tr>
		<tr>
			<td width="50%" height="30"><span
				style="color: #030; font-size: 12px;">< Back to Home</span>
			</td>
			<td width="50%">&nbsp;</td>
		</tr>
	</table>
</body>
</html>