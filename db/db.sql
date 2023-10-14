CREATE DATABASE micro_lecturi;
USE micro_lecturi;

CREATE TABLE `user` (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `email` VARCHAR(255) NOT NULL UNIQUE,
    `enabled` BOOLEAN NOT NULL
);

CREATE TABLE `user_verification` (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `id_user` INT NOT NULL,
    `token` VARCHAR(255) NOT NULL UNIQUE,
    `active_date` DATETIME NOT NULL,
    FOREIGN KEY (`id_user`) REFERENCES `user`(`id`)
);

CREATE TABLE `lecture_category` (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE `lecture` (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(255) NOT NULL,
    `author` VARCHAR(255) NOT NULL,
    `chunks` INT NOT NULL,
    `id_category` INT NOT NULL,
    FOREIGN KEY (`id_category`) REFERENCES `lecture_category`(`id`)
);

CREATE TABLE `subscription` (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `id_user` INT NOT NULL,
    `id_lecture` INT NOT NULL,
    `start_date` DATETIME NOT NULL,
    `current_chunk` INT NOT NULL,
    `is_active` BOOLEAN NOT NULL,
    FOREIGN KEY (`id_user`) REFERENCES `user`(`id`),
    FOREIGN KEY (`id_lecture`) REFERENCES `lecture`(`id`)
);

INSERT INTO `lecture_category` (`name`) VALUES
    ('Epic'),
    ('Liric'),
    ('Dramă'),
    ('Populare');

INSERT INTO `lecture` (`title`, `author`, `chunks`, `id_category`) VALUES 
    -- Epic
    ('Ion', 'Liviu Rebreanu', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Epic')),
    ('Ultima noapte de dragoste, întâia noapte de război', 'Camil Petrescu', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Epic')),
    ('Moromeții (vol. 1)', 'Marin Preda', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Epic')),
    ('Harap-Alb', 'Ion Creangă', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Epic')),
    ('Moara cu noroc', 'Ioan Slavici', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Epic')),
    ('Enigma Otiliei', 'George Călinescu', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Epic')),
    ('Baltagul', 'Mihail Sadoveanu', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Epic')),
    
    -- Liric
    ('Luceafărul', 'Mihai Eminescu', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Liric')),
    ('Scrisoarea I', 'Mihai Eminescu', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Liric')),
    ('Scrisoarea III', 'Mihai Eminescu', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Liric')),
    ('Dorință', 'Mihai Eminescu', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Liric')),
    ('Floare albastră', 'Mihai Eminescu', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Liric')),
    ('Mai am un singur dor', 'Mihai Eminescu', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Liric')),
    ('Testament', 'Tudor Arghezi', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Liric')),
    ('Flori de mucigai', 'Tudor Arghezi', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Liric')),
    ('Silentio', 'Tudor Arghezi', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Liric')),
    ('Cuvânt', 'Tudor Arghezi', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Liric')),
    ('Eu nu strivesc corola de minuni a lumii', 'Lucian Blaga', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Liric')),
    ('În grădina Ghetsemani', 'Lucian Blaga', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Liric')),
    ('La tiganci', 'Lucian Blaga', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Liric')),
    ('O viziune a sentimentelor', 'Nichita Stănescu', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Liric')),
    ('Emoție de toamnă', 'Nichita Stănescu', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Liric')),
    ('Leoaică tânără, iubirea...', 'Nichita Stănescu', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Liric')),
    ('Viziunea viziunii', 'Nichita Stănescu', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Liric')),
    
    -- Dramă
    ('O scrisoare pierdută', 'I.L. Caragiale', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Dramă')),
    ('Riga Crypto și lapona Enigel', 'Ion Barbu', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Dramă')),
    ('Oedip rege', 'Sofocle', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Dramă')),
    ('A douasprezecea noapte sau Cum vă place', 'William Shakespeare', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Dramă')),
    
    -- Populare
    ('Basme (alese)', 'Ion Creangă', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Populare')),
    ('Amintiri din copilărie', 'Ion Creangă', 30, (SELECT `id` FROM `lecture_category` WHERE `name` = 'Populare'));
