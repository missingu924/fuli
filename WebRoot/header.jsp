<%@ page contentType="text/html; charset=gb2312" language="java"
	import="java.sql.*" errorPage=""%>
<%@page import="com.hz.auth.obj.AuthUser"%>
<%@page import="com.hz.util.SystemConstant"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>大丰工业供应商协同平台</title>
		<link href="style.css" rel="stylesheet" type="text/css" />
		<style type="text/css">
<!--
a
{
	color: #fff;
	text-decoration:none;
}
.STYLE2 {color: #000000; line-height:20px;}
.STYLE3 {
	font-size: 24px;
	font-family: Aldhabi, "黑体";
	font-weight: bold;
	color: #FF0000;
}
-->
        </style>
<script type="text/javascript" src="js/utils.js"></script>
	</head>
	<%
		AuthUser user = (AuthUser) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);
	%>
	<body>
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			bgcolor="#FFFFFF">
			<tr>
				<td width="300" height="65" valign="middle"><img src="images/SystemName.png" width="340" height="65" /></td>
				<td align="right" valign="bottom" style="background-image:url(images/background/bg_header_cloud.png); background-position:right; background-repeat:no-repeat; padding:0px 20px 5px 0px">
						
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
						  	<td align="center"><span class="STYLE3">建设新农村&nbsp;&nbsp;&nbsp;&nbsp;走进新时代</span></td>
                            <td align="right"><a href="#"
						onclick="openBigModalDialog('<%=request.getContextPath()%>/Auth/Servlet?method=userDetail&account=<%=user.getAccount()%>')"><span class="STYLE2"><%=user.getName()+"</br>"+user.getDistrict()%></span></a></td>
                            <td width="20" align="right"></td>
                            <td width="1" align="right" bgcolor="#999999"></td>
                            <td width="20" align="right"></td>
                            <td width="25" align="right"><a href="Auth/Servlet?method=logout" target="_parent"><span class="STYLE2">退出</span></a></td>
                          </tr>
                        </table>
			  </td>
			</tr>
			<tr>
				<td height="8" colspan="2" bgcolor="#3DAEB6"></td>
			</tr>
	</table>
	</body>
</html>
