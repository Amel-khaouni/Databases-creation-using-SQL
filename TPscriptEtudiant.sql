/*************************TACHE N 1 : ***********************************/
			  
			  
			
			  
/* 1.Créer l'utilisateur "BDDAdmin" avec le mot de passe "TPAdmin".  */

ALTER USER BDDAdmin IDENTIFIED BY TPAdmin ;

/* 2.Accorder à "BDDAdmin" tous les privilèges. */

GRANT ALL PRIVILEGES TO BDDAdmin ;

/*3.Se connecter avec l'utilisateur "BDDAdmin".  */
CONNECT BDDAdmin TPAdmin



/*4.Créer les tables précédentes avec les contraintes d'intégritésadéquates.  */
CREATE TABLE ETUDIANT
 (  Matricule_etud     Number(10) PRIMARY KEY ,
    nom_etu varchar (10) not null, 
	prenom_etu varchar (10) not null,
	date_naissance   DATE  not null
	
  );
  
  CREATE TABLE Enseignant
 (  matricule_ens     Number(10) PRIMARY KEY ,
    nom_ens varchar (10) not null, 
	prenom_ens varchar (10) not null,
	âge   Number(2) check(age<80 and age>18)
	
  );
  
  CREATE TABLE Unité
 (  code_Unité     VARCHAR(10) PRIMARY KEY ,
    libelle VARCHAR(10) not null, 
	nbr_heures Number(10)  not null,
	
	CONSTRAINT FK_unite FOREIGN KEY (matricule_ens) REFERENCES Enseignant(matricule_ens)
	
  );
  
  
  
  
  CREATE TABLE EtudiantUnité
 (  CONSTRAINT PK_etudianrunite  PRIMARY KEY ( matricule_etu, code_Unité ),
    CONSTRAINT FK_mat_etu FOREIGN KEY (matricule_etu) REFERENCES ETUDIANTS (matricule_etu),
	CONSTRAINT FK_code_unite FOREIGN KEY (code_Unité) REFERENCES Unité (code_Unité),
	note_CC int check (note_CC>=0 and note_CC<=20 ), 
	note_TP int check (note_TP>=0 and note_TP<=20 ) , 
	note_examen int check (note_examen>=0 and note_examen<=20 )
	
  );
  
  /*************************************Tâche 2: Création des utilisateurs ************************************/
  
  
  /*1.Créer l'utilisateur "Etudiant" avec le mot de passe "TPEtudiant".*/
   ALTER USER Etudiant IDENTIFIED BY TPEtudiant ;
   
   /*2.Accorder à "Etudiant" uniquement le privilèges SELECT sur la table Etudiant. */
   grant select on Etudiant to Etudiant ;
  
  /*3.Créer l'utilisateur "Enseignant" avec le mot de passe "TPEnseignant". */
  ALTER USER Enseignant IDENTIFIED BY TPEnseignant ;
  
  
  /*4.Accorder à "Enseignant" le privilèges SELECT et INSERT sur la table Enseignant. */
  grant select, insert on Enseignant to Enseignant ;
  
  /***********************************  Tâche 3: Modification du schéma et ajout de contraintes   ****************************/
  
  
  /*1.Ajouter l'attribut Adresse à la table Etudiant de type chaînes de 100 caractères. */
  
  ALTER TABLE ETUDIANTS ADD ( Adresse varchar (100) not null) ;
  
  /*2.Supprimer l'attribut âge de la table Enseignant. */

  ALTER TABLE Enseignant DROP COLUMN  (âge);
  
  /*3.Exiger que tous les matricules des étudiants doivent être entre 20190000 et 20199999.*/
  alter table ETUDIANTS modify  constraint check (matricule_etu>=20190000 and matricule_etu<=20199999);
  
  /*4.Augmenter le type de l'attribut prénom_etu de 5 caractères.*/
  ALTER TABLE ETUDIANTS MODIFY (prenom_etu varchar(15), );
  
  
  
  /**************************** Tâche 4: Insertions et modifications des tuples. ****************************/
  
  /*1.Insérer les tuples */
  
  /* 1 : Etudiant    */
  INSERT INTO ETUDIANT VALUES (20190001 , 'BOUSSAI ', 'MOHAMED',12012000,'Alger');
  INSERT INTO ETUDIANT VALUES (20190002 , 'CHAID', 'LAMIA',01101999,'Batna');
  INSERT INTO ETUDIANT VALUES (20190003 , 'BRAHIMI ', 'SOUAD',18112000,'Sétif');
  INSERT INTO ETUDIANT VALUES (20190004 , 'LAMA ', 'SAID',23051999,'Oran');
  
  /* 2 : Enseignant    */
  INSERT INTO Enseignant VALUES (20000001 , 'HAROUNI ', 'AMINE');
  INSERT INTO Enseignant VALUES (19990011 , 'FATHI ', 'OMAR');
  INSERT INTO Enseignant VALUES (19980078 , 'BOUZIDANE ', 'FARAH');
  INSERT INTO Enseignant VALUES (20170015 , 'ARABI ', 'ZOUBIDA');
  /* 3 : Unite */
  INSERT INTO unité VALUES ('FEI0001','POO', 6,20000001);
  INSERT INTO unité VALUES ('FEI0002','BDD', 6,19990011);
  INSERT INTO unité VALUES ('FEI0003','RESEAU',3 ,20170015);
  INSERT INTO unité VALUES ('FEI0004','SYSTEME',6 ,19980078);
 
  
  /* 4 : EtudiantUnite */
  INSERT INTO EtudiantUnite VALUES (20000001 , 'FEI0001 ',10,15,9);
  INSERT INTO EtudiantUnite VALUES (20190002 , 'FEI0001 ',20,13,10);
  INSERT INTO EtudiantUnite VALUES (20190004 , 'FEI0001 ',13,17,16);
  INSERT INTO EtudiantUnite VALUES (20190002 , 'FEI0002 ',10,16,17);
  INSERT INTO EtudiantUnite VALUES (20190003 , 'FEI0002 ',9,8,15);
  INSERT INTO EtudiantUnite VALUES (20190004 , 'FEI0002 ',15,9,20);
  INSERT INTO EtudiantUnite VALUES (20190002 , 'FEI0004 ',12,18,14);
  INSERT INTO EtudiantUnite VALUES (20190003 , 'FEI0004 ',17,12,15);
  INSERT INTO EtudiantUnite VALUES (20190004 , 'FEI0004 ',12,13,20);
  
  
    
  
  
  
  
  
  
  /*2.Augmenter la note_CC de 2 pour tous les étudiants dont le nom commence par 'B'.  */
  
  
  
  /*3. Remettre toutes les notes d'examen de l'unité "SYSTEME" à 0 pour tous les étudiants. */
  
  
  
  
  
  
  
       /**************************************  Tâche 5: Interrogation de la base de données ***********************/
  
    /*1. Afficher les noms et prénoms des étudiants ayant obtenus des notes d'examens égales à 20.*/
  
