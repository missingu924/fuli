package com.fuli.service;

import java.util.ArrayList;
import java.util.List;

import com.fuli.obj.VillagerObj;
import com.fuli.obj.VillagerWelfareObj;
import com.fuli.obj.WelfarePolicyObj;
import com.hz.util.SystemConstant;
import com.wuyg.common.dao.DefaultBaseDAO;
import com.wuyg.common.dao.IBaseDAO;
import com.wuyg.common.util.MySqlUtil;
import com.wuyg.common.util.StringUtil;

public class VillagerService
{
	IBaseDAO welfarePolicyDAO = new DefaultBaseDAO(WelfarePolicyObj.class);
	IBaseDAO villagerDAO = new DefaultBaseDAO(VillagerObj.class);
	IBaseDAO villagerWelfareDAO = new DefaultBaseDAO(VillagerWelfareObj.class);

	/**
	 * ���ӻ��޸ĸ�������
	 * 
	 * @param welfarePolicyObj
	 * @return
	 * @throws Exception
	 */
	public boolean addOrModifyVillager(VillagerObj villagerObj) throws Exception
	{
		// �ȱ�����޸Ĵ��������Ϣ
		if (villagerObj.getKeyValue() <= 0)
		{
			villagerObj.setId(villagerDAO.getMaxKeyValue());
		}
		boolean success = villagerDAO.saveOrUpdate(villagerObj);

		// �ٱ�����޸Ļ�ɾ����������

		// ��ɾ��������
		// --���� ������ + �������߱�ţ�ɾ�������ϴ����������
		// where villager_id=? and welfare_id not in (?)
		List<String> usedWelfareIdList = new ArrayList<String>();
		usedWelfareIdList.add("-1");// Ĭ�ϼ�һ������ֹǰ̨ʲô����ѡʱ����
		for (int i = 0; i < villagerObj.getUsedWelfareList().size(); i++)
		{
			usedWelfareIdList.add(villagerObj.getUsedWelfareList().get(i).getId() + "");
		}
		villagerWelfareDAO.deleteByClause(" villager_id='" + villagerObj.getKeyValue() + "' and welfare_policy_id not in("
				+ StringUtil.getStringByListWithQuotation(usedWelfareIdList) + ")");

		// --���� ������ + �������߱�� ��ѯ�����벻���ϴ����������
		// where villager_id=? and welfare_id=?
		for (int i = 0; i < villagerObj.getUsedWelfareList().size(); i++)
		{
			WelfarePolicyObj welfarePolicyObj = villagerObj.getUsedWelfareList().get(i);

			if (villagerWelfareDAO.searchByClause(VillagerWelfareObj.class,
					" villager_id='" + villagerObj.getKeyValue() + "' and welfare_policy_id='" + welfarePolicyObj.getId() + "'", null, 0, 1).size() == 0)
			{
				// ����
				// ���ô����� �� �������
				VillagerWelfareObj villagerWelfareObj = new VillagerWelfareObj();
				villagerWelfareObj.setId(villagerWelfareDAO.getMaxKeyValue());
				villagerWelfareObj.setVillager_id(villagerObj.getId() + "");
				villagerWelfareObj.setWelfare_policy_id(welfarePolicyObj.getId());

				villagerWelfareObj.setLast_modify_account(welfarePolicyObj.getLast_modify_account());
				villagerWelfareObj.setLast_modify_time(welfarePolicyObj.getLast_modify_time());

				villagerWelfareDAO.save(villagerWelfareObj);
			}
		}

		return success;
	}

	public VillagerObj searchVillagerByKey(long villagerId)
	{
		VillagerObj villagerObj = new VillagerObj();
		if (villagerId > 0)
		{
			villagerObj = (VillagerObj) villagerDAO.searchByKey(VillagerObj.class, villagerId + "");
		}

		// �ô��������ܵĸ�������
		String usedWelfareListWhere = "id in (select " + MySqlUtil.getIsNullFunction(SystemConstant.DEFAULT_DB)
				+ "(welfare_policy_id,-1) from VILLAGER_WELFARE where villager_id='" + villagerId + "' )";
		List usedWelfareList = welfarePolicyDAO.searchByClause(WelfarePolicyObj.class, usedWelfareListWhere, null, 0, Integer.MAX_VALUE);
		villagerObj.setUsedWelfareList(usedWelfareList);

		// �ô���δ�����ܵĸ�������
		String notUsedWelfareListWhere = "id not in (select " + MySqlUtil.getIsNullFunction(SystemConstant.DEFAULT_DB)
				+ "(welfare_policy_id,-1) from VILLAGER_WELFARE where villager_id='" + villagerId + "' )";
		List notUseProductList = welfarePolicyDAO.searchByClause(WelfarePolicyObj.class, notUsedWelfareListWhere, null, 0, Integer.MAX_VALUE);
		villagerObj.setNotUsedWelfareList(notUseProductList);

		// �󶨵Ĵ�����Ϣ
		String bindingVillagerListWhere = "binding_to_id='" + villagerId + "'";
		List bindingVillagerList = villagerDAO.searchByClause(VillagerObj.class, bindingVillagerListWhere, null, 0, Integer.MAX_VALUE);
		villagerObj.setBindingVillagerList(bindingVillagerList);

		return villagerObj;
	}

	public boolean deleteVillager(long villagerId)
	{
		int num = welfarePolicyDAO.deleteByKey(villagerId + "");

		if (num > 0)
		{
			num = villagerWelfareDAO.deleteByParentKey(villagerId + "");
		}

		return num >= 0;
	}

	public void unbind(long villagerId)
	{
		VillagerObj villagerObj = new VillagerObj();
		villagerDAO.executeSql("update " + villagerObj.findTableName() + " set binding_to_id=null where " + villagerObj.findKeyColumnName() + " = '" + villagerId + "'");
	}
}
