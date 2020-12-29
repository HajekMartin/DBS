INSERT INTO Pacient(Name, Surname, PersonalIdentifier)
VALUES
    ('Franti�ek', 'Nov�k', '001017/3834'),
    ('Pepa', 'Novotn�', '001017/3845'),
    ('Marek', 'Nov�', '001017/3856'),
    ('Karel', 'Modr�', '001017/3867'),
	('Martin', '�erven�', '001017/3878'),
	('Bruno', 'Zelen�', '001017/3889'),
	('Pavel', 'Fialov�', '001017/4934'),
	('Jirka', 'B�ov�', '001017/6034'),
	('Jaroslav', '�ern�', '001017/7134'),
	('David', 'B�l�', '001017/8234')

INSERT INTO [Location](Name, City, Street, OpenedFrom, OpenedTo)
VALUES 
	('KNL', 'Liberec', 'N�dra�n� 5', '7:00', '13:00'),
	('Soukrom� klinika','Liberec', 'Husova 5', '8:00', '13:00'),
	('Ve�ejn� klinika','Liberec', 'Zeyerova 5', '9:00', '15:00'),
	('nemjbc','Jablonec nad Nisou', 'N�dra�n� 69', '5:00', '10:00'),
	('Soukrom� klinika JBC','Jablonec nad Nisou', 'Nov� 7', '7:00', '13:00'),
	('Pobo�ka KNL - JBC','Jablonec nad Nisou', 'Libereck� 7', '11:00', '13:00'),
	('Pobo�ka KNL - Turnov','Turnov', 'N�dra�n� 7', '4:00', '8:00'),
	('Prvn� turnovsk� nemocnice','Turnov', 'Libereck� 3', '14:00', '20:00'),
	('nemtur','Turnov', 'Star� 34', '7:00', '13:00'),
	('nemcl','�esk� L�pa', 'N�dra�n� 16', '7:00', '13:00')

INSERT INTO Doctor(Name, Surname, Title, LocationId)
VALUES 
	-- Ten select nen� sice 100%, proto�e kdy� budou m�t 2 lokace stejn� jm�na tak to vezme prvn�, ale jedn� se jenom o testovac� data.
	('Marek', 'Honc', 'Doc', (Select top 1 Id from [Location] where Name Like 'KNL')),
	('Bruno', 'Pfohl', 'Mgr', (Select top 1 Id from [Location] where Name Like 'KNL')),
	('Martin', 'H�jek', 'Mgr', (Select top 1 Id from [Location] where Name Like 'nemtur')),
	('Nat�lie', 'Novotn�', 'Mgr', (Select Id from [Location] where Name Like 'Soukrom� klinika')),
	('Karol�na', 'Hust�', 'Mgr', (Select top 1 Id from [Location] where Name Like 'Ve�ejn� klinika')),
	('Lucie', 'Drsn�', 'Doc', (Select top 1 Id from [Location] where Name Like 'nemjbc')),
	('Frajer', 'Sprajer', 'Mgr', (Select top 1 Id from [Location] where Name Like 'Soukrom� klinika JBC')),
	('Eva', 'Evi�ka', 'Mgr', (Select top 1 Id from [Location] where Name Like 'Pobo�ka KNL - JBC')),
	('Pepa', 'Doktor', 'Mgr', (Select top 1 Id from [Location] where Name Like 'nemcl')),
	('Ahmed', 'Arthur', 'Mgr', (Select top 1 Id from [Location] where Name Like 'KNL'))

INSERT INTO Test(Name, Description, Price, Length)
VALUES 
	-- Nejsem doktor - neru��m za p�esnost �daj� ale pro testov�n� posta�uj�c�.
	('PCR', 'Covid - test', 2256, 10),
	('Antigen', 'Covid - test - antigenn�', 0, 10),
	('Alzheimer', null, 1500, 30),
	('Krevn� test', 'Odb�r krve', 250, 5),
	('T�hotensk� test', null, 500, 10),
	('HIV', null, 1500, 45),
	('Wegener', null, 2000, 60),
	('Rakovina', 'Vy�et�en� podle podezd�en�', 5000, 120),
	('�lu�ov� kameny', null, 900, 15),
	('Roztrou�en� skler�za', null, 15000, 10)

