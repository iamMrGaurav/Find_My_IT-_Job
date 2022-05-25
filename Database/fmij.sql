-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 29, 2022 at 10:37 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.0.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fmij`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(10) NOT NULL,
  `username` varchar(25) NOT NULL,
  `password` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `username`, `password`) VALUES
(1, 'admin', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `applied_job`
--

CREATE TABLE `applied_job` (
  `seeker_id` int(10) NOT NULL,
  `job_id` int(10) NOT NULL,
  `applied_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `applied_job`
--

INSERT INTO `applied_job` (`seeker_id`, `job_id`, `applied_date`) VALUES
(15, 67, '2022-04-04 00:00:00'),
(15, 63, '2022-04-07 00:00:00'),
(15, 26, '2022-04-07 00:00:00'),
(15, 14, '2022-04-16 00:00:00'),
(15, 9, '2022-04-16 00:00:00'),
(15, 64, '2022-04-25 00:00:00'),
(6, 67, '2022-04-25 14:39:42'),
(15, 18, '2022-04-25 00:00:00'),
(15, 17, '2022-04-26 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `bookmark`
--

CREATE TABLE `bookmark` (
  `seeker_id` int(10) NOT NULL,
  `job_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bookmark`
--

INSERT INTO `bookmark` (`seeker_id`, `job_id`) VALUES
(6, 15),
(6, 63),
(15, 14);

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

CREATE TABLE `company` (
  `comapny_id` int(10) NOT NULL,
  `company_name` varchar(50) NOT NULL,
  `email_address` varchar(50) NOT NULL,
  `contact_no` varchar(50) NOT NULL,
  `website` varchar(100) NOT NULL,
  `district_id` int(10) NOT NULL,
  `company_description` varchar(500) NOT NULL,
  `image_path` varchar(150) NOT NULL,
  `user_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `company`
--

INSERT INTO `company` (`comapny_id`, `company_name`, `email_address`, `contact_no`, `website`, `district_id`, `company_description`, `image_path`, `user_id`) VALUES
(2, 'teisapce123', 'teispace2021@gmail.com', '061222', 'www.teus', 5, 'a technology company that helps enterprises reimagine their businesses for the digital age and helps technology focused companies grow through strategy and marketing. We offer an integrated portfolio of products, solutions, and services.', 'images/facebook.png', 26),
(3, 'google', 'google@gmail.com', '021-9821', 'google.com', 38, 'last companya company established in 2002, has solidified its position as an effective supplier of ', 'images/google.jpg', 27),
(4, 'Khalti', 'khalti@gmail.com', '061-523211', 'www.khalti.com', 24, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,', 'images/khalti.png', 28),
(5, 'instagram', 'insta@gmail.com', '01-02311', 'facebook.com', 36, 'a company established in 2002, has solidified its position as an effective supplier of ', 'images/insta.jpg', 29);

-- --------------------------------------------------------

--
-- Table structure for table `district`
--

CREATE TABLE `district` (
  `district_id` int(10) NOT NULL,
  `district_name` varchar(50) NOT NULL,
  `state_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `district`
--

INSERT INTO `district` (`district_id`, `district_name`, `state_id`) VALUES
(1, 'Bhojpur', 1),
(2, 'Dhankuta', 1),
(3, 'Ilam', 1),
(4, 'Jhapa', 1),
(5, 'Khotang', 1),
(6, 'Morang', 1),
(7, 'Okhaldhunga', 1),
(8, 'Pachthar', 1),
(9, 'Sankhuwasabha', 1),
(10, 'Solukhumbu', 1),
(11, 'Sunsari', 1),
(12, 'Taplejung', 1),
(13, 'Terhathum', 1),
(14, 'Udayapur', 1),
(15, 'Parsa', 2),
(16, 'Bara', 2),
(17, 'Rautahat', 2),
(18, 'Sarlahi', 2),
(19, 'Siraha', 2),
(20, 'Dhanusha', 2),
(21, 'Saptari', 2),
(22, 'Mahottari', 2),
(23, 'Bhaktapur', 3),
(24, 'Chitwan', 3),
(25, 'Dhading', 3),
(26, 'Dolakha', 3),
(27, 'Kathmandu', 3),
(28, 'Kavrepalanchok', 3),
(29, 'Lalitpur', 3),
(30, 'Makwanpur', 3),
(31, 'Nuwakot', 3),
(32, 'Ramechap', 3),
(33, 'Rasuwa', 3),
(34, 'Sindhuli', 3),
(35, 'Sindhupalchok', 3),
(36, 'Baglung', 4),
(37, 'Gorkha', 4),
(38, 'Kaski', 4),
(39, 'Lamjung', 4),
(40, 'Manang', 4),
(41, 'Mustang', 4),
(42, 'Myagdi', 4),
(43, 'Nawalpur', 4),
(44, 'Parwat', 4),
(45, 'Syangja', 4),
(46, 'Tanahun', 4),
(47, 'Kapilvastu', 5),
(48, 'Parasi', 5),
(49, 'Rupandehi', 5),
(50, 'Arghakhanchi', 5),
(51, 'Gulmi', 5),
(52, 'Palpa', 5),
(53, 'Dang', 5),
(54, 'Pyuthan', 5),
(55, 'Rolpa', 5),
(56, 'Eastern Rukum', 5),
(57, 'Banke', 5),
(58, 'Bardiya', 5),
(59, 'Western Rukum', 6),
(60, 'Salyan', 6),
(61, 'Dolpa', 6),
(62, 'Humla', 6),
(63, 'Jumla', 6),
(64, 'Kalikot', 6),
(65, 'Mugu', 6),
(66, 'Surkhet', 6),
(67, 'Dailekh', 6),
(68, 'Jajarkot', 6),
(69, 'Darchula', 7),
(70, 'Bajhang', 7),
(71, 'Bajura', 7),
(72, 'Baitadi', 7),
(73, 'Doti', 7),
(74, 'Acham', 7),
(75, 'Dadeldhura', 7),
(76, 'Kanchanpur', 7),
(77, 'Kailali', 7);

-- --------------------------------------------------------

--
-- Table structure for table `job_position`
--

CREATE TABLE `job_position` (
  `job_position_id` int(10) NOT NULL,
  `job_position_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `job_position`
--

INSERT INTO `job_position` (`job_position_id`, `job_position_name`) VALUES
(1, 'Back-end developer'),
(2, 'Front-end developer'),
(3, 'Full-stack developer'),
(4, 'Software engineer'),
(5, 'UI (user interface) designer'),
(6, 'Web developer'),
(7, 'Data analyst'),
(8, 'Database administrator'),
(9, 'Data scientist'),
(10, 'DevOps engineer'),
(11, 'Software developer'),
(13, 'IT Director'),
(17, 'IT Officer'),
(18, 'Database engineer'),
(25, 'QA analyst');

-- --------------------------------------------------------

--
-- Table structure for table `job_post_skill`
--

CREATE TABLE `job_post_skill` (
  `job_id` int(10) NOT NULL,
  `job_position_id` int(11) NOT NULL,
  `language` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `job_post_skill`
--

INSERT INTO `job_post_skill` (`job_id`, `job_position_id`, `language`) VALUES
(9, 1, 'Node Js'),
(9, 1, 'My SQL'),
(9, 1, 'Management'),
(14, 8, 'mysql lite'),
(15, 4, 'Node Js'),
(16, 13, 'JavaScript'),
(17, 4, 'Php'),
(17, 4, 'html'),
(18, 7, 'SQL'),
(64, 6, 'PHP'),
(64, 6, 'PHP'),
(64, 6, 'PHP'),
(65, 10, 'PHP'),
(65, 10, 'PHP'),
(65, 10, 'PHP'),
(26, 18, 'Php'),
(63, 7, 'sql,mongodb'),
(62, 11, 'java'),
(26, 8, 'SQL'),
(67, 9, 'Mongoose'),
(12, 1, 'Js developer'),
(18, 8, 'SQL'),
(60, 13, 'Software engineer'),
(27, 11, 'java');

-- --------------------------------------------------------

--
-- Table structure for table `membership`
--

CREATE TABLE `membership` (
  `membership_id` int(11) NOT NULL,
  `membership_name` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `membership`
--

INSERT INTO `membership` (`membership_id`, `membership_name`) VALUES
(1, 'basic'),
(2, 'premium');

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE `message` (
  `company_id` int(11) NOT NULL,
  `seeker_id` int(11) NOT NULL,
  `text_message` text NOT NULL,
  `sender` char(1) NOT NULL,
  `message_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `message`
--

INSERT INTO `message` (`company_id`, `seeker_id`, `text_message`, `sender`, `message_date`) VALUES
(4, 15, 'hello', '1', '2022-04-16 10:41:54'),
(2, 15, 'hello ronit Rana magar, how can we help you ?', '0', '2022-04-25 11:47:09'),
(2, 15, 'i need an internship', '1', '2022-04-25 11:47:39'),
(2, 15, 'hello', '0', '2022-04-25 11:50:00'),
(2, 15, 'please help me', '1', '2022-04-25 11:50:41');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `pay_amount` varchar(50) NOT NULL,
  `payment_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`payment_id`, `user_id`, `pay_amount`, `payment_date`) VALUES
(7, 28, '10000', '2022-04-12 21:55:16'),
(8, 29, '10000', '2022-04-13 09:39:58'),
(9, 28, '10000', '2022-04-13 21:53:01'),
(10, 28, '10000', '2022-04-13 21:54:48'),
(11, 28, '10000', '2022-04-13 22:49:37'),
(12, 28, '10000', '2022-04-13 22:50:57'),
(13, 28, '10000', '2022-04-13 22:53:34'),
(14, 28, '10000', '2022-04-13 22:56:02'),
(15, 28, '10000', '2022-04-13 22:57:59'),
(16, 28, '10000', '2022-04-13 23:08:12'),
(17, 26, '10000', '2022-04-25 17:24:41');

-- --------------------------------------------------------

--
-- Table structure for table `post_job`
--

CREATE TABLE `post_job` (
  `job_id` int(11) NOT NULL,
  `job_description` text NOT NULL,
  `posted_date` datetime NOT NULL,
  `company_id` int(10) NOT NULL,
  `job_type` varchar(50) NOT NULL,
  `salary` double DEFAULT NULL,
  `expired_date` datetime NOT NULL,
  `experience` varchar(25) NOT NULL,
  `minimum_education` varchar(50) NOT NULL,
  `is_negotiable` varchar(25) NOT NULL,
  `job_title` varchar(100) DEFAULT NULL,
  `job_specification` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `post_job`
--

INSERT INTO `post_job` (`job_id`, `job_description`, `posted_date`, `company_id`, `job_type`, `salary`, `expired_date`, `experience`, `minimum_education`, `is_negotiable`, `job_title`, `job_specification`) VALUES
(9, 'We are looking for a Full Stack Developer to produce scalable software solutions. You’ll be part of a cross-functional team that’s responsible for the full software development life cycle, from conception to deployment.\n\nAs a Full Stack Developer, you should be comfortable around both front-end and back-end coding languages, development frameworks and third-party libraries. You should also be a team player with a knack for visual design and utility.\n\nIf you’re also familiar with Agile methodologies, we’d like to meet you.', '2022-03-07 00:00:00', 4, 'full time', 23000, '2022-06-21 00:00:00', '1', 'BIT', 'yes', 'test title', 'Proven experience as a Full Stack Developer or similar role.Experience developing desktop and mobile applications'),
(12, 'We are looking for a UX Designer to design software and platforms that meet people’s needs. You will combine interfaces and workflows to enhance user experience.\n\nIn this role, you should be an analytical and creative designer who is able to grasp user needs and solve problems. A strong portfolio of successful UX and other technical projects is essential.\n\nUltimately, you will make our product more user-friendly and intuitive to attract and retain customers.', '2022-02-01 00:00:00', 3, 'full time', 33000, '2022-07-26 00:00:00', '5', 'BIT', 'yes', 'n', 'Understand product specifications and user psychology. Conduct concept and usability testing and gather feedback. Proven experience as a UX Designer, UI Designer or similar role'),
(14, 'We are looking for a qualified Database developer to design stable and reliable databases, according to our company’s needs. You will be responsible for developing, testing, improving and maintaining new and existing databases to help users retrieve data effectively.', '2022-02-02 00:00:00', 2, 'internship', 12000, '2022-06-02 00:00:00', '4', 'BIT', 'no', 'xx', 'Design stable, reliable and effective databases. Modify databases according to requests and perform tests.Liaise with developers to improve applications and establish best practices\n.'),
(15, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and ting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and ting industry. ', '2022-02-02 00:00:00', 2, 'part time', 20000, '2022-07-21 00:00:00', '2', 'Bcs IT', 'yes', 'somthing', 'something'),
(16, 'We are looking for an experienced IT Director to oversee all IT (Information Technology) functions in our company. You will be in charge of a team of IT managers and manage the company’s technology operations and the implementation of new IT systems and policies.\n\nAn excellent IT director is very knowledgeable in IT and computer systems. They have a solid technical background while able to manage and motivate people. The ideal candidate will be experienced in creating and implementing IT policies and systems that will meet objectives.', '2022-03-24 00:00:00', 5, 'Full Time', 300000, '2022-12-01 00:00:00', '3', 'BIT', 'no', 'enginner', 'Devise and establish IT policies and systems to support the implementation of strategies set by upper management.Coordinate IT managers and supervise computer scientists, technicians and other professionals to provide guidance.'),
(17, 'We are looking for a passionate Software Engineer to design, develop and install software solutions.\n\nSoftware Engineer responsibilities include gathering user requirements, defining system functionality and writing code in various languages, like Java, Ruby on Rails or .NET programming languages (e.g. C++ or JScript.NET.) Our ideal candidates are familiar with the software development life cycle (SDLC) from preliminary system analysis to tests and deployment.', '2022-03-03 00:00:00', 3, 'Remote', 25000, '2022-09-03 00:00:00', '4', 'BE', 'no', 'scientist', 'Integrate software components into a fully functional software system.Develop software verification plans and quality assurance procedures.'),
(18, 'We are looking for a passionate certified Data Analyst. The successful candidate will turn data into information, information into insight and insight into business decisions.', '2022-04-12 00:00:00', 3, 'full time', 12000, '2022-05-15 00:00:00', '3', 'BIT', 'yes', 'xxx', 'Data analyst responsibilities include conducting full lifecycle analysis to include requirements, activities and design. Data analysts will develop analysis and reporting capabilities. They will also monitor performance and quality control plans to identify improvements.'),
(26, 'A professional Database Administrator (DBA) will keep the database up and running smoothly 24/7. The goal is to provide a seamless flow of information throughout the company, considering both backend data structure and frontend accessibility for end-users.', '2022-03-20 00:00:00', 2, 'Internship', 59, '2022-05-25 00:00:00', '12', 'gg', 'true', 'hh', 'A Database Administrator often works with the products of a Data Architect\'s efforts. They take the logical data models created by the Architect and ensure there aren\'t any issues with the models.'),
(27, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and ting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and ting industry. ', '2022-03-15 00:00:00', 2, 'Full Time', 55, '2022-02-11 00:00:00', '5', 'ff', 'false', 'gg', 'yy'),
(60, 'zzzz', '2022-03-24 19:35:23', 2, 'Internship', 55, '2022-09-09 00:00:00', '11', 'BIT', 'false', 'I am job', 'zzzz'),
(61, 'zzzz', '2022-03-24 19:35:59', 2, 'Internship', 55, '2022-02-11 00:00:00', '11', 'BIT', 'false', 'I am job', 'zzzz'),
(62, 'DevOps Engineer responsibilities include deploying product updates, identifying production issues and implementing integrations that meet customer needs. If you have a solid background in software engineering and are familiar with Ruby or Python, we’d like to meet you.\n\nUltimately, you will execute and automate operational processes fast, accurately and securely.', '2022-03-24 19:36:53', 2, 'Internship', 55, '2022-02-21 00:00:00', '11', 'BIT', 'false', 'I am job', 'zzzz'),
(63, 'We are looking for a passionate certified Data Analyst. The successful candidate will turn data into information, information into insight and insight into business decisions.', '2022-03-24 19:38:01', 2, 'Internship', 55, '2022-02-21 00:00:00', '11', 'BIT', 'false', 'I am job', 'A Data Analyst’s responsibilities include the deep analysis of data and then determining the best way to represent it visually to managers and stakeholders. They also ensure quality assurance and process documentation and define Key Performance Indicators (KPIs). Another important duty of a data analyst is to assess and determine the success of specific initiatives.'),
(64, 'We are looking for a skilled Web programmer to join our IT team. You’ll be responsible for designing, coding and improving our company web pages, programs and applications.\n\nAs a Web programmer, you should write clean code to ensure our programs run properly and address our company needs. If you’re passionate about building software and perform well working in a team, along with developers, engineers and web designers, we would like to meet you.', '2022-03-28 08:26:20', 2, 'Part Time', 29000, '2022-07-11 00:00:00', '2', 'BCA', 'false', 'b', 'Produce fully functional programs writing clean, testable code.Collaborate with internal teams to identify system requirements.Design user interface and web layout using HTML/CSS practices.'),
(65, 'We are looking for a DevOps Engineer to help us build functional systems that improve customer experience.\n\nDevOps Engineer responsibilities include deploying product updates, identifying production issues and implementing integrations that meet customer needs. If you have a solid background in software engineering and are familiar with Ruby or Python, we’d like to meet you.', '2022-04-01 08:35:55', 2, 'Internship', 1111, '2022-07-21 00:00:00', '2', 'bit', 'false', 'xx', 'Build tools to reduce occurrences of errors and improve customer experience.Develop software to integrate with internal back-end systems.'),
(67, 'DevOps Engineer responsibilities include deploying product updates, identifying production issues and implementing integrations that meet customer needs. If you have a solid background in software engineering and are familiar with Ruby or Python, we’d like to meet you.\n\nUltimately, you will execute and automate operational processes fast, accurately and securely.', '2022-03-28 08:38:46', 2, 'Internship', 1111, '2022-02-27 00:00:00', '2', 'bit', 'false', 'flutter', 'DevOps Engineer responsibilities include deploying product updates, identifying production issues and implementing integrations that meet customer needs. If you have a solid background in software engineering and are familiar with Ruby or Python, we’d like to meet you.\n\nUltimately, you will execute and automate operational processes fast, accurately and securely.');

-- --------------------------------------------------------

--
-- Table structure for table `seeker`
--

CREATE TABLE `seeker` (
  `seeker_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email_address` varchar(50) NOT NULL,
  `dob` date NOT NULL,
  `highest_qualification` varchar(50) NOT NULL,
  `user_id` int(10) NOT NULL,
  `image_path` varchar(100) NOT NULL,
  `cv` varchar(50) NOT NULL,
  `district_id` int(10) NOT NULL,
  `work_experience` int(10) NOT NULL,
  `bio` text NOT NULL,
  `contact_no` varchar(50) NOT NULL,
  `job_position` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `seeker`
--

INSERT INTO `seeker` (`seeker_id`, `first_name`, `last_name`, `email_address`, `dob`, `highest_qualification`, `user_id`, `image_path`, `cv`, `district_id`, `work_experience`, `bio`, `contact_no`, `job_position`) VALUES
(6, 'gaurav', 'poudel', 'gauravpaudel2013@gmail.com', '2001-10-27', 'BCA', 26, 'cv/hari.jpg', 'cv/1648561923710logsheet8.pdf', 38, 4, 'iam human', '061233', 'senior dev'),
(15, 'ronit', 'magar', 'therealrow123@gmail.com', '2022-03-31', 'Software engineer', 30, 'cv/prassad.jpg', 'cv/ronit.pdf', 12, 1, 'i love coding..very focus on my goals.', '9816116738', 'Flutter developer'),
(16, 'roshan', 'adhikari', 'roshan123@gmail.com', '2022-04-05', 'BSC', 32, 'cv/1648634234683image_picker2047438775400896453.jpg', 'cv/1648634234699sample.pdf', 74, 5, 'i work for professionals', '98000001', 'java developer');

-- --------------------------------------------------------

--
-- Table structure for table `seeker_skill`
--

CREATE TABLE `seeker_skill` (
  `seeker_id` int(10) NOT NULL,
  `job_position_id` int(10) NOT NULL,
  `language` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `seeker_skill`
--

INSERT INTO `seeker_skill` (`seeker_id`, `job_position_id`, `language`) VALUES
(6, 1, 'php'),
(6, 1, 'node'),
(6, 1, 'js'),
(15, 8, 'aa');

-- --------------------------------------------------------

--
-- Table structure for table `state`
--

CREATE TABLE `state` (
  `state_id` int(10) NOT NULL,
  `state_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `state`
--

INSERT INTO `state` (`state_id`, `state_name`) VALUES
(1, 'Province No. 1'),
(2, 'Province No. 2'),
(3, 'Bagmati Province'),
(4, 'Gandaki Province'),
(5, 'Lumbini Province'),
(6, 'Karnali Province'),
(7, 'Sudurpaschim Province');

-- --------------------------------------------------------

--
-- Table structure for table `title_role`
--

CREATE TABLE `title_role` (
  `titile_role_id` int(11) NOT NULL,
  `role_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `title_role`
--

INSERT INTO `title_role` (`titile_role_id`, `role_name`) VALUES
(1, 'Company'),
(2, 'Seeker');

-- --------------------------------------------------------

--
-- Table structure for table `type`
--

CREATE TABLE `type` (
  `type_id` int(10) NOT NULL,
  `type_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `type`
--

INSERT INTO `type` (`type_id`, `type_name`) VALUES
(1, 'google'),
(2, 'email');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `email_address` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `role` int(11) DEFAULT NULL,
  `verification_status` varchar(25) NOT NULL,
  `type` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `user_name`, `email_address`, `password`, `role`, `verification_status`, `type`) VALUES
(26, 'Gaurav Paudel', 'gauravpaudel2013@gmail.com', '$2b$10$/BjUYbooHX7SRU4txVqLBeVLebCUjdLFjmR76eRBhFKDWeF81c5D.', 1, 'true', 1),
(27, 'iam', 'gauravpoudel2022@gmail.com', '$2b$10$bgR42tdtYEoSaymwstiH3O/85LIjLj.O7c05q61M73iT55EPkROFK', 1, 'false', 2),
(28, 'khalti_user', 'facebook@gmail.com', '$2b$10$/BjUYbooHX7SRU4txVqLBeVLebCUjdLFjmR76eRBhFKDWeF81c5D.', 1, 'true', 2),
(29, 'we_insta', 'insta@gmail.com', '$2b$10$bgR42tdtYEoSaymwstiH3O/85LIjLj.O7c05q61M73iT55EPkROFK', 1, 'true', 2),
(30, 'ronit', 'therealrow123@gmail.com', '$2b$10$/BjUYbooHX7SRU4txVqLBeVLebCUjdLFjmR76eRBhFKDWeF81c5D.', 2, 'false', 2),
(32, 'test_user', 'gauravpoudel2020@gmail.com', '$2b$10$/BjUYbooHX7SRU4txVqLBeVLebCUjdLFjmR76eRBhFKDWeF81c5D.', 2, 'true', 2),
(33, 'ICP', 'gaurav.poudel.a19@gmail.com', '$2b$10$C1mtSwwQVcLLCcJpyEa1au5.cf9WL.unbd5ZMdcefpuK2oAlXXW6q', 1, 'true', 2);

-- --------------------------------------------------------

--
-- Table structure for table `user_membership`
--

CREATE TABLE `user_membership` (
  `user_membership_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `membership_id` int(11) NOT NULL,
  `registered_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_membership`
--

INSERT INTO `user_membership` (`user_membership_id`, `user_id`, `membership_id`, `registered_date`) VALUES
(1, 26, 2, '2022-04-25 17:24:41'),
(5, 27, 1, '2022-04-10 11:25:30'),
(6, 29, 2, '2022-04-10 11:25:30'),
(7, 28, 2, '2022-04-13 23:08:12');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `applied_job`
--
ALTER TABLE `applied_job`
  ADD KEY `seeker_id` (`seeker_id`),
  ADD KEY `job_id` (`job_id`);

--
-- Indexes for table `bookmark`
--
ALTER TABLE `bookmark`
  ADD KEY `job_id` (`job_id`),
  ADD KEY `seeker_id` (`seeker_id`);

--
-- Indexes for table `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`comapny_id`),
  ADD KEY `district_id` (`district_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `district`
--
ALTER TABLE `district`
  ADD PRIMARY KEY (`district_id`),
  ADD KEY `state_id` (`state_id`);

--
-- Indexes for table `job_position`
--
ALTER TABLE `job_position`
  ADD PRIMARY KEY (`job_position_id`);

--
-- Indexes for table `job_post_skill`
--
ALTER TABLE `job_post_skill`
  ADD KEY `job_post_skill_ibfk_2` (`job_position_id`),
  ADD KEY `job_post_skill_ibfk_1` (`job_id`);

--
-- Indexes for table `membership`
--
ALTER TABLE `membership`
  ADD PRIMARY KEY (`membership_id`);

--
-- Indexes for table `message`
--
ALTER TABLE `message`
  ADD KEY `company_id` (`company_id`),
  ADD KEY `seeker_id` (`seeker_id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `post_job`
--
ALTER TABLE `post_job`
  ADD PRIMARY KEY (`job_id`),
  ADD KEY `company_id` (`company_id`);

--
-- Indexes for table `seeker`
--
ALTER TABLE `seeker`
  ADD PRIMARY KEY (`seeker_id`),
  ADD KEY `district_id` (`district_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `seeker_skill`
--
ALTER TABLE `seeker_skill`
  ADD KEY `job_position_id` (`job_position_id`),
  ADD KEY `seeker_id` (`seeker_id`);

--
-- Indexes for table `state`
--
ALTER TABLE `state`
  ADD PRIMARY KEY (`state_id`);

--
-- Indexes for table `title_role`
--
ALTER TABLE `title_role`
  ADD PRIMARY KEY (`titile_role_id`);

--
-- Indexes for table `type`
--
ALTER TABLE `type`
  ADD PRIMARY KEY (`type_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email_address` (`email_address`),
  ADD KEY `role` (`role`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `user_membership`
--
ALTER TABLE `user_membership`
  ADD PRIMARY KEY (`user_membership_id`),
  ADD KEY `membership_id` (`membership_id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `company`
--
ALTER TABLE `company`
  MODIFY `comapny_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `job_position`
--
ALTER TABLE `job_position`
  MODIFY `job_position_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `membership`
--
ALTER TABLE `membership`
  MODIFY `membership_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `post_job`
--
ALTER TABLE `post_job`
  MODIFY `job_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `seeker`
--
ALTER TABLE `seeker`
  MODIFY `seeker_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `state`
--
ALTER TABLE `state`
  MODIFY `state_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `title_role`
--
ALTER TABLE `title_role`
  MODIFY `titile_role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `user_membership`
--
ALTER TABLE `user_membership`
  MODIFY `user_membership_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `applied_job`
--
ALTER TABLE `applied_job`
  ADD CONSTRAINT `applied_job_ibfk_1` FOREIGN KEY (`seeker_id`) REFERENCES `seeker` (`seeker_id`),
  ADD CONSTRAINT `applied_job_ibfk_2` FOREIGN KEY (`job_id`) REFERENCES `post_job` (`job_id`);

--
-- Constraints for table `bookmark`
--
ALTER TABLE `bookmark`
  ADD CONSTRAINT `bookmark_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `post_job` (`job_id`),
  ADD CONSTRAINT `bookmark_ibfk_2` FOREIGN KEY (`seeker_id`) REFERENCES `seeker` (`seeker_id`);

--
-- Constraints for table `company`
--
ALTER TABLE `company`
  ADD CONSTRAINT `company_ibfk_1` FOREIGN KEY (`district_id`) REFERENCES `district` (`district_id`),
  ADD CONSTRAINT `company_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `district`
--
ALTER TABLE `district`
  ADD CONSTRAINT `district_ibfk_1` FOREIGN KEY (`state_id`) REFERENCES `state` (`state_id`);

--
-- Constraints for table `job_post_skill`
--
ALTER TABLE `job_post_skill`
  ADD CONSTRAINT `job_post_skill_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `post_job` (`job_id`),
  ADD CONSTRAINT `job_post_skill_ibfk_2` FOREIGN KEY (`job_position_id`) REFERENCES `job_position` (`job_position_id`);

--
-- Constraints for table `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `message_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `company` (`comapny_id`),
  ADD CONSTRAINT `message_ibfk_2` FOREIGN KEY (`seeker_id`) REFERENCES `seeker` (`seeker_id`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `post_job`
--
ALTER TABLE `post_job`
  ADD CONSTRAINT `post_job_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `company` (`comapny_id`);

--
-- Constraints for table `seeker`
--
ALTER TABLE `seeker`
  ADD CONSTRAINT `seeker_ibfk_1` FOREIGN KEY (`district_id`) REFERENCES `district` (`district_id`),
  ADD CONSTRAINT `seeker_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `seeker_skill`
--
ALTER TABLE `seeker_skill`
  ADD CONSTRAINT `seeker_skill_ibfk_1` FOREIGN KEY (`job_position_id`) REFERENCES `job_position` (`job_position_id`),
  ADD CONSTRAINT `seeker_skill_ibfk_2` FOREIGN KEY (`seeker_id`) REFERENCES `seeker` (`seeker_id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role`) REFERENCES `title_role` (`titile_role_id`),
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`type`) REFERENCES `type` (`type_id`);

--
-- Constraints for table `user_membership`
--
ALTER TABLE `user_membership`
  ADD CONSTRAINT `user_membership_ibfk_1` FOREIGN KEY (`membership_id`) REFERENCES `membership` (`membership_id`),
  ADD CONSTRAINT `user_membership_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
