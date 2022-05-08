-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 15, 2020 at 02:09 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `freshnfindsnew`
--

-- --------------------------------------------------------

--
-- Table structure for table `additional_products`
--

CREATE TABLE `additional_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` int(11) NOT NULL,
  `user_id` varchar(100) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `longitude` varchar(255) DEFAULT NULL,
  `latitude` varchar(255) DEFAULT NULL,
  `additional_address` varchar(255) DEFAULT NULL,
  `floor` varchar(255) DEFAULT NULL,
  `how_to_reach` varchar(255) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address_type` enum('Home','Office','Public','') DEFAULT NULL,
  `has_default` tinyint(2) NOT NULL DEFAULT 0,
  `pincode` int(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`id`, `user_id`, `location`, `longitude`, `latitude`, `additional_address`, `floor`, `how_to_reach`, `name`, `email`, `phone`, `address_type`, `has_default`, `pincode`, `created_at`, `updated_at`) VALUES
(1, '14', 'Bhubaneswar', NULL, NULL, 'wef', NULL, NULL, 'Tapan Nandy', 'tapankumarnandy2@gmail.com', '9090909090', 'Home', 1, 754200, '2020-09-13 18:23:17', '2020-09-13 18:23:17'),
(2, '15', 'Bhubaneswar', NULL, NULL, 'werwerewr', NULL, NULL, 'Tapan Nandy', 'tapankumarnandy2@gmail.com', '9090909090', 'Home', 1, 754200, '2020-09-14 16:01:39', '2020-09-14 16:01:39');

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'admin@admin.com', '$2y$10$j1BYpZEYul3V5NaD0y0iDusPZ9zV/9UZvWAps/m3WRu3BoQudqbdW', '3igXnjscvqYqRgoJvObOPcnXcotvPXTA3ieUSCO2pUlDgMHdBXyQSr3hBfqD', '2020-06-24 23:25:45', '2020-07-11 01:06:39');

-- --------------------------------------------------------

--
-- Table structure for table `admin_password_resets`
--

CREATE TABLE `admin_password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blogs`
--

CREATE TABLE `blogs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_desc` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` int(11) NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `blogs`
--

INSERT INTO `blogs` (`id`, `title`, `description`, `slug`, `meta_title`, `meta_desc`, `category_id`, `image`, `created_at`, `updated_at`) VALUES
(2, 'Blog 1', '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod<br />\ntempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,<br />\nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo<br />\nconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esse<br />\ncillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non<br />\nproident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod<br />\ntempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,<br />\nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo<br />\nconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esse<br />\ncillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non<br />\nproident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod<br />\ntempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,<br />\nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo<br />\nconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esse<br />\ncillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non<br />\nproident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod<br />\ntempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,<br />\nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo<br />\nconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esse<br />\ncillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non<br />\nproident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod<br />\ntempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,<br />\nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo<br />\nconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esse<br />\ncillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non<br />\nproident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod<br />\ntempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,<br />\nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo<br />\nconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esse<br />\ncillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non<br />\nproident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod<br />\ntempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,<br />\nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo<br />\nconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esse<br />\ncillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non<br />\nproident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod<br />\ntempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,<br />\nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo<br />\nconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esse<br />\ncillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non<br />\nproident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>', 'blog-1', 'Blog 1', 'Blog 1', 1, '1596257020.png', '2020-08-01 04:43:40', '2020-08-22 01:25:50'),
(3, 'Blog 2', '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod<br />\ntempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,<br />\nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo<br />\nconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esse<br />\ncillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non<br />\nproident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod<br />\ntempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,<br />\nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo<br />\nconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esse<br />\ncillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non<br />\nproident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod<br />\ntempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,<br />\nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo<br />\nconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esse<br />\ncillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non<br />\nproident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod<br />\ntempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,<br />\nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo<br />\nconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esse<br />\ncillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non<br />\nproident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod<br />\ntempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,<br />\nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo<br />\nconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esse<br />\ncillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non<br />\nproident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod<br />\ntempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,<br />\nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo<br />\nconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esse<br />\ncillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non<br />\nproident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>', 'blog-2', 'Blog 2', 'Blog 2', 1, '1596257034.png', '2020-08-01 04:43:54', '2020-08-22 01:25:38'),
(4, 'Blog 3', '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod<br />\ntempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,<br />\nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo<br />\nconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esse<br />\ncillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non<br />\nproident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n\n<p>&nbsp;</p>\n\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod<br />\ntempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,<br />\nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo<br />\nconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esse<br />\ncillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non<br />\nproident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n\n<p>&nbsp;</p>\n\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod<br />\ntempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,<br />\nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo<br />\nconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esse<br />\ncillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non<br />\nproident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n\n<p>&nbsp;</p>\n\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod<br />\ntempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,<br />\nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo<br />\nconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esse<br />\ncillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non<br />\nproident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n\n<p>&nbsp;</p>\n\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod<br />\ntempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,<br />\nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo<br />\nconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esse<br />\ncillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non<br />\nproident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>', 'blog-3', 'Blog 3', 'Blog 3', 1, '1596257048.png', '2020-08-01 04:44:08', '2020-08-22 01:25:11');

-- --------------------------------------------------------

--
-- Table structure for table `blog_categories`
--

CREATE TABLE `blog_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `blog_categories`
--

INSERT INTO `blog_categories` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Category1', NULL, NULL),
(2, 'Category2', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_desc` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_normal` enum('yes','no') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'yes',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `parent_id`, `name`, `slug`, `image`, `meta_title`, `meta_desc`, `is_normal`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Cake', 'cake', '1598442502.png', 'Cake', 'Cake', 'yes', '2020-07-02 02:59:38', '2020-08-26 17:18:22'),
(2, NULL, 'Pastry', 'pastry', '1598448144.png', 'Pastry', 'Pastry', 'yes', '2020-07-02 02:59:57', '2020-08-26 18:52:24'),
(3, NULL, 'Burger & Hotdog', 'burger-sub', '1598441836.png', 'Burger & Hotdog', 'Burger & Hotdog', 'yes', '2020-07-02 03:00:22', '2020-08-26 17:07:16'),
(4, NULL, 'Patties & Roll', 'patties-puff', '1598441422.png', 'Patties & Roll', 'Patties & Roll', 'yes', '2020-07-02 03:00:35', '2020-08-26 17:00:22'),
(5, NULL, 'Chocolate & Dessert', 'chocolate-dessert', '1598549364.png', 'Chocolate & Dessert', 'Chocolate & Dessert', 'yes', '2020-07-02 03:00:47', '2020-08-27 22:59:24'),
(6, NULL, 'Cookies', 'cookies', '1598440262.png', 'Cookies', 'Cookies', 'yes', '2020-07-02 03:01:00', '2020-08-26 16:41:02'),
(7, NULL, 'Bread & More', 'bread', '1598449907.png', 'Bread & More', 'Bread & More', 'yes', '2020-07-02 03:01:20', '2020-08-26 19:21:47'),
(8, NULL, 'Dry Cake & Muffin', 'dry-cake-muffin', '1598546174.png', 'Dry Cake & Muffin', 'Dry Cake & Muffin', 'yes', '2020-07-02 03:01:35', '2020-08-27 22:06:14'),
(31, 1, 'Photo Cake', 'photo-cake', '1598359144.png', 'Photo Cake', 'Photo Cake', 'yes', '2020-08-19 15:02:48', '2020-08-25 18:09:04'),
(33, 1, 'Glow Cake', 'glow-cake', '1598355951.png', 'Glow Cake', 'Glow Cake', 'yes', '2020-08-19 15:04:26', '2020-09-01 18:19:16'),
(35, 1, 'Premium Cakes', 'premium-cakes', '1598354640.png', 'Premium Cakes', 'Premium Cakes', 'yes', '2020-08-25 16:54:00', '2020-08-25 20:14:25'),
(36, 1, 'Vanilla', 'vanilla', '1598359833.png', 'Vanilla', 'Vanilla', 'yes', '2020-08-25 18:20:33', '2020-09-01 18:13:57'),
(37, 1, 'Chocolate', 'chocolate', '1598360574.png', 'Chocolate', 'Chocolate', 'no', '2020-08-25 18:32:54', '2020-09-01 18:17:59'),
(38, 1, 'Butterscotch', 'butterscotch', '1598548537.png', 'Butterscotch', 'Butterscotch', 'no', '2020-08-27 20:22:17', '2020-08-27 22:45:37'),
(39, 1, 'Black Forest', 'black-forest', '1598547491.png', 'Black Forest', 'Black Forest', 'no', '2020-08-27 20:33:55', '2020-08-27 22:28:11'),
(40, 1, 'Pineapple', 'pineapple', '1598547787.png', 'Pineapple', 'Pineapple', 'no', '2020-08-27 20:57:56', '2020-09-01 18:17:05'),
(42, 1, 'Cakes By Flavour', 'cakes-by-flavour', '1598965384.png', 'Cakes By Flavour', 'Cakes By Flavour', 'yes', '2020-09-01 18:33:04', '2020-09-01 18:33:37'),
(43, NULL, 'Add-On Products', 'add-on-products', '1600004008.png', 'Add-On Products', 'Add-On Products', 'yes', '2020-09-13 13:33:28', '2020-09-13 13:33:28');

-- --------------------------------------------------------

--
-- Table structure for table `category_images`
--

CREATE TABLE `category_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` int(11) NOT NULL,
  `imagename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `category_images`
--

INSERT INTO `category_images` (`id`, `category_id`, `imagename`, `image`, `created_at`, `updated_at`) VALUES
(45, 1, 'Sliders', '1597657177.png', '2020-08-17 15:09:37', '2020-08-17 15:09:37'),
(46, 1, 'Sliders', '1597657204.png', '2020-08-17 15:10:04', '2020-08-17 15:10:04'),
(47, 2, 'Sliders', '1597657253.png', '2020-08-17 15:10:53', '2020-08-17 15:10:53'),
(48, 2, 'Sliders', '1597657268.png', '2020-08-17 15:11:08', '2020-08-17 15:11:08'),
(49, 3, 'Sliders', '1597657305.png', '2020-08-17 15:11:45', '2020-08-17 15:11:45'),
(50, 3, 'Sliders', '1597657318.png', '2020-08-17 15:11:58', '2020-08-17 15:11:58'),
(51, 4, 'Sliders', '1597657375.png', '2020-08-17 15:12:55', '2020-08-17 15:12:55'),
(52, 4, 'Sliders', '1597657385.png', '2020-08-17 15:13:05', '2020-08-17 15:13:05'),
(54, 5, 'Sliders', '1597657445.png', '2020-08-17 15:14:05', '2020-08-17 15:14:05'),
(55, 5, 'Sliders', '1597657458.png', '2020-08-17 15:14:18', '2020-08-17 15:14:18'),
(56, 6, 'Sliders', '1597657509.png', '2020-08-17 15:15:09', '2020-08-17 15:15:09'),
(57, 6, 'Sliders', '1597657520.png', '2020-08-17 15:15:20', '2020-08-17 15:15:20'),
(58, 7, 'Sliders', '1597657563.png', '2020-08-17 15:16:03', '2020-08-17 15:16:03'),
(59, 7, 'Sliders', '1597657576.png', '2020-08-17 15:16:16', '2020-08-17 15:16:16'),
(60, 8, 'Sliders', '1597657597.png', '2020-08-17 15:16:37', '2020-08-17 15:16:37'),
(61, 8, 'Sliders', '1597657609.png', '2020-08-17 15:16:49', '2020-08-17 15:16:49'),
(62, 24, 'Sliders', '1597657673.png', '2020-08-17 15:17:53', '2020-08-17 15:17:53'),
(63, 24, 'Sliders', '1597657686.png', '2020-08-17 15:18:06', '2020-08-17 15:18:06'),
(64, 23, 'Sliders', '1597657720.png', '2020-08-17 15:18:40', '2020-08-17 15:18:40'),
(65, 23, 'Sliders', '1597657731.png', '2020-08-17 15:18:51', '2020-08-17 15:18:51'),
(67, 22, 'Sliders', '1597657787.png', '2020-08-17 15:19:47', '2020-08-17 15:19:47'),
(68, 22, 'Sliders', '1597657800.png', '2020-08-17 15:20:00', '2020-08-17 15:20:00'),
(69, 21, 'Sliders', '1597657852.png', '2020-08-17 15:20:52', '2020-08-17 15:20:52'),
(70, 21, 'Sliders', '1597657863.png', '2020-08-17 15:21:03', '2020-08-17 15:21:03'),
(71, 20, 'Sliders', '1597657992.png', '2020-08-17 15:23:12', '2020-08-17 15:23:12'),
(72, 20, 'Sliders', '1597658089.png', '2020-08-17 15:24:49', '2020-08-17 15:24:49'),
(73, 19, 'Sliders', '1597658234.png', '2020-08-17 15:27:14', '2020-08-17 15:27:14'),
(74, 19, 'Sliders', '1597658253.png', '2020-08-17 15:27:33', '2020-08-17 15:27:33'),
(75, 18, 'Sliders', '1597658279.png', '2020-08-17 15:27:59', '2020-08-17 15:27:59'),
(76, 18, 'Sliders', '1597658296.png', '2020-08-17 15:28:16', '2020-08-17 15:28:16'),
(77, 27, 'Sliders', '1597752390.png', '2020-08-18 17:36:30', '2020-08-18 17:36:30'),
(78, 29, 'Sliders', '1597829411.png', '2020-08-19 15:00:11', '2020-08-19 15:00:11'),
(79, 33, 'Sliders', '1597829716.png', '2020-08-19 15:05:16', '2020-08-19 15:05:16'),
(80, 32, 'Sliders', '1597829770.png', '2020-08-19 15:06:10', '2020-08-19 15:06:10'),
(81, 31, 'Sliders', '1597829813.png', '2020-08-19 15:06:53', '2020-08-19 15:06:53'),
(82, 30, 'Sliders', '1597829862.png', '2020-08-19 15:07:42', '2020-08-19 15:07:42');

-- --------------------------------------------------------

--
-- Table structure for table `cbcoins`
--

