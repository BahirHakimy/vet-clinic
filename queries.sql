SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT * FROM animals WHERE neutered=true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pikachu';
SELECT name,escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE NOT name='Gabumon';
SELECT * from animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;
UPDATE animals SET species='unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species='digimon'
WHERE name LIKE '%mon';
UPDATE animals SET species='pokemon'
WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals 
WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SP1;
UPDATE animals SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals
WHERE escape_attempts=0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, MAX(escape_attempts) FROM animals
GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals
GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01'
GROUP BY species;

-- What animals belong to Melody Pond?
SELECT name, full_name as owner FROM animals
JOIN owners 
ON animals.owner_id = owners.id 
WHERE full_name='Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT A.name as pokemon, S.name as type
FROM animals A JOIN species S
ON A.species_id = S.id
WHERE S.name='Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT full_name, name as animle 
FROM owners O LEFT JOIN animals A
ON O.id = A.owner_id;

-- How many animals are there per species?
SELECT S.name AS type,
Count(*) AS animals_count 
FROM animals A JOIN species S
ON A.species_id = S.id
GROUP BY S.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT A.name as pokemon,
full_name as owner, S.name AS species
FROM animals A JOIN owners O
ON A.owner_id = O.id 
JOIN species S 
ON S.id = A.species_id
WHERE S.name = 'Digimon' 
AND full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT A.name as pokemon,
full_name as owner, escape_attempts
FROM animals A JOIN owners O
ON A.owner_id = O.id 
WHERE A.escape_attempts = 0 
AND O.full_name = 'Dean Winchester';

-- Who owns the most animals?
SELECT full_name, COUNT(*) AS animals_owned
FROM animals A JOIN owners O
ON A.owner_id = O.id
GROUP BY O.full_name
ORDER BY animals_owned DESC;