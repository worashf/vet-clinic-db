/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '01-01-2016' AND '01-01-2019';
SELECT name FROM animals WHERE neutered =true  AND  escape_attempts <3;

SELECT date_of_birth
FROM animals WHERE name ='Agumon' OR name ='Pikachu';

SELECT name, escape_attempts from animals WHERE weight_kg >10.5

SELECT * FROM animals WHERE neutered =true;

SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;


/** Transaction, grouping and agregate start */

BEGIN;
UPDATE animals SET species ='unspecified';  --made update on species column
SELECT species FROM animals; --verify update made
ROLLBACK;
SELECT species FROM animals; --verify update made undone

/* update  and commit start*/
BEGIN;
UPDATE animals SET species ='digimon' WHERE name LIKE '%mon';
UPDATE animals SET species ='pokemon' WHERE species IS NULL;
SELECT name,species from animals; --verify update made
COMMIT;
SELECT name,species from animals; --verify update made after commit
/* update and commit end */

/* delete all animals data inside transaction and undo deletion start*/
BEGIN;
DELETE FROM animals;
SELECT COUNT(*) FROM animals; --check the count of animals 
SELECT * FROM animals; -- check after deletion
ROLLBACK;
--check the count of animals after rollback
SELECT COUNT(*) FROM animals; 
/* delete all animals data inside transaction and undo deletion end*/

/** delete all  animals born after jan 1st 2022; */
BEGIN;
DELETE FROM animals WHERE date_of_birth >='01/01/2022';
SELECT name, date_of_birth FROM animals;
 -- create savepoint 

--create savepoint 
SAVEPOINT sp1;
UPDATE animals SET weight_kg =weight_kg * -1;
SELECT name, weight_kg FROM animals;
 ROLLBACK TO sp1;
 SELECT name, weight_kg FROM animals; -- check after rollback

  UPDATE animals SET weight_kg =weight_kg * -1
 WHERE weight_kg < 0;
 SELECT name, weight_kg 
 FROM animals;  --check the chande made
 COMMIT;
/*  */

/* aggreigate */
 -- how many animals are there
 SELECT COUNT(*) from animals;
 -- count animals never tried to escape
  SELECT COUNT(*) from animals WHERE escape_attempts =0;
 -- calculate the average weght of all animals
  SELECT AVG(weight_kg) from animals;
  --  find the max escape attemps ,neutered or not neutered animals?
  SELECT neutered, 
 MAX(escape_attempts)  AS max_escap_attempts
FROM animals 
GROUP BY neutered;

-- find the max weight of animals
SELECT MAX(weight_kg) FROM animals;
--find the min weight of animals
SELECT MIN(weight_kg) FROM animals;
-- acalculate the average escap attemps of animals born between 1990 and 2000
SELECT AVG(escape_attempts) FROM animals WHERE
date_of_birth BETWEEN '01/01/1990' AND '01/01/2000'
/** Transaction, grouping and agregate end */


/** ###  query using join */

 /** What animals belong to Melody Pond? */
 SELECT full_name, name  FROM  animals a JOIN owners o
 ON  a.owner_id = o.id WHERE o.full_name ='Melody Pond';

 /** find all animals whose species is Pokemon */

 SELECT s.name as species,a.name FROM animals a 
 JOIN species s ON a.species_id = s.id WHERE
 s.name = ' Pokemon';


 /** List all owners and their animals, remember to include those that don't own any animal.*/

 SELECT o.full_name as owner_full_name, 
 a.name as animal_name FROM animals a JOIN owners o
  ON a.owner_id =o.id WHERE a.owner_id =o.id;

  /** How many animals are there per species? */
   SELECT COUNT(*) as num_of_animals, s.name 
 FROM animals a JOIN species s ON a.species_id = s.id
   GROUP BY s.name;

   /** List all Digimon owned by Jennifer Orwell. **/
