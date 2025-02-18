# ODAC là gì?
Oracle Data Access Components

# Sử dụng biến
<pre>
declare
    x number := 10;
    y nvarchar2(50) := 'Hello';
begin
    DBMS_OUTPUT.PUT_LINE('Value of x: ' || x);
    DBMS_OUTPUT.PUT_LINE('Value of y: ' || y);
end;
</pre>
<br>

<pre>
declare
    -- v là viết tắt của variable
    v_code nvarchar2(100);
begin
    select employee_code into v_code
    from hu_employee
    where employee_code = 'H2403040004';

    DBMS_OUTPUT.PUT_LINE('Employee code: ' || v_code);
end;
</pre>

# Sử dụng thẻ "pre" trước khi dán code

# Nếu bạn thích in ra màn hình số 1
<pre>
    SELECT 1
    FROM dual;
</pre>

Trong Oracle SQL, bảng dual là một bảng ảo có sẵn, có một cột và một hàng duy nhất, được sử dụng để thực hiện các phép toán hoặc câu lệnh không cần dữ liệu từ bảng thực tế.
<br>

Việc sử dụng dual trong câu lệnh SELECT 1 là một cách tiêu biểu để thực hiện một câu lệnh SELECT không cần dữ liệu từ bảng thực tế.
<br>

Kết quả của câu lệnh SELECT 1 FROM dual sẽ trả về một cột duy nhất với một hàng duy nhất, giá trị của cột này là 1.

# Hàm chuyển string sang date trong Oracle
<pre>
    select to_date('2004-01-31', 'yyyy-MM-dd')
    from dual;
</pre>

# Hàm chuyển date sang string trong Oracle
<pre>
    declare
        v_date date := to_date('2004-01-31', 'yyyy-MM-dd');
        v_string varchar2(20);
    begin
        -- sử dụng hàm to_char()
        v_string := to_char(v_date, 'dd-MM-yyyy');
        
        -- in kết quả ra màn hình output
        DBMS_OUTPUT.PUT_LINE('Date as string: ' || v_string);
    end;
</pre>

# Tính khoảng cách giữa 2 ngày
<pre>
    -- tính khoảng cách giữa
    -- ngày 31/01/2024
    -- và ngày 01/01/2024
    select date '2024-01-31' - date '2024-01-01' as DISTANCE
    from dual;
</pre>

# Hàm chuyển chữ thường thành chữ hoa
<pre>
    select upper('hello')
    from dual;
</pre>

# Hàm chuyển chữ hoa thành chữ thường
<pre>
    select lower('HELLO')
    from dual;
</pre>

# Tận dụng biến
<pre>declare
    v_id number;
    
    -- định nghĩa biến kiểu varchar2 (chuỗi)
    v_other_table_value varchar2(50);
begin
    select EMPLOYEE_ID into v_id
    from SE_USER
    where USERNAME = upper('nva');
    
    -- sử dụng biến v_id trong truy vấn khác
    select FULLNAME_VN into v_other_table_value
    from HU_EMPLOYEE
    where ID = v_id; -- sử dụng v_id làm tham số cho câu where

    -- làm việc với giá trị từ bảng khác
    DBMS_OUTPUT.PUT_LINE(N'In ra màn hình: ' || v_other_table_value);
    
    
    -- để thực thi câu lệnh
    -- thì bấm F8 trong phần mềm PL SQL
end;</pre>

# Lấy bản ghi đầu tiên (giống select top 1)
<pre>-- cách 1:
select *
from HU_EMPLOYEE
where rownum = 1;


-- cách 2:
select *
from HU_EMPLOYEE
fetch next 1 rows only;</pre>

# Sử dụng CASE WHEN
<pre>-- nếu EXPIRE_DATE khác null
-- thì điền giá trị
-- nếu nó là null thì điền chuỗi rỗng
case
    when b1.EXPIRE_DATE is not null then to_char(b1.EXPIRE_DATE, 'dd/MM/yyyy')
    else ''
end as EXPIRE_YEAR</pre>

