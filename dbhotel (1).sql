-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 28, 2022 at 05:28 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbhotel`
--

-- --------------------------------------------------------

--
-- Table structure for table `fasilitas_hotel`
--

CREATE TABLE `fasilitas_hotel` (
  `id_fasilitas_hotel` int(10) NOT NULL,
  `nama_fasilitas` varchar(50) NOT NULL,
  `deskripsi` varchar(500) NOT NULL,
  `foto` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `fasilitas_hotel`
--

INSERT INTO `fasilitas_hotel` (`id_fasilitas_hotel`, `nama_fasilitas`, `deskripsi`, `foto`) VALUES
(15, 'Sauna', 'Kayu yang dipilih oleh konsumen dominan dengan kayu pinus yang mempunyai ciri aroma terapi', 'sauna.jpg'),
(21, 'Gym', 'Luas dan nyaman', 'gym_1.jpg'),
(22, 'Kolam Renang', 'Sangat luas dan disertai pemandangan yang indah', 'kolam renang2.jpg'),
(23, 'Tempat parkir', 'Luas dan nyaman', 'parkir.jpg'),
(24, 'Restoran hotel', 'Luas dan menyediakan berbagai makanan yang sangat lezat', 'restoran.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `petugas`
--

CREATE TABLE `petugas` (
  `id_petugas` int(11) NOT NULL,
  `username` varchar(25) NOT NULL,
  `password` char(32) NOT NULL,
  `nama_petugas` varchar(35) NOT NULL,
  `level` enum('admin','resepsionis') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `petugas`
--

INSERT INTO `petugas` (`id_petugas`, `username`, `password`, `nama_petugas`, `level`) VALUES
(1236, 'admin', '81dc9bdb52d04dc20036dbd8313ed055', 'apin', 'admin'),
(1234567, 'resepsionis', '202cb962ac59075b964b07152d234b70', 'apin', 'resepsionis');

-- --------------------------------------------------------

--
-- Table structure for table `reservasi`
--

CREATE TABLE `reservasi` (
  `id_reservasi` int(10) NOT NULL,
  `tipe_kamar` varchar(200) NOT NULL,
  `nik` varchar(25) NOT NULL,
  `nama_pemesan` varchar(30) NOT NULL,
  `email_pemesan` varchar(50) NOT NULL,
  `nama_tamu` varchar(50) NOT NULL,
  `no_telp` int(15) NOT NULL,
  `cek-in` date NOT NULL,
  `cek-out` date NOT NULL,
  `jumlah_kamar` int(10) NOT NULL,
  `harga_kamar` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `status` tinytext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `reservasi`
--

INSERT INTO `reservasi` (`id_reservasi`, `tipe_kamar`, `nik`, `nama_pemesan`, `email_pemesan`, `nama_tamu`, `no_telp`, `cek-in`, `cek-out`, `jumlah_kamar`, `harga_kamar`, `total`, `status`) VALUES
(35, 'Superior Room', '64378', 'ai', 'a@gmail.com', 'nuwoo', 89765, '2022-05-23', '2022-05-24', 1, 5000000, 0, 'selesai'),
(36, 'Standar Room', '987654', 'afina', 'fida@gmail.com', 'afina', 8763523, '2022-05-24', '2022-05-25', 1, 1000000, 0, ''),
(37, 'Standar Room', '64378', 'mingyu', 'hahaha@gmail.com', 'fida', 8763523, '2022-05-24', '2022-05-25', 1, 1000000, 0, '');

--
-- Triggers `reservasi`
--
DELIMITER $$
CREATE TRIGGER `triger_hotel` AFTER UPDATE ON `reservasi` FOR EACH ROW BEGIN
if new.status='cek-in' THEN UPDATE tbl_kamar set jumlahkamar=jumlahkamar-old.jumlah_kamar
WHERE no_kamar = old.id_reservasi;
END IF;
if new.status='cek-out' THEN UPDATE tbl_kamar set jumlahkamar=jumlahkamar-old.jumlah_kamar
WHERE no_kamar = old.id_reservasi;
END IF;
if new.status='selesai' THEN UPDATE tbl_kamar set jumlahkamar=jumlahkamar-old.jumlah_kamar
WHERE no_kamar = old.id_reservasi;
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tamu`
--

