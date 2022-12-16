CREATE OR REPLACE FUNCTION check_foundation_dates()
    RETURNS TRIGGER AS
$$
DECLARE
BEGIN
    IF NEW."date_termination" <= NEW."date_foundation"
    THEN
        RAISE EXCEPTION 'Wrong dates in DEPARTMENT([id:%])',
            NEW.id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER check_foundation_dates_trigger
    AFTER INSERT OR UPDATE
    ON "department"
    FOR EACH ROW
EXECUTE PROCEDURE check_foundation_dates();

CREATE OR REPLACE FUNCTION check_department_terminated()
    RETURNS TRIGGER AS
$$
DECLARE
caseid integer;
BEGIN
    IF NEW."date_termination" is not null AND NEW."date_termination" < CURRENT_DATE 
    THEN
	update "department" set "status" = 'Terminated' where "id" = NEW."id";
        for caseid in SELECT mc."id" from "ministry_case" mc join "employee" ee on ee."id" = mc."assignee_id" where ee."department_id" = NEW."id" 
        loop
        	call close_case_evidence_destroyed(caseid);
        END loop;
    ELSE IF NEW."status" = 'Terminated'
    THEN
        update "department" set "date_termination" = CURRENT_DATE where "id" = NEW."id";
        for caseid in SELECT mc."id" from "ministry_case" mc join "employee" ee on ee."id" = mc."assignee_id" where ee."department_id" = NEW."id" 
        loop
        	call close_case_evidence_destroyed(caseid);
        END loop;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER check_department_terminated_trigger
    BEFORE INSERT OR UPDATE
    ON "department"
    FOR EACH ROW
EXECUTE PROCEDURE check_department_terminated();

CREATE OR REPLACE FUNCTION check_device_dates()
    RETURNS TRIGGER AS
$$
DECLARE
BEGIN
    IF NEW."date_terminated" <= NEW."date_made"
    THEN
        RAISE EXCEPTION 'Wrong dates in DEVICE([id:%])',
            NEW.id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER check_device_dates_trigger
    AFTER INSERT OR UPDATE
    ON "device"
    FOR EACH ROW
EXECUTE PROCEDURE check_device_dates();


CREATE OR REPLACE FUNCTION check_media_state()
    RETURNS TRIGGER AS
$$
BEGIN
    IF NEW."status" IN ('Destroyed', 'Rereleased', 'Redacted')
    THEN
        RAISE EXCEPTION 'New media product has to be processed before the original can be edited: ([id:%])',
            NEW.id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER check_media_state_trigger
    AFTER INSERT
    ON "media_product"
    FOR EACH ROW
EXECUTE PROCEDURE check_media_state();


CREATE OR REPLACE FUNCTION check_employee_access()
    RETURNS TRIGGER AS
$$
DECLARE
    access_lvl integer;
BEGIN
    SELECT into access_lvl "access_level" from "position" where id = new."position_id";

    IF access_lvl > 1 AND new."name" LIKE 'Junior%'
    THEN
        RAISE EXCEPTION 'New employee cannot be immediately granted high level access';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER check_employee_access_trigger
    AFTER INSERT
    ON "employee"
    FOR EACH ROW
EXECUTE PROCEDURE check_employee_access();

CREATE OR REPLACE FUNCTION check_case_department_category()
    RETURNS TRIGGER AS
$$
DECLARE
    dprtmnt_id integer;
    category_id integer;
BEGIN
    SELECT into dprtmnt_id "department_id" from "employee" JOIN "ministry_case" ON "employee"."id" = "ministry_case"."assignee_id" where ministry_case.id = new."case_id";
	SELECT INTO category_id "media_category_id" FROM "media_product" WHERE id = new."media_id";
    
    IF dprtmnt_id not in (
        SELECT "id"
        from "department"
        where "media_category_id" = category_id
    )
    THEN
        RAISE EXCEPTION 'Chosen media goes out of scope of the assigned department %', new."media_id";
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER check_case_department_category_trigger
    AFTER INSERT OR UPDATE
    ON "case_media_relation"
    FOR EACH ROW
EXECUTE PROCEDURE check_case_department_category();

CREATE OR REPLACE FUNCTION check_device_is_appropriate()
    RETURNS TRIGGER AS
$$
DECLARE
    dev_type varchar(32);
    med_id integer;
    med_type varchar(32);
BEGIN
	SELECT INTO dev_type "type" FROM "device" WHERE "id" = new."device_id";
    for med_id in select "media_id" from "case_media_relation" where "case_id" = new."case_id"
        loop
            SELECT into med_type "media_category"."type" FROM "media_category" 
                        JOIN "media_product" ON "media_product"."media_category_id" = "media_category"."id"
                            WHERE "media_product"."id"= med_id;
            IF NOT dev_type ILIKE CONCAT(med_type, '%')
            then 
                RAISE EXCEPTION 'Chosen device % is not appropriate for media % needed for case %', new."device_id", med_id, new."case_id";
           	END IF;
        end loop;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER check_device_is_appropriate_trigger
    AFTER INSERT OR UPDATE
    ON "case_device_relation"
    FOR EACH ROW
EXECUTE PROCEDURE check_device_is_appropriate();

