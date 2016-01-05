package com.t1;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Types;
import java.util.List;

import org.apache.log4j.Logger;

import com.fuli.obj.ProductObj;
import com.fuli.obj.VWelfareDrawStatByDrawidObj;
import com.hz.auth.obj.AuthUser;
import com.hz.config.ConfigReader;
import com.hz.util.SystemConstant;
import com.t1.obj.AVwUserObj;
import com.t1.obj.ListsaledftObj;
import com.t1.obj.MasterbilldftObj;
import com.wuyg.common.dao.DefaultBaseDAO;
import com.wuyg.common.dao.IBaseDAO;
import com.wuyg.common.util.MySqlUtil;
import com.wuyg.common.util.StringUtil;
import com.wuyg.common.util.TimeUtil;

public class T1Util
{
	private static Logger log = Logger.getLogger(T1Util.class);

	private static IBaseDAO masterBillDftDAO = new DefaultBaseDAO(MasterbilldftObj.class);
	private static IBaseDAO listSaleDftDAO = new DefaultBaseDAO(ListsaledftObj.class);

	/**
	 * 根据村名领取的福利信息生成T1的销售单草稿
	 * 
	 * @param vwelfareDrawStatByDrawidList
	 * @return
	 * @throws Exception
	 */
	public static String createBillDraft(List<VWelfareDrawStatByDrawidObj> vwelfareDrawStatByDrawidList, AuthUser user) throws Exception
	{
		// 1、构造主表信息
		MasterbilldftObj masterbilldftObj = convert2Masterbilldft(vwelfareDrawStatByDrawidList, user);
		// 2、主表保存入库
		masterBillDftDAO.save(masterbilldftObj);
		log.info("T1接口调用:主表保存,billsn" + masterbilldftObj.getBillsn() + ",s_id" + masterbilldftObj.getS_id());

		// 3、构造子表信息
		for (int i = 0; i < vwelfareDrawStatByDrawidList.size(); i++)
		{
			ListsaledftObj listsaledftObj = convert2Listsaledft(vwelfareDrawStatByDrawidList.get(i), masterbilldftObj.getS_id());

			// 4、子表保存入库
			listSaleDftDAO.save(listsaledftObj);
			log.info("T1接口调用:子表保存,billsn" + masterbilldftObj.getBillsn() + ",list_id" + listsaledftObj.getList_id());
		}

		// 5、更新单据信息并更新billsnday中的单据数量，以便实现单据号自动递增
		String o_HintInfo = setOperBill(user.getT1_user_id(), user.getT1_employee_id(), masterbilldftObj.getS_id());
		log.info(o_HintInfo);

		// 6、返回销售单草稿编号
		return masterbilldftObj.getBillsn();
	}

