CREATE DATABASE course_management;
USE course_management;
CREATE TABLE Course (
    course_id VARCHAR(10) PRIMARY KEY,
    course_name VARCHAR(100),
    category VARCHAR(100),
    start_date DATE,
    end_date DATE,
    fee DECIMAL(10,2)
);
CREATE TABLE Student (
    student_id VARCHAR(10) PRIMARY KEY,
    student_full_name VARCHAR(150) NOT NULL,
    student_email VARCHAR(255) UNIQUE,
    student_phone VARCHAR(15) UNIQUE,
    student_dob DATE,
    gender ENUM('Nam','Nữ','Khác')
);
CREATE TABLE Enrollment (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(10) NOT NULL,
    course_id VARCHAR(10) NOT NULL,
    enroll_date DATE,
    enrollment_status ENUM('Confirmed','Cancelled','Pending'),
    slot_count INT NOT NULL DEFAULT 1,
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);
CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT NOT NULL,
    payment_method ENUM('Credit Card','Bank Transfer','Cash'),
    payment_amount DECIMAL(10,2),
    payment_date DATE,
    payment_status ENUM('Success','Failed','Pending'),

    CHECK (payment_amount > 0),
    FOREIGN KEY (enrollment_id) REFERENCES Enrollment(enrollment_id)
);
INSERT INTO Student 
VALUES
('S0001','Le Hoang Nam','nam.le@example.com','0901001001','1995-01-01','Nam'),
('S0002','Nguyen Minh Chau','chau.nguyen@example.com','0902002002','1996-02-02','Nữ'),
('S0003','Pham Bao Anh','bao.pham@example.com','0903003003','1997-03-03','Nam'),
('S0004','Tran Kim Lien','lien.tran@example.com','0904004004','1998-04-04','Nữ'),
('S0005','Hoang Tien Dat','dat.hoang@example.com','0905005005','1999-05-05','Nam'),
('S0006','Vo Thi Mai','mai.vo@example.com','0906006006','2000-06-06','Nữ'),
('S0007','Doan Minh Tri','tri.doan@example.com','0907007007','2001-07-07','Nam'),
('S0008','Nguyen Thanh Ha','ha.nguyen@example.com','0908008008','2002-08-08','Nữ'),
('S0009','Trinh Bao Vy','vy.trinh@example.com','0909009009','2003-09-09','Nữ'),
('S0010','Bui Hoang Nam','nam.bui@example.com','0910001010','2004-10-10','Nam');
INSERT INTO Course 
VALUES
('C001','Web Development','Programming','2025-07-01','2025-08-01',120.0),
('C002','Data Analysis','Data Science','2025-07-10','2025-08-15',150.0),
('C003','Basic Photoshop','Design','2025-07-05','2025-07-30',90.0),
('C004','Intro to Marketing','Marketing','2025-07-12','2025-08-20',110.0);
INSERT INTO Enrollment  
 VALUES
