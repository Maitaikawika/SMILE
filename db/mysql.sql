DROP TABLE IF EXISTS schema_migrations;
CREATE TABLE IF NOT EXISTS `schema_migrations` (version varchar NOT NULL);
INSERT INTO schema_migrations VALUES('20160704215047');
INSERT INTO schema_migrations VALUES('20160707021630');
DROP TABLE IF EXISTS users;
CREATE TABLE IF NOT EXISTS `users` (id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, email varchar DEFAULT '' NOT NULL, encrypted_password varchar DEFAULT '' NOT NULL, reset_password_token varchar, reset_password_sent_at datetime, remember_created_at datetime, sign_in_count integer DEFAULT 0 NOT NULL, current_sign_in_at datetime, last_sign_in_at datetime, current_sign_in_ip varchar, last_sign_in_ip varchar, created_at datetime NOT NULL, updated_at datetime NOT NULL, username varchar);
INSERT INTO users VALUES(1,'david@david-herring.com','$2a$11$CLArmj4aMBDDgOYnQFLm5OhByVZTGNo7Cqz6PGWNIeufCbNUA3Qu6',NULL,NULL,NULL,20,'2016-07-15 02:06:42.117435','2016-07-13 02:00:22.711825','192.168.0.66','192.168.0.49','2016-07-04 21:53:18.231175','2016-07-15 02:06:42.119319','David');
INSERT INTO users VALUES(2,'create@mekila.com','$2a$11$t6hJEiPEgAL8OJqNiPqKgeXUjHd4VGGZ4t4MyN2cEN.HrySd6SN06',NULL,NULL,NULL,2,'2016-07-04 23:24:38.779152','2016-07-04 22:14:53.169508','127.0.0.1','127.0.0.1','2016-07-04 22:14:53.153408','2016-07-04 23:24:38.780428',NULL);
INSERT INTO users VALUES(3,'mekila@mekila.com','$2a$11$01vTzcysMAK3mfygmKxaUuYPg.aXJ1IFyhqGPRHIskwrODqYkRoMC',NULL,NULL,NULL,4,'2016-07-12 21:55:08.296448','2016-07-12 21:38:36.111587','192.168.0.49','192.168.0.49','2016-07-04 23:30:58.374230','2016-07-12 21:55:08.298948','MeKila');
