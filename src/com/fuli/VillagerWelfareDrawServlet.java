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

	// ��ѯ
	public void list4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.list(request, response);
	}

	// ���ID�Ƿ���¼��ϵͳ
	public void checkId4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.checkId(request, response);
	}

	// ���� or �޸�
	public void addOrModify4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		VillagerWelfareDrawObj villagerWelfareDrawObj = (VillagerWelfareDrawObj) domainInstance;
		villagerWelfareDrawObj.setLast_modify_accout(currentUser.getAccount());
		villagerWelfareDrawObj.setLast_modify_time(new Timestamp(System.currentTimeMillis()));
		super.addOrModify(request, response);
	}

	// �޸�ǰ��ѯ���������Ϣ
	private void preModify4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.preModify(request, response);
	}

	// ����
	public void detail4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.detail(request, response);
	}

	// ɾ��
	protected void delete4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.delete(request, response);
	}

	// ����
	public void export4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.export(request, response);
	}

	// ��ѯ�ô������ȡ�ĸ���
	public void preDraw(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		IBaseDAO villgerDAO = new DefaultBaseDAO(VillagerObj.class);
		IBaseDAO VWelfareForDrawDetailDAO = new DefaultBaseDAO(VWelfareForDrawDetailObj.class);

		String villagerIdCard = request.getParameter("id_card");

		request.setAttribute("id_card", villagerIdCard);// ����ǰ��

		// ��ѯ�ô������������Ϣ
		List villagerObjList = villgerDAO.searchByClause(VillagerObj.class, "id_card='" + villagerIdCard + "'", null, 0, 1);
		if (villagerObjList != null && villagerObjList.size() > 0)
		{
			VillagerObj villager = (VillagerObj) villagerObjList.get(0);
			request.setAttribute("villager", villager);

			// ====1����ѯ�ô����������ȡ����
			VWelfareForDrawDetailPerVillagerObj vWelfareForDrawDetailPerVillagerObj = new VWelfareForDrawDetailPerVillagerObj();
			List<VWelfareForDrawDetailObj> selfVWelfareForDrawDetailList = VWelfareForDrawDetailDAO.searchByClause(VWelfareForDrawDetailObj.class, "villager_id='" + villager.getId() + "' and welfare_policy_start_time<" + MySqlUtil.getCurrentTimeFunction(SystemConstant.DEFAULT_DB)
					+ " and welfare_policy_end_time>" + MySqlUtil.getCurrentTimeFunction(SystemConstant.DEFAULT_DB) + "", "villager_name,welfare_policy_id,product_id", 0, Integer.MAX_VALUE);
			vWelfareForDrawDetailPerVillagerObj.setVillager(villager);
			vWelfareForDrawDetailPerVillagerObj.setVwelfareForDrawDetailList(selfVWelfareForDrawDetailList);
			// ����ǰ̨
			request.setAttribute("selfVWelfareForDraw", vWelfareForDrawDetailPerVillagerObj);

			// =====2����ѯ�󶨵��ô����µ���������Ŀ���ȡ����
			List<VWelfareForDrawDetailPerVillagerObj> bindingVWelfareForDraw = new ArrayList<VWelfareForDrawDetailPerVillagerObj>();
			IBaseDAO villagerDAO = new DefaultBaseDAO(VillagerObj.class);
			// 2.1��ѯ�����а󶨵��ô������µ���������
			List<VillagerObj> bindingVillagerList = villagerDAO.searchByClause(VillagerObj.class, "binding_to_id='" + villager.getId() + "' and enable='" + VillagerObj.STATUS_ENABLE + "'", null, 0, Integer.MAX_VALUE);
			// 2.2��ѯ��Щ�󶨵Ĵ������ܵĸ�������
			for (int i = 0; i < bindingVillagerList.size(); i++)
			{
				VWelfareForDrawDetailPerVillagerObj vWelfareForDrawDetailPerVillagerObjBinding = new VWelfareForDrawDetailPerVillagerObj();
				VillagerObj bindingVillager = bindingVillagerList.get(i);
				List<VWelfareForDrawDetailObj> bindingVWelfareForDrawDetailList = VWelfareForDrawDetailDAO.searchByClause(VWelfareForDrawDetailObj.class, "villager_id ='" + bindingVillager.getId() + "' and welfare_policy_start_time<" + MySqlUtil.getCurrentTimeFunction(SystemConstant.DEFAULT_DB)
						+ " and welfare_policy_end_time>" + MySqlUtil.getCurrentTimeFunction(SystemConstant.DEFAULT_DB) + "", "villager_name,welfare_policy_id,product_id", 0, Integer.MAX_VALUE);
				if (bindingVWelfareForDrawDetailList.size() > 0)
				{
					// �и����������ǲ����Ѿ�������
					vWelfareForDrawDetailPerVillagerObjBinding.setVillager(bindingVillager);
					vWelfareForDrawDetailPerVillagerObjBinding.setVwelfareForDrawDetailList(bindingVWelfareForDrawDetailList);

					bindingVWelfareForDraw.add(vWelfareForDrawDetailPerVillagerObjBinding);
				}
			}
			// ����ǰ̨
			request.setAttribute("bindingVWelfareForDraw", bindingVWelfareForDraw);
		} else
		{
			request.setAttribute("message", "�����֤��δ¼��ϵͳ��������ʵ");
		}

		// ת��
		request.getRequestDispatcher("/" + getBasePath() + "/draw.jsp").forward(request, response);

	}

	// ��ȡ����
	public void drawWelfare(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String baseInfo = "==========��ȡ������";

		logger.info(baseInfo + "��ʼ==========");

		// 1���������θ�����ȡ����Ϣ���������

		// 1.1������Ϣ�������
		VillagerWelfareDrawObj villagerWelfareDrawObj = (VillagerWelfareDrawObj) domainInstance;
		villagerWelfareDrawObj.setId(getDomainDao().getMaxKeyValue());
		villagerWelfareDrawObj.setLast_modify_accout(currentUser.getAccount());
		villagerWelfareDrawObj.setLast_modify_time(new Timestamp(System.currentTimeMillis()));
		getDomainDao().save(villagerWelfareDrawObj);
		logger.info(baseInfo + "������Ϣ����������");

		// 1.2����ȡ��ϸ����Ϣ�������
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
				// ������ȡ��¼��
				detail.setVillager_welfare_draw_id(villagerWelfareDrawObj.getId());
				// ��ȡ�ĸ�����ϸ���
				detail.setVillager_welfare_id(villager_welfare_id);
				// ��ȡ�Ĳ�Ʒ��
				detail.setProduct_id(product_id + "");
				// ��ȡ�Ĳ�Ʒ����
				detail.setProduct_quantity(quantity_draw);

				detail.setLast_modify_accout(currentUser.getAccount());
				detail.setLast_modify_time(new Timestamp(System.currentTimeMillis()));

				// ��ϸ���浽���ݿ�
				villagerWelfareDrawDetailDAO.save(detail);
			}
		}
		logger.info(baseInfo + "��ϸ����������");

		// 2����ѯ����Ľ����չ�ִ�ӡ

		// 2.1��ȡ��¼
		villagerWelfareDrawObj = (VillagerWelfareDrawObj) getDomainDao().searchByKey(VillagerWelfareDrawObj.class, villagerWelfareDrawObj.getKeyValue() + "");
		request.setAttribute("villagerWelfareDraw", villagerWelfareDrawObj);

		// 2.2��ȡ����Ϣ
		IBaseDAO villagerDAO = new DefaultBaseDAO(VillagerObj.class);
		VillagerObj villagerObj = (VillagerObj) villagerDAO.searchByKey(VillagerObj.class, villagerWelfareDrawObj.getVillager_id() + "");
		request.setAttribute("villager", villagerObj);

		// 2.3��ȡͳ��
		IBaseDAO vwelfareDrawStatByDrawidDAO = new DefaultBaseDAO(VWelfareDrawStatByDrawidObj.class);
		List<VWelfareDrawStatByDrawidObj> vwelfareDrawStatByDrawidList = vwelfareDrawStatByDrawidDAO.searchByClause(VWelfareDrawStatByDrawidObj.class, "draw_id='" + villagerWelfareDrawObj.getId() + "'", null, 0, Integer.MAX_VALUE);
		request.setAttribute("vwelfareDrawStatByDrawidList", vwelfareDrawStatByDrawidList);

		// 2.4��ȡ��ϸ
		IBaseDAO vwelfareDrawDetailDAO = new DefaultBaseDAO(VWelfareDrawDetailObj.class);
		// --�Լ�������
		VWelfareDrawDetailPerVillagerObj selfVWfareDraw = new VWelfareDrawDetailPerVillagerObj();

		VWelfareDrawDetailPerVillagerObj selfVWelfareDrawDetail = new VWelfareDrawDetailPerVillagerObj();
		List<VWelfareDrawDetailObj> selfVwelfareDrawDetailList = vwelfareDrawDetailDAO.searchByClause(VWelfareDrawDetailObj.class, "villager_id='" + villagerObj.getId() + "' and draw_id='" + villagerWelfareDrawObj.getId() + "'", null, 0, Integer.MAX_VALUE);

		selfVWfareDraw.setVillager(villagerObj);
		selfVWfareDraw.setVwelfareDrawDetailList(selfVwelfareDrawDetailList);
		request.setAttribute("selfVWfareDraw", selfVWfareDraw);

		// --�����˵�����
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

		logger.info(baseInfo + "������Ϣ��ѯ���");

		// 3��������T1������T1�еĵ���
		String t1MasterBillSn = T1Util.createBillDraft(vwelfareDrawStatByDrawidList, currentUser);
		request.setAttribute("t1MasterBillSn", t1MasterBillSn);
		// =====��T1���صĵ��Ÿ��µ�������ȡ������
		VillagerWelfareDrawObj t1billsnUpdateObj = new VillagerWelfareDrawObj();
		t1billsnUpdateObj.setId(villagerWelfareDrawObj.getId());
		t1billsnUpdateObj.setT1_billsn(t1MasterBillSn);
		getDomainDao().update(t1billsnUpdateObj);

		logger.info(baseInfo + "����T1�ӿ����");

		logger.info(baseInfo + "����=========");

		// ת��
		request.getRequestDispatcher("/" + getBasePath() + "/drawed4sign.jsp").forward(request, response);

	}
}
