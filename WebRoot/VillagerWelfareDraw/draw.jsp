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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>领取福利</title>
		<link href="../style.css" rel="stylesheet" type="text/css" />
	</head>
	<script src="../js/jquery-2.0.3.min.js"></script>
	<script src="../js/utils.js"></script>

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
		   
		   	// 提交查询
		   $('#preDrawForm').submit();
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
	<%
			String basePath="VillagerWelfareDraw";// 每个功能都不同
			
			String contextPath = request.getContextPath();
			AuthUser user = (AuthUser) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);
			
			Object message = request.getAttribute("message");
			
			Object tmpObj = null;
			
			// 村民基本信息
			tmpObj = request.getAttribute("villager");
			VillagerObj villager = (tmpObj!=null?(VillagerObj)tmpObj:null);
			
			// 该村民自身可领取福利
			tmpObj = request.getAttribute("selfVWelfareForDraw");
			VWelfareForDrawDetailPerVillagerObj selfVWelfareForDraw = (tmpObj!=null?(VWelfareForDrawDetailPerVillagerObj)tmpObj:null);

			// 绑定到该村名下的其他村民的可领取福利
			tmpObj = request.getAttribute("bindingVWelfareForDraw");
			List<VWelfareForDrawDetailPerVillagerObj> bindingVWelfareForDraw = (tmpObj!=null?(List<VWelfareForDrawDetailPerVillagerObj>)tmpObj:null);
			
			// 每条福利明细的编号列表，villager_welfare_id与product_id之间用下划线_连接，然后多个之间用竖线|分隔
			String villagerWelfareId_productId_list = "";
		%>
	<body onload="HideActiveX()">
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
		<form id="preDrawForm" name="preDrawForm" action="<%=contextPath %>/<%=basePath%>/Servlet">
		<div style="height: <%=villager!=null?"10px":"150px" %>; vertical-align:middle" align="center"></div>
		<div align="center">
			<table width="95%" border="0" cellspacing="0" cellpadding="0" align="center">
			  <tr>
			  	<td colspan="2" height="25" align="left"><font color="red"><%=StringUtil.getNotEmptyStr(message) %></font></td>
			  </tr>
	          <tr>
	            <td width="40" align="right" valign="middle">
	            <input name="method" id="method"  type="hidden" value="preDraw"/>
	            <input name="id_card" id="id_card" type="text" class="input_box_id_card" value="<%=StringUtil.getNotEmptyStr(request.getAttribute("id_card")) %>" size="40"/>
	            </td>
	            <td align="center" valign="middle" class="id_card_button" onclick="javascript:$('#preDrawForm').submit();;">
	            读卡查询该村民可领取的福利
	            </td>
	          </tr>
	        </table>
		</div>
		</form>
		