CREATE TABLE `cbcoins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `order_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coins` int(11) DEFAULT NULL,
  `status` tinyint(3) NOT NULL DEFAULT 1,
  `type` enum('PLUS','MINUS') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `expiry_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cbcoins`
--

INSERT INTO `cbcoins` (`id`, `user_id`, `order_id`, `coins`, `status`, `type`, `created_at`, `expiry_at`, `updated_at`) VALUES
(1, 1, NULL, 50, 1, 'PLUS', '2020-08-24 21:01:13', '2020-09-24 21:01:13', '2020-08-24 21:01:13'),
(2, 2, NULL, 50, 1, 'PLUS', '2020-08-24 21:04:33', '2020-09-24 21:04:33', '2020-08-24 21:04:33'),
(3, 3, NULL, 50, 1, 'PLUS', '2020-08-26 14:36:35', '2020-09-26 14:36:35', '2020-08-26 14:36:35'),
(4, 3, '5f465fcf443e6', 10, 2, 'PLUS', '2020-08-26 18:42:47', '2020-09-26 18:42:47', '2020-08-26 18:42:47'),
(5, 4, NULL, 50, 1, 'PLUS', '2020-08-26 18:55:07', '2020-09-26 18:55:07', '2020-08-26 18:55:07'),
(6, 4, '5f4663a2baf97', 25, 3, 'MINUS', '2020-08-26 18:59:06', '2020-09-26 18:59:06', '2020-08-26 18:59:06'),
(7, 4, '5f4663a2baf97', 21, 2, 'PLUS', '2020-08-26 18:59:06', '2020-09-26 18:59:06', '2020-08-26 18:59:06'),
(8, 4, '5f4665057f2c6', 13, 3, 'MINUS', '2020-08-26 19:05:01', '2020-09-26 19:05:01', '2020-08-26 19:05:01'),
(9, 4, '5f4665057f2c6', 9, 2, 'PLUS', '2020-08-26 19:05:01', '2020-09-26 19:05:01', '2020-08-26 19:05:01'),
(10, 5, NULL, 50, 1, 'PLUS', '2020-09-04 16:40:45', '2020-10-04 16:40:45', '2020-09-04 16:40:45'),
(11, 6, NULL, 50, 1, 'PLUS', '2020-09-05 15:29:46', '2020-10-05 15:29:46', '2020-09-05 15:29:46'),
(12, 7, NULL, 50, 1, 'PLUS', '2020-09-05 15:32:39', '2020-10-05 15:32:39', '2020-09-05 15:32:39'),
(13, 8, NULL, 50, 1, 'PLUS', '2020-09-06 18:07:24', '2020-10-06 18:07:24', '2020-09-06 18:07:24'),
(14, 9, NULL, 50, 1, 'PLUS', '2020-09-08 14:07:13', '2020-10-08 14:07:13', '2020-09-08 14:07:13'),
(15, 10, NULL, 50, 1, 'PLUS', '2020-09-11 09:35:40', '2020-10-11 09:35:41', '2020-09-11 09:35:41'),
(16, 11, NULL, 50, 1, 'PLUS', '2020-09-11 09:36:58', '2020-10-11 09:36:58', '2020-09-11 09:36:58'),
(17, 12, NULL, 50, 1, 'PLUS', '2020-09-12 10:32:44', '2020-10-12 10:32:44', '2020-09-12 10:32:44'),
(18, 13, NULL, 50, 1, 'PLUS', '2020-09-12 17:11:28', '2020-10-12 17:11:28', '2020-09-12 17:11:28'),
(19, 12, '5f5e3442c19be', 5, 3, 'MINUS', '2020-09-13 15:01:23', '2020-10-13 15:01:23', '2020-09-13 15:01:23'),
(20, 12, '5f5e3442c19be', 22, 2, 'PLUS', '2020-09-13 15:01:23', '2020-10-13 15:01:23', '2020-09-13 15:01:23'),
(21, 14, NULL, 50, 1, 'PLUS', '2020-09-13 15:44:00', '2020-10-13 15:44:00', '2020-09-13 15:44:00'),
(22, 14, '5f5e3fa5ca775', 5, 3, 'MINUS', '2020-09-13 15:49:58', '2020-10-13 15:49:58', '2020-09-13 15:49:58'),
(23, 14, '5f5e3fa5ca775', 22, 2, 'PLUS', '2020-09-13 15:49:58', '2020-10-13 15:49:58', '2020-09-13 15:49:58'),
(24, 14, '5f5e414f4dfc8', 5, 3, 'MINUS', '2020-09-13 15:57:03', '2020-10-13 15:57:03', '2020-09-13 15:57:03'),
(25, 14, '5f5e414f4dfc8', 22, 2, 'PLUS', '2020-09-13 15:57:03', '2020-10-13 15:57:03', '2020-09-13 15:57:03'),
(26, 14, '5f5e50a0c3b0a', 5, 3, 'MINUS', '2020-09-13 17:02:25', '2020-10-13 17:02:25', '2020-09-13 17:02:25'),
(27, 14, '5f5e50a0c3b0a', 22, 2, 'PLUS', '2020-09-13 17:02:25', '2020-10-13 17:02:25', '2020-09-13 17:02:25'),
(28, 14, '5f5e5a4ce13e6', 5, 3, 'MINUS', '2020-09-13 17:43:41', '2020-10-13 17:43:41', '2020-09-13 17:43:41'),
(29, 14, '5f5e5a4ce13e6', 22, 2, 'PLUS', '2020-09-13 17:43:41', '2020-10-13 17:43:41', '2020-09-13 17:43:41'),
(30, 14, '5f5e5bdbd3aab', 93, 2, 'PLUS', '2020-09-13 17:50:20', '2020-10-13 17:50:20', '2020-09-13 17:50:20'),
(31, 14, '5f5e5d27452a1', 5, 3, 'MINUS', '2020-09-13 17:55:51', '2020-10-13 17:55:51', '2020-09-13 17:55:51'),
(32, 14, '5f5e5d27452a1', 22, 2, 'PLUS', '2020-09-13 17:55:51', '2020-10-13 17:55:51', '2020-09-13 17:55:51'),
(33, 14, '5f5e5e0fe21e8', 5, 3, 'MINUS', '2020-09-13 17:59:44', '2020-10-13 17:59:44', '2020-09-13 17:59:44'),
(34, 14, '5f5e5e0fe21e8', 22, 2, 'PLUS', '2020-09-13 17:59:44', '2020-10-13 17:59:44', '2020-09-13 17:59:44'),
(35, 14, '5f5e5f1137c34', 5, 3, 'MINUS', '2020-09-13 18:04:01', '2020-10-13 18:04:01', '2020-09-13 18:04:01'),
(36, 14, '5f5e5f1137c34', 22, 2, 'PLUS', '2020-09-13 18:04:01', '2020-10-13 18:04:01', '2020-09-13 18:04:01'),
(37, 14, 'OBORD5f5e6ad6efcf2', 93, 2, 'PLUS', '2020-09-13 18:54:15', '2020-10-13 18:54:15', '2020-09-13 18:54:15'),
(38, 14, '5f5e6c16c89fa', 93, 2, 'PLUS', '2020-09-13 18:59:35', '2020-10-13 18:59:35', '2020-09-13 18:59:35'),
(39, 14, 'OBORD5f5e804d1e8ad', 5, 3, 'MINUS', '2020-09-13 20:25:50', '2020-10-13 20:25:50', '2020-09-13 20:25:50'),
(40, 14, 'OBORD5f5e804d1e8ad', 22, 2, 'PLUS', '2020-09-13 20:25:50', '2020-10-13 20:25:50', '2020-09-13 20:25:50'),
(41, 14, 'OBORD5f5e818e17246', 5, 3, 'MINUS', '2020-09-13 20:31:12', '2020-10-13 20:31:12', '2020-09-13 20:31:12'),
(42, 14, 'OBORD5f5e818e17246', 22, 2, 'PLUS', '2020-09-13 20:31:12', '2020-10-13 20:31:12', '2020-09-13 20:31:12'),
(43, 14, 'OBORD5f5e82a8039f7', 5, 3, 'MINUS', '2020-09-13 20:35:53', '2020-10-13 20:35:53', '2020-09-13 20:35:53'),
(44, 14, 'OBORD5f5e82a8039f7', 22, 2, 'PLUS', '2020-09-13 20:35:53', '2020-10-13 20:35:53', '2020-09-13 20:35:53'),
(45, 15, NULL, 50, 1, 'PLUS', '2020-09-14 08:36:03', '2020-10-14 08:36:04', '2020-09-14 08:36:04'),
(46, 15, NULL, 50000, 1, 'PLUS', '2020-09-14 08:36:03', '2020-10-14 08:36:04', '2020-09-14 08:36:04'),
(47, 15, 'OBORD5f5f947fa2aaa', 10, 3, 'MINUS', '2020-09-14 16:04:17', '2020-10-14 16:04:17', '2020-09-14 16:04:17'),
(48, 15, 'OBORD5f5f94a708d7c', 10, 3, 'MINUS', '2020-09-14 16:04:55', '2020-10-14 16:04:55', '2020-09-14 16:04:55'),
(49, 15, 'OBORD5f5f94eb373cd', 10, 3, 'MINUS', '2020-09-14 16:06:03', '2020-10-14 16:06:03', '2020-09-14 16:06:03'),
(50, 15, 'OBORD5f5f94eb373cd', 93, 2, 'PLUS', '2020-09-14 16:06:03', '2020-10-14 16:06:03', '2020-09-14 16:06:03'),
(51, 15, 'OBORD5f5f95d14ded0', 10, 3, 'MINUS', '2020-09-14 16:09:53', '2020-10-14 16:09:53', '2020-09-14 16:09:53'),
(52, 15, 'OBORD5f5f95d14ded0', 93, 2, 'PLUS', '2020-09-14 16:09:53', '2020-10-14 16:09:53', '2020-09-14 16:09:53'),
(53, 15, 'OBORD5f5f96470e565', 10, 3, 'MINUS', '2020-09-14 16:11:51', '2020-10-14 16:11:51', '2020-09-14 16:11:51'),
(54, 15, 'OBORD5f5f96470e565', 93, 2, 'PLUS', '2020-09-14 16:11:51', '2020-10-14 16:11:51', '2020-09-14 16:11:51'),
(55, 15, 'OBORD5f5f97461fb8a', 93, 2, 'PLUS', '2020-09-14 16:16:07', '2020-10-14 16:16:07', '2020-09-14 16:16:07'),
(56, 15, 'OBORD5f5f979d19c9e', 11, 3, 'MINUS', '2020-09-14 16:17:35', '2020-10-14 16:17:35', '2020-09-14 16:17:35'),
(57, 15, 'OBORD5f5f979d19c9e', 93, 2, 'PLUS', '2020-09-14 16:17:35', '2020-10-14 16:17:35', '2020-09-14 16:17:35'),
(58, 15, 'OBORD5f5f98751057f', 93, 2, 'PLUS', '2020-09-14 16:21:09', '2020-10-14 16:21:09', '2020-09-14 16:21:09'),
(59, 15, 'OBORD5f5f98f86d0c3', 10, 3, 'MINUS', '2020-09-14 16:23:21', '2020-10-14 16:23:21', '2020-09-14 16:23:21'),
(60, 15, 'OBORD5f5f98f86d0c3', 93, 2, 'PLUS', '2020-09-14 16:23:21', '2020-10-14 16:23:21', '2020-09-14 16:23:21'),
(61, 15, 'OBORD5f5f9955eeda1', 10, 3, 'MINUS', '2020-09-14 16:24:54', '2020-10-14 16:24:54', '2020-09-14 16:24:54'),
(62, 15, 'OBORD5f5f9955eeda1', 93, 2, 'PLUS', '2020-09-14 16:24:55', '2020-10-14 16:24:55', '2020-09-14 16:24:55'),
(63, 15, 'OBORD5f5f9ccd0e682', 10, 3, 'MINUS', '2020-09-14 16:39:41', '2020-10-14 16:39:41', '2020-09-14 16:39:41'),
(64, 15, 'OBORD5f5f9ccd0e682', 93, 2, 'PLUS', '2020-09-14 16:39:41', '2020-10-14 16:39:41', '2020-09-14 16:39:41'),
(65, 15, 'OBORD5f605876a7e43', 93, 2, 'PLUS', '2020-09-15 06:00:25', '2020-10-15 06:00:25', '2020-09-15 06:00:25'),
(66, 15, 'OBORD5f60594fc04a4', 93, 2, 'PLUS', '2020-09-15 06:04:00', '2020-10-15 06:04:00', '2020-09-15 06:04:00'),
(67, 15, 'OBORD5f605a62dbd6d', 93, 2, 'PLUS', '2020-09-15 06:08:36', '2020-10-15 06:08:36', '2020-09-15 06:08:36'),
(68, 15, 'OBORD5f605a9933837', 14, 2, 'PLUS', '2020-09-15 06:09:30', '2020-10-15 06:09:30', '2020-09-15 06:09:30'),
(69, 15, 'OBORD5f6062a2b8b91', 100, 3, 'MINUS', '2020-09-15 06:43:49', '2020-10-15 06:43:49', '2020-09-15 06:43:49'),
(70, 15, 'OBORD5f6062a2b8b91', 93, 2, 'PLUS', '2020-09-15 06:43:49', '2020-10-15 06:43:49', '2020-09-15 06:43:49'),
(71, 15, 'OBORD5f6070ecd0686', 93, 2, 'PLUS', '2020-09-15 07:44:45', '2020-10-15 07:44:45', '2020-09-15 07:44:45');

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `firstname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `coupon_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `coupon_heading` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `coupon_desc` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_type` enum('percentage','flat') COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount_amount` int(11) NOT NULL,
  `minimum_order` int(11) NOT NULL,
  `validity_till` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `coupons`
--

INSERT INTO `coupons` (`id`, `coupon_code`, `coupon_heading`, `coupon_desc`, `discount_type`, `discount_amount`, `minimum_order`, `validity_till`, `created_at`, `updated_at`) VALUES
(1, 'FIRSTORDER', 'This will be your first order.', 'This will be your first order. and in this order you will get 10 % off.', 'percentage', 10, 200, '2020-11-13', '2020-07-27 06:42:35', '2020-08-24 21:18:01'),
(2, 'SECONDORDER', 'This will be your second order.', 'This will be your second order. and in this order you will get 10 % off.', 'percentage', 10, 200, '2020-08-30', '2020-07-27 06:42:35', '2020-09-13 16:04:36'),
(3, 'THIRDORDER', 'This will be your third order.', 'This will be your second order. and in this order you will get 13 % off.', 'percentage', 13, 200, '2020-08-14', '2020-07-27 06:42:35', '2020-07-27 06:42:35'),
(4, 'TAKEAWAY', 'This will be your takeaway order.', 'This will be your takeaway order. and in this order you FLAT RS20 off.', 'flat', 20, 100, '2020-08-14', '2020-07-27 06:42:35', '2020-07-27 06:42:35');

-- --------------------------------------------------------

--
-- Table structure for table `customize_cakes`
--

CREATE TABLE `customize_cakes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customize_cakes`
--

INSERT INTO `customize_cakes` (`id`, `image`, `created_at`, `updated_at`) VALUES
(3, '1595311788.png', '2020-07-21 00:39:48', '2020-07-21 00:39:48'),
(4, '1595311799.png', '2020-07-21 00:39:59', '2020-07-21 00:39:59'),
(5, '1595311809.png', '2020-07-21 00:40:09', '2020-07-21 00:40:09'),
(6, '1595311818.png', '2020-07-21 00:40:18', '2020-07-21 00:40:18'),
(7, '1597066281.png', '2020-08-10 19:01:21', '2020-08-10 19:01:21');

-- --------------------------------------------------------

--
-- Table structure for table `customize_flavours`
--

CREATE TABLE `customize_flavours` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customize_flavours`
--

INSERT INTO `customize_flavours` (`id`, `name`, `image`, `created_at`, `updated_at`) VALUES
(8, 'Flavour 1', '1599640214.png', '2020-09-09 08:30:14', '2020-09-09 08:30:14'),
(9, 'Flavour 2', '1599640262.png', '2020-09-09 08:31:02', '2020-09-09 08:31:02'),
(10, 'Flavour 3', '1599640266.png', '2020-09-09 08:31:06', '2020-09-09 08:31:06'),
(11, 'Flavour 4', '1599640271.png', '2020-09-09 08:31:11', '2020-09-09 08:31:11'),
(12, 'Flavour 5', '1599640276.png', '2020-09-09 08:31:16', '2020-09-09 08:31:16');

-- --------------------------------------------------------

--
-- Table structure for table `customize_images`
--

CREATE TABLE `customize_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `customize_shape_id` int(11) DEFAULT NULL,
  `customize_flavour_id` int(11) DEFAULT NULL,
  `custom_image_id` int(11) DEFAULT NULL,
  `message_on_cake` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo_cake` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customize_images`
--

INSERT INTO `customize_images` (`id`, `user_id`, `product_id`, `customize_shape_id`, `customize_flavour_id`, `custom_image_id`, `message_on_cake`, `photo_cake`, `created_at`, `updated_at`) VALUES
(2, 9, 62, 11, 8, NULL, 'Happy Birth Day Sam', '1599816623.webp', '2020-09-11 09:30:23', '2020-09-11 09:30:23');

-- --------------------------------------------------------

--
-- Table structure for table `customize_shapes`
--

CREATE TABLE `customize_shapes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customize_shapes`
--

INSERT INTO `customize_shapes` (`id`, `name`, `image`, `created_at`, `updated_at`) VALUES
(11, 'Shape 1', '1599640163.png', '2020-09-09 08:29:23', '2020-09-09 08:29:23'),
(12, 'Shape 2', '1599640167.png', '2020-09-09 08:29:27', '2020-09-09 08:29:27'),
(13, 'Shape 3', '1599640172.png', '2020-09-09 08:29:32', '2020-09-09 08:29:32'),
(14, 'Shape 4', '1599640180.png', '2020-09-09 08:29:40', '2020-09-09 08:29:40'),
(15, 'Shape 5', '1599640299.png', '2020-09-09 08:31:39', '2020-09-09 08:31:39');

-- --------------------------------------------------------

--
-- Table structure for table `delivery_boys`
--

CREATE TABLE `delivery_boys` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `delivery_boys`
--

INSERT INTO `delivery_boys` (`id`, `name`, `email`, `phone`, `created_at`, `updated_at`) VALUES
(3, 'Sitesh Rout', 'delivery1@gmail.com', '9399123993', NULL, '2020-08-25 15:11:48'),
(4, 'Delivery 2', 'delivery2@gmail.com', '9399123993', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `flavours`
--

CREATE TABLE `flavours` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_desc` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `flavours`
--