# Chuyển string sang danh sách
<pre>WITH split_values AS (
    SELECT REGEXP_SUBSTR('1, 662, 650', '[^,]+', 1, LEVEL) AS CUSTOMIZE_ID
    FROM dual
    CONNECT BY REGEXP_SUBSTR('1, 662, 650', '[^,]+', 1, LEVEL) IS NOT NULL
)
SELECT *
FROM HU_ORGANIZATION
WHERE ID IN (
    SELECT CUSTOMIZE_ID
    FROM split_values
);</pre>

# Truy vấn đệ quy trong Oracle với "START WITH"
<pre>SELECT column1, column2, ...
FROM table_name
START WITH condition
CONNECT BY PRIOR parent_column = child_column;</pre>

<br>
Tóm tắt<br>
START WITH là một phần quan trọng trong các truy vấn đệ quy trong Oracle.<br>
Nó cho phép bạn bắt đầu từ một điểm gốc trong cấu trúc cây và truy xuất tất cả các hàng con liên quan.<br>
Kết hợp với CONNECT BY, nó giúp xây dựng mối quan hệ giữa các hàng trong bảng.<br>

# Lấy năm, lấy tháng
<pre>select extract(month from TER_EFFECT_DATE) as MONTH,
       extract(year from TER_EFFECT_DATE) as YEAR
from   HU_EMPLOYEE
where  TER_EFFECT_DATE is not null</pre>

# Chuyển giá trị của các bản ghi thành một chuỗi danh sách, kèm theo ký tự phân tách "LISTAGG"
<pre>select listagg(b1.FULLNAME, ', ') within group (order by b1.ID asc) as LIST_NAME
from HU_EMPLOYEE b1
where rownum <= 10;</pre>

# Chuyển number sang varchar2
<pre>select to_char(12345) as number_as_string
from dual;</pre>

# Chuyển varchar2 sang number
<pre>select to_number('12345') as number_value
from dual;</pre>

<br>

<pre>select to_number('123,456,789.67', '999G999G999D99') as number_value
from dual;</pre>

# Thủ tục trong Oracle
<pre>PROCEDURE GET_EMPLOYEE_BY_ID(P_ID IN NUMBER,
                              P_CODE IN VARCHAR2,
                              P_CUR OUT CURSOR_TYPE) IS
    P_SQL VARCHAR2(10000);
  BEGIN
    P_SQL := 'select *
              from HU_EMPLOYEE
              where ID = ' || to_char(P_ID) || ' and CODE = ''' || P_CODE || '''';
              
    -- in ra bien P_ID
    dbms_output.put_line('P_ID: ' || P_ID);
    
    -- in ra bien P_CODE
    dbms_output.put_line('P_CODE: ' || P_CODE);
    
    -- in bien P_SQL ra man hinh
    dbms_output.put_line('P_SQL: ' || P_SQL);
    
    -- mo con tro P_CUR
    OPEN P_CUR FOR P_SQL;
  END;</pre>

# Hàm SYS_GUID()
Hàm SYS_GUID() trong Oracle được sử dụng để tạo ra một giá trị GUID (Globally Unique Identifier) duy nhất, dưới dạng chuỗi nhị phân 16 byte. GUID được sử dụng để đảm bảo rằng mỗi giá trị sinh ra là hoàn toàn độc lập và không trùng lặp, ngay cả khi chúng được tạo ra trên nhiều hệ thống khác nhau.
<br>
<pre>SELECT SYS_GUID() AS unique_id
FROM dual;
</pre>
<br>
<pre>INSERT INTO my_table (id, name)
VALUES (SYS_GUID(), 'John Doe');
</pre>

# Xếp hạng bằng hàm RANK()
<pre>SELECT EMPLOYEE_ID,
       SALARY, 
       RANK() OVER (ORDER BY SALARY DESC) AS rank
FROM EMPLOYEES;
</pre>

# Sử dụng WITH
<pre>-- sử dụng with để có 2 bảng tạm
with CommonTableExpressions as (
    select *
    from HU_EMPLOYEE
),
ho as (
    select *
    from HU_ORGANIZATION
)

-- bắt đầu select 2 bảng tạm
select     b1.ID,
           b1.FULLNAME,
           b2.NAME
