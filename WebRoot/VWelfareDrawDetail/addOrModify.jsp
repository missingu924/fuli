<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
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

<%@page import="com.fuli.obj.VWelfareDrawDetailObj"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<%
	
		String basePath="VWelfareDrawDetail";// 每个功能都不同
		VWelfareDrawDetailObj domainInstance = new VWelfareDrawDetailObj();
		
		String contextPath = request.getContextPath();
		
		// 用户信息
		AuthUser user = (AuthUser) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);

		// 如果是修改，则获取对象信息
		Object domainInstanceObj = request.getAttribute("domainInstance");
		if (domainInstanceObj != null)
		{
			domainInstance = (VWelfareDrawDetailObj)domainInstanceObj;
		}

		// 字典服务
		IDictionaryService dict = new DictionaryService();

		// 是否是修改
		boolean isModify = domainInstance.getKeyValue()>0;
	%>
	<head>
		<base target="_self" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><%=isModify ? "修改null" : "增加null"%></title>
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
				if(!checkSomething("id","null")) 
				{
					return false;
				} 
				else 
				{
				// 然后检查ID是否已被使用
					$.get(
					"Servlet?method=checkId&id="+$("#id").val(), 
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
					if(!checkNull("draw_villager_id","领取人编号")) return false;
					if(!checkNull("draw_villager_id_card","领取人身份证")) return false;
					if(!checkNull("draw_villager_name","领取人姓名")) return false;
					if(!checkNull("draw_type","领取方式")) return false;
					if(!checkNull("draw_date","领取时间")) return false;
					if(!checkNull("villager_id","福利人编号")) return false;
					if(!checkNull("id_card","福利人身份证")) return false;
					if(!checkNull("villager_name","福利人姓名")) return false;
					if(!checkNull("welfare_policy_name","福利政策名")) return false;
					if(!checkNull("welfare_policy_start_time","福利政策生效时间")) return false;
					if(!checkNull("welfare_policy_end_time","福利政策过期时间")) return false;
					if(!checkNull("product_name","产品名")) return false;
					if(!checkNull("product_measuring_unit","产品规格")) return false;
					if(!checkNull("product_quantity","人均数量")) return false;
					if(!checkNull("product_quantity_drawed","本次领取数量")) return false;
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
            <td height="25" align="center" class="green_font">添加null</td>
          </tr>
        </table>
			<table width="500" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#3DAEB6">
				<tr>
					<td bgcolor="#FFFFFF">
						<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
							<tr class="list_table_tr0">
								<td width="130" height="30" align="right" class="little_gray_font">null:</td>
								<td>
										<input name="id" type="text" id="id" value="<%=domainInstance.getKeyValue()%>"
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
								<td width="130" height="30" align="right" class="little_gray_font">领取人编号:</td>
								<td>
										<input name="draw_villager_id" type="text" id="draw_villager_id" value="<%=StringUtil.getNotEmptyStr(domainInstance.getDraw_villager_id())%>" class="notEmpty">
								</td>
							</tr>
							<tr class="list_table_tr0">
								<td width="130" height="30" align="right" class="little_gray_font">领取人身份证:</td>
								<td>
										<input name="draw_villager_id_card" type="text" id="draw_villager_id_card" value="<%=StringUtil.getNotEmptyStr(domainInstance.getDraw_villager_id_card())%>" class="notEmpty">
								</td>
							</tr>
							<tr class="list_table_tr2">
								<td width="130" height="30" align="right" class="little_gray_font">领取人姓名:</td>
								<td>
										<input name="draw_villager_name" type="text" id="draw_villager_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getDraw_villager_name())%>" class="notEmpty">
								</td>
							</tr>
							<tr class="list_table_tr0">
								<td width="130" height="30" align="right" class="little_gray_font">领取方式:</td>
								<td>
										<input name="draw_type" type="text" id="draw_type" value="<%=StringUtil.getNotEmptyStr(domainInstance.getDraw_type())%>" class="notEmpty">
								</td>
							</tr>
							<tr class="list_table_tr2">
								<td width="130" height="30" align="right" class="little_gray_font">领取时间:</td>
								<td>
										<input name="draw_date" type="text" id="draw_date" value="<%=StringUtil.getNotEmptyStr(domainInstance.getDraw_date())%>" class="notEmpty">
								</td>
							</tr>
							<tr class="list_table_tr0">
								<td width="130" height="30" align="right" class="little_gray_font">福利人编号:</td>
								<td>
										<input name="villager_id" type="text" id="villager_id" value="<%=StringUtil.getNotEmptyStr(domainInstance.getVillager_id())%>" class="notEmpty">
								</td>
							</tr>
							<tr class="list_table_tr2">
								<td width="130" height="30" align="right" class="little_gray_font">福利人身份证:</td>
								<td>
										<input name="id_card" type="text" id="id_card" value="<%=StringUtil.getNotEmptyStr(domainInstance.getId_card())%>" class="notEmpty">
								</td>
							</tr>
							<tr class="list_table_tr0">
								<td width="130" height="30" align="right" class="little_gray_font">福利人姓名:</td>
								<td>
										<input name="villager_name" type="text" id="villager_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getVillager_name())%>" class="notEmpty">
								</td>
							</tr>
							<tr class="list_table_tr2">
								<td width="130" height="30" align="right" class="little_gray_font">福利政策名:</td>
								<td>
										<input name="welfare_policy_name" type="text" id="welfare_policy_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getWelfare_policy_name())%>" class="notEmpty">
								</td>
							</tr>
							<tr class="list_table_tr0">
								<td width="130" height="30" align="right" class="little_gray_font">福利政策生效时间:</td>
								<td>
										<input name="welfare_policy_start_time" type="text" id="welfare_policy_start_time" value="<%=StringUtil.getNotEmptyStr(domainInstance.getWelfare_policy_start_time())%>" class="notEmpty">
								</td>
							</tr>
							<tr class="list_table_tr2">
								<td width="130" height="30" align="right" class="little_gray_font">福利政策过期时间:</td>
								<td>
										<input name="welfare_policy_end_time" type="text" id="welfare_policy_end_time" value="<%=StringUtil.getNotEmptyStr(domainInstance.getWelfare_policy_end_time())%>" class="notEmpty">
								</td>
							</tr>
							<tr class="list_table_tr0">
								<td width="130" height="30" align="right" class="little_gray_font">产品名:</td>
								<td>
										<input name="product_name" type="text" id="product_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getProduct_name())%>" class="notEmpty">
								</td>
							</tr>
							<tr class="list_table_tr2">
								<td width="130" height="30" align="right" class="little_gray_font">产品规格:</td>
								<td>
										<input name="product_measuring_unit" type="text" id="product_measuring_unit" value="<%=StringUtil.getNotEmptyStr(domainInstance.getProduct_measuring_unit())%>" class="notEmpty">
								</td>
							</tr>
							<tr class="list_table_tr0">
								<td width="130" height="30" align="right" class="little_gray_font">人均数量:</td>
								<td>
										<input name="product_quantity" type="text" id="product_quantity" value="<%=StringUtil.getNotEmptyStr(domainInstance.getProduct_quantity())%>" class="notEmpty">
								</td>
							</tr>
							<tr class="list_table_tr2">
								<td width="130" height="30" align="right" class="little_gray_font">本次领取数量:</td>
								<td>
										<input name="product_quantity_drawed" type="text" id="product_quantity_drawed" value="<%=StringUtil.getNotEmptyStr(domainInstance.getProduct_quantity_drawed())%>" class="notEmpty">
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
