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
/** make id auto incremated  */
		 
ALTER  TABLE animals ALTER COLUMN id SET  GENERATED BY DEFAULT;	

/** drop species column */
ALTER TABLE animals DROP COLUMN species; 

/** add species_id foreign key */
ALTER TABLE animals ADD species_id INT, 
ADD CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id);

/** add owner_id foreign key */
ALTER TABLE animals ADD owner_id INT, 
ADD CONSTRAINT fk_owners FOREIGN KEY(owner_id) REFERENCES owners(id);