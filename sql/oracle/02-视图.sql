/* Formatted on 2015/12/1 9:24:52 (QP5 v5.114.809.3010) */
CREATE OR REPLACE FORCE VIEW V_VILLAGER_WELFARE_DETAIL
(
   VILLAGER_ID,
   ID_CARD,
   VILLAGER_NAME,
   VILLAGER_WELFARE_ID,
   WELFARE_POLICY_ID,
   WELFARE_POLICY_NAME,
   WELFARE_POLICY_START_TIME,
   WELFARE_POLICY_END_TIME,
   WELFARE_POLICY_DETAIL_ID,
   PRODUCT_ID,
   PRODUCT_NAME,
   PRODUCT_QUANTITY,
   PRODUCT_MEASURING_UNIT
)
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
              t4.product_measuring_unit
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
   ORDER BY   t5.villager_name, t4.welfare_policy_id, t4.product_id;


/* Formatted on 2015/12/1 9:24:52 (QP5 v5.114.809.3010) */
CREATE OR REPLACE FORCE VIEW V_VILLAGER_WELFARE_STAT
(
   VILLAGER_ID,
   VILLAGER_NAME,
   ID_CARD,
   WELFARE_POLICY_ID,
   WELFARE_POLICY_NAME,
   PRODUCT_ID,
   PRODUCT_NAME,
   PRODUCT_MEASURING_UNIT,
   DRAWED_PRODUCT_QUANTITY_SUM
)
AS
     SELECT   villager_id,
              villager_name,
              id_card,
              welfare_policy_id,
              welfare_policy_name,
              product_id,
              product_name,
              product_measuring_unit,
              SUM (product_quantity) drawed_product_quantity_sum
       FROM   v_villager_welfare_detail
   GROUP BY   villager_id,
              villager_name,
              id_card,
              welfare_policy_id,
              welfare_policy_name,
              product_id,
              product_name,
              product_measuring_unit
   ORDER BY   villager_name, welfare_policy_id;


/* Formatted on 2015/12/1 9:24:52 (QP5 v5.114.809.3010) */
CREATE OR REPLACE FORCE VIEW V_WELFARE_DRAW_DETAIL
(
   ID,
   DRAW_ID,
   DRAW_TYPE,
   DRAW_DATE,
   PROXY_VILLAGER_NAME,
   DRAW_COMMENT,
   DRAW_VILLAGER_ID,
   DRAW_VILLAGER_ID_CARD,
   DRAW_VILLAGER_NAME,
   VILLAGER_ID,
   ID_CARD,
   VILLAGER_NAME,
   VILLAGER_WELFARE_ID,
   WELFARE_POLICY_ID,
   WELFARE_POLICY_NAME,
   WELFARE_POLICY_START_TIME,
   WELFARE_POLICY_END_TIME,
   WELFARE_POLICY_DETAIL_ID,
   PRODUCT_ID,
   PRODUCT_NAME,
   PRODUCT_QUANTITY,
   PRODUCT_MEASURING_UNIT,
   PRODUCT_QUANTITY_DRAWED
)
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


/* Formatted on 2015/12/1 9:24:52 (QP5 v5.114.809.3010) */
CREATE OR REPLACE FORCE VIEW V_WELFARE_DRAW_DETAIL_CN
(
   "领取明细编号",
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


/* Formatted on 2015/12/1 9:24:52 (QP5 v5.114.809.3010) */
CREATE OR REPLACE FORCE VIEW V_WELFARE_DRAW_STAT
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
              product_measuring_unit;


/* Formatted on 2015/12/1 9:24:52 (QP5 v5.114.809.3010) */
CREATE OR REPLACE FORCE VIEW V_WELFARE_DRAW_STAT_BY_DRAWID
(
   DRAW_ID,
   DRAW_VILLAGER_ID,
   DRAW_VILLAGER_NAME,
   DRAW_VILLAGER_ID_CARD,
   DRAW_DATE,
   PRODUCT_ID,
   PRODUCT_NAME,
   PRODUCT_MEASURING_UNIT,
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
              SUM (product_quantity_drawed) product_quantity_drawed_sum
       FROM   v_welfare_draw_detail
   GROUP BY   draw_id,
              draw_villager_id,
              draw_villager_name,
              product_measuring_unit,
              draw_villager_id_card,
              product_id,
              product_name;


/* Formatted on 2015/12/1 9:24:52 (QP5 v5.114.809.3010) */
CREATE OR REPLACE FORCE VIEW V_WELFARE_FOR_DRAW_DETAIL
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
              v1.product_quantity,
              NVL (v2.product_quantity_drawed, 0) product_quantity_drawed,
              (v1.product_quantity - NVL (v2.product_quantity_drawed, 0))
                 product_quantity_remainder
       FROM      v_villager_welfare_detail v1
              LEFT JOIN
                 v_welfare_draw_stat v2
              ON     v1.villager_id = v2.villager_id
                 AND v1.welfare_policy_id = v2.welfare_policy_id
                 AND v1.welfare_policy_detail_id = v2.welfare_policy_detail_id
   ORDER BY   v1.villager_name, v1.welfare_policy_id, v1.product_id;


/* Formatted on 2015/12/1 9:24:52 (QP5 v5.114.809.3010) */
CREATE OR REPLACE FORCE VIEW V_WELFARE_FOR_DRAW_DETAIL_CN
(
   "福利归属人编号",
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


