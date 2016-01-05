<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<%@page import="com.hz.auth.obj.AuthUser"%>
<%@page import="com.hz.util.SystemConstant"%>
<%@page import="com.wuyg.common.util.StringUtil"%>
<%@page import="com.wuyg.common.servlet.AbstractBaseServletTemplate"%>

<%@page import="com.fuli.obj.VillagerObj"%>
<%@page import="java.util.List"%>
<%@page import="com.fuli.obj.WelfarePolicyObj"%>
<%@page import="com.fuli.obj.VWelfareForDrawDetailObj"%>
<%@page import="com.fuli.obj.VillagerWelfareDrawObj"%>
<%@page import="com.inspur.common.dictionary.util.DictionaryUtil"%>
<%@page import="com.hz.dict.service.DictionaryService"%>
<%@page import="com.wuyg.common.util.TimeUtil"%>
<%@page import="com.fuli.obj.VWelfareForDrawDetailPerVillagerObj"%>
<%@page import="com.fuli.obj.VWelfareDrawDetailObj"%>
<%@page import="com.fuli.obj.VWelfareDrawStatByDrawidObj"%>
<%@page import="com.fuli.obj.VWelfareDrawDetailPerVillagerObj"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<title>领取福利</title>
		<link href="../style.css" rel="stylesheet" type="text/css" />
