DROP SCHEMA IF EXISTS transmusical_a22 CASCADE;

create schema transmusical_a22;

set schema 'transmusical_a22';

create table _formation (
  libelle_formation VARCHAR PRIMARY KEY not null
);

create table _annee (
  an INT PRIMARY KEY not null
);

create table _pays (
  nom_p VARCHAR PRIMARY KEY not null
);

create table _type_musique(
  type_m VARCHAR PRIMARY KEY not null
);

create table _edition(
    nom_edition VARCHAR PRIMARY KEY not null,
    annee_edition INTEGER
);

create table _concert (
  no_concert VARCHAR PRIMARY KEY not null,
  titre VARCHAR not null,
  resume VARCHAR not null,
  duree INT not null,
  tarif FLOAT not null,
  est_de VARCHAR not null,
  se_deroule VARCHAR not null
);

create table _ville (
  nom_v VARCHAR PRIMARY KEY not null,
  se_situe VARCHAR not null
);

create table _lieu (
  id_lieu VARCHAR PRIMARY KEY not null,
  nom_lieu VARCHAR not null,
  accesPMR BOOLEAN not null,
  capacite_max INTEGER not null,
  type_lieu VARCHAR not null,
  dans VARCHAR not null
);

create table _representation (
  numero_representation VARCHAR PRIMARY KEY not null,
  heure VARCHAR not null,
  date_representation DATE not null,
  jouer_par VARCHAR not null,
  a_lieu_dans VARCHAR not null,
  correspond_a VARCHAR not null
);
create table _groupe_artiste (
  id_groupe_artiste VARCHAR PRIMARY KEY not null,
  nom_groupe_artiste VARCHAR not null,
  site_web VARCHAR not null,
  debut INTEGER not null,
  sortie_discographie INTEGER not null,
  a_pour_origine VARCHAR not null
);

ALTER TABLE _groupe_artiste
ADD CONSTRAINT _groupe_artiste_fk_debut
FOREIGN KEY(debut) REFERENCES _annee(an);

ALTER TABLE _groupe_artiste
ADD CONSTRAINT _groupe_artiste_fk_sortie_discographie
FOREIGN KEY(sortie_discographie) REFERENCES _annee(an);

ALTER TABLE _groupe_artiste
ADD CONSTRAINT _groupe_artiste_fk_a_pour_origine
FOREIGN KEY(a_pour_origine) REFERENCES _pays(nom_p);

create table _a_pour(
  id_groupe_artiste VARCHAR not null,
  libelle_formation VARCHAR not null,
  FOREIGN KEY (id_groupe_artiste) REFERENCES _groupe_artiste(id_groupe_artiste),
  FOREIGN KEY (libelle_formation) REFERENCES _formation(libelle_formation),
  PRIMARY KEY (id_groupe_artiste, libelle_formation)
);

create table _type_ponctuel(
  id_groupe_artiste VARCHAR not null,
  type_m VARCHAR not null,
  FOREIGN KEY (id_groupe_artiste) REFERENCES _groupe_artiste(id_groupe_artiste),
  FOREIGN KEY (type_m) REFERENCES _type_musique(type_m),
  PRIMARY KEY (id_groupe_artiste, type_m)
);

create table _type_principale(
  id_groupe_artiste VARCHAR not null,
  type_m VARCHAR not null,
  FOREIGN KEY (id_groupe_artiste) REFERENCES _groupe_artiste(id_groupe_artiste),
  FOREIGN KEY (type_m) REFERENCES _type_musique(type_m),
  PRIMARY KEY (id_groupe_artiste, type_m)
);

ALTER TABLE _representation
ADD CONSTRAINT _representation_fk_jouer_par
FOREIGN KEY (jouer_par) REFERENCES _groupe_artiste(id_groupe_artiste);

ALTER TABLE _edition
ADD CONSTRAINT _edition_fk_annee_edition
FOREIGN KEY(annee_edition) REFERENCES _annee(an);

ALTER TABLE _ville
ADD CONSTRAINT _ville_fk_se_situe
FOREIGN KEY(se_situe) REFERENCES _pays(nom_p);

ALTER TABLE _lieu
ADD CONSTRAINT _lieu_fk_dans
FOREIGN KEY(dans) REFERENCES _ville(nom_v);

ALTER TABLE _representation
ADD CONSTRAINT _representation_fk_a_lieu_dans
FOREIGN KEY(a_lieu_dans) REFERENCES _lieu(id_lieu);

ALTER TABLE _representation
ADD CONSTRAINT _representation_fk_correspond_a
FOREIGN KEY(correspond_a) REFERENCES _concert(no_concert);

ALTER TABLE _concert
ADD CONSTRAINT _concert_fk_est_de
FOREIGN KEY(est_de) REFERENCES _type_musique(type_m);

ALTER TABLE _concert
ADD CONSTRAINT _concert_fk_se_deroule
FOREIGN KEY(se_deroule) REFERENCES _edition(nom_edition); 
