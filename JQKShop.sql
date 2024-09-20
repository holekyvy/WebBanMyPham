create database JQKShop
go
use JQKShop
go
create table DanhMucSanPham
(
	maDanhMuc int identity primary key,
	tenDanhMuc nvarchar(30),
	maThuongHieu int NULL
)
--testDanhMuc

create table ChiTietSanPham
(
	maSP int identity primary key,
	maDanhMuc int,
	--maThuongHieu int,
	tenSP nvarchar(30),
	donGia int,
	khuyenMai nvarchar(max),
	thongTinSP ntext,
	dungTich nvarchar(30),
	hinhAnh nvarchar(max),
	constraint fk_LoaiMyPham
	foreign key(maDanhMuc) references DanhMucSanPham1(maDanhMuc) on update cascade on delete cascade,

)

--testChiTietSanPham--
insert into ChiTietSanPham values(1,'Volcanic Clay',250000,0.2,N'Có nắp hộp đã được thay thế bằng vỏ nhôm cao cấp, sáp đem lại độ giữ nếp cao, thích hợp với người Việt Nam có chất tóc trung bình tới dày.','80g','vocanic clay.jpg')
insert into ChiTietSanPham values(1,'Kevin',400000,0.3,N'Có nắp hộp đã được thay thế bằng vỏ nhôm cao cấp, sáp đem lại độ giữ nếp cao, thích hợp với người Việt Nam có chất tóc trung bình tới dày.','80g','vocanic clay.jpg')
insert into ChiTietSanPham values(2,'Chanel',500000,0.3,N'Sản phẩm được làm từ các loại dầu thơm tự nhiên & an lành .Các mùi hương đậm chất chỉ có ở nhà DUKE.','100ml','vocanic clay.jpg')
insert into ChiTietSanPham values(2,'Havana Tobacco',500000,0.3,N'Sản phẩm được làm từ các loại dầu thơm tự nhiên & an lành .Các mùi hương đậm chất chỉ có ở nhà Tobaco.','100ml','vocanic clay.jpg')
insert into ChiTietSanPham values(3,'Sữa dưỡng da nam Gen',550000,0.1,N'Sản phẩm được làm từ các loại dầu thơm tự nhiên & an lành .Các mùi hương đậm chất chỉ có ở nhà Tobaco.','100ml','vocanic clay.jpg')

select *from ChiTietSanPham

create view showSảnPhẩmTóc
as 
select * from ChiTietSanPham where maDanhMuc=9 or maDanhMuc=10

select * from showSảnPhẩmTóc

create view showNướcHoa
as
select * from ChiTietSanPham where maDanhMuc=4 or maDanhMuc=5

select * from showNướcHoa

create view showChămSócDa
as
select *from ChiTietSanPham where maDanhMuc=7 or maDanhMuc=8

select *from showChămSócDa

create view showSanPhamHotSale
as
select *from ChiTietSanPham where donGia <= 320000

select *from showSanPhamHotSale

create view showSanPhamMoi
as
select *from ChiTietSanPham where donGia >= 320000

select *from showSanPhamMoi

-------

create table Users
(
	IDDN int identity primary key,
	tenDN nvarchar(30),
	email nvarchar(30),
	diaChi nvarchar(30),
	sdt nvarchar(15),
	matkhauDN nvarchar(30),
	quyen bit
)

--testtblKhachhang--
insert into Users values(2,N'John','john@gmail.com','0124544589','john','123')

select *from Users

go
create table HoaDon
(
	ID int identity primary key,
	IDDN int,
	sdt nvarchar(15),
	ngayDat datetime,
	diaChiNhan nvarchar(30),
	tongTien int,
	trangThai bit,
	constraint fk_HoaDon_KH
	foreign key(IDDN) references Users(IDDN) on update cascade on delete cascade
)

--testHoaDon--
insert into  HoaDon values(1,'Pham Quang',1,2700000)

