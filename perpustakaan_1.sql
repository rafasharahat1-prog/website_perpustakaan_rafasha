-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 23, 2026 at 03:38 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 7.4.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `perpustakaan_1`
--

-- --------------------------------------------------------

--
-- Table structure for table `anggota`
--

CREATE TABLE `anggota` (
  `id_anggota` int(11) NOT NULL,
  `nama_anggota` varchar(200) NOT NULL,
  `alamat` text NOT NULL,
  `jenis_kelamin` enum('laki-laki','perempuan','','') NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `foto` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `anggota`
--

INSERT INTO `anggota` (`id_anggota`, `nama_anggota`, `alamat`, `jenis_kelamin`, `email`, `password`, `foto`) VALUES
(10, 'Riedone fadillah', 'ciputat', 'laki-laki', '', '', '1778044492_raul.jpg'),
(11, 'lusi', 'bandung', 'perempuan', '', '', '1778649638_Unknown.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `buku`
--

CREATE TABLE `buku` (
  `id_buku` int(100) NOT NULL,
  `judul_buku` varchar(100) NOT NULL,
  `pengarang` varchar(100) NOT NULL,
  `penerbit` varchar(100) NOT NULL,
  `tahun_terbit` year(4) NOT NULL,
  `foto` varchar(100) NOT NULL,
  `status` enum('Di pinjam','Di kembalikan','tersedia','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `buku`
--

INSERT INTO `buku` (`id_buku`, `judul_buku`, `pengarang`, `penerbit`, `tahun_terbit`, `foto`, `status`) VALUES
(5, 'Dark psychology', 'James Clear', 'Jendela penerbit', 2015, '1778043121_Annotation 2024-11-15 082439.png', 'Di pinjam'),
(6, 'Atomic Habits', 'sabrina', 'Avery', 2015, '1778043169_b836ec5bcbc4bfe8ca3225e690939e6e.jpg', 'Di pinjam'),
(9, 'matematika', 'test', 'test', 2010, 'test', 'Di pinjam'),
(10, 'Bahasa', 'test', 'test', 2010, 'test', 'Di pinjam'),
(11, 'The psychology of money', 'morgan housel', 'Harriman house', 2020, 'psychology_of_money.jpg', 'Di pinjam');

--
-- Triggers `buku`
--
DELIMITER $$
CREATE TRIGGER `TRIGGER_INSERT_DATA` AFTER INSERT ON `buku` FOR EACH ROW INSERT INTO log_aktivitas(tugas) VALUES (concat(' User', USER(),' Menambahkan data', New.judul_buku))
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `delete_buku` AFTER DELETE ON `buku` FOR EACH ROW INSERT log_aktivitas(tugas) VALUES (CONCATE(' user', USER(), 'Menghapus data buku ', old.judul_buku))
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_data` AFTER UPDATE ON `buku` FOR EACH ROW BEGIN INSERT Log_aktivitas(tugas) VALUES(CONCAT(' user ', USER(), ' Mengedit buku ', new.judul_buku, 'yang sebelumnya bernama ', old.judul_buku)); END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `log_aktivitas`
--

CREATE TABLE `log_aktivitas` (
  `id_log` int(11) NOT NULL,
  `tugas` varchar(100) DEFAULT NULL,
  `waktu` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `log_aktivitas`
--

INSERT INTO `log_aktivitas` (`id_log`, `tugas`, `waktu`) VALUES
(1, 'Userroot@localhostMenambahkan datatest', '2026-05-18 02:22:13'),
(2, ' Userroot@localhost Menambahkan datatest', '2026-05-18 02:23:54'),
(3, ' Useradmin@localhost Menambahkan dataThe psychology of money', '2026-05-18 03:01:01'),
(4, ' user root@localhost Mengedit buku IPAS', '2026-05-18 03:10:19'),
(5, ' user root@localhost Mengedit buku IPASyang sebelumnya bernama IPAS', '2026-05-18 03:13:29'),
(6, ' user root@localhost Mengedit buku Bahasayang sebelumnya bernama IPAS', '2026-05-18 03:13:53'),
(7, ' user admin@localhost Mengedit buku matematikayang sebelumnya bernama test', '2026-05-18 03:40:05');

-- --------------------------------------------------------

--
-- Table structure for table `peminjaman`
--

CREATE TABLE `peminjaman` (
  `id_peminjaman` int(11) NOT NULL,
  `id_anggota` int(11) NOT NULL,
  `id_buku` int(11) NOT NULL,
  `tgl_peminjaman` varchar(100) NOT NULL,
  `tgl_kembali` varchar(100) DEFAULT NULL,
  `status` enum('pinjam','kembali') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `peminjaman`
--

INSERT INTO `peminjaman` (`id_peminjaman`, `id_anggota`, `id_buku`, `tgl_peminjaman`, `tgl_kembali`, `status`) VALUES
(4, 10, 5, '2026-05-29', NULL, ''),
(7, 10, 11, '2026-05-31', NULL, ''),
(8, 11, 6, '2026-05-10', NULL, ''),
(9, 10, 5, '2026-05-09', NULL, ''),
(10, 10, 5, '2026-05-10', NULL, ''),
(11, 10, 6, '2026-05-16', NULL, ''),
(12, 11, 6, '2026-05-09', NULL, ''),
(13, 10, 5, '2026-05-22', NULL, 'pinjam');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_users` int(11) NOT NULL,
  `nama_user` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) DEFAULT NULL,
  `role` enum('admin','petugas','anggota','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_users`, `nama_user`, `email`, `password`, `role`) VALUES
(1, 'user2', '', '443', 'admin'),
(2, 'agus asep', 'agus@gmail.com', '110409', 'admin'),
(3, 'wowo', 'wowo@gmail.com', '120489', ''),
(4, 'user2', 'user2@gmail.com', '120409', 'petugas'),
(5, 'user3', 'user3@gmail.com', '130409', 'anggota'),
(6, 'admin', 'admin@gmail.com', '0', 'admin'),
(7, 'admin1', 'admin1@gmail.com', '3def184ad8f4755ff269862ea77393dd', 'admin'),
(8, 'admin5', 'admin5@gmail.com', '0', 'admin'),
(9, 'admin5', 'admin5@gmail.com', 'b3c24017adc624ea11347c023ff75ea3b86747f4ccc934d685b485b54dcc662837bac82da409364474ede07c7f98e096c765', 'admin'),
(10, 'ezzar', 'ezzar@gmail.com', '123456', 'admin'),
(11, 'fatan', 'fatan@gmail.com', '123456', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `user2`
--

CREATE TABLE `user2` (
  `id_user2` int(100) NOT NULL,
  `user2_name` varchar(100) DEFAULT NULL,
  `password` varbinary(225) DEFAULT NULL,
  `role` enum('admin','petugas','anggota') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user2`
--

INSERT INTO `user2` (`id_user2`, `user2_name`, `password`, `role`) VALUES
(1, 'admin1', 0x87ca744203a74f0e8a8ccadc92e13d49, 'admin'),
(2, 'anggota1', 0x138a63099ecc94149d603f414e9b743e, 'anggota');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `anggota`
--
ALTER TABLE `anggota`
  ADD PRIMARY KEY (`id_anggota`);

--
-- Indexes for table `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`id_buku`);

--
-- Indexes for table `log_aktivitas`
--
ALTER TABLE `log_aktivitas`
  ADD PRIMARY KEY (`id_log`);

--
-- Indexes for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`id_peminjaman`),
  ADD KEY `id_anggota` (`id_anggota`),
  ADD KEY `id_buku` (`id_buku`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_users`);

--
-- Indexes for table `user2`
--
ALTER TABLE `user2`
  ADD PRIMARY KEY (`id_user2`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `anggota`
--
ALTER TABLE `anggota`
  MODIFY `id_anggota` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `buku`
--
ALTER TABLE `buku`
  MODIFY `id_buku` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `log_aktivitas`
--
ALTER TABLE `log_aktivitas`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `id_peminjaman` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_users` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `user2`
--
ALTER TABLE `user2`
  MODIFY `id_user2` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD CONSTRAINT `peminjaman_ibfk_1` FOREIGN KEY (`id_anggota`) REFERENCES `anggota` (`id_anggota`),
  ADD CONSTRAINT `peminjaman_ibfk_2` FOREIGN KEY (`id_buku`) REFERENCES `buku` (`id_buku`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