INSERT INTO `flavours` (`id`, `name`, `slug`, `meta_title`, `meta_desc`, `image`, `created_at`, `updated_at`) VALUES
(1, 'flavours', 'haraprasad', 'Haraprasad Choudhury', 'Haraprasad Choudhury', '1593418846.png', '2020-06-29 02:50:46', '2020-06-29 02:52:36'),
(2, 'flavour2', 'haraprasad', 'Haraprasad Choudhury', 'Haraprasad Choudhury', '1593418846.png', '2020-06-29 02:50:46', '2020-06-29 02:52:36');

-- --------------------------------------------------------

--
-- Table structure for table `godowns`
--

CREATE TABLE `godowns` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `godowns`
--

INSERT INTO `godowns` (`id`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Godown', 'godown@admin.com', '$2y$10$j1BYpZEYul3V5NaD0y0iDusPZ9zV/9UZvWAps/m3WRu3BoQudqbdW', NULL, '2020-07-11 00:51:47', '2020-07-11 01:07:16');

-- --------------------------------------------------------

--
-- Table structure for table `godown_password_resets`
--

CREATE TABLE `godown_password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `image_sliders`
--

CREATE TABLE `image_sliders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `imagename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Keonjhar', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `login_signup_banners`
--

CREATE TABLE `login_signup_banners` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `imagename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `login_signup_banners`
--

INSERT INTO `login_signup_banners` (`id`, `imagename`, `image`, `created_at`, `updated_at`) VALUES
(5, 'Login Signup Banner 2', '1598424845.png', '2020-08-26 12:24:05', '2020-08-26 12:24:05');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2020_06_25_045345_create_admins_table', 1),
(4, '2020_06_25_045346_create_admin_password_resets_table', 1),
(6, '2020_06_25_070455_create_categories_table', 3),
(7, '2020_06_25_070612_create_coupons_table', 3),
(8, '2020_06_25_070817_create_additional_products_table', 3),
(10, '2020_06_25_115249_create_shop_password_resets_table', 4),
(11, '2020_06_25_120131_create_shops_table', 5),
(12, '2020_06_25_070901_create_products_table', 6),
(13, '2020_06_26_085253_create_product_images_table', 6),
(14, '2020_06_26_102544_create_cake_categories_table', 7),
(15, '2020_06_26_102723_create_cake_images_table', 7),
(16, '2020_06_27_024940_create_cakes_table', 8),
(17, '2020_06_27_030918_create_cake_prices_table', 8),
(18, '2020_06_29_060651_create_orders_table', 9),
(19, '2020_06_29_070215_create_occasions_table', 10),
(20, '2020_06_29_070228_create_flavours_table', 10),
(21, '2020_06_30_050213_create_locations_table', 11),
(22, '2020_06_30_121551_create_orderlists_table', 12),
(23, '2020_07_02_103611_create_product_prices_table', 13),
(24, '2020_07_06_054412_create_sections_table', 14),
(25, '2020_07_06_054803_create_section_items_table', 15),
(26, '2020_07_06_102214_create_contacts_table', 16),
(27, '2020_07_08_103549_create_addresses_table', 17),
(28, '2020_07_09_024036_create_customize_images_table', 18),
(29, '2020_07_09_064519_create_newsletters_table', 19),
(30, '2020_07_10_094515_create_product_ratings_table', 20),
(31, '2020_07_11_045456_create_delivery_boys_table', 21),
(32, '2020_07_11_060305_create_godowns_table', 22),
(33, '2020_07_11_060306_create_godown_password_resets_table', 22),
(34, '2020_07_14_101809_create_user_coupons_table', 23),
(37, '2020_07_16_105647_create_sliders_table', 26),
(38, '2020_07_21_054846_create_customize_cakes_table', 27),
(39, '2020_07_21_100117_create_c_bcoins_table', 28),
(40, '2020_07_21_100705_create_cbcoins_table', 29);

-- --------------------------------------------------------

--
-- Table structure for table `newsletters`
--

CREATE TABLE `newsletters` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `newsletters`
--

INSERT INTO `newsletters` (`id`, `email`, `created_at`, `updated_at`) VALUES
(12, 'haraprashad.rixosys@gmail.com', '2020-07-09 01:29:20', '2020-07-09 01:29:20'),
(13, 'hyeyuus@fmail.com', '2020-07-13 01:33:46', '2020-07-13 01:33:46'),
(14, 'RATHAPUNYAJA@GMAIL.COM', '2020-08-22 15:18:07', '2020-08-22 15:18:07'),
(15, 'deepak.85@hotmail.com', '2020-08-25 16:56:44', '2020-08-25 16:56:44'),
(16, 'haraprashffffad.rixosys@gmail.com', '2020-09-04 16:52:10', '2020-09-04 16:52:10'),
(17, 'haraprashfffffffad.rixosys@gmail.com', '2020-09-04 18:05:18', '2020-09-04 18:05:18');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('read','unread') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unread',
  `action_type` enum('accept','reject') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `order_id`, `status`, `action_type`, `created_at`, `updated_at`) VALUES
(1, '5f465fcf443e6', 'read', NULL, '2020-08-26 18:42:47', '2020-08-26 18:42:47'),
(2, '5f4663a2baf97', 'read', NULL, '2020-08-26 18:59:06', '2020-08-26 18:59:06'),
(3, '5f4665057f2c6', 'read', 'accept', '2020-08-26 19:05:01', '2020-08-26 19:20:43'),
(4, '5f5e3442c19be', 'read', NULL, '2020-09-13 15:01:23', '2020-09-13 15:01:23'),
(5, '5f5e3fa5ca775', 'read', NULL, '2020-09-13 15:49:58', '2020-09-13 15:49:58'),
(6, '5f5e414f4dfc8', 'read', NULL, '2020-09-13 15:57:03', '2020-09-13 15:57:03'),
(7, '5f5e50a0c3b0a', 'read', NULL, '2020-09-13 17:02:25', '2020-09-13 17:02:25'),
(8, '5f5e5a4ce13e6', 'read', NULL, '2020-09-13 17:43:41', '2020-09-13 17:43:41'),
(9, '5f5e5bdbd3aab', 'read', NULL, '2020-09-13 17:50:20', '2020-09-13 17:50:20'),
(10, '5f5e5d27452a1', 'read', NULL, '2020-09-13 17:55:51', '2020-09-13 17:55:51'),
(11, '5f5e5e0fe21e8', 'read', NULL, '2020-09-13 17:59:44', '2020-09-13 17:59:44'),
(12, '5f5e5f1137c34', 'read', NULL, '2020-09-13 18:04:01', '2020-09-13 18:04:01'),
(13, 'OBORD5f5e6ad6efcf2', 'read', NULL, '2020-09-13 18:54:15', '2020-09-13 18:54:15'),
(14, '5f5e6c16c89fa', 'read', NULL, '2020-09-13 18:59:34', '2020-09-13 18:59:34'),
(15, 'OBORD5f5e804d1e8ad', 'read', NULL, '2020-09-13 20:25:50', '2020-09-13 20:25:50'),
(16, 'OBORD5f5e818e17246', 'read', NULL, '2020-09-13 20:31:12', '2020-09-13 20:31:12'),
(17, 'OBORD5f5e82a8039f7', 'read', NULL, '2020-09-13 20:35:53', '2020-09-13 20:35:53'),
(18, 'OBORD5f5f94eb373cd', 'read', NULL, '2020-09-14 16:06:03', '2020-09-14 16:06:03'),
(19, 'OBORD5f5f95d14ded0', 'read', NULL, '2020-09-14 16:09:53', '2020-09-14 16:09:53'),
(20, 'OBORD5f5f96470e565', 'read', NULL, '2020-09-14 16:11:51', '2020-09-14 16:11:51'),
(21, 'OBORD5f5f97461fb8a', 'read', NULL, '2020-09-14 16:16:07', '2020-09-14 16:16:07'),
(22, 'OBORD5f5f979d19c9e', 'read', NULL, '2020-09-14 16:17:35', '2020-09-14 16:17:35'),
(23, 'OBORD5f5f98751057f', 'read', NULL, '2020-09-14 16:21:09', '2020-09-14 16:21:09'),
(24, 'OBORD5f5f98f86d0c3', 'read', NULL, '2020-09-14 16:23:21', '2020-09-14 16:23:21'),
(25, 'OBORD5f5f9955eeda1', 'read', NULL, '2020-09-14 16:24:55', '2020-09-14 16:24:55'),
(26, 'OBORD5f5f9ccd0e682', 'read', NULL, '2020-09-14 16:39:42', '2020-09-14 16:39:42'),
(27, 'OBORD5f605876a7e43', 'read', NULL, '2020-09-15 06:00:26', '2020-09-15 06:00:26'),
(28, 'OBORD5f60594fc04a4', 'read', NULL, '2020-09-15 06:04:00', '2020-09-15 06:04:00'),
(29, 'OBORD5f605a62dbd6d', 'read', NULL, '2020-09-15 06:08:37', '2020-09-15 06:08:37'),
(30, 'OBORD5f605a9933837', 'read', NULL, '2020-09-15 06:09:30', '2020-09-15 06:09:30'),
(31, 'OBORD5f6062a2b8b91', 'read', NULL, '2020-09-15 06:43:49', '2020-09-15 06:43:49'),
(32, 'OBORD5f6070ecd0686', 'unread', NULL, '2020-09-15 07:44:45', '2020-09-15 07:44:45');

-- --------------------------------------------------------

--
-- Table structure for table `obcoins`
--

CREATE TABLE `obcoins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `precentage` int(11) NOT NULL,
  `paisa` int(11) NOT NULL,
  `deliveryCharge` int(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `obcoins`
--

INSERT INTO `obcoins` (`id`, `precentage`, `paisa`, `deliveryCharge`, `created_at`, `updated_at`) VALUES
(1, 10, 50, 50, NULL, '2020-08-27 18:01:07');

-- --------------------------------------------------------

--
-- Table structure for table `occasions`
--

CREATE TABLE `occasions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_desc` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `occasions`
--

INSERT INTO `occasions` (`id`, `name`, `slug`, `meta_title`, `meta_desc`, `image`, `created_at`, `updated_at`) VALUES
(1, 'Birthday', 'birthday', 'Birthday', 'Birthday', '1596187880.png', '2020-06-29 02:18:40', '2020-07-31 09:31:20'),
(2, 'Anniversary', 'anniversary', 'Anniversary', 'Anniversary', '1596897308.png', '2020-06-29 02:18:40', '2020-08-08 20:05:08'),
(3, 'Happiness', 'happiness', 'Happiness', 'Happiness', '1596896629.png', '2020-07-31 09:27:52', '2020-08-08 19:53:49'),
(4, 'Wedding/Engagement', 'weddingengagement', 'Wedding/Engagement', 'Wedding/Engagement', '1596896201.png', '2020-07-31 09:29:33', '2020-08-08 19:46:41'),
(5, 'So Sorry', 'so-sorry', 'So Sorry', 'So Sorry', '1596895707.png', '2020-07-31 09:29:51', '2020-08-08 19:38:27'),
(6, 'Promotion', 'promotion', 'Promotion', 'Promotion', '1596895325.png', '2020-07-31 09:30:12', '2020-08-08 19:32:05');

-- --------------------------------------------------------

--
-- Table structure for table `orderlists`
--

CREATE TABLE `orderlists` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `order_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_product_id` int(11) DEFAULT NULL,
  `price_id` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customize_image` int(11) DEFAULT NULL,
  `item_mrp_price` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_selling_price` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_quantity` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cart_status` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orderlists`
--

