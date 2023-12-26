-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 26, 2023 at 07:17 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `libsystem`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteBook` (INOUT `id` INT(25))  NO SQL DELETE FROM books WHERE books.id=id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteBorrower` (IN `id` INT(11))  NO SQL DELETE FROM borrow WHERE borrow.id=id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteCategory` (INOUT `id` INT(11))   DELETE FROM category WHERE category.id=id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteCourse` (IN `id` INT(11))  NO SQL DELETE FROM course WHERE course.id=id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteReturnedBook` (IN `id` INT(11))  NO SQL DELETE FROM returns WHERE returns.id=id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteStudent` (IN `id` INT(11))  NO SQL DELETE FROM students WHERE students.id=id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBookList` ()  NO SQL SELECT books.title, books.author, books.isbn, category.name
FROM books INNER JOIN category ON books.category_id = category.id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertNewBook` (IN `isbn` VARCHAR(20), IN `category_id` INT(11), IN `title` TEXT, IN `author` VARCHAR(150), IN `publisher` VARCHAR(150), IN `publish_date` DATE, IN `status` INT(1))  NO SQL INSERT INTO books (id, isbn, category_id, title, author, publisher, publish_date, status) VALUES (null, isbn, category_id, title, author, publisher, publish_date, status)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertNewCourse` (IN `title` VARCHAR(100), IN `code` VARCHAR(11))   INSERT INTO course (id, title, code) VALUES (null, title, code)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateBookTitle` (INOUT `id` INT(25), INOUT `title` VARCHAR(100))  NO SQL UPDATE books SET title=title WHERE books.id=id$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(60) NOT NULL,
  `firstname` varchar(30) NOT NULL,
  `lastname` varchar(30) NOT NULL,
  `photo` varchar(200) NOT NULL,
  `created_on` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `password`, `firstname`, `lastname`, `photo`, `created_on`) VALUES
(1, 'Angel', '$2y$10$1VmOehdw8EfSiTn.wRR2EOmRviX23G6G/8KrbTRkAatc4dRTBLB2q', 'Angelica', 'Balane', 'angelica.jpg', '2023-12-08');

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `id` int(11) NOT NULL,
  `isbn` varchar(20) NOT NULL,
  `category_id` int(11) NOT NULL,
  `title` text NOT NULL,
  `author` varchar(150) NOT NULL,
  `publisher` varchar(150) NOT NULL,
  `publish_date` date NOT NULL,
  `status` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`id`, `isbn`, `category_id`, `title`, `author`, `publisher`, `publish_date`, `status`) VALUES
(1, '9780553418026', 13, 'The Martian Andy Weir', 'Andy Weir', 'Crown ', '2014-02-11', 0),
(2, '9781250316776', 12, 'Red, White and Royal Blue', 'Casey McQuiston', 'St Martins Griffin', '2021-02-02', 0),
(3, '9781612681122', 3, 'Rich Dad, Poor Dad', 'Robert Kiyosaki', 'Plata Publishing, LLC.', '2022-04-05', 1),
(4, '9781779501127', 5, 'Watchmer', 'Alan Moore', 'DC Comics', '2019-05-20', 0),
(5, '9780316556347', 7, 'Circe', 'Madeline Miller', 'Little, Brown and Company', '2018-04-10', 0),
(7, '9789655753011', 9, 'The Boy from Block 66', 'Limor Regev', 'Valcal Software Ltd', '2022-12-19', 0),
(8, '9798835444670', 10, 'The Intimate', 'Freida McFadden', 'Poisoned Pen Press', '2022-06-11', 0),
(9, '9781478927662', 14, 'Michael Jordan: The Life', 'Roland Lazenby', 'Little, Brown & Company', '2014-05-27', 0),
(10, '9780593420256', 15, 'New York City', 'Pico Iyer ', 'Riverhead Books', '2023-01-10', 1),
(11, '9780300203318', 8, 'Yves Saint Laurent', 'Pierre Berge', 'Metropolitan Museum of Art ', '2013-09-10', 1),
(12, '9781786850249', 4, 'Never Stop Dreaming', 'Ellen Mills', 'Summersdale', '2018-06-01', 0),
(13, '9781400052189', 2, 'The Immortal Life of Henrietta Lacks\n', 'Rebecca Skloot', 'Crown Publishers', '2011-03-08', 0),
(14, '9780525428145', 11, 'The Laws of Human', 'Robert Greene', 'Viking', '2018-10-23', 1),
(15, '9780593536407', 6, 'The Dictionary People', 'Sarah Ogilvia', 'Knopf', '2023-10-17', 0),
(18, '9780439023481', 7, 'The Hunger Games', 'Suzanne Collins', 'Scholastic', '2008-09-14', 0),
(19, '9780545069670', 0, '0', 'J.K. Rowling', 'Scholastic Corporation', '1997-06-26', 0);

