INSERT INTO department_designation ("id", "name", "expected_target")
VALUES (10000, 'Censorship', 1000),
          (10001,'Video Production', 100),
       (10002, 'Radio Production', 250),
       (10003, 'Book Production', 1000),
       (10004, 'Special Materials Production', 50);

INSERT INTO media_category ("id", "name", "type", "yearly_quota")
VALUES (10000, 'TV Show', 'VIDEO', 10),
          (10001, 'TV News', 'VIDEO', 365),
       (10002, 'Radio Show', 'AUDIO', 365),
       (10003, 'Music', 'AUDIO', 500),
       (10004, 'Propaganda Reel', 'VIDEO', 100),
       (10005, 'Book', 'TEXT', 100),
       (10006, 'Film', 'VIDEO', 50),
       (10007, 'Gazette', 'TEXT', 100),
       (10008, 'Painting', 'OTHER', 10);

INSERT INTO "position" ("id", "name", "salary", "access_level")
VALUES (10000, 'Junior Agent', 100, 1),
          (10001,'Junior Stationary', 110, 1),
       (10002,'Agent Censor', 200, 1),
       (10003,'Division Lead', 500, 2),
       (10004,'Division Supervisor', 350, 2),
       (10005,'Senior Agent', 400, 2),
       (10006,'Head of Department', 1000, 3),
       (10007, 'Minister of Truth', 999999, 4);
