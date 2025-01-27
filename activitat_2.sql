/*NIVELL 1*/
/*EXERCICI 1*/
    -- Crear taula credit card
CREATE TABLE IF NOT EXISTS credit_card (
		id VARCHAR(255) PRIMARY KEY,
        iban VARCHAR(255) NULL,
        pan VARCHAR(255) NULL,
        pin INT, 
        cvv INT,
        expiring_date VARCHAR(255) NULL
        );
 select * from credit_card;

/*LOAD DATA 
INFILE 'C:/datos_introducir_credit.sql'
INTO TABLE credit_card
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 ROWS;

SHOW VARIABLES LIKE "secure_file_priv";*/

/*EXERCICI 2*/
SELECT * from credit_card
Where id = "CcU-2938";

UPDATE credit_card
SET iban = "R323456312213576817699999"
WHERE id = "CcU-2938";

SELECT iban from credit_card
WHERE id = "CcU-2938";

/*EXERCICI 3*/ 
INSERT INTO company(id) VALUES('b-9999');

INSERT INTO transaction(id, credit_card_id, company_id, user_id, lat, longitude, amount, declined)
VALUES ('108B1D1D-5B23-A76C-55EF-C568E49A99DD', 'CcU-9999', 'b-9999', 9999, 829.999, -117.999, 111.11, 0);

SELECT * from transaction
Where id = '108B1D1D-5B23-A76C-55EF-C568E49A99DD';

/*EXERCiCI 4*/
ALTER TABLE credit_card DROP pan;

SELECT * FROM credit_card;

/*NIVELL 2*/
/*EXERCICI 1*/
DELETE FROM transaction 
WHERE id = '02C6201E-D90A-1859-B4EE-88D2986D3B02';
SELECT * from transaction
Where id = '02C6201E-D90A-1859-B4EE-88D2986D3B02';

/*EXERCICI 2*/
CREATE VIEW VistaMarketing AS 
SELECT c.company_name, c.phone, c.country, avg(t.amount)
FROM company AS c
LEFT JOIN transaction as t
ON c.id = t.company_id
GROUP BY c.company_name, c.phone, c.country
ORDER BY avg(t.amount) DESC;

SELECT * from transactions.vistamarketing;

/*quitar decline, .2 de round*/

/*EXERCICI 3*/
SELECT * from transactions.vistamarketing
WHERE country = 'Germany';

/*NIVELL 3*/
/*EXERCICI 1*/
/*ALTER TABLE credit_card
ADD FOREIGN KEY (id) REFERENCES transaction(credit_card_id);*/
SHOW CREATE TABLE credit_card;
SHOW CREATE TABLE user;
SHOW CREATE TABLE transaction;

ALTER TABLE credit_card 
DROP foreign key credit_card_ibfk_1;
ALTER TABLE user DROP foreign key user_ibfk_1;
ALTER TABLE transaction DROP foreign key transaction_ibfk_1;

AlTER TABLE transaction
ADD FOREIGN KEY (credit_card_id) REFERENCES credit_card(id);
AlTER TABLE transaction
ADD FOREIGN KEY (user_id) REFERENCES user(id);

ALTER TABLE credit_card
ADD column fecha_actual DATE;

ALTER TABLE company
DROP website;

ALTER TABLE credit_card MODIFY id varchar(20);
ALTER TABLE credit_card MODIFY iban varchar(50);
ALTER TABLE credit_card MODIFY pin varchar(4);
ALTER TABLE credit_card MODIFY expiring_date varchar(20);



select * from user;

/*EXERCICI 2*/
CREATE VIEW InformeTecnico as
SELECT t.id, u.name, u.surname, c.iban, co.company_name
FROM transaction as t
LEFT JOIN user as u
ON t.user_id = u.id
LEFT JOIN credit_card as c 
ON t.credit_card_id = c.id
LEFT JOIN company as co
ON t.company_id = co.id;

SELECT * FROM transactions.informetecnico
ORDER BY id DESC;