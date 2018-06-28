-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 06 Noi 2017 la 19:25
-- Versiune server: 5.7.16-0ubuntu0.16.04.1
-- PHP Version: 7.0.8-0ubuntu0.16.04.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `health_care`
--

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `conversations`
--

CREATE TABLE `conversations` (
  `id` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `partner` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `conversations`
--

INSERT INTO `conversations` (`id`, `user`, `partner`) VALUES
(1, 11, 8),
(2, 8, 11),
(3, 13, 12),
(4, 12, 13),
(5, 96, 92),
(6, 92, 96),
(7, 95, 96),
(8, 96, 95),
(9, 97, 96),
(10, 96, 97),
(11, 188, 114),
(12, 114, 188),
(13, 92, 188),
(14, 188, 92),
(15, 206, 11),
(16, 11, 206),
(17, 185, 11),
(18, 11, 185);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `days`
--

CREATE TABLE `days` (
  `id` int(11) NOT NULL,
  `day` int(11) NOT NULL DEFAULT '0',
  `job_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `days`
--

INSERT INTO `days` (`id`, `day`, `job_id`) VALUES
(1, 2, 1),
(2, 4, 1),
(3, 6, 1),
(4, 2, 2),
(5, 4, 2),
(6, 6, 2),
(7, 2, 3),
(8, 4, 3),
(9, 6, 3),
(10, 1, 4),
(11, 2, 4),
(12, 4, 4),
(13, 5, 4),
(14, 6, 4),
(15, 2, 5),
(16, 3, 5),
(17, 4, 5),
(18, 5, 5),
(19, 6, 5),
(20, 2, 6),
(21, 3, 6),
(22, 4, 6),
(23, 5, 6),
(24, 6, 6),
(25, 2, 7),
(26, 3, 7),
(27, 4, 7),
(28, 5, 7),
(29, 6, 7),
(30, 2, 8),
(31, 3, 8),
(32, 4, 8),
(33, 5, 8),
(34, 6, 8),
(41, 2, 9),
(42, 3, 9),
(43, 4, 9),
(44, 5, 9),
(45, 6, 9),
(46, 7, 9),
(47, 1, 10),
(48, 7, 10),
(49, 2, 11),
(50, 3, 11),
(51, 4, 11),
(52, 5, 11),
(53, 6, 11),
(54, 2, 12),
(55, 4, 12),
(56, 6, 12);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `jobs`
--

CREATE TABLE `jobs` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `lat` varchar(255) NOT NULL,
  `longitude` varchar(255) NOT NULL,
  `hours` int(11) NOT NULL,
  `min_price` int(11) NOT NULL,
  `max_price` int(11) NOT NULL,
  `repate` int(11) NOT NULL DEFAULT '0',
  `avalable` int(11) NOT NULL DEFAULT '0',
  `information` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `hidden` int(11) NOT NULL DEFAULT '0',
  `byUser` int(11) NOT NULL,
  `private` int(11) NOT NULL DEFAULT '0',
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Salvarea datelor din tabel `jobs`
--

INSERT INTO `jobs` (`id`, `title`, `lat`, `longitude`, `hours`, `min_price`, `max_price`, `repate`, `avalable`, `information`, `date`, `hidden`, `byUser`, `private`, `city`, `state`) VALUES
(1, 'Head Trauma ', '46.99158239999999', '28.857593100000003', 1, 15, 120, 1, 1, 'hdhdhjslso', '2017-01-06 16:14:36', 0, 11, 0, 'Chişinău', 'MD'),
(2, 'Assist me on call', '47.2118683', '29.1580324', 2, 42, 50, 0, 1, 'If i wii need help, I will call you', '2017-01-09 05:45:02', 0, 12, 1, 'Criuleni', 'MD'),
(3, 'badante', '47.7358946', '28.4831124', 3, 15, 20, 0, 1, 'Assist grandma', '2017-01-09 05:50:32', 0, 12, 0, 'Floreşti', 'MD'),
(4, 'Back pain', '47.0167167', '28.8497415', 4, 15, 120, 0, 1, 'Jdisiidjdjid', '2017-01-26 09:48:24', 0, 22, 0, 'Chişinău', 'MD'),
(5, 'good worker', '35.2216645', '-80.838701', 1, 15, 120, 0, 0, 'We need someone thats great', '2017-07-26 11:54:38', 0, 96, 0, 'North Carolina', 'US'),
(6, 'only the best', '35.910262', '-79.055474', 1, 15, 120, 0, 0, 'If your not first your last', '2017-07-26 11:55:24', 0, 96, 0, 'North Carolina', 'US'),
(7, 'only the best', '35.910262', '-79.055474', 1, 15, 120, 0, 0, 'If your not first your last', '2017-07-26 11:55:25', 0, 96, 0, 'North Carolina', 'US'),
(8, 'only the best', '35.910262', '-79.055474', 1, 15, 120, 0, 0, 'If your not first your last', '2017-07-26 11:55:26', 0, 96, 0, 'North Carolina', 'US'),
(9, 'Jennifer ', '35.92264186972458', '-79.12527414975965', 1, 15, 120, 1, 0, 'Looking for someone to care for my mother on Thanksgiving day and the following Friday', '2017-10-18 15:41:12', 1, 188, 0, 'North Carolina', 'US'),
(10, 'Jennifer/Caregiver', '35.996948', '-78.899023', 1, 15, 20, 1, 0, 'Help with my mom', '2017-10-18 19:46:29', 1, 188, 1, 'North Carolina', 'US'),
(11, 'Jennifer:Caregiver', '35.996948', '-78.899023', 1, 15, 20, 1, 0, 'Great', '2017-10-18 19:50:15', 0, 188, 1, 'North Carolina', 'US'),
(12, 'testing one', '46.991397499999984', '28.857128906249997', 1, 15, 30, 1, 1, 'hey test', '2017-11-03 09:45:38', 0, 142, 0, 'Chişinău', 'MD');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `toUser` int(11) NOT NULL,
  `text` text CHARACTER SET utf8mb4 NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `new` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Salvarea datelor din tabel `messages`
--

INSERT INTO `messages` (`id`, `user`, `toUser`, `text`, `time`, `new`) VALUES
(1, 11, 8, 'hello\n', '2017-01-06 16:15:02', 1),
(2, 13, 12, 'Call me when you need assistance', '2017-01-09 05:58:19', 0),
(3, 96, 92, 'Can you work for me. I will pay only the best. We only pay in pennies', '2017-07-26 11:53:09', 0),
(4, 96, 92, 'Can you work for me. I will pay only the best. We only pay in pennies', '2017-07-26 11:53:10', 0),
(5, 95, 96, 'I would like to het this job', '2017-07-26 11:56:13', 0),
(6, 96, 95, 'How soon can you start?', '2017-07-26 11:58:19', 1),
(7, 96, 95, 'Let\'s start tomorrow', '2017-07-26 12:09:47', 1),
(8, 97, 96, 'Jjznz', '2017-09-13 12:40:58', 1),
(9, 188, 114, 'Hello please givee a call about hite', '2017-10-18 18:47:54', 1),
(10, 92, 188, 'I would like to work for you', '2017-10-18 18:57:50', 0),
(11, 188, 92, 'Thank you and let make a connections', '2017-10-18 19:43:59', 0),
(12, 188, 92, 'What do you think', '2017-10-18 19:47:45', 0),
(13, 188, 92, 'Great', '2017-10-18 19:48:07', 0),
(14, 92, 188, 'Ok', '2017-10-18 19:50:57', 0),
(15, 188, 92, 'Great', '2017-10-18 19:53:02', 0),
(16, 188, 92, 'Can you starting working early that morning', '2017-10-18 19:53:22', 0),
(17, 206, 11, 'mesage', '2017-10-31 10:02:31', 1),
(18, 185, 11, 'hey I want to apply to the job', '2017-11-03 09:31:39', 1);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `offers`
--

CREATE TABLE `offers` (
  `id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `fromUser` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `result` int(11) NOT NULL DEFAULT '0',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `hidden` int(11) NOT NULL DEFAULT '0',
  `new` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `offers`
--

INSERT INTO `offers` (`id`, `userid`, `fromUser`, `job_id`, `type`, `result`, `date`, `hidden`, `new`) VALUES
(1, 10, 11, 1, 1, 1, '2017-01-06 16:14:36', 0, 1),
(2, 7, 11, 1, 0, 0, '2017-01-06 16:15:39', 0, 1),
(3, 10, 12, 2, 1, 1, '2017-01-09 05:45:10', 0, 1),
(4, 13, 12, 3, 0, 1, '2017-01-09 05:56:26', 0, 1),
(5, 13, 11, 1, 0, 0, '2017-01-09 05:56:53', 0, 1),
(6, 10, 22, 4, 0, 0, '2017-01-26 09:50:40', 0, 1),
(7, 95, 96, 6, 0, 1, '2017-07-26 11:56:17', 0, 1),
(8, 97, 96, 5, 0, 0, '2017-09-13 12:40:48', 0, 1),
(9, 92, 96, 5, 0, 0, '2017-10-17 13:29:33', 0, 1),
(10, 92, 188, 9, 0, 1, '2017-10-18 18:57:23', 0, 1),
(11, 92, 188, 10, 1, 1, '2017-10-18 19:46:37', 0, 1),
(12, 92, 188, 11, 1, 0, '2017-10-18 19:50:24', 0, 1),
(13, 143, 96, 8, 0, 0, '2017-10-30 11:16:55', 0, 1),
(14, 206, 11, 1, 0, 0, '2017-10-31 10:02:34', 0, 1),
(15, 143, 11, 1, 0, 0, '2017-10-31 11:13:26', 1, 1),
(16, 185, 11, 1, 0, 0, '2017-11-03 09:13:18', 0, 1),
(17, 185, 96, 8, 0, 0, '2017-11-03 09:32:33', 0, 1),
(18, 185, 142, 12, 0, 1, '2017-11-03 09:46:12', 0, 1);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `rating`
--

CREATE TABLE `rating` (
  `id` int(11) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `to_user` varchar(255) NOT NULL,
  `rating` varchar(255) NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `rating`
--

INSERT INTO `rating` (`id`, `user_id`, `to_user`, `rating`, `type`) VALUES
(4, '210', '174', '5', 0),
(8, '211', '5', '3.5', 1),
(9, '211', '6', '1', 1),
(10, '211', '8', '5', 1);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `reports`
--

CREATE TABLE `reports` (
  `id` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `jobid` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `resolved` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `reports`
--

INSERT INTO `reports` (`id`, `user`, `jobid`, `date`, `resolved`) VALUES
(1, 206, 1, '2017-10-31 10:02:15', 0),
(2, 206, 1, '2017-10-31 10:02:16', 0);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `reports_user`
--

CREATE TABLE `reports_user` (
  `id` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `reported` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `resolved` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `reports_user`
--

INSERT INTO `reports_user` (`id`, `user`, `reported`, `date`, `resolved`) VALUES
(1, 188, 92, '2017-10-18 20:22:32', 0);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `skills`
--

CREATE TABLE `skills` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Salvarea datelor din tabel `skills`
--

INSERT INTO `skills` (`id`, `name`) VALUES
(17, 'Dressing Patient '),
(18, 'Personal Hygiene Care'),
(19, 'Patient Care & Safety'),
(20, 'Vital Signs'),
(21, 'Bathing and Showering Patient'),
(22, 'Identifying Personal Needs'),
(23, 'Time Management'),
(24, 'Transporting Patients'),
(25, 'Documentation');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `skills_attribute`
--

CREATE TABLE `skills_attribute` (
  `id` int(11) NOT NULL,
  `skill_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Salvarea datelor din tabel `skills_attribute`
--

INSERT INTO `skills_attribute` (`id`, `skill_id`, `user_id`) VALUES
(2, 18, 8),
(11, 17, 13),
(12, 18, 13),
(13, 19, 13),
(14, 20, 13),
(15, 18, 14),
(16, 18, 16),
(18, 17, 18),
(19, 18, 18),
(20, 17, 23),
(21, 20, 23),
(23, 19, 35),
(25, 17, 37),
(26, 18, 37),
(27, 19, 37),
(28, 20, 37),
(29, 20, 38),
(31, 17, 39),
(32, 18, 39),
(33, 19, 39),
(34, 20, 39),
(37, 17, 41),
(38, 18, 41),
(39, 19, 41),
(40, 20, 41),
(41, 20, 42),
(42, 17, 43),
(44, 17, 45),
(45, 19, 45),
(46, 17, 46),
(47, 18, 46),
(48, 19, 46),
(49, 20, 46),
(50, 18, 47),
(53, 18, 49),
(54, 19, 49),
(57, 18, 81),
(59, 17, 82),
(60, 18, 82),
(61, 19, 82),
(62, 20, 82),
(63, 20, 84),
(66, 18, 89),
(67, 19, 89),
(78, 17, 91),
(79, 18, 91),
(80, 19, 91),
(81, 20, 91),
(85, 17, 90),
(86, 18, 90),
(87, 19, 90),
(88, 20, 90),
(89, 19, 94),
(90, 20, 94),
(97, 19, 95),
(98, 20, 95),
(99, 21, 95),
(100, 22, 95),
(101, 23, 95),
(102, 24, 95),
(103, 18, 97),
(104, 20, 97),
(106, 17, 98),
(107, 17, 99),
(108, 18, 99),
(109, 19, 99),
(110, 20, 99),
(111, 21, 99),
(112, 22, 99),
(113, 23, 99),
(114, 24, 99),
(115, 25, 99),
(116, 17, 101),
(117, 18, 101),
(118, 19, 101),
(119, 20, 101),
(120, 21, 101),
(121, 22, 101),
(122, 23, 101),
(123, 24, 101),
(124, 25, 101),
(125, 17, 101),
(126, 18, 101),
(127, 19, 101),
(128, 20, 101),
(129, 21, 101),
(130, 22, 101),
(131, 23, 101),
(132, 24, 101),
(133, 25, 101),
(134, 17, 105),
(135, 18, 105),
(136, 19, 105),
(137, 20, 105),
(138, 21, 105),
(139, 22, 105),
(140, 23, 105),
(141, 24, 105),
(142, 25, 105),
(154, 18, 107),
(155, 17, 107),
(156, 20, 107),
(157, 19, 107),
(158, 21, 107),
(159, 22, 107),
(160, 23, 107),
(161, 24, 107),
(162, 25, 107),
(164, 17, 108),
(165, 18, 108),
(166, 19, 108),
(167, 20, 108),
(168, 21, 108),
(169, 22, 108),
(170, 23, 108),
(171, 24, 108),
(172, 25, 108),
(173, 17, 112),
(174, 18, 112),
(175, 19, 112),
(176, 20, 112),
(177, 21, 112),
(178, 22, 112),
(179, 23, 112),
(180, 24, 112),
(181, 25, 112),
(183, 17, 113),
(184, 18, 113),
(185, 19, 113),
(186, 20, 113),
(187, 21, 113),
(188, 22, 113),
(189, 23, 113),
(190, 24, 113),
(191, 25, 113),
(193, 17, 114),
(194, 18, 114),
(195, 19, 114),
(196, 20, 114),
(197, 21, 114),
(198, 22, 114),
(199, 23, 114),
(200, 24, 114),
(201, 25, 114),
(203, 19, 115),
(204, 19, 123),
(205, 17, 126),
(206, 17, 126),
(208, 17, 131),
(209, 18, 131),
(210, 19, 131),
(211, 20, 131),
(212, 21, 131),
(213, 22, 131),
(214, 23, 131),
(215, 24, 131),
(216, 25, 131),
(219, 17, 139),
(222, 17, 145),
(223, 18, 145),
(224, 18, 146),
(225, 18, 146),
(226, 19, 149),
(227, 20, 149),
(231, 17, 151),
(234, 17, 152),
(235, 18, 153),
(236, 17, 154),
(237, 17, 155),
(238, 17, 156),
(247, 17, 130),
(270, 19, 157),
(271, 20, 158),
(272, 20, 159),
(273, 20, 160),
(274, 20, 161),
(275, 20, 162),
(276, 20, 163),
(277, 20, 164),
(278, 20, 165),
(279, 20, 166),
(280, 20, 167),
(281, 20, 168),
(282, 20, 169),
(283, 20, 170),
(284, 20, 171),
(285, 20, 172),
(287, 18, 173),
(288, 19, 174),
(289, 18, 175),
(290, 20, 176),
(291, 20, 177),
(293, 20, 178),
(295, 20, 180),
(319, 17, 181),
(320, 18, 181),
(321, 19, 181),
(332, 25, 132),
(335, 20, 183),
(336, 21, 183),
(341, 18, 184),
(342, 17, 187),
(343, 18, 187),
(344, 19, 187),
(345, 20, 187),
(346, 21, 187),
(347, 22, 187),
(348, 23, 187),
(349, 24, 187),
(350, 25, 187),
(353, 25, 186),
(354, 19, 186),
(363, 17, 92),
(364, 18, 92),
(365, 20, 92),
(368, 20, 204),
(369, 22, 204),
(370, 20, 205),
(371, 21, 205),
(372, 18, 206),
(373, 24, 206),
(374, 17, 209),
(375, 18, 209),
(376, 19, 209),
(377, 20, 209),
(378, 21, 209),
(379, 22, 209),
(380, 23, 209),
(381, 24, 209),
(382, 25, 209),
(383, 18, 211);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `last_name` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `address_lat` varchar(255) NOT NULL,
  `address_long` varchar(255) NOT NULL,
  `experience` int(11) NOT NULL DEFAULT '0',
  `available_time` int(11) NOT NULL DEFAULT '1',
  `price_min` int(11) NOT NULL DEFAULT '15',
  `price_max` int(11) NOT NULL DEFAULT '15',
  `phone` varchar(255) NOT NULL DEFAULT ' ',
  `birthday` varchar(255) NOT NULL DEFAULT ' ',
  `description` text NOT NULL,
  `profile_img` varchar(255) DEFAULT '',
  `gender` int(11) NOT NULL DEFAULT '0',
  `subscribed` int(11) NOT NULL DEFAULT '0',
  `available` int(11) NOT NULL DEFAULT '1',
  `registration_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `android_push` varchar(255) NOT NULL DEFAULT '',
  `ios_push` varchar(255) NOT NULL DEFAULT '',
  `expire` date DEFAULT NULL,
  `hidden` int(11) NOT NULL DEFAULT '0',
  `city` varchar(255) NOT NULL DEFAULT '',
  `state` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL DEFAULT '',
  `zip` varchar(255) NOT NULL DEFAULT '',
  `other_skills` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Salvarea datelor din tabel `users`
--

INSERT INTO `users` (`id`, `password`, `email`, `type`, `last_name`, `first_name`, `address_lat`, `address_long`, `experience`, `available_time`, `price_min`, `price_max`, `phone`, `birthday`, `description`, `profile_img`, `gender`, `subscribed`, `available`, `registration_time`, `android_push`, `ios_push`, `expire`, `hidden`, `city`, `state`, `address`, `zip`, `other_skills`) VALUES
(1, 'a8f5f167f44f4964e6c998dee827110c', 'jsjsksk@jdkdk.cpm', 0, 'hzjs', 'jjzjsks', '46.991721999999996', '28.85779', 0, 1, 15, 15, ' ', ' ', ' ', '', 0, 1, 1, '2016-12-21 00:28:19', '', '', '2017-01-20', 0, 'Chişinău', 'MD', 'Chişinău', '', ''),
(2, '827ccb0eea8a706c4c34a16891f84e7b', 'nemo@gmail.com', 0, 'dd', 'ss', '46.9915702', '28.8575944', 0, 1, 15, 15, ' ', ' ', ' ', '', 0, 1, 1, '2016-12-21 00:47:02', 'APA91bFE9V0hjwiFRSB4zQeq2HTaNUeJcWwEjByl_pZTeCWBWpK3BPFjq7AdCHSXwIWG1_LjHFXSqA-dfIWfTIddykmSHoEp-JafREI7qZ0JsoDwFbT8CUT-UOGUnU6qBtPlNjnvEvpg', '', '2017-01-20', 0, 'Chişinău', 'MD', 'Chişinău', '', ''),
(3, 'a8f5f167f44f4964e6c998dee827110c', 'me@gainaroman.com', 0, 'Roman', 'Gaina', '47.0054037', '28.8789006', 0, 1, 15, 15, ' ', ' ', 'Chişinău', '', 0, 1, 1, '2016-12-21 20:02:48', '', '55e319f0b133046e356000cd4b25628afdbfd40ab1ecb0cc69e8d6234308d072', '2017-01-20', 0, 'MD', 'Chişinău', ' ', '', ''),
(4, 'e10adc3949ba59abbe56e057f20f883e', 'this@is.test', 0, 'Account', 'Test', '37.78008', '-122.420168', 0, 1, 15, 15, ' ', ' ', 'California', '', 0, 1, 1, '2016-12-21 20:21:32', '', '', '2017-01-20', 0, 'US', 'California', ' ', '', ''),
(5, 'e10adc3949ba59abbe56e057f20f883e', 'hello@hello.com', 0, 'Hello', 'Hello', '37.78008', '-122.420168', 0, 1, 15, 15, ' ', ' ', 'California', '', 0, 1, 1, '2016-12-21 20:24:16', '', 'e8c3280f2b6cf34a8f8ef4571ea12a6e820b87fc1af5b1742c00c98efeed206a', '2017-01-20', 0, 'US', 'California', ' ', '', ''),
(6, '4c8aadbc82047b8e11a61098c6a4cdcb', 'burakx98@gmail.com', 0, 'Bayram', 'Burak', '39.8771675', '32.8644018', 0, 1, 15, 15, ' ', ' ', 'Ankara', '', 0, 0, 1, '2016-12-23 18:19:45', '', '', NULL, 0, 'TR', 'Ankara', ' ', '', ''),
(7, '827ccb0eea8a706c4c34a16891f84e7b', 'info@midnight.works', 1, 'Account', 'test', '46.9915702', '28.8575944', 3, 0, 20, 100, '+1234567890', 'Chișinău', 'some random description', 'media/7rUKB0tNj6.png', 1, 1, 0, '2017-01-03 16:02:38', '', '', '2017-02-02', 0, 'Chişinău', 'MD', 'Chişinău', '', ''),
(8, 'e10adc3949ba59abbe56e057f20f883e', 'who@are.you', 1, 'are', 'who', '47.1469955', '28.6150298', 1, 0, 31, 33, '+37367111111', '2001-01-05 15:40:03', 'Test description', 'media/zLT6URH6gs.png', 0, 0, 1, '2017-01-05 01:41:02', '', '', NULL, 0, 'Strășeni', 'MD', 'Strășeni', '', ''),
(9, 'e10adc3949ba59abbe56e057f20f883e', 'iam@iura.that', 0, 'iura', 'iam', '47.2118683', '29.1580324', 0, 1, 15, 15, ' ', ' ', 'Criuleni', '', 0, 0, 1, '2017-01-05 01:54:20', '', '', NULL, 0, 'MD', 'Criuleni', ' ', '', ''),
(10, '20784f738848c693b6cf51cf325412a3', 'jeniferwhite@midnight.works', 1, 'Assworth', 'Albert', '46.99737107223275', '28.85970050617374', 2, 0, 15, 100, '+12376537', '1985-10-03 15:40:03', 'Falalalala', 'media/Q58Z2fO7kv.png', 1, 1, 1, '2017-01-05 10:08:39', 'APA91bEcfS4n7omFtyjGfNdUQ9lYJ7d8civMWDFwQC2KM8IKs07KGx3ANoUWSxd155K6m_SV7uABAPTexin_FODONBM1A-X25rt7tLbirn4N5WB9ZO0ji0aT_EIwYaKTU1siAW5NkHi4', '994804fb82300e65b19c54407753a0eafd791acd3904897ea99e9eeb946dfa46', '2017-02-05', 0, 'Chişinău', 'MD', 'Chişinău', '', ''),
(11, '20784f738848c693b6cf51cf325412a3', 'play@midnight.works', 0, 'Thorns', 'Ares', '46.99158239999999', '28.857593100000003', 0, 1, 15, 15, ' ', ' ', ' ', '', 0, 1, 1, '2017-01-06 16:13:07', '', '', '2017-02-05', 0, 'Chişinău', 'MD', 'Chişinău', '', ''),
(12, '343b1c4a3ea721b2d640fc8700db0f36', 'vomali@mail.ru', 0, 'appleseed', 'john', '47.3694305', '28.8224089', 0, 1, 15, 15, ' ', ' ', 'Orhei', '', 0, 1, 1, '2017-01-09 05:38:57', '', '', '2017-02-08', 0, 'MD', 'Orhei', ' ', '', ''),
(13, '343b1c4a3ea721b2d640fc8700db0f36', 'vomalimovila@yahoo.com', 1, 'doe', 'john', '46.2021115', '28.7456632', 1, 0, 28, 55, '+37367470516', '1992-03-15 15:40:03', 'Good calification. Best assistance.', 'media/SlwvwylNmb.png', 1, 1, 1, '2017-01-09 05:55:07', '', '', '2017-02-08', 0, 'Găgăuzia', 'MD', 'Găgăuzia', '', ''),
(14, '343b1c4a3ea721b2d640fc8700db0f36', 'colodin@mail.ru', 1, 'cardan', 'jora', '46.659219', '28.574462', 3, 0, 119, 120, '+37367470516', '1946-12-10 15:40:03', 'ADasdf asFASDFA', 'media/7gxn3KapdZ.png', 1, 0, 1, '2017-01-11 09:43:15', '', '', NULL, 0, 'Cimişlia', 'MD', 'Cimişlia', '', ''),
(15, '343b1c4a3ea721b2d640fc8700db0f36', 'bola@mail.ru', 0, 'qqqqqq', 'qqqqqq', '46.659219', '28.574462', 0, 1, 15, 15, ' ', ' ', 'Cimişlia', '', 0, 0, 1, '2017-01-11 10:07:34', '', '', NULL, 0, 'MD', 'Cimişlia', ' ', '', ''),
(16, '343b1c4a3ea721b2d640fc8700db0f36', 'cola@mail.ru', 1, 'q', 'q', '47.8188754', '28.6775047', 2, 0, 15, 23, '+37367470516', '1961-11-11 15:40:03', 'Isdhwxinwzohwxih', 'media/5EnondFjx0.png', 1, 0, 1, '2017-01-11 10:13:33', '', '', NULL, 0, 'Şoldăneşti', 'MD', 'Şoldăneşti', '', ''),
(17, '11f6667c5a17190015e7a44f250e9226', 'dem22o@gmail.com', 0, '3', 'ewq', '44.4267347', '26.1040483', 0, 1, 15, 15, ' ', ' ', 'Bucureşti', '', 0, 1, 1, '2017-01-15 17:25:44', '', '', '2017-02-14', 0, 'RO', 'Bucureşti', ' ', '', ''),
(18, 'e10adc3949ba59abbe56e057f20f883e', 'nemo123@gmail.com', 1, 'Boy', 'Best', '55.752222', '37.615556', 0, 0, 20, 110, '+37379315844', '2004-01-25 15:40:03', 'Demoi Nomoi', 'media/BPsrehuPdi.png', 0, 1, 1, '2017-01-15 17:31:43', '', '', '2017-02-14', 0, 'MO', 'RU', 'MO', '', ''),
(19, '4def9dc804ab7fa8668074d9478f04c8', 'malayahawkins851@gmail.com', 0, 'hawkins', 'malaya', '33.572628', '-84.41253399999999', 0, 1, 15, 15, ' ', ' ', 'Georgia', '', 0, 1, 1, '2017-01-25 15:42:37', '', 'ea82fea99cd81039d073b63f0ee6a99961645b0b935ba30cddd8afa957451173', '2017-02-27', 0, 'Georgia', 'US', 'Georgia', '', ''),
(20, '20784f738848c693b6cf51cf325412a3', 'feniferwhite@midnight.works', 0, 'White', 'Jenifer', '47.0054037', '28.8789006', 0, 1, 15, 15, ' ', ' ', 'Chişinău', '', 0, 1, 1, '2017-01-26 09:35:28', '', '', '2017-02-25', 0, 'MD', 'Chişinău', ' ', '', ''),
(21, '20784f738848c693b6cf51cf325412a3', 'sepeliartiom@gmail.com', 0, 'Montagne', 'Dan', '47.0054037', '28.8789006', 0, 1, 15, 15, ' ', ' ', 'Chişinău', '', 0, 1, 1, '2017-01-26 09:42:02', '', '', '2017-02-25', 0, 'MD', 'Chişinău', ' ', '', ''),
(22, '20784f738848c693b6cf51cf325412a3', 'kiki@gmail.com', 0, 'Baker', 'Manny', '47.0167167', '28.8497415', 0, 1, 15, 15, ' ', ' ', 'Chişinău', '', 0, 1, 1, '2017-01-26 09:45:50', '', '', '2017-02-25', 0, 'MD', 'Chişinău', ' ', '', ''),
(23, 'ce3b54018018228195d1bb32db66b057', 'rechulisita3@hotmail.com', 1, 'garcia', 'valentina', '34.239464', '-118.4761301', 1, 0, 15, 20, '+8186140158', '1986-11-22 15:40:03', 'I love to take care the people that need help. I\'m bilingual spanish and english.', 'media/aekUMzQ6sz.png', 0, 0, 1, '2017-02-03 07:28:44', '', '', NULL, 0, 'California', 'US', 'California', '', ''),
(24, '0f668df26b05a41d5d79512db17cb9a5', 'danapalmero@hotmail.com', 0, 'palmero ', 'dana ', '40.642077', '-73.669477', 0, 1, 15, 15, ' ', ' ', 'New York', '', 0, 0, 1, '2017-02-03 23:32:42', '', '', NULL, 0, 'US', 'New York', ' ', '', ''),
(25, 'bf82579e376247aa03775da645dcb15a', 'andrei@movila.com', 0, 'movila', 'andrei', '47.3694305', '28.8224089', 0, 1, 15, 15, ' ', ' ', 'Orhei', '', 0, 0, 1, '2017-03-07 10:28:16', '', '', NULL, 0, 'MD', 'Orhei', ' ', '', ''),
(26, '343b1c4a3ea721b2d640fc8700db0f36', 'test@user.com', 0, 'user', 'test', '46.2021115', '28.7456632', 0, 1, 15, 15, ' ', ' ', 'Găgăuzia', '', 0, 0, 1, '2017-03-07 10:43:26', '', '', NULL, 0, 'MD', 'Găgăuzia', ' ', '', ''),
(27, '343b1c4a3ea721b2d640fc8700db0f36', 'mymail@com.com', 0, 'mail', 'mail', '47.0054037', '28.8789006', 0, 1, 15, 15, ' ', ' ', 'Chişinău', '', 0, 0, 1, '2017-03-07 11:31:47', '', '', NULL, 0, 'MD', 'Chişinău', ' ', '', ''),
(28, '343b1c4a3ea721b2d640fc8700db0f36', 'amail@mail.ru', 0, 'name', 'name', '46.659219', '28.574462', 0, 1, 15, 15, ' ', ' ', 'Cimişlia', '', 0, 0, 1, '2017-03-07 11:54:01', '', '', NULL, 0, 'MD', 'Cimişlia', ' ', '', ''),
(29, '343b1c4a3ea721b2d640fc8700db0f36', 'uder@mail.ru', 1, 'Sepel', 'Arty', '47.0054037', '28.8789006', 1, 0, 15, 50, '+37369123456', '1991-06-07 15:40:03', 'What?\n', 'media/up0zSSZO0J.png', 1, 0, 1, '2017-03-07 13:46:06', '', '6a2bf6c1eadcfb9aa851ab240417fb01b777f31e9737a15fbfc12975633986ef', NULL, 0, 'Chişinău', 'MD', 'Chişinău', '', ''),
(30, '898d88f1a9567c40f21834678a24e9a2', 'ssnelson1971@gmail.com', 0, 'Nelson Adams', 'Shawnea', '36.977714', '-76.43034900000001', 0, 1, 15, 15, ' ', ' ', 'Virginia', '', 0, 0, 1, '2017-03-07 18:12:51', '', '74a36179402dc477b812c8272a6a9380bb8dc99ca565e5cc062e9dcbf57ae99c', NULL, 0, 'US', 'Virginia', ' ', '', ''),
(31, '9d9a1b6c3a5b273165d94ee97e4b5e39', 'jas4sage@yahoo.com', 0, 'sohi', 'jaspreet', '47.3151765', '-122.3346583', 0, 1, 15, 15, ' ', ' ', 'Washington', '', 0, 0, 1, '2017-03-15 17:52:20', '', '', NULL, 0, 'US', 'Washington', ' ', '', ''),
(32, '7482d4b1286adfa895be610bf50cbdbe', 'ana71688@gmail.com', 0, 'morales', 'ana', '34.298772', '-83.829629', 0, 1, 15, 15, ' ', ' ', 'Georgia', '', 0, 0, 1, '2017-03-17 04:18:49', '', '', NULL, 0, 'US', 'Georgia', ' ', '', ''),
(33, 'e7edebee9d48fea3dd53edcadfa88537', 'btevans1186@att.net', 0, 'waters', 'bill', '35.2229364', '-80.8401607', 0, 1, 15, 15, ' ', ' ', 'North Carolina', '', 0, 0, 1, '2017-03-29 15:09:00', '', '', NULL, 0, 'US', 'North Carolina', ' ', '', ''),
(34, 'e7edebee9d48fea3dd53edcadfa88537', 'btevans1186@gmail.com', 0, 'waters', 'bill', '35.2229364', '-80.8401607', 0, 1, 15, 15, ' ', ' ', 'North Carolina', '', 0, 1, 1, '2017-03-30 13:13:38', '', '', '2017-04-29', 0, 'US', 'North Carolina', ' ', '', ''),
(35, 'e7edebee9d48fea3dd53edcadfa88537', 'bryan@infinitiscope.com', 1, 'waters', 'bill', '40.713054', '-74.007228', 0, 0, 15, 35, '+19193609671', '1983-03-16 15:40:03', 'Im the best worker you can find', 'media/7WbSIHjxVa.png', 1, 0, 1, '2017-03-30 15:31:30', '', '', NULL, 0, 'New York', 'US', 'New York', '', ''),
(36, 'c4e050e1cec5d074195e75688e323a9c', 'lharris@hiddenvoices.org', 0, 'harris', 'lynden', '36.2114831', '-79.13781590000001', 0, 1, 15, 15, ' ', ' ', 'North Carolina', '', 0, 0, 1, '2017-04-06 01:53:49', '', '', NULL, 0, 'US', 'North Carolina', ' ', '', ''),
(37, '343b1c4a3ea721b2d640fc8700db0f36', 'qq@qq.ru', 1, 'qq', 'qq', '47.2118683', '29.1580324', 1, 0, 20, 99, '+17367470516', '1975-04-09 15:40:03', 'Nothing important', 'media/BqWytDIMQP.png', 1, 0, 1, '2017-04-09 14:25:57', '', '', NULL, 0, 'Criuleni', 'MD', 'Criuleni', '', ''),
(38, 'cab4a1d3e1180a4c8d3f526ca8c500c4', 'jeniferwhite@gmail.com', 1, 'White', 'Jenifer', '47.0167167', '28.8497415', 1, 0, 15, 30, '+112387519', '1985-04-10 15:40:03', 'Take care.', 'media/A6UcSzfrPj.png', 0, 0, 1, '2017-04-10 15:22:53', '', '', NULL, 0, 'Chişinău', 'MD', 'Chişinău', '', ''),
(39, '395b069478996236f8e456adb474730c', 'btevans11@gmail.com', 1, 'smith', 'will', '35.2216645', '-80.838701', 5, 0, 15, 30, '+19193600675', '1984-04-25 15:40:03', 'The best worker', 'media/UxSuCiq0rm.png', 1, 0, 1, '2017-04-25 17:36:15', '', '', NULL, 0, 'North Carolina', 'US', 'North Carolina', '', ''),
(40, '395b069478996236f8e456adb474730c', 'bevans@gmail.com', 1, 'smith', 'will', '35.2216645', '-80.838701', 5, 0, 15, 55, '+19193600612', '1981-04-25 15:40:03', 'The best', 'media/M6EK6VgzGL.png', 1, 0, 1, '2017-04-25 17:39:41', '', '', NULL, 0, 'North Carolina', 'US', 'North Carolina', '', ''),
(41, 'e7edebee9d48fea3dd53edcadfa88537', 'bryantabithaevans@gmail.com', 1, 'smith', 'will', '35.2216645', '-80.838701', 5, 0, 20, 80, '+19193600819', '1974-04-25 15:40:03', 'The best', 'media/5ayhmMGPwZ.png', 0, 0, 1, '2017-04-25 17:43:36', '', '', NULL, 0, 'North Carolina', 'US', 'North Carolina', '', ''),
(42, '2ad69fd543894dccbeef22c19f6514f3', 'sierraverrall212@gmail.com', 1, 'verrall', 'sierra', '29.6406165', '-95.4361202', 0, 0, 15, 20, '+12814684621', '1993-04-29 15:40:03', 'Im certified CNA & HHA .\nI have experiance in both at least\nA year.', 'media/cDHUSMCRtR.png', 0, 0, 1, '2017-04-29 23:18:35', '', '', NULL, 0, 'Texas', 'US', 'Texas', '', ''),
(43, '5b70b64e092ac4933d3a5cc7876bb697', 'pariswilliams0422@yahoo.com', 1, 'Williams', 'Paris', '36.1650713', '-86.783725', 0, 0, 15, 20, '+16157756800', '1992-04-22 15:40:03', 'Please email me @pariswilliams0422@yahoo.com or contact me by phone @ 615-775-6800 thank you I have been a cna since March 28 2017 I have cpr license Im 25 years old mother of 3 & I need work with plenty of hours with around pay rate of 11.00 to 13.00 a hr. ', 'media/fXZaFycc9H.png', 0, 0, 1, '2017-05-01 23:57:23', '', '', NULL, 0, 'Tennessee', 'US', 'Tennessee', '', ''),
(44, '395b069478996236f8e456adb474730c', 'btevans@gmail.com', 1, 'waters', 'will', '40.713054', '-74.007228', 0, 0, 20, 60, '+19196362586', '1980-05-02 15:40:03', 'The best', 'media/Xuh4GNPxxh.png', 1, 0, 1, '2017-05-02 09:42:57', '', '', NULL, 0, 'New York', 'US', 'New York', '', ''),
(45, '343b1c4a3ea721b2d640fc8700db0f36', 'qqq@qqq.mail.ru', 1, 'qqq', 'qqq', '47.3694305', '28.8224089', 0, 0, 23, 67, '+12025550158', '1991-08-06 15:40:03', 'Nothing important', 'media/YyXFRiCmO7.png', 1, 0, 1, '2017-05-02 14:59:25', '', '', NULL, 0, 'Orhei', 'MD', 'Orhei', '', ''),
(46, '72cbc795f6a1eb2f9dcf30b4fd956f49', 'cierra.robinson63@gmail.com', 1, 'Robinson', 'Cierra', '47.2172439', '-122.3434465', 0, 0, 15, 20, '+12534313130', '1998-06-21 15:40:03', 'Recent Graduate of Divine CNA Training school. Looking for a weekend job that can go Full-Time.', 'media/eTBzxelASE.png', 0, 0, 1, '2017-05-02 20:23:40', '', '6f5afe20f904ebce7f3f3c845b79213bed6f2886541e8520227da2939ff9fe4d', NULL, 0, 'Washington', 'US', 'Washington', '', ''),
(47, 'cb35c159bccccd4b9b15445e525e419e', 'artiom@midnight.works', 1, 'Ashworth', 'Lenny', '47.0167167', '28.8497415', 1, 0, 30, 50, '+15768761234', '1984-05-04 15:40:03', '...', 'media/Pmx2a09CR3.png', 1, 0, 1, '2017-05-04 09:48:12', '', '', NULL, 0, 'Chişinău', 'MD', 'Chişinău', '', ''),
(48, 'e7edebee9d48fea3dd53edcadfa88537', 'lopaz11@gmail.com', 1, 'smith', 'will', '35.2216645', '-80.838701', 0, 0, 20, 30, '+19193609671', '1985-05-04 15:40:03', 'The best worker you will ever find', 'media/o7YdADsoWj.png', 0, 0, 1, '2017-05-04 10:16:04', '', '', NULL, 0, 'North Carolina', 'US', 'North Carolina', '', ''),
(49, '4693fbb215b8ca15a6900f0cfa164cdc', 'vvv@vvv.com', 1, 'vvv', 'vvv', '47.5010185', '28.2816731', 0, 0, 20, 50, '+122222222', '1997-04-20 15:40:03', 'No comment', 'media/n3phtFUgVU.png', 1, 0, 1, '2017-05-04 11:42:10', '', '273a5bf40c28695d9d18dbc4a10516ecd34d3bb08ea0822f1b00685cd966e870', NULL, 1, 'Taraclia', 'MD', 'Taraclia', '', ''),
(50, 'e7edebee9d48fea3dd53edcadfa88537', 'willsmith@gmail.com', 1, 'smith', 'will', '35.2216645', '-80.838701', 0, 0, 20, 30, '+19193609671', '1985-05-04 15:40:03', 'The best worker you will find', 'media/R0RIT0YM1a.png', 0, 0, 1, '2017-05-04 12:54:42', '', '', NULL, 0, 'North Carolina', 'US', 'North Carolina', '', ''),
(51, 'e10adc3949ba59abbe56e057f20f883e', 'dsdasd2g@gmail.com', 0, '123123', 'erewr', '52.2456377', '-0.6529075', 0, 1, 15, 15, ' ', ' ', 'England', '', 0, 0, 1, '2017-05-18 12:31:35', '', '', NULL, 0, 'GB', 'England', ' ', '', ''),
(52, '25f9e794323b453885f5181f1b624d0b', '334123@gmail.com', 0, '12312', '213', '58.0657695', '-4.1786963', 0, 1, 15, 15, ' ', ' ', 'Scotland', '', 0, 0, 1, '2017-05-18 12:33:39', '', '', NULL, 0, 'GB', 'Scotland', ' ', '', ''),
(53, 'e10adc3949ba59abbe56e057f20f883e', 'yohoo@gmail.com', 0, 'yohoo', 'yohoo', '47.0167167', '28.8497415', 0, 1, 15, 15, ' ', ' ', 'Chişinău', '', 0, 0, 1, '2017-05-18 12:35:02', '', '', NULL, 0, 'MD', 'Chişinău', ' ', '', ''),
(54, '11f6667c5a17190015e7a44f250e9226', '23424@mmmmaa.com', 0, 'Yiho', '123', '54.5060741', '-2.1222434', 0, 1, 15, 15, ' ', ' ', 'England', '', 0, 0, 1, '2017-05-18 12:46:27', '', '', NULL, 0, 'GB', 'England', ' ', '', ''),
(55, '96e79218965eb72c92a549dd5a330112', '213213@gmail.com', 0, 'qqwqe', '1qaz', '54.0240413', '-2.6198733', 0, 1, 15, 15, ' ', ' ', 'England', '', 0, 0, 1, '2017-05-18 12:51:31', '', '', NULL, 0, 'GB', 'England', ' ', '', ''),
(56, '11f6667c5a17190015e7a44f250e9226', 'yahoo123@gmail.com', 0, 'Yelloq', 'Yoqwe', '38.08288036467462', '23.81874387939088', 0, 1, 15, 15, ' ', ' ', 'Attica', '', 0, 0, 1, '2017-05-18 18:21:23', '', '', NULL, 0, 'GR', 'Attica', ' ', '', ''),
(57, '11f6667c5a17190015e7a44f250e9226', '312213@gmail.com', 0, 'qwewq', '23132', '47.1473359', '28.6163343', 0, 1, 15, 15, ' ', ' ', 'Strășeni', '', 0, 0, 1, '2017-05-18 18:24:06', '', '', NULL, 0, 'MD', 'Strășeni', ' ', '', ''),
(58, 'e10adc3949ba59abbe56e057f20f883e', 'mw.bwqe@gmail.com', 0, '123', '213', '46.875886', '28.777954', 0, 1, 15, 15, ' ', ' ', 'Laloveni', '', 0, 0, 1, '2017-05-18 18:26:27', '', '', NULL, 0, 'MD', 'Laloveni', ' ', '', ''),
(59, 'e10adc3949ba59abbe56e057f20f883e', 'yellow123@gmail.com', 0, 'bmw', 'car', '46.5395479', '27.7555197', 0, 1, 15, 15, ' ', ' ', 'Vaslui', '', 0, 0, 1, '2017-05-18 18:29:15', '', '', NULL, 0, 'RO', 'Vaslui', ' ', '', ''),
(60, 'e10adc3949ba59abbe56e057f20f883e', '1231232132!@gmail.com', 0, 'c2', 'c1', '47.5010185', '28.2816731', 0, 1, 15, 15, ' ', ' ', 'Taraclia', '', 0, 0, 1, '2017-05-18 18:30:46', '', '', NULL, 0, 'MD', 'Taraclia', ' ', '', ''),
(61, 'e10adc3949ba59abbe56e057f20f883e', '123123@gmail.com', 0, 'nihu', 'yuhuu', '47.2537043', '27.9112573', 0, 1, 15, 15, ' ', ' ', 'Ungheni', '', 0, 0, 1, '2017-05-18 18:32:35', '', '', NULL, 0, 'MD', 'Ungheni', ' ', '', ''),
(62, 'e10adc3949ba59abbe56e057f20f883e', '213123123@gmail.com', 0, 'ciupi', 'iupi', '47.5010185', '28.2816731', 0, 1, 15, 15, ' ', ' ', 'Taraclia', '', 0, 0, 1, '2017-05-18 18:35:09', '', '', NULL, 0, 'MD', 'Taraclia', ' ', '', ''),
(63, '11f6667c5a17190015e7a44f250e9226', 'upi@gmail.com', 0, 'hop', '3', '46.659219', '28.574462', 0, 1, 15, 15, ' ', ' ', 'Cimişlia', '', 0, 0, 1, '2017-05-18 18:38:13', '', '', NULL, 0, 'MD', 'Cimişlia', ' ', '', ''),
(64, 'ebd4d9c739a800c5574f60245b9b8017', '2cip@gmail.com', 0, 'Ciupi', 'Iupi', '47.5010185', '28.2816731', 0, 1, 15, 15, ' ', ' ', 'Taraclia', '', 0, 0, 1, '2017-05-18 18:40:12', '', '', NULL, 0, 'MD', 'Taraclia', ' ', '', ''),
(65, 'e10adc3949ba59abbe56e057f20f883e', 'iuuewer@gmail.com', 0, '2', '1', '41.37549', '-83.65011', 0, 1, 15, 15, ' ', ' ', 'Ohio', '', 0, 0, 1, '2017-05-18 18:44:11', '', '', NULL, 0, 'US', 'Ohio', ' ', '', ''),
(66, '11f6667c5a17190015e7a44f250e9226', 'mwwww@gmailc.om', 0, '2121', 'Deere', '47.6388345', '28.1491581', 0, 1, 15, 15, ' ', ' ', 'Sîngerei', '', 0, 0, 1, '2017-05-18 18:50:25', '', '', NULL, 0, 'MD', 'Sîngerei', ' ', '', ''),
(67, 'e10adc3949ba59abbe56e057f20f883e', '123123c@gmail.com', 0, '123123', '213', '46.9578243', '27.9116251', 0, 1, 15, 15, ' ', ' ', 'Iaşi', '', 0, 0, 1, '2017-05-18 18:58:14', '', '', NULL, 0, 'RO', 'Iaşi', ' ', '', ''),
(68, 'e10adc3949ba59abbe56e057f20f883e', '123123c@gmail.com', 0, '123123', '213', '46.9578243', '27.9116251', 0, 1, 15, 15, ' ', ' ', 'Iaşi', '', 0, 0, 1, '2017-05-18 18:58:20', '', '', NULL, 0, 'RO', 'Iaşi', ' ', '', ''),
(69, '556387c3d5a774fbf602ea656124bbc1', 'pizdamasii@gmail.com', 0, 'masii', 'pzidama', '44.8697193', '13.8414046', 0, 1, 15, 15, ' ', ' ', 'Istarska', '', 0, 0, 1, '2017-05-18 19:00:00', '', '', NULL, 0, 'HR', 'Istarska', ' ', '', ''),
(70, 'e10adc3949ba59abbe56e057f20f883e', 'jijij@gmail.com', 0, 'koiii', 'mkj', '47.3694305', '28.8224089', 0, 1, 15, 15, ' ', ' ', 'Orhei', '', 0, 0, 1, '2017-05-18 19:07:47', '', '', NULL, 0, 'MD', 'Orhei', ' ', '', ''),
(71, '11f6667c5a17190015e7a44f250e9226', 'healthcare@gmail.com', 0, 'perp', 'pet', '46.659219', '28.574462', 0, 1, 15, 15, ' ', ' ', 'Cimişlia', '', 0, 0, 1, '2017-05-18 19:11:55', '', '', NULL, 0, 'MD', 'Cimişlia', ' ', '', ''),
(72, '11f6667c5a17190015e7a44f250e9226', '5oo@gmail.com', 0, 'cat', '123', '47.1469955', '28.6150298', 0, 1, 15, 15, ' ', ' ', 'Strășeni', '', 0, 0, 1, '2017-05-18 19:15:18', '', '', NULL, 0, 'MD', 'Strășeni', ' ', '', ''),
(73, 'e10adc3949ba59abbe56e057f20f883e', 'q123@gmail.com', 0, 'mo', 'Deo', '47.2161521', '29.0669329', 0, 1, 15, 15, ' ', ' ', 'Criuleni', '', 0, 0, 1, '2017-05-18 19:18:43', '', '', NULL, 0, 'MD', 'Criuleni', ' ', '', ''),
(74, 'e10adc3949ba59abbe56e057f20f883e', '2213@yoohoo.com', 0, '12312', '213', '48.1611195', '28.2874508', 0, 1, 15, 15, ' ', ' ', 'Raionul Soroca', '', 0, 0, 1, '2017-05-18 19:22:48', '', '', NULL, 0, 'MD', 'Raionul Soroca', ' ', '', ''),
(75, '11f6667c5a17190015e7a44f250e9226', '213123@gmail.com', 0, '213123', '12312', '48.1611195', '28.2874508', 0, 1, 15, 15, ' ', ' ', 'Raionul Soroca', '', 0, 0, 1, '2017-05-18 19:25:54', '', '', NULL, 0, 'MD', 'Raionul Soroca', ' ', '', ''),
(76, 'e10adc3949ba59abbe56e057f20f883e', '21312@gmaaal.com', 0, 'Nidansid', 'Catlin', '47.0833751', '28.1898151', 0, 1, 15, 15, ' ', ' ', 'Nisporeni', '', 0, 0, 1, '2017-05-19 13:27:57', '', '', NULL, 0, 'MD', 'Nisporeni', ' ', '', ''),
(77, 'e10adc3949ba59abbe56e057f20f883e', 'indiivdual2mail@c.com', 0, '21312', '213', '46.9793043', '28.8465185', 0, 1, 15, 15, ' ', ' ', 'Chişinău', '', 0, 0, 1, '2017-05-19 13:31:34', '', '', NULL, 0, 'MD', 'Chişinău', ' ', '', ''),
(78, 'e10adc3949ba59abbe56e057f20f883e', '12312g@gmail.com', 0, 'cid', '2', '46.8512744', '28.7607364', 0, 1, 15, 15, ' ', ' ', 'Laloveni', '', 0, 0, 1, '2017-05-19 13:32:45', '', '', NULL, 0, 'MD', 'Laloveni', ' ', '', ''),
(79, '11f6667c5a17190015e7a44f250e9226', 'zmazm@gmail.com', 0, 'sdlf', 'dl', '47.2528703', '29.1599968', 0, 1, 15, 15, ' ', ' ', 'Teleneşti', '', 0, 0, 1, '2017-05-19 13:35:36', '', 'd707c4dc4f83a06a43c41b3a88186849dc9acceb6d49d17d434d67755ea07df3', NULL, 0, 'MD', 'Teleneşti', ' ', '', ''),
(80, 'cab4a1d3e1180a4c8d3f526ca8c500c4', 'pizzaprayer@gmail.com', 1, 'Mondu', 'Yondu', '47.0167167', '28.8497415', 0, 0, 20, 40, '+1123121553', '1982-05-23 15:40:03', 'Asdasd', 'media/DRDFBHyD1u.png', 1, 0, 1, '2017-05-22 12:50:28', '', '', NULL, 1, 'Chişinău', 'MD', 'Chişinău', '', ''),
(81, '20784f738848c693b6cf51cf325412a3', 'hi@tusk.one', 1, 'Moon', 'Jello', '47.0167167', '28.8497415', 1, 0, 15, 30, '+115754986706', '1982-05-26 15:40:03', 'Testing', 'media/qfsstxBsZZ.png', 1, 0, 1, '2017-05-26 06:51:29', '', '', NULL, 0, 'Chişinău', 'MD', 'Chişinău', '', ''),
(82, 'e7edebee9d48fea3dd53edcadfa88537', 'billsmith@gmail.com', 1, 'smith', 'bill', '34.0541247', '-118.2433624', 3, 0, 20, 80, '+12052365874', '1969-05-28 15:40:03', 'Only the best', 'media/J6N8zGj6fR.png', 0, 0, 1, '2017-05-28 14:34:47', '', '', NULL, 0, 'California', 'US', 'California', '', ''),
(83, 'e7edebee9d48fea3dd53edcadfa88537', 'billwaters@gmail.com', 0, 'waters', 'bill', '34.0541247', '-118.2433624', 0, 1, 15, 15, ' ', ' ', 'California', '', 0, 0, 1, '2017-05-30 12:48:16', '', '', NULL, 0, 'US', 'California', ' ', '', ''),
(84, 'cab4a1d3e1180a4c8d3f526ca8c500c4', 'hr@midnight.works', 1, 'Yoghurt', 'Mark', '47.0167167', '28.8497415', 0, 0, 15, 20, '+1569362348234', '1984-06-02 15:40:03', 'Asa', 'media/14fyYnccXH.png', 1, 0, 1, '2017-06-02 10:03:56', '', '', NULL, 0, 'Chişinău', 'MD', 'Chişinău', '', ''),
(85, '1a100d2c0dab19c4430e7d73762b3423', 'lalala@gmail.com', 1, 'Tren', 'Jora', '47.0167167', '28.8497415', 0, 0, 20, 30, '+1956434818', '1981-06-08 15:40:03', 'Hurburgue', 'media/qvYdAawWq3.png', 1, 0, 1, '2017-06-08 07:21:38', '', '', NULL, 0, 'Chişinău', 'MD', 'Chişinău', '', ''),
(86, 'e10adc3949ba59abbe56e057f20f883e', 'tralala@gmail.com', 0, 'Paralon', 'Ion', '47.0167167', '28.8497415', 0, 1, 15, 15, ' ', ' ', 'Chişinău', '', 0, 0, 1, '2017-06-08 07:36:50', '', '', NULL, 0, 'MD', 'Chişinău', ' ', '', ''),
(87, '1a100d2c0dab19c4430e7d73762b3423', 'alalal@gmail.com', 1, 'Fishface', 'Tanos', '47.0167167', '28.8497415', 0, 0, 20, 30, '+134343275', '1988-06-09 15:40:03', ':/', 'media/K2ELKZA5mb.png', 1, 0, 1, '2017-06-09 08:11:16', '', '', NULL, 0, 'Chişinău', 'MD', 'Chişinău', '', ''),
(88, '75a593a34aa5ba8e5e5788b7c899802e', 'flyflyerson3@gmail.com', 0, 'smith', 'john', '40.7124879', '-74.0062775', 0, 1, 15, 15, ' ', ' ', 'New York', '', 0, 0, 1, '2017-06-09 13:14:01', '', '', NULL, 0, 'US', 'New York', ' ', '', ''),
(89, 'e7edebee9d48fea3dd53edcadfa88537', 'waterbill@gmail.com', 1, 'bill', 'water', '34.0541247', '-118.2433624', 3, 0, 20, 80, '+19585632365', '1982-06-09 15:40:03', 'The best worker', 'media/AmQURaRrkX.png', 0, 0, 1, '2017-06-09 15:24:27', '', '', NULL, 0, 'California', 'US', 'California', '', ''),
(90, '9e9260573674110d0352290592d14de4', 'rainbowparty@att.net', 1, 'Evans ', 'Jennifer', '35.910262', '-79.055474', 4, 1, 20, 20, '+19193600319', '1965-12-14 15:40:03', 'Love caring for the elderly. Hospice trained and CPR certified.  Will provide references, certification varification and recent background check.  ', 'media/0Ad84ef2GD.png', 0, 0, 1, '2017-06-09 22:47:54', '', '', NULL, 0, 'North Carolina', 'US', 'North Carolina', '', ''),
(91, '61da0597e669330c1d81742044aee28f', 'Clark27215@gmail.com', 1, 'Clark', 'Sylvia', '36.072258', '-79.462493', 2, 0, 15, 15, '3363435858', 'March 11, 1969', 'I am passionate about patient care. I promote quality of care by assessing  patients needs. I take pride in making sure that my client knows that I will  listen, support, and care for them. I am diligent, dependable, and committed to my client. ', 'media/T8VER1Mlum.png', 0, 1, 0, '2017-06-10 02:03:49', 'APA91bHJNWrq7KD7lTCqM6sSefTvUAaKQ_u5bwD1QLTLmGONa9rioVilEdbo-d9nzcR8XqetuFWQCQzvQA0p58oGBUWBGF4vIKOzlwwawG2Owz7-1BqoS-642NlAEX6uyISApGSYWel2', '', '2017-07-10', 0, 'North Carolina', 'US', 'North Carolina', '', ''),
(92, '06ee47b4901204c54295a576dabfc406', 'evans.jane12@gmail.com', 1, 'Evans', 'Janequia', '36.0977335', '-80.3131077', 0, 1, 15, 25, '+19196991858', '1994-01-21 15:40:03', 'Have worked with alzhiemers and dementia patients. ', 'media/xt5AfCgfZK.png', 0, 0, 1, '2017-06-10 02:31:58', '', '7b642893d5fda9658d241b891498e919d7d27758aa39e06948d8da01b3c8aee2', NULL, 0, '', '', '', '', ''),
(93, '102de5e5a79546e1830aee94c18cc933', 'lindseysmithart@windstream.net', 0, 'Smithart', 'Lindsey', '30.2869858', '-83.0064584', 0, 1, 15, 15, ' ', ' ', 'Florida', '', 0, 0, 1, '2017-06-12 20:51:08', '', '', NULL, 0, 'US', 'Florida', ' ', '', ''),
(94, '8fbf6164f6be586cc699fdb328a165ab', 'jazzmin.hall7@gmail.com', 1, 'Hall', 'Jazzmin', '42.332916', '-83.047853', 0, 0, 15, 120, '+13136583814', '1996-08-13 15:40:03', 'Skills\nStrong verbal communication\nConflict resolution\nTeam leadership\nSelf-motivated\n', 'media/gfgmNoo1nw.png', 1, 0, 1, '2017-07-13 11:43:31', '', '', NULL, 0, 'Ontario', 'CA', 'Ontario', '', ''),
(95, 'cc03e747a6afbbcbf8be7668acfebee5', 'mills@gmail.com', 1, 'test', 'mills', '35.2216645', '-80.838701', 3, 1, 20, 30, '+19193608523', '1981-07-26 15:40:03', 'Best you will find', 'media/aBB6AA5s7w.png', 1, 0, 1, '2017-07-26 11:44:42', '', '', NULL, 0, 'North Carolina', 'US', 'North Carolina', '', ''),
(96, 'cc03e747a6afbbcbf8be7668acfebee5', 'sillm@gmail.com', 0, 'test', 'sillm', '35.2216645', '-80.838701', 0, 1, 15, 15, ' ', ' ', 'North Carolina', '', 0, 0, 1, '2017-07-26 11:49:37', '', 'cbfb0e15341ad2f5e7b831523fe76fe4e9e2e71f80852041f9eb6640ee225711', NULL, 0, 'US', 'North Carolina', ' ', '', ''),
(97, 'e10adc3949ba59abbe56e057f20f883e', 'one_test@mail.com', 1, 'Doe', 'John', '47.0167167', '28.8497415', 1, 0, 20, 50, '+168724589', '2007-03-12 15:40:03', 'Test text', 'media/MKV2fi8ZM0.png', 1, 0, 1, '2017-07-28 10:41:24', '', '0685160e578b1b407b6d7c3b8a33a0e38bb641aba0682d2d1ff72b5acce46a30', NULL, 0, 'Chişinău', 'MD', 'Chişinău', '', ''),
(98, 'e10adc3949ba59abbe56e057f20f883e', 'test_two@mail.com', 1, 'Doe', 'John', '46.99158239999999', '28.857593100000003', 1, 1, 15, 30, '+1623496494', 'Chișinău', 'Test', 'media/FJcuaoA4b7.png', 1, 1, 1, '2017-07-28 11:23:55', 'APA91bFGQNDrgTjBGBb_pK_Sf4lOU3Ojk-FF6r-WKNMPQ8ZG2MGTpuCvSPeLv3BwuMDl-g5GHwma6VmIQpNGvJAUECQMHEkmDzOb2N8-J6CillYGRQsSqJIkbBPDIRoxUC--iL2M7zaU', '', '2017-08-27', 0, 'Chişinău', 'MD', 'Chişinău', '', ''),
(99, '48c6fb3f6a8ab1c458dc2d0de173acba', 'herlinda711@yahoo.com', 1, 'Sandoval', 'Herlinda', '34.2418589', '-118.4316476', 1, 0, 15, 20, '+18187386699', '1994-07-11 15:40:03', 'Had experience working in a nursing home faciltiy for 3 years', 'media/lGi8E3cyUo.png', 1, 0, 1, '2017-08-01 04:13:23', '', '', NULL, 0, 'California', 'US', 'California', '', ''),
(100, '09f662b8d2baf94935092c65e784318a', 'fatmatakaloko@gmail.com', 0, 'kaloko', 'fatmata', '38.640037', '-77.296673', 0, 1, 15, 15, ' ', ' ', 'Virginia', '', 0, 0, 1, '2017-08-10 18:47:46', '', '', NULL, 0, 'US', 'Virginia', ' ', '', ''),
(101, 'e108e011e1d131769049aa817d861ae9', 'lopazevans@gmail.com', 1, 'Evans ', 'Jennifer', '39.80551726514516', '-77.74086177666842', 0, 0, 15, 20, '+19193236633', '1973-08-12 15:40:03', 'Help everybody\n', 'media/DmaMj0ojKd.png', 0, 0, 1, '2017-08-12 15:34:27', '', '', NULL, 0, 'Pennsylvania', 'US', 'Pennsylvania', '', ''),
(102, 'e108e011e1d131769049aa817d861ae9', 'lopazevans@gmail.com', 1, 'Evans ', 'Jennifer', '39.80551726514516', '-77.74086177666842', 0, 0, 15, 20, '+19193236633', '1973-08-12 15:40:03', 'Help everybody\n', 'media/o4GLHQ8FlH.png', 0, 0, 1, '2017-08-12 15:34:27', '', '', NULL, 0, 'Pennsylvania', 'US', 'Pennsylvania', '', ''),
(103, '90654d55a3026c702b716df87633cba3', 'tbugqt1999@hotmail.com', 0, 'zimmerman', 'victoria', '40.6530663', '-111.9552946', 0, 1, 15, 15, ' ', ' ', 'Utah', '', 0, 0, 1, '2017-08-16 22:06:18', '', '', NULL, 0, 'US', 'Utah', ' ', '', ''),
(104, '2494d7132ac72396cfa114f7cef099ea', 'lilythao9@gmail.com', 0, 'thao', 'lily', '34.117464', '-83.573374', 0, 1, 15, 15, ' ', ' ', 'Georgia', '', 0, 0, 1, '2017-08-31 23:24:50', '', '', NULL, 0, 'US', 'Georgia', ' ', '', ''),
(105, '53ae2d5178736686bbf8e778856569a4', 'smurfskatina@gmail.com', 1, 'king', 'Katina', '38.546977500000004', '-120.74404296875001', 2, 1, 20, 30, '2092830145', 'October 24, 1980', 'Hi I\'m a C.N.A. right know I\'m a home care aid through Nurse Next Door\'s looking to find a client are two to keep my C.N.A. active .\n\n\n\n\n\n\n\n\n\n\n\n', 'media/yBO0pzb3VB.png', 0, 1, 1, '2017-09-07 07:39:21', 'APA91bHpYjlqBgXmX_0Iz2jPIpGHURMMMqLQdJw_xhTlJCzsLb1ZB0tiT1jnlYkiucg6-9cXy6xhuzu3nSckpLgLa4GSGRGuLqxGffIDhziiuSts65LC_sfFcSfE__6esEyK0BXxbuCq', '', '2017-10-07', 0, 'California', 'US', 'California', '', ''),
(106, '6532721ed9240b14503c7882f3f537f6', 'ptrip13@aol.com', 0, 'Tripodi', 'Pat', '41.9485661', '-71.3550829', 0, 1, 15, 15, ' ', ' ', 'Massachusetts', '', 0, 0, 1, '2017-09-10 17:02:43', '', '30d675e315ed6b25899c4b23ca0460f92a4fe8a552716a57023ff786ca1c2e4e', NULL, 0, 'US', 'Massachusetts', ' ', '', ''),
(107, '6ea934d1f2723486f4d1f2bc254285f8', 'Ciyavahhenry34@yahoo.com', 1, 'Henry ', 'Ciyavah ', '41.784288800000006', '-72.6745871', 2, 1, 15, 18, '8608045373', 'October 4, 1995', 'Hi my name is Ceecee I\'m 22 years old and I have nursing aide experience from rehabilitation centers and personal experience at home from taking care of my late grandfather ', 'media/NTFav20IKT.png', 0, 1, 1, '2017-09-15 13:39:46', 'APA91bGTYiyC9IEctkFuZNABwJ3Aeoido0BIDTiPVt4FPFmkDcjHb7or_-UwQMUWyZj-xV97A3nZuwuR_OAziUEfuqh_dQsQwpIZKNng-LpG_GloYEfgrWEJk7IorXN0gW3fD-tIJvWB', '', '2017-10-15', 0, 'Connecticut', 'US', 'Connecticut', '', ''),
(108, '45307e2bb2acae059199d3cf3baf1ed2', 'amenitakaloko@icloud.com', 1, 'kaloko', 'fatmata', '38.663462', '-77.245654', 2, 0, 15, 20, '+15713599220', '1997-05-27 15:40:03', 'Hello my name is Fatmata Kaloko, I\'m 20 years old. I been a CNA for 5 years now and I have a lot of experience working with different people and different places. I\'m bilingual, I have excellent communication skills, great team player. \n', 'media/0bZxpdPSZw.png', 0, 0, 1, '2017-09-19 01:04:49', '', '', NULL, 0, 'Virginia', 'US', 'Virginia', '', ''),
(109, '5f4dcc3b5aa765d61d8327deb882cf99', 'healthcare@mailinator.com', 0, 'care', 'health', '40.7124879', '-74.0062775', 0, 1, 15, 15, ' ', ' ', 'New York', '', 0, 0, 1, '2017-09-19 19:32:03', '', '', NULL, 0, 'US', 'New York', ' ', '', ''),
(110, '5f4dcc3b5aa765d61d8327deb882cf99', 'healthcare2@mailinator.com', 0, 'care', 'health', '40.7124879', '-74.0062775', 0, 1, 15, 15, ' ', ' ', 'New York', '', 0, 0, 1, '2017-09-19 19:39:24', '', '', NULL, 0, 'US', 'New York', ' ', '', ''),
(111, 'e10adc3949ba59abbe56e057f20f883e', 't@mail.com', 0, 'john', 'tom', '22.5686459', '88.3701319', 0, 1, 15, 15, ' ', ' ', 'West Bengal', '', 0, 0, 1, '2017-09-21 05:54:02', '', '', NULL, 0, 'IN', 'West Bengal', ' ', '', ''),
(112, '86d9bd7f42845af07ce6f34b6625084a', 'jarvis00@my.com', 1, 'jarvis', 'peggy', '38.5769788', '-121.494899', 0, 0, 15, 30, '+19165973707', '2015-08-12 15:40:03', 'Cpr certifed , first aid certifed , aed cerrifed , hospice care . \n', 'media/kCgfs9jzyE.png', 0, 0, 1, '2017-09-25 07:40:40', '', 'd53a85b3733a8589887fcab6391910ff1a7f487adc3cec7bb93e46776e0a5fb4', NULL, 0, 'California', 'US', 'California', '', ''),
(113, '7a4bcedd7b666976ea5f7596d9a293af', 'kiara199366@hotmail.com', 1, 'vieira', 'miria', '41.615609', '-70.91758900000001', 1, 0, 15, 120, '+17742084208', '1993-12-22 15:40:03', 'Im a fast learner and reliable \n', 'media/vsCkccqoeQ.png', 0, 0, 1, '2017-09-26 19:30:35', '', '', NULL, 0, 'Massachusetts', 'US', 'Massachusetts', '', ''),
(114, 'a212fb8a33e644c4c84be771a27f4abb', 'collinsjasmine800@gmail.com', 1, 'collins', 'jasmine', '39.370133', '-76.686823', 1, 0, 15, 16, '+14434736862', '1993-02-20 15:40:03', 'Very compassionate about my patients. Dedicated to taking fully care of any need my patient needs. ', 'media/ruClhaGS3x.png', 0, 0, 1, '2017-10-01 14:02:35', '', '', NULL, 0, 'Maryland', 'US', 'Maryland', '', ''),
(115, 'e10adc3949ba59abbe56e057f20f883e', 'waterman1233@gmail.com', 1, 'man', 'water', '35.2216645', '-80.838701', 0, 0, 35, 50, '+19193609675', '2017-10-03 15:40:03', 'Best ever', 'media/70gq5H0knP.png', 0, 0, 1, '2017-10-03 17:04:32', '', '', NULL, 0, 'North Carolina', 'US', 'North Carolina', '', ''),
(116, 'e10adc3949ba59abbe56e057f20f883e', 'testman@gmail.com', 0, 'man', 'test', '35.2216645', '-80.838701', 0, 1, 15, 15, ' ', ' ', 'North Carolina', '', 0, 0, 1, '2017-10-03 17:10:45', '', '', NULL, 0, 'US', 'North Carolina', ' ', '', ''),
(117, '25d55ad283aa400af464c76d713c07ad', 'wabissuke@gmail.com', 0, 'Spinu', 'Marcel', '47.0167167', '28.8497415', 0, 1, 15, 15, ' ', ' ', 'Chişinău', '', 0, 0, 1, '2017-10-09 09:18:45', '', '', NULL, 0, 'MD', 'Chişinău', ' ', '', ''),
(118, 'e35cf7b66449df565f93c607d5a81d09', 'valera@gmail.com', 0, 'Valera', 'Valera', '47.5551711', '28.0097857', 0, 1, 15, 15, ' ', ' ', 'Sîngerei', '', 0, 0, 1, '2017-10-09 09:33:51', '', '', NULL, 0, 'MD', 'Sîngerei', ' ', '', ''),
(119, '5f4dcc3b5aa765d61d8327deb882cf99', 'dmitrii.vrabie@gmail.com', 0, 'Vrabie', 'Dmitrii', '46.991492499999964', '28.85719921875001', 0, 1, 15, 15, ' ', ' ', ' ', '', 0, 1, 1, '2017-10-09 10:08:36', '', '', '2017-11-08', 0, 'Chişinău', 'MD', 'Chişinău', '', ''),
(120, 'e35cf7b66449df565f93c607d5a81d09', 'agahah@gmail.com', 0, 'Qiq', 'Qiq', '47.0167167', '28.8497415', 0, 1, 15, 15, ' ', ' ', 'Chişinău', '', 0, 0, 1, '2017-10-09 10:28:50', '', '', NULL, 0, 'Chişinău', 'MD', 'Chişinău', '', ''),
(121, 'e35cf7b66449df565f93c607d5a81d09', 'balea@gmail.com', 0, 'Balea', 'Balea', '47.0167167', '28.8497415', 0, 1, 15, 15, ' ', ' ', 'Chişinău', '', 0, 0, 1, '2017-10-09 10:30:48', '', '', NULL, 0, 'MD', 'Chişinău', ' ', '', ''),
(122, 'e35cf7b66449df565f93c607d5a81d09', 'balea@gmail.com', 0, 'Balea', 'Balea', '47.0167167', '28.8497415', 0, 1, 15, 15, ' ', ' ', 'Chişinău', '', 0, 0, 1, '2017-10-09 10:30:52', '', '', NULL, 0, 'MD', 'Chişinău', ' ', '', ''),
(123, '5f4dcc3b5aa765d61d8327deb882cf99', 'ajdj@h.com', 1, 'Hdnm', 'Hie', '46.991552899999995', '28.857597199999997', 1, 1, 15, 25, '+16193041372', '', 'description', 'media/vJhCy2cDba.png', 1, 1, 1, '2017-10-09 13:53:00', '', '', '2017-11-08', 0, 'Chişinău', 'MD', 'Chişinău', '', ''),
(124, 'e35cf7b66449df565f93c607d5a81d09', 'bshssh@gaha.com', 0, 'Spinu', 'Marcel', '-1', '-1', 0, 1, 15, 15, ' ', ' ', '', '', 0, 0, 1, '2017-10-09 14:21:16', '', '', NULL, 0, '', '', ' ', '', ''),
(125, 'e35cf7b66449df565f93c607d5a81d09', 'hshsj@shsh.com', 0, 'Spinu', 'Marcel', '47.02834624111467', '28.79015414538987', 0, 1, 15, 15, ' ', ' ', 'Chişinău', '', 0, 0, 1, '2017-10-09 14:25:54', '', '', NULL, 0, 'MD', 'Chişinău', ' ', '', ''),
(126, 'e35cf7b66449df565f93c607d5a81d09', 'gagags@hshs.com', 1, 'Spinu', 'Marcel', '47.03409810082668', '28.79041679386942', 0, 0, 20, 30, '+1545454545454', '1997-08-07 15:40:03', 'Jssks\n', 'media/OhesVKFdfn.png', 0, 0, 1, '2017-10-09 14:32:05', '', '', NULL, 0, 'Chişinău', 'MD', 'Chişinău', '', ''),
(127, 'e35cf7b66449df565f93c607d5a81d09', 'gagags@hshs.com', 1, 'Spinu', 'Marcel', '47.03409810082668', '28.79041679386942', 0, 0, 20, 30, '+1545454545454', '1997-08-07 15:40:03', 'Jssks\n', 'media/kA3bnJeQVx.png', 0, 0, 1, '2017-10-09 14:32:05', '', '', NULL, 0, 'Chişinău', 'MD', 'Chişinău', '', ''),
(128, '5f4dcc3b5aa765d61d8327deb882cf99', 'shhdj@gdgd.com', 0, 'Down', 'Jihb', '46.991552899999995', '28.857597199999997', 0, 1, 15, 15, ' ', ' ', ' ', '', 0, 1, 1, '2017-10-09 14:45:31', '', '', '2017-11-08', 0, 'Chişinău', 'MD', 'Chişinău', '', ''),
(129, '5f4dcc3b5aa765d61d8327deb882cf99', 'dhdj@gsh.com', 0, 'Xxx', 'Cvb', '46.991552899999995', '28.857597199999997', 0, 1, 15, 15, ' ', ' ', ' ', '', 0, 1, 1, '2017-10-09 14:46:37', '', '', '2017-11-08', 0, 'Chişinău', 'MD', 'Chişinău', '', ''),
(130, '5f4dcc3b5aa765d61d8327deb882cf99', 'test@gmail.com', 1, 'Second', 'Test', '46.991552899999995', '28.857597199999997', 1, 1, 15, 20, '+16193041372', '2038', 'description', 'media/cHo8r2SmeC.png', 0, 1, 1, '2017-10-09 14:58:41', '', '', '2017-11-08', 0, 'Chişinău', 'MD', 'Chişinău', '', 'dsddc'),
(131, 'c23a9c29e292c9706c5923a8f22d3329', 'r0siema203@gmail.com', 1, 'Cardona', 'Rosa', '41.5542609', '-73.04306920000001', 2, 0, 15, 20, '+12033609872', '1987-06-09 15:40:03', 'Im Caring , understanding and sympathetic I love what I do & take my job very serious & Im Cna certified.', 'media/6ZvzVm273B.png', 0, 0, 1, '2017-10-10 03:03:11', '', '', NULL, 0, 'Connecticut', 'US', 'Connecticut', '', ''),
(132, '5f4dcc3b5aa765d61d8327deb882cf99', 'test1@gmail.com', 1, 'Dick', 'pJim', '46.991552899999995', '28.857597199999997', 1, 1, 15, 25, '+16193041', 'March 5, 1993', 'hey', 'media/HV4pvozgof.png', 1, 1, 1, '2017-10-10 07:23:26', '', '', '2017-11-09', 0, 'Chișinău', '', 'Bulevardul Decebal, 76', '2038', 'My skill'),
(133, 'e35cf7b66449df565f93c607d5a81d09', 'valerius@gmail.com', 0, 'Balerian', 'Valerius', '47.02834624111467', '28.79015414538987', 0, 1, 15, 15, ' ', ' ', 'Chişinău', '', 0, 0, 1, '2017-10-10 07:46:37', '', '', NULL, 0, 'MD', 'Chişinău', ' ', '', ''),
(134, 'e35cf7b66449df565f93c607d5a81d09', 'petea@gmail.com', 0, 'Petrovici', 'Petea', '47.0167167', '28.8497415', 0, 1, 15, 15, ' ', ' ', 'Chişinău', '', 0, 0, 1, '2017-10-10 07:58:32', '', '', NULL, 0, 'MD', 'Chişinău', ' ', '', ''),
(135, 'e35cf7b66449df565f93c607d5a81d09', 'vasile@gmail.com', 0, 'Valer', 'Valer', '47.0167167', '28.8497415', 0, 1, 15, 15, ' ', ' ', 'Chişinău', '', 0, 0, 1, '2017-10-10 08:00:27', '', '', NULL, 0, 'MD', 'Chişinău', ' ', '', ''),
(136, 'e35cf7b66449df565f93c607d5a81d09', 'valeriu@gmail.com', 0, 'Valeriu', 'Valeriu', '47.0167167', '28.8497415', 0, 1, 15, 15, ' ', ' ', 'Chişinău', '', 0, 0, 1, '2017-10-10 08:02:42', '', '', NULL, 0, 'MD', 'Chişinău', ' ', '', ''),
(137, 'e35cf7b66449df565f93c607d5a81d09', 'vasea@yandex.ru', 0, 'Vasilii', 'Vasea', '47.0167167', '28.8497415', 0, 1, 15, 15, ' ', ' ', 'Chişinău', '', 0, 0, 1, '2017-10-10 08:05:36', '', '', NULL, 0, 'MD', 'Chişinău', ' ', '', ''),
(138, 'e35cf7b66449df565f93c607d5a81d09', 'sggab@gmail.com', 0, 'Vasile', 'Vasile', '47.0167167', '28.8497415', 0, 1, 15, 15, ' ', ' ', 'Chişinău', '', 0, 0, 1, '2017-10-10 13:38:08', '', '', NULL, 0, 'MD', 'Chişinău', ' ', '', ''),
(139, '20784f738848c693b6cf51cf325412a3', 'artiom@gmail.com', 1, 'Gullies', 'Adrian', '46.991552899999995', '28.857597199999997', 2, 1, 15, 20, '+1643949554365', '', 'test', 'media/fJRMmHnUcz.png', 1, 1, 1, '2017-10-11 07:57:44', '', '', '2017-11-10', 0, 'Chişinău', 'MD', 'Chişinău', '', ''),
(140, '20784f738848c693b6cf51cf325412a3', 'artiom@midnight.porks', 0, 'Davis', 'Johy', '46.991552899999995', '28.857597199999997', 0, 1, 15, 15, ' ', ' ', ' ', '', 0, 1, 1, '2017-10-11 08:00:30', '', '', '2017-11-10', 0, 'Chişinău', 'MD', 'Chişinău', '', ''),
(141, 'e2537517c5c777846964d4470ef855d2', 'hahahs@gmail.com', 0, 'Test', 'Test', '47.0167167', '28.8497415', 0, 1, 15, 15, ' ', ' ', 'Chişinău', '', 0, 0, 1, '2017-10-11 11:43:46', '', '', NULL, 0, 'MD', 'Chişinău', ' ', '', ''),
(142, '20784f738848c693b6cf51cf325412a3', 'yolo@gmail.com', 0, 'Bany', 'many', '47.0167167', '28.8497415', 0, 1, 15, 15, ' ', ' ', 'Chişinău', '', 0, 1, 1, '2017-10-11 14:00:00', '', '0b8c920ebc8f93061905660b5a0fcceff687e9caad67640ebd4cde9927f29366', '2017-12-03', 0, 'MD', 'Chişinău', ' ', '', ''),
(143, '5f4dcc3b5aa765d61d8327deb882cf99', 'ghjkl@gmail.com', 1, 'se', 'onHel', '28.01622769441572', '120.67891578681393', 1, 1, 15, 25, '+16193041372', 'March 5, 1994', 'seascape', 'media/p2uUsfK0ac.png', 1, 1, 1, '2017-10-12 10:57:30', '', '', '2017-11-11', 0, 'Kishinev', 'Kishinev', 'bd. Decebal, null', '', 'Top'),
(144, 'e10adc3949ba59abbe56e057f20f883e', 'adasd@gmail.com', 0, '123123', '123123', '-1', '-1', 0, 1, 15, 15, ' ', ' ', '', '', 0, 0, 1, '2017-10-12 11:12:06', '', '', NULL, 0, '', '', ' ', '', ''),
(145, 'e10adc3949ba59abbe56e057f20f883e', '2321321@gmail.com', 1, 'Asdsad', 'Dde', '53.35208748019481', '-6.285995360518458', 2, 0, 20, 30, '+1987213', '', '21323', 'media/ufc2lJkUmL.png', 0, 0, 1, '2017-10-12 12:03:26', '', '', NULL, 0, 'Leinster', 'IE', 'Leinster', '', ''),
(146, 'e10adc3949ba59abbe56e057f20f883e', 'dasda@gmail.com', 1, 'S', 'S', '37.35264838249385', '-122.0873391566601', 0, 0, 15, 25, '+13443123', '', '1212', 'media/kUYDJEs3fe.png', 0, 0, 1, '2017-10-12 12:07:10', '', '', NULL, 0, 'California', 'US', 'California', '', ''),
(147, 'e10adc3949ba59abbe56e057f20f883e', 'dasda@gmail.com', 1, 'S', 'S', '37.35264838249385', '-122.0873391566601', 0, 0, 15, 25, '+13443123', '', '1212', 'media/I1CEvQY3s3.png', 0, 0, 1, '2017-10-12 12:07:11', '', '', NULL, 0, 'California', 'US', 'California', '', ''),
(148, 'e10adc3949ba59abbe56e057f20f883e', 'mdsmmss@gmail.com', 0, 'Sms', 'Madl', '47.6299557', '7.9044547', 0, 1, 15, 15, ' ', ' ', 'Baden-Württemberg', '', 0, 0, 1, '2017-10-12 12:12:36', '', 'dfec3367fe9d78e07fcee640fab982908f48dd3ead98c7e98793d301250d1bc7', NULL, 0, 'DE', 'Baden-Württemberg', ' ', '', ''),
(149, 'd74682ee47c3fffd5dcd749f840fcdd4', 'huilo@gmail.com', 1, 'Ion', 'Marcel', '-1', '-1', 0, 0, 20, 40, '+132141241421', '', 'Wdwfw', 'media/N46kdtIGt7.png', 0, 0, 1, '2017-10-12 12:22:05', '', '', NULL, 0, '', '', '', '', ''),
(150, 'fcea920f7412b5da7be0cf42b8c93759', 'dldskn@gmail.com', 0, 'dkdk', 'dkd', '46.9957856295822', '27.86828333541417', 0, 1, 15, 15, ' ', ' ', 'Iaşi', '', 0, 0, 1, '2017-10-12 12:27:37', '', 'e85f593634d601669349b45784bd4e8c48851d6fcaae5c7e195c629c03ec67f3', NULL, 0, 'RO', 'Iaşi', ' ', '', ''),
(151, 'd74682ee47c3fffd5dcd749f840fcdd4', 'superman@gmail.com', 1, 'Man', 'Super', '47.0054037', '28.8789006', 0, 0, 20, 30, '+1417249174231', '', 'Marcel', 'media/KrffHcxwXv.png', 1, 0, 1, '2017-10-12 13:11:01', '', '', NULL, 0, 'Chişinău', 'MD', 'Chişinău', '', ''),
(152, 'd74682ee47c3fffd5dcd749f840fcdd4', 'superwomen@gmail.com', 1, 'Women', 'Super', '-1', '-1', 0, 0, 20, 40, '+1321421414141', '', 'Dwafafa', 'media/yUakgmEYBT.png', 0, 0, 1, '2017-10-12 13:28:02', '', '', NULL, 0, '', '', '', '', ''),
(153, 'd74682ee47c3fffd5dcd749f840fcdd4', 'dwafn@gmail.com', 1, 'dwadad', 'Qwer', '47.0054037', '28.8789006', 0, 0, 20, 40, '+12414141414', '', 'Dwadaw', 'media/MnHcfPOT8T.png', 0, 0, 1, '2017-10-12 13:33:34', '', '', NULL, 0, 'Chişinău', 'MD', 'Chişinău', '', '420,445'),
(154, 'd74682ee47c3fffd5dcd749f840fcdd4', 'fwaffa22@gmail.com', 1, 'Dwadwafw', 'Qwer', '-1', '-1', 0, 0, 20, 30, '+124141414142', '', 'Fafwa', 'media/rU9k5MRWwY.png', 0, 0, 1, '2017-10-12 13:35:45', '', '', NULL, 0, '', '', '', '', '435,434'),
(155, 'd74682ee47c3fffd5dcd749f840fcdd4', 'dwahhfo@gmail.com', 1, 'FNoiwno', 'Alewfiwo', '-1', '-1', 0, 0, 20, 50, '+12314214121', '', 'Dawdada', 'media/vfM2sp2Zj6.png', 0, 0, 1, '2017-10-12 13:43:16', '', '', NULL, 0, '', '', '', '', 'Vadim,Marcel'),
(156, 'd74682ee47c3fffd5dcd749f840fcdd4', 'alex@gmail.com', 1, 'Alex', 'Alex', '-1', '-1', 0, 0, 20, 80, '+12115253212', '', 'Desc', 'media/vtxDZpXPRc.png', 0, 0, 1, '2017-10-12 13:44:53', '', '', NULL, 0, '', '', '', '', 'Marcel,Vadim'),
(157, 'e10adc3949ba59abbe56e057f20f883e', 'zsmam@gmaol.clm', 1, 'Ssn', 'Xnx', '47.0104529', '28.863810200000003', 1, 1, 25, 60, '4844', '', 'sbsh', 'media/I3rzhK93pg.png', 0, 1, 1, '2017-10-12 16:41:32', '', '', '2017-11-11', 0, 'Chişinău', 'MD', 'Chişinău', '', '  Ddd'),
(173, 'e10adc3949ba59abbe56e057f20f883e', 'sadasd@gmail.com', 1, 'Lepadatu', 'Alin', '40.6219541', '-74.1055357', 0, 1, 15, 30, '+1791232131231', '', '12312312', 'media/MPpkf1Y8oJ.png', 0, 1, 1, '2017-10-12 18:23:39', '', '', NULL, 0, 'New York', 'NY', 'str. Ismail', '2001', 'Vanea,Rot'),
(174, 'e10adc3949ba59abbe56e057f20f883e', 'joinmoris@gmail.com', 1, 'Mor', 'Join', '37.09285420933502', '-113.5007659982115', 0, 0, 17, 40, '+143323123', '', '213123', '../media/ltikj69WdI.png', 0, 0, 1, '2017-10-12 18:33:33', '', '', NULL, 0, 'Washington', 'Washington', 'Washingdon', '2001', 'Roma'),
(175, 'e10adc3949ba59abbe56e057f20f883e', '3213123@gmail.com', 1, '23123', '213', '47.6403823', '26.2476471', 0, 0, 15, 30, '+1721372137', '', '213123', '/ios/media/zrKiV6TGST.png', 0, 0, 1, '2017-10-12 18:35:41', '', '', NULL, 0, 'Suceava', 'Romania', 'Suceava', '2202', '23123'),
(176, 'e10adc3949ba59abbe56e057f20f883e', 'weqewjwqj@gmail.com', 1, 'Ma', 'Yo', '47.6403823', '26.2476471', 0, 0, 15, 30, '+1353312412321', '', '213123', '/ios/media/c7vZfbcDwS.png', 0, 0, 1, '2017-10-12 18:38:10', '', '', NULL, 0, 'Suceava', 'Romania', 'Suceava', '2001', 'AA'),
(177, 'e10adc3949ba59abbe56e057f20f883e', 'weqewjwqj1@gmail.com', 1, 'Ma', 'Yo', '47.6403823', '26.2476471', 0, 0, 15, 30, '+1353312412321', '', '213123', '/ios/media/5oUwNyWnTb.png', 0, 0, 1, '2017-10-12 18:40:22', '', '', NULL, 0, 'Suceava', 'Romania', 'Suceava', '2001', 'AA'),
(178, 'e10adc3949ba59abbe56e057f20f883e', 'weqewjwqj2@gmail.com', 1, 'Ma', 'Yo', '47.6403823', '26.2476471', 0, 1, 15, 30, '+1353312412321', '', '213123', 'media/H7NN7iqA19.png', 0, 1, 1, '2017-10-12 18:41:54', '', '', NULL, 0, 'Suceava', 'Romania', 'Suceava', '2001', ''),
(179, 'e10adc3949ba59abbe56e057f20f883e', '324233213@gmail.com', 1, '123', '123', '40.63331359461276', '-3.572321604947501', 0, 1, 15, 20, '+123323123', '', '2131', 'media/35iK2Du0pW.png', 0, 1, 1, '2017-10-12 18:48:25', '', '', NULL, 0, 'Chisinau', 'MD', 'Do,a', 'MD', 'Ro'),
(180, 'e10adc3949ba59abbe56e057f20f883e', '32312@gmail.com', 1, '132', '213', '51.49837011353589', '-0.1040176233705015', 0, 0, 15, 120, '+165646345', '', '213123', 'media/mPEEr3LjR1.png', 0, 1, 1, '2017-10-12 18:57:57', '', '', NULL, 0, 'London', '132', 'London, England', '221', ''),
(181, '20784f738848c693b6cf51cf325412a3', 'yoga@gmail.com', 1, 'Crews', 'Terry', '47.00920721935118', '28.86029283704949', 0, 0, 15, 30, '+14861354663', '', 'Test', 'media/u2FbfZ4psb.png', 0, 1, 1, '2017-10-13 12:18:44', '', '', '2017-12-03', 0, 'Chisinau', 'Moldova', 'Bd.Decebal 99/3', '2038', 'Massaging'),
(182, '5f4dcc3b5aa765d61d8327deb882cf99', 'hshs@gmail.com', 1, 'Carey', 'Jim', '46.9915641', '28.8587047', 1, 1, 25, 35, '+16193041372', 'January 1, 1973', 'Dr pepper', 'media/3xEIAFcAdP.png', 1, 1, 1, '2017-10-13 14:00:17', '', '', '2017-11-12', 0, 'Chișinău', 'Chișinău', 'Bulevardul Decebal, 76', '2007', ''),
(183, '5f4dcc3b5aa765d61d8327deb882cf99', 'h@gmail.com', 1, 'Molybdenum', 'Holy', '46.991552899999995', '28.857597199999997', 1, 1, 34, 50, '+1619304', 'January 26, 1994', 'potential', 'media/x3AyycVeFo.png', 1, 1, 1, '2017-10-13 14:04:36', '', '', '2017-11-12', 0, 'Chișinău', 'Chișinău', 'Bulevardul Decebal, 76', '', ''),
(184, '5f4dcc3b5aa765d61d8327deb882cf99', 'ghj@gmail.com', 1, 'Carey', 'Jim ', '46.9915641', '28.8587047', 1, 1, 15, 25, '+7896', 'January 1, 1989', 'description', 'media/tQtNxL4aOz.png', 0, 1, 1, '2017-10-13 14:11:47', '', '', '2017-11-12', 0, 'Chișinău', 'Chișinău', 'Bulevardul Decebal, 76', '266', ''),
(185, '20784f738848c693b6cf51cf325412a3', 'yoto@gmail.com', 1, 'Crews', 'Terry', '47.0167167', '28.8497415', 1, 1, 15, 30, '+1349835494', '1991-10-20 15:40:03', 'Test', 'media/5HIrhvgOsP.png', 1, 1, 1, '2017-10-13 14:43:37', 'APA91bHIc-WHq-L2RZkqSN36m22nSqxP1l8fSgc0NR95-qLGq7tQaBykKtOhMawSAe2taLlICdmb76Yc138yWDo7A-VhNggUdgCAvPDKer4ag7hvf0VxTdIbfX04jqaBWZdPPxfpSJKL', '', '2017-11-12', 0, 'Kishinev', 'Moldova', 'Kishinev, Moldova', '', 'Massage'),
(186, '20784f738848c693b6cf51cf325412a3', 'yoloty@gmail.com', 1, 'Doe', 'John', '46.991552899999995', '28.857597199999997', 1, 1, 15, 30, '+1673794664', '', 'Test', 'media/9AUydC7qiE.png', 1, 1, 1, '2017-10-13 14:47:38', '', '', '2017-11-12', 0, 'Chișinău', 'Chișinău', 'Bulevardul Decebal, 76', '', ''),
(187, '6877b983a41b46fa9ee30fc64824cb76', 'abraha.helen12@gmail.com', 1, 'Abraha', 'Helen', '33.9781805', '-117.5219699', 0, 0, 15, 21, '+13105905209', '1975-12-12 15:40:03', 'I am a honesty and hard worker. I love my job.', 'media/YhkY8oiggk.png', 0, 0, 1, '2017-10-14 07:02:27', '', 'e414498b939802094194abf6eb979bfb5e2695996b0481810ac03a4bfb10dde1', NULL, 0, '', '', '', '', ''),
(188, '488ecb283f37f7737eaad7e9afaacd80', 'jenniferevansmusic@gmail.com', 0, 'Evans ', 'Jennifer', '35.90223740326619', '-79.05046331340199', 0, 1, 15, 15, ' ', ' ', ' ', '', 0, 0, 1, '2017-10-18 15:13:04', '', '', NULL, 0, 'Chapel Hill', 'NC', '621 Jackson St', '37516', ''),
(189, '20784f738848c693b6cf51cf325412a3', 'yogurt@gmail.com', 0, 'Bernsen', 'Arnie', '46.9885824', '28.8705819', 0, 1, 15, 15, ' ', ' ', ' ', '', 0, 0, 1, '2017-10-19 09:00:16', '', '', NULL, 0, 'Chisinau', 'Moldova', 'Cuza-Voda 45/11', '2038', '');
INSERT INTO `users` (`id`, `password`, `email`, `type`, `last_name`, `first_name`, `address_lat`, `address_long`, `experience`, `available_time`, `price_min`, `price_max`, `phone`, `birthday`, `description`, `profile_img`, `gender`, `subscribed`, `available`, `registration_time`, `android_push`, `ios_push`, `expire`, `hidden`, `city`, `state`, `address`, `zip`, `other_skills`) VALUES
(190, 'e10adc3949ba59abbe56e057f20f883e', '2213@gmail.com', 0, '123123', '1213', '46.78813357476267', '27.24313148336086', 0, 1, 15, 15, ' ', ' ', ' ', '', 0, 0, 1, '2017-10-23 08:41:14', '', '', NULL, 0, '123', '3123', '123', '201', ''),
(191, '11f6667c5a17190015e7a44f250e9226', '231123@gmail.com', 0, '13', '13', '48.8567879', '2.3510768', 0, 1, 15, 15, ' ', ' ', ' ', '', 0, 0, 1, '2017-10-23 08:50:36', '', '', NULL, 0, 'Paris', '', 'Paris, France', '2001', ''),
(196, 'e10adc3949ba59abbe56e057f20f883e', '123412@gamil.com', 0, '1', '1', '46.78813357476267', '27.24313148336086', 0, 1, 15, 15, '+12133123123', ' ', ' ', '', 0, 0, 1, '2017-10-23 09:15:54', '', '', NULL, 0, '123', '123', '123', '123', ''),
(198, 'e10adc3949ba59abbe56e057f20f883e', '213123c@gmail.com', 0, 'Ad', 'Wa', '40.7062867', '-74.0092629', 0, 1, 15, 15, '+1213213213', ' ', ' ', '', 0, 0, 1, '2017-10-23 09:57:26', '', '', NULL, 0, 'New York22', 'NY', 'Wall Street', '2001', ''),
(199, 'e10adc3949ba59abbe56e057f20f883e', '323324@gmail.com', 0, '123', '213', '46.48219352875915', '30.73376476764679', 0, 1, 15, 15, '+1535346', ' ', ' ', '', 0, 0, 1, '2017-10-23 10:06:10', '', '', NULL, 0, 'Odessa', 'Odessa', 'Vitse-Admirala Zhukova provulok', '2001', ''),
(200, 'e10adc3949ba59abbe56e057f20f883e', '21323@gmail.com', 0, 'Ad', 'Ace', '41.090984', '-73.918239', 0, 1, 15, 15, '+132443123123', ' ', ' ', '', 0, 0, 1, '2017-10-23 10:57:50', '', '', NULL, 0, 'Asd', 'NY', 'New York', '2000', ''),
(201, 'e10adc3949ba59abbe56e057f20f883e', '324@gmmma.com', 0, 'As', 'C', '41.8905568', '12.4942679', 0, 1, 15, 15, '+121312321123', ' ', ' ', '', 0, 0, 1, '2017-10-23 11:17:47', '', '', NULL, 0, 'Rome', 'Lazio', 'Rome', '2001', ''),
(202, '11f6667c5a17190015e7a44f250e9226', 'ewqqwe@gmail.com', 0, '123', '213', '45.42461994223454', '9.20769686345011', 0, 1, 15, 15, '+1324234324', ' ', ' ', '', 0, 0, 1, '2017-10-23 11:18:48', '', '', NULL, 0, 'Milan1', 'Lombardy', 'Via Federico Chopin', '20141', ''),
(203, 'e10adc3949ba59abbe56e057f20f883e', 'wqewqe@gmail.com', 0, 'Wqeqwe', 'Eqw', '46.9793043', '28.8465185', 0, 1, 15, 15, '+1324324324', ' ', ' ', '', 0, 0, 1, '2017-10-23 11:22:27', '', '', NULL, 0, 'Chisinau1', 'Moldova', 'Moldova', '20012', ''),
(204, 'e10adc3949ba59abbe56e057f20f883e', '111111@gmail.com', 1, 'Qweqwe', 'Waw', '-1', '-1', 0, 1, 22, 23, '+1213213123213', '2017-10-23 15:40:03', '213213', 'media/vnuPB90B2E.png', 0, 0, 1, '2017-10-23 11:57:51', '', '', NULL, 0, 'Qwe', 'Qwe', 'Wqe', 'Qwewqe', ''),
(205, '5f4dcc3b5aa765d61d8327deb882cf99', 'awd@gmail.com', 1, 'Dufel', 'Jony', '28.01622769441572', '120.67891578681393', 1, 1, 10, 15, '+16193041372', 'January 1, 1988', 'My description', 'media/OAdtP0ljfk.png', 1, 1, 1, '2017-10-27 10:57:25', 'APA91bGxvjZTAwc60g0UEqvncQZJvHv2KLGiCeOJ1mHDbTTG4wTHfU2AmThQi1wyFNUjlZn5s1nyWeGbUkiV7FZNgDW3rnqBCnTy0V49mo-bPfQrhVciqeEEnx_OXfwbw-U73DiBGevO', '', '2017-11-26', 0, 'Kishinev', 'Kishinev', 'str. Ismail, null', '', ''),
(206, '5f4dcc3b5aa765d61d8327deb882cf99', 'vk@g.com', 1, 'D', 'Kia', '46.991552899999995', '28.857597199999997', 1, 1, 12, 15, '+16193041372', 'January 1, 1978', 'potential', 'media/zWVd2myG4o.png', 0, 1, 0, '2017-10-31 10:01:35', '', '', '2017-11-30', 0, 'Chișinău', 'Chișinău', 'Bulevardul Decebal, 76', '', ''),
(207, '5f4dcc3b5aa765d61d8327deb882cf99', 'alli@gmail.com', 0, 'He', 'San', '46.991552899999995', '28.857597199999997', 0, 1, 15, 15, ' ', ' ', ' ', '', 0, 1, 1, '2017-10-31 10:03:47', '', '', '2017-11-30', 0, 'Chișinău', 'Chișinău', 'Bulevardul Decebal, 76, Chișinău, Chișinău, 2038', '2038', ''),
(208, '5f4dcc3b5aa765d61d8327deb882cf99', 'ind@gmail.com', 0, 'Ividual', 'Ind', '28.01622769441572', '120.67891578681393', 0, 1, 15, 15, ' ', ' ', ' ', '', 0, 1, 1, '2017-10-31 15:45:56', '', '', '2017-11-30', 0, 'Kishinev', 'Kishinev', 'str. Ismail, null, Kishinev, Kishinev, ', 'null', ''),
(209, '608d4dcbee009de54e2988e433bf3093', 'mookniely@icloud.com', 1, 'Biondo ', 'Mike', '42.3466947', '-88.0486099', 2, 0, 15, 100, '+18475483700', '1984-11-02 15:40:03', 'Im a cna ans looking for a job part time.', 'media/LyArbwjyzL.png', 0, 0, 1, '2017-11-02 23:24:10', '', '', NULL, 0, 'Grayslake ', 'Illinois', '138 harvey ave', '60030', ''),
(210, 'e10adc3949ba59abbe56e057f20f883e', '12323@gmail.com', 0, 'ASs', 'C', '30.7777452', '-107.9386703', 0, 1, 15, 15, '+1767456546', ' ', ' ', '', 0, 0, 1, '2017-11-06 14:00:15', '', '', NULL, 0, 'Chis', 'Dmsd', '123123', 'ASd', ''),
(211, '11f6667c5a17190015e7a44f250e9226', 'dasdsa@gmail.com', 1, '123123', '21312', '17.2952423', '-91.5777185', 0, 0, 19, 100, '+12313213123', '2017-11-05 15:40:03', '123213', 'media/ntpDUCtcc7.png', 0, 0, 1, '2017-11-06 17:57:56', '', '', NULL, 0, 'Chisi', 'Sad', 'SDsad', '20123', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `conversations`
--
ALTER TABLE `conversations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `days`
--
ALTER TABLE `days`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `offers`
--
ALTER TABLE `offers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rating`
--
ALTER TABLE `rating`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reports_user`
--
ALTER TABLE `reports_user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `skills`
--
ALTER TABLE `skills`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `skills_attribute`
--
ALTER TABLE `skills_attribute`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `conversations`
--
ALTER TABLE `conversations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `days`
--
ALTER TABLE `days`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;
--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `offers`
--
ALTER TABLE `offers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `rating`
--
ALTER TABLE `rating`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `reports_user`
--
ALTER TABLE `reports_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `skills`
--
ALTER TABLE `skills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;
--
-- AUTO_INCREMENT for table `skills_attribute`
--
ALTER TABLE `skills_attribute`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=384;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=212;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
