DELETE FROM case_device_relation WHERE TRUE;
DELETE FROM case_media_relation WHERE TRUE;
DELETE FROM ministry_case WHERE TRUE;
DELETE FROM device WHERE TRUE;
DELETE FROM "rule" WHERE TRUE;
DELETE FROM guideline WHERE TRUE;
DELETE FROM employee WHERE TRUE;
DELETE FROM department WHERE TRUE;
DELETE FROM media_product WHERE TRUE;
DELETE FROM publisher WHERE TRUE;
DELETE FROM "position" WHERE TRUE;
DELETE FROM media_category WHERE TRUE;
DELETE FROM department_designation WHERE TRUE;










alter SEQUENCE ministry_case_id_seq RESTART 1;
alter SEQUENCE device_id_seq RESTART 1;
alter SEQUENCE "rule_id_seq" RESTART 1;
alter SEQUENCE guideline_id_seq RESTART 1;
alter SEQUENCE employee_id_seq RESTART 1;
alter SEQUENCE department_id_seq RESTART 1;
alter SEQUENCE media_product_id_seq RESTART 1;
alter SEQUENCE publisher_id_seq RESTART 1;
alter SEQUENCE "position_id_seq" RESTART 1;
alter SEQUENCE media_category_id_seq RESTART 1;
alter SEQUENCE department_designation_id_seq RESTART 1;