INSERT INTO `orderlists` (`id`, `user_id`, `order_id`, `item_id`, `parent_product_id`, `price_id`, `customize_image`, `item_mrp_price`, `item_selling_price`, `item_quantity`, `cart_status`, `created_at`, `updated_at`) VALUES
(1, 14, 'OBORD5f5e6820473e6', '72', NULL, '41', NULL, '35', '30', '1', '1', '2020-09-13 18:42:40', '2020-09-13 18:42:40'),
(2, 14, 'OBORD5f5e6820473e6', '71', NULL, '76', NULL, '1000', '900', '1', '1', '2020-09-13 18:42:40', '2020-09-13 18:42:40'),
(3, 14, 'OBORD5f5e6ad6efcf2', '72', NULL, '41', NULL, '35', '30', '1', '1', '2020-09-13 18:54:15', '2020-09-13 18:54:15'),
(4, 14, 'OBORD5f5e6ad6efcf2', '71', NULL, '76', NULL, '1000', '900', '1', '1', '2020-09-13 18:54:15', '2020-09-13 18:54:15'),
(5, 14, '5f5e6c16c89fa', '72', NULL, '76', NULL, '35', '30', '1', '1', '2020-09-13 18:59:34', '2020-09-13 18:59:34'),
(6, 14, '5f5e6c16c89fa', '71', NULL, '76', NULL, '1000', '900', '1', '1', '2020-09-13 18:59:35', '2020-09-13 18:59:35'),
(7, 14, 'OBORD5f5e7f66500b8', '72', NULL, '41', NULL, '35', '30', '1', '1', '2020-09-13 20:21:58', '2020-09-13 20:21:58'),
(8, 14, 'OBORD5f5e7f66500b8', '71', NULL, '76', NULL, '1000', '900', '1', '1', '2020-09-13 20:21:58', '2020-09-13 20:21:58'),
(9, 14, 'OBORD5f5e7fc49cc05', '72', NULL, '41', NULL, '35', '30', '1', '1', '2020-09-13 20:23:32', '2020-09-13 20:23:32'),
(10, 14, 'OBORD5f5e7fc49cc05', '71', NULL, '76', NULL, '1000', '900', '1', '1', '2020-09-13 20:23:32', '2020-09-13 20:23:32'),
(11, 14, 'OBORD5f5e804d1e8ad', '72', NULL, '41', NULL, '35', '30', '1', '1', '2020-09-13 20:25:49', '2020-09-13 20:25:49'),
(12, 14, 'OBORD5f5e804d1e8ad', '71', NULL, '76', NULL, '1000', '900', '1', '1', '2020-09-13 20:25:49', '2020-09-13 20:25:49'),
(13, 14, 'OBORD5f5e818e17246', '72', NULL, '41', NULL, '35', '30', '1', '1', '2020-09-13 20:31:10', '2020-09-13 20:31:10'),
(14, 14, 'OBORD5f5e818e17246', '71', NULL, '76', NULL, '1000', '900', '1', '1', '2020-09-13 20:31:10', '2020-09-13 20:31:10'),
(15, 14, 'OBORD5f5e82a8039f7', '72', NULL, '41', NULL, '35', '30', '1', '1', '2020-09-13 20:35:52', '2020-09-13 20:35:52'),
(16, 14, 'OBORD5f5e82a8039f7', '71', NULL, '76', NULL, '1000', '900', '1', '1', '2020-09-13 20:35:52', '2020-09-13 20:35:52'),
(17, 15, 'OBORD5f5f93e3724d6', '72', NULL, '41', NULL, '35', '30', '1', '1', '2020-09-14 16:01:39', '2020-09-14 16:01:39'),
(18, 15, 'OBORD5f5f93e3724d6', '71', NULL, '76', NULL, '1000', '900', '1', '1', '2020-09-14 16:01:39', '2020-09-14 16:01:39'),
(19, 15, 'OBORD5f5f947fa2aaa', '72', NULL, '41', NULL, '35', '30', '1', '1', '2020-09-14 16:04:16', '2020-09-14 16:04:16'),
(20, 15, 'OBORD5f5f947fa2aaa', '71', NULL, '76', NULL, '1000', '900', '1', '1', '2020-09-14 16:04:16', '2020-09-14 16:04:16'),
(21, 15, 'OBORD5f5f94a708d7c', '72', NULL, '41', NULL, '35', '30', '1', '1', '2020-09-14 16:04:55', '2020-09-14 16:04:55'),
(22, 15, 'OBORD5f5f94a708d7c', '71', NULL, '76', NULL, '1000', '900', '1', '1', '2020-09-14 16:04:55', '2020-09-14 16:04:55'),
(23, 15, 'OBORD5f5f94eb373cd', '72', NULL, '41', NULL, '35', '30', '1', '1', '2020-09-14 16:06:03', '2020-09-14 16:06:03'),
(24, 15, 'OBORD5f5f94eb373cd', '71', NULL, '76', NULL, '1000', '900', '1', '1', '2020-09-14 16:06:03', '2020-09-14 16:06:03'),
(25, 15, 'OBORD5f5f95d14ded0', '72', NULL, '41', NULL, '35', '30', '1', '1', '2020-09-14 16:09:53', '2020-09-14 16:09:53'),
(26, 15, 'OBORD5f5f95d14ded0', '71', NULL, '76', NULL, '1000', '900', '1', '1', '2020-09-14 16:09:53', '2020-09-14 16:09:53'),
(27, 15, 'OBORD5f5f96470e565', '72', NULL, '41', NULL, '35', '30', '1', '1', '2020-09-14 16:11:51', '2020-09-14 16:11:51'),
(28, 15, 'OBORD5f5f96470e565', '71', NULL, '76', NULL, '1000', '900', '1', '1', '2020-09-14 16:11:51', '2020-09-14 16:11:51'),
(29, 15, 'OBORD5f5f97461fb8a', '72', NULL, '41', NULL, '35', '30', '1', '1', '2020-09-14 16:16:07', '2020-09-14 16:16:07'),
(30, 15, 'OBORD5f5f97461fb8a', '71', NULL, '76', NULL, '1000', '900', '1', '1', '2020-09-14 16:16:07', '2020-09-14 16:16:07'),
(31, 15, 'OBORD5f5f979d19c9e', '72', NULL, '41', NULL, '35', '30', '1', '1', '2020-09-14 16:17:33', '2020-09-14 16:17:33'),
(32, 15, 'OBORD5f5f979d19c9e', '71', NULL, '76', NULL, '1000', '900', '1', '1', '2020-09-14 16:17:33', '2020-09-14 16:17:33'),
(33, 15, 'OBORD5f5f98751057f', '72', NULL, '41', NULL, '35', '30', '1', '1', '2020-09-14 16:21:09', '2020-09-14 16:21:09'),
(34, 15, 'OBORD5f5f98751057f', '71', NULL, '76', NULL, '1000', '900', '1', '1', '2020-09-14 16:21:09', '2020-09-14 16:21:09'),
(35, 15, 'OBORD5f5f98f86d0c3', '72', NULL, '41', NULL, '35', '30', '1', '1', '2020-09-14 16:23:20', '2020-09-14 16:23:20'),
(36, 15, 'OBORD5f5f98f86d0c3', '71', NULL, '76', NULL, '1000', '900', '1', '1', '2020-09-14 16:23:20', '2020-09-14 16:23:20'),
(37, 15, 'OBORD5f5f9955eeda1', '72', NULL, '41', NULL, '35', '30', '1', '1', '2020-09-14 16:24:54', '2020-09-14 16:24:54'),
(38, 15, 'OBORD5f5f9955eeda1', '71', NULL, '76', NULL, '1000', '900', '1', '1', '2020-09-14 16:24:54', '2020-09-14 16:24:54'),
(39, 15, 'OBORD5f5f9ccd0e682', '72', NULL, '41', NULL, '35', '30', '2', '1', '2020-09-14 16:39:41', '2020-09-14 16:39:41'),
(40, 15, 'OBORD5f5f9ccd0e682', '71', NULL, '76', NULL, '1000', '900', '1', '1', '2020-09-14 16:39:41', '2020-09-14 16:39:41'),
(41, 15, 'OBORD5f605876a7e43', '72', NULL, '41', NULL, '35', '30', '1', '1', '2020-09-15 06:00:22', '2020-09-15 06:00:22'),
(42, 15, 'OBORD5f605876a7e43', '71', NULL, '76', NULL, '1000', '900', '1', '1', '2020-09-15 06:00:23', '2020-09-15 06:00:23'),
(43, 15, 'OBORD5f60594fc04a4', '72', NULL, '41', NULL, '35', '30', '1', '1', '2020-09-15 06:03:59', '2020-09-15 06:03:59'),
(44, 15, 'OBORD5f60594fc04a4', '71', NULL, '76', NULL, '1000', '900', '1', '1', '2020-09-15 06:04:00', '2020-09-15 06:04:00'),
(45, 15, 'OBORD5f605a62dbd6d', '72', 49, '41', NULL, '35', '30', '1', '1', '2020-09-15 06:08:35', '2020-09-15 06:08:35'),
(46, 15, 'OBORD5f605a62dbd6d', '71', 62, '76', NULL, '1000', '900', '1', '1', '2020-09-15 06:08:36', '2020-09-15 06:08:36'),
(47, 15, 'OBORD5f605a9933837', '3', NULL, '3', NULL, '60', '50', '1', '1', '2020-09-15 06:09:29', '2020-09-15 06:09:29'),
(48, 15, 'OBORD5f605a9933837', '5', NULL, '4', NULL, '50', '40', '1', '1', '2020-09-15 06:09:29', '2020-09-15 06:09:29'),
(49, 15, 'OBORD5f605a9933837', '8', NULL, '6', NULL, '60', '50', '1', '1', '2020-09-15 06:09:30', '2020-09-15 06:09:30'),
(50, 15, 'OBORD5f6062a2b8b91', '72', 49, '41', NULL, '35', '30', '1', '1', '2020-09-15 06:43:47', '2020-09-15 06:43:47'),
(51, 15, 'OBORD5f6062a2b8b91', '71', 62, '76', NULL, '1000', '900', '1', '1', '2020-09-15 06:43:48', '2020-09-15 06:43:48'),
(52, 15, 'OBORD5f6070ecd0686', '72', 49, '41', NULL, '35', '30', '1', '1', '2020-09-15 07:44:45', '2020-09-15 07:44:45'),
(53, 15, 'OBORD5f6070ecd0686', '71', 62, '76', NULL, '1000', '900', '1', '1', '2020-09-15 07:44:45', '2020-09-15 07:44:45');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_price` int(11) DEFAULT NULL,
  `payable_price` int(11) DEFAULT NULL,
  `coupon_amount` int(100) DEFAULT NULL,
  `delivery_charge` int(100) DEFAULT NULL,
  `cbcoin_amount` int(100) DEFAULT NULL,
  `coupon_id` int(255) DEFAULT NULL,
  `coupon_code` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `user_address_id` int(11) DEFAULT NULL,
  `type` enum('delivery','takeaway','pickup') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `store_id` int(11) DEFAULT NULL,
  `takeaway_to_delivery` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assignto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('order_preparing','ontheway','delivered','cancelled','order_received','order_confirmed') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_type` enum('cod','online') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivered_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `txnid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `razorpay_signature` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `razorpay_payment_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount_paid` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `deliveryboy_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `countdowm_time` timestamp NULL DEFAULT NULL,
  `order_made_action_on` timestamp NULL DEFAULT NULL,
  `action_type` enum('accept','reject') COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `order_price`, `payable_price`, `coupon_amount`, `delivery_charge`, `cbcoin_amount`, `coupon_id`, `coupon_code`, `order_id`, `user_id`, `user_address_id`, `type`, `store_id`, `takeaway_to_delivery`, `assignto`, `status`, `payment_type`, `payment_status`, `delivered_date`, `txnid`, `razorpay_signature`, `razorpay_payment_id`, `amount_paid`, `deliveryboy_id`, `created_at`, `countdowm_time`, `order_made_action_on`, `action_type`, `updated_at`) VALUES
