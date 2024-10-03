/***************************************/
/*           DM2 - M1 ACTUARIAT        */
/*       Marie MEYER - Linh VU        */
/***************************************/


/*-------------------------------------*/
/*            Exercice 1 			   */
/*-------------------------------------*/

	/* 1. Les resultats du premier tour des elections */ 

libname votlib '/home/u63636454/DM2';
run;

data votlib.resultats;
   set votlib.resultats; 
run;

proc import datafile='/home/u63636454/DM2/resultats.xlsx' 
            out=votlib.resultats 
            dbms=xlsx 
            replace;
    getnames=yes;
    delimiter=';';
run;

/* Question 3 : ACP avec tous les inscrits */
data resultats (drop ="%Voix/Exp12"n "Voix12"n "Voix11"n "Voix10"n "Voix9"n "Voix8"n "Voix7"n "Voix6"n "Voix5"n "Voix4"n "%Voix/Exp11"n "%Voix/Exp10"n "%Voix/Exp9"n "%Voix/Exp8"n "%Voix/Exp7"n "%Voix/Exp6"n "%Voix/Exp5"n "%Voix/Exp4"n "%Voix/Exp3"n "Voix3"n "%Voix/Exp2"n "Voix2"n "% Voix/Exp"n "Voix"n "% Exp/Vot"n "% Exp/Ins"n "Exprimés"n "% Nuls/Vot"n "% Nuls/Ins"n "Nuls"n "% Blancs/Vot"n "% Blancs/Ins"n "Blancs"n "% Vot/Ins"n "Votants"n "Inscrits"n "Code du b.vote"n "Code de la commune"n "Libellé du département"n "Code du département"n "Code de la circonscription"n Abstentions "Libellé de la circonscription"n N°Panneau Nom Sexe Prénom AC AD AE AF AJ AK AL AM AQ AR AS AT AX AY AZ BA BE BF BG BH BL BM BN BO BS BT BU BV BZ CA CB CC CG CH CI CJ CN CO CP CQ CU CV CW CX  );
	set votlib.resultats (rename=( "% Abs/Ins"n=Abstention"% Voix/Ins"n=Arthaud AG=Voix2 AH=Roussel AI="%Voix/Exp2"n AN=Voix3 AO=Macron AP="%Voix/Exp3"n AU=Voix4 AV=Lassalle AW="%Voix/Exp4"n BB=Voix5 BC=LePen BD="%Voix/Exp5"n BI=Voix6 BJ=Zemmour BK="%Voix/Exp6"n BP=Voix7 BQ=Melenchon BR="%Voix/Exp7"n BW=Voix8 BX=Hidalgo BY="%Voix/Exp8"n CD=Voix9 CE=Jadot CF="%Voix/Exp9"n CK=Voix10 CL=Pécresse CM="%Voix/Exp10"n CR=Voix11 CS=Poutou CT="%Voix/Exp11"n CY=Voix12 CZ="Dupont-Aignant"n DA="%Voix/Exp12"n));
	/*row_id = _N_;*/
	where input(Inscrits, best.) > 1000; 
run;

	/* ACP */
proc princomp data=resultats out=votlib.sorties n=5 PLOTS(ncomp=4) =(SCORE pattern(circle vector));
id "Libellé de la commune"n;
var Abstention Arthaud Roussel Macron Lassalle LePen Zemmour Melenchon Hidalgo Jadot Pécresse Poutou "Dupont-Aignant"n ;
run;


proc tree data=resultats out=dendrogramme method=average;
var Abstention Arthaud Roussel Macron Lassalle LePen Zemmour Melenchon Hidalgo Jadot Pécresse Poutou "Dupont-Aignant"n;
run;

proc treeplot data=dendogramme;
run;

proc cluster data=resultats OUTTREE=tree method=average;
id "Libellé de la commune"n;
var Abstention Arthaud Roussel Macron Lassalle LePen Zemmour Melenchon Hidalgo Jadot Pécresse Poutou "Dupont-Aignant"n ;
run;

/* Utilisation de la procédure cluster pour la classification avec dendrogramme */
proc cluster data=resultats method=average outtree=outtree;
   id "Libellé de la commune"n;
   var Abstention Arthaud Roussel Macron Lassalle LePen Zemmour Melenchon Hidalgo Jadot Pécresse Poutou "Dupont-Aignant"n ;
run;



/* Affichage du dendrogramme */
proc tree data=tree horizontal;
run;

 PROC TREE DATA=work.dendo HORIZONTAL ;
 ID label ;
 RUN ;



