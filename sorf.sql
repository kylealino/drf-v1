-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 12, 2026 at 11:19 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sorf`
--

-- --------------------------------------------------------

--
-- Table structure for table `myctr_request`
--

CREATE TABLE `myctr_request` (
  `CTR_YEAR` varchar(4) NOT NULL DEFAULT '0000',
  `CTRL_NO01` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `myctr_request`
--

INSERT INTO `myctr_request` (`CTR_YEAR`, `CTRL_NO01`) VALUES
('2026', 6);

-- --------------------------------------------------------

--
-- Table structure for table `myua_user`
--

CREATE TABLE `myua_user` (
  `recid` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `hash_password` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `division` varchar(20) NOT NULL DEFAULT '',
  `section` varchar(20) NOT NULL DEFAULT '',
  `position` varchar(100) NOT NULL DEFAULT '',
  `role_id` int(11) NOT NULL DEFAULT 1,
  `added_at` datetime NOT NULL DEFAULT current_timestamp(),
  `added_by` varchar(50) NOT NULL,
  `is_active` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `myua_user`
--

INSERT INTO `myua_user` (`recid`, `username`, `hash_password`, `full_name`, `division`, `section`, `position`, `role_id`, `added_at`, `added_by`, `is_active`) VALUES
(1, 'hr-personnel', '$2y$10$7Qksz3Gd23ZNQRCMzw1ruuBGUttgTl04.VqscHnHyEOicWkgBoFG2', 'HR Personnel', 'FAD', 'HRMS', 'Human Resource Management Section', 2, '2026-10-08 09:34:12', 'SYSTEM', 1),
(2, 'kylealino1004', '$2y$10$8AWQfHo/xFW2EWMnHNv5v.7tC1l6L8DSS8nD/VeIWn1lBW.TysZ4O', 'KYLE ANDRAE ALINO', 'OD/ODD', 'MIS', 'PROJECT TECHNICAL SPECIALIST IIII', 1, '2026-10-08 10:10:18', 'kylealino1004', 1),
(3, 'CDS-JOVY', '$2y$10$TlK2ck9UWIhZkTHB7GH4meCTGo01HoAHADyQBhozuoWquPg6Qajz2', 'JOVY S. MEDINA', 'FAD', 'CDS', 'PROJECT ADMINISTRATIVE OFFICER V', 1, '2026-10-08 11:02:14', 'CDS-JOVY', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_division`
--

