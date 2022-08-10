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
/** Transaction, grouping and agregate end */