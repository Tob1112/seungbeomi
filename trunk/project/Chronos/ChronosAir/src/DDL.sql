--======================================================
-- CREATE
--======================================================
-- 社員
CREATE TABLE shain ( id TEXT PRIMARY KEY, password TEXT, shainMei TEXT, rememberMe  INTEGER, shainBango	TEXT);
-- 勤務表
CREATE TABLE kinmuhyo (nengetsu TEXT PRIMARY KEY, shinseiBango TEXT, shinseiKubun TEXT, shinseiJokyo TEXT, syoteiNissu INTEGER, sagyoNissu INTEGER, kekkinNissu INTEGER, jitsudoJikanGokei REAL, sagyoGenba TEXT);
-- 勤務表詳細
CREATE TABLE kinmuhyoShosai (nengetsu TEXT, hizuke TEXT, yasumiKubun TEXT, shigyoJikan TEXT, shigyoJikanchiREAL, syuryoJikan TEXT, syuryoJikanchiREAL, kyukeiJikan REAL, jitsudoJikanREAL, sagyoNaiyo TEXT);
-- 時刻表
CREATE TABLE jikokuhyo (jikoku TEXT, jikokuchi REAL);
-- コード
CREATE TABLE code (code TEXT, value TEXT);

--======================================================
-- INSERT
--======================================================
INSERT INTO jikokuhyo (jikoku, jikokuchi) SELECT '08:00', 0.0 UNION SELECT '08:15', 0.25 UNION SELECT '08:30', 0.5 UNION SELECT '08:45', 0.75 UNION SELECT '09:00', 1.0 UNION SELECT '09:15', 1.25 UNION SELECT '09:30', 1.5 UNION SELECT '09:45', 1.75 UNION SELECT '10:00', 2.0 UNION SELECT '10:15', 2.25 UNION SELECT '10:30', 2.5 UNION SELECT '10:45', 2.75 UNION SELECT '11:00', 3.0 UNION SELECT '11:15', 3.25 UNION SELECT '11:30', 3.5 UNION SELECT '11:45', 3.75 UNION SELECT '12:00', 4.0 UNION SELECT '12:15', 4.25 UNION SELECT '12:30', 4.5 UNION SELECT '12:45', 4.75 UNION SELECT '13:00', 5.0 UNION SELECT '13:15', 5.25 UNION SELECT '13:30', 5.5 UNION SELECT '13:45', 5.75 UNION SELECT '14:00', 6.0 UNION SELECT '14:15', 6.25 UNION SELECT '14:30', 6.5 UNION SELECT '14:45', 6.75 UNION SELECT '15:00', 7.0 UNION SELECT '15:15', 7.25 UNION SELECT '15:30', 7.5 UNION SELECT '15:45', 7.75 UNION SELECT '16:00', 8.0 UNION SELECT '16:15', 8.25 UNION SELECT '16:30', 8.5 UNION SELECT '16:45', 8.75 UNION SELECT '17:00', 9.0 UNION SELECT '17:15', 9.25 UNION SELECT '17:30', 9.5 UNION SELECT '17:45', 9.75 UNION SELECT '18:00', 10.0 UNION SELECT '18:15', 10.25 UNION SELECT '18:30', 10.5 UNION SELECT '18:45', 10.75 UNION SELECT '19:00', 11.0 UNION SELECT '19:15', 11.25 UNION SELECT '19:30', 11.5 UNION SELECT '19:45', 11.75 UNION SELECT '20:00', 12.0 UNION SELECT '20:15', 12.25 UNION SELECT '20:30', 12.5 UNION SELECT '20:45', 12.75 UNION SELECT '21:00', 13.0 UNION SELECT '21:15', 13.25 UNION SELECT '21:30', 13.5 UNION SELECT '21:45', 13.75 UNION SELECT '22:00', 14.0 UNION SELECT '22:15', 14.25 UNION SELECT '22:30', 14.5 UNION SELECT '22:45', 14.75 UNION SELECT '23:00', 15.0 UNION SELECT '23:15', 15.25 UNION SELECT '23:30', 15.5 UNION SELECT '23:45', 15.75 UNION SELECT '00:00', 16.0 UNION SELECT '00:15', 16.25 UNION SELECT '00:30', 16.5 UNION SELECT '00:45', 16.75 UNION SELECT '01:00', 17.0 UNION SELECT '01:15', 17.25 UNION SELECT '01:30', 17.5 UNION SELECT '01:45', 17.75 UNION SELECT '02:00', 18.0 UNION SELECT '02:15', 18.25 UNION SELECT '02:30', 18.5 UNION SELECT '02:45', 18.75 UNION SELECT '03:00', 19.0 UNION SELECT '03:15', 19.25 UNION SELECT '03:30', 19.5 UNION SELECT '03:45', 19.75 UNION SELECT '04:00', 20.0 UNION SELECT '04:15', 20.25 UNION SELECT '04:30', 20.5 UNION SELECT '04:45', 20.75 UNION SELECT '05:00', 21.0 UNION SELECT '05:15', 21.25 UNION SELECT '05:30', 21.5 UNION SELECT '05:45', 21.75 UNION SELECT '06:00', 22.0 UNION SELECT '06:15', 22.25 UNION SELECT '06:30', 22.5 UNION SELECT '06:45', 22.75 UNION SELECT '07:00', 23.0 UNION SELECT '07:15', 23.25 UNION SELECT '07:30', 23.5 UNION SELECT '07:45', 23.75;
-- 1-2桁:休み区分/3桁：0-有給休暇,1-無休休暇,2-代替休暇/4桁：区分
INSERT INTO code (code, value) SELECT '0101', '有給休暇(全)' UNION SELECT '0102', '有給休暇(半)' UNION SELECT '0111', '無給休暇(全)' UNION SELECT '0112', '無給休暇(半)' UNION SELECT '0121', '代替休暇(全)' UNION SELECT '0122', '代替休暇(半)';