from       CommonTableExpressions b1
left join  ho b2
on         b1.ORG_ID = b2.ID

-- lấy 10 bản ghi đầu tiên
where rownum <= 10;</pre>

# Lấy dữ liệu ở cột A rồi update cho cột B
<pre>-- tạo bảng
create table test_table (
       num_left number,
       num_final number
);

-- thêm bản ghi
insert into test_table (num_left) values (1);
insert into test_table (num_left) values (2);
insert into test_table (num_left) values (3);
insert into test_table (num_left) values (4);
insert into test_table (num_left) values (5);

-- lấy tất cả bản ghi
select *
from test_table;

-- lấy các giá trị ở cột num_left
-- để update cho cột num_final
update test_table
set num_final = num_left * 2;

-- thiết lập lại giá trị cho cột num_final
update test_table
set num_final = null;

-- thử update kiểu sum
update test_table
set num_final = (select sum(num_left) from test_table);

-- xóa bảng test_table
drop table test_table;</pre>

# Xem tên cột và kiểu dữ liệu của cột trong bảng
<pre>SELECT COLUMN_NAME, DATA_TYPE, DATA_LENGTH, DATA_PRECISION, DATA_SCALE, OWNER
FROM ALL_TAB_COLUMNS
WHERE TABLE_NAME = 'PA_PAYROLLSHEET_DTL_1890'
      AND OWNER = 'TENANTDB1'; -- Thay SCHEMA_NAME bằng tên schema của bạn (nếu cần)</pre>
<br>
COLUMN_NAME: Tên của cột trong bảng.<br>
DATA_TYPE: Kiểu dữ liệu của cột (ví dụ: VARCHAR2, NUMBER, DATE).<br>
DATA_LENGTH: Độ dài của cột (áp dụng cho kiểu VARCHAR2, CHAR).<br>
DATA_PRECISION và DATA_SCALE: Độ chính xác và thang đo (áp dụng cho kiểu NUMBER).<br>

# Sử dụng con trỏ
<pre>CREATE OR REPLACE PACKAGE Payroll_Pkg AS
  -- Khai báo thủ tục trong package
  PROCEDURE Print_XLLD;
END Payroll_Pkg;</pre>

<br>

<pre>CREATE OR REPLACE PACKAGE BODY Payroll_Pkg AS
    PROCEDURE Print_XLLD IS
        -- khai bao bien de xem log
        P_NUM_LOG           NUMBER;
        P_TEXT_LOG          VARCHAR2(100);

        -- tuy chinh con tro de in ra man hinh
        CURSOR c999 IS
            SELECT  XLLD
            FROM    PA_PAYROLLSHEET_DTL_1890
            WHERE   EMPLOYEE_ID in (
                        SELECT DISTINCT EMPLOYEE_ID
                        FROM PA_EMPLOYEE_TEMP
                    )
                    AND PERIOD_ID = 3922; -- tháng 8
        
        v_XLLD c999%ROWTYPE;

    BEGIN
        SELECT COUNT(*)
        INTO P_NUM_LOG
        FROM PA_PAYROLLSHEET_DTL_1890;

        IF P_NUM_LOG > 0 THEN
            OPEN c999;
                LOOP
                    FETCH c999
                    INTO v_XLLD;
                    EXIT WHEN c999%NOTFOUND;
                
                    P_TEXT_LOG := v_XLLD.XLLD;
                    DBMS_OUTPUT.PUT_LINE('XLLD: ' || P_TEXT_LOG);
                END LOOP;
            CLOSE c999;
        END IF;
    END Print_XLLD;
END Payroll_Pkg;</pre>

# Clone bảng trong Oracle
<pre>CREATE TABLE Test2 AS 
SELECT * 
FROM PA_PAYROLLSHEET_SUM_1890 
WHERE 1=0;</pre>
<br>
WHERE 1=0 đảm bảo rằng không có bản ghi nào được sao chép từ PA_PAYROLLSHEET_SUM_1890 sang Test2, chỉ cấu trúc bảng được sao chép.

