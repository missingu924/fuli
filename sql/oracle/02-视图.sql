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
   "��ȡ��ϸ���",
   "��ȡ��¼��",
   "��ȡ����",
   "��ȡʱ��",
   "������",
   "��ȡ��ע",
   "��ȡ�˱��",
   "��ȡ�����֤",
   "��ȡ������",
   "���������˱��",
   "�������������֤",
   "��������������",
   "������ӳ����",
   "�������߱��",
   "����������",
   "������ʼʱ��",
   "��������ʱ��",
   "������ϸ���",
   "��Ʒ���",
   "��Ʒ��",
   "��Ʒ���",
   "�˾�����",
   "������ȡ����"
)
AS
   SELECT   id "��ȡ��ϸ���",
            draw_id "��ȡ��¼��",
            draw_type "��ȡ����",
            draw_date "��ȡʱ��",
            proxy_villager_name "������",
            draw_comment "��ȡ��ע",
            draw_villager_id "��ȡ�˱��",
            draw_villager_id_card "��ȡ�����֤",
            draw_villager_name "��ȡ������",
            villager_id "���������˱��",
            id_card "�������������֤",
            villager_name "��������������",
            villager_welfare_id "������ӳ����",
            welfare_policy_id "�������߱��",
            welfare_policy_name "����������",
            welfare_policy_start_time "������ʼʱ��",
            welfare_policy_end_time "��������ʱ��",
            welfare_policy_detail_id "������ϸ���",
            product_id "��Ʒ���",
            product_name "��Ʒ��",
            product_measuring_unit "��Ʒ���",
            product_quantity "�˾�����",
            product_quantity_drawed "������ȡ����"
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
   "���������˱��",
   "��������������",
   "�������������֤",
   "������ӳ����",
   "�������߱��",
   "����������",
   "������ʼʱ��",
   "��������ʱ��",
   "������ϸ���",
   "��Ʒ���",
   "��Ʒ��",
   "��Ʒ���",
   "�˾�����",
   "��������",
   "δ������"
)
AS
   SELECT   villager_id "���������˱��",
            villager_name "��������������",
            id_card "�������������֤",
            villager_welfare_id "������ӳ����",
            welfare_policy_id "�������߱��",
            welfare_policy_name "����������",
            welfare_policy_start_time "������ʼʱ��",
            welfare_policy_end_time "��������ʱ��",
            welfare_policy_detail_id "������ϸ���",
            product_id "��Ʒ���",
            product_name "��Ʒ��",
            product_measuring_unit "��Ʒ���",
            product_quantity "�˾�����",
            product_quantity_drawed "��������",
            product_quantity_remainder "δ������"
     FROM   v_welfare_for_draw_detail;


