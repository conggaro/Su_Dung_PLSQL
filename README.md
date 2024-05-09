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
