package com.t1.obj;

import java.sql.Timestamp;
import java.util.LinkedHashMap;

import com.hz.util.SystemConstant;
import com.wuyg.common.dao.BaseDbObj;

public class MasterbilldftObj extends BaseDbObj
{
	private Long s_id;// 系统ID
	private Long stor_syb;// 单据类影响标志（0、正常库存 1、委托 2、受托 3、低质易耗）
	private Long s_syb;// 0系统1增加-1删除
	private Integer billtype;// 单据类型
	private String billdate;// 单据日期
	private String billtime;// 单据时间
	private String billsn;// 单据编号
	private String abst;// 摘要
	private Integer unit_id;// 往来单位ID
	private Integer area_id;// 地区ID
	private Integer emp_id;// 经手人ID
	private Integer dept_id;// 部门ID
	private Integer sin_id;// 收货仓库ID
	private Integer oper_id;// 操作人员
	private String operdate;// 录单日期
	private Integer audit_id;// 审核人ID
	private String auditdate;// 审核日期
	private Double sumnumber;// 单据商品总量
	private String datelimit;// 收付款期限
	private Double yh_money;// 优惠金额
	private Double ysyf_money;// 单据应收应付金额
	private Double ysyf_remain;// 单据余额
	private Double summoney;// 单据商品折前额
	private Double sumdismoney;// 单据折后金额
	private Double sumtaxmoney;// 单据税价合计额
	private String InvoiceType;// 无 收据 普票 增值税票 其他
	private String InvoiceTypeNO;// 发票号
	private Double invoicetypemoney;// 发票金额
	private Long billstate;// -1、录入单 1、草稿,-2 零售单暂存 -3 盘点抄帐
	private Double UnitsYSYF;// 单位应收应付余额
	private Boolean track;// 是否价格跟踪
	private Timestamp billdatetime;// 保存时间
	private Long integralall;// 会员卡单据消费积分
	private Long yh_discount;// 整单折扣

	@Override
	public String findKeyColumnName()
	{
		return "s_id";
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
		return SystemConstant.T1_DB + "..masterbilldft";
	}

