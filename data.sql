/* Populate database with sample data. */


INSERT INTO animals (name,date_of_birth,weight_kg,escape_attempts,neutered) VALUES 
('Agumon', '03-02-2020', 10.23, 0,true);

INSERT INTO animals (name,date_of_birth,weight_kg,escape_attempts,neutered) VALUES 
('Gabumon', '15-11-2018', 8, 2,true);

INSERT INTO animals (name,date_of_birth,weight_kg,escape_attempts,neutered) VALUES 
('Pikachu', '7-01-2021', 15.04, 1,flase);

INSERT INTO animals (name,date_of_birth,weight_kg,escape_attempts,neutered) VALUES 
('Davimon', '12-05-2017', 11, 2,true);



/** add new vet data  */
INSERT INTO animals (name,date_of_birth,weight_kg,escape_attempts,neutered) VALUES 
('Charmander', '08-02-2020', -11, 0,false);


INSERT INTO animals (name,date_of_birth,weight_kg,escape_attempts,neutered) VALUES 
('Plantmon', '15-11-2021', -5.7, 2,true);

INSERT INTO animals (name,date_of_birth,weight_kg,escape_attempts,neutered) VALUES 
('Squirtle', '02-04-1993', -12.13, 3, false);


INSERT INTO animals (name,date_of_birth,weight_kg,escape_attempts,neutered) VALUES 
('Angemon', '12-06-2005', -45, 1, true);

INSERT INTO animals (name,date_of_birth,weight_kg,escape_attempts,neutered) VALUES 
('Boarmon', '07-06-2005', 20.4, 7, true);

INSERT INTO animals (name,date_of_birth,weight_kg,escape_attempts,neutered) VALUES 
('Blossom', '13-10-1998', 17, 3, true);

INSERT INTO animals (name,date_of_birth,weight_kg,escape_attempts,neutered) VALUES 
('Ditto', '14-05-2022', 22, 4, true);
/** end  */



/* ###   query multiple table project*/


/** insert data  of owners*/
INSERT INTO owners (full_name, age) VALUES ('Sam Smith',34),('Jennifer Orwell',19),
('Bob', 45),('Melody Pond',77),('Dean Winchester',14),('Jodie Whittaker',38);


/** insert data of species */
INSERT INTO species (name) VALUES (' Pokemon'),('  Digimon');

/** updtae animals table species column   set it to 2 where animals name end with mon */

 UPDATE animals SET species_id =2 WHERE name LIKE '%mon';
/** updtae animals table species column   set it to 1 where animals species id equal null */
 UPDATE animals SET species_id  =1
 WHERE species_id IS NULL;

 /** update animals add owners information **/
  /** Sam Smith own Agumon */

UPDATE animals SET owner_id = 1 WHERE name = 'Agumon'; --  Sam Smith id is 1
/**Jennifer Orwell owns Gabumon and Pikachu. */
UPDATE animals SET owner_id = 2 WHERE name = 'Gabumon' OR name = 'Pikachu';
/** Bob owns Devimon and Plantmon. */
UPDATE animals SET owner_id = 3 WHERE name = 'Devimon'OR name = 'Plantmon'

/** Melody Pond owns Charmander, Squirtle, and Blossom. */
UPDATE animals SET owner_id = 4 WHERE name = 'Charmander' 
OR name = 'Squirtle' OR name = 'Blossom';
/** Dean Winchester owns Angemon and Boarmon.*/
UPDATE animals SET owner_id = 5 WHERE name = 'Angemon' OR name = 'Boarmon';


/* ###  query multiple table project end */

/** ## Many to many relationship start */


/* -- insert vets data */
INSERT INTO vets(name,age,date_of_graduation) VALUES('William Tatcher',45,'23-04-2000'),
('Maisy Smith',26,'17-01-2019'),
('Stephanie Mendez',64,'04-05-1981'),('Jack Harkness',38,'08-06-2008');

 /* -- iinsert specialization data */
 INSERT INTO specializations(vet_id,species_id)
VALUES (1,1),(3,1),(3,2),(4,2);
