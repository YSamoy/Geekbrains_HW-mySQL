/*В данной курсовой работе описана модель храннеия данных для сайта авикомпании
*/
DROP DATABASE IF EXISTS s7;
CREATE DATABASE s7;
USE s7;

/*юзеры*/
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    email VARCHAR(120) UNIQUE NOT NULL,
    phone BIGINT NOT NULL, 
    loyalty_card VARCHAR(255),
    birthday DATE NOT NULL, 
    flight_status VARCHAR(255) DEFAULT 'JUNIOR'
);
INSERT INTO users VALUES
('1', 'Igor', 'Samoylov', 'i.sam@mail.ru', '+781727362837', '00000001', '1987-01-02', 'MASTER'),
('2', 'Alyona', 'Kubova', 'a.kub@mail.ru', '+74567275562837', '00000021', '1998-01-09', 'JUNIOR'),
('3', 'Iliya', 'Belov', 'i.belovm@gmail.ru', '+767542962837', '00030001', '1977-12-21', 'SILVER'),
('4', 'Elizabeth', 'Ozol', 'eli.za@yandex.ru', '+767430962347', '00045001', '1998-03-09', 'JUNIOR'),
('5', 'Vladimir', 'Presnov', 'vladimir.prm@mail.ru', '+78172675677', '034980001', '1985-05-25', 'GOLD'),
('6', 'Stanislav', 'Orlov', 'st.orlov@rambler.ru', '+7817456543', '00456711', '1976-11-16', 'GOLD'),
('7', 'Svetlana', 'Osipova', 'svetik.o@mail.ru', '+781727834517', '05671001', '1997-03-19', 'MASTER'),
('8', 'Kseniya', 'Sinica', 'kseniya.s@yandex.ru', '+745781262837', '05671001', '1997-04-19', 'JUNIOR'),
('9', 'Eugeniy', 'Pirogov', 'e.pir@mail.ru', '+7817678937', '453412', '1989-03-31', 'SILVER'),
('10', 'Anna', 'Simonova', 'annya.sm@mail.ru', '+7834975637', '0892341', '2003-12-12', 'SILVER');
 
 
 /*юзеры описание*/
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles(
	id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
    passport_number BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    hometown VARCHAR(100),
    miles_balance BIGINT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE restrict);
INSERT INTO profiles  VALUES
('1', '1', '5005345671', NOW(),  'Omsk', '567'),
('2', '2', '3456345671', NOW(), 'Tomsk', '637'),
('3', '3', '5008923671', NOW(), 'Novosibirsk', '1567'),
('4', '4', '5705346123', NOW(), 'Barnaul', '5367'),
('5', '5', '5054343321', NOW(), 'Moscow', '5637'),
('6', '6', '2387534671', NOW(), 'Omsk', '9897'),
('7', '7', '3487451298', NOW(), 'Krasnoyrsk', '34567'),
('8', '8', '6754345671', NOW(), 'Tumen', '32447'),
('9', '9', '5643567671', NOW(), 'Novosibirsk', '19267'),
('10', '10', '52785646', NOW(), 'Tomsk', '32817');

/*программа лояльности*/
DROP TABLE IF EXISTS loyalty;
CREATE TABLE loyalty(
	id SERIAL,
    flight_status ENUM('JUNIOR', 'MASTER', 'SILVER', 'GOLD', 'PLATINUM'),
    loyalty_spread VARCHAR(255)
    );
INSERT INTO loyalty VALUES
(1, 'JUNIOR', '0 - 4000'),
(NULL, 'MASTER', '4001-12000'),
(NULL, 'SILVER', '12001-20000'),
(NULL, 'GOLD', '20001-32000'),
(NULL, 'PLATINUM', 'UP TO 32001');

/*полеты самолетов*/
DROP TABLE IF EXISTS flight_map;
CREATE TABLE flight_map(
	id SERIAL PRIMARY KEY,
    destination VARCHAR(255) NOT NULL,
    departure VARCHAR(255) NOT NULL,
    miles INT NOT NULL,
    flight_number VARCHAR(255) NOT NULL    
);
INSERT INTO flight_map VALUES
(NULL, 'Moscow', 'Omsk', '4400', 'AC341'),
(NULL, 'Omsk', 'Moscow', '4400', 'AC341'),
(NULL, 'Moscow', 'Novosibirsk', '4800', 'KL196'),
(NULL, 'Novosibirsk', 'Moscow', '4800', 'KL196'),
(NULL, 'Novosibirsk', 'Omsk', '2000', 'NO231'),
(NULL, 'Omsk', 'Novosibirsk',  '2000', 'NO231');

