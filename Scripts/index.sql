CREATE INDEX IX_MEDIA_PRODUCT_STATUS ON "media_product" USING btree("status");

CREATE INDEX IX_MEDIA_CATEGORY_TYPE ON "media_category" USING btree("type");

CREATE INDEX IX_MINISTRY_CASE_STATE ON "ministry_case" USING hash("state");

CREATE INDEX IX_DEVICE_TYPE ON "device" USING btree("type");

CREATE INDEX IX_EMPLOYEE_DEPARTMENT ON "employee" USING hash("department_id");

CREATE INDEX IX_CASE_ASSIGNEE ON "ministry_case" USING hash("assignee_id");

CREATE INDEX IX_MEDIA_PRODUCT_CATEGORY ON "media_product" USING hash("media_category_id");

CREATE INDEX IX_DEPARTMENT_CATEGORY ON "department" USING hash("media_category_id");

CREATE INDEX IX_DEPARTMENT_DESIGNATION ON "department" USING hash("designation_id");
