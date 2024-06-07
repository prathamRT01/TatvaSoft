-- Table: country
CREATE TABLE country (
    id SERIAL PRIMARY KEY,
    countryName VARCHAR(255) NOT NULL
);

-- Table: city
CREATE TABLE city (
    id SERIAL PRIMARY KEY,
    countryId INTEGER NOT NULL REFERENCES country(id),
    cityName VARCHAR(255) NOT NULL
);

-- Table: missionSkill
CREATE TABLE missionSkill (
    id SERIAL PRIMARY KEY,
    skillName VARCHAR(255) NOT NULL,
    status VARCHAR(255) NOT NULL
);

-- Table: missionTheme
CREATE TABLE missionTheme (
    id SERIAL PRIMARY KEY,
    themeName VARCHAR(255) NOT NULL,
    status VARCHAR(255) NOT NULL
);

-- Table: mission
CREATE TABLE mission (
    id SERIAL PRIMARY KEY,
    missionTitle VARCHAR(255) NOT NULL,
    missionDescription TEXT,
    missionOrganisationName VARCHAR(255),
    missionOrganisationDetail TEXT,
    countryId INTEGER REFERENCES country(id),
    cityId INTEGER REFERENCES city(id),
    startDate DATE DEFAULT CURRENT_DATE, -- Default to current date
    endDate DATE,
    missionType VARCHAR(255),
    totalSheets INTEGER,
    registrationDeadline DATE,
    missionThemeId INTEGER REFERENCES missionTheme(id),
    missionSkillId INTEGER REFERENCES missionSkill(id),
    missionImages TEXT[],                   --[]?
    missionDocuments TEXT[],                --[]?
    missionAvailability VARCHAR(255),
    missionVideoUrl VARCHAR(255)
);

-- Table: "user"
CREATE TABLE "user" (
    id SERIAL PRIMARY KEY,
    firstName VARCHAR(255) NOT NULL,
    lastName VARCHAR(255) NOT NULL,
    phoneNumber VARCHAR(20),
    emailAddress VARCHAR(255) UNIQUE NOT NULL,
    userType VARCHAR(50) NOT NULL DEFAULT 'user',
    password VARCHAR(255) NOT NULL
);

-- Table: missionApplication
CREATE TABLE missionApplication (
    id SERIAL PRIMARY KEY,
    missionId INTEGER NOT NULL REFERENCES mission(id),
    userId INTEGER NOT NULL REFERENCES "user"(id),
    appliedDate timestamp with time zone DEFAULT now() NOT NULL, -- Default to current timestamp
    status BOOLEAN NOT NULL,
    sheet INTEGER NOT NULL
);

-- Table: userDetail
CREATE TABLE userDetail (
    id SERIAL PRIMARY KEY,
    userId INTEGER NOT NULL REFERENCES "user"(id),
    name VARCHAR(255),
    surname VARCHAR(255),
    employeeId VARCHAR(50),
    manager VARCHAR(255),
    title VARCHAR(255),
    department VARCHAR(255),
    myProfile TEXT,
    whyIVolunteer TEXT,
    countryId INTEGER REFERENCES country(id),
    cityId INTEGER REFERENCES city(id),
    availability VARCHAR(255),
    linkedInUrl VARCHAR(255),
    mySkills VARCHAR(255), --[]?
    userImage TEXT,        --[]?
    status BOOLEAN DEFAULT TRUE -- Default to true (active)
);

-- Table: userSkill
CREATE TABLE userSkill (
    id SERIAL PRIMARY KEY,
    skill VARCHAR(255) NOT NULL,
    userId INTEGER NOT NULL REFERENCES "user"(id)
);







-- Insert data into country table
INSERT INTO country (countryName) VALUES
	('India'),
    ('United States'),
    ('United Kingdom');
SELECT * FROM country

-- Insert data into city table
INSERT INTO city (countryId, cityName) VALUES
	(1, 'Ahmedabad'),
    (1, 'Gandhinagar'),
    (2, 'New York'),
    (2, 'Los Angeles'),
    (3, 'London'),
    (3, 'Manchester');

-- Insert data into missionSkill table
INSERT INTO missionSkill (skillName, status) VALUES
    ('Leadership', 'Active'),
    ('Communication', 'Active'),
    ('Problem Solving', 'Active');

