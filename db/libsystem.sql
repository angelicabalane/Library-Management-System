-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Dec 08, 2023 at 09:38 PM
-- Server version: 10.1.19-MariaDB
-- PHP Version: 5.5.38

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteBook` (INOUT `id` INT(25))  NO SQL
DELETE FROM books WHERE books.id=id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBookList` ()  NO SQL
SELECT books.title, books.author, books.isbn, category.name
FROM books INNER JOIN category ON books.category_id = category.id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertNewBook` (IN `isbn` VARCHAR(20), IN `category_id` INT(11), IN `title` TEXT, IN `author` VARCHAR(150), IN `publisher` VARCHAR(150), IN `publisher_date` DATE, IN `status` INT(1))  NO SQL
INSERT INTO books (id, isbn, category_id, title, author, publisher, publish_date, status) VALUES (null, isbn, category_id, title, author, publisher, publish_date, status)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateBookTitle` (INOUT `id` INT(25), INOUT `title` VARCHAR(100))  NO SQL
UPDATE books SET title=title WHERE books.id=id$$

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
(3, '9781612681122', 3, 'Rich Dad, Poor Dad', 'Robert Kiyosaki', 'Plata Publishing, LLC.', '2022-04-05', 0),
(4, '9781779501127', 5, 'Watchmer', 'Alan Moore', 'DC Comics', '2019-05-20', 0),
(5, '9780316556347', 7, 'Circe', 'Madeline Miller', 'Little, Brown and Company', '2018-04-10', 0),
(6, '9780140275360', 1, 'The Iliad Homer', 'Homer', 'Penguin Publishing Group', '1998-11-01', 0),
(7, '9789655753011', 9, 'The Boy from Block 66', 'Limor Regev', 'Valcal Software Ltd', '2022-12-19', 0),
(8, '9798835444670', 10, 'The Intimate', 'Freida McFadden', 'Poisoned Pen Press', '2022-06-11', 0),
(9, '9781478927662', 14, 'Michael Jordan: The Life', 'Roland Lazenby', 'Little, Brown & Company', '2014-05-27', 0),
(10, '9780593420256', 15, 'New York City', 'Pico Iyer ', 'Riverhead Books', '2023-01-10', 0),
(11, '9780300203318', 8, 'Yves Saint Laurent', 'Pierre Berge', 'Metropolitan Museum of Art ', '2013-09-10', 1),
(12, '9781786850249', 4, 'Never Stop Dreaming', 'Ellen Mills', 'Summersdale', '2018-06-01', 0),
(13, '9781400052189', 2, 'The Immortal Life of Henrietta Lacks\n', 'Rebecca Skloot', 'Crown Publishers', '2011-03-08', 0),
(14, '9780525428145', 11, 'The Laws of Human', 'Robert Greene', 'Viking', '2018-10-23', 0),
(15, '9780593536407', 6, 'The Dictionary People', 'Sarah Ogilvia', 'Knopf', '2023-10-17', 0),
(17, '9781603095273', 5, 'But You Have Friends', 'Emilia McKenzie', 'Top Shelf Productions', '0000-00-00', 0);

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
  `update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `book_audit`
--

INSERT INTO `book_audit` (`id`, `isbn`, `title`, `author`, `publisher`, `action`, `update`) VALUES
(16, '9780140707342', 'Hamlet', 'William Shakespeare', 'Simon and Schuster', 'DELETE', '2023-12-08 20:21:40'),
(17, '9781603095273', 'But You Have Friends', 'Emilia McKenzie', 'Top Shelf Productions', 'INSERT', '2023-12-08 20:35:24'),
(17, '9781603095273', 'But You Have Friends', 'Emilia McKenzie', 'Top Shelf Productions', 'UPDATE', '2023-12-08 20:38:04');

-- --------------------------------------------------------

--
-- Stand-in structure for view `book_view`
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
(20, 1, 11, '2023-12-09', 0);

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
  `update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `borrow_audit`
--

INSERT INTO `borrow_audit` (`id`, `student_id`, `book_id`, `date_borrow`, `action`, `update`) VALUES
(20, 1, 11, '2023-12-09', 'INSERT', '2023-12-08 18:19:51'),
(19, 1, 2, '2023-12-09', 'UPDATE', '2023-12-08 18:20:32');

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
(8, 'Fashion'),
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
(4, 'Bachelor of Science in Entertainment and Multimedia Computing', 'BSEMC');

-- --------------------------------------------------------

--
-- Stand-in structure for view `library_summary_view`
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
(5, 1, 2, '2023-12-09');

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
  `update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `returns_audit`
--

INSERT INTO `returns_audit` (`id`, `student_id`, `book_id`, `date_return`, `action`, `update`) VALUES
(5, 1, 2, '2023-12-09', 'INSERT', '2023-12-08 18:20:32');

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
(1, 'QKZ473591628', 'Marinela Joy', 'Ibay', '', 1, '2023-12-09'),
(2, 'OSY659073421', 'Daisy', 'Pajares', '', 1, '2023-12-09'),
(3, 'RNT501962748', 'Jurilaine Anne', 'Pacamara', '', 1, '2023-12-09'),
(4, 'LAT261539840', 'Aubrey Kate', 'Quinonez', '', 1, '2023-12-09');

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
  `update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `students_audit`
--

INSERT INTO `students_audit` (`id`, `student_id`, `firstname`, `lastname`, `action`, `update`) VALUES
(2, 0, 'Daisy', 'Pajares', 'INSERT', '2023-12-08 18:21:59'),
(3, 0, 'Jurilaine Anne', 'Pacamara', 'INSERT', '2023-12-08 18:31:38'),
(4, 0, 'Aubrey Kate', 'Quinonez', 'INSERT', '2023-12-08 18:32:41');

-- --------------------------------------------------------

--
-- Stand-in structure for view `student_view`
--
CREATE TABLE `student_view` (
`TOTAL_STUDENTS` bigint(21)
);

-- --------------------------------------------------------

--
-- Structure for view `book_view`
--
DROP TABLE IF EXISTS `book_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `book_view`  AS  select count(`books`.`id`) AS `TOTAL_BOOKS` from `books` ;

-- --------------------------------------------------------

--
-- Structure for view `library_summary_view`
--
DROP TABLE IF EXISTS `library_summary_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `library_summary_view`  AS  select `books`.`isbn` AS `isbn`,`books`.`title` AS `title`,`books`.`author` AS `author`,`books`.`publisher` AS `publisher`,`category`.`name` AS `name` from (`books` join `category` on((`books`.`category_id` = `category`.`id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `student_view`
--
DROP TABLE IF EXISTS `student_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `student_view`  AS  select count(`students`.`id`) AS `TOTAL_STUDENTS` from `students` ;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `borrow`
--
ALTER TABLE `borrow`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `course`
--
ALTER TABLE `course`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `returns`
--
ALTER TABLE `returns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `delete_event` ON SCHEDULE EVERY 1 WEEK STARTS '2023-12-09 02:39:48' ON COMPLETION NOT PRESERVE ENABLE DO DELETE FROM returns WHERE date_return < CURDATE() - INTERVAL 30 DAY$$

DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
