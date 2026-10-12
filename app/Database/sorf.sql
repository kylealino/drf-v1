-- =====================================================================
-- SORF - Special Order Request Form
-- Import into the `sorf` database:
--   mysql -uroot sorf < app/Database/sorf.sql
-- Safe to re-run: tables are only created when missing and the
-- reference rows are only seeded into empty tables.
-- =====================================================================

CREATE DATABASE IF NOT EXISTS `sorf` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `sorf`;
SET NAMES utf8mb4;

-- ---------------------------------------------------------------------
-- Users + roles
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tbl_roles` (
  `recid` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) NOT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  `is_active` int(11) NOT NULL DEFAULT 1,
  `added_by` varchar(50) NOT NULL,
  `added_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`recid`),
  UNIQUE KEY `uq_tbl_roles_role_name` (`role_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- role ids are fixed: Config\RequestForms::ROLE_REQUESTER / ROLE_HR
INSERT IGNORE INTO `tbl_roles` (`recid`, `role_name`, `description`, `added_by`) VALUES
(1, 'Requester', 'Files special order requests and follows their status', 'SYSTEM'),
(2, 'HR Personnel', 'Receives every request, asks for requirements and grants or denies it', 'SYSTEM');

CREATE TABLE IF NOT EXISTS `myua_user` (
  `recid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `hash_password` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `division` varchar(20) NOT NULL DEFAULT '',
  `section` varchar(20) NOT NULL DEFAULT '',
  `position` varchar(100) NOT NULL DEFAULT '',
  `role_id` int(11) NOT NULL DEFAULT 1,
  `added_at` datetime NOT NULL DEFAULT current_timestamp(),
  `added_by` varchar(50) NOT NULL,
  `is_active` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`recid`),
  UNIQUE KEY `uq_myua_user_username` (`username`),
  KEY `fk_myua_user_role` (`role_id`),
  CONSTRAINT `fk_myua_user_role` FOREIGN KEY (`role_id`) REFERENCES `tbl_roles` (`recid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- HR account: hr-personnel / 123456 (hash_password is PHP password_hash())
INSERT IGNORE INTO `myua_user` (`username`, `hash_password`, `full_name`, `division`, `section`, `position`, `role_id`, `added_by`) VALUES
('hr-personnel', '$2y$10$7Qksz3Gd23ZNQRCMzw1ruuBGUttgTl04.VqscHnHyEOicWkgBoFG2', 'HR Personnel', 'FAD', 'HRMS', 'Human Resource Management Section', 2, 'SYSTEM');

-- ---------------------------------------------------------------------
-- Reference lists (from the Special Order Request Form workbook)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tbl_division` (
  `recid` int(11) NOT NULL AUTO_INCREMENT,
  `division_id` varchar(20) NOT NULL,
  `division_name` varchar(150) NOT NULL,
  `added_at` datetime NOT NULL DEFAULT current_timestamp(),
  `added_by` varchar(50) NOT NULL,
  `is_active` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`recid`),
  UNIQUE KEY `uq_tbl_division_id` (`division_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `tbl_division` (`division_id`, `division_name`, `added_by`)
SELECT * FROM (
  SELECT 'OD/ODD' a, 'Office of the Director' b, 'SYSTEM' c UNION ALL
  SELECT 'NFRDD', 'Nutrition and Food Research and Development Division', 'SYSTEM' UNION ALL
  SELECT 'NAMD', 'Nutrition Assessment and Monitoring Division', 'SYSTEM' UNION ALL
  SELECT 'TDSTSD', 'Technology Diffusion and S&T Services Division', 'SYSTEM' UNION ALL
  SELECT 'FAD', 'Finance and Administrative Division', 'SYSTEM' UNION ALL
  SELECT 'SLG', 'Service Laboratory Group', 'SYSTEM'
) seed WHERE NOT EXISTS (SELECT 1 FROM `tbl_division`);

CREATE TABLE IF NOT EXISTS `tbl_section` (
  `recid` int(11) NOT NULL AUTO_INCREMENT,
  `division_id` varchar(20) NOT NULL,
  `section_id` varchar(20) NOT NULL,
  `section_name` varchar(150) NOT NULL,
  `added_at` datetime NOT NULL DEFAULT current_timestamp(),
  `added_by` varchar(50) NOT NULL,
  `is_active` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`recid`),
  UNIQUE KEY `uq_tbl_section_id` (`division_id`, `section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `tbl_section` (`division_id`, `section_id`, `section_name`, `added_by`)
SELECT * FROM (
  SELECT 'OD/ODD' a, 'OD/ODD' b, 'Office Of The Director / Office Of The Deputy Director' c, 'SYSTEM' d UNION ALL
  SELECT 'OD/ODD', 'MIS', 'Management Information System', 'SYSTEM' UNION ALL
  SELECT 'OD/ODD', 'PEU', 'Planning And Evaluation Unit', 'SYSTEM' UNION ALL
  SELECT 'NFRDD', 'FRDG', 'Food Research and Development Group', 'SYSTEM' UNION ALL
  SELECT 'NFRDD', 'FRDS', 'Nutrition And Food Research and Development Section', 'SYSTEM' UNION ALL
  SELECT 'NFRDD', 'FQSS', 'Food Quality And Safety Section', 'SYSTEM' UNION ALL
  SELECT 'NFRDD', 'NRDG', 'Nutrition Research and Development Group', 'SYSTEM' UNION ALL
  SELECT 'NFRDD', 'LNS', 'Lifestage Nutrition Section', 'SYSTEM' UNION ALL
  SELECT 'NFRDD', 'NBS', 'Nutritional Biochemistry Section', 'SYSTEM' UNION ALL
  SELECT 'NAMD', 'NAS', 'Nutritional Assessment Section', 'SYSTEM' UNION ALL
  SELECT 'NAMD', 'NIEPS', 'Nutrition Intervention, Evaluation And Policy Section', 'SYSTEM' UNION ALL
  SELECT 'NAMD', 'NSIS', 'Nutrition Statistics & Informatics Section', 'SYSTEM' UNION ALL
  SELECT 'TDSTSD', 'TTCS', 'Technology Transfer And Commercialization Section', 'SYSTEM' UNION ALL
  SELECT 'TDSTSD', 'KDS', 'Knowledge Diffusion Section', 'SYSTEM' UNION ALL
  SELECT 'FAD', 'HRMS', 'Human Resource Management Section', 'SYSTEM' UNION ALL
  SELECT 'FAD', 'BS', 'Budget Section', 'SYSTEM' UNION ALL
  SELECT 'FAD', 'AS', 'Accounting Section', 'SYSTEM' UNION ALL
  SELECT 'FAD', 'CDS', 'Collection And Disbursement Section', 'SYSTEM' UNION ALL
  SELECT 'FAD', 'PS', 'Property Section', 'SYSTEM' UNION ALL
  SELECT 'FAD', 'MS', 'Maintenance Section', 'SYSTEM' UNION ALL
  SELECT 'FAD', 'RMU', 'Records Management Unit', 'SYSTEM' UNION ALL
  SELECT 'SLG', 'BIO', 'Biochemical Laboratory', 'SYSTEM' UNION ALL
  SELECT 'SLG', 'CHE', 'Chemical Laboratory', 'SYSTEM' UNION ALL
  SELECT 'SLG', 'MIC', 'Microbiological Laboratory', 'SYSTEM' UNION ALL
  SELECT 'SLG', 'PTL', 'Proficiency Testing Lab', 'SYSTEM'
) seed WHERE NOT EXISTS (SELECT 1 FROM `tbl_section`);

-- The form each document type prints is set in app/Config/RequestForms.php
CREATE TABLE IF NOT EXISTS `tbl_document_type` (
  `recid` int(11) NOT NULL AUTO_INCREMENT,
  `document_id` varchar(10) NOT NULL,
  `document_type` varchar(150) NOT NULL,
  `added_at` datetime NOT NULL DEFAULT current_timestamp(),
  `added_by` varchar(50) NOT NULL,
  `is_active` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`recid`),
  UNIQUE KEY `uq_tbl_document_type_id` (`document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `tbl_document_type` (`document_id`, `document_type`, `added_by`)
SELECT * FROM (
  SELECT 'SO01' a, 'Authority to Receive Incentive/Honorarium (ATRH)' b, 'SYSTEM' c UNION ALL
  SELECT 'SO02', 'General Special Order (GSO)', 'SYSTEM' UNION ALL
  SELECT 'SO03', 'Special Disbursing Officer (SDO)', 'SYSTEM' UNION ALL
  SELECT 'SO04', 'Petty Cash Fund Custodian (PCFC)', 'SYSTEM' UNION ALL
  SELECT 'SO05', 'Authority to Attend Activity (ATAA)', 'SYSTEM' UNION ALL
  SELECT 'SO06', 'Local Travel Order (LTO)', 'SYSTEM' UNION ALL
  SELECT 'SO07', 'Project Team Composition (PTC)', 'SYSTEM'
) seed WHERE NOT EXISTS (SELECT 1 FROM `tbl_document_type`);

-- Permanent staff: name + position suggestions while filling a request
CREATE TABLE IF NOT EXISTS `tbl_employee` (
  `recid` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) NOT NULL,
  `position` varchar(100) NOT NULL DEFAULT '',
  `added_at` datetime NOT NULL DEFAULT current_timestamp(),
  `added_by` varchar(50) NOT NULL,
  `is_active` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`recid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `tbl_employee` (`full_name`, `position`, `added_by`)
SELECT seed.a, seed.b, 'SYSTEM' FROM (
  SELECT 'NACIS, JACUS S.' a, 'Director IV' b UNION ALL
  SELECT 'RAZ, LUCIEDEN G.', 'Director III' UNION ALL
  SELECT 'AGUILA, DIVORAH V.', 'Planning Officer IV' UNION ALL
  SELECT 'AGUILOS, MARILITA A.', 'Planning Officer III' UNION ALL
  SELECT 'MOE, MYRNA F.', 'Planning Officer II' UNION ALL
  SELECT 'MONTERO, PATREEN E.', 'Admin Assistant III' UNION ALL
  SELECT 'BESMONTE, ROCHELLE', 'Administrative Aide IV' UNION ALL
  SELECT 'ORTIZ, ALEXIS M.', 'Chief Admin Officer' UNION ALL
  SELECT 'VIRIÑA, JESTER C.', 'Supervising Adm Officer' UNION ALL
  SELECT 'CAJANO, BONJOBIE F.', 'Accountant III' UNION ALL
  SELECT 'AGABAN, JEZIEL M.', 'Administrative Officer V' UNION ALL
  SELECT 'LLAMAS, ROMANA L.', 'Administrative Officer V' UNION ALL
  SELECT 'MEDINA, JOVY S.', 'Administrative Officer V' UNION ALL
  SELECT 'ESTRELLA, REMEA V.', 'Administrative Officer V' UNION ALL
  SELECT 'BALITAON, MARLON O.', 'Administrative Officer V' UNION ALL
  SELECT 'LUCENA, JAMES C.', 'Accountant II' UNION ALL
  SELECT 'VILLANUEVA, MILDRED D.', 'Administrative Officer IV' UNION ALL
  SELECT 'BARRIENTOS, HONEYGRACE B.', 'Administrative Officer IV' UNION ALL
  SELECT 'BALLESTER, HAROLD JONATHAN D.', 'Administrative Officer III' UNION ALL
  SELECT 'HUELAR, LUCILA C.', 'Administrative Officer II' UNION ALL
  SELECT 'CARIZO, MA. FE A.', 'Administrative Officer II' UNION ALL
  SELECT 'MERCADO, JULIET C.', 'Administrative Officer II' UNION ALL
  SELECT 'CUATERNO, LETICIA H.', 'Administrative Officer I' UNION ALL
  SELECT 'CARANTO, MARY JOYCE M.', 'Admin Assistant III' UNION ALL
  SELECT 'BASILIO, ROSE ANN Q.', 'Admin Assistant II' UNION ALL
  SELECT 'MARAVILLAS, IDA MAE O.', 'Admin Assistant II' UNION ALL
  SELECT 'BANTA, SOFIA B.', 'Admin Assistant I' UNION ALL
  SELECT 'JAIME, JOYCE MARIE A.', 'Administrative Aide VI' UNION ALL
  SELECT 'AGUILAR, RIVA PHILLINE', 'Administrative Aide VI' UNION ALL
  SELECT 'ULVIDA, MARVIN B.', 'Administrative Aide VI' UNION ALL
  SELECT 'RECALDE, MARIA CELINE E.', 'Administrative Aide VI' UNION ALL
  SELECT 'DAQUIOAG, JENINA P.', 'Administrative Aide IV' UNION ALL
  SELECT 'ABLITADO, KYLA JOY M.', 'Administrative Aide IV' UNION ALL
  SELECT 'LLEGADO, ARMILDA A.', 'Administrative Aide IV' UNION ALL
  SELECT 'AGUILAR, DARLENE D.', 'Administrative Aide IV' UNION ALL
  SELECT 'BIÑAS, GLENN B.', 'Administrative Aide III' UNION ALL
  SELECT 'DUMAG, ROSEMARIE J.', 'Chief Science Research Specialist' UNION ALL
  SELECT 'NACIONALES, KRISTINE B.', 'Supervising Science Research Specialist' UNION ALL
  SELECT 'SERAFICO, MICHAEL E.', 'Supervising Science Research Specialist' UNION ALL
  SELECT 'DAJAY, LEAH C.', 'Supervising Science Research Specialist' UNION ALL
  SELECT 'MADRID, MARILOU L.', 'Supervising Science Research Specialist' UNION ALL
  SELECT 'CABANILLA, CARL VINCENT D.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'GIRONELLA, MAY ANN D.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'PALOMO, ALEX M', 'Senior Science Research Specialist' UNION ALL
  SELECT 'TAN, ROBBY CARLO A.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'GUBAT, MARIA JULIA G.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'PADRONES, ABBIE L.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'RAMAS, VANNIZSA I.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'GULAY, JOANNE JETTE S.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'FRANE, RUBY D.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'BAQUIRAN, AMSTER FEI P.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'RAMIREZ, EUGENIO M.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'GUILARAN, ROSE ELAINE P.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'GUILARAN, JOHANNE B.', 'Science Research Specialist I' UNION ALL
  SELECT 'APOR, AVEGAIL D.', 'Science Research Specialist I' UNION ALL
  SELECT 'EWAYAN, CHRISTINE JOY B.', 'Science Research Specialist I' UNION ALL
  SELECT 'LABRADOR, JASON PAOLO H.', 'Science Research Specialist I' UNION ALL
  SELECT 'ZUMARAGA, MARK PRETZEL P.', 'Science Research Specialist I' UNION ALL
  SELECT 'CUMAGUN, MA. LOURDES T.', 'Science Research Specialist I' UNION ALL
  SELECT 'DECENA, MAJA BETHZAIDA S.', 'Science Research Specialist I' UNION ALL
  SELECT 'JACALAN, FRANCES ISABELLE B.', 'Science Research Specialist I' UNION ALL
  SELECT 'DIÑO, ALLEN JASPER D.', 'Science Research Specialist I' UNION ALL
  SELECT 'SEVILLA, CHRISTINE EDEN C.', 'Science Research Specialist I' UNION ALL
  SELECT 'ALBAO, MARICAR D.', 'Science Research Specialist I' UNION ALL
  SELECT 'ALIBAYAN, MARITES V.', 'Science Research Specialist I' UNION ALL
  SELECT 'LICAYAN, JOSAFAT JOHN SIMON L.', 'Science Research Specialist I' UNION ALL
  SELECT 'VILLAPAZ, ROGEL L.', 'Science Research Specialist I' UNION ALL
  SELECT 'ISLA, FAITH CHALICE M.', 'Science Research Specialist I' UNION ALL
  SELECT 'DAVID, ALEXANDRA LYNE E.', 'Science Research Specialist' UNION ALL
  SELECT 'AFUANG, ALDRIN PAUL S.', 'Science Research Specialist' UNION ALL
  SELECT 'ARNEJO, EIRENE AGUSTIN B.', 'Science Research Specialist' UNION ALL
  SELECT 'LAUREA, JENNIFER C.', 'Science Research Specialist' UNION ALL
  SELECT 'EDER, JANEL ANNE C.', 'Science Research Specialist' UNION ALL
  SELECT 'SABINO, MA. JUSTINE CAMILLE S.', 'Science Research Specialist' UNION ALL
  SELECT 'SANTOS, TRINA MAE B.', 'Science Research Specialist' UNION ALL
  SELECT 'VERGARA, MICHA ELLA C.', 'Science Research Specialist' UNION ALL
  SELECT 'DALISAY, ALLAIN LOUISE P.', 'Science Research Specialist' UNION ALL
  SELECT 'ESPULGAR, JEFF MC ROWEN A.', 'Science Research Specialist' UNION ALL
  SELECT 'TAMPIL, GYLE D.', 'Science Research Specialist' UNION ALL
  SELECT 'SUMERA, CYRHO T.', 'Science Research Analyst' UNION ALL
  SELECT 'SOLIS, DANNIELINE M.', 'Science Research Analyst' UNION ALL
  SELECT 'REYES, ANA MAXIMINA C.', 'Science Research Analyst' UNION ALL
  SELECT 'ROSALES, RUVY ANN O.', 'Science Research Analyst' UNION ALL
  SELECT 'PARCAREY, MARICAR GIEL Y.', 'Science Research Asst' UNION ALL
  SELECT 'ABALOS, MA. MIKKAELLA C.', 'Science Aide' UNION ALL
  SELECT 'LALA, JUNIMER B.', 'Science Aide' UNION ALL
  SELECT 'PILARIZA, MARIA HELEN FORTUNA R.', 'Science Aide' UNION ALL
  SELECT 'GUIRINDOLA, MILDRED O.', 'Chief Science Research Specialist & Scientist I' UNION ALL
  SELECT 'DASCO, MA. LILIBETH P.', 'Supervising Science Research Specialist' UNION ALL
  SELECT 'PATALEN, CHONA F.', 'Supervising Science Research Specialist' UNION ALL
  SELECT 'GOYENA, EVA A.', 'Supervising Science Research Specialist & Scientist I' UNION ALL
  SELECT 'GIRONELLA, GLEN MELVIN P.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'ARIAS, FRANCES POLA S.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'AZANA, GLENDA P.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'MANIEGO, MA. LYNELL V.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'DESNACIDO, JOSIE P.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'JAVIER, MAE ANN SA.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'PARANI, MARIA STEPHANIE N.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'VIAJAR, ROWENA V.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'BUGAS, MARIE T.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'JAVIER, CHARINA A.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'AMITA, PATRICIA ISABEL G.', 'Science Research Specialist I' UNION ALL
  SELECT 'PROTACIO, KIM IRVIN T.', 'Science Research Specialist I' UNION ALL
  SELECT 'SERRANO, JEMN D.', 'Science Research Specialist I' UNION ALL
  SELECT 'CAJUCOM, MAYLENE P.', 'Science Research Specialist I' UNION ALL
  SELECT 'DUCAY, APPLE JOY D.', 'Science Research Specialist I' UNION ALL
  SELECT 'MENDOZA, DAVID KENNETH C.', 'Science Research Specialist I' UNION ALL
  SELECT 'RONGAVILLA, EMILY O.', 'Science Research Specialist I' UNION ALL
  SELECT 'MISAGAL, MA. EVETTE B.', 'Science Research Specialist I' UNION ALL
  SELECT 'CALAYAG, JAZELLE ANNE S.', 'Science Research Specialist I' UNION ALL
  SELECT 'CARAIG, GEORGINA S.', 'Science Research Specialist I' UNION ALL
  SELECT 'CRISTOBAL, ANTONIETTE G.', 'Science Research Specialist' UNION ALL
  SELECT 'LARRAZABAL, RICAMAE V.', 'Science Research Specialist' UNION ALL
  SELECT 'SUMANGUE, CHEDER D.', 'Science Research Specialist' UNION ALL
  SELECT 'PATRICIO, JONEL G.', 'Science Research Specialist' UNION ALL
  SELECT 'MUGA, MARICEL C.', 'Science Research Specialist' UNION ALL
  SELECT 'REMENTILLA, JOHN CHRIS E.', 'Science Research Specialist' UNION ALL
  SELECT 'ESCOTE, JOELEAN ZEPHANIE E.', 'Science Research Specialist' UNION ALL
  SELECT 'DELOS SANTOS, MARVIN C.', 'Science Research Specialist' UNION ALL
  SELECT 'LORENZO, ROD PAULO B.', 'Science Research Specialist' UNION ALL
  SELECT 'HERNANDEZ, MARTHA A.', 'Science Research Analyst' UNION ALL
  SELECT 'VELASCO, MA. SHERYL C.', 'Science Research Analyst' UNION ALL
  SELECT 'EGUIA, MARITES E.', 'Science Research Asst' UNION ALL
  SELECT 'BAQUIT, RYAN CHRISTOPHER B.', 'Science Research Asst' UNION ALL
  SELECT 'MESIONA, MA. NILDA S.', 'Science Aide' UNION ALL
  SELECT 'REBATO, EVA L.', 'Laboratory Aide I' UNION ALL
  SELECT 'SERRANO, SALVADOR R.', 'Chief Science Research Specialist' UNION ALL
  SELECT 'GLORIOSO, IDELIA G.', 'Sup Science Research Specialist & Scientist I' UNION ALL
  SELECT 'ARCANGEL, TRINIDAD II T.', 'Sup Science Research Specialist' UNION ALL
  SELECT 'BILLEDO, ELYSS G.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'FERRER, ELDRIDGE B.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'DULDULAO, JOAN C.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'ADONA, CHARLIE E.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'DE LEON, DEXTER Y.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'BRISTOL, NICHOLE M.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'LLANTO, LEA L.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'DE JUAN, JAYPY S.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'BRIONES, DAVE P.', 'Senior Science Research Specialist' UNION ALL
  SELECT 'BINLAYO, PRINCESS MAE J.', 'Information System Analyst II' UNION ALL
  SELECT 'PELAGIO, MICHAEL C.', 'Science Research Specialist I' UNION ALL
  SELECT 'AVORQUE, FRANKIE LYCURGUS D.', 'Science Research Specialist I' UNION ALL
  SELECT 'AREVALO, SHANNEN FAYE Q.', 'Science Research Specialist I' UNION ALL
  SELECT 'TAGAROMA, JAYSON G.', 'Science Research Specialist I' UNION ALL
  SELECT 'ULANDAY, JOSELITA ROSARIO C.', 'Science Research Specialist I' UNION ALL
  SELECT 'BACOLOD, ERIKA NIÑA C.', 'Science Research Specialist I' UNION ALL
  SELECT 'CARRANZA, LHEARNIE M.', 'Science Research Specialist I' UNION ALL
  SELECT 'DILAG, KRYZTALHYN MAE R.', 'Science Research Specialist I' UNION ALL
  SELECT 'BUYCO, NESRIANNE G.', 'Science Research Specialist I' UNION ALL
  SELECT 'GARCIA, FRANCESCA LOUISE P.', 'Science Research Specialist' UNION ALL
  SELECT 'BATALLANTES, FRANZIS JAYKE P.', 'Science Research Specialist' UNION ALL
  SELECT 'TANQUINO, DANIELLA MAE D.', 'Science Research Specialist' UNION ALL
  SELECT 'TORRES, JHANNA CAMELA C.', 'Science Research Specialist' UNION ALL
  SELECT 'TANDA, CARISSA S.', 'Science Research Specialist' UNION ALL
  SELECT 'MENDOZA-CELA, CZARLYN APRIL JOY G.', 'Science Research Specialist' UNION ALL
  SELECT 'SAMSON, MA. ARIZA B.', 'Science Research Specialist' UNION ALL
  SELECT 'PALOMPO, MARIA CORAZON E.', 'Science Research Specialist' UNION ALL
  SELECT 'NANIONG, TRICIA CAMILLE A.', 'Science Research Specialist' UNION ALL
  SELECT 'KAHANAP, CIARA CLAIRE SB.', 'Science Research Specialist' UNION ALL
  SELECT 'BAYALAS, CHRISTELLE LOIS T.', 'Science Research Specialist' UNION ALL
  SELECT 'BRAGAS, FILIPINIANA B.', 'Science Research Specialist' UNION ALL
  SELECT 'GULLA, SHERYL O.', 'Science Research Specialist' UNION ALL
  SELECT 'RAMIREZ, JOHN LESTER G.', 'Science Research Specialist' UNION ALL
  SELECT 'RIVERA, JUNNLIT LORAINE B.', 'Science Research Specialist' UNION ALL
  SELECT 'CABALLES, DENISSE ABBIE A.', 'Science Research Specialist' UNION ALL
  SELECT 'LABRAGUE, ZARIL L.', 'Science Research Specialist' UNION ALL
  SELECT 'YSULAT, JR. JOVITO A.', 'Science Research Specialist' UNION ALL
  SELECT 'RICALDE, MARY BABY JOY A.', 'Science Research Analyst' UNION ALL
  SELECT 'REFUGIO, IVY E.', 'Science Research Analyst' UNION ALL
  SELECT 'VILLANUEVA, JOHN MARK M.', 'Science Research Analyst' UNION ALL
  SELECT 'PEPITO, SOLEDAD G.', 'Science Research Assistant' UNION ALL
  SELECT 'CASTILLO, MARIBETH S.', 'Science Research Assistant' UNION ALL
  SELECT 'TARLIT, JONAHVER O.', 'Science Research Assistant' UNION ALL
  SELECT 'SARIO, TRISTAN GENE D.', 'Administrative Assistant II' UNION ALL
  SELECT 'LUNDAG, ARIES G.', 'Science Aide' UNION ALL
  SELECT 'MALAKI, ALBERTO JR. F.', 'Science Aide' UNION ALL
  SELECT 'TORRES, ASUNCION C.', 'Science Aide' UNION ALL
  SELECT 'ADONA, PRUDENCIO JR. E.', 'Science Aide' UNION ALL
  SELECT 'PONTE, FILOTEO D.', 'Science Aide'
) seed WHERE NOT EXISTS (SELECT 1 FROM `tbl_employee`);

-- ---------------------------------------------------------------------
-- Requests
-- ---------------------------------------------------------------------
-- Request number series, one row per year (SOR-2026-0001)
CREATE TABLE IF NOT EXISTS `myctr_request` (
  `CTR_YEAR` varchar(4) NOT NULL DEFAULT '0000',
  `CTRL_NO01` int(11) NOT NULL DEFAULT 0,
  UNIQUE KEY `ctr01` (`CTR_YEAR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `tbl_request_hd` (
  `recid` int(11) NOT NULL AUTO_INCREMENT,
  `request_no` varchar(20) NOT NULL DEFAULT '',
  `document_id` varchar(10) NOT NULL,
  `full_name` varchar(100) NOT NULL DEFAULT '',
  `position` varchar(100) NOT NULL DEFAULT '',
  `division_id` varchar(20) NOT NULL DEFAULT '',
  `section_id` varchar(20) NOT NULL DEFAULT '',
  `request_date` date NOT NULL,
  `subject` varchar(255) NOT NULL DEFAULT '',
  `noted_by` varchar(100) NOT NULL DEFAULT '',
  `noted_by_user` varchar(50) NOT NULL DEFAULT '',
  `requester_sign` varchar(100) NOT NULL DEFAULT '',
  `requester_signed_at` datetime DEFAULT NULL,
  `noted_sign` varchar(100) NOT NULL DEFAULT '',
  `noted_signed_at` datetime DEFAULT NULL,
  `noted_remarks` varchar(500) NOT NULL DEFAULT '',
  `submitted_at` datetime DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'For Approval',
  `hr_remarks` varchar(500) NOT NULL DEFAULT '',
  `so_no` varchar(50) NOT NULL DEFAULT '',
  `handled_by` varchar(50) NOT NULL DEFAULT '',
  `updated_at` datetime DEFAULT NULL,
  `added_by` varchar(50) NOT NULL DEFAULT '',
  `added_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`recid`),
  UNIQUE KEY `uq_tbl_request_hd_no` (`request_no`),
  KEY `added_by` (`added_by`),
  KEY `noted_by_user` (`noted_by_user`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Signatures + approval by the "Noted by" signatory, for a database created
-- before they were added. noted_by_user is the account whose name matched
-- noted_by; the *_sign files live in writable/uploads/signatures/<year>/.
ALTER TABLE `tbl_request_hd`
  ADD COLUMN IF NOT EXISTS `noted_by_user` varchar(50) NOT NULL DEFAULT '' AFTER `noted_by`,
  ADD COLUMN IF NOT EXISTS `requester_sign` varchar(100) NOT NULL DEFAULT '' AFTER `noted_by_user`,
  ADD COLUMN IF NOT EXISTS `requester_signed_at` datetime DEFAULT NULL AFTER `requester_sign`,
  ADD COLUMN IF NOT EXISTS `noted_sign` varchar(100) NOT NULL DEFAULT '' AFTER `requester_signed_at`,
  ADD COLUMN IF NOT EXISTS `noted_signed_at` datetime DEFAULT NULL AFTER `noted_sign`,
  ADD COLUMN IF NOT EXISTS `noted_remarks` varchar(500) NOT NULL DEFAULT '' AFTER `noted_signed_at`,
  ADD COLUMN IF NOT EXISTS `submitted_at` datetime DEFAULT NULL AFTER `noted_remarks`,
  ADD INDEX IF NOT EXISTS `noted_by_user` (`noted_by_user`);

-- One line of the form's table; each document type uses its own columns
CREATE TABLE IF NOT EXISTS `tbl_request_dt` (
  `recid` int(11) NOT NULL AUTO_INCREMENT,
  `request_id` int(11) NOT NULL,
  `subject` varchar(255) NOT NULL DEFAULT '',
  `staff_name` varchar(150) NOT NULL DEFAULT '',
  `position` varchar(150) NOT NULL DEFAULT '',
  `division_agency` varchar(150) NOT NULL DEFAULT '',
  `duration` varchar(150) NOT NULL DEFAULT '',
  `purpose` varchar(500) NOT NULL DEFAULT '',
  `amount` decimal(15,2) DEFAULT NULL,
  `total_amount` decimal(15,2) DEFAULT NULL,
  `registration_fee` decimal(15,2) DEFAULT NULL,
  `source_of_fund` varchar(150) NOT NULL DEFAULT '',
  `remarks` varchar(255) NOT NULL DEFAULT '',
  `added_by` varchar(50) NOT NULL DEFAULT '',
  `added_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`recid`),
  KEY `request_id` (`request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Local Travel Order: the part of the form that is not a table
CREATE TABLE IF NOT EXISTS `tbl_request_lto` (
  `recid` int(11) NOT NULL AUTO_INCREMENT,
  `request_id` int(11) NOT NULL,
  `destination` varchar(500) NOT NULL DEFAULT '',
  `travel_dates` varchar(500) NOT NULL DEFAULT '',
  `purpose` varchar(1000) NOT NULL DEFAULT '',
  `is_general_fund` int(11) NOT NULL DEFAULT 0,
  `project_fund` varchar(150) NOT NULL DEFAULT '',
  `other_fund` varchar(150) NOT NULL DEFAULT '',
  `remarks` varchar(500) NOT NULL DEFAULT '',
  `added_by` varchar(50) NOT NULL DEFAULT '',
  `added_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`recid`),
  UNIQUE KEY `uq_tbl_request_lto_request` (`request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Local Travel Order: travel expenses per fund (expense_code from Config\RequestForms)
CREATE TABLE IF NOT EXISTS `tbl_request_lto_expense` (
  `recid` int(11) NOT NULL AUTO_INCREMENT,
  `request_id` int(11) NOT NULL,
  `expense_code` varchar(30) NOT NULL,
  `general_fund` varchar(50) NOT NULL DEFAULT '',
  `project_fund` varchar(50) NOT NULL DEFAULT '',
  `other_fund` varchar(50) NOT NULL DEFAULT '',
  `added_by` varchar(50) NOT NULL DEFAULT '',
  `added_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`recid`),
  UNIQUE KEY `uq_tbl_request_lto_expense` (`request_id`, `expense_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ---------------------------------------------------------------------
-- Conversation between the requester and HR, one thread per request
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tbl_request_msg` (
  `recid` int(11) NOT NULL AUTO_INCREMENT,
  `request_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `added_by` varchar(50) NOT NULL DEFAULT '',
  `added_at` datetime NOT NULL DEFAULT current_timestamp(),
  `is_system` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`recid`),
  KEY `request_id` (`request_id`, `recid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Files live in writable/uploads/requests/<year>/
CREATE TABLE IF NOT EXISTS `tbl_request_attachment` (
  `recid` int(11) NOT NULL AUTO_INCREMENT,
  `request_id` int(11) NOT NULL,
  `msg_id` int(11) NOT NULL,
  `file_name` varchar(100) NOT NULL DEFAULT '',
  `orig_name` varchar(255) NOT NULL DEFAULT '',
  `mime_type` varchar(100) NOT NULL DEFAULT '',
  `file_size` int(11) NOT NULL DEFAULT 0,
  `is_image` int(11) NOT NULL DEFAULT 0,
  `added_by` varchar(50) NOT NULL DEFAULT '',
  `added_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`recid`),
  KEY `msg_id` (`msg_id`),
  KEY `request_id` (`request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Last message each user has read, for the unread badges
CREATE TABLE IF NOT EXISTS `tbl_request_seen` (
  `recid` int(11) NOT NULL AUTO_INCREMENT,
  `request_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `last_read_id` int(11) NOT NULL DEFAULT 0,
  `added_by` varchar(50) NOT NULL DEFAULT '',
  `added_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`recid`),
  UNIQUE KEY `request_user` (`request_id`, `username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ---------------------------------------------------------------------
-- The Special Order HR prepares for a request (HR document editor).
-- template_code is a key of Config\DocumentTemplates; doc_html is the
-- edited page body. The requester sees it once doc_status is 'Released'.
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tbl_request_doc` (
  `recid` int(11) NOT NULL AUTO_INCREMENT,
  `request_id` int(11) NOT NULL,
  `template_code` varchar(30) NOT NULL DEFAULT '',
  `doc_html` mediumtext NOT NULL,
  `doc_status` varchar(20) NOT NULL DEFAULT 'Draft',
  `released_at` datetime DEFAULT NULL,
  `released_by` varchar(50) NOT NULL DEFAULT '',
  `updated_at` datetime DEFAULT NULL,
  `added_by` varchar(50) NOT NULL DEFAULT '',
  `added_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`recid`),
  UNIQUE KEY `uq_tbl_request_doc_request` (`request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