	/**
	 * 更新单据信息并更新billsnday中的单据数量，以便实现单据号自动递增
	 */
	private static String setOperBill(int i_UserID, int i_EmpID, long i_DftID)
	{
		// ALTER PROCEDURE [dbo].[P_SetOperBill]
		// @i_MacMark varchar(30),
		// @i_OperType int,
		// @i_UserID int,
		// @i_EmpID int,
		// @i_DftID int,
		// @o_BillID int output,
		// @o_BillSN varchar(100) output,
		// @o_DftDetailID int output,
		// @o_ProdID int output,
		// @o_ColorID int output,
		// @o_SizeID int output,
		// @o_HintInfo varchar(200) output

		Connection conn = null;

		try
		{
			conn = MySqlUtil.getConnection(SystemConstant.DEFAULT_DB);
			CallableStatement stmt = conn.prepareCall("{call " + SystemConstant.T1_DB + "..P_SetOperBill(?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmt.setString(1, "");
			stmt.setInt(2, 51);
			stmt.setInt(3, i_UserID);
			stmt.setInt(4, i_EmpID);
			stmt.setLong(5, i_DftID);
			stmt.registerOutParameter(6, Types.INTEGER);
			stmt.registerOutParameter(7, Types.VARCHAR);
			stmt.registerOutParameter(8, Types.INTEGER);
			stmt.registerOutParameter(9, Types.VARCHAR);
			stmt.registerOutParameter(10, Types.VARCHAR);
			stmt.registerOutParameter(11, Types.VARCHAR);
			stmt.registerOutParameter(12, Types.VARCHAR);

			stmt.execute();

			String o_HintInfo = stmt.getString(12);

			return o_HintInfo;

		} catch (Exception e)
		{
			log.error(e.getMessage(), e);
		} finally
		{
			MySqlUtil.closeConnection(conn);
		}
		return null;
	}

	/**
	 * 单据数量递增，用于递增生成单据编号
	 */
	private static void setBillCount(int i_OperID, String i_BillSN)
	{
		// ALTER PROCEDURE [dbo].[P_SetBillCount]
		// @i_MacMark varchar(30),
		// @i_BillDate varchar(10),
		// @i_BillType int,
		// @i_OperID int,
		// @i_Rule1 int,
		// @i_Rule2 int,
		// @i_Rule3 int,
		// @i_Rule4 int,
		// @i_BillSN varchar(100) = ''

		Connection conn = null;

		try
		{
			conn = MySqlUtil.getConnection(SystemConstant.DEFAULT_DB);
			CallableStatement stmt = conn.prepareCall("{call " + SystemConstant.T1_DB + "..P_SetBillCount(?,?,?,?,?,?,?,?,?)}");
			stmt.setString(1, "");
			stmt.setString(2, TimeUtil.nowTime2str("yyyy-MM-dd"));
			stmt.setInt(3, 1);
			stmt.setInt(4, i_OperID);
			stmt.setInt(5, 0);
			stmt.setInt(6, 0);
			stmt.setInt(7, 1);
			stmt.setInt(8, 2);
			stmt.setString(9, i_BillSN);

			stmt.execute();

		} catch (Exception e)
		{
			log.error(e.getMessage(), e);
		} finally
		{
			MySqlUtil.closeConnection(conn);
		}

	}

	// 构造主表信息
	private static MasterbilldftObj convert2Masterbilldft(List<VWelfareDrawStatByDrawidObj> vwelfareDrawStatByDrawidList, AuthUser user) throws Exception
	{
		int billType = 1;
		String billDate = TimeUtil.nowTime2str("yyyy-MM-dd");

		MasterbilldftObj m = new MasterbilldftObj();
		m.setS_id(getSysid("MasterBillDft"));
		m.setStor_syb(0l);
		m.setS_syb(0l);
		m.setBilltype(billType);
		m.setBilldate(billDate);
		m.setBillsn(getBillSn("", billType, billDate, user.getT1_user_id()));
		m.setAbst(getAbst(vwelfareDrawStatByDrawidList, user));
		m.setUnit_id(getUnit_id());
		m.setArea_id(null);
		m.setEmp_id(user.getT1_user_id());
		m.setDept_id(-1);
		m.setSin_id(getStore_id());
		m.setOper_id(user.getT1_user_id());
		m.setOperdate(billDate);
		m.setAudit_id(user.getT1_user_id());
		m.setAuditdate(billDate);
		m.setSumnumber(getSumNumber(vwelfareDrawStatByDrawidList));
		m.setDatelimit(billDate);
		m.setYh_money(0d);
		m.setYsyf_money(getYsyf_money(vwelfareDrawStatByDrawidList));
		m.setYsyf_remain(m.getYsyf_money());
		m.setSummoney(m.getYsyf_money());
		m.setSumdismoney(m.getYsyf_money());
		m.setSumtaxmoney(m.getYsyf_money());
		m.setInvoiceTypeNO(null);
		m.setInvoicetypemoney(null);
		m.setBillstate(-1l);
		// m.setUnitsYSYF();// 这个字段如何得来的？
		m.setTrack(true);
		m.setInvoiceType("无");
		m.setBilldatetime(TimeUtil.nowTime2TimeStamp());
		m.setIntegralall(0l);
		m.setYh_discount(100l);
		m.setBilltime(TimeUtil.nowTime2str("HH:mm:ss"));

		return m;
	}

	// 往来单位ID
	private static Integer getUnit_id() throws Exception
	{
		Integer unit_id = StringUtil.parseInt(ConfigReader.getProperties("t1.unit_id"));
		return unit_id;// 固定：995代表白沙滩村村委会,对应units表的s_id
	}

	// 收货仓库id
	private static Integer getStore_id() throws Exception
	{
		Integer store_id = StringUtil.parseInt(ConfigReader.getProperties("t1.store_id"));
		return store_id;// 收货仓库id，508
	}

	// 单据应收应付金额
	private static Double getYsyf_money(List<VWelfareDrawStatByDrawidObj> vwelfareDrawStatByDrawidList)
	{
		Double ysyf_money = 0d;

		for (int i = 0; i < vwelfareDrawStatByDrawidList.size(); i++)
		{
			VWelfareDrawStatByDrawidObj o = vwelfareDrawStatByDrawidList.get(i);
			ysyf_money += o.getProduct_quantity_drawed_sum() * o.getProduct_price();
		}

		return ysyf_money;
	}

	// 单据商品总量
	private static Double getSumNumber(List<VWelfareDrawStatByDrawidObj> vwelfareDrawStatByDrawidList)
	{
		Double sumNumber = 0d;

		for (int i = 0; i < vwelfareDrawStatByDrawidList.size(); i++)
		{
			VWelfareDrawStatByDrawidObj o = vwelfareDrawStatByDrawidList.get(i);
			sumNumber += o.getProduct_quantity_drawed_sum();
		}

		return sumNumber;
	}

	// 摘要
	private static String getAbst(List<VWelfareDrawStatByDrawidObj> vwelfareDrawStatByDrawidList, AuthUser user)
	{
		// 需要拼接：从【xx单位】销售(xx)等商品:xx操作员
		return "从【白沙滩村委会】销售(" + vwelfareDrawStatByDrawidList.get(0).getProduct_name() + ")等商品:" + user.getName();
	}

	// 获取销售单sn
	// 
	// P_GetBillSN
	// @i_MacMark varchar(30), @i_BillType int,@i_BillDate varchar(10),
	// @i_OperID int, @i_DftOper int = -1, @i_BillSN varchar(100) = '',
	// @o_BillSN varchar(100) output
	private static String getBillSn(String i_MacMark, Integer i_BillType, String i_BillDate, Integer i_OperID)
	{
		Connection conn = null;

		try
		{
			conn = MySqlUtil.getConnection(SystemConstant.DEFAULT_DB);
			CallableStatement stmt = conn.prepareCall("{call " + SystemConstant.T1_DB + "..P_GetBillSN(?,?,?,?,?,?,?)}");
			stmt.setString(1, i_MacMark);
			stmt.setInt(2, i_BillType);
			stmt.setString(3, i_BillDate);
			stmt.setInt(4, i_OperID);
			stmt.setInt(5, -1);
			stmt.setString(6, "");

			// out 注册的index 和取值时要对应
			stmt.registerOutParameter(7, Types.VARCHAR);
			stmt.execute();

			// getXxx(index)中的index 需要和上面registerOutParameter的index对应
			String o_BillSN = stmt.getString(7);

			return o_BillSN;
		} catch (Exception e)
		{
			log.error(e.getMessage(), e);
		} finally
		{
			MySqlUtil.closeConnection(conn);
		}

		return null;
	}

	// 获取某个表的流水号
	// P_GetSysID @i_TabName varchar(50) ,@o_SysID int output
	private static Long getSysid(String i_TabName)
	{
		Connection conn = null;

		try
		{
			conn = MySqlUtil.getConnection(SystemConstant.DEFAULT_DB);
			CallableStatement stmt = conn.prepareCall("{call " + SystemConstant.T1_DB + "..P_GetSysID(?,?)}");
			stmt.setString(1, i_TabName);

			// out 注册的index 和取值时要对应
			stmt.registerOutParameter(2, Types.INTEGER);
			stmt.execute();

			// getXxx(index)中的index 需要和上面registerOutParameter的index对应
			Long o_SysID = stmt.getLong(2);

			return o_SysID;
		} catch (Exception e)
		{
			log.error(e.getMessage(), e);
		} finally
		{
			MySqlUtil.closeConnection(conn);
		}

		return null;
	}

	// 构造子表信息
	private static ListsaledftObj convert2Listsaledft(VWelfareDrawStatByDrawidObj vWelfareDrawStatByDrawidObj, long billId) throws Exception
	{
		ListsaledftObj l = new ListsaledftObj();

		IBaseDAO productDAO = new DefaultBaseDAO(ProductObj.class);
		ProductObj productObj = (ProductObj) productDAO.searchByKey(ProductObj.class, vWelfareDrawStatByDrawidObj.getProduct_id());

		l.setList_id(getSysid("ListSaleDft"));
		l.setBill_id(billId);
		l.setStor_id(getStore_id());
		l.setProd_id(StringUtil.parseLong(vWelfareDrawStatByDrawidObj.getProduct_id()));
		l.setProd_number(vWelfareDrawStatByDrawidObj.getProduct_quantity_drawed_sum());
		l.setProd_proddw(5l);// 5对应的是“斤”，对应commoninfo表
		l.setProd_price(vWelfareDrawStatByDrawidObj.getProduct_price());
		// l.setProd_money();
		l.setDiscount(100d);
		// l.setDisprice();
		// l.setDismoney();
		// l.setDismoney0();
		l.setTax(0d);
		// l.setTaxprice();
		// l.setTaxmoney();
		// l.setTaxmoney0();
		l.setSernumber(null);
		l.setOutfactorydate(null);
		l.setProd_order(0l);
		l.setPdw_ratio(1d);
		l.setPdw_num(new Double(vWelfareDrawStatByDrawidObj.getProduct_quantity_drawed_sum()));
		l.setCostprice(0l);
		l.setCostmoney(0d);
		l.setInorout(1l);
		l.setProd_ddid(-1l);
		l.setZs_syb(false);
		l.setPromotion("");
		l.setUsevipsyb(1l);
		l.setDwratio(productObj.getDWRatio());
		// l.setProdquantity("");
		l.setDwratio1(productObj.getDWRatio1());
		// l.setAssistant1("");
		l.setDwratio2(null);
		l.setAssistant2(null);
		// l.setBignum();
		// l.setMidnum();
		// l.setLetnum();
		l.setEndfulllifedate(null);
		l.setRetail_price(productObj.getPrice_retail());
		l.setProd_number2(0l);
		l.setLowmoney(0l);
		l.setUpintegral(0l);
		l.setBaseintegral(0l);
		l.setBaseintegralmoney(0l);

		// 单位转换
		if (productObj.getAssitUnit1Rate()!=null&& productObj.getAssitUnit1Rate()>0)
		{
			p_FormatDWNum1(l);
		}
		
		return l;
	}

	// 单位换算
	// procedure [dbo].[p_FormatDWNum1]
	// @prod_id Integer,
	// @P_Num numeric(20,8),
	// @o_BigNum numeric(20,8) output,
	// @o_MidNum numeric(20,8) output,
	// @o_LetNum numeric(20,8) output,
	// @o_DwNum varchar(50) output
	private static void p_FormatDWNum1(ListsaledftObj l)
	{
		Connection conn = null;

		try
		{
			conn = MySqlUtil.getConnection(SystemConstant.DEFAULT_DB);
			CallableStatement stmt = conn.prepareCall("{call " + SystemConstant.T1_DB + "..p_FormatDWNum1(?,?,?,?,?,?)}");
			stmt.setLong(1, l.getProd_id());
			stmt.setLong(2, l.getProd_number());

			// out 注册的index 和取值时要对应
			stmt.registerOutParameter(3, Types.INTEGER);
			stmt.registerOutParameter(4, Types.INTEGER);
			stmt.registerOutParameter(5, Types.INTEGER);
			stmt.registerOutParameter(6, Types.VARCHAR);
			stmt.execute();

			// getXxx(index)中的index 需要和上面registerOutParameter的index对应
			l.setBignum(stmt.getLong(3));
			l.setMidnum(stmt.getLong(4));
			l.setLetnum(stmt.getLong(5));
			l.setProdquantity(stmt.getString(6));
			l.setAssistant1(stmt.getString(6));
			
		} catch (Exception e)
		{
			log.error(e.getMessage(), e);
		} finally
		{
			MySqlUtil.closeConnection(conn);
		}
	}



	// 根据u_code查询用户信息
	public static AVwUserObj getT1User(String u_code)
	{
		IBaseDAO avwuserDAO = new DefaultBaseDAO(AVwUserObj.class);

		Object avwuser = avwuserDAO.searchByKey(AVwUserObj.class, u_code);

		if (avwuser != null)
		{
			return (AVwUserObj) avwuser;
		} else
		{
			return null;
		}
	}

	// 查询t1的账号并转换为本系统账号信息
	public static AuthUser getAuthUser(String account)
	{
		AVwUserObj avwuser = getT1User(account);

		if (avwuser != null)
		{
			AuthUser authUser = new AuthUser();
			authUser.setAccount(account);
			authUser.setName(avwuser.getEmpname());
			authUser.setT1_employee_id(avwuser.getEmp_id());
			// authUser.setT1_user_id(avwuser.getS_id());
			authUser.setT1_user_id(avwuser.getEmp_id());
			authUser.setDistrict("");
			return authUser;
		} else
		{
			return null;
		}

	}

	public static void main(String[] args)
	{
		System.out.println(getSysid("MasterBillDft"));

		System.out.println(getBillSn("", 1, "2015-12-17", 1));
	}

}
