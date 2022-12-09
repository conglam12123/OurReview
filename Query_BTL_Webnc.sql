Create database db_webnc
go
use db_webnc

create table tblUsers
(
	PK_iUserID int IDENTITY(1,1),
	sUserEmail nvarchar(255) UNIQUE,
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
	sPostImageUrl nvarchar(255),
	primary key (PK_iPostID),
	constraint fk_post_user foreign key (FK_iUserID) references tblUsers(PK_iUserID),
	constraint fk_post_category foreign key (FK_iCategoryID) references tblCategories(PK_iCategoryID)
)
go
--create table tblPostImage
--(
--	PK_iImageID int IDENTITY(1,1),
--	FK_iPostID int,
--	sPostImage nvarchar(255),
--	primary key (PK_iImageID),
--	constraint fk_image_post Foreign key (FK_iPostID) references tblPost (PK_iPostID)
--)
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
	constraint fk_comment_post foreign key (FK_iPostID) references tblPost (PK_iPostID) ON DELETE CASCADE,
	constraint fk_comment_user foreign key (FK_iUserID) references tblUsers (PK_iUserID) ON DELETE CASCADE
)
go 
--drop table tblLikedPost
create table tblLikedPost
(
	PK_iLikedPostID int IDENTITY(1,1),
	FK_iUserID int,
	FK_iPostID int,
	primary key (PK_iLikedPostID),
	constraint fk_liked_post foreign key (FK_iPostID) references tblPost (PK_iPostID) ON DELETE CASCADE,
	constraint fk_user_liked_post foreign key (FK_iUserID) references tblUsers (PK_iUserID) ON DELETE CASCADE,
	constraint uq_likedpost unique (FK_iUserID,FK_iPostID)
)
go
create table tblLikedComment
(
	PK_iLikedCommentID int IDENTITY(1,1),
	FK_iUserID int,
	FK_iCommentID int,
	primary key (PK_iLikedCommentID),
	constraint fk_liked_comment foreign key (FK_iCommentID) references tblComment (PK_iCommentID),
	constraint fk_user_liked_comment foreign key (FK_iUserID) references tblUsers (PK_iUserID) ON DELETE CASCADE,
	constraint uq_likedcomment unique (FK_iUserID,FK_iCommentID)
)
-- tạo các stored procedure
-- đăng ký người dùng
go
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
--select * from tblUsers
--delete from tblUsers where PK_iUserID>1

-- sp login
--drop proc sp_login
go
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
go
exec sp_login 'nguyenconglam7@gmail.com', 'c4ca4238a0b923820dcc509a6f75849b'
go
insert into tblCategories (sCategoryName,sCategoryImage)
values (N'Thời trang','./Assets/img/category/fashion.png'),
	(N'Công nghệ','./Assets/img/category/technology.png'),
	(N'Du lịch','./Assets/img/category/travel.png')
-- tạo proc lấy tên thư mục
go
create proc sp_getCategories 
as
begin
	select * from tblCategories
end
-- tạo proc đăng post
drop proc sp_UploadPost
create proc sp_UploadPost
(
	@userid int,
	@cateid int,
	@postcontent nvarchar(255),
	@postImageUrl nvarchar(255)
)
as
begin 
	INSERT into tblPost (FK_iUserID,FK_iCategoryID,sPostContent,dPostedDatetime,sPostImageUrl)
	values(@userid,@cateid,@postcontent,getdate(),@postImageUrl)
end
go
exec sp_UploadPost 1,1,N'Tôi cảm thấy rất hài lòng với chất lượng sản phẩm',N'./Assets/img/avatar/07122022_101227_AM_tommy xiaomi.jpg'
-- tạo proc lấy post để hiển thị 
drop proc sp_getPostByCategoryID
create proc sp_getPostByCategoryID 
(
	@idCate int
)
as
begin
	select  a.PK_iPostID,a.FK_iUserID,sUserName,sUserAvatar,dPostedDatetime,sPostContent,sPostImageUrl,likecount,commentcount
	from tblPost a 
		inner join tblUsers b on a.FK_iUserID = b.PK_iUserID
		inner join (select PK_iPostID, COUNT(FK_iPostID) as [likecount]
			from tblPost a left join tblLikedPost b on a.PK_iPostID = b.FK_iPostID
			group by PK_iPostID) c on a.PK_iPostID = c.PK_iPostID
		inner join (select PK_iPostID, COUNT(PK_iCommentID) as [commentcount]
			from tblPost a left join tblComment b on a.PK_iPostID = b.FK_iPostID
			group by PK_iPostID) d on a.PK_iPostID = d.PK_iPostID
	where FK_iCategoryID = @idCate
end
go
exec sp_getPostByCategoryID 1;

-- Taoj proc xóa bài viết 
drop proc sp_deletePost
create proc sp_deletePost
(
	@postid int,
	@userid int
)
as
begin 
	delete from tblPost
	where PK_iPostID = @postid;
end
--TẠo proc thêm lượt like
create proc sp_LikePost
(
	@postid int,
	@userid int
	)
as
begin
	insert into tblLikedPost(FK_iPostID,FK_iUserID)
	values(@postid,@userid)
end
--tạo proc xóa lượt like 
go
create proc sp_UnlikePost 
(
	@postid int,
	@userid int
)
as
begin
	delete from tblLikedPost
	where FK_iPostID = @postid and FK_iUserID = @userid
end
exec sp_UnlikePost 4,1
delete from tblLikedPost where 1=1
select * from tblLikedPost
--- lấy số like hiện tại của post
create proc sp_getPostLike
(
	@postid int
)
as
begin
	select PK_iPostID, COUNT(b.FK_iPostID) as [likecount]
	from tblPost a left join tblLikedPost b on a.PK_iPostID = b.FK_iPostID
	where PK_iPostID = @postid
	group by PK_iPostID
end 
exec sp_getPostLike 4



















--truy vấn lấy toàn bộ thông tin của post cần hiển thị
select  a.PK_iPostID,a.FK_iUserID,sUserName,dPostedDatetime,sPostContent,sPostImageUrl,likecount,commentcount
from tblPost a 
	inner join tblUsers b on a.FK_iUserID = b.PK_iUserID
	inner join (select PK_iPostID, COUNT(FK_iPostID) as [likecount]
		from tblPost a left join tblLikedPost b on a.PK_iPostID = b.FK_iPostID
		group by PK_iPostID) c on a.PK_iPostID = c.PK_iPostID
	inner join (select PK_iPostID, COUNT(PK_iCommentID) as [commentcount]
		from tblPost a left join tblComment b on a.PK_iPostID = b.FK_iPostID
		group by PK_iPostID) d on a.PK_iPostID = d.PK_iPostID
-- bảng đếm like
go
select PK_iPostID, COUNT(b.FK_iPostID) as [likecount]
from tblPost a left join tblLikedPost b on a.PK_iPostID = b.FK_iPostID
group by PK_iPostID
--bảng đếm comment
go
select PK_iPostID, COUNT(PK_iCommentID) as [commentcount]
from tblPost a left join tblComment b on a.PK_iPostID = b.FK_iPostID
group by PK_iPostID


insert into tblLikedPost(FK_iUserID,FK_iPostID)
values(5,1),(6,1)
select * from tblLikedPost


delete from tblLikedPost where 1=1
select * from tblPost




select * from tblPost;

exec sp_getCategories

exec sp_login 'nguyenconglam7@gmail.com', 'c4ca4238a0b923820dcc509a6f75849b'
select * from tblUsers
delete from tblUsers 
where PK_iUserID>1

select * from tblUsers
select * from tblPost


