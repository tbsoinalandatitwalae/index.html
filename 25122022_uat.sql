  CREATE OR REPLACE FORCE EDITIONABLE VIEW "IP_FUNDING"."INSURANCE_TRANS_VIEW" ("COMPANY", "CONT_NO", "BP_NO", "CUSTOMER_NAME", "CUSTOMER_ADDRESS1", "CUSTOMER_ADDRESS2", "CUSTOMER_ADDRESS3", "PINCODE", "REGION", "ZONE", "BRANCH", "REGISTRATION_NUMBER", "VEHICLE_TYPE", "PREVIOUS_IDV", "POLICY_END_DATE", "PREVIOUS_POLICY_NUMBER", "INSURANCE_COMPANY_CODE", "MODEL", "TENURE", "ROI", "EMI", "YEAR_OF_MANUFACTURING", "MOBILE_NUMBER", "PROPOSAL_NO", "IDV", "TOTAL_PREMIUM", "DOCUMENT_CHARGES", "PROCESSING_FEE", "STAMPING_CHARGES", "FINANCE_AMOUNT", "CRT_DT", "CRT_BY", "MOD_DT", "MOD_BY", "TRANS_NO", "MOD_ID", "CALLBACK_DATE_TIME", "OTP", "STATUS", "ACT_DT", "REMARK", "ACT_BY_NAME", "ACT_TO_NAME", "STATUS_ID", "STATUS_CODE", "NEXT_LEVEL", "OFFER_OTP_SEND_DT", "OFFER_OTP_CONF_DT", "OFFER_OTP", "INS_COPY_REC", "INS_COPY_REC_DATE", "AGREEMENT_OTP_SEND_DT", "AGREEMENT_OTP_CONF_DT", "AGREEMENT_OTP", "AGREEMENT_REC", "CALL_BACK_DT", "FAN_NO", "PROPOSAL_DOC_REC", "APPL_OTP_SEND_DT", "APPL_OTP_CONF_DT", "APPL_OTP", "STATE", "PROCESSING_FEES", "INSURANCE_COMPANY_NAME", "DATE_MASTER_AGREEMENT", "MASTER_LOAN_AMOUNT", "LOAN_APPL_AMOUNT", "VARNCULR_LNG", "PREAPPROVED_ELIGBILITY_AMOUNT", "BRANCH_CODE", "DIVISION", "STAMPING_STATE", "DEALER_NAME", "DEALER_CODE", "SUPPLIER", "EMPLOYEE_RESPONSIBLE", "DISTRIBUTION_CHANNEL", "NORM_CUST_SEGMENT", "RTO_NUMBER", "REGISTRATION_CODE", "REGISTRATION_SERIAL_NUMBER", "CHASSIS_NUMBER", "SEATING_CAPACITY", "ENGINE_NO", "NEW_CONT_NO", "SAP_RESP_MSG") AS 
  SELECT
  "COMPANY","CONT_NO","BP_NO","CUSTOMER_NAME","CUSTOMER_ADDRESS1","CUSTOMER_ADDRESS2","CUSTOMER_ADDRESS3","PINCODE","REGION","ZONE","BRANCH","REGISTRATION_NUMBER","VEHICLE_TYPE","PREVIOUS_IDV","POLICY_END_DATE","PREVIOUS_POLICY_NUMBER","INSURANCE_COMPANY_CODE","MODEL","TENURE","ROI","EMI","YEAR_OF_MANUFACTURING","MOBILE_NUMBER","PROPOSAL_NO","IDV",nvl(total_premium,0) total_premium,"DOCUMENT_CHARGES","PROCESSING_FEE","STAMPING_CHARGES","FINANCE_AMOUNT","CRT_DT","CRT_BY","MOD_DT","MOD_BY","TRANS_NO","MOD_ID" ,callback_date_time,otp,
(SELECT act_id ||'-'||(SELECT sts_act_descr FROM insurance_act_master WHERE sts_id = act_id)   FROM insurance_act_log x WHERE x.trans_no = a.trans_no
AND act_dt = (SELECT MAX(act_dt) FROM insurance_act_log x1 WHERE x1.trans_no = a.trans_no ) AND ROWNUM =1) status,
(SELECT act_dt  FROM insurance_act_log x WHERE x.trans_no = a.trans_no
AND act_dt = (SELECT MAX(act_dt) FROM insurance_act_log x1 WHERE x1.trans_no = a.trans_no ) AND ROWNUM =1) act_dt,
(SELECT remark  FROM insurance_act_log x WHERE x.trans_no = a.trans_no
AND act_dt = (SELECT MAX(act_dt) FROM insurance_act_log x1 WHERE x1.trans_no = a.trans_no ) AND ROWNUM =1) remark,
f_get_status_by(trans_no) act_by_name, f_get_status_to(trans_no) act_to_name,
(SELECT act_id  FROM insurance_act_log x WHERE x.trans_no = a.trans_no
AND act_dt = (SELECT MAX(act_dt) FROM insurance_act_log x1 WHERE x1.trans_no = a.trans_no ) AND ROWNUM =1) status_id,
f_get_status_insurance(trans_no) status_code,
f_get_nxtlvel_loan_insurance(trans_no) next_level,
offer_otp_send_dt,
offer_otp_conf_dt,
offer_otp,
ins_copy_rec,
ins_copy_rec_date,
agreement_otp_send_dt,
agreement_otp_conf_dt,
agreement_otp,
agreement_rec,
call_back_dt, fan_no,proposal_doc_rec,appl_otp_send_dt,appl_otp_conf_dt,appl_otp,state,processing_fees,insurance_company_name,date_master_agreement,
master_loan_amount,loan_appl_amount,varnculr_lng,preapproved_eligbility_amount,
branch_code,
division  ,      
stamping_state   ,
dealer_name,
dealer_code     ,
supplier                   ,
employee_responsible   ,
distribution_channel   ,
norm_cust_segment     ,
rto_number                         ,
registration_code                    ,
registration_serial_number,
chassis_number,
seating_capacity,
engine_no,
new_cont_no,
sap_resp_msg
FROM
insurance_trans a;