(1,'S0001','C001','2025-06-01','Confirmed',1),
(2,'S0002','C002','2025-06-02','Pending',2),
(3,'S0003','C003','2025-06-03','Cancelled',3),
(4,'S0004','C004','2025-06-04','Confirmed',1),
(5,'S0005','C001','2025-06-05','Pending',2),
(6,'S0006','C002','2025-06-06','Cancelled',3),
(7,'S0007','C003','2025-06-07','Confirmed',1),
(8,'S0008','C004','2025-06-08','Pending',2),
(9,'S0009','C001','2025-06-09','Cancelled',3),
(10,'S0010','C002','2025-06-10','Confirmed',1),
(11,'S0001','C003','2025-06-11','Pending',2),
(12,'S0002','C004','2025-06-12','Cancelled',3),
(13,'S0003','C001','2025-06-13','Confirmed',1),
(14,'S0004','C002','2025-06-14','Pending',2),
(15,'S0005','C003','2025-06-15','Cancelled',3),
(16,'S0006','C004','2025-06-16','Confirmed',1),
(17,'S0007','C001','2025-06-17','Pending',2),
(18,'S0008','C002','2025-06-18','Cancelled',3),
(19,'S0009','C003','2025-06-19','Confirmed',1),
(20,'S0010','C004','2025-06-20','Pending',2);
INSERT INTO Payment (payment_id, enrollment_id, payment_method, payment_amount, payment_date, payment_status) 
VALUES
(1,1,'Credit Card',120.0,'2025-06-01','Success'),
(2,2,'Bank Transfer',150.0,'2025-06-02','Failed'),
(3,3,'E-wallet',90.0,'2025-06-03','Pending'),
(4,4,'Credit Card',110.0,'2025-06-04','Success'),
(5,5,'Cash',120.0,'2025-06-05','Pending'),
(6,6,'E-wallet',150.0,'2025-06-06','Success'),
(7,7,'Credit Card',90.0,'2025-06-07','Failed'),
(8,8,'Bank Transfer',110.0,'2025-06-08','Pending'),
(9,9,'Cash',120.0,'2025-06-09','Success'),
(10,10,'Credit Card',150.0,'2025-06-10','Pending');
ALTER TABLE Payment MODIFY payment_method 
ENUM('Credit Card','Bank Transfer','Cash','E-wallet');
ALTER TABLE Payment
MODIFY COLUMN payment_amount DECIMAL(10,2) CHECK (payment_amount > 0);
START TRANSACTION;
UPDATE Payment
SET payment_status = 'Success'
WHERE payment_method = 'Credit Card'
  AND payment_amount > 0
  AND payment_date < CURRENT_DATE;
UPDATE Payment
SET payment_status = 'Pending'
WHERE payment_method = 'Bank Transfer'
  AND payment_amount < 100
  AND payment_date < CURRENT_DATE;
DELETE FROM Payment
WHERE payment_status = 'Pending'
  AND payment_method = 'Cash';
COMMIT;
SELECT student_id, student_full_name, student_email, student_dob, gender
FROM Student
ORDER BY student_full_name ASC
LIMIT 5;
SELECT course_id, course_name, category, fee
FROM Course
ORDER BY fee DESC;
SELECT s.student_id, s.student_full_name, e.course_id, e.enrollment_status
FROM Enrollment e
JOIN Student s ON e.student_id = s.student_id
WHERE e.enrollment_status = 'Cancelled';
SELECT e.course_id, e.student_id, c.course_name, e.slot_count
FROM Enrollment e
JOIN Course c ON e.course_id = c.course_id
WHERE e.enrollment_status = 'Confirmed'
ORDER BY e.slot_count DESC;
SELECT e.course_id, s.student_id, s.student_full_name, c.course_name, e.slot_count
FROM Enrollment e
JOIN Student s ON e.student_id = s.student_id
JOIN Course c ON e.course_id = c.course_id
WHERE e.slot_count BETWEEN 2 AND 3
ORDER BY s.student_full_name;
SELECT DISTINCT s.student_id, s.student_full_name, e.enrollment_id, e.slot_count, p.payment_status
FROM Enrollment e
JOIN Student s ON e.student_id = s.student_id
JOIN Payment p ON p.enrollment_id = e.enrollment_id
WHERE e.slot_count >= 2
  AND p.payment_status = 'Pending';
SELECT s.student_id, s.student_full_name, SUM(p.payment_amount) AS total_paid_success
FROM Student s
JOIN Enrollment e ON s.student_id = e.student_id
JOIN Payment p ON p.enrollment_id = e.enrollment_id
WHERE p.payment_status = 'Success'
GROUP BY s.student_id, s.student_full_name
ORDER BY total_paid_success DESC;
SELECT s.student_id, s.student_full_name, e.slot_count, e.enrollment_status
FROM Enrollment e
JOIN Student s ON e.student_id = s.student_id
WHERE e.slot_count > 1
ORDER BY e.slot_count DESC
LIMIT 5;
SELECT c.course_id, c.course_name, COUNT(e.enrollment_id) AS registrations
FROM Course c
LEFT JOIN Enrollment e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
ORDER BY registrations DESC
LIMIT 1;
SELECT DISTINCT s.student_id, s.student_full_name, s.student_dob, s.student_email
FROM Student s
JOIN Enrollment e ON s.student_id = e.student_id
JOIN Payment p ON p.enrollment_id = e.enrollment_id
WHERE s.student_dob < '2000-01-01'
  AND p.payment_status = 'Success';
  