-- Insert data into missionTheme table
INSERT INTO missionTheme (themeName, status) VALUES
    ('Community Service', 'Active'),
    ('Education', 'Active'),
    ('Environmental Conservation', 'Active');

-- Insert data into mission table
INSERT INTO mission (missionTitle, missionDescription, missionOrganisationName, missionOrganisationDetail, countryId, cityId, endDate, missionType, totalSheets, registrationDeadline, missionThemeId, missionSkillId, missionImages, missionDocuments, missionAvailability, missionVideoUrl) VALUES
    ('Clean Up Campaign', 'Clean up campaign for a cleaner environment', 'Green Earth Organization', 'We aim to clean up public spaces and raise awareness about environmental conservation', 1, 2, '2024-06-30', 'Community Service', 100, '2024-06-15', 3, 1, ARRAY['https://www.w3schools.com/howto/img_avatar.png', 'https://www.w3schools.com/howto/img_avatar.png'], ARRAY['https://www.clickdimensions.com/links/TestPDFfile.pdf'], 'Open to all volunteers', 'https://example.com/video1'),
    ('Teaching Program', 'Education program for underprivileged children', 'Education for All', 'We provide free education to children from low-income families', 2, 3, '2024-08-15', 'Education', 200, '2024-07-30', 2, 2, ARRAY['https://www.w3schools.com/howto/img_avatar.png', 'https://www.w3schools.com/howto/img_avatar.png'], ARRAY['https://www.clickdimensions.com/links/TestPDFfile.pdf', 'https://www.clickdimensions.com/links/TestPDFfile.pdf'], 'Volunteers with teaching experience preferred', 'https://example.com/video2');

-- Insert data into "user" table
INSERT INTO "user" (firstName, lastName, phoneNumber, emailAddress, userType, password) VALUES
    ('pratham', 'thakkar', '+918460218196', 'prathamthakkar@gmail.com', 'admin', 'admin123'),
    ('John', 'Smith', '+19876543210', 'johnsmith@gmail.com', 'user', 'user123');

-- Insert data into missionApplication table
INSERT INTO missionApplication (missionId, userId, status, sheet) VALUES
    (1, 2, true, 1),
    (2, 2, true, 2);

-- Insert data into userDetail table
INSERT INTO userDetail (userId, name, surname, employeeId, manager, title, department, myProfile, whyIVolunteer, countryId, cityId, availability, linkedInUrl, mySkills, userImage, status) VALUES
    (1, 'pratham', 'thakkar', 'EMP001', 'Jane Manager', 'Senior Manager', 'Administration', 'Experienced manager with a passion for community service', 'I believe in giving back to the community and making a positive impact', 1, 1, 'Available on weekends', 'https://linkedin.com/prathamthakkar0306', 'Leadership, Communication', 'https://www.w3schools.com/howto/img_avatar.png', true),
    (2, 'John', 'Smith', 'EMP002', 'pratham Manager', 'Volunteer Teacher', 'Education', 'Passionate about teaching and helping children in need', 'I want to contribute to providing education for all children, regardless of their background', 2, 3, 'Available on weekdays', 'https://linkedin.com/alice_smith', 'Teaching, Communication', 'https://www.w3schools.com/howto/img_avatar.png', true);

-- Insert data into userSkill table
INSERT INTO userSkill (skill, userId) VALUES
    ('Leadership', 1),
    ('Communication', 1),
    ('Teaching', 2),
    ('Communication', 2);











SELECT * FROM city;

SELECT * FROM country;

SELECT * FROM mission;

SELECT * FROM missionApplication;

SELECT * FROM missionSkill;

SELECT * FROM missionTheme;

SELECT * FROM "user";

SELECT * FROM userDetail;

SELECT * FROM userSkill;

SELECT * FROM "user" JOIN userSkill ON "user".id = userSkill.userId;

SELECT missionTitle,countryName FROM mission as m JOIN country as c ON c.id=m.countryId

SELECT * from mission
where cityId IN (select id from city where cityName='Gandhinagar')





		
INSERT INTO "user" (firstName, lastName, phoneNumber, emailAddress, userType, password) VALUES
    ('Deep', 'Parekh', '+918460218196', 'deepparekh@gmail.com', 'user', 'user123');

SELECT * FROM "user" LEFT JOIN userSkiLl
			ON "user".id=userSkill.userId
			
SELECT * FROM "user"




