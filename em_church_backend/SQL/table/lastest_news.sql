CREATE TABLE `EM_Church`.`lastest_news` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DateTime NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `created_by` INT NOT NULL,
  `created_at` DateTime NOT NULL,
  PRIMARY KEY (`id`)
);