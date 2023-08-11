-- tạo bảng nhân viên
create table NhanVien(
       ma_NhanVien varchar2(6 char),
       ho_ten varchar2(50 char),
       tuoi number
);


-- nhập dữ liệu
insert into NhanVien(ma_NhanVien, ho_ten, tuoi) values (N'NV001', N'Nguyễn Văn An', 20);
insert into NhanVien(ma_NhanVien, ho_ten, tuoi) values (N'NV002', N'Nguyễn Văn Bình', 30);
insert into NhanVien(ma_NhanVien, ho_ten, tuoi) values (N'NV003', N'Nguyễn Văn Chính', 18);
insert into NhanVien(ma_NhanVien, ho_ten, tuoi) values (N'NV004', N'Nguyễn Văn Dương', 45);


-- lấy ra tất cả bản ghi
select *
from NhanVien;


-- sử dụng từ khóa rownum để tạo ra cột mới
-- có chức năng tự động tăng
-- nó giống như đánh chỉ mục index ấy
select rownum STT, Cai_Bang.*
from (
       select *
       from NhanVien
)Cai_Bang;
