/*
由 Aqua Data Studio 8.0.4 于 十二月-04-2015 11:13:49 上午
 日生成的脚本数据库：fuli
架构：dbo
对象：DATATYPE, DEFAULT, RULE, TABLE, VIEW, SYNONYM, PROCEDURE, FUNCTION, INDEX, TRIGGER
*/
DROP INDEX "dbo"."WELFARE_POLICY_DETAIL"."WELFARE_POLICY_DETAIL_UIDX"
GO
DROP INDEX "dbo"."VILLAGER_WELFARE_DRAW_DETAIL"."VILL_WEL_DRAW_DETAIL_UIDX"
GO
DROP INDEX "dbo"."VILLAGER_WELFARE"."VILLAGER_WELFARE_UIDX"
GO
DROP INDEX "dbo"."VILLAGER_WELFARE_DRAW"."VILLAGER_WELFARE_DRAW_UIDX"
GO
DROP INDEX "dbo"."VILLAGER_WELFARE_DRAW"."VILLAGER_WELFARE_DRAW_IDX01"
GO
DROP INDEX "dbo"."VILLAGER"."VILLAGER_UIDX"
GO
DROP INDEX "dbo"."AUTH_USER"."ACCOUNT_UNIQUE"
GO
DROP VIEW "dbo"."V_WELFARE_FOR_DRAW_DETAIL"
GO
DROP VIEW "dbo"."V_WELFARE_FOR_DRAW_DETAIL_CN"
GO
DROP VIEW "dbo"."V_WELFARE_DRAW_STAT"
GO
DROP VIEW "dbo"."V_WELFARE_DRAW_STAT_BY_DRAWID"
GO
DROP VIEW "dbo"."V_WELFARE_DRAW_DETAIL"
GO
DROP VIEW "dbo"."V_WELFARE_DRAW_DETAIL_CN"
GO
DROP VIEW "dbo"."V_VILLAGER_WELFARE_STAT"
GO
DROP VIEW "dbo"."V_VILLAGER_WELFARE_DETAIL"
GO
DROP TABLE "dbo"."WELFARE_POLICY"
GO
DROP TABLE "dbo"."WELFARE_POLICY_DETAIL"
GO
DROP TABLE "dbo"."VILLAGER"
GO
DROP TABLE "dbo"."VILLAGER_WELFARE"
GO
DROP TABLE "dbo"."VILLAGER_WELFARE_DRAW"
GO
DROP TABLE "dbo"."VILLAGER_WELFARE_DRAW_DETAIL"
GO
DROP TABLE "dbo"."PRODUCT"
GO
DROP TABLE "dbo"."LOG_LOGIN"
GO
DROP TABLE "dbo"."AUTH_USER"
GO
DROP TABLE "dbo"."AUTH_USER_ROLE"
GO
DROP TABLE "dbo"."AUTH_ROLE"
GO
DROP TABLE "dbo"."AUTH_ROLE_FUNCTION"
GO
DROP TABLE "dbo"."AUTH_GROUP"
GO
DROP TABLE "dbo"."AUTH_GROUP_USER"
GO
DROP TABLE "dbo"."AUTH_FUNCTION"
GO
DROP TABLE "dbo"."AUTH_DEPARTMENT"
GO

CREATE TABLE "dbo"."AUTH_DEPARTMENT"  ( 
	"DEPARTMENTID"  	varchar(128) NOT NULL,
	"DEPARTMENTNAME"	varchar(128) NOT NULL,
	"CITY"          	varchar(128) NULL,
	"DISTRICTNAME"  	varchar(128) NULL,
	"COMMENTINFO"   	varchar(1024) NULL 
	)
GO
CREATE TABLE "dbo"."AUTH_FUNCTION"  ( 
	"FUNCTONID"          	int NOT NULL,
	"FUNCTIONNAME"       	varchar(128) NULL,
	"FUNCTIONDISCRIPTION"	varchar(512) NULL 
	)
GO
CREATE TABLE "dbo"."AUTH_GROUP_USER"  ( 
	"GROUPID"    	int NOT NULL,
	"GROUPNAME"  	varchar(128) NULL,
	"USERACCOUNT"	varchar(128) NULL,
	"USERNAME"   	varchar(128) NULL 
	)
GO
CREATE TABLE "dbo"."AUTH_GROUP"  ( 
	"GROUPID"         	int NOT NULL,
	"GROUPNAME"       	varchar(128) NULL,
	"GROUPDISCRIPTION"	varchar(512) NULL 
	)