--
-- Triggers `books`
--
DELIMITER $$
CREATE TRIGGER `book_after_insert` AFTER INSERT ON `books` FOR EACH ROW INSERT INTO book_audit (id, isbn,title,author,publisher, ACTION) VALUES (NEW.id, NEW.isbn, NEW.title, NEW.author,NEW.publisher, 'INSERT')
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `book_after_update` AFTER UPDATE ON `books` FOR EACH ROW INSERT INTO book_audit (id, isbn,title,author,publisher, ACTION) VALUES (OLD.id, OLD.isbn, OLD.title, OLD.author,OLD.publisher, 'UPDATE')
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `book_before_delete` BEFORE DELETE ON `books` FOR EACH ROW INSERT INTO book_audit (id, isbn,title,author,publisher, ACTION) VALUES (OLD.id, OLD.isbn, OLD.title, OLD.author,OLD.publisher, 'DELETE')
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `book_audit`
--

CREATE TABLE `book_audit` (
  `id` int(11) NOT NULL,
  `isbn` varchar(20) NOT NULL,
  `title` varchar(100) NOT NULL,
  `author` varchar(100) NOT NULL,
  `publisher` varchar(100) NOT NULL,
  `action` varchar(10) NOT NULL,
  `update` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `book_audit`
--

INSERT INTO `book_audit` (`id`, `isbn`, `title`, `author`, `publisher`, `action`, `update`) VALUES
(16, '9780140707342', 'Hamlet', 'William Shakespeare', 'Simon and Schuster', 'DELETE', '2023-12-08 20:21:40'),
(17, '9781603095273', 'But You Have Friends', 'Emilia McKenzie', 'Top Shelf Productions', 'INSERT', '2023-12-08 20:35:24'),
(17, '9781603095273', 'But You Have Friends', 'Emilia McKenzie', 'Top Shelf Productions', 'UPDATE', '2023-12-08 20:38:04'),
(14, '9780525428145', 'The Laws of Human', 'Robert Greene', 'Viking', 'UPDATE', '2023-12-10 06:10:50'),
(17, '9781603095273', 'But You Have Friends', 'Emilia McKenzie', 'Top Shelf Productions', 'DELETE', '2023-12-10 06:12:52'),
(10, '9780593420256', 'New York City', 'Pico Iyer ', 'Riverhead Books', 'UPDATE', '2023-12-10 06:19:39'),
(10, '9780593420256', 'New York City', 'Pico Iyer ', 'Riverhead Books', 'UPDATE', '2023-12-10 06:21:02'),
(13, '9781400052189', 'The Immortal Life of Henrietta Lacks\n', 'Rebecca Skloot', 'Crown Publishers', 'UPDATE', '2023-12-10 06:23:42'),
(13, '9781400052189', 'The Immortal Life of Henrietta Lacks\n', 'Rebecca Skloot', 'Crown Publishers', 'UPDATE', '2023-12-10 06:24:10'),
(10, '9780593420256', 'New York City', 'Pico Iyer ', 'Riverhead Books', 'UPDATE', '2023-12-10 06:37:35'),
(5, '9780316556347', 'Circe', 'Madeline Miller', 'Little, Brown and Company', 'UPDATE', '2023-12-10 06:38:53'),
(5, '9780316556347', 'Circe', 'Madeline Miller', 'Little, Brown and Company', 'UPDATE', '2023-12-10 06:39:36'),
(4, '9781779501127', 'Watchmer', 'Alan Moore', 'DC Comics', 'UPDATE', '2023-12-10 07:19:44'),
(4, '9781779501127', 'Watchmer', 'Alan Moore', 'DC Comics', 'UPDATE', '2023-12-10 07:20:59'),
(3, '9781612681122', 'Rich Dad, Poor Dad', 'Robert Kiyosaki', 'Plata Publishing, LLC.', 'UPDATE', '2023-12-10 08:31:42'),
(6, '9780140275360', 'The Iliad Homer', 'Homer', 'Penguin Publishing Group', 'DELETE', '2023-12-15 09:09:25'),
(18, '9780439023481', '0', 'Suzanne Collins', 'Scholastic', 'INSERT', '2023-12-15 13:21:30'),
(18, '9780439023481', '0', 'Suzanne Collins', 'Scholastic', 'UPDATE', '2023-12-15 13:21:58'),
(19, '9780545069670', '0', 'J.K. Rowling', 'Scholastic Corporation', 'INSERT', '2023-12-16 16:55:05');

-- --------------------------------------------------------

--
-- Stand-in structure for view `book_view`
-- (See below for the actual view)
--
CREATE TABLE `book_view` (
`TOTAL_BOOKS` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `borrow`
--

CREATE TABLE `borrow` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `date_borrow` date NOT NULL,
  `status` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `borrow`
--

INSERT INTO `borrow` (`id`, `student_id`, `book_id`, `date_borrow`, `status`) VALUES
(19, 1, 2, '2023-12-09', 1),
(20, 1, 11, '2023-12-09', 0),
(21, 1, 14, '2023-12-10', 0),
(22, 4, 10, '2023-12-10', 1),
(23, 3, 13, '2023-12-10', 1),
(24, 4, 10, '2023-12-10', 0),
(25, 4, 5, '2023-12-10', 1),
(26, 4, 4, '2023-12-10', 1),
(27, 1, 3, '2023-12-10', 0);

--
-- Triggers `borrow`
--
DELIMITER $$
CREATE TRIGGER `borrow_after_insert` AFTER INSERT ON `borrow` FOR EACH ROW INSERT INTO borrow_audit (id,student_id, book_id,date_borrow, ACTION) VALUES (NEW.id, NEW.student_id, NEW.book_id, NEW.date_borrow,'INSERT')
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `borrow_after_update` AFTER UPDATE ON `borrow` FOR EACH ROW INSERT INTO borrow_audit (id,student_id, book_id,date_borrow, ACTION) VALUES (OLD.id, OLD.student_id, OLD.book_id, OLD.date_borrow,'UPDATE')
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `borrow_before_delete` BEFORE DELETE ON `borrow` FOR EACH ROW INSERT INTO borrow_audit (id,student_id, book_id,date_borrow, ACTION) VALUES (OLD.id, OLD.student_id, OLD.book_id, OLD.date_borrow,'DELETE')
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `borrow_audit`
--

CREATE TABLE `borrow_audit` (
  `id` int(100) NOT NULL,
  `student_id` int(100) NOT NULL,
  `book_id` int(100) NOT NULL,
  `date_borrow` date NOT NULL,
  `action` varchar(10) NOT NULL,
  `update` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `borrow_audit`
--

INSERT INTO `borrow_audit` (`id`, `student_id`, `book_id`, `date_borrow`, `action`, `update`) VALUES
(20, 1, 11, '2023-12-09', 'INSERT', '2023-12-08 18:19:51'),
(19, 1, 2, '2023-12-09', 'UPDATE', '2023-12-08 18:20:32'),
(21, 1, 14, '2023-12-10', 'INSERT', '2023-12-10 06:10:50'),
(22, 4, 10, '2023-12-10', 'INSERT', '2023-12-10 06:19:39'),
(22, 4, 10, '2023-12-10', 'UPDATE', '2023-12-10 06:21:02'),
(23, 3, 13, '2023-12-10', 'INSERT', '2023-12-10 06:23:42'),
(23, 3, 13, '2023-12-10', 'UPDATE', '2023-12-10 06:24:10'),
(24, 4, 10, '2023-12-10', 'INSERT', '2023-12-10 06:37:35'),
(25, 4, 5, '2023-12-10', 'INSERT', '2023-12-10 06:38:53'),
(25, 4, 5, '2023-12-10', 'UPDATE', '2023-12-10 06:39:36'),
(26, 4, 4, '2023-12-10', 'INSERT', '2023-12-10 07:19:44'),
(26, 4, 4, '2023-12-10', 'UPDATE', '2023-12-10 07:20:59'),
(27, 1, 3, '2023-12-10', 'INSERT', '2023-12-10 08:31:42');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`) VALUES
(1, 'Art History'),
(2, 'Biography'),
(3, 'Business'),
(4, 'Children'),
(5, 'Comic'),
(6, 'Dictionary'),
(7, 'Fantasy'),
(9, 'History'),
(10, 'Horror'),
(11, 'Political'),
(12, 'Romance'),
(13, 'Sci-Fi'),
(14, 'Sports'),
(15, 'Travel'),
(16, 'Tragedy');

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `code` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`id`, `title`, `code`) VALUES
(1, 'Bachelor of Science in Information Systems', 'BSIS'),
(2, 'Bachelor of Science in Computer Science', 'BSCS'),
(3, 'Bachelor of Science in Information System', 'BSIT'),
(4, 'Bachelor of Science in Entertainment and Multimedia Computing', 'BSEMC'),
(6, 'Bachelor of Science in Computer Engineering', 'BSCpE');

-- --------------------------------------------------------

--
-- Stand-in structure for view `dashboard_view`
-- (See below for the actual view)
--
CREATE TABLE `dashboard_view` (
`student_id` varchar(15)
,`firstname` varchar(50)
,`lastname` varchar(50)
,`date_borrow` date
,`date_return` date
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `library_summary_view`
-- (See below for the actual view)
--
CREATE TABLE `library_summary_view` (
`isbn` varchar(20)
,`title` text
,`author` varchar(150)
,`publisher` varchar(150)
,`name` varchar(100)
);

-- --------------------------------------------------------

--
-- Table structure for table `returns`
--

CREATE TABLE `returns` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `date_return` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `returns`
--

INSERT INTO `returns` (`id`, `student_id`, `book_id`, `date_return`) VALUES
(5, 1, 2, '2023-12-09'),
(6, 4, 10, '2023-12-10'),
(7, 3, 13, '2023-12-10'),
(8, 4, 5, '2023-12-10'),
(9, 4, 4, '2023-12-10');

--
-- Triggers `returns`
--
DELIMITER $$
CREATE TRIGGER `return_after_insert` AFTER INSERT ON `returns` FOR EACH ROW INSERT INTO returns_audit (id,student_id, book_id,date_return, ACTION) VALUES (NEW.id, NEW.student_id, NEW.book_id, NEW.date_return,'INSERT')
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `return_after_update` AFTER UPDATE ON `returns` FOR EACH ROW INSERT INTO returns_audit (id,student_id, book_id,date_return, ACTION) VALUES (OLD.id, OLD.student_id, OLD.book_id, OLD.date_return,'UPDATE')
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `return_before_delete` BEFORE DELETE ON `returns` FOR EACH ROW INSERT INTO returns_audit (id,student_id, book_id,date_return, ACTION) VALUES (OLD.id, OLD.student_id, OLD.book_id, OLD.date_return,'DELETE')
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `returns_audit`
--

CREATE TABLE `returns_audit` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `book_id` int(100) NOT NULL,
  `date_return` date NOT NULL,
  `action` varchar(10) NOT NULL,
  `update` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `returns_audit`
--

INSERT INTO `returns_audit` (`id`, `student_id`, `book_id`, `date_return`, `action`, `update`) VALUES
(5, 1, 2, '2023-12-09', 'INSERT', '2023-12-08 18:20:32'),
(6, 4, 10, '2023-12-10', 'INSERT', '2023-12-10 06:21:02'),
(7, 3, 13, '2023-12-10', 'INSERT', '2023-12-10 06:24:10'),
(8, 4, 5, '2023-12-10', 'INSERT', '2023-12-10 06:39:36'),
(9, 4, 4, '2023-12-10', 'INSERT', '2023-12-10 07:20:59');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `student_id` varchar(15) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `photo` varchar(200) NOT NULL,
  `course_id` int(11) NOT NULL,
  `created_on` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `student_id`, `firstname`, `lastname`, `photo`, `course_id`, `created_on`) VALUES
(1, 'QKZ473591628', 'Marinela Joy', 'Ibay', 'ID.jpg', 1, '2023-12-09'),
(2, 'OSY659073421', 'Daisy', 'Pajares', 'daisy.jpg', 1, '2023-12-09'),
(3, 'RNT501962748', 'Jurilaine Anne', 'Pacamara', 'jurilaine.jpg', 1, '2023-12-09'),
(4, 'LAT261539840', 'Aubrey Kate', 'Quinonez', 'aubrey.jpeg', 1, '2023-12-09');

--
-- Triggers `students`
--
DELIMITER $$
CREATE TRIGGER `student_after_insert` AFTER INSERT ON `students` FOR EACH ROW INSERT INTO students_audit (id, student_id,firstname,lastname, ACTION) VALUES (NEW.id, NEW.student_id, NEW.firstname, NEW.lastname, 'INSERT')
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `students_after_update` AFTER UPDATE ON `students` FOR EACH ROW INSERT INTO students_audit (id, student_id,firstname,lastname, ACTION) VALUES (OLD.id, OLD.student_id, OLD.firstname, OLD.lastname, 'UPDATE')
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `students_before_delete` BEFORE DELETE ON `students` FOR EACH ROW INSERT INTO students_audit (id, student_id,firstname,lastname, ACTION) VALUES (OLD.id, OLD.student_id, OLD.firstname, OLD.lastname, 'DELETE')
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `students_audit`
--

CREATE TABLE `students_audit` (
  `id` int(50) NOT NULL,
  `student_id` int(15) NOT NULL,
  `firstname` varchar(25) NOT NULL,
  `lastname` varchar(25) NOT NULL,
  `action` varchar(50) NOT NULL,
  `update` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `students_audit`
--

INSERT INTO `students_audit` (`id`, `student_id`, `firstname`, `lastname`, `action`, `update`) VALUES
(2, 0, 'Daisy', 'Pajares', 'INSERT', '2023-12-08 18:21:59'),
(3, 0, 'Jurilaine Anne', 'Pacamara', 'INSERT', '2023-12-08 18:31:38'),
(4, 0, 'Aubrey Kate', 'Quinonez', 'INSERT', '2023-12-08 18:32:41'),
(1, 0, 'Marinela Joy', 'Ibay', 'UPDATE', '2023-12-10 06:27:39'),
(4, 0, 'Aubrey Kate', 'Quinonez', 'UPDATE', '2023-12-10 06:28:28'),
(3, 0, 'Jurilaine Anne', 'Pacamara', 'UPDATE', '2023-12-10 06:29:01'),
(2, 0, 'Daisy', 'Pajares', 'UPDATE', '2023-12-10 06:29:17'),
(5, 0, 'Mary Joy', 'Bonganay', 'INSERT', '2023-12-15 16:01:06'),
(5, 0, 'Mary Joy', 'Bonganay', 'DELETE', '2023-12-15 16:01:11');

-- --------------------------------------------------------

--
-- Stand-in structure for view `student_view`
-- (See below for the actual view)
--
CREATE TABLE `student_view` (
`TOTAL_STUDENTS` bigint(21)
);

-- --------------------------------------------------------

--
-- Structure for view `book_view`
--
DROP TABLE IF EXISTS `book_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `book_view`  AS SELECT count(`books`.`id`) AS `TOTAL_BOOKS` FROM `books``books`  ;

-- --------------------------------------------------------

--
-- Structure for view `dashboard_view`
--
DROP TABLE IF EXISTS `dashboard_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `dashboard_view`  AS SELECT `students`.`student_id` AS `student_id`, `students`.`firstname` AS `firstname`, `students`.`lastname` AS `lastname`, `borrow`.`date_borrow` AS `date_borrow`, `returns`.`date_return` AS `date_return` FROM ((`students` join `borrow` on(`borrow`.`student_id` = `students`.`id`)) join `returns` on(`returns`.`student_id` = `students`.`id`))  ;

-- --------------------------------------------------------

--
-- Structure for view `library_summary_view`
--
DROP TABLE IF EXISTS `library_summary_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `library_summary_view`  AS SELECT `books`.`isbn` AS `isbn`, `books`.`title` AS `title`, `books`.`author` AS `author`, `books`.`publisher` AS `publisher`, `category`.`name` AS `name` FROM (`books` join `category` on(`books`.`category_id` = `category`.`id`))  ;

-- --------------------------------------------------------

--
-- Structure for view `student_view`
--
DROP TABLE IF EXISTS `student_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `student_view`  AS SELECT count(`students`.`id`) AS `TOTAL_STUDENTS` FROM `students``students`  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `borrow`
--
ALTER TABLE `borrow`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `returns`
--
ALTER TABLE `returns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `borrow`
--
ALTER TABLE `borrow`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `course`
--
ALTER TABLE `course`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `returns`
--
ALTER TABLE `returns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `delete_event` ON SCHEDULE EVERY 1 WEEK STARTS '2023-12-09 02:39:48' ON COMPLETION NOT PRESERVE ENABLE DO DELETE FROM returns WHERE date_return < CURDATE() - INTERVAL 30 DAY$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