/* test */
data votlib.sorties_with_id;
   set resultats;
   /* Ajouter un identifiant unique */
   row_id = _N_;
run;

/* Utilisation de la procédure cluster pour la classification avec dendrogramme */
proc cluster data=votlib.sorties_with_id method=average outtree=outtree;
   id row_id;
   var Abstention Arthaud Roussel Macron Lassalle LePen Zemmour Melenchon Hidalgo Jadot Pécresse Poutou "Dupont-Aignant"n ;
run;

/* Affichage du dendrogramme */
proc tree data=outtree;
   id row_id;
run;






	/* Nous allons dans un 1e temps garder que les villes avec +5000 inscrits */
/* on supprime les colonnes non pertinentes et on renomme les colonnes que l'on garde */
data resultats1 (drop = "Libellé de la circonscription"n N°Panneau Nom Sexe Prénom AC AD AE AF AJ AK AL AM AQ AR AS AT AX AY AZ BA BE BF BG BH BL BM BN BO BS BT BU BV BZ CA CB CC CG CH CI CJ CN CO CP CQ CU CV CW CX  );
	set votlib.resultats (rename=( "% Voix/Ins"n=Arthaud AG=Voix2 AH=Roussel AI="%Voix/Exp2"n AN=Voix3 AO=Macron AP="%Voix/Exp3"n AU=Voix4 AV=Lassalle AW="%Voix/Exp4"n BB=Voix5 BC=LePen BD="%Voix/Exp5"n BI=Voix6 BJ=Zemmour BK="%Voix/Exp6"n BP=Voix7 BQ=Melenchon BR="%Voix/Exp7"n BW=Voix8 BX=Hidalgo BY="%Voix/Exp8"n CD=Voix9 CE=Jadot CF="%Voix/Exp9"n CK=Voix10 CL=Pécresse CM="%Voix/Exp10"n CR=Voix11 CS=Poutou CT="%Voix/Exp11"n CY=Voix12 CZ="Dupont-Aignant"n DA="%Voix/Exp12"n));
	if not ("Code du département"n in ("ZZ"));
	where input(Inscrits, best.) > 5000 ;
run;


proc princomp data=resultats1 out=votlib.sorties n=5 PLOTS(ncomp=4) =(SCORE pattern(circle vector));
id "Libellé de la commune"n;
var Arthaud Roussel Macron Lassalle LePen Zemmour Melenchon Hidalgo Jadot Pécresse Poutou "Dupont-Aignant"n;
run;

/* 2e catégorie */
data resultats2 (drop = "Libellé de la circonscription"n N°Panneau Nom Sexe Prénom AC AD AE AF AJ AK AL AM AQ AR AS AT AX AY AZ BA BE BF BG BH BL BM BN BO BS BT BU BV BZ CA CB CC CG CH CI CJ CN CO CP CQ CU CV CW CX  );
	set votlib.resultats (rename=( "% Voix/Ins"n=Arthaud AG=Voix2 AH=Roussel AI="%Voix/Exp2"n AN=Voix3 AO=Macron AP="%Voix/Exp3"n AU=Voix4 AV=Lassalle AW="%Voix/Exp4"n BB=Voix5 BC=LePen BD="%Voix/Exp5"n BI=Voix6 BJ=Zemmour BK="%Voix/Exp6"n BP=Voix7 BQ=Melenchon BR="%Voix/Exp7"n BW=Voix8 BX=Hidalgo BY="%Voix/Exp8"n CD=Voix9 CE=Jadot CF="%Voix/Exp9"n CK=Voix10 CL=Pécresse CM="%Voix/Exp10"n CR=Voix11 CS=Poutou CT="%Voix/Exp11"n CY=Voix12 CZ="Dupont-Aignant"n DA="%Voix/Exp12"n));
	if not ("Code du département"n in ("ZZ"));
	where input(Inscrits, best.) < 5000 and input(Inscrits, best.) >1000;
run;

proc princomp data=resultats2 out=votlib.sorties2 n=5 PLOTS(ncomp=3) =(SCORE pattern(circle vector));
id "Code du département"n;
var Arthaud Roussel Macron Lassalle LePen Zemmour Melenchon Hidalgo Jadot Pécresse Poutou "Dupont-Aignant"n;
run;


