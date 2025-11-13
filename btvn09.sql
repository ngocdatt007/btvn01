create database new_table;
use quanlynhansu;
-- ============================================
-- Cơ sở dữ liệu: sakila
-- Người thực hiện: Quản lý Marketing
-- Ngày thực hiện: (ghi ngày chạy)
-- ============================================

USE sakila;

-- ============================================
-- 🎯 NHIỆM VỤ 1: XÁC ĐỊNH DANH SÁCH PHIM ÁP DỤNG KHUYẾN MÃI
-- Điều kiện:
--   1️⃣ rating = 'PG' hoặc 'G'
--   2️⃣ length > 100
--   3️⃣ rental_rate >= 2.99
-- ============================================

SELECT 
    film_id, 
    title, 
    rating, 
    length, 
    rental_rate
FROM film
WHERE (rating = 'PG' OR rating = 'G')
  AND length > 100
  AND rental_rate >= 2.99
ORDER BY rental_rate DESC;

-- ✅ Mục đích:
-- Kiểm tra trước các phim đủ điều kiện giảm giá 50%.


-- ============================================
-- 💰 NHIỆM VỤ 2: THỰC THI CHIẾN DỊCH GIẢM GIÁ
-- Giảm 50% giá thuê (rental_rate) cho các phim ở trên.
-- ============================================

UPDATE film
SET rental_rate = rental_rate / 2
WHERE (rating = 'PG' OR rating = 'G')
  AND length > 100
  AND rental_rate >= 2.99;

-- ✅ Lưu ý:
-- Luôn đảm bảo mệnh đề WHERE chính xác để tránh ảnh hưởng đến toàn bộ bảng dữ liệu.


-- ============================================
-- 🧠 NHIỆM VỤ 3: PHÂN TÍCH RỦI RO & KẾ HOẠCH HOÀN TÁC
-- ============================================

/*
=====================================================
🎯 PHÂN TÍCH RỦI RO & KẾ HOẠCH HOÀN TÁC
=====================================================

1️⃣ RỦI RO LỚN NHẤT:
   - Nếu chạy câu lệnh UPDATE mà **không có mệnh đề WHERE**, 
     toàn bộ bảng `film` sẽ bị giảm giá 50%.
   - Hậu quả:
     → Mọi bộ phim, bao gồm cả phim mới hoặc phim nổi tiếng, đều bị giảm giá.
     → Doanh thu thuê phim giảm mạnh, ảnh hưởng trực tiếp đến lợi nhuận.
     → Dữ liệu giá bị sai lệch, gây mất uy tín và khó khôi phục lại mức giá ban đầu.

-----------------------------------------------------

2️⃣ KẾ HOẠCH HOÀN TÁC (ROLLBACK PLAN):
   Nếu phát hiện lỗi sau khi cập nhật, có thể khôi phục giá thuê cũ 
   bằng cách nhân đôi lại giá hiện tại cho các phim đã bị ảnh hưởng.

   Ví dụ:
   UPDATE film
   SET rental_rate = rental_rate * 2
   WHERE (rating = 'PG' OR rating = 'G')
     AND length > 100
     AND rental_rate < 2.99;  -- giả sử sau giảm, giá nhỏ hơn 2.99

   - Lệnh trên “đảo ngược” tác động của phép chia /2 bằng phép nhân *2.
   - Giới hạn trong phạm vi phim bị giảm để tránh sai lệch dữ liệu khác.

-----------------------------------------------------
   - Trong quản trị dữ liệu chuyên nghiệp, mọi thay đổi lớn (bulk update)
     đều phải có **kế hoạch rollback**.
   - Việc này giúp:
     • Đảm bảo tính toàn vẹn dữ liệu khi có lỗi phát sinh.
     • Tiết kiệm thời gian khôi phục thay vì phải khôi phục từ bản sao lưu toàn bộ hệ thống.
     • Giảm rủi ro gián đoạn hoạt động kinh doanh.

-----------------------------------------------------

   💡 Tạo thêm cột `original_rental_rate` trong bảng film:
      ALTER TABLE film ADD COLUMN original_rental_rate DECIMAL(4,2);
   
   💡 Trước khi giảm giá:
      UPDATE film 
      SET original_rental_rate = rental_rate
      WHERE (rating = 'PG' OR rating = 'G')
        AND length > 100
        AND rental_rate >= 2.99;

   → Cách này giúp lưu lại giá gốc, đảm bảo an toàn tuyệt đối và dễ dàng khôi phục.

=====================================================
*/
