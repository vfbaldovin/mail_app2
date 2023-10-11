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

CREATE TABLE `lecture` (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(255) NOT NULL,
    `chunks` TEXT NOT NULL
);

CREATE TABLE `subscription` (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `id_user` INT NOT NULL,
    `id_lecture` INT NOT NULL,
    `start_date` DATETIME NOT NULL,
    `current_chunk` TEXT NOT NULL,
    `is_active` BOOLEAN NOT NULL,
    FOREIGN KEY (`id_user`) REFERENCES `user`(`id`),
    FOREIGN KEY (`id_lecture`) REFERENCES `lecture`(`id`)
);
