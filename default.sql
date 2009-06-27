-- phpMyAdmin SQL Dump
-- version 3.1.2deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 14, 2009 at 04:23 AM
-- Server version: 5.0.75
-- PHP Version: 5.2.6-3ubuntu4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `job_queue`
--

-- --------------------------------------------------------

--
-- Table structure for table `codes`
--

CREATE TABLE IF NOT EXISTS `codes` (
  `index` int(11) NOT NULL COMMENT 'index for this table',
  `filename` varchar(255) NOT NULL COMMENT 'filename of the source code file',
  `fileLocation` varchar(512) NOT NULL COMMENT 'filename on the web server',
  `compileCommand` varchar(1024) NOT NULL COMMENT 'command to compile this code',
  `lastUpdate` date NOT NULL COMMENT 'last time it was updated',
  `exeName` varchar(255) NOT NULL COMMENT 'filename of the executable produced',
  PRIMARY KEY  (`index`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='stores codes to run on the mesh';

-- --------------------------------------------------------

--
-- Table structure for table `queue`
--

CREATE TABLE IF NOT EXISTS `queue` (
  `index` int(11) NOT NULL auto_increment COMMENT 'job index',
  `requiredCodes` varchar(255) NOT NULL COMMENT 'codes we should compile',
  `runCommand` varchar(1024) NOT NULL COMMENT 'command to run the job',
  `outputFile` varchar(255) NOT NULL COMMENT 'file we should output to',
  `status` enum('W','P','D') NOT NULL default 'W' COMMENT 'status of this job',
  `jobKey` varchar(100) NOT NULL COMMENT 'job key for later updates',
  PRIMARY KEY  (`index`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=45700 ;



INSERT INTO `codes` (`index`, `filename`, `fileLocation`, `compileCommand`, `lastUpdate`, `exeName`) VALUES
(0, 'hello.sh', 'http://traviscj.com/job_queue/codes/hello.sh', '', '2009-05-09', 'hello.sh');

INSERT INTO `job_queue`.`queue` (
`index`,`requiredCodes`,`runCommand`,`outputFile`,`status`,`jobKey`)
VALUES (NULL , '0', './hello.sh', 'hello-sh-output', 'W', SHA1( './hello.sh' ));


