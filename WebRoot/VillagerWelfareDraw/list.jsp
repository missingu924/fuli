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

<%@page import="com.fuli.obj.VillagerWelfareDrawObj"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>领取福利列表</title>
		<link href="../style.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="../js/jquery-2.0.3.min.js"></script>
		<script type="text/javascript" src="../js/utils.js"></script>
		<%
			String basePath="VillagerWelfareDraw";// 每个功能都不同
			VillagerWelfareDrawObj domainInstance = (VillagerWelfareDrawObj)request.getAttribute("domainInstance");

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
			<table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#3DAEB6">
				<tr>
					<td>
						<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
							<tr class="list_table_tr2">
								<td align="left">
									编号 <input name="id" type="text" id="id" value="<%=StringUtil.getNotEmptyStr(domainInstance.getKeyValue())%>" size="20">
									&nbsp;
									<input name="searchButton" type="button" class="blue_button" value="查询" onClick="toPage(1)">
							  	</td>
							    <td align="right">
							      <input name="addButton" type="button" class="green_button" value="添加" onClick="openBigModalDialog('<%=contextPath%>/<%=basePath%>/addOrModify.jsp')">
							    </td>
							</tr>
						</table>
					</td>
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
					<td>编号</td>
					<td>村民编号</td>
					<td>领取方式</td>
					<td>代领人编号</td>
					<td>代领人姓名</td>
					<td>领取日期</td>
					<td>备注</td>
					<td>操作</td>
				</tr>
				<%
					for (int i = 0; i < list.size(); i++)
						{
							VillagerWelfareDrawObj o = (VillagerWelfareDrawObj)list.get(i);
				%>
				<tr class="<%=i % 2 == 0 ? "list_table_tr0" : "list_table_tr1"%>">
					<td><%=StringUtil.getNotEmptyStr(o.getId())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getVillager_id())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getDraw_type())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getProxy_villager_id())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getProxy_villager_name())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getDraw_date())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getDraw_comment())%></td>
					<td width="90" align="center" style="padding: 0; cursor: pointer">
						<img src="../images/list_detail.png" width="25" height="25"
							alt="详情" title="详情"
							onClick="openBigModalDialog('<%=contextPath%>/<%=basePath%>/Servlet?method=<%=AbstractBaseServletTemplate.BASE_METHOD_DETAIL %>&<%=o.findKeyColumnName() %>=<%=o.getKeyValue()%>')">
						<%
							if (SystemConstant.ROLE_ADMIN.equalsIgnoreCase(user.getRoleLevel()))
									{
						%>
						<img src="../images/list_edit.png" width="25" height="25" alt="修改"
							title="修改"
							onClick="openBigModalDialog('<%=contextPath%>/<%=basePath%>/Servlet?method=<%=AbstractBaseServletTemplate.BASE_METHOD_PRE_MODIFY %>&<%=o.findKeyColumnName() %>=<%=o.getKeyValue()%>')"/>
						<img src="../images/list_delete.png" width="25" height="25"
							alt="删除" title="删除"
							onClick="javascript:
								$('#pageForm').attr('action','<%=contextPath%>/<%=basePath%>/Servlet?method=<%=AbstractBaseServletTemplate.BASE_METHOD_DELETE %>&<%=o.findKeyColumnName() %>_4del=<%=o.getKeyValue()%>');
								$('#pageForm').submit();
								"/>
						<%
							}
						%>
					</td>
				</tr>
				<%
					}
				%>
				<tr class="list_table_foot">
					<td colspan="8">
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