/*информация по бронированию*/
DROP TABLE IF EXISTS booking;
CREATE TABLE booking(
	id SERIAL AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    flight_number VARCHAR(255) NOT NULL, 
    baggage BIT,
    sport_euqpment BIT, 
    add_baggage BIT,
    
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE restrict,
    INDEX (flight_number)
    );
    
INSERT INTO booking VALUES
('1', '1', 'NO231', 1, 0, 0),
(NULL, '2', 'NO231', 1, 0, 0),
(NULL, '3', 'KL196', 1, 0, 0),
(NULL, '6', 'NO231', 1, 0, 0),
(NULL, '7', 'KL196', 1, 0, 0),
(NULL, '9', 'NO231', 1, 0, 0),
(NULL, '8', 'KL196', 1, 0, 0),
(NULL, '2', 'AC341', 1, 0, 0),
(NULL, '3', 'NO231', 1, 0, 1),
(NULL, '4', 'NO231', 1, 1, 0);

/*оплата бронирования*/
DROP TABLE IF EXISTS payments;
CREATE TABLE payments(
	id SERIAL,
    booking_id VARCHAR(255) NOT NULL,
    success_transaction BIT,
    FOREIGN KEY (id) REFERENCES booking(id),
    INDEX booking_indx(booking_id)
);
    
    INSERT INTO payments VALUES
    (NULL, '775a12', 0),
    (NULL, '1d1652', 1),
    (NULL, '462546', 1),
    (NULL, 'aad4b0', 0),
    (NULL, 'a662fd', 1),
    (NULL, '1831ef', 0),
    (NULL, 'fa2ade', 1),
    (NULL, '6b8513', 0),
    (NULL, '5d3a35', 1);

 /*статус рейса*/
DROP TABLE IF EXISTS flight_status;
CREATE TABLE flight_status(
	id SERIAL,
    flight VARCHAR(255) NOT NULL,
    departure_time DATETIME NOT NULL,
    flight_status ENUM('CHECK IN', 'BOARDER', 'DELAY', 'TAKE OFF', 'ARRIVED'),
    FOREIGN KEY (id) REFERENCES flight_map(id)
    
);
INSERT INTO flight_status VALUES
(NULL, 'NO231', '2022-11-11 00:15:00', 'CHECK IN' ),
(NULL, 'AC341', '2022-11-11 00:30:00', 'DELAY' ),
(NULL, 'KL196', '2022-11-11 01:10:00', 'BOARDER' ),
(NULL, 'KL196', '2022-11-10 01:10:00', 'TAKE OFF'),
(NULL, 'AC341', '2022-11-10 00:30:00', 'TAKE OFF'),
(NULL, 'NO231', '2022-11-10 00:15:00', 'DELAY');

/*статус регистрации на рейс*/
DROP TABLE IF EXISTS check_in;
CREATE TABLE check_in(
	id SERIAL,
	flight_number VARCHAR(255) NOT NULL,
    departure_time DATETIME NOT NULL,
    check_in ENUM('OPEN', 'CLOSE'),
    FOREIGN KEY (id) REFERENCES flight_status(id)
    
);

INSERT INTO check_in VALUES
(NULL, 'NO231', '2022-11-11 00:15:00', 'OPEN'), 
(NULL, 'AC341', '2022-11-11 00:30:00', 'OPEN'),
(NULL, 'KL196', '2022-11-11 01:10:00', 'OPEN'),
(NULL, 'KL196', '2022-11-10 01:10:00', 'CLOSE'),
(NULL, 'AC341', '2022-11-10 00:30:00', 'CLOSE'),
(NULL, 'NO231', '2022-11-10 00:15:00', 'CLOSE');
 
 
/*информация по наполняемости рейса*/       
DROP TABLE IF EXISTS flight_passangers;
CREATE TABLE flight_passangers(
	id SERIAL,
    flight_number VARCHAR(255) NOT NULL,
    departure_time DATETIME NOT NULL,
    user_id  BIGINT UNSIGNED NOT NULL,
    
    FOREIGN KEY flight_passangers(user_id) REFERENCES users(id)

);

INSERT INTO flight_passangers VALUES
(NULL, 'NO231', '2022-11-11 00:15:00', '1'),
(NULL, 'NO231', '2022-11-11 00:15:00', '2'),
(NULL, 'NO231', '2022-11-11 00:15:00', '5'),
(NULL, 'AC341', '2022-11-11 00:30:00', '3'),
(NULL, 'AC341', '2022-11-11 00:30:00', '4'),
(NULL, 'AC341', '2022-11-11 00:30:00', '6'),
(NULL, 'KL196', '2022-11-11 01:10:00', '7' ),
(NULL, 'KL196', '2022-11-11 01:10:00', '8' ),
(NULL, 'KL196', '2022-11-11 01:10:00', '9' );