(1, 930, 980, 0, 50, NULL, 1, NULL, 'OBORD5f5e6820473e6', 14, 1, NULL, NULL, NULL, NULL, NULL, 'cod', NULL, NULL, NULL, NULL, NULL, '0', NULL, '2020-09-13 18:42:40', NULL, NULL, 'accept', '2020-09-13 18:42:40'),
(2, 930, 980, 0, 50, NULL, 0, NULL, 'OBORD5f5e6ad6efcf2', 14, 1, NULL, NULL, NULL, NULL, NULL, 'cod', NULL, NULL, NULL, NULL, NULL, '0', NULL, '2020-09-13 18:54:14', '2020-09-13 18:59:14', NULL, 'accept', '2020-09-13 18:54:15'),
(3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '5f5e6b3d8e608', 14, 1, NULL, NULL, NULL, NULL, 'order_received', 'online', NULL, NULL, NULL, NULL, NULL, '1', NULL, '2020-09-13 18:55:57', NULL, NULL, 'accept', '2020-09-13 18:55:57'),
(4, 930, 980, NULL, 50, NULL, NULL, NULL, '5f5e6c16c89fa', 14, 1, NULL, NULL, NULL, NULL, 'order_received', 'online', NULL, NULL, NULL, NULL, NULL, '1', NULL, '2020-09-13 18:59:34', '2020-09-13 19:04:34', NULL, 'accept', '2020-09-13 18:59:34'),
(5, NULL, NULL, NULL, NULL, NULL, 1, NULL, 'OBORD5f5e7f66500b8', 14, 1, '', 5, NULL, NULL, 'order_received', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2020-09-13 20:21:58', '2020-09-13 20:26:58', NULL, 'accept', '2020-09-13 20:21:58'),
(6, NULL, NULL, NULL, NULL, NULL, 1, NULL, 'OBORD5f5e7fc49cc05', 14, 1, '', 5, NULL, NULL, 'order_received', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, '2020-09-13 20:23:32', '2020-09-13 20:28:32', NULL, 'accept', '2020-09-13 20:23:32'),
(7, 930, 980, 0, 50, NULL, 1, NULL, 'OBORD5f5e804d1e8ad', 14, 1, '', 5, NULL, NULL, 'order_received', '', 'failed', NULL, NULL, NULL, NULL, '0', NULL, '2020-09-13 20:25:49', '2020-09-13 20:30:49', NULL, 'accept', '2020-09-13 20:25:49'),
(8, 930, 980, 0, 50, NULL, 1, NULL, 'OBORD5f5e818e17246', 14, 1, '', 5, NULL, NULL, 'order_received', 'online', 'failed', NULL, NULL, NULL, 'pay_FceABlOsaZ5Cjy', '0', NULL, '2020-09-13 20:31:10', '2020-09-13 20:36:10', NULL, 'accept', '2020-09-13 20:31:10'),
(9, 930, 980, 0, 50, NULL, 1, NULL, 'OBORD5f5e82a8039f7', 14, 1, '', 5, NULL, NULL, 'order_received', 'online', 'success', NULL, NULL, NULL, 'pay_FceFA3ZQOOvbmG', '0', NULL, '2020-09-13 20:35:52', '2020-09-13 20:40:52', NULL, 'accept', '2020-09-13 20:35:53'),
(10, 930, 990, 0, 60, NULL, 0, '', 'OBORD5f5f93e3724d6', 15, 2, '', 5, 'Yes', NULL, 'order_received', 'online', 'success', NULL, NULL, NULL, 'pay_Fcy6PLmKaIhWzO', '0', NULL, '2020-09-14 16:01:39', '2020-09-14 16:06:39', NULL, 'accept', '2020-09-14 16:01:42'),
(11, 930, 895, 90, 60, NULL, 1, 'FIRSTORDER', 'OBORD5f5f947fa2aaa', 15, 2, '', 5, 'No', NULL, 'order_received', 'cod', NULL, NULL, NULL, NULL, NULL, '0', NULL, '2020-09-14 16:04:15', '2020-09-14 16:09:15', NULL, 'accept', '2020-09-14 16:04:17'),
(12, 930, 895, 90, 60, NULL, 1, 'FIRSTORDER', 'OBORD5f5f94a708d7c', 15, 2, '', 5, 'No', NULL, 'order_received', 'cod', NULL, NULL, NULL, NULL, NULL, '0', NULL, '2020-09-14 16:04:55', '2020-09-14 16:09:55', NULL, 'accept', '2020-09-14 16:04:55'),
(13, 930, 895, 90, 60, NULL, 1, 'FIRSTORDER', 'OBORD5f5f94eb373cd', 15, 2, '', 5, 'No', NULL, 'order_received', 'cod', NULL, NULL, NULL, NULL, NULL, '0', NULL, '2020-09-14 16:06:03', '2020-09-14 16:11:03', NULL, 'accept', '2020-09-14 16:06:03'),
(14, 930, 892, 93, 60, NULL, 1, 'FIRSTORDER', 'OBORD5f5f95d14ded0', 15, 2, '', 5, 'Yes', NULL, 'order_received', 'cod', NULL, NULL, NULL, NULL, NULL, '0', NULL, '2020-09-14 16:09:53', '2020-09-14 16:14:53', NULL, 'accept', '2020-09-14 16:09:53'),
(15, 930, 892, 93, 60, 5, 1, 'FIRSTORDER', 'OBORD5f5f96470e565', 15, 2, '', 5, 'No', NULL, 'order_received', 'cod', NULL, NULL, NULL, NULL, NULL, '0', NULL, '2020-09-14 16:11:51', '2020-09-14 16:16:51', NULL, 'accept', '2020-09-14 16:11:51'),
(16, 930, 990, 0, 60, 0, 0, '', 'OBORD5f5f97461fb8a', 15, 2, '', 5, 'No', NULL, 'order_received', 'cod', NULL, NULL, NULL, NULL, NULL, '0', NULL, '2020-09-14 16:16:06', '2020-09-14 16:21:06', NULL, 'accept', '2020-09-14 16:16:07'),
(17, 930, 892, 93, 60, 6, 1, 'FIRSTORDER', 'OBORD5f5f979d19c9e', 15, 2, '', 5, 'No', NULL, 'order_received', 'online', 'success', NULL, NULL, NULL, 'pay_FcyNQ3OyHevmPY', '0', NULL, '2020-09-14 16:17:33', '2020-09-14 16:22:33', NULL, 'accept', '2020-09-14 16:17:33'),
(18, 930, 990, 0, 60, 0, 0, '', 'OBORD5f5f98751057f', 15, 2, '', 5, 'No', NULL, 'order_received', 'online', 'success', NULL, NULL, NULL, 'pay_FcyREN71mkrWb0', '0', NULL, '2020-09-14 16:21:09', '2020-09-14 16:26:09', NULL, 'accept', '2020-09-14 16:21:09'),
(19, 930, 892, 93, 60, 5, 1, 'FIRSTORDER', 'OBORD5f5f98f86d0c3', 15, 2, '', 5, 'No', NULL, 'order_received', 'online', 'success', NULL, NULL, NULL, 'pay_FcyTYMzlDxkbVm', '0', NULL, '2020-09-14 16:23:20', '2020-09-14 16:28:20', NULL, 'accept', '2020-09-14 16:23:20'),
(20, 930, 892, 93, 60, 5, 1, 'FIRSTORDER', 'OBORD5f5f9955eeda1', 15, 2, '', 5, 'No', NULL, 'order_received', 'online', 'success', NULL, NULL, NULL, 'pay_FcyVCJuiPe73Rm', '0', NULL, '2020-09-14 16:24:53', '2020-09-14 16:29:53', NULL, 'accept', '2020-09-14 16:24:54'),
(21, 930, 892, 93, 60, 5, 1, 'FIRSTORDER', 'OBORD5f5f9ccd0e682', 15, 2, '', 5, 'No', NULL, 'order_received', 'online', 'failed', NULL, NULL, NULL, 'pay_FcykoTNx7YpjDL', '0', NULL, '2020-09-14 16:39:41', '2020-09-14 16:44:41', NULL, 'accept', '2020-09-14 16:39:41'),
(22, 930, 990, 0, 60, 0, 0, '', 'OBORD5f605876a7e43', 15, 2, '', 5, 'No', NULL, 'order_received', 'online', 'success', NULL, NULL, NULL, 'pay_FdCOb8pMYLkamU', '0', NULL, '2020-09-15 06:00:22', '2020-09-15 06:05:22', NULL, 'accept', '2020-09-15 06:00:25'),
(23, 930, 990, 0, 60, 0, 0, '', 'OBORD5f60594fc04a4', 15, 2, 'pickup', 5, 'No', NULL, 'order_received', 'online', 'success', NULL, NULL, NULL, 'pay_FdCSMidD9c3Pqm', '0', NULL, '2020-09-15 06:03:59', '2020-09-15 06:08:59', NULL, 'accept', '2020-09-15 06:04:00'),
(24, 930, 990, 0, 60, 0, 0, '', 'OBORD5f605a62dbd6d', 15, 2, 'pickup', 5, 'No', NULL, 'order_received', 'cod', NULL, NULL, NULL, NULL, NULL, '0', NULL, '2020-09-15 06:08:34', '2020-09-15 06:13:34', NULL, 'accept', '2020-09-15 06:08:36'),
(25, 140, 200, 0, 60, 0, 0, '', 'OBORD5f605a9933837', 15, 2, 'delivery', 5, 'No', NULL, 'order_received', 'cod', NULL, NULL, NULL, NULL, NULL, '0', NULL, '2020-09-15 06:09:29', '2020-09-15 06:14:29', NULL, 'accept', '2020-09-15 06:09:30'),
(26, 930, 847, 93, 60, 50, 1, 'FIRSTORDER', 'OBORD5f6062a2b8b91', 15, 2, 'pickup', 5, 'No', NULL, 'delivered', 'cod', NULL, NULL, NULL, NULL, NULL, '0', NULL, '2020-09-15 06:43:46', '2020-09-15 06:48:46', NULL, 'accept', '2020-09-15 07:43:13'),
(27, 930, 990, 0, 60, 0, 0, '', 'OBORD5f6070ecd0686', 15, 2, 'pickup', 5, 'No', NULL, 'order_confirmed', 'cod', NULL, NULL, NULL, NULL, NULL, '0', NULL, '2020-09-15 07:44:44', '2020-09-15 07:49:44', NULL, 'accept', '2020-09-15 07:47:17');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `subcategory_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `occasion_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_desc` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `store_id` int(11) DEFAULT NULL,
  `parent_product_id` int(11) DEFAULT NULL,
  `stock_quantity` int(11) DEFAULT NULL,
  `is_customize` tinyint(2) NOT NULL DEFAULT 0,
  `is_photocake` tinyint(2) NOT NULL DEFAULT 0,
  `steps_completed` tinyint(3) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `category_id`, `subcategory_id`, `occasion_id`, `meta_title`, `meta_desc`, `slug`, `store_id`, `parent_product_id`, `stock_quantity`, `is_customize`, `is_photocake`, `steps_completed`, `created_at`, `updated_at`) VALUES
(1, 'Chicken Burger', '<p>Crispy Chicken Burger with Mesmerizing taste.</p>', 3, NULL, NULL, 'Chicken Burger', 'Chicken Burger', 'chicken-burger', NULL, NULL, 10, 0, 0, 3, '2020-08-25 15:27:08', '2020-08-25 15:47:33'),
(2, 'Veg Burger', '<p>Crispy all-veg patty packed inside a soft&nbsp;bun.</p>', 3, NULL, NULL, 'Veg Burger', 'Veg Burger', 'veg-burger', NULL, NULL, 10, 0, 0, 3, '2020-08-25 15:44:20', '2020-08-25 15:45:19'),
(3, 'Chicken Hotdog', '<p>Original signature hotdog with sausage.</p>', 3, NULL, NULL, 'Chicken Hotdog', 'Chicken Hotdog', 'chicken-hotdog', NULL, NULL, 10, 0, 0, 3, '2020-08-25 15:52:31', '2020-08-25 15:53:10'),
(5, 'Paneer Hotdog', '<p>The Classic Paneer Hot dog.</p>', 3, NULL, NULL, 'Paneer Hotdog', 'Paneer Hotdog', 'paneer-hotdog', NULL, NULL, 10, 0, 0, 3, '2020-08-25 16:58:26', '2020-08-25 16:58:58'),
(8, 'Choco Brownie', '<p>Made with real dark chocolate, studded with chocolate chips, they make for a truly decadent dessert.</p>', 5, NULL, NULL, 'Choco Brownie', 'Choco Brownie', 'choco-brownie', NULL, NULL, 10, 0, 0, 3, '2020-08-25 17:36:07', '2020-08-25 17:36:31'),
(11, 'Almond Chocolate', '<p>The roasted almonds add a little crunch and go perfectly with the smooth chocolate.Roasted nuts and chocolates are a match made in heaven indeed.</p>', 5, NULL, NULL, 'Almond Chocolate', 'Almond Chocolate', 'almond-chocolate', NULL, NULL, 10, 0, 0, 3, '2020-08-25 17:45:55', '2020-08-25 17:46:16'),
(12, 'Cashew Chocolate', '<p>Take your taste buds on an exotic taste adventure with this delectable mix of crunchy cashew nuts swathed in creamy chocolate.</p>', 5, NULL, NULL, 'Cashew Chocolate', 'Cashew Chocolate', 'cashew-chocolate', NULL, NULL, 10, 0, 0, 3, '2020-08-25 17:51:24', '2020-08-25 17:51:58'),
(13, 'Heart Chocolates', '<p>A chocolate is nature&#39;s way of making a loved one smile.</p>', 5, NULL, NULL, 'Heart Chocolates', 'Heart Chocolates', 'heart-chocolates', NULL, NULL, 10, 0, 0, 3, '2020-08-25 17:57:26', '2020-08-25 20:28:43'),
(22, 'Aloo Patties', '<p>Tasty and delightful.</p>', 4, NULL, NULL, 'Aloo Patties', 'Aloo Patties', 'aloo-patties', NULL, NULL, 10, 0, 0, 3, '2020-08-25 19:06:07', '2020-08-25 19:06:42'),
(23, 'Chicken Patties', '<p>Enjoy the ravishing taste of Chicken Patties.</p>', 4, NULL, NULL, 'Chicken Patties', 'Chicken Patties', 'chicken-patties', NULL, NULL, 10, 0, 0, 3, '2020-08-25 19:08:26', '2020-08-25 19:08:58'),
(24, 'Black Forest', '<p>Just have a single bite of this Black Forest pastry and it will all make a proper sense to you. The kick of cherry and rich chocolate of this super light, airy pastry will definitely make you feel &quot;wow&quot;. The perfect combination of cherry cream and rich chocolate can provide the ultimate fulfillment to your dessert craving.</p>', 2, NULL, NULL, 'Black Forest', 'Black Forest', 'black-forest', NULL, NULL, 10, 0, 0, 3, '2020-08-25 19:14:21', '2020-08-25 19:15:00'),
(25, 'Strawberry', '<p>The ultimate flavour to delight your heart is here in pastries! These strawberry pastries would fill your dullest days with liveliness. The freshly baked desserts with a topping of strawberry glaze and chocolate crown are going to be your ultimate favourite for a long time to come!</p>', 2, NULL, NULL, 'Strawberry', 'Strawberry', 'strawberry', NULL, NULL, 10, 0, 0, 3, '2020-08-25 19:21:24', '2020-08-25 19:21:45'),
(26, 'Blueberry', '<p>Here&#39;s blueberry to impart the flavour like never before. This delicious blueberry pastries is sure to leave you spellbound with its perfect dose of richly whipped cream and blueberry glaze and qualify as an impressive dessert.</p>', 2, NULL, NULL, 'Blueberry', 'Blueberry', 'blueberry', NULL, NULL, 10, 0, 0, 3, '2020-08-25 19:23:32', '2020-08-25 19:24:04'),
(27, 'Butterscotch', '<p>Here&#39;s another classic flavour to leave you spellbound. This scrumptious butterscotch pastries with its luscious flavour is all set to entice you with its caramel shavings and delicious toppings. We bet you would swoon over the pleasing taste of your favourite flavour.</p>', 2, NULL, NULL, 'Butterscotch', 'Butterscotch', 'butterscotch', NULL, NULL, 10, 0, 0, 3, '2020-08-25 19:26:15', '2020-08-25 19:26:43'),
(29, 'Chocolate Chips', '<p>It&#39;s time to fall in luxury..in love with this delish pastries loaded with choco chips and white chocolate crown to satiate your chocolate desires. The mushy base with a delicious chocolate topping is something you would have a hard time saying &#39;No&#39; to.</p>', 2, NULL, NULL, 'Chocolate Chips', 'Chocolate Chips', 'chocolate-chips', NULL, NULL, 10, 0, 0, 3, '2020-08-25 20:06:56', '2020-08-25 20:07:21'),
(30, 'Mango', '<p>Award yourself with the delish flavours of mango pastries and lose yourself in their sumptuous appeal like never before. The mushy base enrobed with almond shavings and topped with mango glaze and chocolate crown are not only going to satiate your sweet tooth desires but also remind you of the summertime goodness!</p>', 2, NULL, NULL, 'Mango', 'Mango', 'mango', NULL, NULL, 10, 0, 0, 3, '2020-08-25 20:10:33', '2020-08-25 20:11:01'),
(32, 'Coffee', '<p>Coffee dusted pastries for those who can never get over their addiction of chocolates! Drool-worthy pastries is here to add a dose of freshness to your mundane routine. These decadent coffee flavours are sure give you a taste of luxury in each bite.</p>', 2, NULL, NULL, 'Coffee', 'Coffee', 'coffee', NULL, NULL, 10, 0, 0, 3, '2020-08-25 20:40:18', '2020-08-25 20:41:08'),
(33, 'Red Velvet', '<p>This is a top to bottom dramatic looking pastry with its bright color of red which is sharply contrasted by a very fresh white cream frosting. This pastry can easily get you completely lost with the amazing flavor that derives when the pastry almost instantly melts in your mouth. Enjoy each bite of this scrumptious pastry.</p>', 2, NULL, NULL, 'Red Velvet', 'Red Velvet', 'red-velvet', NULL, NULL, 10, 0, 0, 3, '2020-08-25 20:42:45', '2020-08-25 20:43:11'),
(34, 'Pineapple', '<p>Pineapple pastries because classic always works the best! These pineapple pastries topped with frozen pineapples and juicy maraschino cherries are sure to leave you craving for one bite after another. So, here&#39;s your favourite flavour wrapped in creamy vanilla to gratify your taste buds in the most delicious way!</p>', 2, NULL, NULL, 'Pineapple', 'Pineapple', 'pineapple', NULL, NULL, 10, 0, 0, 3, '2020-08-25 20:45:49', '2020-08-25 20:46:12'),
(35, 'White Forest', '<p>Delve into sweet pleasures with this White Forest pastries that has everything to gratify your palates with a taste of luxury. The mushy base having bits of maraschino cherries with a topping of white chocolate shavings and juicy cherries is a perfect dessert to dig into whenever you are craving for a luxurious indulgence.</p>', 2, NULL, NULL, 'White Forest', 'White Forest', 'white-forest', NULL, NULL, 10, 0, 0, 3, '2020-08-25 21:22:48', '2020-08-25 21:23:15'),
(36, 'Chocolate Truffle', '<p>This pastry is all about perfection. Made from the finest quality of chocolate, this delicious pastry proudly boasts lips-smacking chocolate covering and cherry decoration. This pastry has been given an awesome touch with the liquid chocolate cream.</p>', 2, NULL, NULL, 'Chocolate Truffle', 'Chocolate Truffle', 'chocolate-truffle', NULL, NULL, 10, 0, 0, 3, '2020-08-25 21:29:35', '2020-08-25 21:30:05'),
(37, 'Chocolate Mud', '<p>Deliciously moist and rich, this is definitely THE best ever pastry&nbsp;for chocolate lovers. One piece is never enough!</p>', 2, NULL, NULL, 'Chocolate Mud', 'Chocolate Mud', 'chocolate-mud', NULL, NULL, 10, 0, 0, 3, '2020-08-25 21:33:22', '2020-08-25 21:34:01'),
(38, 'Chocolate Flakes', '<p>Fudgy chocolate pastry made with pure melted chocolate.</p>', 2, NULL, NULL, 'Chocolate Flakes', 'Chocolate Flakes', 'chocolate-flakes', NULL, NULL, 10, 0, 0, 3, '2020-08-25 21:39:09', '2020-08-25 21:39:36'),
(41, 'Paneer Roll', '<p>The tongue tickling spicy masala of grated paneer wrapped in chapati is a treat to taste buds anytime.These wraps have stuffing of grated paneer, which is sauteed in spicy masala.</p>', 4, NULL, NULL, 'Paneer Roll', 'Paneer Roll', 'paneer-roll', NULL, NULL, 10, 0, 0, 3, '2020-08-25 21:52:38', '2020-08-25 21:52:59'),
(44, 'Orange Slice Cake', '<p>The pulpy orange flavor in the form of bread. Unit Size = 150g</p>', 8, NULL, NULL, 'Orange Slice Cake', 'Orange Slice Cake', 'orange-slice-cake', NULL, NULL, 10, 0, 0, 3, '2020-08-25 23:23:08', '2020-08-27 21:27:03'),
(45, 'Pineapple Slice Cake', '<p>Juicy pineapple flavour in cake.&nbsp;Unit Size = 150g</p>', 8, NULL, NULL, 'Pineapple Slice Cake', 'Pineapple Slice Cake', 'pineapple-slice-cake', NULL, NULL, 10, 0, 0, 3, '2020-08-25 23:29:15', '2020-08-27 21:41:47'),
(46, 'Mix Fruit Slice Cake', '<p>Soft and yummy, the flavor of fruits&nbsp;combined&nbsp;with&nbsp;bread.&nbsp;Unit Size = 150g</p>', 8, NULL, NULL, 'Mix Fruit Slice Cake', 'Mix Fruit Slice Cake', 'mix-fruit-slice-cake', NULL, NULL, 10, 0, 0, 3, '2020-08-25 23:33:01', '2020-08-27 21:37:04'),
(47, 'Milk Butter Slice Cake', '<p>Experience the goodness of milk and butter in all.&nbsp;Unit Size = 150g</p>', 8, NULL, NULL, 'Milk Butter Slice Cake', 'Milk Butter Slice Cake', 'milk-butter-slice-cake', NULL, NULL, 10, 0, 0, 3, '2020-08-25 23:35:07', '2020-08-27 21:28:59'),
(48, 'Butterscotch Cookie', '<p>Crispy and sweet, butterscotch just got a bit better.</p>', 6, NULL, NULL, 'Butterscotch Cookie', 'Butterscotch Cookie', 'butterscotch-cookie', NULL, NULL, 10, 0, 0, 3, '2020-08-25 23:41:19', '2020-08-25 23:43:24'),
(49, 'Magic Cashew', '<p>The delight of cashew with the crunchiness of the cookie.</p>', 1, '33', '3', 'Magic Cashew', 'Magic Cashew', 'magic-cashew', NULL, NULL, 10, 0, 0, 3, '2020-08-25 23:45:32', '2020-09-01 18:50:52'),
(51, 'Round Vanilla', '<p>Simpler things always garner more love and appreciation not just because they are simple rather because they are rare and are one-of-a-kind. Such is this vanilla opulence that has not just filled pages of history with its flavorsome textures but also because it is a crowd-pleasing beauty that has won million hearts before and continue to reign the world with its flavor and creamy textures.</p>', 1, '35', '1,2,3', 'Round Vanilla', 'Round Vanilla', 'round-vanilla', NULL, NULL, NULL, 0, 0, 3, '2020-08-31 17:40:07', '2020-08-31 17:42:35'),
(52, 'Vanilla Oreo Delight', '<p>This simple yet delicious bundt cake is what happens when you add&nbsp;chopped Oreos&nbsp;to an already wonderful vanilla cake batter, cover it in a&nbsp;dripping powdered sugar glaze, and add cookies on top. The best of both worlds, right?</p>', 1, '35', '1,2,3', 'Vanilla Oreo Delight', 'Vanilla Oreo Delight', 'vanilla-oreo-delight', NULL, NULL, NULL, 0, 0, 3, '2020-08-31 17:50:12', '2020-08-31 17:53:19'),
(53, 'Vanilla Strawberry Cake', '<p>No worries if you like strawberry or vanilla we have got both in one. This two in one cake is specially baked for strawberry and vanilla lovers. So, without further ado try this scrumptious strawberry vanilla cake now! You won&#39;t regret the taste.</p>', 1, '35', '1,2,3', 'Vanilla Strawberry Cake', 'Vanilla Strawberry Cake', 'vanilla-strawberry-cake', NULL, NULL, NULL, 0, 0, 3, '2020-08-31 17:57:04', '2020-08-31 17:58:45'),
(54, 'Classic  Vanilla', '<p>If you are spoiled with so many choices then the vanilla cake is the way to go. Perfect for any occasion be it an anniversary, birthday, or any small family gathering. Enjoy the luscious flavored of the all-time classic vanilla cake. Send it to your family or friends on their special days.</p>', 1, '36', '1,2,3,6', 'Classic  Vanilla', 'Classic  Vanilla', 'classic--vanilla', NULL, NULL, NULL, 0, 0, 3, '2020-08-31 18:06:35', '2020-08-31 18:38:01'),
(55, 'Exotic Vanilla', '<p>Covered in lovely light vanilla buttercream and finished with chocolate waffles, this exotic vanilla cake is extremely forgiving. Make this delicious cake a part of any occasion. A perfect delight to surprise anyone, anytime be it a housewarming party or a promotion party.</p>', 1, '36', '1,2,3,6', 'Exotic Vanilla', 'Exotic Vanilla', 'exotic-vanilla', NULL, NULL, NULL, 1, 0, 3, '2020-08-31 18:16:35', '2020-09-01 19:43:29'),
(56, 'Exotic Chocolate', '<p>A true chocolate lover knows how indomitable the cravings can be when it comes to enjoying a decadent chocolate cake. This layered chocolate cake topped up with swirling design of chocolate shaving is the real show-stopper.</p>', 1, '37', '1,2,3,6', 'Exotic Chocolate', 'Exotic Chocolate', 'exotic-chocolate', NULL, NULL, NULL, 0, 0, 3, '2020-08-31 18:23:23', '2020-08-31 18:24:35'),
(58, 'Chocolacious Bliss', '<p>A true chocolate lover knows how indomitable the cravings can be when it comes to enjoying a decadent chocolate cake. This layered chocolate cake topped up with swirling design of chocolate shaving is the real show-stopper.</p>', 1, '37', '1,2,3,4,6', 'Chocolacious Bliss', 'Chocolacious Bliss', 'chocolacious-bliss', NULL, NULL, NULL, 0, 0, 3, '2020-08-31 18:33:09', '2020-08-31 18:35:01'),
(59, 'Kit Kat Choco', '<p>Your beloved kit-kat break just evolved to a whole new level with wafer chocolate frosting and a two-layered delectable chocolaty cake. Utterly mouth-watering treat with whipped dark and brown Chocolate cream and kit kat bars on its crown. Note: Number of Kit Kat bars will vary depending on cake weight</p>', 1, '37', '1,2,3,6', 'Kit Kat Choco', 'Kit Kat Choco', 'kit-kat-choco', NULL, NULL, NULL, 0, 0, 3, '2020-08-31 18:39:48', '2020-08-31 18:41:04'),
(60, 'Choco-Rocher Cake', '<p>Wondering what form of temptation would it take if it was to materialize? The answer is simple- a magically delicious and temptingly mushy - Ferrero Rocher Cake. Made of three layers of rich Chocolate cream, Ferrero Rocher crunch and hazelnut flavour, this Choco ball treat is beyond doubt an irresistible treat. Note: Number of Ferrero Rocher will vary depending on cake weight</p>', 1, '31', '1,2,3', 'Choco-Rocher Cake', 'Choco-Rocher Cake', 'choco-rocher-cake', NULL, NULL, NULL, 0, 0, 3, '2020-08-31 18:52:31', '2020-08-31 18:53:47'),
(61, 'Choco Oreo Delight', '<p>Well, this one comes with a warning! This delectable treat is no less than a delight to the O-RE-O-HO-LICs. So, if you serve this yummylicious two-layered rich creamy Choco-Oreo Cake, all the more frosted with Oreo Cookies, you&#39;ll be starting a tradition. One that&#39;s going to be tough to break!</p>', 1, '37', '1,2,3', 'Choco Oreo Delight', 'Choco Oreo Delight', 'choco-oreo-delight', NULL, NULL, NULL, 0, 0, 3, '2020-08-31 18:56:49', '2020-08-31 19:00:00'),
(62, 'Photo Cake Square', '<p>abcd</p>', 1, '31', '1,2,3,4,5,6', 'Photo Cake Square', 'Photo Cake Square', 'photo-cake-square', NULL, NULL, NULL, 1, 1, 3, '2020-09-06 18:50:30', '2020-09-06 18:51:19'),
(63, 'Photo Cake Square', '<p>abcd</p>', 1, '31', '1,2,3,4,5,6', 'Photo Cake Square', 'Photo Cake Square', 'photo-cake-square', 4, 62, 0, 1, 1, 3, '2020-09-07 11:51:21', '2020-09-07 11:51:21'),
(64, 'Choco Oreo Delight', '<p>Well, this one comes with a warning! This delectable treat is no less than a delight to the O-RE-O-HO-LICs. So, if you serve this yummylicious two-layered rich creamy Choco-Oreo Cake, all the more frosted with Oreo Cookies, you&#39;ll be starting a tradition. One that&#39;s going to be tough to break!</p>', 1, '37', '1,2,3', 'Choco Oreo Delight', 'Choco Oreo Delight', 'choco-oreo-delight', 4, 61, 0, 0, 0, 3, '2020-09-07 11:51:24', '2020-09-07 11:51:24'),
(65, 'Choco-Rocher Cake', '<p>Wondering what form of temptation would it take if it was to materialize? The answer is simple- a magically delicious and temptingly mushy - Ferrero Rocher Cake. Made of three layers of rich Chocolate cream, Ferrero Rocher crunch and hazelnut flavour, this Choco ball treat is beyond doubt an irresistible treat. Note: Number of Ferrero Rocher will vary depending on cake weight</p>', 1, '37', '1,2,3', 'Choco-Rocher Cake', 'Choco-Rocher Cake', 'choco-rocher-cake', 4, 60, 0, 0, 0, 3, '2020-09-07 11:51:26', '2020-09-07 11:51:26'),
(66, 'Kit Kat Choco', '<p>Your beloved kit-kat break just evolved to a whole new level with wafer chocolate frosting and a two-layered delectable chocolaty cake. Utterly mouth-watering treat with whipped dark and brown Chocolate cream and kit kat bars on its crown. Note: Number of Kit Kat bars will vary depending on cake weight</p>', 1, '37', '1,2,3,6', 'Kit Kat Choco', 'Kit Kat Choco', 'kit-kat-choco', 4, 59, 0, 0, 0, 3, '2020-09-07 11:51:29', '2020-09-07 11:51:29'),
(67, 'Chocolacious Bliss', '<p>A true chocolate lover knows how indomitable the cravings can be when it comes to enjoying a decadent chocolate cake. This layered chocolate cake topped up with swirling design of chocolate shaving is the real show-stopper.</p>', 1, '37', '1,2,3,4,6', 'Chocolacious Bliss', 'Chocolacious Bliss', 'chocolacious-bliss', 4, 58, 0, 0, 0, 3, '2020-09-07 11:51:32', '2020-09-07 11:51:32'),
(68, 'Exotic Vanilla', '<p>Covered in lovely light vanilla buttercream and finished with chocolate waffles, this exotic vanilla cake is extremely forgiving. Make this delicious cake a part of any occasion. A perfect delight to surprise anyone, anytime be it a housewarming party or a promotion party.</p>', 1, '36', '1,2,3,6', 'Exotic Vanilla', 'Exotic Vanilla', 'exotic-vanilla', 4, 55, 0, 1, 0, 3, '2020-09-07 11:51:36', '2020-09-07 11:51:36'),
(69, 'Magic Cashew', '<p>The delight of cashew with the crunchiness of the cookie.</p>', 1, '33', '3', 'Magic Cashew', 'Magic Cashew', 'magic-cashew', 4, 49, 0, 0, 0, 3, '2020-09-07 11:51:43', '2020-09-07 11:51:43'),
(70, 'Round Vanilla', '<p>Simpler things always garner more love and appreciation not just because they are simple rather because they are rare and are one-of-a-kind. Such is this vanilla opulence that has not just filled pages of history with its flavorsome textures but also because it is a crowd-pleasing beauty that has won million hearts before and continue to reign the world with its flavor and creamy textures.</p>', 1, '36', '1,2,3', 'Round Vanilla', 'Round Vanilla', 'round-vanilla', 4, 51, 0, 0, 0, 3, '2020-09-07 11:51:46', '2020-09-07 11:51:46'),
(71, 'Photo Cake Square', '<p>abcd</p>', 1, '31', '1,2,3,4,5,6', 'Photo Cake Square', 'Photo Cake Square', 'photo-cake-square', 5, 62, 0, 1, 1, 3, '2020-09-07 11:55:19', '2020-09-07 11:55:19'),
(72, 'Magic Cashew', '<p>The delight of cashew with the crunchiness of the cookie.</p>', 1, '33', '3', 'Magic Cashew', 'Magic Cashew', 'magic-cashew', 5, 49, 0, 0, 0, 3, '2020-09-07 13:24:04', '2020-09-07 13:24:04'),
(77, 'Product 1', '<p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using &#39;Content here, content here&#39;, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for &#39;lorem ipsum&#39; will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose</p>', 43, NULL, NULL, 'Product 1', 'Product 1', 'product-1', NULL, NULL, 10, 0, 0, 3, '2020-09-13 13:37:46', '2020-09-13 13:38:18'),
(78, 'Product 2', '<p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using &#39;Content here, content here&#39;, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for &#39;lorem ipsum&#39; will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose</p>', 43, NULL, NULL, 'Product 2', 'Product 2', 'product-2', NULL, NULL, 12, 0, 0, 3, '2020-09-13 13:38:52', '2020-09-13 13:39:12');

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `is_featured` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customize` tinyint(2) DEFAULT NULL,
  `images` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_images`
--

INSERT INTO `product_images` (`id`, `product_id`, `category_id`, `is_featured`, `customize`, `images`, `created_at`, `updated_at`) VALUES
(1, '1', 3, '1', 0, '1598349470.png', '2020-08-25 15:27:50', '2020-08-25 15:27:50'),
(2, '2', 3, '1', 0, '1598350519.png', '2020-08-25 15:45:19', '2020-08-25 15:45:19'),
(3, '3', 3, '1', 0, '1598350990.png', '2020-08-25 15:53:10', '2020-08-25 15:53:10'),
(4, '5', 3, '1', 0, '1598354938.png', '2020-08-25 16:58:58', '2020-08-25 16:58:58'),
(6, '8', 5, '1', 0, '1598357191.png', '2020-08-25 17:36:31', '2020-08-25 17:36:31'),
(9, '11', 5, '1', 0, '1598357776.png', '2020-08-25 17:46:16', '2020-08-25 17:46:16'),
(10, '12', 5, '1', 0, '1598358118.png', '2020-08-25 17:51:58', '2020-08-25 17:51:58'),
(22, '22', 4, '1', 0, '1598362602.png', '2020-08-25 19:06:42', '2020-08-25 19:06:42'),
(23, '23', 4, '1', 0, '1598362738.png', '2020-08-25 19:08:58', '2020-08-25 19:08:58'),
(24, '24', 2, '1', 0, '1598363100.png', '2020-08-25 19:15:00', '2020-08-25 19:15:00'),
(25, '25', 2, '1', 0, '1598363505.png', '2020-08-25 19:21:45', '2020-08-25 19:21:45'),
(26, '26', 2, '1', 0, '1598363644.png', '2020-08-25 19:24:04', '2020-08-25 19:24:04'),
(27, '27', 2, '1', 0, '1598363803.png', '2020-08-25 19:26:43', '2020-08-25 19:26:43'),
(29, '29', 2, '1', 0, '1598366241.png', '2020-08-25 20:07:21', '2020-08-25 20:07:21'),
(30, '30', 2, '1', 0, '1598366461.png', '2020-08-25 20:11:01', '2020-08-25 20:11:01'),
(32, '22', 4, '0', 0, '1598367776.png', '2020-08-25 20:32:56', '2020-08-25 20:32:56'),
(33, '13', 5, '1', 0, '1598367833.png', '2020-08-25 20:33:53', '2020-08-25 20:33:53'),
(34, '32', 2, '1', 0, '1598368268.png', '2020-08-25 20:41:08', '2020-08-25 20:41:08'),
(35, '33', 2, '1', 0, '1598368391.png', '2020-08-25 20:43:11', '2020-08-25 20:43:11'),
(36, '34', 2, '1', 0, '1598368572.png', '2020-08-25 20:46:12', '2020-08-25 20:46:12'),
(37, '35', 2, '1', 0, '1598370795.png', '2020-08-25 21:23:15', '2020-08-25 21:23:15'),
(38, '36', 2, '1', 0, '1598371205.png', '2020-08-25 21:30:05', '2020-08-25 21:30:05'),
(39, '37', 2, '1', 0, '1598371441.png', '2020-08-25 21:34:01', '2020-08-25 21:34:01'),
(40, '38', 2, '1', 0, '1598371776.png', '2020-08-25 21:39:36', '2020-08-25 21:39:36'),
(43, '41', 4, '1', 0, '1598372579.png', '2020-08-25 21:52:59', '2020-08-25 21:52:59'),
(46, '44', 8, '1', 0, '1598378023.png', '2020-08-25 23:23:43', '2020-08-25 23:23:43'),
(47, '45', 8, '1', 0, '1598378448.png', '2020-08-25 23:30:48', '2020-08-25 23:30:48'),
(48, '46', 8, '1', 0, '1598378601.png', '2020-08-25 23:33:21', '2020-08-25 23:33:21'),
(49, '47', 8, '1', 0, '1598378765.png', '2020-08-25 23:36:05', '2020-08-25 23:36:05'),
(50, '48', 6, '1', 0, '1598379204.png', '2020-08-25 23:43:24', '2020-08-25 23:43:24'),
(51, '49', 6, '1', 0, '1598380217.png', '2020-08-26 00:00:17', '2020-08-26 00:00:17'),
(55, '51', 1, '1', 0, '1598875955.png', '2020-08-31 17:42:35', '2020-08-31 17:42:35'),
(56, '51', 1, '0', 0, '1598876045.png', '2020-08-31 17:44:05', '2020-08-31 17:44:05'),
(57, '52', 1, '1', 0, '1598876556.png', '2020-08-31 17:52:36', '2020-08-31 17:52:36'),
(58, '53', 1, '1', 0, '1598876925.png', '2020-08-31 17:58:45', '2020-08-31 17:58:45'),
(59, '53', 1, '0', 0, '1598876942.png', '2020-08-31 17:59:02', '2020-08-31 17:59:02'),
(60, '53', 1, '0', 0, '1598876956.png', '2020-08-31 17:59:16', '2020-08-31 17:59:16'),
(61, '54', 1, '1', 0, '1598877472.png', '2020-08-31 18:07:52', '2020-08-31 18:07:52'),
(62, '54', 1, '0', 0, '1598877488.png', '2020-08-31 18:08:08', '2020-08-31 18:08:08'),
(63, '54', 1, '0', 0, '1598877499.png', '2020-08-31 18:08:19', '2020-08-31 18:08:19'),
(64, '55', 1, '1', 0, '1598878054.png', '2020-08-31 18:17:34', '2020-08-31 18:17:34'),
(65, '55', 1, '0', 0, '1598878063.png', '2020-08-31 18:17:43', '2020-08-31 18:17:43'),
(66, '55', 1, '0', 0, '1598878075.png', '2020-08-31 18:17:55', '2020-08-31 18:17:55'),
(67, '56', 1, '1', 0, '1598878475.png', '2020-08-31 18:24:35', '2020-08-31 18:24:35'),
(68, '58', 1, '1', 0, '1598879101.png', '2020-08-31 18:35:01', '2020-08-31 18:35:01'),
(69, '58', 1, '0', 0, '1598879119.png', '2020-08-31 18:35:19', '2020-08-31 18:35:19'),
(70, '59', 1, '1', 0, '1598879464.png', '2020-08-31 18:41:04', '2020-08-31 18:41:04'),
(71, '59', 1, '0', 0, '1598879527.png', '2020-08-31 18:42:07', '2020-08-31 18:42:07'),
(72, '59', 1, '0', 0, '1598879553.png', '2020-08-31 18:42:33', '2020-08-31 18:42:33'),
(73, '60', 1, '1', 0, '1598880227.png', '2020-08-31 18:53:47', '2020-08-31 18:53:47'),
(74, '60', 1, '0', 0, '1598880246.png', '2020-08-31 18:54:06', '2020-08-31 18:54:06'),
(75, '60', 1, '0', 0, '1598880260.png', '2020-08-31 18:54:20', '2020-08-31 18:54:20'),
(77, '61', 1, '1', 0, '1598881044.png', '2020-08-31 19:07:24', '2020-08-31 19:07:24'),
(78, '62', 1, '1', 0, '1599398479.png', '2020-09-06 18:51:19', '2020-09-06 18:51:19'),
(81, '77', 43, '1', 0, '1600004298.png', '2020-09-13 13:38:18', '2020-09-13 13:38:18'),
(82, '78', 43, '1', 0, '1600004352.png', '2020-09-13 13:39:12', '2020-09-13 13:39:12');

-- --------------------------------------------------------

--
-- Table structure for table `product_prices`
--

CREATE TABLE `product_prices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `weight` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `mrp_price` int(11) DEFAULT NULL,
  `show_price` tinyint(2) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_prices`
--

INSERT INTO `product_prices` (`id`, `product_id`, `category_id`, `weight`, `price`, `mrp_price`, `show_price`, `created_at`, `updated_at`) VALUES
(1, 2, 3, NULL, 40, 50, 1, '2020-08-25 15:44:33', '2020-09-11 11:30:42'),
(2, 1, 3, NULL, 50, 60, 1, '2020-08-25 15:47:33', '2020-09-11 11:33:50'),
(3, 3, 3, NULL, 50, 60, 1, '2020-08-25 15:52:40', '2020-09-11 11:30:32'),
(4, 5, 3, NULL, 40, 50, 1, '2020-08-25 16:58:36', '2020-09-11 11:30:25'),
(5, 6, 5, NULL, 50, 60, 0, '2020-08-25 17:21:16', '2020-08-25 17:21:16'),
(6, 8, 5, NULL, 50, 60, 1, '2020-08-25 17:36:15', '2020-09-11 11:30:20'),
(7, 9, 5, NULL, 30, 40, 0, '2020-08-25 17:41:55', '2020-08-25 17:41:55'),
(8, 10, 5, NULL, 30, 40, 0, '2020-08-25 17:44:48', '2020-08-25 17:44:48'),
(9, 11, 5, NULL, 30, 40, 1, '2020-08-25 17:46:03', '2020-09-11 11:30:15'),
(10, 12, 5, NULL, 30, 40, 1, '2020-08-25 17:51:34', '2020-09-11 11:30:09'),
(11, 13, 5, NULL, 30, 40, 1, '2020-08-25 17:57:37', '2020-09-11 11:29:50'),
(12, 15, 4, NULL, 30, 40, 0, '2020-08-25 18:32:05', '2020-08-25 18:32:05'),
(13, 16, 4, NULL, 30, 40, 0, '2020-08-25 18:40:09', '2020-08-25 18:40:09'),
(14, 17, 4, NULL, 30, 40, 0, '2020-08-25 18:42:37', '2020-08-25 18:42:37'),
(15, 19, 4, NULL, 30, 40, 0, '2020-08-25 18:45:40', '2020-08-25 18:45:40'),
(16, 21, 4, NULL, 30, 40, 0, '2020-08-25 19:02:34', '2020-08-25 19:02:34'),
(17, 22, 4, NULL, 30, 40, 1, '2020-08-25 19:06:19', '2020-09-11 11:29:44'),
(18, 23, 4, NULL, 30, 40, 1, '2020-08-25 19:08:36', '2020-09-11 11:29:39'),
(19, 24, 2, NULL, 50, 60, 1, '2020-08-25 19:14:31', '2020-09-11 11:29:34'),
(20, 25, 2, NULL, 50, 60, 1, '2020-08-25 19:21:33', '2020-09-11 11:29:30'),
(21, 26, 2, NULL, 50, 60, 1, '2020-08-25 19:23:49', '2020-09-11 11:29:10'),
(22, 27, 2, NULL, 50, 60, 1, '2020-08-25 19:26:25', '2020-09-11 11:29:06'),
(23, 29, 2, NULL, 50, 60, 1, '2020-08-25 20:07:06', '2020-09-11 11:29:00'),
(24, 30, 2, NULL, 50, 60, 1, '2020-08-25 20:10:44', '2020-09-11 11:28:53'),
(25, 32, 2, NULL, 50, 60, 1, '2020-08-25 20:40:30', '2020-09-11 11:28:26'),
(26, 33, 2, NULL, 50, 60, 1, '2020-08-25 20:42:55', '2020-09-11 11:28:18'),
(27, 34, 2, NULL, 50, 60, 1, '2020-08-25 20:45:58', '2020-09-11 11:28:12'),
(28, 35, 2, NULL, 50, 60, 1, '2020-08-25 21:22:59', '2020-09-11 11:28:05'),
(29, 36, 2, NULL, 50, 60, 1, '2020-08-25 21:29:47', '2020-09-11 11:27:59'),
(30, 37, 2, NULL, 50, 60, 1, '2020-08-25 21:33:34', '2020-09-11 11:27:22'),
(31, 38, 2, NULL, 50, 60, 1, '2020-08-25 21:39:21', '2020-09-10 08:15:51'),
(32, 39, 4, NULL, 50, 60, 0, '2020-08-25 21:50:20', '2020-08-25 21:50:20'),
(33, 41, 4, NULL, 50, 60, 1, '2020-08-25 21:52:47', '2020-09-11 11:27:11'),
(34, 42, 8, NULL, 30, 35, 0, '2020-08-25 23:15:50', '2020-08-25 23:15:50'),
(35, 43, 8, NULL, 30, 35, 0, '2020-08-25 23:18:11', '2020-08-25 23:18:11'),
(36, 44, 8, NULL, 26, 30, 1, '2020-08-25 23:23:20', '2020-09-11 11:27:05'),
(37, 45, 8, NULL, 26, 30, 1, '2020-08-25 23:29:23', '2020-09-11 11:26:59'),
(38, 46, 8, NULL, 26, 30, 1, '2020-08-25 23:33:07', '2020-09-11 11:26:51'),
(39, 47, 8, NULL, 26, 30, 1, '2020-08-25 23:35:13', '2020-09-11 11:26:45'),
(40, 48, 6, NULL, 30, 35, 1, '2020-08-25 23:41:27', '2020-09-11 11:26:36'),
(41, 49, 6, '1Kg', 30, 35, 1, '2020-08-25 23:45:38', '2020-09-11 11:26:25'),
(42, 50, 2, NULL, 190, 200, 0, '2020-08-26 14:22:06', '2020-08-26 14:26:23'),
(43, 51, 1, '500gms', 350, 400, 1, '2020-08-31 17:42:02', '2020-09-11 11:26:12'),
(44, 51, 1, '1kg', 700, 800, 0, '2020-08-31 17:42:02', '2020-09-11 11:26:12'),
(45, 51, 1, '2kg', 1400, 1600, 0, '2020-08-31 17:42:02', '2020-09-11 11:26:12'),
(46, 52, 1, '500gms', 400, 500, 1, '2020-08-31 17:51:21', '2020-09-11 11:26:01'),
(47, 52, 1, '1kg', 800, 1000, 0, '2020-08-31 17:51:21', '2020-09-11 11:26:01'),
(48, 52, 1, '2kg', 1600, 2000, 0, '2020-08-31 17:51:21', '2020-09-11 11:26:01'),
(49, 53, 1, '500gms', 500, 600, 1, '2020-08-31 17:57:59', '2020-09-11 11:25:51'),
(50, 53, 1, '1kg', 1000, 1200, 0, '2020-08-31 17:57:59', '2020-09-11 11:25:51'),
(51, 53, 1, '2kg', 2000, 2400, 0, '2020-08-31 17:57:59', '2020-09-11 11:25:51'),
(52, 54, 1, '500gms', 350, 400, 1, '2020-08-31 18:06:58', '2020-08-31 18:06:58'),
(53, 54, 1, '1kg', 700, 800, 0, '2020-08-31 18:07:36', '2020-08-31 18:07:36'),
(54, 54, 1, '2kg', 1400, 1600, 0, '2020-08-31 18:07:36', '2020-08-31 18:07:36'),
(55, 55, 1, '500gms', 400, 500, 1, '2020-08-31 18:17:22', '2020-09-11 11:25:35'),
(56, 55, 1, '1kg', 800, 1000, 0, '2020-08-31 18:17:22', '2020-09-11 11:25:35'),
(57, 55, 1, '2kg', 1600, 2000, 0, '2020-08-31 18:17:22', '2020-09-11 11:25:35'),
(58, 56, 1, '500gms', 400, 500, 1, '2020-08-31 18:24:19', '2020-09-11 11:25:20'),
(61, 58, 1, '500gms', 500, 600, 1, '2020-08-31 18:34:11', '2020-09-11 11:25:09'),
(62, 58, 1, '1kg', 1000, 1200, 0, '2020-08-31 18:34:11', '2020-09-11 11:25:08'),
(63, 58, 1, '2kg', 2000, 2400, 0, '2020-08-31 18:34:11', '2020-09-11 11:25:08'),
(64, 59, 1, '500gms', 500, 600, 1, '2020-08-31 18:40:45', '2020-09-11 11:24:55'),
(65, 59, 1, '1kg', 1000, 1200, 0, '2020-08-31 18:40:45', '2020-09-11 11:24:55'),
(66, 59, 1, '2kg', 2000, 2400, 0, '2020-08-31 18:40:45', '2020-09-11 11:24:55'),
(67, 60, 1, '500gms', 700, 800, 1, '2020-08-31 18:53:22', '2020-09-11 11:24:43'),
(68, 60, 1, '1kg', 1400, 1600, 0, '2020-08-31 18:53:22', '2020-09-11 11:24:43'),
(69, 60, 1, '2kg', 2800, 3200, 0, '2020-08-31 18:53:22', '2020-09-11 11:24:43'),
(70, 61, 1, '500gms', 500, 600, 1, '2020-08-31 18:57:43', '2020-09-10 10:58:13'),
(71, 61, 1, '1kg', 1000, 1200, 0, '2020-08-31 18:57:43', '2020-09-10 10:58:13'),
(72, 61, 1, '2kg', 2000, 2400, 0, '2020-08-31 18:57:43', '2020-09-10 10:58:13'),
(74, 56, 1, '1kg', 800, 1000, 0, '2020-09-04 15:58:18', '2020-09-11 11:25:20'),
(75, 56, 1, '2kg', 1600, 2000, 0, '2020-09-04 15:58:18', '2020-09-11 11:25:20'),
(76, 62, 1, '1kg', 900, 1000, 1, '2020-09-06 18:51:06', '2020-09-06 18:51:06'),
(77, 73, 1, '500 Grams', 400, 500, 1, '2020-09-10 11:24:25', '2020-09-10 11:24:39'),
(78, 73, 1, '1 Kg', 900, 1000, 0, '2020-09-10 11:24:26', '2020-09-10 11:24:39'),
(79, 76, 2, NULL, 25489, 35566, 1, '2020-09-10 11:41:59', '2020-09-10 11:41:59'),
(80, 77, 43, NULL, 180, 200, 1, '2020-09-13 13:38:05', '2020-09-13 13:38:05'),
(81, 78, 43, NULL, 170, 190, 1, '2020-09-13 13:39:05', '2020-09-13 13:39:05');

-- --------------------------------------------------------

--
-- Table structure for table `product_ratings`
--

CREATE TABLE `product_ratings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `review_text` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rating` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sections`
--

CREATE TABLE `sections` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` enum('Product','Offer') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sections`
--

INSERT INTO `sections` (`id`, `name`, `type`, `image`, `created_at`, `updated_at`) VALUES
(1, 'Trending Now', 'Product', NULL, '2020-07-26 20:32:59', '2020-08-27 17:59:32'),
(2, 'Appetizer', 'Product', NULL, '2020-07-26 20:33:21', '2020-08-19 17:29:33'),
(3, 'Offer', 'Offer', '1595795617.png', '2020-07-26 20:33:37', '2020-07-31 16:35:12');

-- --------------------------------------------------------

--
-- Table structure for table `section_items`
--

CREATE TABLE `section_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `section_id` int(11) NOT NULL,
  `product_id` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `section_items`
--

INSERT INTO `section_items` (`id`, `section_id`, `product_id`, `created_at`, `updated_at`) VALUES
(23, 3, NULL, '2020-07-26 20:33:37', '2020-07-26 20:33:37'),
(45, 1, '1', '2020-08-27 17:59:06', '2020-08-27 17:59:06'),
(46, 1, '3', '2020-08-27 17:59:06', '2020-08-27 17:59:06'),
(47, 1, '5', '2020-08-27 17:59:06', '2020-08-27 17:59:06'),
(48, 1, '8', '2020-08-27 17:59:06', '2020-08-27 17:59:06'),
(49, 1, '11', '2020-08-27 17:59:06', '2020-08-27 17:59:06'),
(50, 1, '12', '2020-08-27 17:59:06', '2020-08-27 17:59:06'),
(51, 1, '13', '2020-08-27 17:59:06', '2020-08-27 17:59:06'),
(52, 1, '23', '2020-08-27 17:59:06', '2020-08-27 17:59:06'),
(53, 1, '26', '2020-08-27 17:59:06', '2020-08-27 17:59:06'),
(54, 2, '1', '2020-08-27 18:00:07', '2020-08-27 18:00:07'),
(55, 2, '2', '2020-08-27 18:00:07', '2020-08-27 18:00:07'),
(56, 2, '5', '2020-08-27 18:00:07', '2020-08-27 18:00:07'),
(57, 2, '11', '2020-08-27 18:00:07', '2020-08-27 18:00:07'),
(58, 2, '12', '2020-08-27 18:00:07', '2020-08-27 18:00:07'),
(59, 2, '22', '2020-08-27 18:00:07', '2020-08-27 18:00:07'),
(60, 2, '23', '2020-08-27 18:00:07', '2020-08-27 18:00:07'),
(61, 2, '24', '2020-08-27 18:00:07', '2020-08-27 18:00:07'),
(62, 2, '25', '2020-08-27 18:00:07', '2020-08-27 18:00:07'),
(63, 2, '26', '2020-08-27 18:00:07', '2020-08-27 18:00:07'),
(64, 2, '27', '2020-08-27 18:00:07', '2020-08-27 18:00:07');

-- --------------------------------------------------------

--
-- Table structure for table `shops`
--

CREATE TABLE `shops` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shop_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` int(11) DEFAULT NULL,
  `short_address` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `long_address` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shops`
--

INSERT INTO `shops` (`id`, `name`, `phone`, `email`, `shop_name`, `location`, `short_address`, `long_address`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Saumya', '09692280557', 'saumya@gmail.com', 'Keonjhar Shop 1', 1, 'Keonjhar Shop 1', 'Keonjhar Shop 1', '$2y$10$Xrj14v1aQeIhv8Gkb.Nb6uvrTY7GxJcEXTvl2RlWcUt3ht1ww.pIC', NULL, '2020-07-26 20:26:52', '2020-07-26 20:26:52'),
(2, 'Tilak', '9438802718', 'tilak@orangebakery.in', 'OTC 2', 1, 'D.D.College Road', 'D.D.College Road, Infront Of KIDZEE', '$2y$10$EDAiBT/o/7rGyxxqmS2fnujhl8wqiAiosO/bmi59ZP6eifS/esJFy', NULL, '2020-07-26 20:27:19', '2020-09-03 17:32:38'),
(4, 'Tapan', '9090909090', 'tapan@gmail.com', 'Tapan', 1, 'Tapan Store', 'Tapan Store', '$2y$10$238LXk2xLmzU8WGAl4WUKuY9IygcMbS9KPJ.OnZzdKV.84cC4WwZG', NULL, '2020-09-07 11:50:51', '2020-09-07 11:50:51'),
(5, 'Sam', '9090909090', 'sam@gmail.com', 'Sam', 1, 'Sam Store', 'Sam Store Long Address', '$2y$10$QBxOU1Tqq7uoYWMExuWCme77L5W3PuYHOMoM4/7dKPv5hRtFtYPCW', NULL, '2020-09-07 11:53:52', '2020-09-07 11:53:52');

-- --------------------------------------------------------

--
-- Table structure for table `shop_password_resets`
--

CREATE TABLE `shop_password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sliders`
--

CREATE TABLE `sliders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `imagename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `show_in_app_home` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_in_website_home` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sliders`
--

INSERT INTO `sliders` (`id`, `imagename`, `image`, `created_at`, `updated_at`, `show_in_app_home`, `show_in_website_home`) VALUES
(3, 'hhyy', '1.png', '2020-07-16 05:38:37', '2020-07-16 05:38:37', 'yes', 'yes');

-- --------------------------------------------------------

--
-- Table structure for table `testimonials`
--

CREATE TABLE `testimonials` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_in_app_home` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_in_website_home` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `testimonials`
--

INSERT INTO `testimonials` (`id`, `title`, `description`, `image`, `show_in_app_home`, `show_in_website_home`, `created_at`, `updated_at`) VALUES
(1, 'Tapan', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '1597342146.png', 'yes', 'yes', '2020-08-13 23:39:06', '2020-08-13 23:39:06'),
(2, 'Harapraasd', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '1597342169.png', 'yes', 'yes', '2020-08-13 23:39:29', '2020-08-13 23:39:29'),
(3, 'Saumya', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '1597342189.png', 'yes', 'yes', '2020-08-13 23:39:49', '2020-08-13 23:39:49'),
(4, 'Harapriya', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '1597342218.png', 'yes', 'yes', '2020-08-13 23:40:18', '2020-08-13 23:40:18'),
(5, 'Lopamudra', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '1597342243.png', 'yes', 'yes', '2020-08-13 23:40:43', '2020-08-13 23:40:43');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `txnid` varchar(255) DEFAULT NULL,
  `user_id` varchar(100) DEFAULT NULL,
  `order_id` varchar(100) DEFAULT NULL,
  `amount` varchar(100) DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  `razorpay_signature` varchar(255) DEFAULT NULL,
  `razorpay_order_id` varchar(255) DEFAULT NULL,
  `razorpay_payment_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `txnid`, `user_id`, `order_id`, `amount`, `date`, `razorpay_signature`, `razorpay_order_id`, `razorpay_payment_id`, `created_at`, `updated_at`) VALUES
