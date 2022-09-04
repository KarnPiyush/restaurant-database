-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 01, 2022 at 12:33 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `newrestaurant`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking_table`
--

CREATE TABLE `booking_table` (
  `ID` bigint(20) NOT NULL,
  `TABLE ID` bigint(20) NOT NULL COMMENT 'unique table id',
  `USER ID` bigint(20) NOT NULL COMMENT 'unique user id',
  `TOKEN` varchar(15) NOT NULL COMMENT 'token for table',
  `STATUS` smallint(6) NOT NULL DEFAULT 0 COMMENT 'table status',
  `CREATED AT` datetime NOT NULL COMMENT 'time when table was created',
  `UPDATED AT` datetime DEFAULT NULL COMMENT 'time when table was updated',
  `CONTENT` text DEFAULT NULL COMMENT 'additional info about table booking'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `ID` bigint(20) NOT NULL COMMENT 'UNIQUE ID TO IDENTIFY BOOKING',
  `BOOKING ID` bigint(20) NOT NULL COMMENT 'ASSOCIATED BOOKING ID',
  `USER ID` bigint(20) NOT NULL COMMENT 'associated user id',
  `FOOD ID` bigint(20) NOT NULL COMMENT 'FOOD ITEM ADDED TO CART',
  `SKU` varchar(100) NOT NULL COMMENT 'STCOK KEEPING UNIT',
  `PRICE` float DEFAULT NULL COMMENT 'ITEM SELLING PRICE',
  `DISCOUNT` float DEFAULT NULL COMMENT 'DISCOUNT ON ITEM',
  `QUANTITY ADDED` float DEFAULT NULL,
  `CREATED AT` datetime NOT NULL,
  `UPDATED AT` datetime DEFAULT NULL,
  `CONTENT` text DEFAULT NULL COMMENT 'ADDITIONAL INFO ABOUT CART'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `chef`
--

CREATE TABLE `chef` (
  `ID` bigint(20) NOT NULL,
  `FOOD ID` bigint(20) NOT NULL,
  `CHEF ID` bigint(20) NOT NULL,
  `CHEF AVAILABILITY` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='to track chef assigned to cook item';

-- --------------------------------------------------------

--
-- Table structure for table `delivery`
--

CREATE TABLE `delivery` (
  `ID` bigint(20) NOT NULL,
  `USER ID` bigint(20) NOT NULL COMMENT 'ASSOCIATED USER ID',
  `ADDRESS LINE1` text DEFAULT NULL,
  `ADDRESS LINE2` text DEFAULT NULL,
  `PHONE NUMBER` bigint(15) DEFAULT NULL,
  `PAYEMENT STATUS` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'PAYED OR COD',
  `DELIVERED` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'DELIVERED OR NOT DELIVERED',
  `DELIVERY INSTRUCTIONS` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `forgot_password`
--

CREATE TABLE `forgot_password` (
  `ID` bigint(20) NOT NULL COMMENT 'to uniquely identify record',
  `USER ID` bigint(20) NOT NULL COMMENT 'to identify user',
  `MOBILE NUMBER` int(11) NOT NULL,
  `EMAIL` varchar(100) NOT NULL,
  `OTP` bigint(4) DEFAULT NULL,
  `NEW PASSWORD` varchar(32) DEFAULT NULL,
  `CONFIRM PASSWORD` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE `item` (
  `ID` bigint(20) NOT NULL,
  `VENDOR ID` bigint(20) NOT NULL,
  `TITLE` varchar(100) NOT NULL COMMENT 'item title to be displayed on menu',
  `SUMMARY` tinytext DEFAULT NULL COMMENT 'summary to highlight key details',
  `TYPE` smallint(6) NOT NULL DEFAULT 0 COMMENT 'to differentiate between different types of items',
  `COOKING` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'whether cooking required or not ',
  `SKU` varchar(100) NOT NULL COMMENT 'stock keeping unit',
  `QUANTITY` float NOT NULL DEFAULT 0 COMMENT 'AVAILABLE QUANTITY',
  `UNIT` smallint(6) NOT NULL COMMENT 'UNIT OF MEASURE',
  `CREATED AT` datetime NOT NULL,
  `UPDATED AT` datetime DEFAULT NULL,
  `CONTENT` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `MENU ID` bigint(20) NOT NULL COMMENT 'to differentiate b/w type of menu',
  `USER ID` bigint(20) NOT NULL COMMENT 'to identify admin',
  `TITLE` varchar(100) NOT NULL COMMENT 'TITLE TO BE DISPLAYED ABOUT MENU TYPE',
  `SUMMARY` text DEFAULT NULL COMMENT 'KEY HIGHLIGHTS OF MENU',
  `CREATED AT` datetime NOT NULL,
  `UPDATED AT` datetime DEFAULT NULL,
  `CONTENT` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='TO STORE MULTIPLE MENUS OF RESTAURANT';

-- --------------------------------------------------------

--
-- Table structure for table `menu_item_availability`
--

CREATE TABLE `menu_item_availability` (
  `ID` bigint(20) NOT NULL,
  `SUBMENID` bigint(20) NOT NULL,
  `ITEM ID` bigint(20) NOT NULL,
  `AVAILABILITY` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `order_summary`
--

CREATE TABLE `order_summary` (
  `ID` bigint(20) NOT NULL,
  `USER ID` bigint(20) NOT NULL COMMENT 'associated user id associated with order summary',
  `SUB MENU ID` bigint(20) NOT NULL COMMENT 'associated menu items',
  `ORDER ID` bigint(20) NOT NULL COMMENT 'associated order id',
  `SKU` varchar(100) NOT NULL COMMENT 'stock keeping unit',
  `PRICE` float NOT NULL DEFAULT 0 COMMENT 'final price paid',
  `DISCOUNT` float NOT NULL DEFAULT 0 COMMENT 'discount applied',
  `QUANTITY` float NOT NULL DEFAULT 0 COMMENT 'quantity on menu item',
  `CREATED AT` datetime NOT NULL,
  `UPDATED AT` datetime DEFAULT NULL,
  `CONTENT` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `order_table`
--

CREATE TABLE `order_table` (
  `ID` bigint(20) NOT NULL,
  `USER ID` bigint(20) NOT NULL,
  `VENDOR ID` bigint(20) NOT NULL,
  `TOKEN` varchar(100) NOT NULL,
  `STATUS` smallint(6) NOT NULL,
  `SUBTOTAL` float DEFAULT 0,
  `ITEM DISCOUNT` float DEFAULT 0,
  `TAX` float DEFAULT 0,
  `SHIPPING` float NOT NULL DEFAULT 0,
  `TOTAL` float NOT NULL DEFAULT 0,
  `PROMOCODE` varchar(50) DEFAULT NULL,
  `PROMO DISCOUNT` float NOT NULL DEFAULT 0,
  `GRAND TOTAL` float NOT NULL,
  `CREATED AT` datetime NOT NULL,
  `UPDATED AT` datetime DEFAULT NULL,
  `CONTENT` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `recipe`
--

CREATE TABLE `recipe` (
  `RECIPE ID` bigint(20) NOT NULL,
  `CHEF ID` bigint(20) NOT NULL COMMENT 'ASSOCIATED CHEF FOR RECIPE',
  `RECIPE NAME` varchar(100) NOT NULL,
  `CREATED AT` datetime NOT NULL,
  `UPDATED AT` datetime DEFAULT NULL,
  `CONTENT` text NOT NULL COMMENT 'additional info about recipe'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `subrecipe`
--

CREATE TABLE `subrecipe` (
  `ID` bigint(20) NOT NULL,
  `SUB RECIPE ID` bigint(20) NOT NULL,
  `ITEM ID` bigint(20) NOT NULL,
  `QUANTITY` float NOT NULL DEFAULT 0,
  `INSTRUCTIONS` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `sub_menu`
--

CREATE TABLE `sub_menu` (
  `ID` bigint(20) NOT NULL,
  `SUBMENID` bigint(20) NOT NULL COMMENT 'TO IDENTIFY MENU TYPE',
  `MENU ITEM` text DEFAULT NULL COMMENT 'NAME OF THE ITEM',
  `QUANTITY` float DEFAULT NULL COMMENT 'QUANTITY OF THE ITEM',
  `PRICE` float DEFAULT NULL COMMENT 'PRICE OF THAT PARTICULAR AMOUNT'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `table_top`
--

CREATE TABLE `table_top` (
  `ID` bigint(20) NOT NULL,
  `TABLE CODE` varchar(15) NOT NULL COMMENT 'table code',
  `STATUS` smallint(6) NOT NULL DEFAULT 0 COMMENT 'table status reserved , cancelled ,  booked ,damage',
  `CAPACITY` smallint(6) NOT NULL DEFAULT 0 COMMENT 'table capacity',
  `CREATED AT` datetime NOT NULL COMMENT 'time table was created',
  `UPDATED AT` datetime DEFAULT NULL COMMENT 'time table was updated',
  `CONTENT` text DEFAULT NULL COMMENT 'additional info about table'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `ID` bigint(20) NOT NULL,
  `USER ID` bigint(20) NOT NULL COMMENT 'ASSOCIATED USER WITH TRANSACTION',
  `ORDER ID` bigint(20) NOT NULL COMMENT 'ASSOCIATED ORDER ID',
  `VENDOR ID` bigint(20) NOT NULL COMMENT 'ASSOCIATED VENDOR/APPLICATION',
  `CODE` smallint(6) NOT NULL DEFAULT 0 COMMENT 'TO PROIVIDE GATEWAY OF PAYEMENT',
  `TYPE` smallint(6) NOT NULL COMMENT 'CREDIT/DEBIT',
  `MODE` smallint(6) NOT NULL COMMENT 'CHECK/DD/UPI..',
  `STATUS` smallint(6) NOT NULL COMMENT 'NEW/CANCELLED',
  `CREATED AT` datetime NOT NULL,
  `UPDATED AT` datetime DEFAULT NULL,
  `CONTENT` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `ID` bigint(20) NOT NULL COMMENT 'to identify user',
  `USERNAME` varchar(50) NOT NULL,
  `PASSWORD` varchar(32) NOT NULL,
  `ROLE` tinyint(4) NOT NULL COMMENT 'to identify vendor,customer,chef, admin',
  `FORGOT PASSWORD` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'in case forgot password'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user_details`
