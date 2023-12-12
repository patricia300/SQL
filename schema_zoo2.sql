drop table lesanimaux FORCE;
drop table lesemployes FORCE;
drop table lescages FORCE;
drop type ens_maladies FORCE;
drop type ens_gardiens FORCE;
drop type tresponsable;
drop type tgardien;
drop type temploye;
drop type tcage;
drop type tmaladie;
drop type tspecialites;


-- Definir le type tcage
create type tcage as ________ (
	noCage number(3),
	fonction varchar2(20),
	noAllee number(3)
);
/

-- Definir une collection libre ens_cages de references sur tcage
create type _________ as _____ of __________;
/

-- Definir une collection statique (Varray) tspecialites de chaines de caracteres (fonction de la cage)
Create type tspecialites as _______________ OF _________________ ;
/

-- Definir un type temploye
create type temploye as object(
	nomE varchar2(20),
	adresse varchar2(20),
	fonction_cage _____
)
_____;
/


-- Definir les sous-types de temploye: tgardien et trespsonsable
create type tgardien under temploye (
	liste_cages _____________ );
/

create type tresponsable under temploye (
	noAllee _________________ );
/

-- Creation de la table lesemployes (avec nomE comme clé primaire )
--  sans oublier la nested table
create table lesemployes of ________________ ( _______________ );
nested table ________________ store as cages;

-- Creation de la table lescages (nocage est la clé primaire)
create table ________ of _________
( ________________ );


create type tmaladie as object(
	datem date,
	nomm varchar2(20));
/

-- Definir une collection libre ens_maladies de tmaladie
create type ens_maladies as ______________ of ____________ ;
/

-- Compléter la définition de la table animaux
create table LesAnimaux (
	nomA varchar2(20) primary key,
	sexe varchar2(13),
	type_an varchar2(15),
	fonction_cage varchar2(20),
	pays varchar2(20),
	anNais number(4),
	lacage REF ________________ ,
	liste_maladies ______________ )
nested table ______________________ store as maladies;
