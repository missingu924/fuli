<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<%@page import="com.hz.auth.obj.AuthUser"%>
<%@page import="com.hz.util.SystemConstant"%>
<%@page import="com.wuyg.common.util.StringUtil"%>
<%@page import="com.wuyg.common.servlet.AbstractBaseServletTemplate"%>
<%@page import="com.fuli.obj.WelfarePolicyObj"%>
<%@page import="com.fuli.obj.WelfarePolicyDetailObj"%>
<%@page import="com.fuli.obj.ProductObj"%>
<%@page import="java.util.List"%>
<%
	WelfarePolicyObj domainInstance = (WelfarePolicyObj) request.getAttribute("domainInstance");
	String basePath = domainInstance.getBasePath();

	String contextPath = request.getContextPath();
	AuthUser user = (AuthUser) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);
%>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<title><%=domainInstance.getCnName()%>详情</title>
		<link href="../style.css" rel="stylesheet" type="text/css" />
		<link href="../table.css" rel="stylesheet" type="text/css" />
		<script src="../js/jquery-2.0.3.min.js"></script>
		<script src="../js/utils.js"></script>
	</head>
	<body>
		<!-- 表格标题 -->
		<table width="600" align="center" class="title_table">
			<tr>
				<td>
					<img src="../images/svg/heavy/green/shop.png" width="18" height="18" align="absmiddle">&nbsp;&nbsp;<%=domainInstance.getCnName()%>信息
			  </td>
			</tr>
		</table>
		<!-- 详细信息 -->
		<table width="600" align="center" class="detail_table detail_table-bordered detail_table-striped">
			<tr>
				<td>
					<%=domainInstance.getPropertyCnName("welfare_policy_name") %>:
				</td>
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getWelfare_policy_name())%></td>
			</tr>
			<tr>
				<td>
					<%=domainInstance.getPropertyCnName("year_lunar") %>:
				</td>
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getYear_lunar())%></td>
			</tr>
			<tr>
				<td>
					<%=domainInstance.getPropertyCnName("welfare_policy_start_time") %>:
				</td>
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getWelfare_policy_start_time_show())%>&nbsp;&nbsp;&nbsp;&nbsp;
					<span class="little_gray_font">农历<%=StringUtil.getNotEmptyStr(domainInstance.getWelfare_policy_start_time_lunar())%></span>
				</td>
			</tr>
			<tr>
				<td>
					<%=domainInstance.getPropertyCnName("welfare_policy_end_time") %>:
				</td>
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getWelfare_policy_end_time_show())%>&nbsp;&nbsp;&nbsp;&nbsp;
					<span class="little_gray_font">农历<%=StringUtil.getNotEmptyStr(domainInstance.getWelfare_policy_end_time_lunar())%></span>
				</td>
			</tr>
			<tr>
				<td>
					<%=domainInstance.getPropertyCnName("welfare_policy_for_all_show") %>:
				</td>
				<td>
					<%
						boolean welfare_policy_for_all = "true".equalsIgnoreCase(domainInstance.getWelfare_policy_for_all());
						{
					%>
					<font color="<%=welfare_policy_for_all ? "green" : ""%>"> <%=welfare_policy_for_all ? "是" : "否"%> </font>
					<%
						}
					%>
				</td>
			</tr>
			<tr>
				<td>
					<%=domainInstance.getPropertyCnName("welfare_policy_status") %>:
				</td>
				<td>
					<font color="<%=domainInstance.getWelfare_status_color()%>"><%=StringUtil.getNotEmptyStr(domainInstance.getWelfare_policy_status())%></font>
				</td>
			</tr>
			<tr>
				<td>
					<%=domainInstance.getPropertyCnName("welfare_policy_comment") %>:
				</td>
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getWelfare_policy_comment())%></td>
			</tr>
		</table>
		
		<!-- 表格标题 -->
		<table width="600" align="center" class="title_table">
			<tr>
				<td>
					<img src="../images/svg/heavy/green/list.png" width="18" height="18" align="absmiddle" >&nbsp;&nbsp;分配的福利产品
				</td>
			</tr>
		</table>
		<!-- 详细信息 -->
		<%
			WelfarePolicyDetailObj detailObj = new WelfarePolicyDetailObj();
		%>
		<table class="table table-bordered" align="center" width="600">
			<thead>
				<tr>
					<th>
						<%=detailObj.getPropertyCnName("product_u_code") %>
					</th>
					<th>
						<%=detailObj.getPropertyCnName("product_name") %>
					</th>
					<th>
						<%=detailObj.getPropertyCnName("product_spec") %>
					</th>
					<th>
						<%=detailObj.getPropertyCnName("product_measuring_unit") %>
					</th>
					<th>
						<%=detailObj.getPropertyCnName("product_price") %>
					</th>
					<th>
						<%=detailObj.getPropertyCnName("product_quantity") %>
					</th>
				</tr>
			</thead>
			<%
				List<WelfarePolicyDetailObj> usedList = domainInstance.getUsedDetailList();
				for (int i = 0; i < usedList.size(); i++)
				{
					detailObj = usedList.get(i);
			%>
			<tr class="list_table_tr3">
				<td><%=StringUtil.getNotEmptyStr(detailObj.getProduct_u_code())%></td>
				<td><%=StringUtil.getNotEmptyStr(detailObj.getProduct_name())%></td>
				<td><%=StringUtil.getNotEmptyStr(detailObj.getProduct_spec())%></td>
				<td><%=StringUtil.getNotEmptyStr(detailObj.getProduct_measuring_unit())%></td>
				<td><%=StringUtil.getNotEmptyStr(detailObj.getProduct_price())%></td>
				<td><%=StringUtil.getNotEmptyStr(detailObj.getProduct_quantity())%></td>
			</tr>
			<%
				}
			%>
		</table>
		
		<!-- 工具栏 -->
		<jsp:include page="../ToolBar/detail_toolbar.jsp"/>
	</body>
</html>
