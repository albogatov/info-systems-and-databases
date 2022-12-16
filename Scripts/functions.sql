create or replace PROCEDURE erase_destroyed_media_data() as
$$
BEGIN
  IF CURRENT_DATE LIKE '%12-31%'
  THEN 
    DELETE FROM "media_product" WHERE "status" = 'Destroyed';
  END IF;
END
$$ language plpgsql;

create or replace PROCEDURE close_case_evidence_destroyed(mcase_id integer) as
$$
DECLARE
  mproduct_id integer;
BEGIN
  UPDATE "ministry_case" SET "state" = 'Closed' where "id" = mcase_id;
  FOR mproduct_id IN SELECT "media_id" FROM "case_media_relation" WHERE "case_id" = mcase_id
    loop
      UPDATE "media_product" SET "status" = 'Destroyed' WHERE "id" = mproduct_id;
    END loop;
END;
$$ language plpgsql;

create or replace function employee_closed_case_count(empl_id integer) returns integer as
$$
  SELECT count(*) as result
  from "employee" 
  JOIN "ministry_case" ON "ministry_case"."assignee_id" = "employee"."id"
  where "employee"."id" = empl_id AND "ministry_case"."state" = 'Closed';
$$ language sql;

create or replace function employee_closed_case_count_by_name(empl_name varchar(64)) returns integer as 
$$
DECLARE
  empl_id integer;
BEGIN
  SELECT INTO empl_id "employee"."id" FROM "employee" WHERE "employee"."name" = empl_name;
  RETURN employee_closed_case_count(empl_id);
END;
$$ language plpgsql;

create or replace function department_closed_case_count(dprtmnt_id integer) returns integer as
$$
  SELECT count(*) as result
  from "department"
  		   join "employee" on "department"."id" = "employee"."department_id"
           join "ministry_case" on "ministry_case"."assignee_id" = "employee"."id"
  where "department"."id" = dprtmnt_id AND "ministry_case"."state" = 'Closed';
$$ language sql;

create or replace function department_target_check(dprtmnt_id integer) returns boolean as
$$
DECLARE
  target integer;
BEGIN
  SELECT INTO target "department_designation"."expected_target" from "department"
               join "department_designation" 
               on "department"."designation_id" = "department_designation"."id"
               WHERE "department"."id" = dprtmnt_id;
  IF target < department_closed_case_count(dprtmnt_id)
  	THEN RETURN TRUE;
  ELSE RETURN FALSE;
  END IF;
END;
$$ language plpgsql;

create or replace function dptmt_failed_target_count() returns integer as
$$
DECLARE
  rslt integer := 0;
  did integer;
BEGIN
  FOR did IN SELECT "id" as did FROM "department"
  	loop
    	IF NOT (department_target_check(did))
        THEN rslt := rslt + 1;
        END IF;
    END loop;
    RETURN rslt;
END;
$$ language plpgsql;
