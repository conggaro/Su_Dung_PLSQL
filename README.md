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