SELECT a.name AS vet_name, s.name AS specie_name, o.full_name AS owner_full_name 
FROM animals a
JOIN species s ON a.species_id =s.id 
JOIN owners o
ON a.owner_id= o.id 
WHERE o.full_name ='Jennifer Orwell'
AND s.name='  Digimon';

/** List all animals owned by Dean Winchester that haven't tried to escape */
SELECT a.name AS animal_name, escape_attempts ,
o.full_name AS owner_name FROM animals a JOIN owners o
ON a.owner_id =o.id WHERE o.full_name ='Dean Winchester'
AND a.escape_attempts =0;

/** Who owns the most animals? -****/
SELECT full_name, COUNT(*) FROM animals
JOIN owners ON animals.owner_id = owners.id
GROUP BY owners.full_name ORDER BY count DESC;



/**  ## many to many  ***/
/*Who was the last animal seen by William Tatcher? */
SELECT a.name As animal_name, vet.name As vet_name, visit.date_of_visit 
FROM animals a JOIN visits visit on a.id =visit.animal_id
JOIN vets vet ON vet.id =visit.vet_id WHERE vet.name ='William Tatcher'
ORDER BY date_of_visit DESC LIMIT 1;

/*How many different animals did Stephanie Mendez see?*/
SELECT vet.name AS vet_name, COUNT(DISTINCT animal_id)FROM
vets vet JOIN visits visit on vet.id =visit.vet_id 
WHERE vet.name ='Stephanie Mendez' GROUP BY vet.name;


/* List all vets and their specialties, including vets with no specialties.*/
SELECT vet.name AS vet_name ,s.name As specialization FROM vets vet LEFT JOIN 
specializations spec ON vet.id =spec.vet_id LEFT JOIN species s 
ON  s.id =spec.species_id;

/*List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020 */
SELECT a.name AS animal_name, vet.name AS vet_name ,visit.date_of_visit
FROM visits visit JOIN  animals a ON a.id =visit.animal_id JOIN vets vet ON vet.id =visit.vet_id
WHERE vet.name ='Stephanie Mendez'AND visit.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';


/*What animal has the most visits to vets? */

SELECT a.name AS animal_name, COUNT(date_of_visit) as visit_count FROM
animals a JOIN visits visit on a.id =visit.vet_id 
 GROUP BY a.name  ORDER BY visit_count DESC LIMIT 1;



 /* Who was Maisy Smith's first visit? */
SELECT vet.name AS vet_name, a.name AS animal_name, visit.date_of_visit 
FROM visits visit JOIN vets vet ON vet.id = visit.vet_id JOIN animals a ON
  a.id = visit.animal_id WHERE vet.name = 'Maisy Smith' 
  ORDER BY visit.date_of_visit ASC LIMIT 1;


  /* Details for most recent visit: animal information, vet information, and date of visit. */
  SELECT a.name AS animal_name,a.date_of_birth,a.neutered, vet.name AS doctor_name, vet.date_of_graduation
AS vet_graduation_date, vet.age AS vet_age, visit.date_of_visit
FROM vets vet JOIN  visits visit ON vet.id =visit.vet_id JOIN animals a
ON a.id =visit.animal_id ORDER BY visit.date_of_visit DESC LIMIT 1;



/*How many visits were with a vet that did not specialize in that animal's species? */
SELECT COUNT(date_of_visit) FROM vets LEFT JOIN visits V ON V.vet_id = vets.id LEFT JOIN specializations S ON
  S.vet_id = vets.id LEFT JOIN animals ON animal_id = animals.id WHERE animals.species_id NOT IN
  (SELECT species_id FROM specializations WHERE vet_id = vets.id) OR S.species_id IS NULL;


  /*What specialty should Maisy Smith consider getting? Look for the species she gets the most. */

  SELECT  vet.name AS vet_name, s.name as speciality,COUNT(date_of_visit) count  FROM visits visit JOIN animals a ON 
visit.animal_id = a.id JOIN species s ON a.species_id = s.id 
JOIN vets vet ON visit.vet_id = vet.id WHERE vet.name = 'Maisy Smith' GROUP BY vet.name,s.name;
