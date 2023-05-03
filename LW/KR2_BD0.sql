--��2.����� �����.������� 1.
--������ 1.

--�������� ������ �� ����� �������������
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
ALTER TABLE Article add CONSTRAINT type CHECK (SUBSTR(type,4,2)='��' or SUBSTR(type,4,2)='��');

CREATE TABLE price_list
( id_price_list NUMBER(5) Primary KEY,
id_seller NUMBER(5) REFERENCES Seller(id_seller),
id_producer NUMBER(5) REFERENCES Producer(id_producer),
id_art NUMBER(5) REFERENCES Article(id_art),
price FLOAT(2)
);

--���������� ������� � �������
INSERT INTO Producer VALUES(1,'�������� ��������� ����������','Krasnodar','tg:elizaveta2002');
INSERT INTO Producer VALUES(2,'����� ����� ����������','Krasnodar','tg:darya_esina');
INSERT INTO Producer VALUES(3,'�������� ���� ����������','Ladozhskaya','tg:anna_rep');

INSERT INTO Article VALUES(11,'������','10 ��','23.11.2022');
INSERT INTO Article VALUES(22,'����','50 ��','15.10.2022');
INSERT INTO Article VALUES(33,'������','10 ��','23.11.2022');

INSERT INTO Seller VALUES(5,'����� ����� ����������','���������','+7-------------','tg:pluxurypinkphloydrock');
INSERT INTO Seller VALUES(10,'����� ������� ����������','���������','+7-------------','tg:baeva_tat');
INSERT INTO Seller VALUES(15,'���� ������ ����������','����-�������','+7-------------','tg:overseer');

INSERT INTO price_list VALUES(01,5,1,11,70.00);
INSERT INTO price_list VALUES(02,10,2,22,27.05);
INSERT INTO price_list VALUES(03,15,3,33,69.18);