CREATE TABLE `tbl_division` (
  `recid` int(11) NOT NULL,
  `division_id` varchar(20) NOT NULL,
  `division_name` varchar(150) NOT NULL,
  `added_at` datetime NOT NULL DEFAULT current_timestamp(),
  `added_by` varchar(50) NOT NULL,
  `is_active` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_division`
--

INSERT INTO `tbl_division` (`recid`, `division_id`, `division_name`, `added_at`, `added_by`, `is_active`) VALUES
(1, 'OD/ODD', 'Office of the Director', '2026-10-08 09:34:12', 'SYSTEM', 1),
(2, 'NFRDD', 'Nutrition and Food Research and Development Division', '2026-10-08 09:34:12', 'SYSTEM', 1),
(3, 'NAMD', 'Nutrition Assessment and Monitoring Division', '2026-10-08 09:34:12', 'SYSTEM', 1),
(4, 'TDSTSD', 'Technology Diffusion and S&T Services Division', '2026-10-08 09:34:12', 'SYSTEM', 1),
(5, 'FAD', 'Finance and Administrative Division', '2026-10-08 09:34:12', 'SYSTEM', 1),
(6, 'SLG', 'Service Laboratory Group', '2026-10-08 09:34:12', 'SYSTEM', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_document_type`
--

CREATE TABLE `tbl_document_type` (
  `recid` int(11) NOT NULL,
  `document_id` varchar(10) NOT NULL,
  `document_type` varchar(150) NOT NULL,
  `added_at` datetime NOT NULL DEFAULT current_timestamp(),
  `added_by` varchar(50) NOT NULL,
  `is_active` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_document_type`
--

INSERT INTO `tbl_document_type` (`recid`, `document_id`, `document_type`, `added_at`, `added_by`, `is_active`) VALUES
(1, 'SO01', 'Authority to Receive Incentive/Honorarium (ATRH)', '2026-10-08 09:34:12', 'SYSTEM', 1),
(2, 'SO02', 'General Special Order (GSO)', '2026-10-08 09:34:12', 'SYSTEM', 1),
(3, 'SO03', 'Special Disbursing Officer (SDO)', '2026-10-08 09:34:12', 'SYSTEM', 1),
(4, 'SO04', 'Petty Cash Fund Custodian (PCFC)', '2026-10-08 09:34:12', 'SYSTEM', 1),
(5, 'SO05', 'Authority to Attend Activity (ATAA)', '2026-10-08 09:34:12', 'SYSTEM', 1),
(6, 'SO06', 'Local Travel Order (LTO)', '2026-10-08 09:34:12', 'SYSTEM', 1),
(7, 'SO07', 'Project Team Composition (PTC)', '2026-10-08 09:34:12', 'SYSTEM', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_employee`
--

CREATE TABLE `tbl_employee` (
  `recid` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `position` varchar(100) NOT NULL DEFAULT '',
  `added_at` datetime NOT NULL DEFAULT current_timestamp(),
  `added_by` varchar(50) NOT NULL,
  `is_active` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_employee`
--

INSERT INTO `tbl_employee` (`recid`, `full_name`, `position`, `added_at`, `added_by`, `is_active`) VALUES
(1, 'NACIS, JACUS S.', 'Director IV', '2026-10-08 09:34:12', 'SYSTEM', 1),
(2, 'RAZ, LUCIEDEN G.', 'Director III', '2026-10-08 09:34:12', 'SYSTEM', 1),
(3, 'AGUILA, DIVORAH V.', 'Planning Officer IV', '2026-10-08 09:34:12', 'SYSTEM', 1),
(4, 'AGUILOS, MARILITA A.', 'Planning Officer III', '2026-10-08 09:34:12', 'SYSTEM', 1),
(5, 'MOE, MYRNA F.', 'Planning Officer II', '2026-10-08 09:34:12', 'SYSTEM', 1),
(6, 'MONTERO, PATREEN E.', 'Admin Assistant III', '2026-10-08 09:34:12', 'SYSTEM', 1),
(7, 'BESMONTE, ROCHELLE', 'Administrative Aide IV', '2026-10-08 09:34:12', 'SYSTEM', 1),
(8, 'ORTIZ, ALEXIS M.', 'Chief Admin Officer', '2026-10-08 09:34:12', 'SYSTEM', 1),
(9, 'VIRIÑA, JESTER C.', 'Supervising Adm Officer', '2026-10-08 09:34:12', 'SYSTEM', 1),
(10, 'CAJANO, BONJOBIE F.', 'Accountant III', '2026-10-08 09:34:12', 'SYSTEM', 1),
(11, 'AGABAN, JEZIEL M.', 'Administrative Officer V', '2026-10-08 09:34:12', 'SYSTEM', 1),
(12, 'LLAMAS, ROMANA L.', 'Administrative Officer V', '2026-10-08 09:34:12', 'SYSTEM', 1),
(13, 'MEDINA, JOVY S.', 'Administrative Officer V', '2026-10-08 09:34:12', 'SYSTEM', 1),
(14, 'ESTRELLA, REMEA V.', 'Administrative Officer V', '2026-10-08 09:34:12', 'SYSTEM', 1),
(15, 'BALITAON, MARLON O.', 'Administrative Officer V', '2026-10-08 09:34:12', 'SYSTEM', 1),
(16, 'LUCENA, JAMES C.', 'Accountant II', '2026-10-08 09:34:12', 'SYSTEM', 1),
(17, 'VILLANUEVA, MILDRED D.', 'Administrative Officer IV', '2026-10-08 09:34:12', 'SYSTEM', 1),
(18, 'BARRIENTOS, HONEYGRACE B.', 'Administrative Officer IV', '2026-10-08 09:34:12', 'SYSTEM', 1),
(19, 'BALLESTER, HAROLD JONATHAN D.', 'Administrative Officer III', '2026-10-08 09:34:12', 'SYSTEM', 1),
(20, 'HUELAR, LUCILA C.', 'Administrative Officer II', '2026-10-08 09:34:12', 'SYSTEM', 1),
(21, 'CARIZO, MA. FE A.', 'Administrative Officer II', '2026-10-08 09:34:12', 'SYSTEM', 1),
(22, 'MERCADO, JULIET C.', 'Administrative Officer II', '2026-10-08 09:34:12', 'SYSTEM', 1),
(23, 'CUATERNO, LETICIA H.', 'Administrative Officer I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(24, 'CARANTO, MARY JOYCE M.', 'Admin Assistant III', '2026-10-08 09:34:12', 'SYSTEM', 1),
(25, 'BASILIO, ROSE ANN Q.', 'Admin Assistant II', '2026-10-08 09:34:12', 'SYSTEM', 1),
(26, 'MARAVILLAS, IDA MAE O.', 'Admin Assistant II', '2026-10-08 09:34:12', 'SYSTEM', 1),
(27, 'BANTA, SOFIA B.', 'Admin Assistant I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(28, 'JAIME, JOYCE MARIE A.', 'Administrative Aide VI', '2026-10-08 09:34:12', 'SYSTEM', 1),
(29, 'AGUILAR, RIVA PHILLINE', 'Administrative Aide VI', '2026-10-08 09:34:12', 'SYSTEM', 1),
(30, 'ULVIDA, MARVIN B.', 'Administrative Aide VI', '2026-10-08 09:34:12', 'SYSTEM', 1),
(31, 'RECALDE, MARIA CELINE E.', 'Administrative Aide VI', '2026-10-08 09:34:12', 'SYSTEM', 1),
(32, 'DAQUIOAG, JENINA P.', 'Administrative Aide IV', '2026-10-08 09:34:12', 'SYSTEM', 1),
(33, 'ABLITADO, KYLA JOY M.', 'Administrative Aide IV', '2026-10-08 09:34:12', 'SYSTEM', 1),
(34, 'LLEGADO, ARMILDA A.', 'Administrative Aide IV', '2026-10-08 09:34:12', 'SYSTEM', 1),
(35, 'AGUILAR, DARLENE D.', 'Administrative Aide IV', '2026-10-08 09:34:12', 'SYSTEM', 1),
(36, 'BIÑAS, GLENN B.', 'Administrative Aide III', '2026-10-08 09:34:12', 'SYSTEM', 1),
(37, 'DUMAG, ROSEMARIE J.', 'Chief Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(38, 'NACIONALES, KRISTINE B.', 'Supervising Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(39, 'SERAFICO, MICHAEL E.', 'Supervising Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(40, 'DAJAY, LEAH C.', 'Supervising Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(41, 'MADRID, MARILOU L.', 'Supervising Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(42, 'CABANILLA, CARL VINCENT D.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(43, 'GIRONELLA, MAY ANN D.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(44, 'PALOMO, ALEX M', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(45, 'TAN, ROBBY CARLO A.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(46, 'GUBAT, MARIA JULIA G.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(47, 'PADRONES, ABBIE L.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(48, 'RAMAS, VANNIZSA I.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(49, 'GULAY, JOANNE JETTE S.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(50, 'FRANE, RUBY D.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(51, 'BAQUIRAN, AMSTER FEI P.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(52, 'RAMIREZ, EUGENIO M.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(53, 'GUILARAN, ROSE ELAINE P.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(54, 'GUILARAN, JOHANNE B.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(55, 'APOR, AVEGAIL D.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(56, 'EWAYAN, CHRISTINE JOY B.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(57, 'LABRADOR, JASON PAOLO H.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(58, 'ZUMARAGA, MARK PRETZEL P.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(59, 'CUMAGUN, MA. LOURDES T.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(60, 'DECENA, MAJA BETHZAIDA S.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(61, 'JACALAN, FRANCES ISABELLE B.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(62, 'DIÑO, ALLEN JASPER D.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(63, 'SEVILLA, CHRISTINE EDEN C.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(64, 'ALBAO, MARICAR D.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(65, 'ALIBAYAN, MARITES V.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(66, 'LICAYAN, JOSAFAT JOHN SIMON L.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(67, 'VILLAPAZ, ROGEL L.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(68, 'ISLA, FAITH CHALICE M.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(69, 'DAVID, ALEXANDRA LYNE E.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(70, 'AFUANG, ALDRIN PAUL S.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(71, 'ARNEJO, EIRENE AGUSTIN B.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(72, 'LAUREA, JENNIFER C.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(73, 'EDER, JANEL ANNE C.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(74, 'SABINO, MA. JUSTINE CAMILLE S.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(75, 'SANTOS, TRINA MAE B.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(76, 'VERGARA, MICHA ELLA C.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(77, 'DALISAY, ALLAIN LOUISE P.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(78, 'ESPULGAR, JEFF MC ROWEN A.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(79, 'TAMPIL, GYLE D.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(80, 'SUMERA, CYRHO T.', 'Science Research Analyst', '2026-10-08 09:34:12', 'SYSTEM', 1),
(81, 'SOLIS, DANNIELINE M.', 'Science Research Analyst', '2026-10-08 09:34:12', 'SYSTEM', 1),
(82, 'REYES, ANA MAXIMINA C.', 'Science Research Analyst', '2026-10-08 09:34:12', 'SYSTEM', 1),
(83, 'ROSALES, RUVY ANN O.', 'Science Research Analyst', '2026-10-08 09:34:12', 'SYSTEM', 1),
(84, 'PARCAREY, MARICAR GIEL Y.', 'Science Research Asst', '2026-10-08 09:34:12', 'SYSTEM', 1),
(85, 'ABALOS, MA. MIKKAELLA C.', 'Science Aide', '2026-10-08 09:34:12', 'SYSTEM', 1),
(86, 'LALA, JUNIMER B.', 'Science Aide', '2026-10-08 09:34:12', 'SYSTEM', 1),
(87, 'PILARIZA, MARIA HELEN FORTUNA R.', 'Science Aide', '2026-10-08 09:34:12', 'SYSTEM', 1),
(88, 'GUIRINDOLA, MILDRED O.', 'Chief Science Research Specialist & Scientist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(89, 'DASCO, MA. LILIBETH P.', 'Supervising Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(90, 'PATALEN, CHONA F.', 'Supervising Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(91, 'GOYENA, EVA A.', 'Supervising Science Research Specialist & Scientist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(92, 'GIRONELLA, GLEN MELVIN P.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(93, 'ARIAS, FRANCES POLA S.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(94, 'AZANA, GLENDA P.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(95, 'MANIEGO, MA. LYNELL V.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(96, 'DESNACIDO, JOSIE P.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(97, 'JAVIER, MAE ANN SA.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(98, 'PARANI, MARIA STEPHANIE N.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(99, 'VIAJAR, ROWENA V.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(100, 'BUGAS, MARIE T.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(101, 'JAVIER, CHARINA A.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(102, 'AMITA, PATRICIA ISABEL G.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(103, 'PROTACIO, KIM IRVIN T.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(104, 'SERRANO, JEMN D.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(105, 'CAJUCOM, MAYLENE P.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(106, 'DUCAY, APPLE JOY D.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(107, 'MENDOZA, DAVID KENNETH C.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(108, 'RONGAVILLA, EMILY O.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(109, 'MISAGAL, MA. EVETTE B.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(110, 'CALAYAG, JAZELLE ANNE S.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(111, 'CARAIG, GEORGINA S.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(112, 'CRISTOBAL, ANTONIETTE G.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(113, 'LARRAZABAL, RICAMAE V.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(114, 'SUMANGUE, CHEDER D.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(115, 'PATRICIO, JONEL G.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(116, 'MUGA, MARICEL C.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(117, 'REMENTILLA, JOHN CHRIS E.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(118, 'ESCOTE, JOELEAN ZEPHANIE E.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(119, 'DELOS SANTOS, MARVIN C.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(120, 'LORENZO, ROD PAULO B.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(121, 'HERNANDEZ, MARTHA A.', 'Science Research Analyst', '2026-10-08 09:34:12', 'SYSTEM', 1),
(122, 'VELASCO, MA. SHERYL C.', 'Science Research Analyst', '2026-10-08 09:34:12', 'SYSTEM', 1),
(123, 'EGUIA, MARITES E.', 'Science Research Asst', '2026-10-08 09:34:12', 'SYSTEM', 1),
(124, 'BAQUIT, RYAN CHRISTOPHER B.', 'Science Research Asst', '2026-10-08 09:34:12', 'SYSTEM', 1),
(125, 'MESIONA, MA. NILDA S.', 'Science Aide', '2026-10-08 09:34:12', 'SYSTEM', 1),
(126, 'REBATO, EVA L.', 'Laboratory Aide I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(127, 'SERRANO, SALVADOR R.', 'Chief Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(128, 'GLORIOSO, IDELIA G.', 'Sup Science Research Specialist & Scientist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(129, 'ARCANGEL, TRINIDAD II T.', 'Sup Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(130, 'BILLEDO, ELYSS G.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(131, 'FERRER, ELDRIDGE B.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(132, 'DULDULAO, JOAN C.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(133, 'ADONA, CHARLIE E.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(134, 'DE LEON, DEXTER Y.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(135, 'BRISTOL, NICHOLE M.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(136, 'LLANTO, LEA L.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(137, 'DE JUAN, JAYPY S.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(138, 'BRIONES, DAVE P.', 'Senior Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(139, 'BINLAYO, PRINCESS MAE J.', 'Information System Analyst II', '2026-10-08 09:34:12', 'SYSTEM', 1),
(140, 'PELAGIO, MICHAEL C.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(141, 'AVORQUE, FRANKIE LYCURGUS D.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(142, 'AREVALO, SHANNEN FAYE Q.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(143, 'TAGAROMA, JAYSON G.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(144, 'ULANDAY, JOSELITA ROSARIO C.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(145, 'BACOLOD, ERIKA NIÑA C.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(146, 'CARRANZA, LHEARNIE M.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(147, 'DILAG, KRYZTALHYN MAE R.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(148, 'BUYCO, NESRIANNE G.', 'Science Research Specialist I', '2026-10-08 09:34:12', 'SYSTEM', 1),
(149, 'GARCIA, FRANCESCA LOUISE P.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(150, 'BATALLANTES, FRANZIS JAYKE P.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(151, 'TANQUINO, DANIELLA MAE D.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(152, 'TORRES, JHANNA CAMELA C.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(153, 'TANDA, CARISSA S.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(154, 'MENDOZA-CELA, CZARLYN APRIL JOY G.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(155, 'SAMSON, MA. ARIZA B.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(156, 'PALOMPO, MARIA CORAZON E.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(157, 'NANIONG, TRICIA CAMILLE A.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(158, 'KAHANAP, CIARA CLAIRE SB.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(159, 'BAYALAS, CHRISTELLE LOIS T.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(160, 'BRAGAS, FILIPINIANA B.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(161, 'GULLA, SHERYL O.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(162, 'RAMIREZ, JOHN LESTER G.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(163, 'RIVERA, JUNNLIT LORAINE B.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(164, 'CABALLES, DENISSE ABBIE A.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(165, 'LABRAGUE, ZARIL L.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(166, 'YSULAT, JR. JOVITO A.', 'Science Research Specialist', '2026-10-08 09:34:12', 'SYSTEM', 1),
(167, 'RICALDE, MARY BABY JOY A.', 'Science Research Analyst', '2026-10-08 09:34:12', 'SYSTEM', 1),
(168, 'REFUGIO, IVY E.', 'Science Research Analyst', '2026-10-08 09:34:12', 'SYSTEM', 1),
(169, 'VILLANUEVA, JOHN MARK M.', 'Science Research Analyst', '2026-10-08 09:34:12', 'SYSTEM', 1),
(170, 'PEPITO, SOLEDAD G.', 'Science Research Assistant', '2026-10-08 09:34:12', 'SYSTEM', 1),
(171, 'CASTILLO, MARIBETH S.', 'Science Research Assistant', '2026-10-08 09:34:12', 'SYSTEM', 1),
(172, 'TARLIT, JONAHVER O.', 'Science Research Assistant', '2026-10-08 09:34:12', 'SYSTEM', 1),
(173, 'SARIO, TRISTAN GENE D.', 'Administrative Assistant II', '2026-10-08 09:34:12', 'SYSTEM', 1),
(174, 'LUNDAG, ARIES G.', 'Science Aide', '2026-10-08 09:34:12', 'SYSTEM', 1),
(175, 'MALAKI, ALBERTO JR. F.', 'Science Aide', '2026-10-08 09:34:12', 'SYSTEM', 1),
(176, 'TORRES, ASUNCION C.', 'Science Aide', '2026-10-08 09:34:12', 'SYSTEM', 1),
(177, 'ADONA, PRUDENCIO JR. E.', 'Science Aide', '2026-10-08 09:34:12', 'SYSTEM', 1),
(178, 'PONTE, FILOTEO D.', 'Science Aide', '2026-10-08 09:34:12', 'SYSTEM', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_request_attachment`
--

CREATE TABLE `tbl_request_attachment` (
  `recid` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `msg_id` int(11) NOT NULL,
  `file_name` varchar(100) NOT NULL DEFAULT '',
  `orig_name` varchar(255) NOT NULL DEFAULT '',
  `mime_type` varchar(100) NOT NULL DEFAULT '',
  `file_size` int(11) NOT NULL DEFAULT 0,
  `is_image` int(11) NOT NULL DEFAULT 0,
  `added_by` varchar(50) NOT NULL DEFAULT '',
  `added_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_request_attachment`
--

INSERT INTO `tbl_request_attachment` (`recid`, `request_id`, `msg_id`, `file_name`, `orig_name`, `mime_type`, `file_size`, `is_image`, `added_by`, `added_at`) VALUES
(1, 2, 11, '2026/996bee40fd98a79acf06f49621e1c7ca.pdf', 'Special Order Request Form - DocumentTypes.pdf', 'application/pdf', 8149, 0, 'hr-personnel', '2026-10-08 16:14:06');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_request_doc`
--

CREATE TABLE `tbl_request_doc` (
  `recid` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `template_code` varchar(30) NOT NULL DEFAULT '',
  `doc_html` mediumtext NOT NULL,
  `doc_status` varchar(20) NOT NULL DEFAULT 'Draft',
  `released_at` datetime DEFAULT NULL,
  `released_by` varchar(50) NOT NULL DEFAULT '',
  `updated_at` datetime DEFAULT NULL,
  `added_by` varchar(50) NOT NULL DEFAULT '',
  `added_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_request_doc`
--

INSERT INTO `tbl_request_doc` (`recid`, `request_id`, `template_code`, `doc_html`, `doc_status`, `released_at`, `released_by`, `updated_at`, `added_by`, `added_at`) VALUES
(1, 3, 'ATRH-INC-AMEND', '<p class=\"doc-so\">DOST-FNRI Special Order No. <b>ATRH-RARARARA</b><br>Series of 2026</p>\r\n\r\n<p style=\"text-align: center\"><b>Subject: Amendment of DOST-FNRI Special Order No. ATRH-<span>111</span><br>Series 2026 Re: Authority to Receive Incentive</b></p>\r\n\r\n<p class=\"doc-indent\">In the interest of service, DOST-FNRI Special Order No. ATRH-<span>111</span> Series of 2026 Re: Authority to Receive Incentive for services rendered in connection with the conduct of the project titled <b>“test”</b>, is hereby amended as follows:</p>\r\n\r\n<table class=\"doc-table doc-small\">\r\n    <thead>\r\n        <tr>\r\n            <th><u>Name As Approved</u></th>\r\n            <th><u>Name As Amended</u></th>\r\n            <th><u>Designation As Approved</u></th>\r\n            <th><u>Designation As Amended</u></th>\r\n            <th><u>Duration As Approved</u></th>\r\n            <th><u>Duration As Amended</u></th>\r\n            <th><u>Amount As Approved</u></th>\r\n            <th><u>Amount As Amended</u></th>\r\n        </tr>\r\n    </thead>\r\n    <tbody>\r\n                <tr>\r\n            <td>ASDA</td>\r\n            <td>BIÑAS, GLENN B.</td>\r\n            <td>ASDASDA</td>\r\n            <td>Administrative Aide III</td>\r\n            <td>DSAD</td>\r\n            <td>test</td>\r\n            <td style=\"text-align: right\">ASDA</td>\r\n            <td style=\"text-align: right\">10.00</td>\r\n        </tr>\r\n            </tbody>\r\n</table>\r\n\r\n<p class=\"doc-indent\">All other provisions from the previously approved Special Order shall remain valid. This Special Order shall take effect immediately and remain valid until superseded.</p>\r\n\r\n<p class=\"doc-sign\"><b>JACUS S. NACIS</b><br>Director IV</p>', 'Released', '2026-10-12 16:59:32', 'hr-personnel', '2026-10-12 16:59:32', 'hr-personnel', '2026-10-12 16:58:08'),
(2, 4, 'GSO', '<p class=\"doc-so\">DOST-FNRI Special Order No. <b>_______</b><br>Series of 2026</p>\r\n\r\n<table class=\"doc-plain\">\r\n    <tbody><tr>\r\n        <td style=\"width: 16%\"><b>Subject:</b></td>\r\n        <td><b>TEST SUBJECT</b></td>\r\n    </tr>\r\n</tbody></table>\r\n\r\n<p class=\"doc-indent\">In the interest of the service, DOST-FNRI TEST SUBJECT is hereby <span>TEST</span> and shall be composed of the following officials/employees:</p>\r\n\r\n<p style=\"text-align: center\"><b>TEST SUBJECT</b></p>\r\n\r\n<table class=\"doc-plain\">\r\n    <thead>\r\n        <tr>\r\n            <th style=\"width: 28%\"><br></th>\r\n            <th style=\"width: 38%\">PRINCIPAL</th>\r\n            <th style=\"width: 34%\">ALTERNATES</th>\r\n        </tr>\r\n    </thead>\r\n    <tbody>\r\n                <tr>\r\n            <td><b>Senior Science Research Specialist</b></td>\r\n            <td style=\"text-align: center\">ADONA, CHARLIE E.</td>\r\n            <td style=\"text-align: center\"><br></td>\r\n        </tr>\r\n            </tbody>\r\n</table>\r\n\r\n<p>The Committee shall perform the following functions:</p>\r\n<ol>\r\n                <li>TEST</li>\r\n    </ol>\r\n\r\n<p class=\"doc-indent\">This Special Order shall take effect immediately and remain valid until superseded.</p>\r\n\r\n<p class=\"doc-sign\"><b>JACUS S. NACIS</b><br>Director IV</p>', 'Released', '2026-10-12 17:04:20', 'hr-personnel', '2026-10-12 17:04:20', 'hr-personnel', '2026-10-12 17:04:04'),
(3, 5, 'SDO', '<p class=\"doc-so\">DOST-FNRI Special Order No. <b>SDO-test</b><br>Series of 2026</p>\r\n\r\n<table class=\"doc-plain\">\r\n    <tbody><tr>\r\n        <td style=\"width: 24%; text-align: right\">Subject:</td>\r\n        <td><b><u>Designation of ADONA, PRUDENCIO JR. E. as<br>Special Disbursing Officer (SDO)</u></b></td>\r\n    </tr>\r\n</tbody></table>\r\n\r\n<p class=\"doc-indent\">In the interest of the service, ADONA, PRUDENCIO JR. E., Science Aide, is hereby designated as Special Disbursing Officer (SDO) and is authorized to hold Cash Advance in the amount stated opposite his/her name, to defray operating expenses to be incurred relevant to the activities of the project stated herewith:</p>\r\n\r\n<table class=\"doc-plain\">\r\n    <thead>\r\n        <tr>\r\n            <th style=\"width: 50%\"><u>Source of Fund</u></th>\r\n            <th style=\"width: 28%\"><u>Duration</u></th>\r\n            <th style=\"width: 22%\"><u>Amount</u></th>\r\n        </tr>\r\n    </thead>\r\n    <tbody>\r\n                <tr>\r\n            <td style=\"text-align: center\"><span>test</span></td>\r\n            <td style=\"text-align: center\">test</td>\r\n            <td style=\"text-align: center\">5,000.00</td>\r\n        </tr>\r\n            </tbody>\r\n</table>\r\n\r\n<p class=\"doc-indent\">The designated Special Disbursing Officer shall perform the following duties and responsibilities:</p>\r\n<ul>\r\n    <li>Maintain a Cash Disbursement Record (Appendix 40), and keep a copy of Petty Cash Voucher (Appendix 48) and Report on Paid Petty Cash Vouchers (Appendix 49);</li>\r\n    <li>Open a separate ATM account for the purpose of maintaining and monitoring of the cash advances, which must also be kept in a safekeeping device, either a vault or locked container;</li>\r\n    <li>Required to liquidate the cash advance on or before <u>December 15, 2026</u> or before the end date of the project duration on which the funds of the cash advance were drawn, whichever is earlier;</li>\r\n    <li>The designated employee shall immediately liquidate the full amount of cash advances due to but not limited to the following circumstances:\r\n        <ul>\r\n            <li>separation from the agency</li>\r\n            <li>on leave for a month or more</li>\r\n        </ul>\r\n    </li>\r\n</ul>\r\n\r\n<p class=\"doc-indent\">Failure to do so would mean an automatic deduction from his/her salary of the amount granted in the next succeeding payday. This Special Order shall take effect immediately and will remain valid until superseded.</p>\r\n\r\n<p class=\"doc-sign\"><b>JACUS S. NACIS</b><br>Director IV</p>', 'Released', '2026-10-12 17:08:50', 'hr-personnel', '2026-10-12 17:08:50', 'hr-personnel', '2026-10-12 17:08:31'),
(4, 6, 'SDO', '<p class=\"doc-so\">DOST-FNRI Special Order No. <b>SDO-_1231</b><br>Series of 2026</p>\r\n\r\n<table class=\"doc-plain\">\r\n    <tbody><tr>\r\n        <td style=\"width: 24%; text-align: right\">Subject:</td>\r\n        <td><b><u>Designation of ABLITADO, KYLA JOY M. as<br>Special Disbursing Officer (SDO)</u></b></td>\r\n    </tr>\r\n</tbody></table>\r\n\r\n<p class=\"doc-indent\">In the interest of the service, ABLITADO, KYLA JOY M., Administrative Aide IV, is hereby designated as Special Disbursing Officer (SDO) and is authorized to hold Cash Advance in the amount stated opposite his/her name, to defray operating expenses to be incurred relevant to the activities of the project stated herewith:</p>\r\n\r\n<table class=\"doc-plain\">\r\n    <thead>\r\n        <tr>\r\n            <th style=\"width: 50%\"><u>Source of Fund</u></th>\r\n            <th style=\"width: 28%\"><u>Duration</u></th>\r\n            <th style=\"width: 22%\"><u>Amount</u></th>\r\n        </tr>\r\n    </thead>\r\n    <tbody>\r\n                <tr>\r\n            <td style=\"text-align: center\">test</td>\r\n            <td style=\"text-align: center\">TEST</td>\r\n            <td style=\"text-align: center\">5,000.00</td>\r\n        </tr>\r\n            </tbody>\r\n</table>\r\n\r\n<p class=\"doc-indent\">The designated Special Disbursing Officer shall perform the following duties and responsibilities:</p>\r\n<ul>\r\n    <li>Maintain a Cash Disbursement Record (Appendix 40), and keep a copy of Petty Cash Voucher (Appendix 48) and Report on Paid Petty Cash Vouchers (Appendix 49);</li>\r\n    <li>Open a separate ATM account for the purpose of maintaining and monitoring of the cash advances, which must also be kept in a safekeeping device, either a vault or locked container;</li>\r\n    <li>Required to liquidate the cash advance on or before <u>December 15, 2026</u> or before the end date of the project duration on which the funds of the cash advance were drawn, whichever is earlier;</li>\r\n    <li>The designated employee shall immediately liquidate the full amount of cash advances due to but not limited to the following circumstances:\r\n        <ul>\r\n            <li>separation from the agency</li>\r\n            <li>on leave for a month or more</li>\r\n        </ul>\r\n    </li>\r\n</ul>\r\n\r\n<p class=\"doc-indent\">Failure to do so would mean an automatic deduction from his/her salary of the amount granted in the next succeeding payday. This Special Order shall take effect immediately and will remain valid until superseded.</p>\r\n\r\n<p class=\"doc-sign\"><b>JACUS S. NACIS</b><br>Director IV</p>', 'Released', '2026-10-12 17:11:46', 'hr-personnel', '2026-10-12 17:11:46', 'hr-personnel', '2026-10-12 17:11:27');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_request_dt`
--

CREATE TABLE `tbl_request_dt` (
  `recid` int(11) NOT NULL,
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
  `added_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_request_dt`
--

INSERT INTO `tbl_request_dt` (`recid`, `request_id`, `subject`, `staff_name`, `position`, `division_agency`, `duration`, `purpose`, `amount`, `total_amount`, `registration_fee`, `source_of_fund`, `remarks`, `added_by`, `added_at`) VALUES
(2, 1, 'test', 'AFUANG, ALDRIN PAUL S.', 'Science Research Specialist', '', '', 'test', NULL, NULL, NULL, '', 'test', 'kylealino1004', '2026-10-08 11:02:42'),
(3, 2, 'test', 'test', 'test', '', '', 'test', NULL, NULL, NULL, '', 'test', 'kylealino1004', '2026-10-08 16:10:21'),
(4, 3, '', 'BIÑAS, GLENN B.', 'Administrative Aide III', '', 'test', '', 10.00, 1000.00, NULL, 'test', '', 'kylealino1004', '2026-10-08 17:09:27'),
(5, 4, 'TEST', 'ADONA, CHARLIE E.', 'Senior Science Research Specialist', '', '', 'TEST', NULL, NULL, NULL, '', 'TEST', 'kylealino1004', '2026-10-12 17:03:15'),
(6, 5, '', 'ADONA, PRUDENCIO JR. E.', 'Science Aide', '', 'test', '', 5000.00, NULL, NULL, '', '', 'kylealino1004', '2026-10-12 17:07:50'),
(7, 6, '', 'ABLITADO, KYLA JOY M.', 'Administrative Aide IV', '', 'TEST', '', 5000.00, NULL, NULL, 'TEST', '', 'kylealino1004', '2026-10-12 17:10:40');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_request_hd`
--

CREATE TABLE `tbl_request_hd` (
  `recid` int(11) NOT NULL,
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
  `status` varchar(20) NOT NULL DEFAULT 'Pending',
  `hr_remarks` varchar(500) NOT NULL DEFAULT '',
  `so_no` varchar(50) NOT NULL DEFAULT '',
  `handled_by` varchar(50) NOT NULL DEFAULT '',
  `updated_at` datetime DEFAULT NULL,
  `added_by` varchar(50) NOT NULL DEFAULT '',
  `added_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_request_hd`
--

INSERT INTO `tbl_request_hd` (`recid`, `request_no`, `document_id`, `full_name`, `position`, `division_id`, `section_id`, `request_date`, `subject`, `noted_by`, `noted_by_user`, `requester_sign`, `requester_signed_at`, `noted_sign`, `noted_signed_at`, `noted_remarks`, `submitted_at`, `status`, `hr_remarks`, `so_no`, `handled_by`, `updated_at`, `added_by`, `added_at`) VALUES
(1, 'SOR-2026-0001', 'SO02', 'KYLE ANDRAE ALINO', 'PROJECT TECHNICAL SPECIALIST IIII', 'OD/ODD', 'MIS', '2026-10-08', 'test', 'JOVY S. MEDINA', 'CDS-JOVY', '2026/93d79e0476392001109c29175de88dbb.png', '2026-10-08 11:02:42', '2026/d838c65301b3c8674267f6b6a7602efc.png', '2026-10-08 11:03:36', '', '2026-10-08 11:05:16', 'Pending', '', '', '', '2026-10-08 11:05:16', 'kylealino1004', '2026-10-08 10:33:07'),
(2, 'SOR-2026-0002', 'SO02', 'KYLE ANDRAE ALINO', 'PROJECT TECHNICAL SPECIALIST IIII', 'OD/ODD', 'MIS', '2026-10-08', 'testing', 'JOVY S. MEDINA', 'CDS-JOVY', '2026/cddae1db1b99686eb5ca928c39a449d3.png', '2026-10-08 16:10:21', '2026/94a992a573d6e39b9cc5bc57e87a5f92.png', '2026-10-08 16:10:57', '', '2026-10-08 16:11:07', 'Approved', '', '', 'hr-personnel', '2026-10-08 16:12:05', 'kylealino1004', '2026-10-08 16:10:21'),
(3, 'SOR-2026-0003', 'SO07', 'KYLE ANDRAE ALINO', 'PROJECT TECHNICAL SPECIALIST IIII', 'OD/ODD', 'MIS', '2026-10-08', 'test', 'JOVY S. MEDINA', 'CDS-JOVY', '2026/153789fc179004d8c27db5aba337546e.png', '2026-10-08 17:09:27', '2026/9908aa4472ddcb6abbe56808e4150df0.png', '2026-10-08 17:10:05', '', '2026-10-08 17:10:05', 'Pending', '', '', '', '2026-10-08 17:10:05', 'kylealino1004', '2026-10-08 17:09:27'),
(4, 'SOR-2026-0004', 'SO02', 'KYLE ANDRAE ALINO', 'PROJECT TECHNICAL SPECIALIST IIII', 'OD/ODD', 'MIS', '2026-10-12', 'TEST SUBJECT', 'JOVY S. MEDINA', 'CDS-JOVY', '2026/d27c1ab41ece9f88e57e2dc3f75bbedd.png', '2026-10-12 17:03:15', '2026/816f0bf8e719f3eb0e87acdcd5c944c7.png', '2026-10-12 17:03:39', '', '2026-10-12 17:03:39', 'Approved', 'TEST', '123123123', 'hr-personnel', '2026-10-12 17:04:31', 'kylealino1004', '2026-10-12 17:03:15'),
(5, 'SOR-2026-0005', 'SO03', 'KYLE ANDRAE ALINO', 'PROJECT TECHNICAL SPECIALIST IIII', 'OD/ODD', 'MIS', '2026-10-12', 'test sdo', 'JOVY S. MEDINA', 'CDS-JOVY', '2026/a89a1de039c0b619527c8d7773f10e4f.png', '2026-10-12 17:07:50', '2026/a079911a4c9556d35d8026bf5adc788c.png', '2026-10-12 17:08:12', '', '2026-10-12 17:08:12', 'Approved', '', 'sdasdasda', 'hr-personnel', '2026-10-12 17:08:58', 'kylealino1004', '2026-10-12 17:07:50'),
(6, 'SOR-2026-0006', 'SO03', 'KYLE ANDRAE ALINO', 'PROJECT TECHNICAL SPECIALIST IIII', 'OD/ODD', 'MIS', '2026-10-12', 'TEST SDO', 'JOVY S. MEDINA', 'CDS-JOVY', '2026/778a0cc8fe42fd7adb7868ac71575c3d.png', '2026-10-12 17:10:40', '2026/4e79c161e44c5af2cd334a4075f25d45.png', '2026-10-12 17:11:02', '', '2026-10-12 17:11:02', 'Approved', '', '012391', 'hr-personnel', '2026-10-12 17:11:57', 'kylealino1004', '2026-10-12 17:10:40');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_request_lto`
--

CREATE TABLE `tbl_request_lto` (
  `recid` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `destination` varchar(500) NOT NULL DEFAULT '',
  `travel_dates` varchar(500) NOT NULL DEFAULT '',
  `purpose` varchar(1000) NOT NULL DEFAULT '',
  `is_general_fund` int(11) NOT NULL DEFAULT 0,
  `project_fund` varchar(150) NOT NULL DEFAULT '',
  `other_fund` varchar(150) NOT NULL DEFAULT '',
  `remarks` varchar(500) NOT NULL DEFAULT '',
  `added_by` varchar(50) NOT NULL DEFAULT '',
  `added_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_request_lto_expense`
--

CREATE TABLE `tbl_request_lto_expense` (
  `recid` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `expense_code` varchar(30) NOT NULL,
  `general_fund` varchar(50) NOT NULL DEFAULT '',
  `project_fund` varchar(50) NOT NULL DEFAULT '',
  `other_fund` varchar(50) NOT NULL DEFAULT '',
  `added_by` varchar(50) NOT NULL DEFAULT '',
  `added_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_request_msg`
--

CREATE TABLE `tbl_request_msg` (
  `recid` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `added_by` varchar(50) NOT NULL DEFAULT '',
  `added_at` datetime NOT NULL DEFAULT current_timestamp(),
  `is_system` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_request_msg`
--

INSERT INTO `tbl_request_msg` (`recid`, `request_id`, `message`, `added_by`, `added_at`, `is_system`) VALUES
(1, 1, 'please send doc 1, doc 2 and doc 3', 'hr-personnel', '2026-10-08 10:34:28', 0),
(2, 1, 'okay maam wait', 'kylealino1004', '2026-10-08 10:34:39', 0),
(3, 1, 'KYLE ANDRAE ALINO updated the request and sent it to JOVY S. MEDINA for approval.', 'kylealino1004', '2026-10-08 11:02:42', 1),
(4, 1, 'JOVY S. MEDINA signed and approved the request. It can now be submitted to HR.', 'CDS-JOVY', '2026-10-08 11:03:36', 1),
(5, 1, 'KYLE ANDRAE ALINO submitted the request to HR.', 'kylealino1004', '2026-10-08 11:05:16', 1),
(6, 2, 'KYLE ANDRAE ALINO signed the request and sent it to JOVY S. MEDINA for approval.', 'kylealino1004', '2026-10-08 16:10:21', 1),
(7, 2, 'JOVY S. MEDINA signed and approved the request. It can now be submitted to HR.', 'CDS-JOVY', '2026-10-08 16:10:57', 1),
(8, 2, 'KYLE ANDRAE ALINO submitted the request to HR.', 'kylealino1004', '2026-10-08 16:11:07', 1),
(9, 2, 'PLEASE SEND DOC 1 AND DOC 2 FIRST', 'hr-personnel', '2026-10-08 16:11:54', 0),
(10, 2, 'Status changed to Approved.', 'hr-personnel', '2026-10-08 16:12:05', 1),
(11, 2, 'PLEASE SEE ATTACH SO', 'hr-personnel', '2026-10-08 16:14:06', 0),
(12, 3, 'KYLE ANDRAE ALINO signed the request and sent it to JOVY S. MEDINA for approval.', 'kylealino1004', '2026-10-08 17:09:27', 1),
(13, 3, 'JOVY S. MEDINA signed and approved the request. It has been submitted to HR.', 'CDS-JOVY', '2026-10-08 17:10:05', 1),
(14, 3, 'HR released the Special Order document. It can be viewed, printed or downloaded from this request.', 'hr-personnel', '2026-10-12 16:59:32', 1),
(15, 4, 'KYLE ANDRAE ALINO signed the request and sent it to JOVY S. MEDINA for approval.', 'kylealino1004', '2026-10-12 17:03:15', 1),
(16, 4, 'JOVY S. MEDINA signed and approved the request. It has been submitted to HR.', 'CDS-JOVY', '2026-10-12 17:03:39', 1),
(17, 4, 'HR released the Special Order document. It can be viewed, printed or downloaded from this request.', 'hr-personnel', '2026-10-12 17:04:20', 1),
(18, 4, 'Status changed to Approved.\nTEST\nS.O. No.: 123123123', 'hr-personnel', '2026-10-12 17:04:31', 1),
(19, 5, 'KYLE ANDRAE ALINO signed the request and sent it to JOVY S. MEDINA for approval.', 'kylealino1004', '2026-10-12 17:07:50', 1),
(20, 5, 'JOVY S. MEDINA signed and approved the request. It has been submitted to HR.', 'CDS-JOVY', '2026-10-12 17:08:12', 1),
(21, 5, 'HR released the Special Order document. It can be viewed, printed or downloaded from this request.', 'hr-personnel', '2026-10-12 17:08:50', 1),
(22, 5, 'Status changed to Approved.\nS.O. No.: sdasdasda', 'hr-personnel', '2026-10-12 17:08:58', 1),
(23, 6, 'KYLE ANDRAE ALINO signed the request and sent it to JOVY S. MEDINA for approval.', 'kylealino1004', '2026-10-12 17:10:40', 1),
(24, 6, 'JOVY S. MEDINA signed and approved the request. It has been submitted to HR.', 'CDS-JOVY', '2026-10-12 17:11:02', 1),
(25, 6, 'HR released the Special Order document. It can be viewed, printed or downloaded from this request.', 'hr-personnel', '2026-10-12 17:11:46', 1),
(26, 6, 'Status changed to Approved.\nS.O. No.: 012391', 'hr-personnel', '2026-10-12 17:11:57', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_request_seen`
--

CREATE TABLE `tbl_request_seen` (
  `recid` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `last_read_id` int(11) NOT NULL DEFAULT 0,
  `added_by` varchar(50) NOT NULL DEFAULT '',
  `added_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_request_seen`
--

INSERT INTO `tbl_request_seen` (`recid`, `request_id`, `username`, `last_read_id`, `added_by`, `added_at`) VALUES
(1, 1, 'hr-personnel', 5, 'hr-personnel', '2026-10-08 10:34:28'),
(3, 1, 'kylealino1004', 5, 'kylealino1004', '2026-10-08 10:34:34'),
(11, 1, 'CDS-JOVY', 5, 'CDS-JOVY', '2026-10-08 11:03:21'),
(21, 2, 'kylealino1004', 11, 'kylealino1004', '2026-10-08 16:10:21'),
(22, 2, 'CDS-JOVY', 10, 'CDS-JOVY', '2026-10-08 16:10:49'),
(27, 2, 'hr-personnel', 11, 'hr-personnel', '2026-10-08 16:11:41'),
(40, 3, 'kylealino1004', 14, 'kylealino1004', '2026-10-08 17:09:27'),
(42, 3, 'CDS-JOVY', 13, 'CDS-JOVY', '2026-10-08 17:09:48'),
(47, 3, 'hr-personnel', 14, 'hr-personnel', '2026-10-12 16:57:40'),
(54, 4, 'kylealino1004', 18, 'kylealino1004', '2026-10-12 17:03:15'),
(55, 4, 'CDS-JOVY', 16, 'CDS-JOVY', '2026-10-12 17:03:31'),
(57, 4, 'hr-personnel', 18, 'hr-personnel', '2026-10-12 17:03:53'),
(61, 5, 'kylealino1004', 22, 'kylealino1004', '2026-10-12 17:07:50'),
(62, 5, 'CDS-JOVY', 20, 'CDS-JOVY', '2026-10-12 17:08:02'),
(66, 5, 'hr-personnel', 22, 'hr-personnel', '2026-10-12 17:08:23'),
(72, 6, 'kylealino1004', 26, 'kylealino1004', '2026-10-12 17:10:40'),
(73, 6, 'CDS-JOVY', 24, 'CDS-JOVY', '2026-10-12 17:10:54'),
(77, 6, 'hr-personnel', 26, 'hr-personnel', '2026-10-12 17:11:15');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_roles`
--

CREATE TABLE `tbl_roles` (
  `recid` int(11) NOT NULL,
  `role_name` varchar(100) NOT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  `is_active` int(11) NOT NULL DEFAULT 1,
  `added_by` varchar(50) NOT NULL,
  `added_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_roles`
--

INSERT INTO `tbl_roles` (`recid`, `role_name`, `description`, `is_active`, `added_by`, `added_at`) VALUES
(1, 'Requester', 'Files special order requests and follows their status', 1, 'SYSTEM', '2026-10-08 09:34:12'),
(2, 'HR Personnel', 'Receives every request, asks for requirements and grants or denies it', 1, 'SYSTEM', '2026-10-08 09:34:12');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_section`
--

CREATE TABLE `tbl_section` (
  `recid` int(11) NOT NULL,
  `division_id` varchar(20) NOT NULL,
  `section_id` varchar(20) NOT NULL,
  `section_name` varchar(150) NOT NULL,
  `added_at` datetime NOT NULL DEFAULT current_timestamp(),
  `added_by` varchar(50) NOT NULL,
  `is_active` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_section`
--

INSERT INTO `tbl_section` (`recid`, `division_id`, `section_id`, `section_name`, `added_at`, `added_by`, `is_active`) VALUES
(1, 'OD/ODD', 'OD/ODD', 'Office Of The Director / Office Of The Deputy Director', '2026-10-08 09:34:12', 'SYSTEM', 1),
(2, 'OD/ODD', 'MIS', 'Management Information System', '2026-10-08 09:34:12', 'SYSTEM', 1),
(3, 'OD/ODD', 'PEU', 'Planning And Evaluation Unit', '2026-10-08 09:34:12', 'SYSTEM', 1),
(4, 'NFRDD', 'FRDG', 'Food Research and Development Group', '2026-10-08 09:34:12', 'SYSTEM', 1),
(5, 'NFRDD', 'FRDS', 'Nutrition And Food Research and Development Section', '2026-10-08 09:34:12', 'SYSTEM', 1),
(6, 'NFRDD', 'FQSS', 'Food Quality And Safety Section', '2026-10-08 09:34:12', 'SYSTEM', 1),
(7, 'NFRDD', 'NRDG', 'Nutrition Research and Development Group', '2026-10-08 09:34:12', 'SYSTEM', 1),
(8, 'NFRDD', 'LNS', 'Lifestage Nutrition Section', '2026-10-08 09:34:12', 'SYSTEM', 1),
(9, 'NFRDD', 'NBS', 'Nutritional Biochemistry Section', '2026-10-08 09:34:12', 'SYSTEM', 1),
(10, 'NAMD', 'NAS', 'Nutritional Assessment Section', '2026-10-08 09:34:12', 'SYSTEM', 1),
(11, 'NAMD', 'NIEPS', 'Nutrition Intervention, Evaluation And Policy Section', '2026-10-08 09:34:12', 'SYSTEM', 1),
(12, 'NAMD', 'NSIS', 'Nutrition Statistics & Informatics Section', '2026-10-08 09:34:12', 'SYSTEM', 1),
(13, 'TDSTSD', 'TTCS', 'Technology Transfer And Commercialization Section', '2026-10-08 09:34:12', 'SYSTEM', 1),
(14, 'TDSTSD', 'KDS', 'Knowledge Diffusion Section', '2026-10-08 09:34:12', 'SYSTEM', 1),
(15, 'FAD', 'HRMS', 'Human Resource Management Section', '2026-10-08 09:34:12', 'SYSTEM', 1),
(16, 'FAD', 'BS', 'Budget Section', '2026-10-08 09:34:12', 'SYSTEM', 1),
(17, 'FAD', 'AS', 'Accounting Section', '2026-10-08 09:34:12', 'SYSTEM', 1),
(18, 'FAD', 'CDS', 'Collection And Disbursement Section', '2026-10-08 09:34:12', 'SYSTEM', 1),
(19, 'FAD', 'PS', 'Property Section', '2026-10-08 09:34:12', 'SYSTEM', 1),
(20, 'FAD', 'MS', 'Maintenance Section', '2026-10-08 09:34:12', 'SYSTEM', 1),
(21, 'FAD', 'RMU', 'Records Management Unit', '2026-10-08 09:34:12', 'SYSTEM', 1),
(22, 'SLG', 'BIO', 'Biochemical Laboratory', '2026-10-08 09:34:12', 'SYSTEM', 1),
(23, 'SLG', 'CHE', 'Chemical Laboratory', '2026-10-08 09:34:12', 'SYSTEM', 1),
(24, 'SLG', 'MIC', 'Microbiological Laboratory', '2026-10-08 09:34:12', 'SYSTEM', 1),
(25, 'SLG', 'PTL', 'Proficiency Testing Lab', '2026-10-08 09:34:12', 'SYSTEM', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `myctr_request`
--
ALTER TABLE `myctr_request`
  ADD UNIQUE KEY `ctr01` (`CTR_YEAR`);

--
-- Indexes for table `myua_user`
--
ALTER TABLE `myua_user`
  ADD PRIMARY KEY (`recid`),
  ADD UNIQUE KEY `uq_myua_user_username` (`username`),
  ADD KEY `fk_myua_user_role` (`role_id`);

--
-- Indexes for table `tbl_division`
--
ALTER TABLE `tbl_division`
  ADD PRIMARY KEY (`recid`),
  ADD UNIQUE KEY `uq_tbl_division_id` (`division_id`);

--
-- Indexes for table `tbl_document_type`
--
ALTER TABLE `tbl_document_type`
  ADD PRIMARY KEY (`recid`),
  ADD UNIQUE KEY `uq_tbl_document_type_id` (`document_id`);

--
-- Indexes for table `tbl_employee`
--
ALTER TABLE `tbl_employee`
  ADD PRIMARY KEY (`recid`);

--
-- Indexes for table `tbl_request_attachment`
--
ALTER TABLE `tbl_request_attachment`
  ADD PRIMARY KEY (`recid`),
  ADD KEY `msg_id` (`msg_id`),
  ADD KEY `request_id` (`request_id`);

--
-- Indexes for table `tbl_request_doc`
--
ALTER TABLE `tbl_request_doc`
  ADD PRIMARY KEY (`recid`),
  ADD UNIQUE KEY `uq_tbl_request_doc_request` (`request_id`);

--
-- Indexes for table `tbl_request_dt`
--
ALTER TABLE `tbl_request_dt`
  ADD PRIMARY KEY (`recid`),
  ADD KEY `request_id` (`request_id`);

--
-- Indexes for table `tbl_request_hd`
--
ALTER TABLE `tbl_request_hd`
  ADD PRIMARY KEY (`recid`),
  ADD UNIQUE KEY `uq_tbl_request_hd_no` (`request_no`),
  ADD KEY `added_by` (`added_by`),
  ADD KEY `status` (`status`),
  ADD KEY `noted_by_user` (`noted_by_user`);

--
-- Indexes for table `tbl_request_lto`
--
ALTER TABLE `tbl_request_lto`
  ADD PRIMARY KEY (`recid`),
  ADD UNIQUE KEY `uq_tbl_request_lto_request` (`request_id`);

--
-- Indexes for table `tbl_request_lto_expense`
--
ALTER TABLE `tbl_request_lto_expense`
  ADD PRIMARY KEY (`recid`),
  ADD UNIQUE KEY `uq_tbl_request_lto_expense` (`request_id`,`expense_code`);

--
-- Indexes for table `tbl_request_msg`
--
ALTER TABLE `tbl_request_msg`
  ADD PRIMARY KEY (`recid`),
  ADD KEY `request_id` (`request_id`,`recid`);

--
-- Indexes for table `tbl_request_seen`
--
ALTER TABLE `tbl_request_seen`
  ADD PRIMARY KEY (`recid`),
  ADD UNIQUE KEY `request_user` (`request_id`,`username`);

--
-- Indexes for table `tbl_roles`
--
ALTER TABLE `tbl_roles`
  ADD PRIMARY KEY (`recid`),
  ADD UNIQUE KEY `uq_tbl_roles_role_name` (`role_name`);

--
-- Indexes for table `tbl_section`
--
ALTER TABLE `tbl_section`
  ADD PRIMARY KEY (`recid`),
  ADD UNIQUE KEY `uq_tbl_section_id` (`division_id`,`section_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `myua_user`
--
ALTER TABLE `myua_user`
  MODIFY `recid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_division`
--
ALTER TABLE `tbl_division`
  MODIFY `recid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tbl_document_type`
--
ALTER TABLE `tbl_document_type`
  MODIFY `recid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_employee`
--
ALTER TABLE `tbl_employee`
  MODIFY `recid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=179;

--
-- AUTO_INCREMENT for table `tbl_request_attachment`
--
ALTER TABLE `tbl_request_attachment`
  MODIFY `recid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_request_doc`
--
ALTER TABLE `tbl_request_doc`
  MODIFY `recid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_request_dt`
--
ALTER TABLE `tbl_request_dt`
  MODIFY `recid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_request_hd`
--
ALTER TABLE `tbl_request_hd`
  MODIFY `recid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tbl_request_lto`
--
ALTER TABLE `tbl_request_lto`
  MODIFY `recid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_request_lto_expense`
--
ALTER TABLE `tbl_request_lto_expense`
  MODIFY `recid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_request_msg`
--
ALTER TABLE `tbl_request_msg`
  MODIFY `recid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `tbl_request_seen`
--
ALTER TABLE `tbl_request_seen`
  MODIFY `recid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `tbl_roles`
--
ALTER TABLE `tbl_roles`
  MODIFY `recid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_section`
--
ALTER TABLE `tbl_section`
  MODIFY `recid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `myua_user`
--
ALTER TABLE `myua_user`
  ADD CONSTRAINT `fk_myua_user_role` FOREIGN KEY (`role_id`) REFERENCES `tbl_roles` (`recid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
