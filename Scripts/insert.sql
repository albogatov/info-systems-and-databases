INSERT INTO department_designation ("name", "expected_target")
VALUES ('Censorship', 1000),
          ('Video Production', 100),
       ('Radio Production', 250),
       ('Book Production', 1000),
       ('Special Materials Production', 50);

INSERT INTO media_category ("name", "type", "yearly_quota")
VALUES ('TV Show', 'VIDEO', 10),
          ('TV News', 'VIDEO', 365),
       ('Radio Show', 'AUDIO', 365),
       ('Music', 'AUDIO', 500),
       ('Propaganda Reel', 'VIDEO', 100),
       ('Book', 'TEXT', 100),
       ('Film', 'VIDEO', 50),
       ('Gazette', 'TEXT', 100),
       ('Painting', 'OTHER', 10);
       
INSERT INTO "position" ("name", "salary", "access_level")
VALUES ('Junior Agent', 100, 1),
          ('Junior Stationary', 110, 1),
       ('Agent Censor', 200, 1),
       ('Division Lead', 500, 2),
       ('Division Supervisor', 350, 2),
       ('Senior Agent', 400, 2),
       ('Head of Department', 1000, 3),
       ('Minister of Truth', 999999, 4);
       
INSERT INTO publisher ("name", "foundation_date")
VALUES ('Oceania News', CURRENT_DATE),
          ('Oceania Truth', CURRENT_DATE),
       ('The NewSpeak Post', CURRENT_DATE),
       ('Oceania Ltd.', CURRENT_DATE);
       
INSERT INTO publisher ("name", "foundation_date", "employees_count", "registration_code", "representative")
values    ('Oceania TV Productions', '1984-10-10', 200, 'YYY123', 'Borisov Boris Borisovich');
       
INSERT INTO media_product ("title", "estimation", "status", "media_category_id", "publisher_id")
VALUES ('Real Housewives of Oceania', 1, 'Processing', 1, 5),
       ('The Post', 1, 'Discovered', 1, 5),
       ('The Revolution', 5, 'Discovered', 8, 2),
       ('The Unspeakable', 5, 'Processing', 3, 4),
       ('News for March 5th of 1984', 3, 'Discovered', 2, 1),
       ('The lies of Big Brother', 8, 'Processing', 6, 2),
       ('News for March 12th of 1984', 3, 'Processing', 2, 1),
       ('News for March 30th of 1984', 3, 'Processing', 2, 1);
       
INSERT INTO department ("name", "status", "designation_id", "media_category_id")
VALUES ('Department of Rebellious TV', 'Active', 1, 1),
       ('Department of Patriotic Discipline', 'Active', 2, 5),
       ('First Department of History', 'Active', 1, 2),
       ('Second Department of History', 'Active', 5, 2),
       ('Department of War Materials', 'Suspended', 1, 3);
       
INSERT INTO department ("name", "status", "designation_id", "media_category_id", "date_foundation", "date_termination")
VALUES ('Third Department of Novels', 'Terminated', 1, 6, '1982-10-10', '1984-01-01');

INSERT INTO employee ("name", "age", "address", "married", "children_amount", "department_id", "position_id")
VALUES ('Laura', 27, 'West side, west street, 255b, 33', false, 0, 1, 2),
          ('Serge', 55, null, true, 2, 1, 7),
       ('Alexandr', 45, null, false, 1, 1, 5),
       ('Andrew', 22, null, false, 0, 1, 3),
       ('Bill', 53, null, true, 2, 2, 7),
       ('Alexandr', 35, null, false, 1, 2, 5),
       ('Andrew', 29, null, false, 0, 2, 3),
       ('Stan', 41, null, true, 1, 2, 2),
       ('Phil', 53, null, true, 2, 3, 7),
       ('Alexandra', 35, null, false, 1, 3, 5),
       ('Alex', 29, null, false, 0, 3, 3),
       ('Stew', 41, null, true, 1, 3, 2),
       ('Duck', 53, null, true, 2, 4, 7),
       ('Kat', 35, null, false, 1, 4, 5),
       ('Omar', 29, null, false, 0, 4, 3),
       ('Guy', 41, null, true, 1, 4, 2),
       ('Yuri', 53, null, true, 2, 5, 7),
       ('Oleg', 35, null, false, 1, 5, 5),
       ('Viktor', 29, null, false, 0, 5, 3),
       ('Gemma', 41, null, true, 1, 5, 2);
       
INSERT INTO guideline ("name", "department_id", "author_id")
VALUES ('Main Guideline For Censors of TV', 1, 2),
          ('Main Guideline: Propaganda Production 101', 2, 2),
       ('Guideline: History Unpreservation', 3, 2),
       ('Guideline: History Unpreservation for producers', 4, 2),
       ('Guideline: War History Coverage', 5, 2);
       
INSERT INTO "rule" ("description", "punishment", "guideline_id")
VALUES ('Every original containing unredacted data must be burned immediately after closing the case, 
        archived data will be destroyed at the end of the year', 'Ministry of Love Room 101', 1),
       ('All reels must contain at least 10 mentions of The Big Brother', 'Reevaluation', 2),
       ('Any mentions of what never happened never existed', 'Ministry of Love Room 101', 3),
       ('No actual war footage can be used', 'Ministry of Love Room 101', 4),
       ('Obituaries for veterans must not mention details of war conflict', 'Party will be dissapointed', 5);
 
INSERT INTO device ("type", "model", "maintainer_id") 
VALUES ('AUDIO_CAPTURE', 'AREC 102X', 1),
          ('VIDEO_CAPTURE', 'VCAM 612U', 1),
       ('TEXT_CAPTURE', 'YYG123', 3),
       ('VIDEO_CAPTURE', 'VCAM 712U', 1);
       
INSERT INTO ministry_case ("state", "assignee_id")
VALUES ('In Progress', 1),
          ('In Progress', 4),
       ('In Progress', 2),
       ('Open', 9),
       ('Incomplete', 1),
       ('Incomplete', 12);

INSERT INTO case_media_relation ("case_id", "media_id")
VALUES (1,1),
          (1,2),
       (2,1),
       (3,2),
       (4,5),
       (5,1),
       (6,5),
       (4,7),
       (6,8);
       
INSERT INTO case_device_relation ("case_id", "device_id")
values    (1,2),
           (1,4),
           (2,2),
           (3,4),
           (4,2),
           (5,2),
           (6,2);
