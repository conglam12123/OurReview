Create database db_webnc
go
use db_webnc

create table tblUsers
(
	PK_iUserID int IDENTITY(1,1),
	sUserEmail nvarchar(255),
	sUserPassword nvarchar(255),
	sUserName nvarchar(255),
	sUserAvatar nvarchar(255),
	PRIMARY KEY (PK_iUserID)
)
go
create table tblCategories 
(
	PK_iCategoryID int IDENTITY(1,1),
	sCategoryName nvarchar(255),
	sCategoryImage nvarchar(255),
	primary key (PK_icategoryID)
)
go
create table tblPost 
(
	PK_iPostID int IDENTITY(1,1),
	FK_iUserID int,
	FK_iCategoryID int,
	sPostContent nvarchar(255),
	dPostedDatetime datetime,
	iPostLikedCount int,
	primary key (PK_iPostID),
	constraint fk_post_user foreign key (FK_iUserID) references tblUsers(PK_iUserID),
	constraint fk_post_category foreign key (FK_iCategoryID) references tblCategories(PK_iCategoryID)
)
go
create table tblPostImage
(
	PK_iImageID int IDENTITY(1,1),
	FK_iPostID int,
	sPostImage nvarchar(255),
	primary key (PK_iImageID),
	constraint fk_image_post Foreign key (FK_iPostID) references tblPost (PK_iPostID)
)
go
create table tblComment
(
	PK_iCommentID int IDENTITY(1,1),
	FK_iUserID int,
	FK_iPostID int,
	sCommentContent nvarchar(255),
	dCommentDateTime datetime,
	iCommentLikedCount int,
	primary key (PK_iCommentID),
	constraint fk_comment_post foreign key (FK_iPostID) references tblPost (PK_iPostID),
	constraint fk_comment_user foreign key (FK_iUserID) references tblUsers (PK_iUserID)
)
go 
create table tblLikedPost
(
	PK_iLikedPostID int IDENTITY(1,1),
	FK_iUserID int,
	FK_iPostID int,
	primary key (PK_iLikedPostID),
	constraint fk_liked_post foreign key (FK_iPostID) references tblPost (PK_iPostID),
	constraint fk_user_liked_post foreign key (FK_iUserID) references tblUsers (PK_iUserID)
)
go
create table tblLikedComment
(
	PK_iLikedCommentID int IDENTITY(1,1),
	FK_iUserID int,
	FK_iCommentID int,
	primary key (PK_iLikedCommentID),
	constraint fk_liked_comment foreign key (FK_iCommentID) references tblComment (PK_iCommentID),
	constraint fk_user_liked_comment foreign key (FK_iUserID) references tblUsers (PK_iUserID)
)
-- tạo các stored procedure
-- đăng ký người dùng
use db_webnc
create proc sp_InsertUser
(
	@email nvarchar(255),
	@password nvarchar(255),
	@username nvarchar(255),
	@avatar nvarchar(255)
)
as
begin
	insert into tblUsers (sUserEmail, sUserPassword, sUserName, sUserAvatar)
	values (@email,@password,@username,@avatar)
end
select * from tblUsers
delete from tblUsers where PK_iUserID>1

-- sp login
drop proc sp_login
create proc sp_login
(
	@email nvarchar(255),
	@password nvarchar(255)
)
as
begin
	select * from tblUsers 
	where (sUserEmail = @email) and sUserPassword = @password
end

exec sp_login 'nguyenconglam7@gmail.com', 'c4ca4238a0b923820dcc509a6f75849b'
select * from tblUsers