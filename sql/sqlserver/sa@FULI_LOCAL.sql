select * from UFbstcld..a_vw_InfoProd where s_Layer>1;

select * from v_PRODUCT;


drop view v_product;

create view v_product as
select 
s_id id,
u_name name,
isnull(prodspec,'') spec,
proddw,
pdwcode,
pdwname,
preprice1 price
from 
UFbstcld..a_vw_InfoProd 
where s_Layer>1;

SELECT MasterBillDft.*, Units.u_Code AS Uni_Code, Units.u_Name AS Uni_Name,
      jsr.u_Code AS Jsr_code, jsr.u_Name AS Jsr_Name, StorHouse.u_Code AS StorHouse_Code, 
      StorHouse.u_Name AS StorHouse_Name, EmpOper.u_Code AS OPer_Code, 
      EmpOper.u_Name AS Oper_Name, MoneyAccount.u_Code AS MoneyAccount_Code, 
      MoneyAccount.u_Name AS MoneyAccount_Name, EmpAudit.u_Code AS AuditCode, 
      EmpAudit.u_Name AS AuditName, Units.BankNO AS Uni_BankNo, 
      Units.TaxNO AS Uni_TaxNo, Units.Address AS Uni_Add, 
      Units.LinkMan AS Uni_Linkman, Units.LinkTel AS Uni_LinkTel, Units.Fax AS Uni_Fax,
      Units.Address AS Uni_Adddress, DZYHEmp.u_Code AS DZYHEmpCode, Units.MobileTel  Uni_MobileTel,
      DZYHEmp.u_Name AS DZYHEmpName,
      VIPCard.u_Code AS VIP_Cardcode, 
      VIPCard.Holder AS VIP_Holder, 
      VIPCard.CountAll AS VIP_CountAll,Cardtype AS VIP_CardType,MoneyAccount.act_Ifzfb,
      Units.EMail AS Uni_EMail ,MoneyAccount.Act_ZFBUser, MoneyAccount.Act_ZFBName
       ,Cardtype_ID AS VIP_CardTypeID,Units.CertificateNO as Uni_CertificateNO,ThirdPayment.u_name ThirdPaymentName,isnull(vip_usemoney,0) -isnull(card_money,0) sycardmoney,department.u_name deptname
FROM MasterBillDft INNER JOIN
      Employee EmpOper ON MasterBillDFT.Oper_ID = EmpOper.S_ID INNER JOIN
      Employee jsr ON MasterBillDFT.Emp_ID = jsr.S_ID LEFT OUTER JOIN
      b_vw_VIPCard VIPCard ON MasterBillDFT.VIP_ID = VIPCard.s_id  LEFT OUTER JOIN
      Units ON MasterBillDFT.Unit_ID = Units.S_ID LEFT OUTER JOIN
      StorHouse  ON MasterBillDFT.SIn_ID = StorHouse.S_ID LEFT OUTER JOIN
      MoneyAccount ON MasterBillDFT.Act_ID = MoneyAccount.S_ID LEFT OUTER JOIN
      Employee EmpAudit ON MasterBillDFT.Audit_ID = EmpAudit.S_ID LEFT OUTER JOIN
      Employee DZYHEmp ON MasterBillDFT.LYUser_ID = DZYHEmp.S_ID   LEFT OUTER JOIN
      Units ThirdPayment ON MasterBilldft.ThirdPayment = ThirdPayment.S_ID LEFT outer JOIN
      DEPARTMENT ON Masterbilldft.dept_id = department.s_id
WHERE MasterBillDft.S_id =-1;

select * from SetSystemInfo where s_FullID='0000400010' and IfAllow='¡Ì' ;

select * from SystemInfo where s_FullID = '00006';

select * from ufbstcld..billsnday;

select * from ufbstcld..billsnmonth;

select * from ufbstcld..billsnyear;

select * from ufbstcld..BillSNRule;

select * from ufbstcld..billtype;

select * from ufbstcld..masterbilldft;

select * from ufbstcld..listsaledft;


--truncate table VILLAGER_WELFARE_DRAW;

--truncate table VILLAGER_WELFARE_DRAW_DETAIL;

select * from VILLAGER_WELFARE_DRAW;