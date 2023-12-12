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
create type tcage as object (
	noCage number(3),
	fonction varchar2(20),
	noAllee number(3)
);
/

-- Definir une collection libre ens_cages de references sur tcage
create type ens_cages as table of tcage;
/

-- Definir une collection statique (Varray) tspecialites de chaines de caracteres (fonction de la cage)
Create type tspecialites as Varray(10) OF varchar(30) ;
/

-- Definir un type temploye
create type temploye as object(
	nomE varchar2(20),
	adresse varchar2(20),
	fonction_cage tspecialites
)
not final
;
/


-- Definir les sous-types de temploye: tgardien et trespsonsable
create type tgardien under temploye (
	liste_cages ens_cages);
/

create type tresponsable under temploye (
	noAllee number(3) );
/

-- Creation de la table lesemployes (avec nomE comme cl� primaire )
--  sans oublier la nested table
create table lesemployes of temploye ( CONSTRAINT lesemployes_c1 PRIMARY KEY (nomE) );
nested table liste_cages store as cages;

-- Creation de la table lescages (nocage est la cl� primaire)
create table lescages of tcage
( CONSTRAINT lescages_c2 PRIMARY KEY (noCage) );


create type tmaladie as object(
	datem date,
	nomm varchar2(20));
/

-- Definir une collection libre ens_maladies de tmaladie
create type ens_maladies as table of tmaladie;
/

-- Compl�ter la d�finition de la table animaux
create table LesAnimaux (
	nomA varchar2(20) primary key,
	sexe varchar2(13),
	type_an varchar2(15),
	fonction_cage varchar2(20),
	pays varchar2(20),
	anNais number(4),
	lacage REF tcage ,
	liste_maladies ens_maladies )
nested table liste_maladies store as maladies;
