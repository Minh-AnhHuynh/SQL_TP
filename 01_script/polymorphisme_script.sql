-- TP SQL pratique

-- ssh -f -N -L 10007:localhost:5432 -l obi_5 134.157.183.99

-- password = @bim2021-14
-- psql-h localhost polymorphisme -U minhanh


-- psql -h 134.157.183.99 -d polymorphisme -p10007 -U brice


-- Pour se connecter à obiN directement
-- ssh -X obi4@134.157.183.99
-- OBI_2022! -- Password
-- gedit HuynhMinh-Anh.sql & -- Open sql file
-- psql polymorphisme -- Launch psql


-- Use Putty for windows or Linux Sub System to have an ssh terminal

-- Connecting from a database manager DBeaver for Windows
-- SSH connection: 134.157.183.99
-- user : minhanh ; password : @bim2021-14 ; database : polymorphisme

-- 1. Lister les régions
SELECT nom_region FROM regions;
SELECT * FROM regions ;
-- 2. Compter le nombre de régions différentes
SELECT COUNT (nom_region) FROM regions;
SELECT COUNT (*) FROM regions;

-- 3. Afficher les populations de la région europe
SELECT nom_region FROM populations WHERE nom_region = 'Europe';

-- 4. Compter le nombre de population de la région europe
SELECT COUNT(nom_population) FROM populations WHERE nom_region = 'Europe';

-- 5. Afficher les échantillons dont la taille est supérieure à 300
SELECT * FROM echantillons WHERE taille_echantillon > 300;

-- 6. Compter le nombre d’echantillons dont la taille est comprise entre 100 et 200
SELECT COUNT(*) FROM echantillons WHERE taille_echantillon > 100 AND taille_echantillon < 200;

-- 7. Lister les informations relatives aux populations triées par régions
SELECT * FROM populations ORDER BY nom_region;

-- 8. Lister les chromosomes à partir de la table
SELECT nom_chromosome FROM bandes;

-- 9. Liste unique des chromosomes à partir de la table bandes
SELECT DISTINCT nom_chromosome FROM bandes;

-- 10. Information pour échantillons nommés Zoro
SELECT nom_echantillon, echantillon_uid, taille_echantillon, pop_uid FROM echantillons WHERE nom_echantillon = 'Zoro' ;

-- 11. Noms et uid des échantillons dont le nom commence par Druze
SELECT nom_echantillon, echantillon_uid FROM echantillons WHERE nom_echantillon ~ '^Druze';
-- = sign doesn't work
-- '\>Europe\<' to search only for a word

-- 12. Noms et uid des échantillons qui contiennent le terme Afric
SELECT nom_echantillon, echantillon_uid FROM echantillons WHERE nom_echantillon ~ 'Afric';

-- 13. Taille minimale des échantillons dont le nom contient Afric
SELECT min(taille_echantillon) FROM echantillons WHERE nom_echantillon ~'Afric';
-- Un min() fait un GROUP BY caché, donc il ne peut pas afficher une ligne qui n'est pas regroupée, donc on ne peut pas afficher nom_echantillon sans faire GROUP BY.

-- 14. Taille maximale des échantillons dont le nom commence par Druz
SELECT max(taille_echantillon) FROM echantillons WHERE nom_echantillon ~ '^Druze';

-- 15. Nombre d'allèles pour condition >= 0.1
SELECT count (DISTINCT allele_uid) FROM frequences WHERE frequence >= 0.1 ;


-- 16. Minimum et maximum de la fréquence pour chaque échantillons
SELECT echantillon_uid, min(frequence), max(frequence) FROM frequences GROUP BY echantillon_uid ;

-- 17. Nombre d'allèles par site
SELECT site_uid, COUNT(allele_uid) FROM alleles GROUP BY site_uid ;

-- 18. Somme des fréquences pour chaque échantillons
SELECT echantillon_uid, sum(frequence) FROM frequences GROUP BY echantillon_uid ;
-- C'est normal de ne pas avoir 1 car on �tudie plusieurs g�nes par �chantillon. Plusieurs all�les donnent 1 g�ne.
-- Filtrer par locus_uid pour obtenir la somme des all�les = 1 (paire echantillon + locus)


-- 19. produit cartésien de chromosomes et régions
SELECT * from roM chromosomes CROSS JOIN regions ;

-- 20. Nom et fréquence de chaque allèle, 12 premiers
SELECT nom_allele, frequence FROM alleles as a
INNER JOIN frequences as f ON a.allele_uid  = f.allele_uid limit 12;
-- Bien s'assurer de rentrer la cl� primaire sur l'argument ON
-- On peut simplifier la requ�te en utilisant as 

-- 21. Liste des échantillons par régions
SELECT nom_echantillon, nom_region FROM echantillons
INNER JOIN populations ON echantillons.pop_uid = populations.pop_uid
ORDER BY nom_region;

-- 22. Somme des fréquences par échantillon et par site 
SELECT nom_echantillon , nom_site, sum(frequence) FROM frequences 
INNER JOIN alleles ON alleles.allele_uid = frequences.allele_uid join 
GROUP BY echantillon_uid, site_uid  ;

-- 23. Liste des populations pour lesquelles la moyenne des tailles d'échantillons >= 100
SELECT nom_population, avg(taille_echantillon) FROM populations
INNER JOIN echantillons ON populations.pop_uid = echantillons.pop_uid 
group by nom_population  
having avg(taille_echantillon) > 100;

-- 24. Lister les symboles d'all�les par locus
SELECT distinct locus_uid ,symbole_allele FROM loci 
natural join alleles natural join sites;
-- A un locus on peut avoir plusieurs sites

-- 25. alleles avec la m�me fréquence dans différentes pop ?
SELECT nom_allele, frequence, nom_population  FROM alleles a 
NATURAL JOIN frequences f2 NATURAL JOIN populations p where allele_uid in (select allele_uid, count(pop_uid), frequence 
from frequences f natural join echantillons e group by allele_uid, frequence having count(pop_uid)>1);

-- Code doesn't work yet




