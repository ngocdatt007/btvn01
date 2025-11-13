create database city;
use sakila;
CREATE DATABASE IF NOT EXISTS PhanTichKhachHang;
USE PhanTichKhachHang;

-- 2️⃣ Tạo bảng KhachHangThanThiet
CREATE TABLE KhachHangThanThiet (
    MaKH INT PRIMARY KEY,
    HoTen VARCHAR(255),
    ThanhPho VARCHAR(100),
    TongChiTieu INT,
    SoDonHang INT,
    LanCuoiMuaHang DATE
);

-- 3️⃣ Thêm dữ liệu mẫu
INSERT INTO KhachHangThanThiet (MaKH, HoTen, ThanhPho, TongChiTieu, SoDonHang, LanCuoiMuaHang) VALUES
(1, 'Nguyễn Thị Mai', 'Hà Nội', 15000000, 12, '2023-10-28'),
(2, 'Trần Văn Nam', 'TP. Hồ Chí Minh', 25000000, 20, '2023-10-15'),
(3, 'Lê Minh Anh', 'Hà Nội', 3000000, 2, '2023-10-05'),
(4, 'Phạm Hồng Nhung', 'Đà Nẵng', 8000000, 8, '2023-05-20'),
(5, 'Hoàng Tuấn Kiệt', 'Hà Nội', 18000000, 15, '2023-09-30'),
(6, 'Vũ Bích Phương', 'TP. Hồ Chí Minh', 4500000, 3, '2023-04-11');

-- =========================
-- 4️⃣ DANH SÁCH KHÁCH HÀNG VIP
-- Điều kiện: TongChiTieu > 10,000,000 VÀ SoDonHang >= 10
-- Sắp xếp theo TongChiTieu giảm dần
SELECT *
FROM KhachHangThanThiet
WHERE TongChiTieu > 10000000
  AND SoDonHang >= 10
ORDER BY TongChiTieu DESC;

-- =========================
-- 5️⃣ KHÁCH HÀNG MỚI TIỀM NĂNG
-- Điều kiện: Ở Hà Nội, SoDonHang < 5, TongChiTieu > 2,000,000
SELECT *
FROM KhachHangThanThiet
WHERE ThanhPho = 'Hà Nội'
  AND SoDonHang < 5
  AND TongChiTieu > 2000000;

-- =========================
-- 6️⃣ KHÁCH HÀNG CẦN "HÂM NÓNG"
-- Điều kiện: LanCuoiMuaHang trước ngày 2023-09-01
SELECT *
FROM KhachHangThanThiet
WHERE LanCuoiMuaHang < '2023-09-01';

-- =========================
