/*_____________________________MINI PROJRET FINAL ______________________________*/


/*________________tache 1 ______________*/


create table Section ( ID_section int primary key,
                       Nom_section char(1),
					   Niveau char(2) not null ,
					   Specialite char(4));
drop table Etudiant;
create table Etudiant (matricule_etu int primary key ,
                       nom_etu varchar(20),
 					   prenom_etu varchar(30),
					   date_naissance date,
					   Adresse varchar(20),
					   ID_section int ); 
ALTER TABLE Etudiant ADD CONSTRAINT fk_ID FOREIGN KEY (ID_section ) REFERENCES Section (ID_section);
 
INSERT INTO Section Values(1 ,'A' ,'L2' ,'ACAD');
INSERT INTO Section Values(2 ,'B' ,'L2' ,'ACAD');
INSERT INTO Section Values(3 ,'A' ,'L2' ,'ISIL');
INSERT INTO Section Values(4 ,'B' ,'L2' ,'ISIL');
INSERT INTO Section Values(5 ,'A' ,'M1' ,'SII');
INSERT INTO Section Values(6 , 'A' ,'M1' ,'SS');

INSERT INTO Etudiant Values(20190001 ,'BOUSSAI',' MOHAMED' ,'12/01/2000',' Alger',1);
INSERT INTO Etudiant Values(20190002 ,'CHAID ','LAMIA'     , '01/10/1999' , 'Batna',2);
INSERT INTO Etudiant Values(20190003 ,'BRAHIMI',' SOUAD '  ,'18/11/2000'  ,'Sétif',1);
INSERT INTO Etudiant Values(20190004 ,' LAMA ','SAID'      , '23/05/1999' ,'Oran',1);

/*_________________tache 2____________*/

/*__________________1 er partie _________*/

/*ajouter une enseignant*/
insert into BDDAdmin.Enseignant values (?,?,?)
PreparedStatement aj=cnx.prepareStatement(req);
					aj.setString (1,mat.getText());
					aj.setString (2,nom.getText());
					aj.setString (3,prenom.getText());
					
					aj.execute();
					
/*modifier un enseignant*/
UPDATE BDDAdmin.Enseignant SET NOM_ENS='"+nom1.getText()+"',PRENOM_ENS='"+prenom1.getText()+"' 
where (MATRICULE_ENS='"+mat2.getText()+"')
/*changer la libelle et le nombre d'heure d'une unité donnée*/
UPDATE 	Unite set  LIBELLE='"+libelle.getText()+"',NBR_HEURES='"+nbr.getText()+"' 
where (CODE_UNITE='"+code.getText()+"')
/*Afficher les noms et prénoms des étudiants ayant obtenus des notes d'examens égales à une note donnée*/
SELECT nom_etu, prenom_etu 
FROM Etudiant 
 where matricule_etu IN (SELECT matricule_etu from EtudiantUnite where   note_examen ="+note.getText() +")
/*Afficher les noms et prénoms des étudiants qui ne sont pas inscrits dans l'unité donnée*/
SELECT libelle FROM Unite MINUS SELECT libelle 
FROM Unite
WHERE code_unite IN (SELECT code_unite FROM EtudiantUnite)
/*Afficher les libellés des unités d'enseignement dont aucun étudiant n'est inscrit*/
SELECT libelle
FROM Unite MINUS SELECT libelle FROM Unite WHERE code_unite IN (SELECT code_unite FROM EtudiantUnite)
/*Afficher pour chaque étudiant, son nom, son prénom sa moyenne par unité d'enseignement ainsi que le libellé de l'unité*/
SELECT E.nom_etu,  E.prenom_etu,  U.libelle,  ((EU.note_CC + EU.note_TP + EU.note_examen)/3)
FROM Etudiant E, Unite U, EtudiantUnite EU 
WHERE E.matricule_etu = EU.matricule_etu AND EU.code_Unite = U.code_Unite
/*recherche par étudiant*/
ELECT E.nom_etu,E.prenom_etu, D.libelle,((F.note_CC+F.note_TP+F.note_examen)/3) 
FROM Etudiant E,Unite D, EtudiantUnite F 
WHERE E.matricule_etu =F.matricule_etu and F.code_unite= D.code_unite And E.matricule_etu="+matr.getText("))
/*recharche par enseignant*/
select x.code_unite 
 from  Unite x, Enseignant y  
 where x.matricule_ens=y.matricule_ens and  y.matricule_ens="+mat.getText()" )

/*liste etudiant par section*/
select nom_etu,prenom_etu,matricule_etu,id_section from etudiant 
where id_section in (select id_section from section where etudiant.id_section=section.id_section) 
order by id_section

 
 