/*состояние лицевого счета каждого юзера*/
DROP TABLE IF EXISTS users_cashbalance;
CREATE TABLE users_cashbalance(
	id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
    vaucher BIGINT DEFAULT '0',
    
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO users_cashbalance VALUE
(NULL, '1', '45000'),
(NULL, '2', '3500'),
(NULL, '3', '0'),
(NULL, '4', '300'),
(NULL, '5', '567'),
(NULL, '6', '0'),
(NULL, '7', '3500'),
(NULL, '8', '1239'),
(NULL, '9', '23897'),
(NULL, '10', '2139');

/*как много пользователей в каждом статусе*/
SELECT COUNT(*) total_users, flight_status FROM users GROUP BY flight_status;


/* у кого из пользователей больше всего миль*/
SELECT concat(firstname, ' ', lastname) FIO FROM users WHERE id = 
(SELECT user_id FROM profiles ORDER BY miles_balance DESC LIMIT 1);

/*Самое загруженное направление*/
DROP VIEW IF EXISTS frequent_flight;
CREATE VIEW frequent_flight AS
SELECT COUNT(*) booked, flight_number  FROM booking  GROUP BY flight_number ORDER BY booked DESC LIMIT 1;

SELECT ff.*, concat(fm.destination, '-', fm.departure, ' / ',  fm.departure,'-', fm.destination) flight FROM frequent_flight ff
JOIN flight_map fm ON ff.flight_number=fm.flight_number LIMIT 1;

/*Представление - Вывести: пользователя, номер бронирования, количество миль на счету,
сумма ваучера тех пользователей, у кого не оплачено бронирование*/
DROP VIEW IF EXISTS no_transaction;
CREATE VIEW no_transaction AS
SELECT u.id, u.email, u. phone, concat(u.firstname, ' ', u.lastname) FIO, p.booking_id, pr.miles_balance, v.vaucher, b.flight_number, fl_m.miles
FROM payments p
JOIN booking b ON b.id=p.id AND p.success_transaction = 0
JOIN users u ON b.user_id=u.id
JOIN profiles pr ON pr.user_id=u.id
JOIN users_cashbalance v ON v.user_id=u.id
JOIN flight_map fl_m ON b.flight_number=fl_m.flight_number GROUP BY booking_id; 

SELECT * FROM no_transaction;
/*Процедура. Проверяем достаточно ли средст на ваучере user.cashbalance_vaucher 
пользователя для завершения бронирования(flight_map.miles). 
Если да, то меняем статус payments.success_transaction на 1 и обновляем данные по юзеру
user_cashbalance.vaucher*/

DELIMITER //
DROP PROCEDURE IF EXISTS upd_payments//
CREATE PROCEDURE upd_payments(for_booking_id VARCHAR(255))
BEGIN

	IF (SELECT vaucher FROM no_transaction WHERE booking_id=for_booking_id) > 
    (SELECT miles FROM no_transaction WHERE id=@for_user_id)
	THEN UPDATE payments p SET success_transaction = 1 WHERE p.booking_id = for_booking_id;
	END IF;

END//

DELIMITER //
DROP PROCEDURE IF EXISTS upd_balance//
CREATE PROCEDURE upd_balance(for_booking_id VARCHAR(255))
BEGIN
 IF (SELECT vaucher FROM no_transaction WHERE booking_id=for_booking_id) > 
 (SELECT miles FROM no_transaction WHERE id=@for_user_id)
 THEN  UPDATE users_cashbalance
 SET vaucher = vaucher - (SELECT miles FROM no_transaction WHERE id = @for_user_id)
 WHERE user_id = @for_user_id;
 END IF;

END//

SELECT * FROM no_transaction; /*смотрим значения для @for_user_id и @for_booking_id*/
START TRANSACTION;
SET @for_user_id = '1';
CALL upd_payments('775a12');
CALL upd_balance('775a12');
COMMIT;

SELECT * FROM no_transaction; /*смотрим значения для @for_user_id и @for_booking_id*/
START TRANSACTION;
SET @for_user_id = '6';
CALL upd_payments('aad4b0');
CALL upd_balance('aad4b0');
COMMIT;

/*Триггер на открытие регистрации  в таблицу check_in, если дата ранее, чем 24 часа до отправления*/
DELIMITER //
DROP TRIGGER IF EXISTS check_departure_time_before_insert//
CREATE TRIGGER check_departure_time_before_insert
BEFORE INSERT
ON check_in FOR EACH ROW
BEGIN
IF NEW.departure_time > (CURRENT_DATE() + 1) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'регистрация на рейс не может начаться ранее, чем за 24 часа';
END IF;
END//

INSERT INTO check_in VALUES
(NULL, 'NO231', '2022-12-11 00:15:00', 'OPEN');





