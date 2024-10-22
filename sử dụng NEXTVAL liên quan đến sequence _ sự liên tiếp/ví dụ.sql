INSERT INTO employees (id, name)
VALUES (employee_seq.NEXTVAL, 'John Doe');



CREATE SEQUENCE employee_seq
START WITH 1
INCREMENT BY 1
NOCACHE;



SELECT employee_seq.NEXTVAL FROM dual;