<form name="drawForm" id="drawForm" action="<%=contextPath%>/<%=basePath %>/Servlet?method=drawWelfare">
		<%if( villager != null){ %>
		<div style="height: 30px;"></div>
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
							已绑定到<a href="#" onClick="openWindow('<%=contextPath%>/Villager/Servlet?method=detailVillager&<%=villager.findKeyColumnName() %>=<%=villager.getBinding_to_id()%>')">
										<%=StringUtil.getNotEmptyStr(villager.getBinding_to_villager_name())%>
										</a>
							<%} %>
				</td>
			</tr>
			<tr>
				<td  height="2" bgcolor="#3DAEB6"></td>
			</tr>
			<tr>
				<td  height="25" align="left" class="">
				<div style="height: 20px;"></div>
				<strong>&nbsp;<%=villager.getVillager_name() %> 本人的福利</strong>
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
              <td>应领数</td>
              <td>已领数</td>
              <td>未领数</td>
              <td><font color="blue">本次领取数</font></td>
            </tr>
            <% 
            List<VWelfareForDrawDetailObj> selfVWelfareForDrawDetailList = selfVWelfareForDraw.getVwelfareForDrawDetailList();
            for(int i=0; i<selfVWelfareForDrawDetailList.size() ;i++)
            { 
            	VWelfareForDrawDetailObj o = selfVWelfareForDrawDetailList.get(i);
            	String villagerWelfareId_productId = o.getVillager_welfare_id()+"_"+o.getProduct_id();
            	villagerWelfareId_productId_list += (villagerWelfareId_productId_list.length()>0?"|":"") + villagerWelfareId_productId;
            %>
            <tr class="list_table_tr0">
              <td><a href="#" onClick="openBigModalDialog('<%=contextPath%>/WelfarePolicy/Servlet?method=detailWelfarePolicy&id=<%=o.getWelfare_policy_id()%>')"><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_name()) %></a></td>
            	<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_start_time_show())%></td>
				<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_end_time_show())%></td>
				<td><%=StringUtil.getNotEmptyStr(o.getProduct_name()) %></td>
				<td><%=StringUtil.getNotEmptyStr(o.getProduct_spec()) %></td>
				<td><%=StringUtil.getNotEmptyStr(o.getProduct_measuring_unit()) %></td>
				<td align="right"><%=StringUtil.getNotEmptyStr(o.getProduct_quantity()) %></td>
				<td align="right">
				<%if(o.getProduct_quantity_drawed()>0){ %>
				<a href="#" onClick="openWindow('<%=contextPath%>/VWelfareDrawDetail/Servlet?method=list&villager_welfare_id=<%=o.getVillager_welfare_id()%>&product_id=<%=o.getProduct_id() %>')">
				<%=StringUtil.getNotEmptyStr(o.getProduct_quantity_drawed()) %>
				</a>
				<%} else { %>
				<%=StringUtil.getNotEmptyStr(o.getProduct_quantity_drawed()) %>
				<%} %>
				</td>
				<td align="right"><%=StringUtil.getNotEmptyStr(o.getProduct_quantity_remainder()) %></td>
				<td align="right">
				<%if (o.getProduct_quantity_remainder()>0) {%>
				<select name="<%=villagerWelfareId_productId+"_select"%>" id="<%=villagerWelfareId_productId+"_select"%>">
				<% for(long j = o.getProduct_quantity_remainder(); j>=0 ; j--){ %>
				<option value="<%=j %>" <%=j==o.getProduct_quantity_remainder()?"selected":"" %>>
				<%=j %>
				</option>
				<%} %>
				</select>
				<%} else {%>
				已领完
				<%} %>
				</td>
            </tr>
           <%} %>
        </table>
						
						
		<!-- 绑定的村民 -->
		
		<% 
		for(int n=0; n< bindingVWelfareForDraw.size(); n++)
		{
			VWelfareForDrawDetailPerVillagerObj vWelfareForDrawDetailBinding = bindingVWelfareForDraw.get(n);
			List<VWelfareForDrawDetailObj> bindingVWelfareForDrawDetailList = vWelfareForDrawDetailBinding.getVwelfareForDrawDetailList();
	        if(bindingVWelfareForDrawDetailList.size()>0)
	        {
	    %>
		<div style="height: 20px;"></div>				
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr>
				<td height="25" align="left" class="">
				<strong>&nbsp;绑定人 <%=vWelfareForDrawDetailBinding.getVillager().getVillager_name()+"/"+vWelfareForDrawDetailBinding.getVillager().getId_card()%> 的福利</strong>
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
              <td>应领数</td>
              <td>已领数</td>
              <td>未领数</td>
              <td><font color="blue">本次领取数</font></td>
            </tr>
            <% 
            for(int i=0;i<bindingVWelfareForDrawDetailList.size();i++)
            { 
            	VWelfareForDrawDetailObj o = bindingVWelfareForDrawDetailList.get(i);
            	String villagerWelfareId_productId = o.getVillager_welfare_id()+"_"+o.getProduct_id();
            	villagerWelfareId_productId_list += (villagerWelfareId_productId_list.length()>0?"|":"") + villagerWelfareId_productId;
            %>
            <tr class="list_table_tr0">
              	<td><a href="#" onClick="openBigModalDialog('<%=contextPath%>/WelfarePolicy/Servlet?method=detailWelfarePolicy&id=<%=o.getWelfare_policy_id()%>')"><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_name()) %></a></td>
            	<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_start_time_show())%></td>
				<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_end_time_show())%></td>
				<td><%=StringUtil.getNotEmptyStr(o.getProduct_name()) %></td>
				<td><%=StringUtil.getNotEmptyStr(o.getProduct_spec()) %></td>
				<td><%=StringUtil.getNotEmptyStr(o.getProduct_measuring_unit()) %></td>
				<td align="right"><%=StringUtil.getNotEmptyStr(o.getProduct_quantity()) %></td>
				<td align="right">
				<%if(o.getProduct_quantity_drawed()>0){ %>
				<a href="#" onClick="openWindow('<%=contextPath%>/VWelfareDrawDetail/Servlet?method=list&villager_welfare_id=<%=o.getVillager_welfare_id()%>&product_id=<%=o.getProduct_id() %>')">
				<%=StringUtil.getNotEmptyStr(o.getProduct_quantity_drawed()) %>
				</a>
				<%} else { %>
				<%=StringUtil.getNotEmptyStr(o.getProduct_quantity_drawed()) %>
				<%} %>
				</td>
				<td align="right"><%=StringUtil.getNotEmptyStr(o.getProduct_quantity_remainder()) %></td>
				<td align="right">
					<%if (o.getProduct_quantity_remainder()>0) {%>
					<select name="<%=villagerWelfareId_productId+"_select" %>" id="<%=villagerWelfareId_productId+"_select" %>">
					<% for(long j = o.getProduct_quantity_remainder(); j>=0 ; j--){ %>
					<option value="<%=j %>" <%=j==o.getProduct_quantity_remainder()?"selected":"" %>>
					<%=j %>
					</option>
					<%} %>
					</select>
					<%} else {%>
					已领完
					<%} %>
				</td>
			</tr>
           <%} %>
        </table>
	<%} //某个人的福利信息结束
	}// 所有福利人的信息结束
	%>
	
		<div style="height: 20px;"></div>
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="">
			<tr>
				<td  height="25" align="left" class="blue_font">
				<div style="height: 20px;"></div>
				&nbsp;填写领取信息
				</td>
			</tr>
			<tr>
				<td  height="2" bgcolor="#3DAEB6"></td>
			</tr>
			<tr class="list_table_tr1">
				<td height="50">
				<input type="hidden" id="method" name="method" value="drawWelfare"/>
				<input type="hidden" id="isFromUrl" name="isFromUrl" value="true" label="用jquery提交相当于是从url提交"/>
				<input type="hidden" id="villager_id" name="villager_id" label="领取人ID" value="<%=villager.getId() %>"/>
				<input type="hidden" id="draw_date" name="draw_date" label="领取时间" value="<%=new Timestamp(System.currentTimeMillis()) %>"/>
				<input type="hidden" id="villagerWelfareId_productId_list" name="villagerWelfareId_productId_list" label="村民福利映射编号+产品编号，可唯一确认一行福利详情" value="<%=villagerWelfareId_productId_list %>"/>
				领取方式：<%=DictionaryUtil.getSelectHtml(new
											DictionaryService().getDictItemsByDictName("drawType", false),
											"draw_type", "领取方式","本人自领",
											"notEmpty")%>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<label name="proxy_villager_name_label" id="proxy_villager_name_label" style="display:none">代领人姓名：</label>
				<input id="proxy_villager_name" name="proxy_villager_name" type="text" style="display:none"></td>
			</tr>
			<tr class="list_table_tr1">
				<td>备注信息：<textarea name="draw_comment" cols="50" rows="3" class="notEmpty" id="draw_comment"></textarea></td>
			</tr>
			<tr class="list_table_tr1">
			<td height="40"align="right" >
				<input name="modifyButton" type="button" class="blue_button" value="          选好了 领福利          " onclick="javascript:drawWelfare()"/>
			</td>
			</tr>
	</table>
	
		<%} %>
		
		
		
		
	</td>
	</tr>
