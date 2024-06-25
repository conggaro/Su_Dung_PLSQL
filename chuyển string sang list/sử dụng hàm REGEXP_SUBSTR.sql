-- trích xuất ra chuỗi '123'
SELECT REGEXP_SUBSTR('abc123xyz', '[0-9]+') AS extracted_substr FROM dual;


-- trích xuất ra chuỗi 'banana'
SELECT REGEXP_SUBSTR('apple,banana,orange', '[^,]+', 1, 2) AS extracted_substr FROM dual;


-- trích xuất ra chuỗi 'AbC'
SELECT REGEXP_SUBSTR('AbCdeFg', 'abc', 1, 1, 'i') AS extracted_substr FROM dual;


Hàm REGEXP_SUBSTR trong Oracle
được sử dụng để trích xuất một chuỗi con
từ một chuỗi ban đầu
dựa trên biểu thức chính quy (regular expression).
Đây là một công cụ mạnh mẽ để làm việc với
các chuỗi ký tự và thực hiện các thao tác phức 
tạp liên quan đến việc khớp mẫu (pattern matching).


Các tham số của hàm REGEXP_SUBSTR:
1. source_string: Chuỗi nguồn mà bạn muốn trích xuất chuỗi con.
2. pattern: Biểu thức chính quy xác định mẫu cần tìm trong chuỗi nguồn.
3. position (tùy chọn): Vị trí bắt đầu tìm kiếm trong chuỗi nguồn (mặc định là 1).
4. occurrence (tùy chọn): Lần xuất hiện của mẫu mà bạn muốn trích xuất (mặc định là 1).
5. match_parameter (tùy chọn): Các tham số điều khiển cách khớp mẫu, chẳng hạn như 'i' cho case-insensitive matching.


-- cách để chuyển chuỗi string
-- thành 1 danh sách
-- như kiểu convert string to list ấy
WITH split_values AS (
    SELECT REGEXP_SUBSTR('1, 662, 650', '[^,]+', 1, LEVEL) AS CUSTOMIZE_ID
    FROM dual
    CONNECT BY REGEXP_SUBSTR('1, 662, 650', '[^,]+', 1, LEVEL) IS NOT NULL
)
SELECT *
FROM HU_ORGANIZATION
WHERE ID IN (
    SELECT CUSTOMIZE_ID
    FROM split_values
);