SELECT  nom_etu, prenom_etu FROM Etudiant  where matricule_etu IN (SELECT matricule_etu from EtudiantUnite where   note_examen = 20 );


/*2. Afficher les noms et prénoms des étudiants qui ne sont pas inscrits dans l'unité « POO ».*/

SELECT nom_etu, prenom_etu FROM Etudiant WHERE matricule_etu NOT IN (SELECT EU.matricule_etu FROM EtudiantUnite EU, Unite U WHERE EU.code_Unite = U.code_Unite AND libelle = 'POO');
		
		
		/*3. Afficher les libellés des unités d'enseignement dont aucun étudiant n'est inscrit.*/
		
SELECT libelle FROM Unite MINUS SELECT libelle FROM Unite WHERE code_unite IN (SELECT code_unite FROM EtudiantUnite);

/*4. Afficher pour chaque étudiant, son nom, son prénom sa moyenne par unité d'enseignement ainsi que le libellé de l'unité.*/
		
	SELECT E.nom_etu,  E.prenom_etu,  U.libelle,  ((EU.note_CC + EU.note_TP + EU.note_examen)/3) 
     FROM Etudiant E, Unite U, EtudiantUnite EU
     WHERE E.matricule_etu = EU.matricule_etu AND EU.code_Unite = U.code_Unite;

  