select *from HoaDon
go
create table ChiTietHoaDon
(
	IDHD int,
	maSP int,
	donGia int,
	soLuong int,
	constraint pk primary key (IDHD, maSP),
	constraint fk_ChiTietHoaDon foreign key(IDHD) references HoaDon(ID) on update cascade on delete cascade,
	constraint fk_ChiTietHoaDonSP
	foreign key(maSP) references ChiTietSanPham(maSP) on update cascade on delete cascade
)
go
create table Blog
(
	maTin int primary key,
	tieuDe nvarchar(max),
	hinhAnh nvarchar(max),
	noiDung nvarchar(max),
	ngayDangTin nvarchar(20),
	tacGia nvarchar(30)
)

--testtblTinTuc--
insert into Blog values(1,N'Ra mắt điện thoại thông minh thế hệ mới',
							N'Tintuc1.JPG',
							N'cuộc cách mạng công nghệ lớn đang diễn ra, thung lũng Silicon của Mỹ 
							đang nhộn nhịp',N'Sắp có sản phẩm công nghệ tiên tiến mới chuẩn bị ra mắt',
							'12-10-2020',N'Jonathan')
insert into Blog values(2,N'Ra công nghệ cao AirPod 5.2',
							N'Tintuc2.JPG',
							N'cuộc cách mạng công nghệ lớn đang diễn ra, thung lũng Silicon của Mỹ 
							đang nhộn nhịp',N'Sắp có sản phẩm công nghệ tiên tiến mới chuẩn bị ra mắt',
							N'12-11-2020',N'Phan Dang')							
							
select *from Blog

go
create table tblAdmin
(
	tenTaiKhoan nvarchar(30) primary key,
	matKhauAdmin nvarchar(max),
)
--testtblAdmin--
insert into tblAdmin values(N'quang','1')
select *from tblAdmin


--create view thongkebanhang
--as
--select ChiTietSanPham.tenSP,ChiTietSanPham.donGia , SUM(ChiTietSanPham.) as N'Số lượng trong kho', sum (tblChiTietHoaDonDienThoai.soLuong) as N'Số lượng đã bán', 
--sum(tblChiTietDienThoai.soLuong - tblChiTietHoaDonDienThoai.soLuong ) as N'Số lượng còn lại',
--sum (tblChiTietHoaDonDienThoai.donGiaDT*tblChiTietHoaDonDienThoai.soLuong) as N'Tổng tiền 1 sản phẩm đã bán'
--from tblChiTietHoaDonDienThoai  inner join tblChiTietDienThoai on tblChiTietHoaDonDienThoai.maDT=tblChiTietDienThoai.maDT
--group by tenDT,tblChiTietDienThoai.donGiaDT

create view thongkebanhang
as
select ChiTietSanPham.tenSP,ChiTietSanPham.donGia  ,SUM(ChiTietHoaDon.soLuong) as 'Số lượng mua',
sum(ChiTietHoaDon.donGia*ChiTietHoaDon.soLuong) as N'Doanh Thu',
SUM(ChiTietHoaDon.donGia*ChiTietHoaDon.soLuong*0.5) as N'Lợi Nhuận'
from ChiTietSanPham  inner join ChiTietHoaDon on ChiTietSanPham.maSP=ChiTietHoaDon.maSP
					inner join HoaDon on ChiTietHoaDon.IDHD=HoaDon.IDDN
group by tenSP,ChiTietSanPham.donGia


create view thongkenguoidung
as
select Count(IDDN) as 'tong nguoi dung'
from Users

create view thongkesanpham
as
select Count(maSP) as 'tổng sản phẩm'
from ChiTietSanPham

create view thongkehoadon
as
select Count(ID) as 'tổng số hoá đơn'
from HoaDon

create view thongkedoanhthu
as
select Sum(ChiTietHoaDon.donGia*ChiTietHoaDon.soLuong) as 'tổng doanh thu'
from ChiTietSanPham  inner join ChiTietHoaDon on ChiTietSanPham.maSP=ChiTietHoaDon.maSP
					

select maDanhMuc, tenDanhMuc
from DanhMucSanPham
where maThuongHieu is NULL


