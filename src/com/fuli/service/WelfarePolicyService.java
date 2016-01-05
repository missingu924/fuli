package com.fuli.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import sun.util.logging.resources.logging;

import com.fuli.obj.ProductObj;
import com.fuli.obj.VillagerObj;
import com.fuli.obj.VillagerWelfareObj;
import com.fuli.obj.WelfarePolicyDetailObj;
import com.fuli.obj.WelfarePolicyObj;
import com.hz.util.SystemConstant;
import com.wuyg.common.dao.DefaultBaseDAO;
import com.wuyg.common.dao.IBaseDAO;
import com.wuyg.common.util.MySqlUtil;

public class WelfarePolicyService
{
	private Logger log = Logger.getLogger(getClass());

	IBaseDAO welfarePolicyDAO = new DefaultBaseDAO(WelfarePolicyObj.class);
	IBaseDAO welfarePolicyDetailDAO = new DefaultBaseDAO(WelfarePolicyDetailObj.class);
	IBaseDAO productDAO = new DefaultBaseDAO(ProductObj.class);
	IBaseDAO villagerWelfareDAO = new DefaultBaseDAO(VillagerWelfareObj.class);
	IBaseDAO villagerDAO = new DefaultBaseDAO(VillagerObj.class);

	/**
	 * ���ӻ��޸ĸ�������
	 * 
	 * @param welfarePolicyObj
	 * @return
	 * @throws Exception
	 */
	public boolean addOrModifyWelfarePolicy(WelfarePolicyObj welfarePolicyObj) throws Exception
	{
		boolean isAdd = welfarePolicyObj.getKeyValue() <= 0;// ����

		// �ȱ�����޸ĸ���������Ϣ
		if (isAdd)
		{
			welfarePolicyObj.setId(welfarePolicyDAO.getMaxKeyValue());
		}
		boolean success = welfarePolicyDAO.saveOrUpdate(welfarePolicyObj);

		// �ٱ�����޸Ļ�ɾ��������ϸ
		for (int i = 0; i < welfarePolicyObj.getUsedDetailList().size(); i++)
		{

			WelfarePolicyDetailObj detailObj = welfarePolicyObj.getUsedDetailList().get(i);

			// ���ø������߱��
			detailObj.setWelfare_policy_id(welfarePolicyObj.getId());

			// ����������ģ������������޸Ĳ���
			if (detailObj.getProduct_quantity() > 0)
			{
				if (detailObj.getKeyValue() <= 0)
				{
					detailObj.setId(welfarePolicyDetailDAO.getMaxKeyValue());
				}
				success &= welfarePolicyDetailDAO.saveOrUpdate(detailObj);
			}
			// ��������0�ģ�����ɾ������������Ѿ����ŵ�������ɾ����ǰ̨�Ϳ��ƺò�������ѷ��ŵ����޸ģ����ﲻ����
			else
			{
				if (detailObj.getKeyValue() > 0)
				{
					success &= (welfarePolicyDetailDAO.deleteByKey(detailObj.getKeyValue() + "") >= 0);
				}
			}
		}

		// �����������õ����д���Ļ�����Ӧ�õ�����״̬Ϊ"����"�Ĵ�����ɾ��ԭ���Ĺ�����ϵ���ٲ����µĹ�����ϵ��
		if (isAdd && "true".equalsIgnoreCase(welfarePolicyObj.getWelfare_policy_for_all()))
		{
			villagerWelfareDAO.deleteByClause("welfare_policy_id='" + welfarePolicyObj.getId() + "'");// ��ɾ��ԭ����

			List<VillagerObj> villagerList = villagerDAO.searchByClause(VillagerObj.class, "enable='" + VillagerObj.STATUS_ENABLE + "'", null, 0, Integer.MAX_VALUE);

			long maxVWid = villagerWelfareDAO.getMaxKeyValue();
			List<VillagerWelfareObj> villagerWelfareList = new ArrayList<VillagerWelfareObj>();
			for (int i = 0; i < villagerList.size(); i++)
			{
				VillagerWelfareObj vw = new VillagerWelfareObj();
				vw.setId(maxVWid++);
				vw.setVillager_id(villagerList.get(i).getId() + "");
				vw.setWelfare_policy_id(welfarePolicyObj.getId());
				villagerWelfareList.add(vw);
			}

			success &= villagerWelfareDAO.save(villagerWelfareList);
		}

		return success;
	}

	public WelfarePolicyObj searchWealfarePolicyByKey(long policyId)
	{
		WelfarePolicyObj welfarePolicyObj = new WelfarePolicyObj();
		if (policyId > 0)
		{
			welfarePolicyObj = (WelfarePolicyObj) welfarePolicyDAO.searchByKey(WelfarePolicyObj.class, policyId + "");
		}

		// �ø���������ʹ�õ���Ʒ�б�
		String usedDetailListWhere = "welfare_policy_id='" + policyId + "'";

		List usedDetailList = welfarePolicyDetailDAO.searchByClause(WelfarePolicyDetailObj.class, usedDetailListWhere, null, 0, Integer.MAX_VALUE);

		welfarePolicyObj.setUsedDetailList(usedDetailList);

		// �ø�������δʹ�õ���Ʒ�б�
		String notUseProductListWhere = "id not in (select " + MySqlUtil.getIsNullFunction(SystemConstant.DEFAULT_DB)
				+ "(product_id,-1) from WELFARE_POLICY_DETAIL where welfare_policy_id='" + policyId + "' )";

		List notUseProductList = productDAO.searchByClause(ProductObj.class, notUseProductListWhere, null, 0, Integer.MAX_VALUE);

		welfarePolicyObj.setNotUseProductList(notUseProductList);

		welfarePolicyObj.setNotUseProductList(notUseProductList);

		return welfarePolicyObj;

	}

	public boolean deleteWelfarePolicy(long welfarePolicyId)
	{
		// ɾ��������Ϣ
		int num = welfarePolicyDAO.deleteByKey(welfarePolicyId + "");

		// ɾ����ϸ��Ϣ
		if (num > 0)
		{
			num = welfarePolicyDetailDAO.deleteByParentKey(welfarePolicyId + "");
		}

		// ɾ��������������Ϣ
		if (num > 0)
		{
			num = villagerWelfareDAO.deleteByClause("welfare_policy_id='" + welfarePolicyId + "'");
		}

		return num >= 0;
	}

	public static void main(String[] args) throws Exception
	{
		WelfarePolicyService service = new WelfarePolicyService();

		WelfarePolicyObj welfarePolicyObj = service.searchWealfarePolicyByKey(1);

		System.out.println();

		welfarePolicyObj = new WelfarePolicyObj();

		List<WelfarePolicyDetailObj> usedList = new ArrayList<WelfarePolicyDetailObj>();
		WelfarePolicyDetailObj detailObj = new WelfarePolicyDetailObj();
		detailObj.setProduct_id("2");
		detailObj.setProduct_quantity(22l);
		usedList.add(detailObj);

		welfarePolicyObj.setUsedDetailList(usedList);

		service.addOrModifyWelfarePolicy(welfarePolicyObj);
	}
}