</table>
</form>
<script>

// 光标定位在第一个输入框
$('input:text:first').focus();

// 他人代领时显示代领人姓名输入框
$("#draw_type").change(function(){
	$("#proxy_villager_name").toggle();
	$("#proxy_villager_name_label").toggle();
	
	if($("#draw_type").val()=='本人自领'){
		$("#proxy_villager_name").val('');//清空代领人姓名
	}
});

function drawWelfare(){
	var selectedSomeProduct = false;//是否选择了一些产品
	
	var villagerWelfareId_productId_list = $("#villagerWelfareId_productId_list").val().split("|");
	
	for(var i=0; i<villagerWelfareId_productId_list.length; i++){
	
		var villagerWelfareId_productId = villagerWelfareId_productId_list[i];
		
		var product_quantity_draw = $("#"+villagerWelfareId_productId+"_select").val();
		
		if(product_quantity_draw != null && product_quantity_draw>0){
			selectedSomeProduct = true;
			break;
		}
	}
	
	if(selectedSomeProduct == false){
		alert("还没有选择任何福利产品");
		return;
	}
	
	if($("#draw_type").val()=='他人代领' && $("#proxy_villager_name").val()==""){
		alert("他人代领必须填写代领人姓名");
		return;
	}
	
	// 检查通过后提交保存
	$('#drawForm').submit();
	
}

</script>
</body>
</html>