# Xóa dấu phẩy ở cuối của chuỗi text
<pre>SELECT REGEXP_REPLACE('ok,ko,ko,', ',$', '') AS result
FROM dual;</pre>

# Câu lệnh tạo sequence
<pre>-- Tạo sequence mới cho bảng REPORT_SHEET_SUM
CREATE SEQUENCE REPORT_SHEET_SUM_SEQ
START WITH 1  -- Hoặc số bạn muốn bắt đầu
INCREMENT BY 1;</pre>

# Sửa kiểu dữ liệu của cột
<pre>ALTER TABLE PA_PAYROLLSHEET_SUM_1890
MODIFY TAX5 NUMBER</pre>

# Đánh số thứ tự
<pre>SELECT 
    ROW_NUMBER() OVER (ORDER BY YourColumn) AS RowNum, 
    *
FROM 
    YourTable;</pre>

# Vòng lặp for trong stored procedure
<pre>FOR C IN (SELECT * FROM AT_TIMESHEET_MONTHLY_DTL WHERE EMPLOYEE_ID = 43589
) LOOP
        dbms_output.put_line('P_TEXT :' || P_TEXT);
END LOOP;</pre>

# Bắt ngoại lệ Exception
<pre>PROCEDURE REPORT_TEST(P_TENANT_ID  IN NUMBER)
IS
  v_number NUMBER;
BEGIN
  FOR C IN (SELECT * FROM HU_SALARY_TYPE
  ) LOOP
    dbms_output.put_line('Test log :' || C.ID);
  END LOOP;

	-- Gi? s? x?y ra l?i chia cho 0
  v_number := 10 / 0;
      
  DBMS_OUTPUT.PUT_LINE('This line will not be executed due to the error.');

EXCEPTION
      WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;</pre>

# Hàm Trunc() bỏ phần thập phân
<pre>SELECT TRUNC(1.5555) AS XOA_PHAN_THAP_PHAN
FROM DUAL</pre>

Cho giá trị "31/01/2004 22:35:59" kiểu DateTime, nếu dùng hàm Trunc() thì nó sẽ trả về Date, nó trả về trông như này "31/01/2004"

# Format ngày giờ - định dạng ngày giờ
<pre>SELECT to_date('18/11/2024 22:35:59', 'dd/MM/yyyy HH24:MI:SS')
FROM DUAL</pre>

# In ra thời gian mỗi khi Debug
<pre>DBMS_OUTPUT.PUT_LINE('Run into here: ' || TO_CHAR(SYSDATE,'MI:SS'));</pre>

# Cây có bậc
<pre>SELECT 
    TO_NCHAR(RPAD(' ', 5 * (LEVEL - 1), '    ') || O.NAME) AS NAME,
    O.ID,
    LEVEL AS TREE_LEVEL -- Cột hiển thị bậc của cây
FROM 
    HU_ORGANIZATION O
WHERE 
    TENANT_ID = 1890
START WITH 
    O.ID = 3201 -- Bao gồm phòng ban gốc
CONNECT BY 
    PRIOR O.ID = O.PARENT_ID;
</pre>

# Câu lệnh tạo sequence phần 2
<pre> 
CREATE SEQUENCE seq_hu_employee_tmp_id
START WITH 1    -- Giá trị bắt đầu
INCREMENT BY 1  -- Giá trị tăng thêm
NOCACHE;        -- Không lưu trữ giá trị tạm thời
 </pre>

# Câu lệnh thêm khóa chính
<pre>ALTER TABLE AT_WORKSIGN_TMP
ADD CONSTRAINT pk_at_worksign_tmp_id PRIMARY KEY (id);</pre>

# Cấu hình tự động tăng cho ID sau khi tạo sequence
<pre>ALTER TABLE AT_WORKSIGN_TMP
MODIFY ID DEFAULT seq_hu_employee_tmp_id.NEXTVAL;</pre>

# Dùng OFFSET để bỏ qua n dòng đầu tiên
<pre>SELECT * FROM table_name
ORDER BY column_name
OFFSET n ROWS;  -- Bỏ qua n hàng đầu tiên
</pre>
