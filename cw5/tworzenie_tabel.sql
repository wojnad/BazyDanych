create table ksiegowosc.pracownicy(
	id_pracownika int primary key,
	imie varchar(50) not null,
	nazwisko varchar(50) not null,
	adres varchar(120),
	telefon varchar(15)
	);

create table ksiegowosc.godziny(
	id_godziny int primary key,
	data_ date not null,
	liczba_godzin int not null,
	id_pracownika int
	foreign key (id_pracownika) references ksiegowosc.pracownicy(id_pracownika)
	on delete cascade on update cascade
	);

create table ksiegowosc.pensja(
	id_pensji int primary key,
	stanowisko varchar(80) not null,
	kwota numeric(10, 2) not null
	);

create table ksiegowosc.premia(
	id_premii int primary key,
	rodzaj varchar(50) not null,
	kwota numeric(10,2) default 0.0
	);

create table ksiegowosc.wynagrodzenie(
	id_wynagrodzenia int primary key,
	data_ date not null,
	id_pracownika int foreign key (id_pracownika)
	references ksiegowosc.pracownicy(id_pracownika)
	on delete cascade on update cascade,
	id_godziny int foreign key (id_godziny)
	references ksiegowosc.godziny(id_godziny),
	id_pensji int foreign key (id_pensji)
	references ksiegowosc.pensja(id_pensji)
	on delete cascade on update cascade,
	id_premii int foreign key (id_premii)
	references ksiegowosc.premia(id_premii)
	);