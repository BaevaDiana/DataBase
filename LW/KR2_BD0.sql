--КР2.Баева Диана.Вариант 1.
--Задача 1.

--создание таблиц со всеми ограничениями
CREATE TABLE Seller
( id_seller NUMBER(5) Primary KEY,
fullname VARCHAR(100),
address VARCHAR(100),
phone VARCHAR(15),
website VARCHAR(25)
);
alter table Seller MODIFY (fullname not null, address not null);
ALTER TABLE Seller add CONSTRAINT phone CHECK (SUBSTR(phone,0,1)='+' and LENGTH(phone)>12 and LENGTH(phone)<16);

CREATE TABLE Producer
( id_producer NUMBER(5) Primary KEY,
fullname VARCHAR(100),
address VARCHAR(100),
website VARCHAR(25)
);
ALTER TABLE Producer MODIFY (fullname not null, address not null);


CREATE TABLE Article
( id_art NUMBER(5) Primary KEY,
name VARCHAR(100),
type VARCHAR(100),
hie_date DATE
);
ALTER TABLE Article MODIFY (name not null, type not null);
ALTER TABLE Article add CONSTRAINT type CHECK (SUBSTR(type,4,2)='кг' or SUBSTR(type,4,2)='шт');

CREATE TABLE price_list
( id_price_list NUMBER(5) Primary KEY,
id_seller NUMBER(5) REFERENCES Seller(id_seller),
id_producer NUMBER(5) REFERENCES Producer(id_producer),
id_art NUMBER(5) REFERENCES Article(id_art),
price FLOAT(2)
);

--добавление записей в таблицу
INSERT INTO Producer VALUES(1,'Гамаёнова Елизавета Валерьевна','Krasnodar','tg:elizaveta2002');
INSERT INTO Producer VALUES(2,'Есина Дарья Максимовна','Krasnodar','tg:darya_esina');
INSERT INTO Producer VALUES(3,'Репетило Анна Николаевна','Ladozhskaya','tg:anna_rep');

INSERT INTO Article VALUES(11,'Молоко','10 шт','23.11.2022');
INSERT INTO Article VALUES(22,'Хлеб','50 шт','15.10.2022');
INSERT INTO Article VALUES(33,'Яблоки','10 кг','23.11.2022');

INSERT INTO Seller VALUES(5,'Баева Диана Николаевна','Краснодар','+7-------------','tg:pluxurypinkphloydrock');
INSERT INTO Seller VALUES(10,'Баева Татьяна Викторовна','Ладожская','+7-------------','tg:baeva_tat');
INSERT INTO Seller VALUES(15,'Баев Андрей Николаевич','Усть-Лабинск','+7-------------','tg:overseer');

INSERT INTO price_list VALUES(01,5,1,11,70.00);
INSERT INTO price_list VALUES(02,10,2,22,27.05);
INSERT INTO price_list VALUES(03,15,3,33,69.18);