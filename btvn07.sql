create database hayhay;
use new_schema;
-- ============================================
-- 📊 BÁO CÁO PHÂN TÍCH GIAO DỊCH - CSDL SAKILA
-- Người thực hiện: Thực tập sinh Phân tích Kinh doanh
-- Ngày thực hiện: (ghi ngày chạy)
-- ============================================

USE sakila;

-- ============================================
-- 🧾 NHIỆM VỤ 1: DANH SÁCH CÁC GIAO DỊCH CÓ GIÁ TRỊ CAO
-- Điều kiện:
-- - Giao dịch sau ngày 2005-08-01
-- - amount > 9.00
-- - Sắp xếp theo amount giảm dần (DESC)
-- ============================================

SELECT 
    customer_id,
    amount,
    payment_date
FROM payment
WHERE payment_date > '2005-08-01'
  AND amount > 9.00
ORDER BY amount DESC;

-- ============================================
-- ⚠️ NHIỆM VỤ 2: TÌM KIẾM CÁC GIAO DỊCH BẤT THƯỜNG
-- Điều kiện:
-- - amount = 0.00
--   HOẶC
-- - staff_id = 1 VÀ amount > 10.00
-- Hiển thị các cột: payment_id, customer_id, staff_id, amount
-- Sắp xếp theo customer_id tăng dần
-- ============================================

SELECT 
    payment_id,
    customer_id,
    staff_id,
    amount
FROM payment
WHERE amount = 0.00
   OR (staff_id = 1 AND amount > 10.00)
ORDER BY customer_id ASC;

-- ============================================
-- 💬 NHIỆM VỤ 3: PHÂN TÍCH VÀ NHẬN ĐỊNH
-- Viết nhận xét trong comment dưới đây
-- ============================================

/*
==================== NHẬN ĐỊNH & PHÂN TÍCH ====================

🧍‍♀️ 1. Khách hàng VIP:
Các giao dịch có giá trị lớn (> 9.00) thường đến từ nhóm khách hàng chi tiêu cao,
có thể là những người thuê phim thường xuyên hoặc thuê nhiều DVD cùng lúc.
Việc sắp xếp theo `amount DESC` giúp nhanh chóng nhận diện các khách hàng chi tiêu lớn nhất,
từ đó hỗ trợ việc lập danh sách khách hàng VIP để triển khai các chương trình tri ân hoặc ưu đãi đặc biệt.

⚠️ 2. Giao dịch Bất thường:
Các giao dịch có `amount = 0.00` có thể là:
- Giao dịch khuyến mãi (miễn phí thuê DVD, phiếu giảm giá)
- Hoặc lỗi hệ thống (ví dụ: ghi nhận thanh toán không chính xác)
Quản lý cần quan tâm đến những trường hợp này để phân biệt giữa “khuyến mãi hợp lệ”
và “lỗi ghi nhận thanh toán”, đảm bảo tính minh bạch và chính xác của báo cáo tài chính.

👨‍💼 3. Hiệu suất Nhân viên:
Kết quả cho thấy nhân viên có `staff_id = 1` xử lý các giao dịch giá trị cao (>10.00),
đây có thể là dấu hiệu tốt — nhân viên này có thể đang phục vụ khách hàng VIP hoặc các giao dịch lớn.
Tuy nhiên, để kết luận chắc chắn, cần thêm dữ liệu về:
- Tổng số giao dịch mỗi nhân viên xử lý
- Tỷ lệ hoàn thành / sai sót
- Phản hồi từ khách hàng
Từ đó mới có thể đánh giá toàn diện về hiệu suất của nhân viên này.

===============================================================
*/
