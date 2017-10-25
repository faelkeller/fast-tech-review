-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 25-Out-2017 às 17:12
-- Versão do servidor: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `fast_tech`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `attribute`
--

CREATE TABLE IF NOT EXISTS `attribute` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Extraindo dados da tabela `attribute`
--

INSERT INTO `attribute` (`id`, `name`) VALUES
(1, 'bitter'),
(2, 'flavour');

-- --------------------------------------------------------

--
-- Estrutura da tabela `beer`
--

CREATE TABLE IF NOT EXISTS `beer` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `tagline` varchar(50) NOT NULL,
  `first_brewed` varchar(7) NOT NULL,
  `description` text,
  `image_url` varchar(75) NOT NULL,
  `abv` decimal(3,1) DEFAULT NULL,
  `ibu` int(11) DEFAULT NULL,
  `target_fg` int(11) DEFAULT NULL,
  `target_og` int(11) DEFAULT NULL,
  `ebc` int(11) DEFAULT NULL,
  `srm` int(11) DEFAULT NULL,
  `ph` decimal(3,1) DEFAULT NULL,
  `attenuation_level` int(11) DEFAULT NULL,
  `volume_value` smallint(5) unsigned DEFAULT NULL,
  `volume_unit` tinyint(3) unsigned DEFAULT NULL,
  `boil_volume_value` smallint(5) unsigned DEFAULT NULL,
  `boil_volume_unit` tinyint(3) unsigned DEFAULT NULL,
  `ferm_temp_value` smallint(5) unsigned DEFAULT NULL,
  `ferm_temp_unit` tinyint(3) unsigned DEFAULT NULL,
  `twist` varchar(255) DEFAULT NULL,
  `brewers_tips` varchar(255) DEFAULT NULL,
  `contributed_by` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `volume_unit` (`volume_unit`),
  KEY `ferm_temp_unit` (`ferm_temp_unit`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Extraindo dados da tabela `beer`
--

INSERT INTO `beer` (`id`, `name`, `tagline`, `first_brewed`, `description`, `image_url`, `abv`, `ibu`, `target_fg`, `target_og`, `ebc`, `srm`, `ph`, `attenuation_level`, `volume_value`, `volume_unit`, `boil_volume_value`, `boil_volume_unit`, `ferm_temp_value`, `ferm_temp_unit`, `twist`, `brewers_tips`, `contributed_by`) VALUES
(1, 'Test 1', 'testtag', '12/2016', 'sadada dad', 'http://www.rafaelkeller.com.br/img.jpg', '4.0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
(2, 'Test 2', 'tagtest2', '11/2015', 'sdad gewuyrgewy sfsdbfks', 'http://www.rafaelkeller.com.br/image2.jpg', '2.0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2),
(3, 'Bad Pixie', 'Spiced Wheat Beer.', '10/2008', '2008 Prototype beer, a 4.7% wheat ale with crushed juniper berries and citrus peel.', 'https://images.punkapi.com/v2/25.png', '4.7', 45, 1010, 1047, 8, 4, '4.4', 79, 20, 1, 25, 1, 19, 2, 'Crushed juniper berries: 12.5g, Lemon peel: 18.8g', 'Make sure you have plenty of room in the fermenter. Beers containing wheat can often foam aggressively during fermentation.', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `beer_food_pairing`
--

CREATE TABLE IF NOT EXISTS `beer_food_pairing` (
  `id_beer` int(10) unsigned NOT NULL,
  `id_food_pairing` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id_beer`,`id_food_pairing`),
  KEY `fk_bfp_food_pairing` (`id_food_pairing`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `beer_food_pairing`
--

INSERT INTO `beer_food_pairing` (`id_beer`, `id_food_pairing`) VALUES
(3, 1),
(3, 2),
(3, 3);

-- --------------------------------------------------------

--
-- Estrutura da tabela `beer_hop`
--

CREATE TABLE IF NOT EXISTS `beer_hop` (
  `id_beer` int(10) unsigned NOT NULL,
  `id_hop` smallint(5) unsigned NOT NULL,
  `amount_value` decimal(4,2) unsigned NOT NULL,
  `amount_unit` tinyint(3) unsigned NOT NULL,
  `add` enum('start','end') NOT NULL,
  `id_attribute` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id_beer`,`id_hop`,`add`),
  KEY `amount_unit` (`amount_unit`),
  KEY `id_attribute` (`id_attribute`),
  KEY `fk_bh_hop` (`id_hop`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `beer_hop`
--

INSERT INTO `beer_hop` (`id_beer`, `id_hop`, `amount_value`, `amount_unit`, `add`, `id_attribute`) VALUES
(3, 1, '18.75', 4, 'start', 1),
(3, 1, '25.00', 4, 'end', 2),
(3, 2, '16.25', 4, 'end', 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `beer_malt`
--

CREATE TABLE IF NOT EXISTS `beer_malt` (
  `id_beer` int(10) unsigned NOT NULL,
  `id_malt` smallint(5) unsigned NOT NULL,
  `amount_value` decimal(4,2) unsigned NOT NULL,
  `amount_unit` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id_beer`,`id_malt`),
  KEY `amount_unit` (`amount_unit`),
  KEY `fk_bm_malt` (`id_malt`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `beer_malt`
--

INSERT INTO `beer_malt` (`id_beer`, `id_malt`, `amount_value`, `amount_unit`) VALUES
(3, 1, '2.50', 3),
(3, 2, '2.06', 3);

-- --------------------------------------------------------

--
-- Estrutura da tabela `beer_yeast`
--

CREATE TABLE IF NOT EXISTS `beer_yeast` (
  `id_beer` int(10) unsigned NOT NULL,
  `id_yeast` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id_beer`,`id_yeast`),
  KEY `fk_by_yeast` (`id_yeast`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `beer_yeast`
--

INSERT INTO `beer_yeast` (`id_beer`, `id_yeast`) VALUES
(3, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `food_pairing`
--

CREATE TABLE IF NOT EXISTS `food_pairing` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `text` varchar(150) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Extraindo dados da tabela `food_pairing`
--

INSERT INTO `food_pairing` (`id`, `text`) VALUES
(1, 'Poached sole fillet with capers'),
(2, 'Summer fruit salad'),
(3, 'Banana split');

-- --------------------------------------------------------

--
-- Estrutura da tabela `hop`
--

CREATE TABLE IF NOT EXISTS `hop` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Extraindo dados da tabela `hop`
--

INSERT INTO `hop` (`id`, `name`) VALUES
(1, 'First Gold'),
(2, 'Sorachi Ace');

-- --------------------------------------------------------

--
-- Estrutura da tabela `malt`
--

CREATE TABLE IF NOT EXISTS `malt` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Extraindo dados da tabela `malt`
--

INSERT INTO `malt` (`id`, `name`) VALUES
(1, 'Wheat'),
(2, 'Extra Pale');

-- --------------------------------------------------------

--
-- Estrutura da tabela `mash_temp`
--

CREATE TABLE IF NOT EXISTS `mash_temp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_beer` int(10) unsigned NOT NULL,
  `temp_value` smallint(5) unsigned NOT NULL,
  `temp_unit` tinyint(3) unsigned NOT NULL,
  `duration` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_beer` (`id_beer`),
  KEY `temp_unit` (`temp_unit`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Extraindo dados da tabela `mash_temp`
--

INSERT INTO `mash_temp` (`id`, `id_beer`, `temp_value`, `temp_unit`, `duration`) VALUES
(2, 3, 67, 2, 75);

-- --------------------------------------------------------

--
-- Estrutura da tabela `request`
--

CREATE TABLE IF NOT EXISTS `request` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(40) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=425 ;

--
-- Extraindo dados da tabela `request`
--

INSERT INTO `request` (`id`, `ip`, `date`) VALUES
(1, '127.0.0.1', '2017-10-21 14:53:02'),
(2, '127.0.0.1', '2017-10-21 14:55:43'),
(3, '127.0.0.1', '2017-10-21 14:56:00'),
(4, '127.0.0.1', '2017-10-21 14:56:02'),
(5, '127.0.0.1', '2017-10-21 14:58:43'),
(6, '127.0.0.1', '2017-10-21 14:58:55'),
(7, '127.0.0.1', '2017-10-21 14:58:56'),
(8, '127.0.0.1', '2017-10-21 14:58:58'),
(9, '127.0.0.1', '2017-10-21 14:58:59'),
(10, '127.0.0.1', '2017-10-21 14:59:00'),
(11, '127.0.0.1', '2017-10-21 14:59:01'),
(12, '127.0.0.1', '2017-10-21 15:00:40'),
(13, '127.0.0.1', '2017-10-21 15:00:42'),
(14, '127.0.0.1', '2017-10-21 15:00:44'),
(15, '127.0.0.1', '2017-10-21 15:01:09'),
(16, '127.0.0.1', '2017-10-21 15:03:32'),
(17, '127.0.0.1', '2017-10-21 15:09:19'),
(18, '127.0.0.1', '2017-10-21 15:09:42'),
(19, '127.0.0.1', '2017-10-21 15:11:18'),
(20, '127.0.0.1', '2017-10-21 15:11:44'),
(21, '127.0.0.1', '2017-10-21 15:14:33'),
(22, '127.0.0.1', '2017-10-21 15:14:44'),
(23, '127.0.0.1', '2017-10-21 15:14:48'),
(24, '127.0.0.1', '2017-10-21 15:15:03'),
(25, '127.0.0.1', '2017-10-21 15:28:59'),
(26, '127.0.0.1', '2017-10-21 15:29:07'),
(27, '127.0.0.1', '2017-10-21 15:29:10'),
(28, '127.0.0.1', '2017-10-21 15:30:13'),
(29, '127.0.0.1', '2017-10-21 15:31:01'),
(30, '127.0.0.1', '2017-10-21 15:31:31'),
(31, '127.0.0.1', '2017-10-21 15:31:40'),
(32, '127.0.0.1', '2017-10-21 15:33:31'),
(33, '127.0.0.1', '2017-10-21 15:33:54'),
(34, '127.0.0.1', '2017-10-21 15:36:01'),
(35, '127.0.0.1', '2017-10-21 15:37:02'),
(36, '127.0.0.1', '2017-10-21 15:37:47'),
(37, '127.0.0.1', '2017-10-21 15:38:41'),
(38, '127.0.0.1', '2017-10-21 15:38:52'),
(39, '127.0.0.1', '2017-10-21 15:39:27'),
(40, '127.0.0.1', '2017-10-21 15:39:44'),
(41, '127.0.0.1', '2017-10-21 15:40:00'),
(42, '127.0.0.1', '2017-10-21 15:40:05'),
(43, '127.0.0.1', '2017-10-21 15:40:14'),
(44, '127.0.0.1', '2017-10-21 15:40:27'),
(45, '127.0.0.1', '2017-10-21 15:40:35'),
(46, '127.0.0.1', '2017-10-21 15:46:51'),
(47, '127.0.0.1', '2017-10-21 15:47:01'),
(48, '127.0.0.1', '2017-10-21 15:47:14'),
(49, '127.0.0.1', '2017-10-21 15:47:38'),
(50, '127.0.0.1', '2017-10-21 15:48:35'),
(51, '127.0.0.1', '2017-10-21 15:48:37'),
(52, '127.0.0.1', '2017-10-21 15:48:43'),
(53, '127.0.0.1', '2017-10-21 15:48:47'),
(54, '127.0.0.1', '2017-10-21 15:48:52'),
(55, '127.0.0.1', '2017-10-21 15:48:56'),
(56, '127.0.0.1', '2017-10-21 15:49:03'),
(57, '127.0.0.1', '2017-10-21 15:49:07'),
(58, '127.0.0.1', '2017-10-21 16:29:11'),
(59, '127.0.0.1', '2017-10-21 16:30:56'),
(60, '127.0.0.1', '2017-10-21 16:31:02'),
(61, '127.0.0.1', '2017-10-21 16:32:17'),
(62, '127.0.0.1', '2017-10-21 16:32:36'),
(63, '127.0.0.1', '2017-10-21 16:33:55'),
(64, '127.0.0.1', '2017-10-23 01:14:29'),
(65, '127.0.0.1', '2017-10-23 01:16:43'),
(66, '127.0.0.1', '2017-10-23 01:16:57'),
(67, '127.0.0.1', '2017-10-23 01:17:00'),
(68, '127.0.0.1', '2017-10-23 01:57:04'),
(69, '127.0.0.1', '2017-10-23 01:57:08'),
(70, '127.0.0.1', '2017-10-23 01:57:14'),
(71, '127.0.0.1', '2017-10-23 01:57:42'),
(72, '127.0.0.1', '2017-10-23 01:57:46'),
(73, '127.0.0.1', '2017-10-23 01:58:08'),
(74, '127.0.0.1', '2017-10-23 01:58:19'),
(75, '127.0.0.1', '2017-10-23 01:59:00'),
(76, '127.0.0.1', '2017-10-23 01:59:06'),
(77, '127.0.0.1', '2017-10-23 02:00:22'),
(78, '127.0.0.1', '2017-10-23 02:11:28'),
(79, '127.0.0.1', '2017-10-23 02:12:24'),
(80, '::1', '2017-10-23 02:12:29'),
(81, '127.0.0.1', '2017-10-23 02:12:49'),
(82, '::1', '2017-10-23 02:13:25'),
(83, '127.0.0.1', '2017-10-23 02:13:37'),
(84, '127.0.0.1', '2017-10-23 02:13:48'),
(85, '127.0.0.1', '2017-10-23 02:14:45'),
(86, '127.0.0.1', '2017-10-23 02:39:46'),
(87, '127.0.0.1', '2017-10-23 02:39:53'),
(88, '127.0.0.1', '2017-10-23 02:40:16'),
(89, '127.0.0.1', '2017-10-23 20:56:18'),
(90, '127.0.0.1', '2017-10-23 20:59:27'),
(91, '127.0.0.1', '2017-10-23 21:00:14'),
(92, '127.0.0.1', '2017-10-23 21:02:00'),
(93, '127.0.0.1', '2017-10-23 21:02:47'),
(94, '127.0.0.1', '2017-10-23 21:03:02'),
(95, '127.0.0.1', '2017-10-23 21:12:13'),
(96, '127.0.0.1', '2017-10-23 21:12:17'),
(97, '127.0.0.1', '2017-10-23 21:13:10'),
(98, '127.0.0.1', '2017-10-23 21:14:03'),
(99, '127.0.0.1', '2017-10-23 21:14:23'),
(100, '127.0.0.1', '2017-10-23 21:14:28'),
(101, '127.0.0.1', '2017-10-23 21:22:36'),
(102, '127.0.0.1', '2017-10-23 21:23:11'),
(103, '127.0.0.1', '2017-10-23 21:23:15'),
(104, '127.0.0.1', '2017-10-23 21:30:43'),
(105, '127.0.0.1', '2017-10-24 15:15:34'),
(106, '127.0.0.1', '2017-10-24 15:15:48'),
(107, '127.0.0.1', '2017-10-24 15:16:23'),
(108, '127.0.0.1', '2017-10-24 15:16:54'),
(109, '127.0.0.1', '2017-10-24 19:08:19'),
(110, '127.0.0.1', '2017-10-24 19:08:19'),
(111, '127.0.0.1', '2017-10-24 19:08:19'),
(112, '127.0.0.1', '2017-10-24 19:11:33'),
(113, '127.0.0.1', '2017-10-24 19:11:33'),
(114, '127.0.0.1', '2017-10-24 19:11:33'),
(115, '127.0.0.1', '2017-10-24 19:12:14'),
(116, '127.0.0.1', '2017-10-24 19:12:14'),
(117, '127.0.0.1', '2017-10-24 19:12:14'),
(118, '127.0.0.1', '2017-10-24 19:14:16'),
(119, '127.0.0.1', '2017-10-24 19:14:16'),
(120, '127.0.0.1', '2017-10-24 19:14:16'),
(121, '127.0.0.1', '2017-10-24 19:14:26'),
(122, '127.0.0.1', '2017-10-24 19:14:26'),
(123, '127.0.0.1', '2017-10-24 19:14:26'),
(124, '127.0.0.1', '2017-10-24 19:15:23'),
(125, '127.0.0.1', '2017-10-24 19:15:23'),
(126, '127.0.0.1', '2017-10-24 19:15:23'),
(127, '127.0.0.1', '2017-10-24 19:16:04'),
(128, '127.0.0.1', '2017-10-24 19:16:04'),
(129, '127.0.0.1', '2017-10-24 19:16:04'),
(130, '127.0.0.1', '2017-10-24 19:17:52'),
(131, '127.0.0.1', '2017-10-24 19:17:52'),
(132, '127.0.0.1', '2017-10-24 19:17:52'),
(133, '127.0.0.1', '2017-10-24 19:18:31'),
(134, '127.0.0.1', '2017-10-24 19:18:31'),
(135, '127.0.0.1', '2017-10-24 19:18:31'),
(136, '127.0.0.1', '2017-10-24 19:20:50'),
(137, '127.0.0.1', '2017-10-24 19:20:50'),
(138, '127.0.0.1', '2017-10-24 19:20:50'),
(139, '127.0.0.1', '2017-10-24 20:10:30'),
(140, '127.0.0.1', '2017-10-24 20:10:30'),
(141, '127.0.0.1', '2017-10-24 20:10:30'),
(142, '127.0.0.1', '2017-10-24 20:10:59'),
(143, '127.0.0.1', '2017-10-24 20:10:59'),
(144, '127.0.0.1', '2017-10-24 20:10:59'),
(145, '127.0.0.1', '2017-10-24 20:12:05'),
(146, '127.0.0.1', '2017-10-24 20:12:05'),
(147, '127.0.0.1', '2017-10-24 20:12:05'),
(148, '127.0.0.1', '2017-10-24 20:12:16'),
(149, '127.0.0.1', '2017-10-24 20:12:16'),
(150, '127.0.0.1', '2017-10-24 20:12:16'),
(151, '127.0.0.1', '2017-10-24 20:12:27'),
(152, '127.0.0.1', '2017-10-24 20:12:27'),
(153, '127.0.0.1', '2017-10-24 20:12:27'),
(154, '127.0.0.1', '2017-10-24 20:12:37'),
(155, '127.0.0.1', '2017-10-24 20:12:37'),
(156, '127.0.0.1', '2017-10-24 20:12:37'),
(157, '127.0.0.1', '2017-10-24 20:13:42'),
(158, '127.0.0.1', '2017-10-24 20:13:42'),
(159, '127.0.0.1', '2017-10-24 20:13:42'),
(160, '127.0.0.1', '2017-10-24 20:14:21'),
(161, '127.0.0.1', '2017-10-24 20:14:21'),
(162, '127.0.0.1', '2017-10-24 20:14:21'),
(163, '127.0.0.1', '2017-10-24 20:14:49'),
(164, '127.0.0.1', '2017-10-24 20:14:49'),
(165, '127.0.0.1', '2017-10-24 20:14:49'),
(166, '127.0.0.1', '2017-10-24 20:15:13'),
(167, '127.0.0.1', '2017-10-24 20:15:13'),
(168, '127.0.0.1', '2017-10-24 20:15:13'),
(169, '127.0.0.1', '2017-10-24 20:15:24'),
(170, '127.0.0.1', '2017-10-24 20:15:24'),
(171, '127.0.0.1', '2017-10-24 20:15:24'),
(172, '127.0.0.1', '2017-10-24 20:16:31'),
(173, '127.0.0.1', '2017-10-24 20:16:31'),
(174, '127.0.0.1', '2017-10-24 20:16:31'),
(175, '127.0.0.1', '2017-10-24 20:16:41'),
(176, '127.0.0.1', '2017-10-24 20:16:41'),
(177, '127.0.0.1', '2017-10-24 20:16:41'),
(178, '127.0.0.1', '2017-10-24 20:16:54'),
(179, '127.0.0.1', '2017-10-24 20:16:54'),
(180, '127.0.0.1', '2017-10-24 20:16:54'),
(181, '127.0.0.1', '2017-10-24 20:25:38'),
(182, '127.0.0.1', '2017-10-24 20:25:38'),
(183, '127.0.0.1', '2017-10-24 20:25:38'),
(184, '127.0.0.1', '2017-10-24 20:40:56'),
(185, '127.0.0.1', '2017-10-24 20:40:56'),
(186, '127.0.0.1', '2017-10-24 20:40:56'),
(187, '127.0.0.1', '2017-10-24 20:41:42'),
(188, '127.0.0.1', '2017-10-24 20:41:42'),
(189, '127.0.0.1', '2017-10-24 20:41:42'),
(190, '127.0.0.1', '2017-10-24 20:43:36'),
(191, '127.0.0.1', '2017-10-24 20:43:36'),
(192, '127.0.0.1', '2017-10-24 20:43:36'),
(193, '127.0.0.1', '2017-10-24 20:44:10'),
(194, '127.0.0.1', '2017-10-24 20:44:10'),
(195, '127.0.0.1', '2017-10-24 20:44:10'),
(196, '127.0.0.1', '2017-10-24 20:45:00'),
(197, '127.0.0.1', '2017-10-24 20:45:00'),
(198, '127.0.0.1', '2017-10-24 20:45:00'),
(199, '127.0.0.1', '2017-10-24 20:45:22'),
(200, '127.0.0.1', '2017-10-24 20:45:22'),
(201, '127.0.0.1', '2017-10-24 20:45:22'),
(202, '127.0.0.1', '2017-10-24 20:47:31'),
(203, '127.0.0.1', '2017-10-24 20:47:31'),
(204, '127.0.0.1', '2017-10-24 20:47:31'),
(205, '127.0.0.1', '2017-10-24 20:48:15'),
(206, '127.0.0.1', '2017-10-24 20:48:15'),
(207, '127.0.0.1', '2017-10-24 20:48:15'),
(208, '127.0.0.1', '2017-10-24 20:55:15'),
(209, '127.0.0.1', '2017-10-24 20:55:15'),
(210, '127.0.0.1', '2017-10-24 20:55:15'),
(211, '127.0.0.1', '2017-10-24 20:55:25'),
(212, '127.0.0.1', '2017-10-24 20:55:25'),
(213, '127.0.0.1', '2017-10-24 20:55:25'),
(214, '127.0.0.1', '2017-10-24 20:57:19'),
(215, '127.0.0.1', '2017-10-24 20:57:19'),
(216, '127.0.0.1', '2017-10-24 20:57:19'),
(217, '127.0.0.1', '2017-10-24 20:57:56'),
(218, '127.0.0.1', '2017-10-24 20:57:56'),
(219, '127.0.0.1', '2017-10-24 20:57:56'),
(220, '127.0.0.1', '2017-10-24 21:01:26'),
(221, '127.0.0.1', '2017-10-24 21:01:26'),
(222, '127.0.0.1', '2017-10-24 21:01:26'),
(223, '127.0.0.1', '2017-10-24 21:02:06'),
(224, '127.0.0.1', '2017-10-24 21:02:06'),
(225, '127.0.0.1', '2017-10-24 21:02:06'),
(226, '127.0.0.1', '2017-10-24 21:05:06'),
(227, '127.0.0.1', '2017-10-24 21:05:06'),
(228, '127.0.0.1', '2017-10-24 21:05:06'),
(229, '127.0.0.1', '2017-10-24 23:33:37'),
(230, '127.0.0.1', '2017-10-24 23:33:37'),
(231, '127.0.0.1', '2017-10-24 23:33:37'),
(232, '127.0.0.1', '2017-10-24 23:34:10'),
(233, '127.0.0.1', '2017-10-24 23:34:10'),
(234, '127.0.0.1', '2017-10-24 23:34:10'),
(235, '127.0.0.1', '2017-10-24 23:46:06'),
(236, '127.0.0.1', '2017-10-24 23:46:06'),
(237, '127.0.0.1', '2017-10-24 23:46:06'),
(238, '127.0.0.1', '2017-10-25 00:01:42'),
(239, '127.0.0.1', '2017-10-25 00:01:42'),
(240, '127.0.0.1', '2017-10-25 00:01:42'),
(241, '127.0.0.1', '2017-10-25 00:02:32'),
(242, '127.0.0.1', '2017-10-25 00:02:32'),
(243, '127.0.0.1', '2017-10-25 00:02:32'),
(244, '127.0.0.1', '2017-10-25 00:02:56'),
(245, '127.0.0.1', '2017-10-25 00:02:56'),
(246, '127.0.0.1', '2017-10-25 00:02:56'),
(247, '127.0.0.1', '2017-10-25 00:02:59'),
(248, '127.0.0.1', '2017-10-25 00:03:12'),
(249, '127.0.0.1', '2017-10-25 00:03:15'),
(250, '127.0.0.1', '2017-10-25 00:03:15'),
(251, '127.0.0.1', '2017-10-25 00:03:15'),
(252, '127.0.0.1', '2017-10-25 00:03:41'),
(253, '127.0.0.1', '2017-10-25 00:03:41'),
(254, '127.0.0.1', '2017-10-25 00:03:41'),
(255, '127.0.0.1', '2017-10-25 00:04:09'),
(256, '127.0.0.1', '2017-10-25 00:04:09'),
(257, '127.0.0.1', '2017-10-25 00:04:09'),
(258, '127.0.0.1', '2017-10-25 00:04:10'),
(259, '127.0.0.1', '2017-10-25 00:06:45'),
(260, '127.0.0.1', '2017-10-25 00:06:46'),
(261, '127.0.0.1', '2017-10-25 00:07:19'),
(262, '127.0.0.1', '2017-10-25 00:07:19'),
(263, '127.0.0.1', '2017-10-25 00:09:18'),
(264, '127.0.0.1', '2017-10-25 00:09:18'),
(265, '127.0.0.1', '2017-10-25 00:10:04'),
(266, '127.0.0.1', '2017-10-25 00:10:04'),
(267, '127.0.0.1', '2017-10-25 00:10:04'),
(268, '127.0.0.1', '2017-10-25 00:10:22'),
(269, '127.0.0.1', '2017-10-25 00:10:22'),
(270, '127.0.0.1', '2017-10-25 00:10:22'),
(271, '127.0.0.1', '2017-10-25 00:10:39'),
(272, '127.0.0.1', '2017-10-25 00:10:39'),
(273, '127.0.0.1', '2017-10-25 00:10:39'),
(274, '127.0.0.1', '2017-10-25 00:15:09'),
(275, '127.0.0.1', '2017-10-25 00:15:09'),
(276, '127.0.0.1', '2017-10-25 00:15:09'),
(277, '127.0.0.1', '2017-10-25 00:24:26'),
(278, '127.0.0.1', '2017-10-25 00:24:26'),
(279, '127.0.0.1', '2017-10-25 00:27:09'),
(280, '127.0.0.1', '2017-10-25 00:27:09'),
(281, '127.0.0.1', '2017-10-25 00:27:09'),
(282, '127.0.0.1', '2017-10-25 00:27:44'),
(283, '127.0.0.1', '2017-10-25 00:27:44'),
(284, '127.0.0.1', '2017-10-25 00:27:44'),
(285, '127.0.0.1', '2017-10-25 00:28:10'),
(286, '127.0.0.1', '2017-10-25 00:28:10'),
(287, '127.0.0.1', '2017-10-25 00:28:10'),
(288, '127.0.0.1', '2017-10-25 00:28:50'),
(289, '127.0.0.1', '2017-10-25 00:28:50'),
(290, '127.0.0.1', '2017-10-25 00:28:50'),
(291, '127.0.0.1', '2017-10-25 00:34:07'),
(292, '127.0.0.1', '2017-10-25 00:34:07'),
(293, '127.0.0.1', '2017-10-25 00:34:07'),
(294, '127.0.0.1', '2017-10-25 00:34:41'),
(295, '127.0.0.1', '2017-10-25 00:34:41'),
(296, '127.0.0.1', '2017-10-25 00:34:41'),
(297, '127.0.0.1', '2017-10-25 00:35:02'),
(298, '127.0.0.1', '2017-10-25 00:35:02'),
(299, '127.0.0.1', '2017-10-25 00:35:02'),
(300, '127.0.0.1', '2017-10-25 00:35:19'),
(301, '127.0.0.1', '2017-10-25 00:35:19'),
(302, '127.0.0.1', '2017-10-25 00:35:19'),
(303, '127.0.0.1', '2017-10-25 00:46:52'),
(304, '127.0.0.1', '2017-10-25 00:46:52'),
(305, '127.0.0.1', '2017-10-25 00:46:52'),
(306, '127.0.0.1', '2017-10-25 00:46:58'),
(307, '127.0.0.1', '2017-10-25 00:46:58'),
(308, '127.0.0.1', '2017-10-25 00:46:58'),
(309, '127.0.0.1', '2017-10-25 00:47:03'),
(310, '127.0.0.1', '2017-10-25 00:47:03'),
(311, '127.0.0.1', '2017-10-25 00:47:03'),
(312, '127.0.0.1', '2017-10-25 00:47:37'),
(313, '127.0.0.1', '2017-10-25 00:47:37'),
(314, '127.0.0.1', '2017-10-25 00:47:37'),
(315, '127.0.0.1', '2017-10-25 00:47:56'),
(316, '127.0.0.1', '2017-10-25 00:47:56'),
(317, '127.0.0.1', '2017-10-25 00:47:56'),
(318, '127.0.0.1', '2017-10-25 00:47:59'),
(319, '127.0.0.1', '2017-10-25 00:47:59'),
(320, '127.0.0.1', '2017-10-25 00:47:59'),
(321, '127.0.0.1', '2017-10-25 00:48:19'),
(322, '127.0.0.1', '2017-10-25 00:48:19'),
(323, '127.0.0.1', '2017-10-25 00:48:19'),
(324, '127.0.0.1', '2017-10-25 00:48:22'),
(325, '127.0.0.1', '2017-10-25 00:48:22'),
(326, '127.0.0.1', '2017-10-25 00:48:22'),
(327, '127.0.0.1', '2017-10-25 00:52:45'),
(328, '127.0.0.1', '2017-10-25 00:52:45'),
(329, '127.0.0.1', '2017-10-25 00:52:45'),
(330, '127.0.0.1', '2017-10-25 00:52:49'),
(331, '127.0.0.1', '2017-10-25 00:52:49'),
(332, '127.0.0.1', '2017-10-25 00:52:49'),
(333, '127.0.0.1', '2017-10-25 00:52:52'),
(334, '127.0.0.1', '2017-10-25 00:52:52'),
(335, '127.0.0.1', '2017-10-25 00:52:52'),
(336, '127.0.0.1', '2017-10-25 00:54:12'),
(337, '127.0.0.1', '2017-10-25 00:54:12'),
(338, '127.0.0.1', '2017-10-25 00:54:12'),
(339, '127.0.0.1', '2017-10-25 00:54:21'),
(340, '127.0.0.1', '2017-10-25 00:54:21'),
(341, '127.0.0.1', '2017-10-25 00:54:21'),
(342, '127.0.0.1', '2017-10-25 00:55:00'),
(343, '127.0.0.1', '2017-10-25 00:55:00'),
(344, '127.0.0.1', '2017-10-25 00:55:00'),
(345, '127.0.0.1', '2017-10-25 00:55:05'),
(346, '127.0.0.1', '2017-10-25 00:55:05'),
(347, '127.0.0.1', '2017-10-25 00:55:05'),
(348, '127.0.0.1', '2017-10-25 14:57:39'),
(349, '127.0.0.1', '2017-10-25 14:57:39'),
(350, '127.0.0.1', '2017-10-25 14:57:39'),
(351, '127.0.0.1', '2017-10-25 14:58:20'),
(352, '127.0.0.1', '2017-10-25 14:58:20'),
(353, '127.0.0.1', '2017-10-25 14:58:20'),
(354, '127.0.0.1', '2017-10-25 14:58:20'),
(355, '127.0.0.1', '2017-10-25 14:58:20'),
(356, '127.0.0.1', '2017-10-25 14:58:24'),
(357, '127.0.0.1', '2017-10-25 15:01:51'),
(358, '127.0.0.1', '2017-10-25 15:01:51'),
(359, '127.0.0.1', '2017-10-25 15:01:51'),
(360, '127.0.0.1', '2017-10-25 15:05:22'),
(361, '127.0.0.1', '2017-10-25 15:05:22'),
(362, '127.0.0.1', '2017-10-25 15:05:22'),
(363, '127.0.0.1', '2017-10-25 15:08:52'),
(364, '127.0.0.1', '2017-10-25 15:08:52'),
(365, '127.0.0.1', '2017-10-25 15:08:52'),
(366, '127.0.0.1', '2017-10-25 15:12:23'),
(367, '127.0.0.1', '2017-10-25 15:12:23'),
(368, '127.0.0.1', '2017-10-25 15:12:23'),
(369, '127.0.0.1', '2017-10-25 15:15:54'),
(370, '127.0.0.1', '2017-10-25 15:15:54'),
(371, '127.0.0.1', '2017-10-25 15:15:54'),
(372, '127.0.0.1', '2017-10-25 15:18:34'),
(373, '127.0.0.1', '2017-10-25 15:19:12'),
(374, '127.0.0.1', '2017-10-25 15:39:10'),
(375, '127.0.0.1', '2017-10-25 15:39:41'),
(376, '127.0.0.1', '2017-10-25 15:41:11'),
(377, '127.0.0.1', '2017-10-25 15:41:30'),
(378, '127.0.0.1', '2017-10-25 15:41:48'),
(379, '127.0.0.1', '2017-10-25 15:43:23'),
(380, '127.0.0.1', '2017-10-25 15:43:56'),
(381, '127.0.0.1', '2017-10-25 15:45:11'),
(382, '127.0.0.1', '2017-10-25 15:45:52'),
(383, '127.0.0.1', '2017-10-25 15:46:18'),
(384, '127.0.0.1', '2017-10-25 15:48:34'),
(385, '127.0.0.1', '2017-10-25 15:48:57'),
(386, '127.0.0.1', '2017-10-25 15:49:15'),
(387, '127.0.0.1', '2017-10-25 16:00:57'),
(388, '127.0.0.1', '2017-10-25 16:04:05'),
(389, '127.0.0.1', '2017-10-25 16:21:16'),
(390, '127.0.0.1', '2017-10-25 16:21:51'),
(391, '127.0.0.1', '2017-10-25 16:23:34'),
(392, '127.0.0.1', '2017-10-25 16:28:06'),
(393, '127.0.0.1', '2017-10-25 16:29:35'),
(394, '127.0.0.1', '2017-10-25 16:30:35'),
(395, '127.0.0.1', '2017-10-25 16:32:53'),
(396, '127.0.0.1', '2017-10-25 16:35:48'),
(397, '127.0.0.1', '2017-10-25 17:06:49'),
(398, '127.0.0.1', '2017-10-25 17:07:08'),
(399, '127.0.0.1', '2017-10-25 17:07:32'),
(400, '127.0.0.1', '2017-10-25 17:08:01'),
(401, '127.0.0.1', '2017-10-25 17:08:44'),
(402, '127.0.0.1', '2017-10-25 17:18:34'),
(403, '127.0.0.1', '2017-10-25 17:26:29'),
(404, '127.0.0.1', '2017-10-25 17:26:48'),
(405, '127.0.0.1', '2017-10-25 17:32:52'),
(406, '127.0.0.1', '2017-10-25 17:33:13'),
(407, '127.0.0.1', '2017-10-25 17:35:56'),
(408, '127.0.0.1', '2017-10-25 17:53:02'),
(409, '127.0.0.1', '2017-10-25 17:53:24'),
(410, '127.0.0.1', '2017-10-25 17:53:30'),
(411, '127.0.0.1', '2017-10-25 17:58:42'),
(412, '127.0.0.1', '2017-10-25 17:59:07'),
(413, '127.0.0.1', '2017-10-25 17:59:30'),
(414, '127.0.0.1', '2017-10-25 18:01:07'),
(415, '127.0.0.1', '2017-10-25 18:03:05'),
(416, '127.0.0.1', '2017-10-25 18:04:27'),
(417, '127.0.0.1', '2017-10-25 18:04:41'),
(418, '127.0.0.1', '2017-10-25 18:05:14'),
(419, '127.0.0.1', '2017-10-25 18:05:20'),
(420, '127.0.0.1', '2017-10-25 18:05:41'),
(421, '127.0.0.1', '2017-10-25 18:06:55'),
(422, '127.0.0.1', '2017-10-25 18:07:11'),
(423, '127.0.0.1', '2017-10-25 18:09:17'),
(424, '127.0.0.1', '2017-10-25 18:09:43');

-- --------------------------------------------------------

--
-- Estrutura da tabela `unit`
--

CREATE TABLE IF NOT EXISTS `unit` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `value` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Extraindo dados da tabela `unit`
--

INSERT INTO `unit` (`id`, `value`) VALUES
(1, 'liters'),
(2, 'celsius'),
(3, 'kilograms'),
(4, 'grams');

-- --------------------------------------------------------

--
-- Estrutura da tabela `yeast`
--

CREATE TABLE IF NOT EXISTS `yeast` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Extraindo dados da tabela `yeast`
--

INSERT INTO `yeast` (`id`, `name`) VALUES
(1, 'Wyeast 1056 - American Ale™');

--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `beer`
--
ALTER TABLE `beer`
  ADD CONSTRAINT `fk_beer_ferm_temp_unit` FOREIGN KEY (`ferm_temp_unit`) REFERENCES `unit` (`id`),
  ADD CONSTRAINT `fk_bee_vol_uni` FOREIGN KEY (`volume_unit`) REFERENCES `unit` (`id`);

--
-- Limitadores para a tabela `beer_food_pairing`
--
ALTER TABLE `beer_food_pairing`
  ADD CONSTRAINT `fk_bfp_beer` FOREIGN KEY (`id_beer`) REFERENCES `beer` (`id`),
  ADD CONSTRAINT `fk_bfp_food_pairing` FOREIGN KEY (`id_food_pairing`) REFERENCES `food_pairing` (`id`);

--
-- Limitadores para a tabela `beer_hop`
--
ALTER TABLE `beer_hop`
  ADD CONSTRAINT `fk_bh_amount_unit` FOREIGN KEY (`amount_unit`) REFERENCES `unit` (`id`),
  ADD CONSTRAINT `fk_bh_attribute` FOREIGN KEY (`id_attribute`) REFERENCES `attribute` (`id`),
  ADD CONSTRAINT `fk_bh_beer` FOREIGN KEY (`id_beer`) REFERENCES `beer` (`id`),
  ADD CONSTRAINT `fk_bh_hop` FOREIGN KEY (`id_hop`) REFERENCES `hop` (`id`);

--
-- Limitadores para a tabela `beer_malt`
--
ALTER TABLE `beer_malt`
  ADD CONSTRAINT `fk_bm_amount_unit` FOREIGN KEY (`amount_unit`) REFERENCES `unit` (`id`),
  ADD CONSTRAINT `fk_bm_beer` FOREIGN KEY (`id_beer`) REFERENCES `beer` (`id`),
  ADD CONSTRAINT `fk_bm_malt` FOREIGN KEY (`id_malt`) REFERENCES `malt` (`id`);

--
-- Limitadores para a tabela `beer_yeast`
--
ALTER TABLE `beer_yeast`
  ADD CONSTRAINT `fk_by_beer` FOREIGN KEY (`id_beer`) REFERENCES `beer` (`id`),
  ADD CONSTRAINT `fk_by_yeast` FOREIGN KEY (`id_yeast`) REFERENCES `yeast` (`id`);

--
-- Limitadores para a tabela `mash_temp`
--
ALTER TABLE `mash_temp`
  ADD CONSTRAINT `fk_mash_beer` FOREIGN KEY (`id_beer`) REFERENCES `beer` (`id`),
  ADD CONSTRAINT `fk_mash_temp_unit` FOREIGN KEY (`temp_unit`) REFERENCES `unit` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;