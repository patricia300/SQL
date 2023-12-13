// Ne pas ex�cuter ce script.
// il faut copier coller chaque ligne pour tester
// Vous pourrez passer le script lorsqu'il sera compl�t� correctement !

// ins�rer les instances de responsables (avec les constructeurs qui vont bien): Verdier, Desmoulins, Jouanot
insert into LesEmployes values (tresponsable('Verdier'  , 'Noumea', tspecialites('fauve'),10));
insert into LesEmployes values (tresponsable('Desmoulins'  , 'Ushuaia',tspecialites('fauve','fosse','petits oiseaux'),2) );
insert into LesEmployes values (tresponsable('Jouanot'   , 'Papeete',tspecialites('fosse','aquarium','grand aquarium'),1) );

// ins�rer les instances de gardiens: Martins (spec: fauve), Labbe (spec:fauve), Lachaize (spec:'fauve','fosse','petits oiseaux'), Huard (spec:'fosse'), STMarcel (vide)
// pour l'instant ils doivent avoir une collection de cages gard�es vide
insert into LesEmployes values (tgardien('Martins','Calvi',tspecialites('fauve'),ens_cages()));
insert into LesEmployes values (tgardien('Labbe','',tspecialites('fauve'),ens_cages()));
insert into LesEmployes values (tgardien('Lachaize','',tspecialites('fauve','fosse','petits oiseaux'),ens_cages()));
insert into LesEmployes values (tgardien('Huard','',tspecialites('fosse'),ens_cages()));
insert into LesEmployes values (tgardien('STMarcel','',tspecialites(),ens_cages()));

// ins�rer les cages
insert into LesCages values (11 ,  'fauve'           , 10 );
insert into LesCages values (1     , 'fosse'         , 1 );
insert into LesCages values (2     , 'aquarium'      , 1 );
insert into LesCages values (3     , 'petits oiseaux'        , 2 );
insert into LesCages values (4     , 'grand aquarium'        , 1 );
insert into LesCages values (12     , 'fauve' , 10);


// Ont ajoute les cages � la liste de cages des gardiens
// POur cela on r�cup�re l'objet liste_cages qui est une table (nested table) dans laquelle on peut ajouter les r�f�rences aux cages gard�es
// Attention: on ins�re des r�f�rences sur des gardiens (et pas directement les objets)
// Demandez-vous pourquoi ce choix ? Et quel serait les implications d'un ajout direct d'objet par exemple ?
// Faire d�j� Martins avec les cages 11 et 12
// ensuite Labbe avec aussi la 11 et 12
// puis Lachaize avec la 1, 11 et 12
// puis Huard pour la 1
// et enfin Lachaize � nouveau pour la cage 3 (ce qui prouve qu'on peut ajouter des �l�ments � la collection ! 
insert into Table(select treat(value(g) as tgardien).liste_cages from lesemployes g where nomE='Martins' ) value (SELECT REF(c) FROM lesCages c WHERE c.nocage in (11,12));
insert into Table(select treat(value(g) as tgardien).liste_cages from lesemployes g where nomE='Labbe' ) value (SELECT REF(c) FROM lesCages c WHERE c.nocage in (11,12));
insert into Table(select treat(value(g) as tgardien).liste_cages from lesemployes g where nomE='Lachaize' ) value (SELECT REF(c) FROM lesCages c WHERE c.nocage in (1,11,12));
insert into Table(select treat(value(g) as tgardien).liste_cages from lesemployes g where nomE='Huard' ) value (SELECT REF(c) FROM lesCages c WHERE c.nocage in (1));
insert into Table(select treat(value(g) as tgardien).liste_cages from lesemployes g where nomE='Lachaize' ) value (SELECT REF(c) FROM lesCages c WHERE c.nocage in (3));

/ Insertion des instances d'animaux
// ATTENTION: l'avant dernier attribut est une r�f�rence sur une cage et pas un num�ro de cage (sinon revoir le sch�ma)=> requ�te SQL
// Lorsqu'aucune maladie n'apparait, il s'agit d'un collection vide de maladies.
insert into LesAnimaux values ('Charly', 'male',   'lion', 'fauve',  'Kenya',  2018, (select REF(c) from lesCages c where c.nocage=12),ens_maladies(tmaladie(to_date('11092023','DDMMYYYY'),'rage de dents'), tmaladie(to_date('05122022','DDMMYYYY'),'grippe')));
insert into LesAnimaux values ('Arthur', 'male',   'ours', 'fosse',  'France', 2020, (select REF(c) from lesCages c where c.nocage=1),ens_maladies());
insert into LesAnimaux values ('Chloe',  'femelle', 'pie', 'petits oiseaux' ,  'France', 2019, (select REF(c) from lesCages c where c.nocage=3),ens_maladies(tmaladie(TO_DATE('20102022','DDMMYYYY'),'grippe')));
insert into LesAnimaux values ('Milou',  'male' ,  'leopard', 'fauve', 'France', 2016, (select REF(c) from lesCages c where c.nocage=11),ens_maladies(tmaladie(to_date('10012021','DDMMYYYY'),'angine')));
insert into LesAnimaux values ('Tintin', 'male' , 'leopard', 'fauve', 'France', 2017, (select REF(c) from lesCages c where c.nocage=11),ens_maladies());
insert into LesAnimaux values ('Charlotte', 'femelle', 'lion',  'fauve',  'Kenya',  2021, (select REF(c) from lesCages c where c.nocage=12),ens_maladies());

