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
	 * 增加或修改福利政策
	 * 
	 * @param welfarePolicyObj
	 * @return
	 * @throws Exception
	 */
	public boolean addOrModifyWelfarePolicy(WelfarePolicyObj welfarePolicyObj) throws Exception
	{
		boolean isAdd = welfarePolicyObj.getKeyValue() <= 0;// 新增

		// 先保存或修改福利基本信息
		if (isAdd)
		{
			welfarePolicyObj.setId(welfarePolicyDAO.getMaxKeyValue());
		}
		boolean success = welfarePolicyDAO.saveOrUpdate(welfarePolicyObj);

		// 再保存或修改或删除福利明细
		for (int i = 0; i < welfarePolicyObj.getUsedDetailList().size(); i++)
		{

			WelfarePolicyDetailObj detailObj = welfarePolicyObj.getUsedDetailList().get(i);

			// 设置福利政策编号
			detailObj.setWelfare_policy_id(welfarePolicyObj.getId());

			// 数量大于零的，进行新增或修改操作
			if (detailObj.getProduct_quantity() > 0)
			{
				if (detailObj.getKeyValue() <= 0)
				{
					detailObj.setId(welfarePolicyDetailDAO.getMaxKeyValue());
				}
				success &= welfarePolicyDetailDAO.saveOrUpdate(detailObj);
			}
			// 数量等于0的，进行删除操作，如果已经发放的则不允许删除，前台就控制好不允许对已发放的做修改，这里不控制
			else
			{
				if (detailObj.getKeyValue() > 0)
				{
					success &= (welfarePolicyDetailDAO.deleteByKey(detailObj.getKeyValue() + "") >= 0);
				}
			}
		}

		// 最后如果是用用到所有村民的话，则应用到所有状态为"启用"的村民（先删除原来的关联关系，再插入新的关联关系）
		if (isAdd && "true".equalsIgnoreCase(welfarePolicyObj.getWelfare_policy_for_all()))
		{
			villagerWelfareDAO.deleteByClause("welfare_policy_id='" + welfarePolicyObj.getId() + "'");// 先删除原来的

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

		// 该福利政策已使用的商品列表
		String usedDetailListWhere = "welfare_policy_id='" + policyId + "'";

		List usedDetailList = welfarePolicyDetailDAO.searchByClause(WelfarePolicyDetailObj.class, usedDetailListWhere, null, 0, Integer.MAX_VALUE);

		welfarePolicyObj.setUsedDetailList(usedDetailList);

		// 该福利政策未使用的商品列表
		String notUseProductListWhere = "id not in (select " + MySqlUtil.getIsNullFunction(SystemConstant.DEFAULT_DB)
				+ "(product_id,-1) from WELFARE_POLICY_DETAIL where welfare_policy_id='" + policyId + "' )";

		List notUseProductList = productDAO.searchByClause(ProductObj.class, notUseProductListWhere, null, 0, Integer.MAX_VALUE);

		welfarePolicyObj.setNotUseProductList(notUseProductList);

		welfarePolicyObj.setNotUseProductList(notUseProductList);

		return welfarePolicyObj;

	}

	public boolean deleteWelfarePolicy(long welfarePolicyId)
	{
		// 删除基本信息
		int num = welfarePolicyDAO.deleteByKey(welfarePolicyId + "");

		// 删除详细信息
		if (num > 0)
		{
			num = welfarePolicyDetailDAO.deleteByParentKey(welfarePolicyId + "");
		}

		// 删除村民福利关联信息
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
