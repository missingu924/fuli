package com.fuli;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.fuli.obj.VWelfareDrawDetailObj;
import com.fuli.obj.VWelfareDrawDetailPerVillagerObj;
import com.fuli.obj.VWelfareDrawStatByDrawidObj;
import com.fuli.obj.VWelfareForDrawDetailObj;
import com.fuli.obj.VWelfareForDrawDetailPerVillagerObj;
import com.fuli.obj.VillagerObj;
import com.fuli.obj.VillagerWelfareDrawDetailObj;
import com.fuli.obj.VillagerWelfareDrawObj;
import com.hz.util.SystemConstant;
import com.t1.T1Util;
import com.wuyg.common.dao.DefaultBaseDAO;
import com.wuyg.common.dao.IBaseDAO;
import com.wuyg.common.obj.PaginationObj;
import com.wuyg.common.servlet.AbstractBaseServletTemplate;
import com.wuyg.common.util.MySqlUtil;
import com.wuyg.common.util.StringUtil;

public class VillagerWelfareDrawServlet extends AbstractBaseServletTemplate
{
	private Logger logger = Logger.getLogger(getClass());

	@Override
	public String getBasePath()
	{
		return "VillagerWelfareDraw";
	}

	@Override
	public IBaseDAO getDomainDao()
	{
		return new DefaultBaseDAO(getDomainInstanceClz());
	}

	@Override
	public Class getDomainInstanceClz()
	{
		return com.fuli.obj.VillagerWelfareDrawObj.class;
	}

	@Override
	public Class getDomainSearchConditionClz()
	{
		return com.fuli.searchcondition.VillagerWelfareDrawObjSearchCondition.class;
	}