GO
CREATE TABLE "dbo"."AUTH_ROLE_FUNCTION"  ( 
	"ROLEID"      	int NOT NULL,
	"ROLENAME"    	varchar(128) NULL,
	"FUNCTIONID"  	int NULL,
	"FUNCTIONNAME"	varchar(128) NULL 
	)
GO
CREATE TABLE "dbo"."AUTH_ROLE"  ( 
	"ROLEID"         	int NOT NULL,
	"ROLENAME"       	varchar(128) NULL,
	"ROLEDISCRIPTION"	varchar(512) NULL 
	)
GO
CREATE TABLE "dbo"."AUTH_USER_ROLE"  ( 
	"USERACCOUNT"	varchar(128) NULL,
	"USERID"     	varchar(128) NULL,
	"ROLEID"     	varchar(128) NULL,
	"ROLENAME"   	varchar(128) NULL 
	)
GO
CREATE TABLE "dbo"."AUTH_USER"  ( 
	"ID"            	int NOT NULL,
	"ACCOUNT"       	varchar(128) NOT NULL,
	"PASSWORD"      	varchar(128) NULL,
	"NAME"          	varchar(128) NULL,
	"TELEPHONE"     	varchar(128) NULL,
	"SEX"           	varchar(128) NULL,
	"PROVINCE"      	varchar(128) NULL,
	"CITY"          	varchar(128) NULL,
	"DISTRICT"      	varchar(128) NULL,
	"DEPARTMENTID"  	varchar(128) NULL,
	"DEPARTMENTNAME"	varchar(128) NULL,
	"OFFICE"        	varchar(128) NULL,
	"ROLELEVEL"     	varchar(128) NULL,
	CONSTRAINT "PK__AUTH_USE__C41152740AD2A005" PRIMARY KEY("ACCOUNT","ID")
)
GO
CREATE TABLE "dbo"."LOG_LOGIN"  ( 
	"ID"                	int NOT NULL,
	"USERACCOUNT"       	varchar(128) NULL,
	"USERNAME"          	varchar(128) NULL,
	"USERDISTRICT"      	varchar(128) NULL,
	"USERDEPARTMENTID"  	varchar(128) NULL,
	"USERDEPARTMENTNAME"	varchar(128) NULL,
	"timestamp"         	datetime NULL 
	)
GO
CREATE TABLE "dbo"."PRODUCT"  ( 
	"ID"  	int NULL,
	"NAME"	varchar(256) NULL,
	"SPEC"	varchar(256) NULL,
	"TYPE"	varchar(256) NULL 
	)
