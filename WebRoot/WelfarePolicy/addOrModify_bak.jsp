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

<%@page import="com.fuli.obj.WelfarePolicyObj"%>
<%@page import="com.fuli.obj.WelfarePolicyDetailObj"%>
<%@page import="com.fuli.obj.ProductObj"%>
<%@page import="com.wuyg.common.util.TimeUtil"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<%
	
		String basePath="WelfarePolicy";// 每个功能都不同
		WelfarePolicyObj domainInstance = new WelfarePolicyObj();
		
		String contextPath = request.getContextPath();
		
		// 用户信息
		AuthUser user = (AuthUser) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);

		// 如果是修改，则获取对象信息
		Object domainInstanceObj = request.getAttribute("domainInstance");
		if (domainInstanceObj != null)
		{
			domainInstance = (WelfarePolicyObj)domainInstanceObj;
		}

		// 字典服务
		IDictionaryService dict = new DictionaryService();

		// 是否是修改
		boolean isModify = domainInstance.getKeyValue()>0;
	%>
	<head>
		<base target="_self" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><%=isModify ? "修改福利政策" : "增加福利政策"%></title>
		<link href="../style.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="../js/jquery-2.0.3.min.js"></script>
		<script type="text/javascript" src="../js/utils.js"></script>
		<script src="../My97DatePicker/WdatePicker.js"></script>
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
				if(!checkSomething("welfare_policy_id","编号")) 
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
							alert("该编号已录入系统"); 
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
					if(!checkNull("welfare_policy_id","编号")) return false;
					if(!checkNull("welfare_policy_name","福利政策名称")) return false;
					if(!checkNull("year_lunar","福利农历年份")) return false;
					if(!checkNull("welfare_policy_start_time","福利开始日期")) return false;
					if(!checkNull("welfare_policy_end_time","福利结束日期")) return false;
						$("#addOrModifyForm").submit();
		}
		</script>
	</head>
	<body>
		<form name="addOrModifyForm" id="addOrModifyForm" action="<%=contextPath%>/<%=basePath %>/Servlet?method=addOrModifyWelfarePolicy" method="post">
		<div style="height:8px;"></div>
        <table width="600" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#3DAEB6">
          <tr>
            <td height="4" bgcolor="#3DAEB6"></td>
          </tr>
          <tr>
            <td height="25" align="center" class="green_font">添加福利政策</td>
          </tr>
        </table>
			<table width="600" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#3DAEB6">
				<tr>
					<td bgcolor="#FFFFFF">
						<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
							<tr class="list_table_tr0">
								<td width="130" height="30" align="right" class="little_gray_font">福利政策名称:</td>
								<td>
										<input name="id" type="hidden" id="id" value="<%=StringUtil.getNotEmptyStr(domainInstance.getKeyValue())%>">
										<input name="welfare_policy_name" type="text" id="welfare_policy_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getWelfare_policy_name())%>" class="notEmpty" size="40">
								</td>
							</tr>
							<tr class="list_table_tr2">
								<td width="130" height="30" align="right" class="little_gray_font">福利生效时间:</td>
								<td>
										<input name="welfare_policy_start_time" type="text" id="welfare_policy_start_time" value="<%=StringUtil.getNotEmptyStr(domainInstance.getWelfare_policy_start_time_show(),TimeUtil.getThisLunarYearFirstDay2solar())%>" class="notEmpty" onFocus="WdatePicker({isShowClear:false,readOnly:false,highLineWeekDay:true,dateFmt:'yyyy-MM-dd'})">								</td>
							</tr>
							<tr class="list_table_tr0">
								<td width="130" height="30" align="right" class="little_gray_font">福利过期时间:</td>
								<td>
										<input name="welfare_policy_end_time" type="text" id="welfare_policy_end_time" value="<%=StringUtil.getNotEmptyStr(domainInstance.getWelfare_policy_end_time_show(),TimeUtil.getThisLunarYearLastDay2solar())%>" class="notEmpty" onFocus="WdatePicker({isShowClear:false,readOnly:false,highLineWeekDay:true,dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'welfare_policy_start_time\',{d:1})}'})">								</td>
							</tr>
							<tr class="list_table_tr2">
								<td width="130" height="30" align="right" class="little_gray_font">所有村民都享受:</td>
								<td>
									<table>
										<tr>
										<td>
										<%
										boolean welfare_policy_for_all = "true".equalsIgnoreCase(domainInstance.getWelfare_policy_for_all());
										if(isModify)
										{
										 %>
										 	<input type="hidden" name="welfare_policy_for_all" id="welfare_policy_for_all" value="<%=welfare_policy_for_all %>">
											<input type="checkbox" disabled <%=welfare_policy_for_all?"checked":"" %> value="true" class="notEmpty" >
										<%} else {%>
											<input type="checkbox" name="welfare_policy_for_all" id="welfare_policy_for_all" value="true">
										<%} %>
										</td>
										<td><font color="red">【操作提示】<br>1、选中该项后，除了已停用的村民，其他村民都会享受该福利<br>2、保存后，该项不能再更改</font>	</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr class="list_table_tr0">
							<td width="100" height="30" align="right" class="little_gray_font">福利状态:</td>
							<td><font color="<%=domainInstance.getWelfare_status_color() %>"><%=StringUtil.getNotEmptyStr(domainInstance.getWelfare_policy_status())%></font></td>
							</tr>
							<tr class="list_table_tr2">
								<td width="130" height="30" align="right" class="little_gray_font">备注信息:</td>
								<td>
										<textarea name="welfare_policy_comment" cols="30" rows="4" class="notEmpty" id="welfare_policy_comment"><%=StringUtil.getNotEmptyStr(domainInstance.getWelfare_policy_comment())%></textarea>								</td>
							</tr>
							<tr>
							<td colspan="2">
							<table width="100%"  border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
                                  <tr class="list_table_head">
                                    <td>产品编号</td>
                                    <td>产品名称</td>
                                    <td>产品规格</td>
                                    <td>产品单位</td>
                                    <td>产品单价</td>
                                    <%if(isModify){ %>
                                    <td>当前人均数量</td>
                                    <td>调整人均数量</td>
                                    <%}else{ %>
                                    <td>设置人均数量</td>
                                    <%} %>
                                  </tr>
                                  <% 
                                  int n = 0;
                                  List<WelfarePolicyDetailObj> usedList = domainInstance.getUsedDetailList();
                                  for(int i=0;i<usedList.size();i++)
                                  { 
                                  	WelfarePolicyDetailObj detailObj = usedList.get(i);
                                  %>
                                  <tr class="list_table_tr3">
                                  	<input type="hidden" id="detail_id_<%=n%>" name="detail_id_<%=n%>" value="<%=detailObj.getId() %>"/>
                                  	<input type="hidden" id="product_id_<%=n%>" name="product_id_<%=n%>" value="<%=detailObj.getProduct_id() %>"/>
                                    <td>
                                    <%=StringUtil.getNotEmptyStr(detailObj.getProduct_u_code()) %>
                                    <input type="hidden" id="product_u_code_<%=n%>" name="product_u_code_<%=n%>" value="<%=detailObj.getProduct_u_code() %>"/>
                                    </td>
                                    <td>
                                    <%=StringUtil.getNotEmptyStr(detailObj.getProduct_name()) %>
                                    <input type="hidden" id="product_name_<%=n%>" name="product_name_<%=n%>" value="<%=detailObj.getProduct_name()%>"/>
                                    </td>
                                    <td>
                                    <%=StringUtil.getNotEmptyStr(detailObj.getProduct_spec()) %>
                                    <input type="hidden" id="product_spec_<%=n%>" name="product_spec_<%=n%>" value="<%=detailObj.getProduct_spec()%>"/>
                                    </td>
                                    <td>
                                    <%=StringUtil.getNotEmptyStr(detailObj.getProduct_measuring_unit()) %>
                                    <input type="hidden" id="product_measuring_unit_<%=n%>" name="product_measuring_unit_<%=n%>" value="<%=detailObj.getProduct_measuring_unit()%>"/>
                                    </td>
                                    <td>
                                    <%=StringUtil.getNotEmptyStr(detailObj.getProduct_price()) %>
                                    <input type="hidden" id="product_price_<%=n%>" name="product_price_<%=n%>" value="<%=detailObj.getProduct_price()%>"/>
                                    </td>
                                    <%if(isModify){ %>
                                    <td><%=StringUtil.getNotEmptyStr(detailObj.getProduct_quantity()) %></td>
                                   	<%} %>
                                   	<td>
                                   	<%=DictionaryUtil.getSelectHtml(new
											DictionaryService().getDictItemsByDictName("number_0_100", true),
											"product_quantity_"+n, "人均数量",
											StringUtil.getNotEmptyStr(detailObj.getProduct_quantity(),"0"),
											"notEmpty")%>
                                   	</td>
                                  </tr>
                                  <%
                                  n++;
                                  } %>
                                  
                                  <% 
                                  List<ProductObj> notUsedList = domainInstance.getNotUseProductList();
                                  for(int i=0;i<notUsedList.size();i++)
                                  { 
                                  	ProductObj productObj = notUsedList.get(i);
                                  %>
                                  <tr class="list_table_tr0">
                                  	
                                    <td>
                                    <%=StringUtil.getNotEmptyStr(productObj.getU_code()) %>
                                     <input type="hidden" id="product_id_<%=n%>" name="product_id_<%=n%>" value="<%=productObj.getId() %>"/>
                                     <input type="hidden" id="product_u_code_<%=n%>" name="product_u_code_<%=n%>" value="<%=productObj.getU_code() %>"/>
                                    </td>
                                    <td>
                                    <%=StringUtil.getNotEmptyStr(productObj.getName()) %>
                                     <input type="hidden" id="product_name_<%=n%>" name="product_name_<%=n%>" value="<%=productObj.getName()%>"/>
                                    </td>
                                    <td>
                                    <%=StringUtil.getNotEmptyStr(productObj.getSpec()) %>
                                     <input type="hidden" id="product_spec_<%=n%>" name="product_spec_<%=n%>" value="<%=productObj.getSpec()%>"/>
                                    </td>
                                    <td>
                                    <%=StringUtil.getNotEmptyStr(productObj.getPdwname()) %> 
                                    <input type="hidden" id="product_measuring_unit_<%=n%>" name="product_measuring_unit_<%=n%>" value="<%=productObj.getPdwname()%>"/>
                                    </td>
                                    <td>
                                    <%=StringUtil.getNotEmptyStr(productObj.getPrice()) %>
                                    <input type="hidden" id="product_price_<%=n%>" name="product_price_<%=n%>" value="<%=productObj.getPrice()%>"/>
                                    </td>
                                    <%if(isModify){ %>
                                    <td>0</td>
                                    <%} %>
                                    <td> 	<%=DictionaryUtil.getSelectHtml(new
											DictionaryService().getDictItemsByDictName("number_0_100", true),
											"product_quantity_"+n, "人均数量",
											"0",
											"notEmpty")%>
									</td>
                                  </tr>
                                  <%
                                  n++;
                                  } %>
                                </table>							</td>
							</tr>
							<tr class="tab_bg">
								<td height="30" colspan="2" align="center">
									<input name="Submit" type="button" class="gray_button" value="取消" onClick="javascript:window.close();">
									&nbsp;
									<input name="Submit2" type="button" class="green_button" value="保存" onClick="addOrModify()">								</td>
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