INSERT INTO DoctorToTest(TestId, DoctorId)
VALUES
-- Ten select nen� sice 100%, proto�e kdy� podm�nce vyhov� v�ce z�znam� vezme se prvn�, ale jedn� se jenom o testovac� data.
	((Select top 1 Id from Test where Name Like 'PCR'), (Select top 1 Id from Doctor where SurName Like 'Honc')),
	((Select top 1 Id from Test where Name Like 'Antigen'), (Select top 1 Id from Doctor where SurName Like 'Honc')),
	((Select top 1 Id from Test where Name Like 'Alzheimer'), (Select top 1 Id from Doctor where SurName Like 'Pfohl')),
	((Select top 1 Id from Test where Name Like 'Krevn� test'), (Select top 1 Id from Doctor where SurName Like 'Pfohl')),
	((Select top 1 Id from Test where Name Like 'PCR'), (Select top 1 Id from Doctor where SurName Like 'H�jek')),
	((Select top 1 Id from Test where Name Like 'Alzheimer'), (Select top 1 Id from Doctor where SurName Like 'H�jek')),
	((Select top 1 Id from Test where Name Like 'Roztrou�en� skler�za'), (Select top 1 Id from Doctor where SurName Like 'Novotn�')),
	((Select top 1 Id from Test where Name Like 'HIV'), (Select top 1 Id from Doctor where SurName Like 'Hust�')),
	((Select top 1 Id from Test where Name Like 'Wegener'), (Select top 1 Id from Doctor where SurName Like 'Drsn�')),
	((Select top 1 Id from Test where Name Like 'Rakovina'), (Select top 1 Id from Doctor where SurName Like 'Sprajer'))

Insert INTO Booking(DoctorToTestId, PacientId, StartsAt, Paid, IsPositive)
VALUES
	((Select top 1 Id from DoctorToTest where TestId = (Select top 1 Id from Test where Name Like 'PCR') and DoctorId = (Select top 1 Id from Doctor where SurName Like 'Honc')),
		(Select top 1 Id from Pacient where PersonalIdentifier like '001017/3834'), '2020-12-29 11:40:00', 0, 0),
	((Select top 1 Id from DoctorToTest where TestId = (Select top 1 Id from Test where Name Like 'Antigen') and DoctorId = (Select top 1 Id from Doctor where SurName Like 'Honc')),
		(Select top 1 Id from Pacient where PersonalIdentifier like '001017/3834'), '2020-12-29 11:50:00', 1, 0),
	((Select top 1 Id from DoctorToTest where TestId = (Select top 1 Id from Test where Name Like 'Alzheimer') and DoctorId = (Select top 1 Id from Doctor where SurName Like 'Pfohl')),
		(Select top 1 Id from Pacient where PersonalIdentifier like '001017/3845'), '2020-12-29 10:30:00', 1, 0),
	((Select top 1 Id from DoctorToTest where TestId = (Select top 1 Id from Test where Name Like 'Krevn� test') and DoctorId = (Select top 1 Id from Doctor where SurName Like 'Pfohl')),
		(Select top 1 Id from Pacient where PersonalIdentifier like '001017/3856'), '2020-12-29 11:00:00', 0, 1),
	((Select top 1 Id from DoctorToTest where TestId = (Select top 1 Id from Test where Name Like 'PCR') and DoctorId = (Select top 1 Id from Doctor where SurName Like 'H�jek')),
		(Select top 1 Id from Pacient where PersonalIdentifier like '001017/3867'), '2020-12-29 9:40:00', 0, 1),
	((Select top 1 Id from DoctorToTest where TestId = (Select top 1 Id from Test where Name Like 'Alzheimer') and DoctorId = (Select top 1 Id from Doctor where SurName Like 'H�jek')),
		(Select top 1 Id from Pacient where PersonalIdentifier like '001017/3878'), '2020-12-29 9:50:00', 1, 1),
	((Select top 1 Id from DoctorToTest where TestId = (Select top 1 Id from Test where Name Like 'PCR') and DoctorId = (Select top 1 Id from Doctor where SurName Like 'Honc')),
		(Select top 1 Id from Pacient where PersonalIdentifier like '001017/3889'), '2020-12-30 8:30:00', 0, 0),
	((Select top 1 Id from DoctorToTest where TestId = (Select top 1 Id from Test where Name Like 'PCR') and DoctorId = (Select top 1 Id from Doctor where SurName Like 'Honc')),
		(Select top 1 Id from Pacient where PersonalIdentifier like '001017/4934'), '2020-12-29 8:40:00', 1, 1),
	((Select top 1 Id from DoctorToTest where TestId = (Select top 1 Id from Test where Name Like 'Roztrou�en� skler�za') and DoctorId = (Select top 1 Id from Doctor where SurName Like 'Novotn�')),
		(Select top 1 Id from Pacient where PersonalIdentifier like '001017/6034'), '2020-12-29 8:00:00', 0, 0),
	((Select top 1 Id from DoctorToTest where TestId = (Select top 1 Id from Test where Name Like 'Rakovina') and DoctorId = (Select top 1 Id from Doctor where SurName Like 'Sprajer')),
		(Select top 1 Id from Pacient where PersonalIdentifier like '001017/7134'), '2020-12-29 7:40:00', 0, 1)