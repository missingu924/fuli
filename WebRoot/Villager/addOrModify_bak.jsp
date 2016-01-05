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

<%@page import="com.fuli.obj.VillagerObj"%>
<%@page import="com.fuli.obj.WelfarePolicyObj"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<%
	
		String basePath="Villager";// 每个功能都不同
		VillagerObj domainInstance = new VillagerObj();
		
		String contextPath = request.getContextPath();
		
		// 用户信息
		AuthUser user = (AuthUser) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);

		// 如果是修改，则获取对象信息
		Object domainInstanceObj = request.getAttribute("domainInstance");
		if (domainInstanceObj != null)
		{
			domainInstance = (VillagerObj)domainInstanceObj;
		}

		// 字典服务
		IDictionaryService dict = new DictionaryService();

		// 是否是修改
		boolean isModify = domainInstance.getKeyValue()>0;
	%>
	<head>
		<base target="_self" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><%=isModify ? "修改村民信息" : "增加村民信息"%></title>
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
				save();
			}
			// 新建账号
			else
			{
				// 检查身份证号
				checkTheIdCard(false);
			}
		}
		
		// 提交保存或修改
		function save()
		{
					// 如果账号符合要求且未被使用，则检测其他的项
					if(!checkNull("villager_id","身份证号")) return false;
					if(!checkNull("villager_name","姓名")) return false;
					if(!checkNull("villager_sex","性别")) return false;
					if(!checkNull("enable","是否启用")) return false;
					$("#addOrModifyForm").submit();
		}
		
		// 检查身份证号是否合适以及是否已录入
		
		function checkTheIdCard(justCheck)
		{
				// 做必要的检查
				if(!checkIDcard("id_card","身份证号")) 
				{
					$("#checkOk").val("false");
					return false;
				} 
				else 
				{
					// 然后检查ID是否已被使用
					$.post(
					"Servlet?method=checkIdCard&id_card="+$("#id_card").val(), 
					{Action:"post"}, 
					function (data, textStatus){
						this;
						if(data=="true") 
						{
							alert("该身份证号已录入系统"); 
							return false;
						}
						else
						{
							if(justCheck==false)
							{
								save();
							}
						}
					});
				};
		}
	</script>
		
	<!-- 身份证读卡器 -->
	<script>
	function HideActiveX() {
	   ClearIDCard();
	   return true;
	}
	
	function ReadIDCard() {   
	
	   CVR_IDCard.PhotoPath="c:/idcard";
	   CVR_IDCard.TimeOut=3;// 3秒后放弃读卡
	   
	   // 清空
	   ClearIDCard(); 
	   
	   // 读卡
	   $("#id_card").val("请将二代身份证放置到读卡器");
	   
	   var strReadResult=CVR_IDCard.ReadCard;   
	   
	   if('0'!=strReadResult) 
	   {
	   	var readResultMessage = '读卡成功';
	   	
	   	if(strReadResult=-1)
			readResultMessage= '未连接机具';
		else if(strReadResult=-2)
			readResultMessage= '放卡超时'
		else if(strReadResult=-3)
			readResultMessage= '用户已取消读卡'
		else if(strReadResult=-4)
			readResultMessage= '读基本信息出错'
		else if(strReadResult=-5)
			readResultMessage= '照片创建失败'
	  	 
	  	 $("#id_card").val(readResultMessage);
	   }
	   else
	   {
	   		// 获取身份证号
		   $("#id_card").val(CVR_IDCard.CardNo);
		   $("#villager_name").val(CVR_IDCard.NameL);
		   $("#villager_sex").val(CVR_IDCard.SexL);
		   
		   checkTheIdCard(true);
	   }
	   return true;
	}
	
	function ClearIDCard() {
	
	   CVR_IDCard.Name="";
	   CVR_IDCard.NameL="";
	   CVR_IDCard.Sex="";   
	   //CVR_IDCard.SexL="";   
	   CVR_IDCard.Nation="";
	   //CVR_IDCard.NationL="";
	   CVR_IDCard.Born="";
	   //CVR_IDCard.BornL="";
	   CVR_IDCard.Address="";
	   CVR_IDCard.CardNo="";
	   CVR_IDCard.Police="";
	   CVR_IDCard.Activity="";
	   CVR_IDCard.NewAddr="";
	  
	   return true;
	}
	</script>
	</head>
	<body>
		<!-- 身份证读卡器 -->
		<OBJECT
			  classid="clsid:10946843-7507-44FE-ACE8-2B3483D179B7"
			  codebase="CVR100.cab#version=3,0,3,3"
			  id="CVR_IDCard" name="CVR_IDCard"
			  width=0
			  height=0
			  align=center
			  hspace=0
			  vspace=0 	 	  
		>
		</OBJECT> 
		
		<form name="addOrModifyForm" id="addOrModifyForm" action="<%=contextPath%>/<%=basePath %>/Servlet?method=addOrModifyVillager" method="post">
		<div style="height:8px;"></div>
        <table width="700" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#3DAEB6">
          <tr>
            <td height="4" bgcolor="#3DAEB6"></td>
          </tr>
          <tr>
            <td height="25" align="center" class="green_font">添加村民信息</td>
          </tr>
        </table>
			<table width="700" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#3DAEB6">
				<tr>
					<td bgcolor="#FFFFFF">
						<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
							<tr class="list_table_tr0">
								<td width="130" align="right" class="little_gray_font">身份证号:</td>
								<td>
										<input name="id" type="hidden" id="id" value="<%=domainInstance.getKeyValue()%>">
										<input name="id_card" type="text" id="id_card" value="<%=StringUtil.getNotEmptyStr(domainInstance.getId_card())%>"
											<%=isModify ? "readonly" : ""%> class="notEmpty" size="30">

										<%
											if (isModify)
											{
										%>
										<span class="red_font">(不可修改)</span>
										<%
											} else
											{
										%>
										<input name="readButton" type="button" class="blue_button" value="读取身份证信息" onClick="javascript:ReadIDCard();">
										<%
											}
										%>
								</td>
							</tr>
							<tr class="list_table_tr2">
								<td width="130" align="right" class="little_gray_font">姓名:</td>
								<td>
										<input name="villager_name" type="text" id="villager_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getVillager_name())%>" class="notEmpty">
								</td>
							</tr>
							<tr class="list_table_tr0">
								<td width="130" align="right" class="little_gray_font">性别:</td>
								<td>
										<%=DictionaryUtil.getSelectHtml(new
											DictionaryService().getDictItemsByDictName("sex", false),
											"villager_sex", "性别",
											StringUtil.getNotEmptyStr(domainInstance.getVillager_sex(),"男"),
											"notEmpty")%>
								</td>
							</tr>
							<tr class="list_table_tr2">
								<td width="130" align="right" class="little_gray_font">电话:</td>
								<td>
										<input name="villager_telephone" type="text" id="villager_telephone" value="<%=StringUtil.getNotEmptyStr(domainInstance.getVillager_telephone())%>" class="notEmpty">
								</td>
							</tr>
							<tr class="list_table_tr0">
								<td width="130" align="right" class="little_gray_font">备注:</td>
								<td>
										<input name="villager_omment" type="text" id="villager_omment" value="<%=StringUtil.getNotEmptyStr(domainInstance.getVillager_omment())%>" class="notEmpty">
								</td>
							</tr>
							<tr class="list_table_tr2">
								<td width="130" align="right" class="little_gray_font">是否启用:</td>
								<td>
										<%=DictionaryUtil.getSelectHtml(new
											DictionaryService().getDictItemsByDictName("enable", false), "enable",
											"是否启用", StringUtil.getNotEmptyStr(domainInstance.getEnable(),"启用"),
											"notEmpty")%>
								</td>
							</tr>
							<tr class="list_table_tr0">
								<td width="130" align="right" class="little_gray_font">绑定到:</td>
								<td>
								<%if(domainInstance.isBindinged()){ %>
								该村民已被其他人绑定
								<%}else{ %>
										<%=DictionaryUtil.getSelectHtml(new
											DictionaryService().getDictItemsByDictNameExcludeKey("villager", false, domainInstance.getId()+""), "binding_to_id",
											"绑定到", StringUtil.getNotEmptyStr(domainInstance.getBinding_to_id()),
											"notEmpty")%>
								<%} %>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<table width="700" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#3DAEB6">
										<tr>
											<td height="2" bgcolor="#3DAEB6"></td>
										</tr>
										<tr>
											<td height="25" align="center" class="green_font">享受的福利</td>
										</tr>
									</table>
								</td>
							</tr>
						<tr>
							<td colspan="2">
							<table width="100%"  border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
                                  <tr class="list_table_head">
                                  	<td>选择</td>
                                    <td>编号</td>
                                    <td>福利政策名称</td>
                                    <td>福利年份</td>
                                    <td>福利开始日期</td>
                                    <td>福利结束日期</td>
                                    <td>福利状态</td>
                                  </tr>
                                  <% 
                                  int n=0;
                                  List <WelfarePolicyObj> list = domainInstance.getUsedWelfareList();
                                  for(int i=0;i<list.size();i++)
                                  { 
                                  	WelfarePolicyObj o = list.get(i);
                                  %>
                                  <tr class="list_table_tr3">
                                  	<td>         	
                                  	<%
                                  	// 对于已选中的福利
                                  	// 新增账号时，只要未过期的福利政策都可以用
                                  	// 修改账号时，只有 未开始 或 待发放 的可以改
                                  	
                                  	if((!isModify&&o.canUse())||(isModify&&o.canModify())){ %>
	                                 	<input type="checkbox" checked id="welfare_policy_id" name="welfare_policy_id" value="<%=StringUtil.getNotEmptyStr(o.getId()) %>">
	                                 	<%} else {%>
	                                 	<input label="传值用" type="hidden" id="welfare_policy_id" name="welfare_policy_id" value="<%=StringUtil.getNotEmptyStr(o.getId()) %>">
	                                 	<input label="显示用" type="checkbox" disabled checked value="<%=StringUtil.getNotEmptyStr(o.getId()) %>">
	                                  	<%} %></td>
                                    <td><%=StringUtil.getNotEmptyStr(o.getId()) %></td>
                                    <td><a href="#" onClick="openBigModalDialog('<%=contextPath%>/WelfarePolicy/Servlet?method=detailWelfarePolicy&<%=o.findKeyColumnName() %>=<%=o.getKeyValue()%>')"><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_name()) %></a></td>
                                    <td><%=StringUtil.getNotEmptyStr(o.getYear_lunar()) %></td>
                                  	<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_start_time_show())%><br/><span class="little_gray_font">农历<%=StringUtil.getNotEmptyStr(o.getWelfare_policy_start_time_lunar())%></span></td>
									<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_end_time_show())%><br/><span class="little_gray_font">农历<%=StringUtil.getNotEmptyStr(o.getWelfare_policy_end_time_lunar())%></span></td>
                                  	<td><font color="<%=o.getWelfare_status_color() %>"><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_status()) %></font></td>
                                  </tr>
                                  <%
                                  n++;
                                  } %>
                                  
                                  <%
                                  list = domainInstance.getNotUsedWelfareList();
                                  for(int i=0;i<list.size();i++)
                                  { 
                                  	WelfarePolicyObj o = list.get(i);
                                  	// 对于未选中的福利，只要是未过期的都可以用
                                  %>
                                  <tr class="list_table_tr0">
                                  	<td>
                                  		<input <%=(o.canUse())?"":"disabled" %> type="checkbox" id="welfare_policy_id" name="welfare_policy_id" value="<%=StringUtil.getNotEmptyStr(o.getId()) %>">
                                  	</td>
                                    <td><%=StringUtil.getNotEmptyStr(o.getId()) %></td>
                                    <td><a href="#" onClick="openBigModalDialog('<%=contextPath%>/WelfarePolicy/Servlet?method=detailWelfarePolicy&<%=o.findKeyColumnName() %>=<%=o.getKeyValue()%>')"><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_name()) %></a></td>
                                    <td><%=StringUtil.getNotEmptyStr(o.getYear_lunar()) %></td>
                                  	<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_start_time_show())%><br/><span class="little_gray_font">农历<%=StringUtil.getNotEmptyStr(o.getWelfare_policy_start_time_lunar())%></span></td>
									<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_end_time_show())%><br/><span class="little_gray_font">农历<%=StringUtil.getNotEmptyStr(o.getWelfare_policy_end_time_lunar())%></span></td>
                                  	<td><font color="<%=o.getWelfare_status_color() %>"><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_status()) %></font></td>
                                  </tr>
                                  <%
                                  n++;
                                  } %>
                                  
                                </table>
							</td>
							</tr>
						<tr>
							<tr class="tab_bg">
								<td colspan="2" align="center">
									<input name="cancleButton" type="button" class="gray_button" value="取消" onClick="javascript:window.close();">
									<%if(SystemConstant.ROLE_ADMIN.equals(user.getRoleLevel())){ %>
									&nbsp;
									<input name="saveButton" type="button" class="green_button" value="保存" onClick="javascript:addOrModify()">
									<%} %>
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