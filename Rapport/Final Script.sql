IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'TEC')
CREATE DATABASE TEC;

else
Use TEC
go

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'post_nr_by')
begin

create table post_nr_by
(
post_nr int NOT NULL PRIMARY KEY,
by_navn varchar(255)
)

insert into post_nr_by values
(2650, 'temp'),
(2300, 'temp'),
(2500, 'temp'),
(2610, 'temp'),
(3650, 'temp'),
(2830, 'temp'),
(2770, 'temp'),
(1824, 'temp'),
(2740, 'temp'),
(2750, 'temp');

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'postnr$')
begin
update post_nr_by
set by_navn = postnr$.by_navn from postnr$
where post_nr_by.post_nr = postnr$.post_nr;
end
end

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'klasse')
begin

create table klasse
(
klasse_id int NOT NULL PRIMARY KEY,
klasse varchar(255)
)

insert into klasse values
(1, '1A'),
(2, '9B'),
(3, '4D');

end

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'elev')
begin

create table elev
(
elev_id int NOT NULL PRIMARY KEY,
fornavn varchar(255),
efternavn varchar(255),
adresse varchar(255),
klasse_id int foreign key references klasse(klasse_id),
post_nr int foreign key references post_nr_by(post_nr)
)

insert into elev values
(1, 'Bo', 'Andersen', 'Gammel Byvej 12', '1', 2650),
(2, 'Frederikke', 'Hansen', 'Amager Boulevard 5', '2', 2300),
(3, 'Jens', 'Mikkelsen', 'Lily Brogbergs Vej 17', '3', 2500),
(4, 'Philip', 'Mortensen', 'Brunevang 90', '1', 2610),
(5, 'Kasper', 'Frederiksen', 'Bryggetorvet 32', '2', 3650),
(6, 'Milla', 'Jørgensen', 'Virum Torv 25', '3', 2830),
(7, 'fie', 'Kudsen', 'Allen 85', '1', 2770),
(8, 'Henrik', 'Madsen', 'Lily Brogbergs Vej 53', '2', 2500);

end

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'laerer')
begin

create table laerer
(
laerer_id int NOT NULL PRIMARY KEY,
fornavn varchar(255),
efternavn varchar(255),
adresse varchar(255),
klasse_id int foreign key references klasse(klasse_id),
post_nr int foreign key references post_nr_by(post_nr)
)

insert into laerer values
(1, 'Tom', 'it', 'Sankt Thomas alle 3', '1', 1824),
(2, 'Lars', 'Henriksen', 'Nissedalen 76', '2', 2740),
(3, 'Mia', 'Hansen', 'Østervej 16', '3', 2750);

end



select elev.fornavn, elev.efternavn, klasse.klasse 
from elev
join klasse on elev.klasse_id = klasse.klasse_id;


select laerer.fornavn, laerer.efternavn, post_nr_by.by_navn 
from laerer
join post_nr_by on laerer.post_nr = post_nr_by.post_nr;


select elev.fornavn, elev.efternavn, laerer.fornavn, laerer.efternavn
from elev
join laerer on elev.efternavn = laerer.efternavn;


