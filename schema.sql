/* Database schema to keep the structure of entire database. */
CREATE TABLE animals(
 id INT,
 name VARCHAR(40),
	date_of_birth DATE,
	escape_attempts INT,
	neutered BOOLEAN, 
	weight_kg Decimal,
	PRIMARY KEY (id)
);

ALTER TABLE animals ADD species VARCHAR(45);


/** create owners table */
CREATE TABLE owners (id INT GENERATED ALWAYS AS IDENTITY,
					full_name VARCHAR(255) NOT NULL,age INT,
                    CONSTRAINT pk_owners PRIMARY KEY(id)
					)


/** create species table */
CREATE TABLE species (id INT GENERATED ALWAYS AS IDENTITY,
					 name VARCHAR(45), CONSTRAINT pk_species PRIMARY KEY(id))