/* 3e catégorie */
data resultats3 (drop = "Libellé de la circonscription"n N°Panneau Nom Sexe Prénom AC AD AE AF AJ AK AL AM AQ AR AS AT AX AY AZ BA BE BF BG BH BL BM BN BO BS BT BU BV BZ CA CB CC CG CH CI CJ CN CO CP CQ CU CV CW CX  );
	set votlib.resultats (rename=( "% Voix/Ins"n=Arthaud AG=Voix2 AH=Roussel AI="%Voix/Exp2"n AN=Voix3 AO=Macron AP="%Voix/Exp3"n AU=Voix4 AV=Lassalle AW="%Voix/Exp4"n BB=Voix5 BC=LePen BD="%Voix/Exp5"n BI=Voix6 BJ=Zemmour BK="%Voix/Exp6"n BP=Voix7 BQ=Melenchon BR="%Voix/Exp7"n BW=Voix8 BX=Hidalgo BY="%Voix/Exp8"n CD=Voix9 CE=Jadot CF="%Voix/Exp9"n CK=Voix10 CL=Pécresse CM="%Voix/Exp10"n CR=Voix11 CS=Poutou CT="%Voix/Exp11"n CY=Voix12 CZ="Dupont-Aignant"n DA="%Voix/Exp12"n));
	if not ("Code du département"n in ("ZZ"));
	where input(Inscrits, best.) < 1000;
run;

proc princomp data=resultats3 out=votlib.sorties3 n=5 PLOTS(ncomp=4) =(SCORE pattern(circle vector));
id "Code du département"n;
var Arthaud Roussel Macron Lassalle LePen Zemmour Melenchon Hidalgo Jadot Pécresse Poutou "Dupont-Aignant"n;
run;

/* 4e catégorie */
data resultats4 (drop = "Libellé de la circonscription"n N°Panneau Nom Sexe Prénom AC AD AE AF AJ AK AL AM AQ AR AS AT AX AY AZ BA BE BF BG BH BL BM BN BO BS BT BU BV BZ CA CB CC CG CH CI CJ CN CO CP CQ CU CV CW CX  );
	set votlib.resultats (rename=( "% Voix/Ins"n=Arthaud AG=Voix2 AH=Roussel AI="%Voix/Exp2"n AN=Voix3 AO=Macron AP="%Voix/Exp3"n AU=Voix4 AV=Lassalle AW="%Voix/Exp4"n BB=Voix5 BC=LePen BD="%Voix/Exp5"n BI=Voix6 BJ=Zemmour BK="%Voix/Exp6"n BP=Voix7 BQ=Melenchon BR="%Voix/Exp7"n BW=Voix8 BX=Hidalgo BY="%Voix/Exp8"n CD=Voix9 CE=Jadot CF="%Voix/Exp9"n CK=Voix10 CL=Pécresse CM="%Voix/Exp10"n CR=Voix11 CS=Poutou CT="%Voix/Exp11"n CY=Voix12 CZ="Dupont-Aignant"n DA="%Voix/Exp12"n));
	if ("Code du département"n in ("ZZ"));
		where input(Inscrits, best.) > 1000;
run;

proc princomp data=resultats4 out=votlib.sorties4 n=5 PLOTS(ncomp=4) =(SCORE pattern(circle vector));
id "Libellé de la commune"n;
var Arthaud Roussel Macron Lassalle LePen Zemmour Melenchon Hidalgo Jadot Pécresse Poutou "Dupont-Aignant"n;
run;


/* test */

/* il y a 107 département */
proc freq data=resultats;
  tables "Libellé du départements"n ;
run;



proc corr data=resultats;
  var "% Voix/Ins"n "%Voix/Ins2"n "%Voix/Ins3"n "%Voix/Ins4"n "%Voix/Ins5"n "%Voix/Ins6"n "%Voix/Ins7"n "%Voix/Ins8"n "%Voix/Ins9"n "%Voix/Ins10"n "%Voix/Ins11"n "%Voix/Ins12"n;
run;

proc standard data=resultats out=donnees_standardisees;
  var "% Voix/Ins"n "%Voix/Ins2"n "%Voix/Ins3"n "%Voix/Ins4"n "%Voix/Ins5"n "%Voix/Ins6"n "%Voix/Ins7"n "%Voix/Ins8"n "%Voix/Ins9"n "%Voix/Ins10"n "%Voix/Ins11"n "%Voix/Ins12"n;
 run;

proc princomp data=donnees_standardisees out=votlib.sorties n=5 PLOTS(ncomp=2) =(SCORE pattern(circle vector));
id "Libellé du département"n;
var "% Voix/Ins"n "%Voix/Ins2"n "%Voix/Ins3"n "%Voix/Ins4"n "%Voix/Ins5"n "%Voix/Ins6"n "%Voix/Ins7"n "%Voix/Ins8"n "%Voix/Ins9"n "%Voix/Ins10"n "%Voix/Ins11"n "%Voix/Ins12"n;
run;