	@Override
	public String getBasePath()
	{
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getCnName()
	{
		// TODO Auto-generated method stub
		return null;
	}

	public LinkedHashMap<String, String> getProperties()
	{
		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();

		pros.put("autoid", "autoid");
		pros.put("s_id", "s_id");
		pros.put("stor_syb", "stor_syb");
		pros.put("s_syb", "s_syb");
		pros.put("billtype", "billtype");
		pros.put("logindate", "logindate");
		pros.put("billdate", "billdate");
		pros.put("billtime", "billtime");
		pros.put("billsn", "billsn");
		pros.put("abst", "abst");
		pros.put("remark", "remark");
		pros.put("unit_id", "unit_id");
		pros.put("area_id", "area_id");
		pros.put("emp_id", "emp_id");
		pros.put("dept_id", "dept_id");
		pros.put("sin_id", "sin_id");
		pros.put("sout_id", "sout_id");
		pros.put("oper_id", "oper_id");
		pros.put("operdate", "operdate");
		pros.put("audit_id", "audit_id");
		pros.put("auditdate", "auditdate");
		pros.put("lyuser_id", "lyuser_id");
		pros.put("pcmoney", "pcmoney");
		pros.put("sumnumber", "sumnumber");
		pros.put("datelimit", "datelimit");
		pros.put("date_yq", "date_yq");
		pros.put("qxwar", "qxwar");
		pros.put("yh_money", "yh_money");
		pros.put("ysyf_money", "ysyf_money");
		pros.put("act_id", "act_id");
		pros.put("act_money", "act_money");
		pros.put("card_money", "card_money");
		pros.put("ysyf_remain", "ysyf_remain");
		pros.put("summoney", "summoney");
		pros.put("sumdismoney", "sumdismoney");
		pros.put("sumtaxmoney", "sumtaxmoney");
		pros.put("yus_yuf_money", "yus_yuf_money");
		pros.put("jsmoney", "jsmoney");
		pros.put("writejsbill", "writejsbill");
		pros.put("period", "period");
		pros.put("invoicetype", "invoicetype");
		pros.put("invoicetypeno", "invoicetypeno");
		pros.put("invoicetypemoney", "invoicetypemoney");
		pros.put("billstate", "billstate");
		pros.put("transcount", "transcount");
		pros.put("lasttranstime", "lasttranstime");
		pros.put("guid", "guid");
		pros.put("posguid", "posguid");
		pros.put("swaptype", "swaptype");
		pros.put("tmpsyb", "tmpsyb");
		pros.put("vip_id", "vip_id");
		pros.put("discount", "discount");
		pros.put("integralall", "integralall");
		pros.put("change", "change");
		pros.put("paymoney", "paymoney");
		pros.put("handnextid", "handnextid");
		pros.put("billdatetime", "billdatetime");
		pros.put("unitsysyf", "unitsysyf");
		pros.put("prttimes", "prttimes");
		pros.put("track", "track");
		pros.put("sumdiffmoney", "sumdiffmoney");
		pros.put("yh_discount", "yh_discount");
		pros.put("unipayno", "unipayno");
		pros.put("remarktype", "remarktype");
		pros.put("teamno", "teamno");
		pros.put("dzsign", "dzsign");
		pros.put("makeufidapz", "makeufidapz");
		pros.put("ufidapzh", "ufidapzh");
		pros.put("ufidapzh2", "ufidapzh2");
		pros.put("firstdate", "firstdate");
		pros.put("makeufidapzlist", "makeufidapzlist");
		pros.put("exc_vipid", "exc_vipid");
		pros.put("exc_recdate", "exc_recdate");
		pros.put("exc_integralall", "exc_integralall");
		pros.put("exc_integralavail", "exc_integralavail");
		pros.put("exc_integral", "exc_integral");
		pros.put("mutilvipcard", "mutilvipcard");
		pros.put("vip_swapintegral", "vip_swapintegral");
		pros.put("vip_swapintegralm", "vip_swapintegralm");
		pros.put("former_bid", "former_bid");
		pros.put("makeufidapzlist1", "makeufidapzlist1");
		pros.put("ufidapzh21", "ufidapzh21");
		pros.put("ufidapzh1", "ufidapzh1");
		pros.put("makeufidapz1", "makeufidapz1");
		pros.put("offsetintegral", "offsetintegral");
		pros.put("offsetmoney", "offsetmoney");
		pros.put("lastdate", "lastdate");
		pros.put("vip_integral", "vip_integral");
		pros.put("vip_usemoney", "vip_usemoney");
		pros.put("vip_moneyall", "vip_moneyall");
		pros.put("syb_ba", "syb_ba");
		pros.put("order_id", "order_id");
		pros.put("inibill", "inibill");
		pros.put("slemail", "slemail");
		pros.put("syb_oper", "syb_oper");
		pros.put("isautopos", "isautopos");
		pros.put("mdformer_bid", "mdformer_bid");
		pros.put("md_autoid", "md_autoid");
		pros.put("ws_id", "ws_id");
		pros.put("vipfinteger", "vipfinteger");
		pros.put("mutilholder", "mutilholder");
		pros.put("mutilvipname", "mutilvipname");
		pros.put("sendaddid", "sendaddid");
		pros.put("sendemp", "sendemp");
		pros.put("thirdpayment", "thirdpayment");
		pros.put("thirdpaymentmoney", "thirdpaymentmoney");
		pros.put("itembillno", "itembillno");
		pros.put("sumshippingmoney", "sumshippingmoney");
		pros.put("srunit", "srunit");
		pros.put("sracount_id", "sracount_id");
		pros.put("sracount_money", "sracount_money");
		pros.put("srjsmoney", "srjsmoney");
		pros.put("zftype", "zftype");
		pros.put("billsendadd", "billsendadd");
		pros.put("writejsbill_ds_yf", "writejsbill_ds_yf");
		return pros;
	}

	public Long getS_id()
	{
		return s_id;
	}

	public void setS_id(Long s_id)
	{
		this.s_id = s_id;
	}

	public Long getStor_syb()
	{
		return stor_syb;
	}

	public void setStor_syb(Long stor_syb)
	{
		this.stor_syb = stor_syb;
	}

	public Long getS_syb()
	{
		return s_syb;
	}

	public void setS_syb(Long s_syb)
	{
		this.s_syb = s_syb;
	}

	public Integer getBilltype()
	{
		return billtype;
	}

	public void setBilltype(Integer billtype)
	{
		this.billtype = billtype;
	}

	public String getBilldate()
	{
		return billdate;
	}

	public void setBilldate(String billdate)
	{
		this.billdate = billdate;
	}

	public String getBilltime()
	{
		return billtime;
	}

	public void setBilltime(String billtime)
	{
		this.billtime = billtime;
	}

	public String getBillsn()
	{
		return billsn;
	}

	public void setBillsn(String billsn)
	{
		this.billsn = billsn;
	}

	public String getAbst()
	{
		return abst;
	}

	public void setAbst(String abst)
	{
		this.abst = abst;
	}

	public Integer getUnit_id()
	{
		return unit_id;
	}

	public void setUnit_id(Integer unit_id)
	{
		this.unit_id = unit_id;
	}

	public Integer getArea_id()
	{
		return area_id;
	}

	public void setArea_id(Integer area_id)
	{
		this.area_id = area_id;
	}

	public Integer getEmp_id()
	{
		return emp_id;
	}

	public void setEmp_id(Integer emp_id)
	{
		this.emp_id = emp_id;
	}

	public Integer getDept_id()
	{
		return dept_id;
	}

	public void setDept_id(Integer dept_id)
	{
		this.dept_id = dept_id;
	}

	public Integer getSin_id()
	{
		return sin_id;
	}

	public void setSin_id(Integer sin_id)
	{
		this.sin_id = sin_id;
	}

	public Integer getOper_id()
	{
		return oper_id;
	}

	public void setOper_id(Integer oper_id)
	{
		this.oper_id = oper_id;
	}

	public String getOperdate()
	{
		return operdate;
	}

	public void setOperdate(String operdate)
	{
		this.operdate = operdate;
	}

	public Integer getAudit_id()
	{
		return audit_id;
	}

	public void setAudit_id(Integer audit_id)
	{
		this.audit_id = audit_id;
	}

	public String getAuditdate()
	{
		return auditdate;
	}

	public void setAuditdate(String auditdate)
	{
		this.auditdate = auditdate;
	}

	public Double getSumnumber()
	{
		return sumnumber;
	}

	public void setSumnumber(Double sumnumber)
	{
		this.sumnumber = sumnumber;
	}

	public String getDatelimit()
	{
		return datelimit;
	}

	public void setDatelimit(String datelimit)
	{
		this.datelimit = datelimit;
	}

	public Double getYh_money()
	{
		return yh_money;
	}

	public void setYh_money(Double yh_money)
	{
		this.yh_money = yh_money;
	}

	public Double getYsyf_money()
	{
		return ysyf_money;
	}

	public void setYsyf_money(Double ysyf_money)
	{
		this.ysyf_money = ysyf_money;
	}

	public void setYsyf_remain(Double ysyf_remain)
	{
		this.ysyf_remain = ysyf_remain;
	}

	public void setSummoney(Double summoney)
	{
		this.summoney = summoney;
	}

	public void setSumdismoney(Double sumdismoney)
	{
		this.sumdismoney = sumdismoney;
	}

	public void setSumtaxmoney(Double sumtaxmoney)
	{
		this.sumtaxmoney = sumtaxmoney;
	}

	public void setUnitsYSYF(Double unitsYSYF)
	{
		UnitsYSYF = unitsYSYF;
	}

	public double getYsyf_remain()
	{
		return ysyf_remain;
	}

	public void setYsyf_remain(double ysyf_remain)
	{
		this.ysyf_remain = ysyf_remain;
	}

	public double getSummoney()
	{
		return summoney;
	}

	public void setSummoney(double summoney)
	{
		this.summoney = summoney;
	}

	public double getSumdismoney()
	{
		return sumdismoney;
	}

	public void setSumdismoney(double sumdismoney)
	{
		this.sumdismoney = sumdismoney;
	}

	public double getSumtaxmoney()
	{
		return sumtaxmoney;
	}

	public void setSumtaxmoney(double sumtaxmoney)
	{
		this.sumtaxmoney = sumtaxmoney;
	}

	public String getInvoiceType()
	{
		return InvoiceType;
	}

	public void setInvoiceType(String invoiceType)
	{
		InvoiceType = invoiceType;
	}

	public String getInvoiceTypeNO()
	{
		return InvoiceTypeNO;
	}

	public void setInvoiceTypeNO(String invoiceTypeNO)
	{
		InvoiceTypeNO = invoiceTypeNO;
	}

	public double getInvoicetypemoney()
	{
		return invoicetypemoney;
	}

	public void setInvoicetypemoney(Double invoicetypemoney)
	{
		this.invoicetypemoney = invoicetypemoney;
	}

	public Long getBillstate()
	{
		return billstate;
	}

	public void setBillstate(Long billstate)
	{
		this.billstate = billstate;
	}

	public double getUnitsYSYF()
	{
		return UnitsYSYF;
	}

	public void setUnitsYSYF(double unitsYSYF)
	{
		UnitsYSYF = unitsYSYF;
	}

	public Boolean getTrack()
	{
		return track;
	}

	public void setTrack(Boolean track)
	{
		this.track = track;
	}

	public Timestamp getBilldatetime()
	{
		return billdatetime;
	}

	public void setBilldatetime(Timestamp billdatetime)
	{
		this.billdatetime = billdatetime;
	}

	public Long getIntegralall()
	{
		return integralall;
	}

	public void setIntegralall(Long integralall)
	{
		this.integralall = integralall;
	}

	public Long getYh_discount()
	{
		return yh_discount;
	}

	public void setYh_discount(Long yh_discount)
	{
		this.yh_discount = yh_discount;
	}
}
