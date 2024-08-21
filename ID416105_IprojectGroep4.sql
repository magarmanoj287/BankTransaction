-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: com-linweb089.srv.combell-ops.net:3306
-- Gegenereerd op: 28 apr 2024 om 12:20
-- Serverversie: 5.7.44-49-log
-- PHP-versie: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ID416105_IprojectGroep4`
--

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `ACCOUNTS`
--

CREATE TABLE `ACCOUNTS` (
  `id` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `balance` decimal(18,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `ACCOUNTS`
--

INSERT INTO `ACCOUNTS` (`id`, `password`, `balance`) VALUES
('BE 176875448', 'de zon', 15.00),
('BE 196875312', 'de maan', 19597.00),
('BE12456866546392', 'paswoord2', 2177.00),
('BE16456487177574', 'paswoord3', 238.00),
('BE17456346512521', 'paswoord7', 1598.00),
('BE19456211148112', 'paswoord6', 856.00),
('BE25436676237882', 'paswoord10', 863.00),
('BE33456439984246', 'paswoord4', 2300.00),
('BE40485452171863', 'paswoord9', 6135.00);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `ACK_IN`
--

CREATE TABLE `ACK_IN` (
  `po_id` varchar(30) NOT NULL,
  `po_amount` decimal(18,2) NOT NULL,
  `po_message` varchar(255) DEFAULT NULL,
  `po_datetime` datetime NOT NULL,
  `ob_id` varchar(50) NOT NULL,
  `oa_id` varchar(50) NOT NULL,
  `ob_code` varchar(50) NOT NULL,
  `ob_datetime` datetime NOT NULL,
  `cb_code` varchar(50) NOT NULL,
  `cb_datetime` datetime NOT NULL,
  `bb_id` varchar(50) NOT NULL,
  `ba_id` varchar(50) NOT NULL,
  `bb_code` varchar(50) DEFAULT NULL,
  `bb_datetime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `ACK_IN`
--

INSERT INTO `ACK_IN` (`po_id`, `po_amount`, `po_message`, `po_datetime`, `ob_id`, `oa_id`, `ob_code`, `ob_datetime`, `cb_code`, `cb_datetime`, `bb_id`, `ba_id`, `bb_code`, `bb_datetime`) VALUES
('FUTOBE37_kerPLoN', 25.00, 'postman api test', '2024-04-25 09:52:39', 'FUTOBE37', 'BE40485452171863', '2000', '2024-04-25 09:53:00', '2014', '2024-04-25 09:53:39', 'TEBABE86', 'BE11233273374548', '2058', '2024-04-25 09:00:06');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `ACK_OUT`
--

