<%@ page contentType="text/html; charset=GBK" language="java" import="java.sql.*" errorPage=""%>
<%@page import="com.hz.auth.obj.AuthUser"%>
<%@page import="java.util.List"%>
<%@page import="com.hz.util.SystemConstant"%>
<%@page import="com.wuyg.common.util.StringUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.wuyg.common.obj.PaginationObj"%>
<%@page import="com.inspur.common.dictionary.util.DictionaryUtil"%>
<%@page import="com.hz.dict.service.DictionaryService"%>
<%@page import="com.hz.auth.service.AuthService"%>
<%@page import="com.hz.dict.service.IDictionaryService"%>
<%@page import="java.net.URLEncoder"%>

<%@page import="com.fuli.obj.VWelfareDrawStatObj"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<%
	
		String basePath="VWelfareDrawStat";// 每个功能都不同
		VWelfareDrawStatObj domainInstance = new VWelfareDrawStatObj();
		
		String contextPath = request.getContextPath();
		
		// 用户信息
		AuthUser user = (AuthUser) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);

		// 如果是修改，则获取对象信息
		Object domainInstanceObj = request.getAttribute("domainInstance");
		if (domainInstanceObj != null)
		{
			domainInstance = (VWelfareDrawStatObj)domainInstanceObj;
		}

		// 字典服务
		IDictionaryService dict = new DictionaryService();

		// 是否是修改
		boolean isModify = domainInstance.getKeyValue()>0;
	%>
	<head>
		<base target="_self" />
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<title><%=isModify ? "修改福利领取统计" : "增加福利领取统计"%></title>
		<link href="../style.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="../js/jquery-2.0.3.min.js"></script>
		<script type="text/javascript" src="../js/utils.js"></script>
		<script>
		//  新增或修改
		function addOrModify()
		{	
			// 修改账号
			if("true"=="<%=isModify%>")
			{
				submit();
			}
			// 新建账号
			else
			{
				// 做必要的检查
				if(!checkSomething("welfare_policy_id","null")) 
				{
					return false;
				} 
				else 
				{
				// 然后检查ID是否已被使用
					$.get(
					"Servlet?method=checkId&welfare_policy_id="+$("#welfare_policy_id").val(), 
					{Action:"get"}, 
					function (data, textStatus){
						this;
						if(data=="true") 
						{
							alert("该null已录入系统"); 
							return false;
						}
						else
						{
							submit();
						}
					});
				};
			}
		}
		
		// 提交保存或修改
		function submit()
		{
						// 如果账号符合要求且未被使用，则检测其他的项
					if(!checkNull("welfare_policy_name","福利政策")) return false;
					if(!checkNull("product_name","产品名称")) return false;
					if(!checkNull("product_spec","产品规格")) return false;
					if(!checkNull("product_qunatity_sum","已领取数量")) return false;
						$("#addOrModifyForm").submit();
		}
		</script>
	</head>
	<body>
		<form name="addOrModifyForm" id="addOrModifyForm" action="<%=contextPath%>/<%=basePath %>/Servlet?method=addOrModify" method="post">
		<div style="height:8px;"></div>
        <table width="500" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#3DAEB6">
          <tr>
            <td height="4" bgcolor="#3DAEB6"></td>
          </tr>
          <tr>
            <td height="25" align="center" class="green_font">添加福利领取统计</td>
          </tr>
        </table>
			<table width="500" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#3DAEB6">
				<tr>
					<td bgcolor="#FFFFFF">
						<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
							<tr class="list_table_tr0">
								<td width="130" height="30" align="right" class="little_gray_font">null:</td>
								<td>
										<input name="welfare_policy_id" type="text" id="welfare_policy_id" value="<%=domainInstance.getKeyValue()%>"
											<%=isModify ? "readonly" : ""%> class="notEmpty">

										<%
											if (isModify)
											{
										%>
										<span class="red_font">(不可修改)</span>
										<%
											} else
											{
										%>
										<%
											}
										%>
								</td>
							</tr>
							<tr class="list_table_tr2">
								<td width="130" height="30" align="right" class="little_gray_font"><%=domainInstance.getProperties().get("welfare_policy_name")%>:</td>
								<td>
										<input name="welfare_policy_name" type="text" id="welfare_policy_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getWelfare_policy_name())%>" class="notEmpty">
								</td>
							</tr>
							<tr class="list_table_tr0">
								<td width="130" height="30" align="right" class="little_gray_font"><%=domainInstance.getProperties().get("product_name")%>:</td>
								<td>
										<input name="product_name" type="text" id="product_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getProduct_name())%>" class="notEmpty">
								</td>
							</tr>
							<tr class="list_table_tr2">
								<td width="130" height="30" align="right" class="little_gray_font"><%=domainInstance.getProperties().get("product_spec")%>:</td>
								<td>
										<input name="product_spec" type="text" id="product_spec" value="<%=StringUtil.getNotEmptyStr(domainInstance.getProduct_spec())%>" class="notEmpty">
								</td>
							</tr>
							<tr class="list_table_tr0">
								<td width="130" height="30" align="right" class="little_gray_font"><%=domainInstance.getProperties().get("product_qunatity_sum")%>:</td>
								<td>
										<input name="product_qunatity_sum" type="text" id="product_qunatity_sum" value="<%=StringUtil.getNotEmptyStr(domainInstance.getProduct_qunatity_sum())%>" class="notEmpty">
								</td>
							</tr>
							<tr class="tab_bg">
								<td height="30" colspan="2" align="center">
									<input name="Submit" type="button" class="gray_button" value="取消" onClick="javascript:window.close();">
									&nbsp;
									<input name="Submit2" type="button" class="green_button" value="保存" onClick="addOrModify()">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
		<script>
			// 绑定enter事件
			$('body').keydown(function(){
			   if(event.keyCode == 13)
			   {
				 addOrModify();
			   }
			});
		</script>
	</body>
</html>
