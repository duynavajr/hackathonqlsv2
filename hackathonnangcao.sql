CREATE DATABASE QUANLYSINHVIEN2;
USE QUANLYSINHVIEN2;


CREATE TABLE dmkhoa (
    makhoa VARCHAR(20) PRIMARY KEY,
    tenkhoa VARCHAR(255)
);


CREATE TABLE dmnganh (
    manganh INT PRIMARY KEY,
    tennganh VARCHAR(255),
    makhoa VARCHAR(20),
    FOREIGN KEY (makhoa) REFERENCES dmkhoa(makhoa)
);


CREATE TABLE dmlop (
    malop VARCHAR(20) PRIMARY KEY,
    tenlop VARCHAR(255),
    manganh INT,
    khoahoc INT,
    hedt VARCHAR(255),
    namnhaphoc INT,
    FOREIGN KEY (manganh) REFERENCES dmnganh(manganh)
);

CREATE TABLE sinhvien (
    masv INT PRIMARY KEY,
    hoten VARCHAR(255),
    malop VARCHAR(20),
    gioitinh TINYINT(1),
    ngaysinh DATE,
    diachi VARCHAR(255),
    FOREIGN KEY (malop) REFERENCES dmlop(malop)
);


CREATE TABLE dmhocphan (
    mahp INT PRIMARY KEY,
    tenhp VARCHAR(255),
    sodvht INT,
    manganh INT,
    hocky INT,
    FOREIGN KEY (manganh) REFERENCES dmnganh(manganh)
);


CREATE TABLE diemhp (
    masv INT,
    mahp INT,
    diemhp FLOAT,
    foreign key(masv) references sinhvien(masv),
    FOREIGN KEY (mahp) REFERENCES dmhocphan(mahp)
);


-- THÊM DỮ LIỆU VÀO CÁC BẢNG 
insert into dmkhoa (makhoa,tenkhoa) values
 ('CNTT','CÔNG NGHỆ THÔNG TIN'),
 ('KT','KẾ TOÁN'),
 ('SP','SƯ PHẠM');
 
 -- Thêm dữ liệu vào bảng dmnganh
insert into dmnganh (manganh, tennganh, makhoa)
values
    (140902, 'Sư phạm toán tin', 'SP'),
    (480202, 'Tin học ứng dụng', 'CNTT');

-- Thêm dữ liệu vào bảng dmlop
insert into dmlop (malop, tenlop, manganh, khoahoc, hedt, namnhaphoc)
values
    ('CT11', 'Cao đẳng tin học', 480202, 11, 'TC', 2013),
    ('CT12', 'cao đẳng tin học', 480202, 12, 'CĐ', 2013),
    ('CT13', 'cao đẳng tin học', 480202, 13, 'TC', 2014);

-- Thêm dữ liệu vào bảng dmhocphan
insert into dmhocphan (mahp, tenhp, sodvht, manganh, hocky) values
(1, 'Toán cao cấp A1', 4, 480202, 1),
(2, 'Tiếng anh 1', 3, 480202, 1),
(3, 'Vật lí đại cương', 4, 480202, 1),
(4, 'Tiếng anh 2', 7, 480202, 1),
(5, 'Tiếng anh 1', 3, 140902, 2),
(6, 'Xác suất thống kê', 4, 480202, 2);

-- Thêm dữ liệu vào bảng sinhvien
insert into sinhvien (masv, hoten, malop, gioitinh, ngaysinh, diachi) values
(1, 'Phan Thanh', 'CT12', 0, '1999-09-12', 'Tuy Phước'),
(2, 'Nguyên Thị Cẩm', 'CT12', 1, '1994-01-12', 'Quy Nhơn'),
(3, 'Võ Thị Hà', 'CT12', 1, '1995-07-02', 'An Nhơn'),
(4, 'Trần Hoài Nam', 'CT12', 0, '1994-04-05', 'Tây Sơn'),
(5, 'Trần Văn Hoàng', 'CT13', 0, '1995-08-04', 'Vĩnh Thạnh'),
(6, 'Đặng Thị Thảo', 'CT13', 1, '1995-06-12', 'Quy Nhơn'),
(7, 'Lê Thị Sen', 'CT13', 1, '1994-08-12', 'Phủ Mỹ'),
(8, 'Nguyễn Văn Huy', 'CT11', 0, '1995-06-04', 'Tuy Phước'),
(9, 'Trần Thị Hoa', 'CT11', 1, '1994-08-09', 'Hoài Nhơn');

