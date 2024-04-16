# Sử dụng biến
<template>
declare
    x number := 10;
    y nvarchar2(50) := 'Hello';
begin
    DBMS_OUTPUT.PUT_LINE('Value of x: ' || x);
    DBMS_OUTPUT.PUT_LINE('Value of y: ' || y);
end;
</template>template>
<br><br>

<template>
declare
    -- v là viết tắt của variable
    v_code nvarchar2(100);
begin
    select employee_code into v_code
    from hu_employee
    where employee_code = 'H2403040004';

    DBMS_OUTPUT.PUT_LINE('Employee code: ' || v_code);
end;
</template>
