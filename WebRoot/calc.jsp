<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>利星行融资计算器</title>
<style type="text/css">
<!--
.STYLE1 {color: #000000
}
.STYLE2 {color: #666666}
body,td,th {
	font-size: medium;
}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.STYLE3 {
	font-size: large;
	font-weight: bold;
}
-->
</style>
<script language="javascript" src="js/jquery-2.0.3.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
  $("#btnCalc").click(function(){
    $("#preTotal").html("");//先清空
  	price=$("#price").val();
    $.post(
    "/lsh/calc",
    $("#mainForm").serialize(),
    function(result){
    $("#preTotal").html(result);
  	});
  
  });
});
</script>

</head>

<body>
<form id="mainForm">
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td height="30" colspan="3" align="center">
	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="33%" height="32" align="left"><img src="images/Cat_logo.gif" width="61" height="32" /></td>
            <td width="34%"><div align="center"><span class="STYLE3">融资计算器</span></div></td>
            <td width="33%">&nbsp;</td>
          </tr>
        </table></td>
    </tr>
    <tr>
      <td height="40" colspan="3" valign="bottom"><span class="STYLE1">挖机类型</span></td>
    </tr>
    <tr>
      <td height="30" valign="bottom"><label>
          <input name="type" type="radio" value="new_big" checked="checked" />
      <span class="STYLE2">          新机-大挖          </span></label></td>
      <td valign="bottom"><label>
      <input type="radio" name="type" value="new_small" />
      </label>
        <span class="STYLE2">新机-小挖</span></td>
      <td valign="bottom"><label>
        <input type="radio" name="type" value="old" />
      </label>
        <span class="STYLE2">二手机</span></td>
    </tr>
    <tr>
      <td height="30" colspan="3" valign="bottom"><span class="STYLE1">整机价格（￥）</span></td>
    </tr>
    <tr>
      <td height="30" colspan="3" valign="bottom"><input id="price" name="price" type="text" size="36" style="height: 28px;" /></td>
    </tr>
    <tr>
      <td height="30" colspan="3" valign="bottom"><span class="STYLE1">付款年限（年）</span></td>
    </tr>
    <tr>
      <td height="30" colspan="3" valign="bottom"><input id="years" name="years" type="text" size="36" style="height: 28px;" /></td>
    </tr>
    <tr>
      <td height="30" colspan="3" valign="bottom"><span class="STYLE1">首付比例（%）</span></td>
    </tr>
    <tr>
      <td height="30" colspan="3" valign="bottom"><input id="rate" name="rate" type="text" size="36" style="height: 28px;" /></td>
    </tr>
    <tr>
      <td height="50" colspan="3" valign="bottom"><div align="center">
        <input type="button" id="btnCalc" value="              开始计算             " style="height: 40px;" />
      </div></td>
    </tr>
    <tr>
      <td height="50" colspan="3" valign="bottom">
	  <p id="preTotal"></p></td>
    </tr>
  </table>
  </form>
</body>
</html>