-- Thêm dữ liệu vào bảng diemhp
insert into diemhp (masv, mahp, diemhp) values
(2, 2, 5.9),
(2, 3, 4.5),
(3, 1, 4.3),
(3, 2, 6.7),
(3, 3, 7.3),
(4, 1, 4),
(4, 2, 5.2),
(4, 3, 3.5),
(5, 1, 9.8),
(5, 2, 7.9),
(5, 3, 7.5),
(6, 1, 6.1),
(6, 2, 5.6),
(6, 3, 4),
(7, 1, 6.2);

-- THỰC HIỆN CÁC CÂU TRUY VẤN LỒNG NHAU ( CẤU TRÚC LỒNG NHAU PHỦ ĐỊNH : KHÔNG - CHƯA)
-- 1.
select masv,hoten
from sinhvien
where masv not in
(select masv from diemhp);

-- 2
select masv,hoten
from sinhvien
where masv not in 
(select masv from diemhp where mahp = 1);

-- 3
select mahp,tenhp
from dmhocphan
where mahp NOT IN 
(select mahp from diemhp where diemhp < 5);

-- 4
select masv,hoten
from sinhvien
where masv not in 
(select masv from diemhp where diemhp < 5);

-- TRUY VẤN LỒNG NHAU KHÔNG KẾT NỐI 
-- 5
select distinct tenlop
from dmlop
where malop in
(select malop from sinhvien where hoten like '%Hoa%');
-- 6
select hoten
from sinhvien
where masv in
(select masv from diemhp where mahp = 1 and diemhp < 5);

-- 7
select mahp,tenhp,sodvht,manganh,hocky
from dmhocphan
where sodvht >= (select sodvht from dmhocphan where mahp = 1);

-- dạng truy vấn lượng từ : all,any,exists
-- 8
select masv,hoten
from sinhvien
where masv = all (select masv from diemhp where diemhp = (select MAX(diemhp) from diemhp));
-- 9
select masv, hoten
from sinhvien
where masv = all 
(select masv from diemhp where mahp = 1 and diemhp = (select MAX(diemhp) from diemhp where mahp = 1));
 
 -- 10
select masv, mahp
from diemhp
where diemhp > any (select diemhp from diemhp where masv = 3);

-- 11
select masv, hoten
from sinhvien
where exists (select * from diemhp where sinhvien.masv = diemhp.masv);

-- 12
select masv, hoten
from sinhvien
where not exists (select * from diemhp where sinhvien.masv = diemhp.masv);

-- dạng truy vấn với cấu trúc tập hợp :UNION 

-- 13 select
select masv
from diemhp
where mahp = 1 union
select masv
from diemhp
where mahp = 2;

-- 14
DELIMITER //
create procedure KIEM_TRA_LOP(IN malop VARCHAR(20))
begin
    declare lop_count INT;
    select COUNT(*) into lop_count from dmlop where malop = malop;
    
    if lop_count = 0 then
        select 'Lớp này không có trong danh mục' as result;
    else
        select hoten
        from sinhvien
        where masv not in 
        (select masv from diemhp where diemhp < 5 and masv 
        in (select masv from sinhvien where malop = malop));
    end if;
end;
//
DELIMITER ;
call KIEM_TRA_LOP ('CT12');


-- 15
DELIMITER //
create trigger check_sv
before insert on sinhvien
for each row
begin
   if new.MaSV is null or new.MaSV = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã sinh viên phải được nhập';
    end if;
END //
DELIMITER ;