</head>
	<script src="../js/jquery-2.0.3.min.js"></script>
	<script src="../js/utils.js"></script>
	<script type="text/javascript" src="../js/jquery.PrintArea.js"></script>
	<%
			String basePath="VillagerWelfareDraw";// 每个功能都不同
			
			String contextPath = request.getContextPath();
			AuthUser user = (AuthUser) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);
			
			Object message = request.getAttribute("message");
			
			Object tmpObj = null;
			
			// 领取的主记录
			tmpObj = request.getAttribute("villagerWelfareDraw");
			VillagerWelfareDrawObj villagerWelfareDraw = (tmpObj!=null?(VillagerWelfareDrawObj)tmpObj:null);
			
			// 村民基本信息
			tmpObj = request.getAttribute("villager");
			VillagerObj villager = (tmpObj!=null?(VillagerObj)tmpObj:null);
			
			// 本次领取的统计信息
			tmpObj = request.getAttribute("vwelfareDrawStatByDrawidList");
			List<VWelfareDrawStatByDrawidObj> vwelfareDrawStatByDrawidList = (tmpObj!=null?(List<VWelfareDrawStatByDrawidObj>)tmpObj:null);
			
			// 领取的该村民自身的福利
			tmpObj = request.getAttribute("selfVWfareDraw");
			VWelfareDrawDetailPerVillagerObj selfVWelfareDrawDetail = (tmpObj!=null?(VWelfareDrawDetailPerVillagerObj)tmpObj:null);

			// 领取的绑定到该村名下的其他村民的福利
			tmpObj = request.getAttribute("bindingVWfareDrawList");
			List<VWelfareDrawDetailPerVillagerObj> bindingVWfareDrawList = (tmpObj!=null?(List<VWelfareDrawDetailPerVillagerObj>)tmpObj:null);
			
		%>
	<body>
		
		<%if( villager != null){ %>
		<div style="height: 20px;"></div>
<div id="printDiv" name="printDiv">
<div align="center" class="title">白沙滩村村民福利品发放清单</div>
<table width="95%" border="0" cellpadding="0" cellspacing="1" bgcolor="#3DAEB6" align="center">
  <tr>
    <td bgcolor="#FFFFFF">
    	<!-- 村民基本信息 -->
    	<!-- 自身享受的福利 -->
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="">
			<tr>
				<td  height="25" align="center" class="">
				&nbsp;
							<%=StringUtil.getNotEmptyStr(villager.getVillager_name())%>&nbsp;/&nbsp;
							<%=StringUtil.getNotEmptyStr(villager.getId_card())%>&nbsp;/&nbsp;
							<%=StringUtil.getNotEmptyStr(villager.getVillager_sex())%>&nbsp;/&nbsp;
							<%=StringUtil.getNotEmptyStr(villager.getVillager_telephone())%>&nbsp;/&nbsp;
							<%=StringUtil.getNotEmptyStr(villager.getEnable())%>&nbsp;/&nbsp;
							<%if(StringUtil.isEmpty(villager.getBinding_to_villager_name())) {%>
							没有绑定到其他村民
							<%}else{ %>
							已绑定到<%=StringUtil.getNotEmptyStr(villager.getBinding_to_villager_name())%>		
							<%} %>
				</td>
			</tr>
			<tr>
				<td  height="2" bgcolor="#3DAEB6"></td>
			</tr>
		</table>
		<%if(selfVWelfareDrawDetail.getVwelfareDrawDetailList().size()>0){ %>
		<div style="height: 5px;"></div>				
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr>
				<td height="25" align="left" class="">
				<strong>&nbsp;本人的福利</strong>
				</td>
			</tr>
			<tr>
				<td  height="2" bgcolor="#3DAEB6"></td>
			</tr>
		</table>
		<table width="100%"  border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
            <tr class="list_table_head">
              <td>福利政策名称</td>
              <td>福利开始日期</td>
              <td>福利结束日期</td>
              <td>商品名</td>
              <td>商品规格</td>
              <td>商品单位</td>
              <td><font color="blue">本次领取数</font></td>
            </tr>
            <% 
            List<VWelfareDrawDetailObj> selfVWelfareDrawDetailList = selfVWelfareDrawDetail.getVwelfareDrawDetailList();
            for(int i=0; i<selfVWelfareDrawDetailList.size() ;i++)
            { 
            	VWelfareDrawDetailObj o = selfVWelfareDrawDetailList.get(i);
           	%>
            <tr class="list_table_tr0">
              	<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_name()) %></td>
            	<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_start_time_show())%></td>
				<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_end_time_show())%></td>
				<td><%=StringUtil.getNotEmptyStr(o.getProduct_name()) %></td>
				<td><%=StringUtil.getNotEmptyStr(o.getProduct_spec()) %></td>
				<td><%=StringUtil.getNotEmptyStr(o.getProduct_measuring_unit()) %></td>
				<td align="right"><%=StringUtil.getNotEmptyStr(o.getProduct_quantity_drawed()) %></td>
            </tr>
           <%} %>
        </table>
        <%} %>
						
						
		<!-- 绑定的村民 -->
		
		<% 
		for(int n=0; n< bindingVWfareDrawList.size(); n++)
		{
			VWelfareDrawDetailPerVillagerObj vWelfareDrawDetailBinding = bindingVWfareDrawList.get(n);
			List<VWelfareDrawDetailObj> bindingVWelfareDrawDetailList = vWelfareDrawDetailBinding.getVwelfareDrawDetailList();
	        if(bindingVWelfareDrawDetailList.size()>0)
	        {
	    %>
		<div style="height: 5px;"></div>				
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr>
				<td height="25" align="left" class="">
				<strong>&nbsp;绑定人 <%=vWelfareDrawDetailBinding.getVillager().getVillager_name()+"/"+vWelfareDrawDetailBinding.getVillager().getId_card()%> 的福利</strong>
				</td>
			</tr>
			<tr>
				<td  height="2" bgcolor="#3DAEB6"></td>
			</tr>
		</table>
		<table width="100%"  border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
            <tr class="list_table_head">
              <td>福利政策名称</td>
              <td>福利开始日期</td>
              <td>福利结束日期</td>
              <td>商品名</td>
              <td>商品规格</td>
              <td>商品单位</td>
              <td><font color="blue">本次领取数</font></td>
            </tr>
            <% 
            for(int i=0;i<bindingVWelfareDrawDetailList.size();i++)
            { 
            	VWelfareDrawDetailObj o = bindingVWelfareDrawDetailList.get(i);
            %>
            <tr class="list_table_tr0">
              	<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_name()) %></td>
            	<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_start_time_show())%></td>
				<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_end_time_show())%></td>
				<td><%=StringUtil.getNotEmptyStr(o.getProduct_name()) %></td>
				<td><%=StringUtil.getNotEmptyStr(o.getProduct_spec()) %></td>
				<td><%=StringUtil.getNotEmptyStr(o.getProduct_measuring_unit()) %></td>
				<td align="right"><%=StringUtil.getNotEmptyStr(o.getProduct_quantity_drawed()) %></td>
			</tr>
           <%} %>
        </table>
	<%} //某个人的福利信息结束
	}// 所有福利人的信息结束
	%>
	
		<!-- 本次领取统计信息 -->
		<div style="height: 5px;"></div>
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr>
				<td height="25" align="left" class="">
				<strong>&nbsp;合计</strong>
				</td>
			</tr>
			<tr>
				<td  height="2" bgcolor="#3DAEB6"></td>
			</tr>
		</table>
		<table width="100%"  border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
            <tr class="list_table_head">
              <td>商品名</td>
              <td>商品规格</td>
              <td>商品单位</td>
              <td><font color="blue">本次领取总数</font></td>
            </tr>
    		<%for(int m=0; m<vwelfareDrawStatByDrawidList.size(); m++)
    		{ 
    			VWelfareDrawStatByDrawidObj vwelfareDrawStatByDrawid = vwelfareDrawStatByDrawidList.get(m);
    		%>
            <tr class="list_table_tr0">
              	<td><%=StringUtil.getNotEmptyStr(vwelfareDrawStatByDrawid.getProduct_name())%></td>
              	<td><%=StringUtil.getNotEmptyStr(vwelfareDrawStatByDrawid.getProduct_spec())%></td> 
              	<td><%=StringUtil.getNotEmptyStr(vwelfareDrawStatByDrawid.getProduct_measuring_unit())%></td>
				<td><%=StringUtil.getNotEmptyStr(vwelfareDrawStatByDrawid.getProduct_quantity_drawed_sum())%></td>
            </tr>
            <%} %>
        </table>
	
		<div style="height: 5px;"></div>
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="">
			<tr>
				<td>
				<div style="height: 10px;"></div>
				<strong>&nbsp;本次领取的基本信息</strong>
				</td>
			</tr>
			<tr>
				<td  height="2" bgcolor="#3DAEB6"></td>
			</tr>
			<tr class="list_table_tr0">
				<td>
				福利领取系统单据编号：<%=StringUtil.getNotEmptyStr(villagerWelfareDraw.getId())%>
				&nbsp;&nbsp;&nbsp;&nbsp;
				T1系统销售单据编号：<%=StringUtil.getNotEmptyStr(request.getAttribute("t1MasterBillSn"))%>
				&nbsp;&nbsp;&nbsp;&nbsp;
				领取方式：<%=villagerWelfareDraw.getDraw_type()%>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<%="他人代领".equals(villagerWelfareDraw.getDraw_type())?("代领人姓名：" + villagerWelfareDraw.getProxy_villager_name()):"" %>
				&nbsp;&nbsp;&nbsp;&nbsp;
				备注信息：<%=StringUtil.getNotEmptyStr(villagerWelfareDraw.getDraw_comment())%>
				</td>
			</tr>
			<tr class="list_table_tr0">
			<td height="40"align="right" >
				签名：<u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<%=villagerWelfareDraw.getDraw_date_show() %>
			</td>
			</tr>
	</table>
<%} %>
		
	
	</td>
	</tr>
</table>

</div>
</body>
</html>
	<div align="right" height="40">
	<img src="../images/print.png"  title="打印当前页"  class="image_button" align="absmiddle" onclick="printme();" />
	</div>