GO
CREATE TABLE "dbo"."VILLAGER_WELFARE_DRAW_DETAIL"  ( 
	"ID"                      	numeric(18,0) NOT NULL,
	"VILLAGER_WELFARE_DRAW_ID"	numeric(18,0) NULL,
	"VILLAGER_WELFARE_ID"     	numeric(18,0) NULL,
	"PRODUCT_ID"              	varchar(128) NULL,
	"PRODUCT_NAME"            	varchar(128) NULL,
	"PRODUCT_QUANTITY"        	int NULL,
	"PRODUCT_MEASURING_UNIT"  	varchar(128) NULL,
	"PRODUCT_PRICE"        			numeric(15,5) NULL,
	"LAST_MODIFY_TIME"        	datetime NULL,
	"LAST_MODIFY_ACCOUT"      	varchar(128) NULL,
	CONSTRAINT "VILLAGER_WELFARE_DRAW_DETAILPK" PRIMARY KEY("ID")
)
GO
CREATE TABLE "dbo"."VILLAGER_WELFARE_DRAW"  ( 
	"ID"                 	numeric(18,0) NOT NULL,
	"VILLAGER_ID"        	varchar(128) NULL,
	"DRAW_TYPE"          	varchar(128) NULL,
	"PROXY_VILLAGER_ID"  	varchar(128) NULL,
	"PROXY_VILLAGER_NAME"	varchar(128) NULL,
	"LAST_MODIFY_TIME"   	datetime NULL,
	"LAST_MODIFY_ACCOUT" 	varchar(128) NULL,
	"DRAW_COMMENT"       	varchar(4000) NULL,
	"DRAW_DATE"          	datetime NULL,
	CONSTRAINT "VILLAGER_WELFARE_DRAW_PK" PRIMARY KEY("ID")
)
GO
CREATE TABLE "dbo"."VILLAGER_WELFARE"  ( 
	"ID"                 	numeric(18,0) NOT NULL,
	"VILLAGER_ID"        	varchar(128) NULL,
	"WELFARE_POLICY_ID"  	int NULL,
	"LAST_MODIFY_ACCOUNT"	varchar(128) NULL,
	"LAST_MODIFY_TIME"   	datetime NULL,
	CONSTRAINT "VILLAGER_WELFARE_PK" PRIMARY KEY("ID")
)
GO
CREATE TABLE "dbo"."VILLAGER"  ( 
	"ID"                 	numeric(18,0) NOT NULL,
	"ID_CARD"            	varchar(128) NULL,
	"VILLAGER_NAME"      	varchar(128) NULL,
	"VILLAGER_SEX"       	varchar(128) NULL,
	"VILLAGER_TELEPHONE" 	varchar(128) NULL,
	"VILLAGER_OMMENT"    	varchar(4000) NULL,
	"LAST_MODIFY_ACCOUNT"	varchar(128) NULL,
	"LAST_MODIFY_TIME"   	datetime NULL,
	"ENABLE"             	varchar(128) NULL,
	"BINDING_TO_ID"      	varchar(128) NULL,
	CONSTRAINT "VILLAGER_PK" PRIMARY KEY("ID")
)
GO
CREATE TABLE "dbo"."WELFARE_POLICY_DETAIL"  ( 
	"ID"                    	numeric(18,0) NOT NULL,
	"WELFARE_POLICY_ID"     	int NULL,
	"PRODUCT_ID"            	varchar(128) NULL,
	"PRODUCT_NAME"          	varchar(512) NULL,
	"PRODUCT_QUANTITY"      	int NULL,
	"PRODUCT_PRICE"        		numeric(15,5) NULL,
	"PRODUCT_MEASURING_UNIT"	varchar(128) NULL,
	"LAST_MODIFY_TIME"      	datetime NULL,
	"LAST_MODIFY_ACCOUNT"   	varchar(128) NULL,
	CONSTRAINT "WELFARE_POLICY_DETAIL_PK" PRIMARY KEY("ID")
)
GO
CREATE TABLE "dbo"."WELFARE_POLICY"  ( 
	"ID"                       	numeric(18,0) NOT NULL,
	"WELFARE_POLICY_NAME"      	varchar(512) NULL,
	"LAST_MODIFY_TIME"         	datetime NULL,
	"LAST_MODIFY_ACCOUNT"      	varchar(128) NULL,
	"WELFARE_POLICY_START_TIME"	datetime NULL,
	"WELFARE_POLICY_END_TIME"  	datetime NULL,
	"WELFARE_POLICY_COMMENT"   	varchar(1024) NULL,
	"WELFARE_POLICY_FOR_ALL"   	varchar(128) NULL,
	CONSTRAINT "WELFARE_POLICY_PK" PRIMARY KEY("ID")
)
GO
CREATE VIEW "dbo"."V_VILLAGER_WELFARE_DETAIL"
AS
     SELECT   t5.id villager_id,
              t5.id_card,
              t5.villager_name,
              t2.id villager_welfare_id,
              t3.id welfare_policy_id,
              t3.welfare_policy_name,
              t3.welfare_policy_start_time,
              t3.welfare_policy_end_time,
              t4.id welfare_policy_detail_id,
              t4.product_id,
              t4.product_name,
              t4.product_quantity,
              t4.product_measuring_unit,
              t4.product_price
       FROM            villager_welfare t2
                    LEFT JOIN
                       welfare_policy t3
                    ON t2.welfare_policy_id = t3.id
                 LEFT JOIN
                    welfare_policy_detail t4
                 ON t3.id = t4.welfare_policy_id
              LEFT JOIN
                 villager t5
              ON t2.villager_id = t5.id
GO
CREATE VIEW "dbo"."V_VILLAGER_WELFARE_STAT"
AS
     SELECT   villager_id,
              villager_name,
              id_card,
              welfare_policy_id,
              welfare_policy_name,
              product_id,
              product_name,
              product_measuring_unit,
              product_price,
              SUM (product_quantity) drawed_product_quantity_sum
       FROM   v_villager_welfare_detail
   GROUP BY   villager_id,
              villager_name,
              id_card,
              welfare_policy_id,
              welfare_policy_name,
              product_id,
              product_name,
              product_measuring_unit,
              product_price
