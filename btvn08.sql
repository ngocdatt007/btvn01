create database companydb;

USE sakila;

-- ============================================
-- 🧾 NHIỆM VỤ 1: THÊM MỘT KHÁCH HÀNG MỚI
-- Thông tin khách hàng:
--   Họ tên: ANNA HILL
--   store_id: 2
--   address_id: 5
--   email: ANNA.HILL@sakilacustomer.org
-- ============================================

INSERT INTO customer (store_id, first_name, last_name, email, address_id, active, create_date)
VALUES (2, 'ANNA', 'HILL', 'ANNA.HILL@sakilacustomer.org', 5, 1, NOW());

-- ✅ Ghi chú:
-- Cột `active` được đặt là 1 (đang hoạt động)
-- Cột `create_date` dùng hàm NOW() để tự động lấy thời điểm hiện tại


-- ============================================
-- ✉️ NHIỆM VỤ 2: CẬP NHẬT EMAIL CHO KHÁCH HÀNG TÊN "JENNIFER"
-- Thay thế đuôi email từ "@sakilacustomer.org" → "@sakilacustomer.com"
-- ============================================

UPDATE customer
SET email = REPLACE(email, '@sakilacustomer.org', '@sakilacustomer.com')
WHERE first_name = 'JENNIFER';

-- ✅ Ghi chú:
-- Sử dụng hàm REPLACE() giúp thay đổi phần đuôi email đồng loạt mà không ảnh hưởng đến phần tên phía trước.


-- ============================================
-- 🔒 NHIỆM VỤ 3: KHÓA TẠM THỜI TÀI KHOẢN CỦA KHÁCH HÀNG CÓ ID = 25
-- Thay đổi giá trị cột active thành 0 (tức là tài khoản không hoạt động)
-- ============================================

UPDATE customer
SET active = 0
WHERE customer_id = 25;


-- ============================================
-- 💬 NHẬN XÉT: TẠI SAO NÊN "ĐÁNH DẤU" (SOFT DELETE)
-- THAY VÌ XÓA VĨNH VIỄN (HARD DELETE)?
-- ============================================

/*
==================== PHÂN TÍCH KINH DOANH ====================

Việc "đánh dấu" bản ghi là không hoạt động (soft delete)
được ưu tiên hơn việc xóa vĩnh viễn (hard delete) vì những lý do sau:

1️⃣ Bảo toàn lịch sử dữ liệu:
   - Dữ liệu khách hàng vẫn còn trong hệ thống, giúp theo dõi lịch sử giao dịch, hành vi mua hàng, hoặc khi khách hàng quay lại kích hoạt tài khoản.
   - Tránh mất dữ liệu quan trọng cho các báo cáo tài chính hoặc kiểm toán.

2️⃣ Hỗ trợ phân tích và ra quyết định:
   - Dữ liệu "không hoạt động" vẫn có thể được sử dụng trong phân tích xu hướng rời bỏ khách hàng (churn analysis) hoặc hiệu quả chiến dịch CSKH.
   - Giúp phân biệt giữa “khách hàng ngừng hoạt động” và “khách hàng mới”.

3️⃣ An toàn và dễ phục hồi:
   - Nếu vô tình “khóa nhầm” hoặc khách hàng quay lại yêu cầu mở lại tài khoản, có thể khôi phục dễ dàng chỉ bằng UPDATE.
   - Tránh rủi ro mất dữ liệu vĩnh viễn khi dùng lệnh DELETE.

Tóm lại: 
Soft delete giúp đảm bảo an toàn dữ liệu, hỗ trợ phân tích chuyên sâu, 
và duy trì khả năng khôi phục — điều rất quan trọng trong hệ thống kinh doanh thực tế.

==============================================================
*/