-- 16
DELIMITER //
CREATE TRIGGER tr_update_SiSo
AFTER INSERT ON sinhvien
FOR EACH ROW
BEGIN
    UPDATE dmlop
    SET SiSo = SiSo + 1
    WHERE MaLop = NEW.MaLop;
END //
DELIMITER ;

-- 17
DELIMITER //
CREATE FUNCTION DOC_DIEM(DiemHP FLOAT) RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE DiemChu VARCHAR(255);
    CASE
        WHEN DiemHP >= 9.5 THEN SET DiemChu = 'A+';
        WHEN DiemHP >= 8.5 THEN SET DiemChu = 'A';
        WHEN DiemHP >= 7.5 THEN SET DiemChu = 'B+';
        WHEN DiemHP >= 6.5 THEN SET DiemChu = 'B';
        WHEN DiemHP >= 5.5 THEN SET DiemChu = 'C+';
        WHEN DiemHP >= 4.5 THEN SET DiemChu = 'C';
        WHEN DiemHP >= 3.5 THEN SET DiemChu = 'D+';
        WHEN DiemHP >= 2.0 THEN SET DiemChu = 'D';
        ELSE SET DiemChu = 'F';
    END CASE;
    RETURN DiemChu;
END //
DELIMITER ;

SELECT sv.MaSV,sv.HoTen,dh.MaHP,dh.DiemHP,DOC_DIEM(dh.DiemHP) AS DiemChu
FROM diemhp dh
JOIN sinhvien sv ON dh.MaSV = sv.MaSV
LIMIT 0, 1000;

-- 18
DELIMITER //
CREATE PROCEDURE HIEN_THI_DIEM(IN threshold FLOAT)
BEGIN
    DECLARE student_count INT;
    SELECT COUNT(*) INTO student_count
    FROM sinhvien sv
    JOIN diemhp dh ON sv.MaSV = dh.MaSV
    WHERE dh.DiemHp < threshold;

    IF student_count > 0 THEN
        SELECT sv.MaSV, sv.HoTen, sv.MaLop, dh.DiemHp, dh.MaHP
        FROM sinhvien sv
        JOIN diemhp dh ON sv.MaSV = dh.MaSV
        WHERE dh.DiemHp < threshold;
    ELSE
        SELECT 'Không có sinh viên nào' AS Message;
    END IF;
END //
DELIMITER ;
CALL HIEN_THI_DIEM(5);

-- 19
DELIMITER //
CREATE PROCEDURE HIEN_THI_MAHP(IN maHP INT)
BEGIN
    DECLARE hphExists INT;
    SELECT COUNT(*) INTO hphExists FROM dmhocphan WHERE MaHP = maHP;
    IF hphExists = 0 THEN
        SELECT 'Không có học phần với mã chỉ định.' AS Message;
    ELSE
        -- Display HoTen sinh viên who have not studied the specified học phần
        SELECT sv.HoTen
        FROM sinhvien sv
        WHERE sv.MaSV NOT IN (SELECT MaSV FROM diemhp WHERE MaHP = maHP);
    END IF;
END //
DELIMITER ;
CALL HIEN_THI_MAHP(1);

-- 20
DELIMITER //
CREATE PROCEDURE HIEN_THI_TUOI(IN TuoiMin INT, IN TuoiMax INT)
BEGIN
    SELECT sv.MaSV, sv.HoTen, sv.MaLop, sv.NgaySinh, sv.Gioitinh,
           TIMESTAMPDIFF(YEAR, sv.NgaySinh, CURDATE()) AS Tuoi
    FROM sinhvien sv
    WHERE TIMESTAMPDIFF(YEAR, sv.NgaySinh, CURDATE()) BETWEEN TuoiMin AND TuoiMax
    UNION
    SELECT NULL, 'Không có sinh viên nào', NULL, NULL, NULL, NULL
    WHERE NOT EXISTS (
        SELECT 1 FROM sinhvien WHERE TIMESTAMPDIFF(YEAR, NgaySinh, CURDATE()) BETWEEN TuoiMin AND TuoiMax
    );
END //
DELIMITER ;
CALL HIEN_THI_TUOI(20, 30);
