	// 查询
	public void list4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.list(request, response);
	}

	// 检查ID是否已录入系统
	public void checkId4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.checkId(request, response);
	}

	// 增加 or 修改
	public void addOrModify4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		VillagerWelfareDrawObj villagerWelfareDrawObj = (VillagerWelfareDrawObj) domainInstance;
		villagerWelfareDrawObj.setLast_modify_accout(currentUser.getAccount());
		villagerWelfareDrawObj.setLast_modify_time(new Timestamp(System.currentTimeMillis()));
		super.addOrModify(request, response);
	}

	// 修改前查询领域对象信息
	private void preModify4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.preModify(request, response);
	}

	// 详情
	public void detail4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.detail(request, response);
	}

	// 删除
	protected void delete4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.delete(request, response);
	}

	// 导出
	public void export4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.export(request, response);
	}

	// 查询该村民可领取的福利
	public void preDraw(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		IBaseDAO villgerDAO = new DefaultBaseDAO(VillagerObj.class);
		IBaseDAO VWelfareForDrawDetailDAO = new DefaultBaseDAO(VWelfareForDrawDetailObj.class);

		String villagerIdCard = request.getParameter("id_card");

		request.setAttribute("id_card", villagerIdCard);// 传回前端

		// 查询该村民自身基本信息
		List villagerObjList = villgerDAO.searchByClause(VillagerObj.class, "id_card='" + villagerIdCard + "'", null, 0, 1);
		if (villagerObjList != null && villagerObjList.size() > 0)
		{
			VillagerObj villager = (VillagerObj) villagerObjList.get(0);
			request.setAttribute("villager", villager);

			// ====1、查询该村民自身可领取福利
			VWelfareForDrawDetailPerVillagerObj vWelfareForDrawDetailPerVillagerObj = new VWelfareForDrawDetailPerVillagerObj();
			List<VWelfareForDrawDetailObj> selfVWelfareForDrawDetailList = VWelfareForDrawDetailDAO.searchByClause(VWelfareForDrawDetailObj.class, "villager_id='" + villager.getId() + "' and welfare_policy_start_time<" + MySqlUtil.getCurrentTimeFunction(SystemConstant.DEFAULT_DB)
					+ " and welfare_policy_end_time>" + MySqlUtil.getCurrentTimeFunction(SystemConstant.DEFAULT_DB) + "", "villager_name,welfare_policy_id,product_id", 0, Integer.MAX_VALUE);
			vWelfareForDrawDetailPerVillagerObj.setVillager(villager);
			vWelfareForDrawDetailPerVillagerObj.setVwelfareForDrawDetailList(selfVWelfareForDrawDetailList);
			// 传到前台
			request.setAttribute("selfVWelfareForDraw", vWelfareForDrawDetailPerVillagerObj);

			// =====2、查询绑定到该村名下的其他村民的可领取福利
			List<VWelfareForDrawDetailPerVillagerObj> bindingVWelfareForDraw = new ArrayList<VWelfareForDrawDetailPerVillagerObj>();
			IBaseDAO villagerDAO = new DefaultBaseDAO(VillagerObj.class);
			// 2.1查询出所有绑定到该村民名下的其他村民
			List<VillagerObj> bindingVillagerList = villagerDAO.searchByClause(VillagerObj.class, "binding_to_id='" + villager.getId() + "' and enable='" + VillagerObj.STATUS_ENABLE + "'", null, 0, Integer.MAX_VALUE);
			// 2.2查询这些绑定的村民享受的福利待遇
			for (int i = 0; i < bindingVillagerList.size(); i++)
			{
				VWelfareForDrawDetailPerVillagerObj vWelfareForDrawDetailPerVillagerObjBinding = new VWelfareForDrawDetailPerVillagerObj();
				VillagerObj bindingVillager = bindingVillagerList.get(i);
				List<VWelfareForDrawDetailObj> bindingVWelfareForDrawDetailList = VWelfareForDrawDetailDAO.searchByClause(VWelfareForDrawDetailObj.class, "villager_id ='" + bindingVillager.getId() + "' and welfare_policy_start_time<" + MySqlUtil.getCurrentTimeFunction(SystemConstant.DEFAULT_DB)
						+ " and welfare_policy_end_time>" + MySqlUtil.getCurrentTimeFunction(SystemConstant.DEFAULT_DB) + "", "villager_name,welfare_policy_id,product_id", 0, Integer.MAX_VALUE);
				if (bindingVWelfareForDrawDetailList.size() > 0)
				{
					// 有福利，不管是不是已经领完了
					vWelfareForDrawDetailPerVillagerObjBinding.setVillager(bindingVillager);
					vWelfareForDrawDetailPerVillagerObjBinding.setVwelfareForDrawDetailList(bindingVWelfareForDrawDetailList);

					bindingVWelfareForDraw.add(vWelfareForDrawDetailPerVillagerObjBinding);
				}
			}
			// 传到前台
			request.setAttribute("bindingVWelfareForDraw", bindingVWelfareForDraw);
		} else
		{
			request.setAttribute("message", "该身份证尚未录入系统，请您核实");
		}

		// 转向
		request.getRequestDispatcher("/" + getBasePath() + "/draw.jsp").forward(request, response);

	}

	// 领取福利
	public void drawWelfare(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String baseInfo = "==========领取福利：";

		logger.info(baseInfo + "开始==========");

		// 1、解析本次福利领取的信息并保存入库

		// 1.1基本信息保存入库
		VillagerWelfareDrawObj villagerWelfareDrawObj = (VillagerWelfareDrawObj) domainInstance;
		villagerWelfareDrawObj.setId(getDomainDao().getMaxKeyValue());
		villagerWelfareDrawObj.setLast_modify_accout(currentUser.getAccount());
		villagerWelfareDrawObj.setLast_modify_time(new Timestamp(System.currentTimeMillis()));
		getDomainDao().save(villagerWelfareDrawObj);
		logger.info(baseInfo + "基本信息保存入库完成");

		// 1.2“领取明细”信息保存入库
		String villagerWelfareId_productId_list_str = StringUtil.getNotEmptyStr(request.getParameter("villagerWelfareId_productId_list"));
		String[] villagerWelfareId_productId_list = villagerWelfareId_productId_list_str.split("\\|");
		IBaseDAO villagerWelfareDrawDetailDAO = new DefaultBaseDAO(VillagerWelfareDrawDetailObj.class);
		for (int i = 0; i < villagerWelfareId_productId_list.length; i++)
		{
			String villagerWelfareId_productId = villagerWelfareId_productId_list[i];
			long quantity_draw = StringUtil.parseLong(request.getParameter(villagerWelfareId_productId + "_select"));
			long villager_welfare_id = StringUtil.parseLong(villagerWelfareId_productId.split("_")[0]);
			long product_id = StringUtil.parseLong(villagerWelfareId_productId.split("_")[1]);

			if (quantity_draw > 0)
			{
				VillagerWelfareDrawDetailObj detail = new VillagerWelfareDrawDetailObj();
				detail.setId(villagerWelfareDrawDetailDAO.getMaxKeyValue());
				// 本次领取记录号
				detail.setVillager_welfare_draw_id(villagerWelfareDrawObj.getId());
				// 领取的福利明细编号
				detail.setVillager_welfare_id(villager_welfare_id);
				// 领取的产品号
				detail.setProduct_id(product_id + "");
				// 领取的产品数量
				detail.setProduct_quantity(quantity_draw);

				detail.setLast_modify_accout(currentUser.getAccount());
				detail.setLast_modify_time(new Timestamp(System.currentTimeMillis()));

				// 明细保存到数据库
				villagerWelfareDrawDetailDAO.save(detail);
			}
		}
		logger.info(baseInfo + "明细保存入库完成");

		// 2、查询保存的结果并展现打印

		// 2.1领取记录
		villagerWelfareDrawObj = (VillagerWelfareDrawObj) getDomainDao().searchByKey(VillagerWelfareDrawObj.class, villagerWelfareDrawObj.getKeyValue() + "");
		request.setAttribute("villagerWelfareDraw", villagerWelfareDrawObj);

		// 2.2领取人信息
		IBaseDAO villagerDAO = new DefaultBaseDAO(VillagerObj.class);
		VillagerObj villagerObj = (VillagerObj) villagerDAO.searchByKey(VillagerObj.class, villagerWelfareDrawObj.getVillager_id() + "");
		request.setAttribute("villager", villagerObj);

		// 2.3领取统计
		IBaseDAO vwelfareDrawStatByDrawidDAO = new DefaultBaseDAO(VWelfareDrawStatByDrawidObj.class);
		List<VWelfareDrawStatByDrawidObj> vwelfareDrawStatByDrawidList = vwelfareDrawStatByDrawidDAO.searchByClause(VWelfareDrawStatByDrawidObj.class, "draw_id='" + villagerWelfareDrawObj.getId() + "'", null, 0, Integer.MAX_VALUE);
		request.setAttribute("vwelfareDrawStatByDrawidList", vwelfareDrawStatByDrawidList);

		// 2.4领取明细
		IBaseDAO vwelfareDrawDetailDAO = new DefaultBaseDAO(VWelfareDrawDetailObj.class);
		// --自己的明細
		VWelfareDrawDetailPerVillagerObj selfVWfareDraw = new VWelfareDrawDetailPerVillagerObj();

		VWelfareDrawDetailPerVillagerObj selfVWelfareDrawDetail = new VWelfareDrawDetailPerVillagerObj();
		List<VWelfareDrawDetailObj> selfVwelfareDrawDetailList = vwelfareDrawDetailDAO.searchByClause(VWelfareDrawDetailObj.class, "villager_id='" + villagerObj.getId() + "' and draw_id='" + villagerWelfareDrawObj.getId() + "'", null, 0, Integer.MAX_VALUE);

		selfVWfareDraw.setVillager(villagerObj);
		selfVWfareDraw.setVwelfareDrawDetailList(selfVwelfareDrawDetailList);
		request.setAttribute("selfVWfareDraw", selfVWfareDraw);

		// --綁定人的明細
		List<VillagerObj> bindingVillagerList = villagerDAO.searchByClause(VillagerObj.class, "binding_to_id='" + villagerObj.getId() + "'", null, 0, Integer.MAX_VALUE);
		List<VWelfareDrawDetailPerVillagerObj> bindingVWfareDrawList = new ArrayList<VWelfareDrawDetailPerVillagerObj>();

		for (int i = 0; i < bindingVillagerList.size(); i++)
		{
			VillagerObj bindingVillager = bindingVillagerList.get(i);
			VWelfareDrawDetailPerVillagerObj bindingVwdd = new VWelfareDrawDetailPerVillagerObj();

			List<VWelfareDrawDetailObj> bindingVwelfareDrawDetailList = vwelfareDrawDetailDAO.searchByClause(VWelfareDrawDetailObj.class, "villager_id='" + bindingVillager.getId() + "' and draw_id='" + villagerWelfareDrawObj.getId() + "'", null, 0, Integer.MAX_VALUE);

			bindingVwdd.setVillager(bindingVillager);
			bindingVwdd.setVwelfareDrawDetailList(bindingVwelfareDrawDetailList);

			bindingVWfareDrawList.add(bindingVwdd);
		}

		request.setAttribute("bindingVWfareDrawList", bindingVWfareDrawList);

		logger.info(baseInfo + "入库后信息查询完成");

		// 3、保存入T1并返回T1中的单号
		String t1MasterBillSn = T1Util.createBillDraft(vwelfareDrawStatByDrawidList, currentUser);
		request.setAttribute("t1MasterBillSn", t1MasterBillSn);
		// =====将T1返回的单号更新到福利领取主表中
		VillagerWelfareDrawObj t1billsnUpdateObj = new VillagerWelfareDrawObj();
		t1billsnUpdateObj.setId(villagerWelfareDrawObj.getId());
		t1billsnUpdateObj.setT1_billsn(t1MasterBillSn);
		getDomainDao().update(t1billsnUpdateObj);

		logger.info(baseInfo + "调用T1接口完成");

		logger.info(baseInfo + "结束=========");

		// 转向
		request.getRequestDispatcher("/" + getBasePath() + "/drawed4sign.jsp").forward(request, response);

	}
}