GO
CREATE VIEW "dbo"."V_WELFARE_DRAW_DETAIL_CN"
(
   领取明细编号,
   "领取记录号",
   "领取类型",
   "领取时间",
   "代领人",
   "领取备注",
   "领取人编号",
   "领取人身份证",
   "领取人姓名",
   "福利归属人编号",
   "福利归属人身份证",
   "福利归属人姓名",
   "村民福利映射编号",
   "福利政策编号",
   "福利政策名",
   "福利开始时间",
   "福利过期时间",
   "福利明细编号",
   "商品编号",
   "商品名",
   "商品规格",
   "人均数量",
   "本次领取数量"
)
AS
   SELECT   id "领取明细编号",
            draw_id "领取记录号",
            draw_type "领取类型",
            draw_date "领取时间",
            proxy_villager_name "代领人",
            draw_comment "领取备注",
            draw_villager_id "领取人编号",
            draw_villager_id_card "领取人身份证",
            draw_villager_name "领取人姓名",
            villager_id "福利归属人编号",
            id_card "福利归属人身份证",
            villager_name "福利归属人姓名",
            villager_welfare_id "村民福利映射编号",
            welfare_policy_id "福利政策编号",
            welfare_policy_name "福利政策名",
            welfare_policy_start_time "福利开始时间",
            welfare_policy_end_time "福利过期时间",
            welfare_policy_detail_id "福利明细编号",
            product_id "商品编号",
            product_name "商品名",
            product_measuring_unit "商品规格",
            product_quantity "人均数量",
            product_quantity_drawed "本次领取数量"
     FROM   v_welfare_draw_detail;
GO
CREATE VIEW "dbo"."V_WELFARE_DRAW_DETAIL"
AS
   SELECT   t0.id,
            t1.id draw_id,
            t1.draw_type,
            t1.draw_date,
            t1.proxy_villager_name,
            t1.draw_comment,
            t6.id draw_villager_id,
            t6.id_card draw_villager_id_card,
            t6.villager_name draw_villager_name,
            t5.id villager_id,
            t5.id_card,
            t5.villager_name,
            t2.id villager_welfare_id,
            t3.id welfare_policy_id,
            t3.welfare_policy_name,
            t3.welfare_policy_start_time,
            t3.welfare_policy_end_time,
            t4.id welfare_policy_detail_id,
            t4.product_id,
            t4.product_name,
            t4.product_quantity,
            t4.product_measuring_unit,
            t4.product_price,
            t0.product_quantity product_quantity_drawed
     FROM                     villager_welfare_draw_detail t0
                           LEFT JOIN
                              villager_welfare_draw t1
                           ON t0.villager_welfare_draw_id = t1.id
                        LEFT JOIN
                           villager_welfare t2
                        ON t0.villager_welfare_id = t2.id
                     LEFT JOIN
                        welfare_policy t3
                     ON t2.welfare_policy_id = t3.id
                  LEFT JOIN
                     welfare_policy_detail t4
                  ON t4.welfare_policy_id = t3.id
                     AND t0.product_id = t4.product_id
               LEFT JOIN
                  villager t5
               ON t2.villager_id = t5.id
            LEFT JOIN
               villager t6
            ON t1.villager_id = t6.id;
GO
CREATE VIEW "dbo"."V_WELFARE_DRAW_STAT_BY_DRAWID"
(
   DRAW_ID,
   DRAW_VILLAGER_ID,
   DRAW_VILLAGER_NAME,
   DRAW_VILLAGER_ID_CARD,
   DRAW_DATE,
   PRODUCT_ID,
   PRODUCT_NAME,
   PRODUCT_MEASURING_UNIT,
   PRODUCT_PRICE,
   PRODUCT_QUANTITY_DRAWED_SUM
)
AS
     SELECT   draw_id,
              draw_villager_id,
              draw_villager_name,
              draw_villager_id_card,
              MAX (draw_date) draw_date,
              product_id,
              product_name,
              product_measuring_unit,
              product_price,
              SUM (product_quantity_drawed) product_quantity_drawed_sum
       FROM   v_welfare_draw_detail
   GROUP BY   draw_id,
              draw_villager_id,
              draw_villager_name,
              product_measuring_unit,
              draw_villager_id_card,
              product_id,
              product_name,
              product_price;
GO
CREATE VIEW "dbo"."V_WELFARE_DRAW_STAT"
(
   VILLAGER_ID,
   VILLAGER_NAME,
   ID_CARD,
   VILLAGER_WELFARE_ID,
   WELFARE_POLICY_ID,
   WELFARE_POLICY_NAME,
   WELFARE_POLICY_DETAIL_ID,
   PRODUCT_ID,
   PRODUCT_NAME,
   PRODUCT_MEASURING_UNIT,
   PRODUCT_PRICE,
   PRODUCT_QUANTITY_DRAWED
)
AS
     SELECT   villager_id,
              villager_name,
              id_card,
              villager_welfare_id,
              welfare_policy_id,
              welfare_policy_name,
              welfare_policy_detail_id,
              product_id,
              product_name,
              product_measuring_unit,
              product_price,
              SUM (product_quantity_drawed) product_quantity_drawed
       FROM   v_welfare_draw_detail
   GROUP BY   villager_id,
              villager_name,
              id_card,
              villager_welfare_id,
              welfare_policy_id,
              welfare_policy_name,
              welfare_policy_detail_id,
              product_id,
              product_name,
              product_measuring_unit,
              product_price;
