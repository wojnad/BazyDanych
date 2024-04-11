-- utworzenie bazy danych FIRMA
create database firma;

-- utworzenie schematu rozliczenia
create SCHEMA rozliczenia;


-- utworzenie tabeli pracownicy
create table rozliczenia.pracownicy(
	id_pracownika SERIAL primary key, 
	imie varchar(50), 
	nazwisko varchar(50), 
	adres varchar(100), 
	telefon varchar(15)
	);

-- utworzenie tabeli godziny
create table rozliczenia.godziny(
	id_godziny SERIAL primary key,
	data DATE,
	liczba_godzin INT,
	id_pracownika INT,
	foreign key (id_pracownika) references rozliczenia.pracownicy(id_pracownika)
	);
	
-- utworzenie tabeli premie
CREATE TABLE rozliczenia.premie (
    id_premii SERIAL PRIMARY KEY,
    rodzaj VARCHAR(100),
    kwota NUMERIC(10, 2)
);

-- utworzenie tabeli pensje
CREATE TABLE rozliczenia.pensje (
    id_pensji SERIAL PRIMARY KEY,
    stanowisko VARCHAR(100),
    kwota NUMERIC(10, 2),
    id_premii INT,
    FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii)
);

-- modyfikacje tabel
alter table rozliczenia.pracownicy
alter column id_pracownika set not null;
alter table rozliczenia.pracownicy
alter column imie set not null;
alter table rozliczenia.pracownicy
alter column nazwisko set not null;

alter table rozliczenia.godziny
alter column id_godziny set not null;
alter table rozliczenia.godziny
alter column data set not null;

alter table rozliczenia.premie
alter column id_premii set not null;
alter table rozliczenia.premie
alter column kwota set not null;

alter table rozliczenia.pensje
alter column id_pensji set not null;
alter table rozliczenia.pensje
alter column kwota set not null;

-- dodane klucza z pracownikami do pensji
ALTER TABLE rozliczenia.pensje
ADD COLUMN id_pracownika INT;

ALTER TABLE rozliczenia.pensje
ADD CONSTRAINT id_pracownika FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);

-- dodanie rekordów
INSERT INTO rozliczenia.pracownicy (imie, nazwisko, adres, telefon) VALUES
    ('Jan', 'Kowalski', 'ul. Kwiatowa 1', '123-456-789'),
    ('Anna', 'Nowak', 'ul. Słoneczna 5', '987-654-321'),
    ('Marek', 'Wiśniewski', 'ul. Leśna 10', '555-123-789'),
    ('Karolina', 'Dąbrowska', 'ul. Polna 3', '111-222-333'),
    ('Piotr', 'Lis', 'ul. Żurawia 7', '444-555-666'),
    ('Monika', 'Kaczmarek', 'ul. Lipowa 12', '777-888-999'),
    ('Adam', 'Zieliński', 'ul. Parkowa 2', '111-222-333'),
    ('Michał', 'Wożnicki', 'pl. Zmartwychwstania 1', '444-555-666'),
    ('Marcin', 'Kowalczyk', 'ul. Kwiatowa 8', '777-888-999'),
    ('Magdalena', 'Szymańska', 'ul. Leśna 6', '111-222-333');

INSERT INTO rozliczenia.premie (rodzaj, kwota) VALUES
    ('Premia roczna', 1000),
    ('Premia świąteczna', 500),
    ('Premia za dobre wyniki', 800),
    ('Premia za staż pracy', 1200),
    ('Premia za efektywność', 900),
    ('Premia motywacyjna', 600),
    ('Premia za nadgodziny', 1100),
    ('Premia jubileuszowa', 1500),
    ('Premia za innowacyjność', 700),
    ('Premia za awans', 1300);

INSERT INTO rozliczenia.godziny (data, liczba_godzin, id_pracownika) VALUES
    ('2024-04-01', 8, 1),
    ('2024-04-02', 7, 2),
    ('2024-04-03', 8, 3),
    ('2024-04-04', 9, 4),
    ('2024-04-05', 6, 5),
    ('2024-04-06', 8, 6),
    ('2024-04-07', 7, 7),
    ('2024-04-08', 8, 8),
    ('2024-04-09', 9, 9),
    ('2024-04-10', 6, 10);

INSERT INTO rozliczenia.pensje (stanowisko, kwota, id_premii) VALUES
    ('Kierownik', 5000, 1),
    ('Specjalista', 3500, 3),
    ('Pracownik fizyczny', 2500, 2),
    ('Analityk', 4000, 4),
    ('Doradca klienta', 3000, 5),
    ('Administrator', 2800, 6),
    ('Księgowy', 3200, 7),
    ('Inżynier', 4200, 8),
    ('Technik', 2600, 9),
    ('Handlowiec', 3800, 10);
    
-- wybór naziwska i adresu z tabeli pracownicy
select nazwisko, adres from rozliczenia.pracownicy;

-- wyświetlenie dnia tygodnia i miesiąca z tabeli godziny
select 
date_part('dow', data) as dzien_tygodnia,
date_part('month', data) as miesiac
from
rozliczenia.godziny;

-- dodanie kwoty brutto i netto
alter table rozliczenia.pensje
rename column kwota to kwota_brutto

alter table rozliczenia.pensje
add column kwota_netto numeric(10,2);

update rozliczenia.pensje
set kwota_netto = kwota_brutto * 0.7; -- podatek i opłaty ok. 30%

select * from rozliczenia.pensje;