(1, '5f1ec50293d47', NULL, 'order_FJW2WKCo1W7Azi', '360.00', NULL, 'acde521071f7fae6e84b461ec3ff54a72b841729000bde2e71057d98a410083f', 'order_FJW2WKCo1W7Azi', 'order_EevGUYzjxy8leZ', '2020-07-27 12:13:54', '2020-07-27 12:13:54'),
(2, '5f1ec60c77701', NULL, 'order_FJW2WKCo1W7Azi', '360.00', NULL, 'acde521071f7fae6e84b461ec3ff54a72b841729000bde2e71057d98a410083f', 'order_FJW2WKCo1W7Azi', 'order_EevGUYzjxy8leZ', '2020-07-27 12:18:20', '2020-07-27 12:18:20'),
(3, '5f29c6cdc2316', NULL, 'order_FMolg3lEv0yp17', '2524.00', NULL, '694c11add615d089a288fc533f9161a9c1d3193c1b399a00bd4ca89d054819c3', 'order_FMolg3lEv0yp17', 'pay_FMopj4Si8cEzsx', '2020-08-05 02:06:29', '2020-08-05 02:06:29'),
(4, '5f29d1684e614', NULL, 'order_FMpehhinyQJgTb', '2524.00', NULL, '219d9c89f5809d4e43ab1e94d2c6cd65cd3d3c5494ec9f2d7e7ce045143e0e46', 'order_FMpehhinyQJgTb', 'pay_FMpepAxoeB2z21', '2020-08-05 02:51:44', '2020-08-05 02:51:44'),
(5, '5f2eab1eb8ac1', NULL, 'order_FOHqSomzEQsXA6', '701.00', NULL, 'd8f4f9e73605d2b75c341c41bcc12281dd4a7e6b36f2787b8d5456c3a15644b6', 'order_FOHqSomzEQsXA6', 'pay_FOHv9kqohMRL9W', '2020-08-08 19:09:42', '2020-08-08 19:09:42'),
(6, '5f2ece93d1c4c', NULL, 'order_FOKU95tSqXx21Y', '825.00', NULL, 'fb3f20d88827604575c03392317e4b3a97378dc309045619abed021051312927', 'order_FOKU95tSqXx21Y', 'pay_FOKUOoz86Hkuge', '2020-08-08 21:40:59', '2020-08-08 21:40:59');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `otp` int(11) DEFAULT NULL,
  `has_verified` tinyint(2) NOT NULL DEFAULT 0,
  `last_used_platform` enum('ANDROID','WEB') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `lastname`, `email`, `phone`, `avatar`, `otp`, `has_verified`, `last_used_platform`, `email_verified_at`, `password`, `access_token`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Tapan Nandy', NULL, 'dilpreet@civoo.com', '8895064057', NULL, 910801, 0, 'WEB', NULL, 'tapan1234', NULL, NULL, '2020-08-24 21:01:13', '2020-08-24 21:01:14'),
