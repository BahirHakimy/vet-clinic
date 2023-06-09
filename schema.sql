/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet-clinic;

CREATE TABLE animals (
    id INT GENERATED BY DEFAULT AS IDENTITY,
    name VARCHAR(155),
    date_of_birth date,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL(10,2)
);

ALTER TABLE animals ADD COLUMN species VARCHAR(55);

CREATE TABLE IF NOT EXISTS owners(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(155),
    age INT
);

CREATE TABLE IF NOT EXISTS species(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(55)
);

ALTER TABLE animals ADD CONSTRAINT pk_animals 
    PRIMARY KEY (id);
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_species
    FOREIGN KEY (species_id) REFERENCES species(id)
    ON DELETE SET NULL;
ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_owner 
    FOREIGN KEY (owner_id) REFERENCES owners(id)
    ON DELETE SET NULL;

CREATE TABLE IF NOT EXISTS vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(55),
    age INT,
    date_of_graduation DATE
);

CREATE TABLE IF NOT EXISTS specializations(
    species_id INT REFERENCES species(id),
    vet_id INT REFERENCES vets(id),
    PRIMARY KEY (species_id, vet_id)
);

CREATE TABLE IF NOT EXISTS visits(
    animal_id INT REFERENCES animals(id),
    vet_id INT REFERENCES vets(id),
    date_of_visit DATE,
    PRIMARY KEY (animal_id, vet_id, date_of_visit)
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);
ALTER TABLE visits DROP CONSTRAINT visits_pkey;
ALTER TABLE visits ADD COLUMN id SERIAL PRIMARY KEY;

CREATE INDEX visits_idx ON visits(animal_id);
CREATE INDEX visits_index ON visits(vet_id);
CREATE INDEX idx_owners_email ON owners(email);