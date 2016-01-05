package com.fuli.obj;

import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import com.wuyg.common.dao.DefaultBaseDAO;
import com.wuyg.common.dao.IBaseDAO;
import com.wuyg.common.util.StringUtil;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

public class VillagerObj extends BaseDbObj
{
	private Long id;
	private String id_card;
	private String villager_name;
	private String villager_sex;
	private String villager_telephone;
	private String villager_omment;
	private String last_modify_account;
	private Timestamp last_modify_time;
	private String enable;
	private String binding_to_id;

	private List<WelfarePolicyObj> usedWelfareList = new ArrayList<WelfarePolicyObj>();// 已享受福利

	private List<WelfarePolicyObj> notUsedWelfareList = new ArrayList<WelfarePolicyObj>(); // 未享受福利

	private List<VillagerObj> bindingVillagerList = new ArrayList<VillagerObj>();// 绑定的村民信息
	
	public static final String STATUS_ENABLE="启用";
	public static final String STATUS_DISABLE="停用";

	@Override
	public String findKeyColumnName()
	{
		return "id";
	}

	@Override
	public String findParentKeyColumnName()
	{
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String findTableName()
	{
		return "villager";
	}

	@Override
	public String getBasePath()
	{
		return "Villager";
	}

	@Override
	public String getCnName()
	{
		return "村民";
	}

	public LinkedHashMap<String, String> getProperties()
	{
		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();

		pros.put("id", "编号");
		pros.put("villager_name", "姓名");
		pros.put("id_card", "身份证号");
		pros.put("villager_sex", "性别");
		pros.put("villager_telephone", "电话");
		pros.put("villager_omment", "备注");
		pros.put("enable", "是否启用");
		pros.put("binding_to_villager_name", "绑定到");

		return pros;
	}

	// 获取绑定到的人名
	public String getBinding_to_villager_name()
	{
		if (StringUtil.isEmpty(binding_to_id))
		{
			return null;
		}

		IBaseDAO villagerDAO = new DefaultBaseDAO(VillagerObj.class);
		
		Object villagerObj = villagerDAO.searchByKey(this.getClass(), binding_to_id);

		if (villagerObj != null)
		{
			return ((VillagerObj) villagerObj).getVillager_name();
		}

		return binding_to_id;
	}

	// 是否已被绑定
	public boolean isBindinged()
	{
		IBaseDAO villagerDAO = new DefaultBaseDAO(VillagerObj.class);
		List list = villagerDAO.searchByClause(this.getClass(), " binding_to_id='" + this.id + "'", null, 0, 1);
		return list.size() > 0;
	}
	
	// 没分配福利的可以删除
	public boolean canDelete()
	{
		IBaseDAO villageWelfareDAO=new DefaultBaseDAO(VillagerWelfareObj.class);
		
		return villageWelfareDAO.searchByClause(VillagerWelfareObj.class, "villager_id='"+this.id+"'", null, 0, 1).size()==0;
	}

	public String getBinding_to_id()
	{
		return binding_to_id;
	}

	public void setBinding_to_id(String binding_to_id)
	{
		this.binding_to_id = binding_to_id;
	}

	public List<VillagerObj> getBindingVillagerList()
	{
		return bindingVillagerList;
	}

	public void setBindingVillagerList(List<VillagerObj> bindingVillagerList)
	{
		this.bindingVillagerList = bindingVillagerList;
	}

	public List<WelfarePolicyObj> getUsedWelfareList()
	{
		return usedWelfareList;
	}

	public void setUsedWelfareList(List<WelfarePolicyObj> usedWelfareList)
	{
		this.usedWelfareList = usedWelfareList;
	}

	public List<WelfarePolicyObj> getNotUsedWelfareList()
	{
		return notUsedWelfareList;
	}

	public void setNotUsedWelfareList(List<WelfarePolicyObj> notUsedWelfareList)
	{
		this.notUsedWelfareList = notUsedWelfareList;
	}

	public Long getId()
	{
		return id;
	}

	public void setId(Long id)
	{
		this.id = id;
	}

	public String getId_card()
	{
		return id_card;
	}

	public void setId_card(String id_card)
	{
		this.id_card = id_card;
	}

	public String getVillager_name()
	{
		return villager_name;
	}

	public void setVillager_name(String villager_name)
	{
		this.villager_name = villager_name;
	}

	public String getVillager_sex()
	{
		return villager_sex;
	}

	public void setVillager_sex(String villager_sex)
	{
		this.villager_sex = villager_sex;
	}

	public String getVillager_telephone()
	{
		return villager_telephone;
	}

	public void setVillager_telephone(String villager_telephone)
	{
		this.villager_telephone = villager_telephone;
	}

	public String getVillager_omment()
	{
		return villager_omment;
	}

	public void setVillager_omment(String villager_omment)
	{
		this.villager_omment = villager_omment;
	}

	public String getLast_modify_account()
	{
		return last_modify_account;
	}

	public void setLast_modify_account(String last_modify_account)
	{
		this.last_modify_account = last_modify_account;
	}

	public Timestamp getLast_modify_time()
	{
		return last_modify_time;
	}

	public void setLast_modify_time(Timestamp last_modify_time)
	{
		this.last_modify_time = last_modify_time;
	}

	public String getEnable()
	{
		return enable;
	}

	public void setEnable(String enable)
	{
		this.enable = enable;
	}
}