(2, 'Haraprasad Choudhury', NULL, 'haraprashad.rixosys@gmail.com', '7978591914', NULL, 878648, 1, 'WEB', NULL, 'pupu1234', NULL, 'lAqVYKWQeDotlgEv3sY26zNtO1c3KLMamTdB2soRjawYd1UiSTKmVlurgHd7', '2020-08-24 21:04:33', '2020-09-04 16:19:34'),
(3, 'Haraprasad Choudhury', NULL, 'unfeatured@sundaymovo.com', '7978591910', NULL, 468963, 1, 'WEB', NULL, 'pupu1234', NULL, '6TPiszox65ZUcOm5YSn3732JHyX6zaW6Y3AYzDrgqVowb2okfB3uNsCVAKCA', '2020-08-26 14:36:35', '2020-08-26 14:42:31'),
(4, 'Haraprasad', NULL, 'unfeatured@gcyacademy.com', '9099123993', NULL, 366577, 1, 'WEB', NULL, 'pupu1234', NULL, 'kNRaRXjQyz0NJjHASGPoWpObCI7ZTTESnZXjYSLehEASV9DZGU2Ux3dy7N8r', '2020-08-26 18:55:07', '2020-08-26 18:56:03'),
(5, 'Haraprasad', NULL, 'basgggggharaw@coronagg.com', '7978591910', NULL, 428219, 1, 'ANDROID', NULL, 'pupu1234', '9ed895a1f06d855721473a69f1d263be', NULL, '2020-09-04 16:40:45', '2020-09-04 16:42:12'),
(6, 'Rachit', NULL, 'R@gmail.com', '1234567890', NULL, 808166, 0, 'ANDROID', NULL, 'qwerty', NULL, NULL, '2020-09-05 15:29:46', '2020-09-05 15:29:48'),
(7, 'Rachit', NULL, 'Ra@gmail.com', '9439312511', NULL, 327491, 1, 'ANDROID', NULL, 'qwerty', 'b7944ec647db9ae7617348ef82c30372', NULL, '2020-09-05 15:32:39', '2020-09-05 15:33:12'),
(8, 'Tilak Das', NULL, 'tdas006@gmail.com', '9853525838', NULL, 777838, 1, 'WEB', NULL, 'ichigo006', '435ad6916cba0bc4d4471ca0e2b5af8f', 'A4Qy0e11jXcYxBXsVAPhTzSYJOIC0W8i1bDSZz4bxtVqEXmtvmFkaYIZjT02', '2020-09-06 18:07:24', '2020-09-06 18:07:40'),
(9, 'Tapan', NULL, 'testcaketapan@yopmail.com', '9090909090', NULL, 801122, 1, 'WEB', NULL, 'Tapan1234', '5abab5b6c30994c45fd28bee4b76b225', '9RASizkIEgqGEyYRMzcaoePMn9ZiZxlyNp6IHJR5MQvQLwwzCGroP5Zsvk52', '2020-09-08 14:07:12', '2020-09-08 14:07:49'),
(10, 'Tapan', NULL, 'testntv2@yopmail.com', '9090909091', NULL, 986828, 0, 'WEB', NULL, 'Tapan1234', NULL, NULL, '2020-09-11 09:35:40', '2020-09-11 09:36:07'),
(11, 'Tapan', NULL, 'testntv3@yopmail.com', '9090909092', NULL, 661982, 1, 'WEB', NULL, 'Tapan1234', 'df78427dd2f60aed110087f68a267a6b', '4nH5de2HdlLWHvSCtEtn4Td2mW3mfE1xontXjM3pbXKV2qjw8Tbop9TMmfai', '2020-09-11 09:36:58', '2020-09-11 09:38:11'),
(12, 'OB Test', NULL, 'obtest1@yopmail.com', '9090909093', NULL, 560001, 1, 'WEB', NULL, 'Tapan1234', 'd2a7f5fc6ac598ab66957e9cec384db1', '7Xajrlk8F6is1lJhqhFVFupDkgiyF9Ajg1LwTIDZPopF31IzbkdKYvG9V6i5', '2020-09-12 10:32:44', '2020-09-12 10:33:41'),
(13, 'Tapan Nandy', NULL, 'obtest3@yopmail.com', '9090909094', NULL, 197906, 1, 'WEB', NULL, 'Tapan1234', '2ea3dddfb802fe0be1dd6355165ca816', 'FMToXw9tWqViSIiiOb7CcnpT1Ngg7foT1o8tBxbEuw0WEd99Otptv3ajhy8d', '2020-09-12 17:11:27', '2020-09-12 17:11:46'),
(14, 'Tapan', NULL, 'obtest4@yopmail.com', '8095225505', NULL, 902240, 1, 'WEB', NULL, 'Tapan1234', 'a5d99a7a725aafc233bf51c2b7f2b4a3', 'LWA3Fyu890KvUH96Hp1UwvZlCj4xkfojGMQYlO0fF3spvFaf3wUJi20uL6GG', '2020-09-13 15:44:00', '2020-09-13 15:44:18'),
(15, 'OB Test', NULL, 'obtest5@yopmail.com', '8164626456', NULL, 684209, 1, 'WEB', NULL, 'Tapan1234', '102113bea50cbe04e22947ff31631152', 'OSekrQuo1YlVwgYI5zi2l0IqHvV9kc3ATtgJSSAZVYDvFrvOyttzrLXrLADa', '2020-09-14 08:36:03', '2020-09-14 08:36:27');

