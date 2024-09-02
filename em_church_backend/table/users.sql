CREATE TABLE `EM_Church`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `prefer_name` VARCHAR(50) NULL,
  `sure_name` VARCHAR(50) NULL,
  `last_name` VARCHAR(50) NULL,
  `tel` VARCHAR(50) NULL,
  `is_admin` BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY (`id`)
);