--

CREATE TABLE `user_details` (
  `ID` bigint(20) NOT NULL,
  `USER ID` bigint(20) DEFAULT NULL,
  `FIRST NAME` varchar(50) DEFAULT NULL,
  `MIDDLE NAME` varchar(50) DEFAULT NULL,
  `LAST NAME` varchar(50) DEFAULT NULL,
  `MOBILE` bigint(15) DEFAULT NULL,
  `EMAIL` varchar(100) DEFAULT NULL,
  `ADDRESSLINE1` varchar(255) DEFAULT NULL,
  `ADDRESSLINE2` varchar(255) DEFAULT NULL,
  `CITY` varchar(50) DEFAULT NULL,
  `PROVINCE` varchar(50) DEFAULT NULL,
  `COUNTRY` varchar(50) DEFAULT NULL,
  `CONTENT` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `vendor_details`
--

CREATE TABLE `vendor_details` (
  `VENDOR ID` bigint(20) NOT NULL,
  `COMPANY NAME` varchar(100) NOT NULL COMMENT 'vendor''s company name',
  `CONTACT NAME` varchar(100) DEFAULT NULL COMMENT 'vendor name',
  `CONTACT NUMBER` bigint(20) DEFAULT NULL COMMENT 'vendor''s mobile no.',
  `CONTACT DESIGNATION` varchar(100) DEFAULT NULL COMMENT 'vendor''s designation',
  `EMAIL` varchar(100) DEFAULT NULL,
  `ADDRESS` varchar(255) DEFAULT NULL,
  `CONTENT` text DEFAULT NULL COMMENT 'additional info about vendor'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking_table`
--
ALTER TABLE `booking_table`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `fk_booking_table_table_id` (`TABLE ID`),
  ADD KEY `fk_booking_table_user_id` (`USER ID`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD KEY `fk_cart_booking_id` (`BOOKING ID`),
  ADD KEY `fk_cart_submenid` (`FOOD ID`),
  ADD KEY `fk_cart_user_id` (`USER ID`);

--
-- Indexes for table `chef`
--
ALTER TABLE `chef`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `fk_chef_food_id` (`CHEF ID`),
  ADD KEY `fk_chef_chef_id` (`FOOD ID`);

--
-- Indexes for table `delivery`
--
ALTER TABLE `delivery`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `fk_delivery_user_id` (`USER ID`);

--
-- Indexes for table `forgot_password`
--
ALTER TABLE `forgot_password`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `fk_user_forgotpassword` (`USER ID`);

--
-- Indexes for table `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `idx_item_vendor` (`VENDOR ID`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`MENU ID`),
  ADD KEY `fk_menu_user` (`USER ID`);

--
-- Indexes for table `menu_item_availability`
--
ALTER TABLE `menu_item_availability`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `fk_menu_item_availability_submenid` (`SUBMENID`),
  ADD KEY `fk_menu_item_availability_item_id` (`ITEM ID`);

--
-- Indexes for table `order_summary`
--
ALTER TABLE `order_summary`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `fk_order_summary_user_id` (`USER ID`),
  ADD KEY `fk_order_summary_order_id` (`ORDER ID`),
  ADD KEY `fk_order_summary_sub_menu_id` (`SUB MENU ID`);

--
-- Indexes for table `order_table`
--
ALTER TABLE `order_table`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `fk_order_table_user_id` (`USER ID`),
  ADD KEY `fk_order_table_vendor_id` (`VENDOR ID`);

--
-- Indexes for table `recipe`
--
ALTER TABLE `recipe`
  ADD PRIMARY KEY (`RECIPE ID`),
  ADD KEY `fk_recipe_chef_id` (`CHEF ID`);

--
-- Indexes for table `subrecipe`
--
ALTER TABLE `subrecipe`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `uq_recipe_item_id` (`ITEM ID`),
  ADD KEY `fk_subrecipe_subrecipeid` (`SUB RECIPE ID`);

--
-- Indexes for table `sub_menu`
--
ALTER TABLE `sub_menu`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `fk_sub_menu_submenid` (`SUBMENID`);

--
-- Indexes for table `table_top`
--
ALTER TABLE `table_top`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `fk_transaction_user_id` (`USER ID`),
  ADD KEY `fk_transaction_vendor_id` (`VENDOR ID`),
  ADD KEY `fk_transaction_order_id` (`ORDER ID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `user_details`
--
ALTER TABLE `user_details`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `uq_mobile` (`MOBILE`),
  ADD UNIQUE KEY `uq_email` (`EMAIL`),
  ADD KEY `fk_user_user_details` (`USER ID`);

--
-- Indexes for table `vendor_details`
--
ALTER TABLE `vendor_details`
  ADD PRIMARY KEY (`VENDOR ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking_table`
--
ALTER TABLE `booking_table`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chef`
--
ALTER TABLE `chef`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `delivery`
--
ALTER TABLE `delivery`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `forgot_password`
--
ALTER TABLE `forgot_password`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'to uniquely identify record';

--
-- AUTO_INCREMENT for table `item`
--
ALTER TABLE `item`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `MENU ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'to differentiate b/w type of menu';

--
-- AUTO_INCREMENT for table `menu_item_availability`
--
ALTER TABLE `menu_item_availability`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_summary`
--
ALTER TABLE `order_summary`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_table`
--
ALTER TABLE `order_table`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `recipe`
--
ALTER TABLE `recipe`
  MODIFY `RECIPE ID` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subrecipe`
--
ALTER TABLE `subrecipe`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sub_menu`
--
ALTER TABLE `sub_menu`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `table_top`
--
ALTER TABLE `table_top`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'to identify user';

--
-- AUTO_INCREMENT for table `user_details`
--
ALTER TABLE `user_details`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vendor_details`
--
ALTER TABLE `vendor_details`
  MODIFY `VENDOR ID` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking_table`
--
ALTER TABLE `booking_table`
  ADD CONSTRAINT `fk_booking_table_table_id` FOREIGN KEY (`TABLE ID`) REFERENCES `table_top` (`ID`) ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_booking_table_user_id` FOREIGN KEY (`USER ID`) REFERENCES `user` (`ID`) ON UPDATE NO ACTION;

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `fk_cart_booking_id` FOREIGN KEY (`BOOKING ID`) REFERENCES `booking_table` (`ID`) ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_cart_submenid` FOREIGN KEY (`FOOD ID`) REFERENCES `sub_menu` (`SUBMENID`) ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_cart_user_id` FOREIGN KEY (`USER ID`) REFERENCES `user` (`ID`) ON UPDATE NO ACTION;

--
-- Constraints for table `chef`
--
ALTER TABLE `chef`
  ADD CONSTRAINT `fk_chef_chef_id` FOREIGN KEY (`FOOD ID`) REFERENCES `user` (`ID`) ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_chef_food_id` FOREIGN KEY (`CHEF ID`) REFERENCES `sub_menu` (`ID`) ON UPDATE NO ACTION;

--
-- Constraints for table `delivery`
--
ALTER TABLE `delivery`
  ADD CONSTRAINT `fk_delivery_user_id` FOREIGN KEY (`USER ID`) REFERENCES `user` (`ID`) ON UPDATE NO ACTION;

--
-- Constraints for table `forgot_password`
--
ALTER TABLE `forgot_password`
  ADD CONSTRAINT `fk_user_forgotpassword` FOREIGN KEY (`USER ID`) REFERENCES `user` (`ID`) ON UPDATE NO ACTION;

--
-- Constraints for table `item`
--
ALTER TABLE `item`
  ADD CONSTRAINT `fk_item_vendor_id` FOREIGN KEY (`VENDOR ID`) REFERENCES `vendor_details` (`VENDOR ID`) ON UPDATE NO ACTION;

--
-- Constraints for table `menu`
--
ALTER TABLE `menu`
  ADD CONSTRAINT `fk_menu_user` FOREIGN KEY (`USER ID`) REFERENCES `user` (`ID`) ON UPDATE NO ACTION;

--
-- Constraints for table `menu_item_availability`
--
ALTER TABLE `menu_item_availability`
  ADD CONSTRAINT `fk_menu_item_availability_item_id` FOREIGN KEY (`ITEM ID`) REFERENCES `item` (`ID`) ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_menu_item_availability_submenid` FOREIGN KEY (`SUBMENID`) REFERENCES `sub_menu` (`SUBMENID`) ON UPDATE NO ACTION;

--
-- Constraints for table `order_summary`
--
ALTER TABLE `order_summary`
  ADD CONSTRAINT `fk_order_summary_order_id` FOREIGN KEY (`ORDER ID`) REFERENCES `order_table` (`ID`) ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_order_summary_sub_menu_id` FOREIGN KEY (`SUB MENU ID`) REFERENCES `sub_menu` (`ID`) ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_order_summary_user_id` FOREIGN KEY (`USER ID`) REFERENCES `user` (`ID`) ON UPDATE NO ACTION;

--
-- Constraints for table `order_table`
--
ALTER TABLE `order_table`
  ADD CONSTRAINT `fk_order_table_user_id` FOREIGN KEY (`USER ID`) REFERENCES `user` (`ID`) ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_order_table_vendor_id` FOREIGN KEY (`VENDOR ID`) REFERENCES `vendor_details` (`VENDOR ID`) ON UPDATE NO ACTION;

--
-- Constraints for table `recipe`
--
ALTER TABLE `recipe`
  ADD CONSTRAINT `fk_recipe_chef_id` FOREIGN KEY (`CHEF ID`) REFERENCES `chef` (`ID`) ON UPDATE NO ACTION;

--
-- Constraints for table `subrecipe`
--
ALTER TABLE `subrecipe`
  ADD CONSTRAINT `fk_subrecipe_item_id` FOREIGN KEY (`ITEM ID`) REFERENCES `sub_menu` (`ID`) ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_subrecipe_subrecipeid` FOREIGN KEY (`SUB RECIPE ID`) REFERENCES `recipe` (`RECIPE ID`) ON UPDATE NO ACTION;

--
-- Constraints for table `sub_menu`
--
ALTER TABLE `sub_menu`
  ADD CONSTRAINT `fk_sub_menu_submenid` FOREIGN KEY (`SUBMENID`) REFERENCES `menu` (`MENU ID`) ON UPDATE NO ACTION;

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `fk_transaction_order_id` FOREIGN KEY (`ORDER ID`) REFERENCES `order_table` (`ID`) ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_transaction_user_id` FOREIGN KEY (`USER ID`) REFERENCES `user` (`ID`) ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_transaction_vendor_id` FOREIGN KEY (`VENDOR ID`) REFERENCES `vendor_details` (`VENDOR ID`) ON UPDATE NO ACTION;

--
-- Constraints for table `user_details`
--
ALTER TABLE `user_details`
  ADD CONSTRAINT `fk_user_user_details` FOREIGN KEY (`USER ID`) REFERENCES `user` (`ID`) ON UPDATE NO ACTION;

--
-- Constraints for table `vendor_details`
--
ALTER TABLE `vendor_details`
  ADD CONSTRAINT `fk_vendor_detials_admin` FOREIGN KEY (`VENDOR ID`) REFERENCES `user` (`ID`) ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