-- --------------------------------------------------------

--
-- Table structure for table `user_coupons`
--

CREATE TABLE `user_coupons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `coupon_code` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_coupons`
--

INSERT INTO `user_coupons` (`id`, `user_id`, `coupon_code`, `order_id`, `created_at`, `updated_at`) VALUES
(3, 2, 'c1', NULL, '2020-07-27 03:03:41', '2020-07-27 03:03:41');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `additional_products`
--
ALTER TABLE `additional_products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admins_email_unique` (`email`);

--
-- Indexes for table `admin_password_resets`
--
ALTER TABLE `admin_password_resets`
  ADD KEY `admin_password_resets_email_index` (`email`),
  ADD KEY `admin_password_resets_token_index` (`token`);

--
-- Indexes for table `blogs`
--
ALTER TABLE `blogs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog_categories`
--
ALTER TABLE `blog_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category_images`
--
ALTER TABLE `category_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cbcoins`
--
ALTER TABLE `cbcoins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customize_cakes`
--
ALTER TABLE `customize_cakes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customize_flavours`
--
ALTER TABLE `customize_flavours`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customize_images`
--
ALTER TABLE `customize_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customize_shapes`
--
ALTER TABLE `customize_shapes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `delivery_boys`
--
ALTER TABLE `delivery_boys`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `flavours`
--
ALTER TABLE `flavours`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `godowns`
--
ALTER TABLE `godowns`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `godowns_email_unique` (`email`);

--
-- Indexes for table `godown_password_resets`
--
ALTER TABLE `godown_password_resets`
  ADD KEY `godown_password_resets_email_index` (`email`),
  ADD KEY `godown_password_resets_token_index` (`token`);

--
-- Indexes for table `image_sliders`
--
ALTER TABLE `image_sliders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `login_signup_banners`
--
ALTER TABLE `login_signup_banners`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `newsletters`
--
ALTER TABLE `newsletters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `obcoins`
--
ALTER TABLE `obcoins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `occasions`
--
ALTER TABLE `occasions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orderlists`
--
ALTER TABLE `orderlists`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_prices`
--
ALTER TABLE `product_prices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_ratings`
--
ALTER TABLE `product_ratings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `section_items`
--
ALTER TABLE `section_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shops`
--
ALTER TABLE `shops`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `shops_email_unique` (`email`);

--
-- Indexes for table `shop_password_resets`
--
ALTER TABLE `shop_password_resets`
  ADD KEY `shop_password_resets_email_index` (`email`),
  ADD KEY `shop_password_resets_token_index` (`token`);

--
-- Indexes for table `sliders`
--
ALTER TABLE `sliders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `testimonials`
--
ALTER TABLE `testimonials`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `user_coupons`
--
ALTER TABLE `user_coupons`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `additional_products`
--
ALTER TABLE `additional_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `blogs`
--
ALTER TABLE `blogs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `blog_categories`
--
ALTER TABLE `blog_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `category_images`
--
ALTER TABLE `category_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `cbcoins`
--
ALTER TABLE `cbcoins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `customize_cakes`
--
ALTER TABLE `customize_cakes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `customize_flavours`
--
ALTER TABLE `customize_flavours`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `customize_images`
--
ALTER TABLE `customize_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `customize_shapes`
--
ALTER TABLE `customize_shapes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `delivery_boys`
--
ALTER TABLE `delivery_boys`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `flavours`
--
ALTER TABLE `flavours`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `godowns`
--
ALTER TABLE `godowns`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `image_sliders`
--
ALTER TABLE `image_sliders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `login_signup_banners`
--
ALTER TABLE `login_signup_banners`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `newsletters`
--
ALTER TABLE `newsletters`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `obcoins`
--
ALTER TABLE `obcoins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `occasions`
--
ALTER TABLE `occasions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `orderlists`
--
ALTER TABLE `orderlists`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `product_prices`
--
ALTER TABLE `product_prices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT for table `product_ratings`
--
ALTER TABLE `product_ratings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sections`
--
ALTER TABLE `sections`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `section_items`
--
ALTER TABLE `section_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `shops`
--
ALTER TABLE `shops`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `sliders`
--
ALTER TABLE `sliders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `testimonials`
--
ALTER TABLE `testimonials`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `user_coupons`
--
ALTER TABLE `user_coupons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
