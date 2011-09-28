<%@include file="../include.jsp"%>
<%@page contentType="text/html; charset=utf-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
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
	<table width="950" align="center" border="0" cellspacing="0"
		cellpadding="0">
		<tr>
			<td height="30" colspan="2"><span
				style="color: #030; font-size: 12px;"><strong>You
						are in:</strong> Home > BPS Term and Difinition</span>
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td align="right"><a href="BPSTerm_admin_add.html"><img
					src="images/btn_admin.gif" width="65" height="25">
			</a>
			</td>
		</tr>

		<tr>
			<td colspan="2"><div class="team" style="padding-left: 10px;">
					<a href="#" class="team">A</a> <a href="#" class="team">B</a><a
						href="#" class="team"> C </a><a href="#" class="team"> D</a><a
						href="#" class="team"> E </a><a href="#" class="team">F </a><a
						href="#" class="team">G</a><a href="#" class="team"> H</a><a
						href="#" class="team"> I</a><a href="#" class="team"> J</a><a
						href="#" class="team"> K</a><a href="#" class="team"> L</a><a
						href="#" class="team"> M</a><a href="#" class="team"> N</a><a
						href="#" class="team"> O</a><a href="#" class="team"> P</a><a
						href="#" class="team"> Q</a><a href="#" class="team"> R</a><a
						href="#" class="team"> S</a><a href="#" class="team"> T</a><a
						href="#" class="team"> U</a><a href="#" class="team"> V</a><a
						href="#" class="team"> W</a><a href="#" class="team"> X</a><a
						href="#" class="team"> Y</a><a href="#" class="team"> Z</a>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<div style="padding-top: 5px;">
					<form action="" method="get">
						<strong style="padding-left: 5px;">Search:</strong> <input
							name="textfield" type="text" id="textfield" size="30"> <select
							name="select" id="select">
							<option value="1" selected>By Term</option>
							<option value="2">By Difinition</option>
							<option value="3">By All</option>
						</select> <select name="select2" id="select2">
							<option value="0" selected>--Select Category--</option>
							<option value="1">Category1</option>
							<option value="2">Category2</option>
						</select>
					</form>
				</div></td>
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
				<table width="100%" id="box-table-a" border="0" cellspacing="2"
					cellpadding="0" style="border: 1px solid #132C00">
					<tr>
						<th width="25%" height="25" align="center" bgcolor="#3DB0B5">Term&nbsp;<img
							src="images/up.png"><img src="images/down.png">
						</th>
						<th width="26%" align="center" bgcolor="#3DB0B5">Difinition&nbsp;<img
							src="images/up.png"><img src="images/down.png">
						</th>
						<th width="26%" align="center" bgcolor="#3DB0B5">Categoty&nbsp;<img
							src="images/up.png"><img src="images/down.png">
						</th>
						<th width="17%" align="center" bgcolor="#3DB0B5">Source&nbsp;<img
							src="images/up.png"><img src="images/down.png">
						</th>
						<th width="6%" align="center" bgcolor="#3DB0B5">&nbsp;</th>
					</tr>
					<tr>
						<td><a href="BPSTerm02_detail.html" class="team">xxx</a>
						</td>
						<td>xxxx 200 ตัวอักษร</td>
						<td>xxxx</td>
						<td>xxxx</td>
						<td align="center"><img src="images/edit.png" width="16"
							height="16"><img src="images/delete.png" width="16"
							height="16">
						</td>
					</tr>
					<tr>
						<td><a href="BPSTerm02_detail.html" class="team">xxx</a>
						</td>
						<td>xxxx</td>
						<td>xxxx</td>
						<td>xxxx</td>
						<td align="center"><img src="images/edit.png" width="16"
							height="16"><img src="images/delete.png" width="16"
							height="16">
						</td>
					</tr>
					<tr>
						<td><a href="BPSTerm02_detail.html" class="team">xxx</a>
						</td>
						<td>xxxx</td>
						<td>xxxx</td>
						<td>xxxx</td>
						<td align="center"><img src="images/edit.png" width="16"
							height="16"><img src="images/delete.png" width="16"
							height="16">
						</td>
					</tr>
					<tr>
						<td><a href="BPSTerm02_detail.html" class="team">xxx</a>
						</td>
						<td>xxxx</td>
						<td>xxxx</td>
						<td>xxxx</td>
						<td align="center"><img src="images/edit.png" width="16"
							height="16"><img src="images/delete.png" width="16"
							height="16">
						</td>
					</tr>
					<tr>
						<td><a href="BPSTerm02_detail.html" class="team">xxx</a>
						</td>
						<td>xxxx</td>
						<td>xxxx</td>
						<td>xxxx</td>
						<td align="center"><img src="images/edit.png" width="16"
							height="16"><img src="images/delete.png" width="16"
							height="16">
						</td>
					</tr>
					<tr>
						<td><a href="BPSTerm02_detail.html" class="team">xxx</a>
						</td>
						<td>xxxx</td>
						<td>xxxx</td>
						<td>xxxx</td>
						<td align="center"><img src="images/edit.png" width="16"
							height="16"><img src="images/delete.png" width="16"
							height="16">
						</td>
					</tr>
					<tr>
						<td><a href="BPSTerm02_detail.html" class="team">xxx</a>
						</td>
						<td>xxxx</td>
						<td>xxxx</td>
						<td>xxxx</td>
						<td align="center"><img src="images/edit.png" width="16"
							height="16"><img src="images/delete.png" width="16"
							height="16">
						</td>
					</tr>
					<tr>
						<td><a href="BPSTerm02_detail.html" class="team">xxx</a>
						</td>
						<td>xxxx</td>
						<td>xxxx</td>
						<td>xxxx</td>
						<td align="center"><img src="images/edit.png" width="16"
							height="16"><img src="images/delete.png" width="16"
							height="16">
						</td>
					</tr>
					<tr>
						<td><a href="BPSTerm02_detail.html" class="team">xxx</a>
						</td>
						<td>xxxx</td>
						<td>xxxx</td>
						<td>xxxx</td>
						<td align="center"><img src="images/edit.png" width="16"
							height="16"><img src="images/delete.png" width="16"
							height="16">
						</td>
					</tr>
					<tr>
						<td><a href="BPSTerm_detail.html" class="team">xxx</a>
						</td>
						<td>xxxx</td>
						<td>xxxx</td>
						<td>xxxx</td>
						<td align="center"><img src="images/edit.png" width="16"
							height="16"><img src="images/delete.png" width="16"
							height="16">
						</td>
					</tr>
				</table></td>
		</tr>
		<tr>
			<td width="50%" height="30"><span
				style="color: #030; font-size: 12px;">< Back to Home</span>
			</td>
			<td width="50%">
				<div class="pagination">
					<ul>
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
					</ul>
				</div>
			</td>
		</tr>
	</table>
</body>
</html>