CREATE TABLE `tamu` (
  `nik` int(32) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` char(32) NOT NULL,
  `alamat` text NOT NULL,
  `no_tlp` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tamu`
--

INSERT INTO `tamu` (`nik`, `nama`, `email`, `password`, `alamat`, `no_tlp`) VALUES
(3209999, 'fida', 'fida@gmail.com', '202cb962ac59075b964b07152d234b70', 'kuningan', 896),
(819218387, 'afina', 'afina@gmail.com', '202cb962ac59075b964b07152d234b70', 'kuningan', 89767);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_kamar`
--

CREATE TABLE `tbl_kamar` (
  `no_kamar` char(11) NOT NULL,
  `tipe_kamar` varchar(50) NOT NULL,
  `deskripsi` varchar(500) NOT NULL,
  `harga_kamar` int(100) NOT NULL,
  `jumlahkamar` int(10) NOT NULL,
  `fasilitas_kamar` varchar(50) NOT NULL,
  `status_kamar` enum('tersedia','dipesan','ditempat') NOT NULL,
  `foto` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_kamar`
--

INSERT INTO `tbl_kamar` (`no_kamar`, `tipe_kamar`, `deskripsi`, `harga_kamar`, `jumlahkamar`, `fasilitas_kamar`, `status_kamar`, `foto`) VALUES
('101', 'Standar Room', 'terdapat single bed dengan fasilitas standar, seperti televisi, AC, telepon, toilet, meja.', 1000000, 10, 'Wifi,AC', 'tersedia', 'standar.jpg'),
('102', 'Superior Room', 'Kamar dengan tempat tidur ukuran Twin yang besar, kamar mandi mewah dengan pilihan rain shower  atau handshower ', 2000000, 10, 'Televisi', 'tersedia', 'superior1.jpg'),
('103', 'Deluxe Room', 'Kamar yang luas dengan tempat tidur ber ukuran King Size, kamar mandi dengan wastafel ganda, interior yang bagus serta fasilitas tambahan di dalam kamar yang akan membuat pengalaman menginap Anda akan sangat menyenangkan.', 4000000, 10, 'Televisi kabel, pengering rambut', 'tersedia', 'deluxe1.jpg'),
('104', 'Presidential Suite', 'Kamar dengan pilihan tempat tidur berukuran King Size yang besar dan Twin, kamar mandi dengan pilihan rain shower  atau hand shower, Presidential suite adalah tipe Kamar yang memiliki fasilitas lengkap dan disediakan untuk tamu yang menyukai privasi.', 7000000, 10, 'layanan pribadi (butler)', 'tersedia', 'presidential1.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `fasilitas_hotel`
--
ALTER TABLE `fasilitas_hotel`
  ADD PRIMARY KEY (`id_fasilitas_hotel`);

--
-- Indexes for table `petugas`
--
ALTER TABLE `petugas`
  ADD PRIMARY KEY (`id_petugas`);

--
-- Indexes for table `reservasi`
--
ALTER TABLE `reservasi`
  ADD PRIMARY KEY (`id_reservasi`),
  ADD KEY `id_kamar` (`tipe_kamar`);

--
-- Indexes for table `tamu`
--
ALTER TABLE `tamu`
  ADD PRIMARY KEY (`nik`);

--
-- Indexes for table `tbl_kamar`
--
ALTER TABLE `tbl_kamar`
  ADD PRIMARY KEY (`no_kamar`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `fasilitas_hotel`
--
ALTER TABLE `fasilitas_hotel`
  MODIFY `id_fasilitas_hotel` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `petugas`
--
ALTER TABLE `petugas`
  MODIFY `id_petugas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1234568;

--
-- AUTO_INCREMENT for table `reservasi`
--
ALTER TABLE `reservasi`
  MODIFY `id_reservasi` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
