create database country;
use sakila;
DROP TABLE IF EXISTS Customers;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName VARCHAR(255),
    Email VARCHAR(255),
    RegistrationDate DATE,
    City VARCHAR(100),
    Status VARCHAR(50) -- Ví dụ: 'Active', 'Inactive', 'Potential'
);

-- Chèn dữ liệu mẫu
INSERT INTO Customers (CustomerID, FullName, Email, RegistrationDate, City, Status) VALUES
(1, 'Nguyen Van An', 'an.nguyen@email.com', '2023-01-15', 'Ho Chi Minh', 'Active'),
(2, 'Tran Thi Ba', 'ba.tran@email.com', '2023-02-20', 'Hanoi', 'Active'),
(3, 'Le Van Cuong', 'cuong.le@email.com', '2023-02-25', 'Da Nang', 'Inactive'),
(4, 'Pham Thi Dung', 'dung.pham@email.com', '2023-03-10', 'Hanoi', 'Potential'),
(5, 'Hoang Van Em', 'em.hoang@email.com', '2023-04-01', 'Ho Chi Minh', 'Active');

-- ===============================================================
-- 🎯 NHIỆM VỤ 1: THÊM DỮ LIỆU MỚI
-- ===============================================================

INSERT INTO Customers (CustomerID, FullName, Email, RegistrationDate, City, Status)
VALUES (6, 'Ly Thi Giang', 'giang.ly@email.com', '2023-05-20', 'Can Tho', 'Potential');

-- Kiểm tra dữ liệu sau khi thêm
SELECT * FROM Customers;

-- ===============================================================
-- 🎯 NHIỆM VỤ 2: TRUY VẤN & PHÂN TÍCH DỮ LIỆU
-- ===============================================================

-- 2.1 Lấy danh sách tên và email của tất cả khách hàng (gửi bản tin)
SELECT FullName, Email
FROM Customers;

-- 2.2 Liệt kê các thành phố hiện có khách hàng (mỗi thành phố 1 lần)
SELECT DISTINCT City
FROM Customers;

-- 2.3 Danh sách khách hàng đăng ký gần đây nhất (sắp xếp giảm dần theo ngày)
SELECT *
FROM Customers
ORDER BY RegistrationDate DESC;

-- 2.4 Danh sách khách hàng ở Hà Nội
SELECT *
FROM Customers
WHERE City = 'Hanoi';

-- 2.5 Tìm khách hàng ở TP.HCM và có trạng thái 'Active'
SELECT *
FROM Customers
WHERE City = 'Ho Chi Minh' AND Status = 'Active';

-- ===============================================================
-- 🎯 NHIỆM VỤ 3: CẬP NHẬT & XÓA DỮ LIỆU
-- ===============================================================

-- 3.1 Cập nhật trạng thái khách hàng có CustomerID = 3 thành 'Active'
UPDATE Customers
SET Status = 'Active'
WHERE CustomerID = 3;

-- 3.2 Kiểm tra lại xem thay đổi đã thành công chưa
SELECT * FROM Customers WHERE CustomerID = 3;

-- 3.3 Xóa bản ghi của khách hàng có CustomerID = 4
DELETE FROM Customers
WHERE CustomerID = 4;

-- 3.4 Kiểm tra lại danh sách khách hàng sau khi xóa
SELECT * FROM Customers;