CREATE TABLE `ACK_OUT` (
  `po_id` varchar(30) NOT NULL,
  `po_amount` decimal(18,2) NOT NULL,
  `po_message` varchar(255) DEFAULT NULL,
  `po_datetime` datetime NOT NULL,
  `ob_id` varchar(50) NOT NULL,
  `oa_id` varchar(50) NOT NULL,
  `ob_code` varchar(50) NOT NULL,
  `ob_datetime` datetime NOT NULL,
  `cb_code` varchar(50) NOT NULL,
  `cb_datetime` datetime NOT NULL,
  `bb_id` varchar(50) NOT NULL,
  `ba_id` varchar(50) NOT NULL,
  `bb_code` varchar(50) NOT NULL,
  `bb_datetime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `ACK_OUT`
--

INSERT INTO `ACK_OUT` (`po_id`, `po_amount`, `po_message`, `po_datetime`, `ob_id`, `oa_id`, `ob_code`, `ob_datetime`, `cb_code`, `cb_datetime`, `bb_id`, `ba_id`, `bb_code`, `bb_datetime`) VALUES
('FUTOBE37_kerPLoN', 25.00, 'postman api test', '2024-04-25 09:52:39', 'FUTOBE37', 'BE40485452171863', '2000', '2024-04-25 09:53:00', '2014', '2024-04-25 09:53:39', 'TEBABE86', 'BE11233273374548', '2058', '2024-04-25 09:00:06');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `INFO`
--

CREATE TABLE `INFO` (
  `id` varchar(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `INFO`
--

INSERT INTO `INFO` (`id`, `name`, `description`) VALUES
('FUTOBE37', 'NexaBank', 'Sofiane Rghioui, Ilias Chafaï , Manoj Magar, Kwinten Lauwerys, Sam De Lombaert, Adam El Bouab');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `LOG`
--

CREATE TABLE `LOG` (
  `id` int(11) NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `po_id` varchar(30) DEFAULT NULL,
  `po_amount` decimal(18,2) DEFAULT NULL,
  `po_message` varchar(255) DEFAULT NULL,
  `po_datetime` datetime DEFAULT NULL,
  `ob_id` varchar(30) DEFAULT NULL,
  `oa_id` varchar(30) DEFAULT NULL,
  `ob_code` varchar(50) DEFAULT NULL,
  `ob_datetime` datetime DEFAULT NULL,
  `cb_code` varchar(50) DEFAULT NULL,
  `cb_datetime` datetime DEFAULT NULL,
  `bb_id` varchar(30) DEFAULT NULL,
  `ba_id` varchar(30) DEFAULT NULL,
  `bb_code` varchar(50) DEFAULT NULL,
  `bb_datetime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `PO_NEW`
--

CREATE TABLE `PO_NEW` (
  `po_id` varchar(30) NOT NULL,
  `po_amount` decimal(18,2) NOT NULL,
  `po_message` text,
  `po_datetime` datetime NOT NULL,
  `ob_id` varchar(30) NOT NULL,
  `oa_id` varchar(30) NOT NULL,
  `ob_code` varchar(50) DEFAULT NULL,
  `ob_datetime` datetime DEFAULT NULL,
  `cb_code` varchar(50) DEFAULT NULL,
  `cb_datetime` datetime DEFAULT NULL,
  `bb_id` varchar(30) NOT NULL,
  `ba_id` varchar(30) NOT NULL,
  `bb_code` varchar(50) DEFAULT NULL,
  `bb_datetime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `PO_OUT`
--

CREATE TABLE `PO_OUT` (
  `po_id` varchar(30) NOT NULL,
  `po_amount` decimal(18,2) NOT NULL,
  `po_message` varchar(255) DEFAULT NULL,
  `po_datetime` datetime NOT NULL,
  `ob_id` varchar(30) NOT NULL,
  `oa_id` varchar(30) NOT NULL,
  `ob_code` varchar(50) NOT NULL,
  `ob_datetime` datetime NOT NULL,
  `cb_code` varchar(50) DEFAULT NULL,
  `cb_datetime` datetime DEFAULT NULL,
  `bb_id` varchar(30) NOT NULL,
  `ba_id` varchar(30) NOT NULL,
  `bb_code` varchar(50) DEFAULT NULL,
  `bb_datetime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `PO_OUT`
--

INSERT INTO `PO_OUT` (`po_id`, `po_amount`, `po_message`, `po_datetime`, `ob_id`, `oa_id`, `ob_code`, `ob_datetime`, `cb_code`, `cb_datetime`, `bb_id`, `ba_id`, `bb_code`, `bb_datetime`) VALUES
('AXABBE22662d1cdf899c50.1712254', 180.00, 'Payment for utilities', '2024-04-23 11:50:05', 'AXABBE22', 'IBAN567890123', 'OB-005', '2024-04-23 11:50:05', '', '2024-04-27 17:42:23', 'OONXBEBB', 'IBAN543210987', '', '2024-04-27 17:42:23');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `TRANSACTION`
--

CREATE TABLE `TRANSACTION` (
  `id` int(11) NOT NULL,
  `amount` decimal(18,2) DEFAULT NULL,
  `datetime` datetime DEFAULT NULL,
  `po_id` varchar(30) DEFAULT NULL,
  `account_id` varchar(50) DEFAULT NULL,
  `isvalid` tinyint(1) DEFAULT NULL,
  `iscomplete` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `TRANSACTION`
--

INSERT INTO `TRANSACTION` (`id`, `amount`, `datetime`, `po_id`, `account_id`, `isvalid`, `iscomplete`) VALUES
(1, 50.00, '2024-04-24 14:47:57', 'FUTOBE37_di7jLT5', 'BE33456439984246', 1, 1),
(2, -5.00, '2024-04-24 14:47:57', 'FUTOBE37_kerY4oN', 'BE40485452171863', 1, 1),
(3, -5.00, '2024-04-24 14:47:57', 'FUTOBE37_kerY4oN', 'BE40485452171863', 1, 1),
(4, 25.00, '2024-04-24 16:43:57', 'FUTOBE37_LogY4oN', 'BE40485452171863', 1, 1),
(5, -37.00, '2024-04-24 16:43:57', 'FUTOBE37_LoTRfY4oN', 'BE16456487177574', 1, 1),
(6, 37.00, '2024-04-24 16:43:57', 'FUTOBE37_LoTRfY4oN', 'BE12456866546392', 1, 1),
(7, -100.00, '2024-04-25 09:48:59', 'FUTOBE37_LoTRfYoN', 'BE33456439984246', 1, 1),
(8, 100.00, '2024-04-25 09:48:59', 'FUTOBE37_LoTRfYoN', 'BE12456866546392', 1, 1),
(9, -100.00, '2024-04-25 09:50:24', 'FUTOBE37_LoTRfYoN', 'BE33456439984246', 1, 1),
(10, 100.00, '2024-04-25 09:50:24', 'FUTOBE37_LoTRfYoN', 'BE12456866546392', 1, 1),
(11, -100.00, '2024-04-25 09:50:55', 'FUTOBE37_LoTRfYoN', 'BE33456439984246', 1, 1),
(12, 100.00, '2024-04-25 09:50:55', 'FUTOBE37_LoTRfYoN', 'BE12456866546392', 1, 1),
(13, -100.00, '2024-04-25 09:51:09', 'FUTOBE37_LoTRfYoN', 'BE33456439984246', 1, 1),
(14, 100.00, '2024-04-25 09:51:09', 'FUTOBE37_LoTRfYoN', 'BE12456866546392', 1, 1),
(15, -6.00, '2024-04-25 10:26:33', 'FUTOBE37_LoTRfYoN', 'BE33456439984246', 1, 1),
(16, 6.00, '2024-04-25 10:26:33', 'FUTOBE37_LoTRfYoN', 'BE12456866546392', 1, 1),
(17, -10.00, '2024-04-25 10:28:10', 'FUTOBE37_LoTRfYoN', 'BE33456439984246', 1, 1),
(18, 10.00, '2024-04-25 10:28:10', 'FUTOBE37_LoTRfYoN', 'BE12456866546392', 1, 1),
(19, -10.00, '2024-04-25 10:28:31', 'FUTOBE37_LoTRfYoN', 'BE33456439984246', 1, 1),
(20, 10.00, '2024-04-25 10:28:31', 'FUTOBE37_LoTRfYoN', 'BE12456866546392', 1, 1),
(21, -10.00, '2024-04-25 10:28:31', 'FUTOBE37_LoTRfYoN', 'BE33456439984246', 1, 1),
(22, 10.00, '2024-04-25 10:28:31', 'FUTOBE37_LoTRfYoN', 'BE12456866546392', 1, 1),
(23, -10.00, '2024-04-25 10:30:22', 'FUTOBE37_LoTRfYoN', 'BE33456439984246', 1, 1),
(24, 10.00, '2024-04-25 10:30:22', 'FUTOBE37_LoTRfYoN', 'BE12456866546392', 1, 1),
(25, -10.00, '2024-04-25 10:31:12', 'FUTOBE37_LoTRfYoN', 'BE33456439984246', 1, 1),
(26, 10.00, '2024-04-25 10:31:12', 'FUTOBE37_LoTRfYoN', 'BE12456866546392', 1, 1),
(27, -10.00, '2024-04-25 10:31:12', 'FUTOBE37_LoTRfYoN', 'BE33456439984246', 1, 1),
(28, 10.00, '2024-04-25 10:31:12', 'FUTOBE37_LoTRfYoN', 'BE12456866546392', 1, 1),
(29, -20.00, '2024-04-25 10:31:30', 'FUTOBE37_LoTRfYoN', 'BE33456439984246', 1, 1),
(30, 20.00, '2024-04-25 10:31:30', 'FUTOBE37_LoTRfYoN', 'BE12456866546392', 1, 1),
(31, -10.00, '2024-04-25 11:48:34', 'FUTOBE37_LoTRfYoN', 'BE33456439984246', 1, 1),
(32, 10.00, '2024-04-25 11:48:34', 'FUTOBE37_LoTRfYoN', 'BE12456866546392', 1, 1),
(33, -100.00, '2024-04-25 12:03:47', 'FUTOBE37_LoTRfYoN', 'BE33456439984246', 1, 1),
(34, 100.00, '2024-04-25 12:03:47', 'FUTOBE37_LoTRfYoN', 'BE12456866546392', 1, 1),
(35, -100.00, '2024-04-25 12:04:36', 'FUTOBE37_LoTRfYoN', 'BE33456439984246', 1, 1),
(36, 100.00, '2024-04-25 12:04:36', 'FUTOBE37_LoTRfYoN', 'BE12456866546392', 1, 1),
(37, -100.00, '2024-04-25 12:05:32', 'FUTOBE37_LoTRfYoN', 'BE33456439984246', 1, 1),
(38, 100.00, '2024-04-25 12:05:32', 'FUTOBE37_LoTRfYoN', 'BE12456866546392', 1, 1),
(39, -90.00, '2024-04-25 13:27:56', 'FUTOBE37_LoTRfYoN', 'BE33456439984246', 1, 1),
(40, 90.00, '2024-04-25 13:27:56', 'FUTOBE37_LoTRfYoN', 'BE12456866546392', 1, 1),
(41, -34.00, '2024-04-25 13:40:54', 'FUTOBE37_LoTRfYoN', 'BE33456439984246', 1, 1),
(42, 34.00, '2024-04-25 13:40:54', 'FUTOBE37_LoTRfYoN', 'BE40485452171863', 1, 1),
(43, -50.00, '2024-04-09 17:28:01', 'FUTOBE37_LoTRfYoN', 'BE33456439984246', 1, 1),
(44, 50.00, '2024-04-09 17:28:01', 'FUTOBE37_LoTRfYoN', 'BE40485452171863', 1, 1),
(45, -50.00, '2024-04-09 17:28:01', 'FUTOBE37_LoTRfYoN', 'BE33456439984246', 1, 1),
(46, 50.00, '2024-04-09 17:28:01', 'FUTOBE37_LoTRfYoN', 'BE40485452171863', 1, 1),
(47, -158.00, '2024-04-26 16:43:57', 'FUTOBE37_LoTRfgfoN', 'BE16456487177574', 1, 1),
(48, 158.00, '2024-04-26 16:43:57', 'FUTOBE37_LoTRfgfoN', 'BE12456866546392', 1, 1),
(49, -50.00, '2024-04-09 17:28:01', 'FUTOBE37_LoTRfYoN', 'BE19456211148112', 1, 1),
(50, 50.00, '2024-04-09 17:28:01', 'FUTOBE37_LoTRfYoN', 'BE40485452171863', 1, 1),
(51, -100.00, '2024-04-25 14:43:35', 'FUTOBE37_LoTRfYoN', 'BE33456439984246', 1, 1),
(52, 100.00, '2024-04-25 14:43:35', 'FUTOBE37_LoTRfYoN', 'BE42456456789012', 1, 1),
(53, -158.00, '2024-04-26 16:43:57', 'FUTOBE37_LoTRfgfoN', 'BE16456487177574', 1, 1),
(54, 158.00, '2024-04-26 16:43:57', 'FUTOBE37_LoTRfgfoN', 'BE12456866546392', 1, 1),
(55, -66.00, '2024-04-25 15:24:14', 'FUTOBE37_LoTRfYoN', 'BE33456439984246', 1, 1),
(56, 66.00, '2024-04-25 15:24:14', 'FUTOBE37_LoTRfYoN', 'BE12456866546392', 1, 1),
(57, -50.00, '2024-04-09 17:28:01', 'FUTOBE37_LoTRfYoN', 'BE19456211148112', 1, 1),
(58, 50.00, '2024-04-09 17:28:01', 'FUTOBE37_LoTRfYoN', 'BE40485452171863', 1, 1),
(59, 25.00, '2024-04-24 16:43:57', 'FUTOBE37_LogY4oN', 'BE40485452171863', 1, 1),
(60, -5.00, '2024-04-24 14:47:57', 'FUTOBE37_kerY4oN', 'BE40485452171863', 1, 1);

--
-- Indexen voor geëxporteerde tabellen
--

--
-- Indexen voor tabel `ACCOUNTS`
--
ALTER TABLE `ACCOUNTS`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `ACK_IN`
--
ALTER TABLE `ACK_IN`
  ADD PRIMARY KEY (`po_id`);

--
-- Indexen voor tabel `ACK_OUT`
--
ALTER TABLE `ACK_OUT`
  ADD PRIMARY KEY (`po_id`);

--
-- Indexen voor tabel `INFO`
--
ALTER TABLE `INFO`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `PO_NEW`
--
ALTER TABLE `PO_NEW`
  ADD PRIMARY KEY (`po_id`);

--
-- Indexen voor tabel `PO_OUT`
--
ALTER TABLE `PO_OUT`
  ADD PRIMARY KEY (`po_id`);

--
-- Indexen voor tabel `TRANSACTION`
--
ALTER TABLE `TRANSACTION`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT voor geëxporteerde tabellen
--

--
-- AUTO_INCREMENT voor een tabel `TRANSACTION`
--
ALTER TABLE `TRANSACTION`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
