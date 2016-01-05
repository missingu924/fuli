<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<%@page import="com.hz.auth.obj.AuthUser"%>
<%@page import="java.util.List"%>
<%@page import="com.hz.util.SystemConstant"%>
<%@page import="com.wuyg.common.util.StringUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.wuyg.common.obj.PaginationObj"%>
<%@page import="com.inspur.common.dictionary.util.DictionaryUtil"%>
<%@page import="com.hz.dict.service.DictionaryService"%>
<%@page import="com.wuyg.common.servlet.AbstractBaseServletTemplate"%>

<%@page import="com.fuli.obj.VWelfareDrawDetailObj"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>null列表</title>
		<link href="../style.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="../js/jquery-2.0.3.min.js"></script>
		<script type="text/javascript" src="../js/utils.js"></script>
		<%
			String basePath="VWelfareDrawDetail";// 每个功能都不同

			String contextPath = request.getContextPath();
			AuthUser user = (AuthUser) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);
		%>
	</head>
	<body>

		<form name="pageForm" id="pageForm" method="post" action="<%=request.getContextPath()%>/<%=basePath%>/Servlet?method=list">
			<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
				<tr>
					<td height="9px"></td>
				</tr>
			</table>
			
			<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
				<tr>
					<td height="10px"></td>
				</tr>
			</table>
			<%
				// 数据信息
				PaginationObj pagination = null;
				List list = new ArrayList();

				Object paginationObj = request.getAttribute("domainPagination");
				if (paginationObj != null)
				{
					pagination = (PaginationObj) paginationObj;
					list = (List) pagination.getDataList();
				}
				if (paginationObj == null)
				{
					out.print("没有查询到数据。");
				} else
				{
			%>
			<table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
				<tr class="list_table_head">
					<td>领取人编号</td>
					<td>领取人身份证</td>
					<td>领取人姓名</td>
					<td>领取方式</td>
					<td>领取时间</td>
					<td>福利人编号</td>
					<td>福利人身份证</td>
					<td>福利人姓名</td>
					<td>福利政策名</td>
					<td>福利政策生效时间</td>
					<td>福利政策过期时间</td>
					<td>产品名</td>
					<td>产品规格</td>
					<td>人均数量</td>
					<td>本次领取数量</td>
				</tr>
				<%
					for (int i = 0; i < list.size(); i++)
						{
							VWelfareDrawDetailObj o = (VWelfareDrawDetailObj)list.get(i);
				%>
				<tr class="<%=i % 2 == 0 ? "list_table_tr0" : "list_table_tr1"%>">
					<td><%=StringUtil.getNotEmptyStr(o.getDraw_villager_id())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getDraw_villager_id_card())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getDraw_villager_name())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getDraw_type())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getDraw_date())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getVillager_id())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getId_card())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getVillager_name())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_name())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_start_time())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_end_time())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getProduct_name())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getProduct_measuring_unit())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getProduct_quantity())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getProduct_quantity_drawed())%></td>
					
				</tr>
				<%
					}
				%>
				<tr class="list_table_foot">
					<td colspan="16">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							align="center">
							<tr>
								<td align="right">
									<input name="pageNo" type="hidden" id="pageNo" value="<%=pagination.getPageNo()%>" size="3" />
									<input name="pageCount" type="hidden" value="<%=pagination.getPageCount()%>" size="3" />
									<%
										if (pagination.isPrevious())
											{
									%>
									<img src="../images/pagination_icons_first.png" align="absmiddle" onClick="toPage(1);" />
									&nbsp;&nbsp;
									<img src="../images/pagination_icons_pre.png" align="absmiddle" onclick="toPage(<%=pagination.getPageNo() - 1%>);" />
									&nbsp;&nbsp;
									<%
										} else
											{
									%>
									<img src="../images/pagination_icons_first_gray.png" align="absmiddle" />
									&nbsp;&nbsp;
									<img src="../images/pagination_icons_pre_gray.png" align="absmiddle" />
									&nbsp;&nbsp;
									<%
										}
									%>
									<%
										if (pagination.isNext())
											{
									%>
									<img src="../images/pagination_icons_next.png" align="absmiddle" onclick="toPage(<%=pagination.getPageNo() + 1%>);" />
									&nbsp;&nbsp;
									<img src="../images/pagination_icons_last.png" align="absmiddle" onclick="toPage(<%=pagination.getTotalPage()%>);" />
									&nbsp;&nbsp;
									<%
										} else
											{
									%>
									<img src="../images/pagination_icons_next_gray.png" align="absmiddle" />
									&nbsp;&nbsp;
									<img src="../images/pagination_icons_last_gray.png" align="absmiddle" />
									&nbsp;&nbsp;
									<%
										}
									%>
									<img src="../images/pagination_icons_fresh.png" align="absmiddle" onClick="toPage(1);" />
								</td>
								<td width="180" align="right" valign="middle">第<%=pagination.getPageNo()%>/<%=pagination.getTotalPage()%>页&nbsp;共<%=pagination.getTotalCount()%>条数据&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<%
				}
			%>
		</form>
		<script>
			// 绑定enter事件
			$('body').keydown(function(){
			   if(event.keyCode == 13)
			   {
				 $("#pageForm").submit();
			   }
			});
		</script>
	</body>
</html>