GO
CREATE VIEW "dbo"."V_WELFARE_FOR_DRAW_DETAIL_CN"
(
   福利归属人编号,
   "福利归属人姓名",
   "福利归属人身份证",
   "村民福利映射编号",
   "福利政策编号",
   "福利政策名",
   "福利开始时间",
   "福利过期时间",
   "福利明细编号",
   "商品编号",
   "商品名",
   "商品规格",
   "人均数量",
   "已领数量",
   "未领数量"
)
AS
   SELECT   villager_id "福利归属人编号",
            villager_name "福利归属人姓名",
            id_card "福利归属人身份证",
            villager_welfare_id "村民福利映射编号",
            welfare_policy_id "福利政策编号",
            welfare_policy_name "福利政策名",
            welfare_policy_start_time "福利开始时间",
            welfare_policy_end_time "福利过期时间",
            welfare_policy_detail_id "福利明细编号",
            product_id "商品编号",
            product_name "商品名",
            product_measuring_unit "商品规格",
            product_quantity "人均数量",
            product_quantity_drawed "已领数量",
            product_quantity_remainder "未领数量"
     FROM   v_welfare_for_draw_detail;
GO
CREATE VIEW "dbo"."V_WELFARE_FOR_DRAW_DETAIL"
(
   VILLAGER_ID,
   VILLAGER_NAME,
   ID_CARD,
   VILLAGER_WELFARE_ID,
   WELFARE_POLICY_ID,
   WELFARE_POLICY_NAME,
   WELFARE_POLICY_START_TIME,
   WELFARE_POLICY_END_TIME,
   WELFARE_POLICY_DETAIL_ID,
   PRODUCT_ID,
   PRODUCT_NAME,
   PRODUCT_MEASURING_UNIT,
   PRODUCT_PRICE,
   PRODUCT_QUANTITY,
   PRODUCT_QUANTITY_DRAWED,
   PRODUCT_QUANTITY_REMAINDER
)
AS
     SELECT   v1.villager_id,
              v1.villager_name,
              v1.id_card,
              v1.villager_welfare_id,
              v1.welfare_policy_id,
              v1.welfare_policy_name,
              v1.welfare_policy_start_time,
              v1.welfare_policy_end_time,
              v1.welfare_policy_detail_id,
              v1.product_id,
              v1.product_name,
              v1.product_measuring_unit,
              v1.product_price,
              v1.product_quantity,
              isnull(v2.product_quantity_drawed, 0) product_quantity_drawed,
              (v1.product_quantity - isnull(v2.product_quantity_drawed, 0))
                 product_quantity_remainder
       FROM      v_villager_welfare_detail v1
              LEFT JOIN
                 v_welfare_draw_stat v2
              ON     v1.villager_id = v2.villager_id
                 AND v1.welfare_policy_id = v2.welfare_policy_id
                 AND v1.welfare_policy_detail_id = v2.welfare_policy_detail_id
GO
CREATE UNIQUE INDEX "ACCOUNT_UNIQUE"
	ON "dbo"."AUTH_USER"("ACCOUNT")
GO
CREATE UNIQUE INDEX "VILLAGER_UIDX"
	ON "dbo"."VILLAGER"("ID_CARD")
GO
CREATE INDEX "VILLAGER_WELFARE_DRAW_IDX01"
	ON "dbo"."VILLAGER_WELFARE_DRAW"("VILLAGER_ID")
GO
CREATE UNIQUE INDEX "VILLAGER_WELFARE_DRAW_UIDX"
	ON "dbo"."VILLAGER_WELFARE_DRAW"("ID")
GO
CREATE UNIQUE INDEX "VILLAGER_WELFARE_UIDX"
	ON "dbo"."VILLAGER_WELFARE"("VILLAGER_ID", "WELFARE_POLICY_ID")
GO
CREATE UNIQUE INDEX "VILL_WEL_DRAW_DETAIL_UIDX"
	ON "dbo"."VILLAGER_WELFARE_DRAW_DETAIL"("VILLAGER_WELFARE_DRAW_ID", "VILLAGER_WELFARE_ID", "PRODUCT_ID")
GO
CREATE UNIQUE INDEX "WELFARE_POLICY_DETAIL_UIDX"
	ON "dbo"."WELFARE_POLICY_DETAIL"("WELFARE_POLICY_ID", "PRODUCT_ID")
GO

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
where s_Layer>1 
GO