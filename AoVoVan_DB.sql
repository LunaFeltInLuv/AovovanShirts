create database aovovan_db
go

use aovovan_db
go


create table users(
	id int primary key identity(1,1),
	username varchar(32) not null unique,
	password_hash varchar(255) not null,
	name nvarchar(50) not null,
	phone varchar(20) not null,
	email varchar(255) not null unique,
	profile_picture_url varchar(2048),
	address nvarchar(1000),
	is_active bit default 1, -- dang hoat dong = true
	created_at datetime2 default getdate(),
	updated_at datetime2 default getdate(),
)
go

alter table users add constraint chk_username
check (username not like '% %' and len(username) >= 3);

alter table users add constraint chk_name
check (len(name) >= 2);


alter table users add constraint chk_phone
check (phone not like '%[^0-9]%' and len(phone) >= 10 and len(phone) <= 20);

--alter table users drop constraint chk_phone

alter table users add constraint chk_email
CHECK (email LIKE '%_@__%._%')


create table roles(
	id int primary key identity(1,1),
	name varchar(50) not null unique,
	description nvarchar(255)
)
go


create table user_role( -- noi user voi role de co the linh hoat thay doi role cua user
	role_id int not null, 
	user_id int not null,
	foreign key(role_id) references roles(id) on delete cascade,
	foreign key(user_id) references users(id) on delete cascade,
	primary key(user_id, role_id)
)
go


CREATE TABLE permissions (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(50) UNIQUE NOT NULL,  -- 'read', 'update', 'delete'
    description NVARCHAR(255) NULL
);

insert into permissions(name) values ('read'), ('create'), ('update'), ('delete')


CREATE TABLE role_permissions (
    role_id INT NOT NULL,
    permission_id INT NOT NULL,
    PRIMARY KEY (role_id, permission_id),
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
    FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE
);
go




select * from users
select * from roles
select * from user_role
select * from role_permissions
select * from permissions

insert into roles(name) values ('user'), ('admin'), ('product_manager')






-- =============================================
-- 15 USER HỢP LỆ
-- =============================================
INSERT INTO users (username, password_hash, name, phone, email, address, is_active) VALUES 
('john_doe', 'hashed123', N'John Doe', '0912345678', 'john@gmail.com', N'123 Main St, Hanoi', 1),
('jane_smith', 'hashed456', N'Jane Smith', '0987654321', 'jane@gmail.com', N'456 Oak Ave, Hanoi', 1),
('mike_brown', 'hashed789', N'Michael Brown', '0977777777', 'mike@gmail.com', N'789 Pine Rd, Hanoi', 1),
('emily_davis', 'hashed101', N'Emily Davis', '0966666666', 'emily@gmail.com', N'101 Maple Dr, HCMC', 1),
('david_wilson', 'hashed112', N'David Wilson', '0955555555', 'david@gmail.com', N'202 Cedar Ln, HCMC', 1),
('sarah_miller', 'hashed113', N'Sarah Miller', '0944444444', 'sarah@gmail.com', N'303 Birch Blvd, Da Nang', 1),
('chris_taylor', 'hashed114', N'Chris Taylor', '0933333333', 'chris@gmail.com', N'404 Elm St, Da Nang', 1),
('lisa_anderson', 'hashed115', N'Lisa Anderson', '0922222222', 'lisa@gmail.com', N'505 Willow Way, Hanoi', 1),
('kevin_thomas', 'hashed116', N'Kevin Thomas', '0911111111', 'kevin@gmail.com', N'606 Ash Ct, HCMC', 1),
('amanda_jackson', 'hashed117', N'Amanda Jackson', '0900000000', 'amanda@gmail.com', N'707 Poplar Pl, Da Nang', 1),
('robert_white', 'hashed118', N'Robert White', '0898888888', 'robert@gmail.com', N'808 Sycamore St, Hanoi', 1),
('jessica_harris', 'hashed119', N'Jessica Harris', '0887777777', 'jessica@gmail.com', N'909 Beech Dr, HCMC', 1),
('daniel_martin', 'hashed120', N'Daniel Martin', '0876666666', 'daniel@gmail.com', N'1010 Hickory Ln, Da Nang', 1),
('laura_thompson', 'hashed121', N'Laura Thompson', '0865555555', 'laura@gmail.com', N'1111 Magnolia Ave, Hanoi', 1),
('james_garcia', 'hashed122', N'James Garcia', '0854444444', 'james@gmail.com', N'1212 Dogwood Rd, HCMC', 1);


-- Gán role cho từng user cụ thể
-- user 1: john_doe → admin
INSERT INTO user_role (user_id, role_id) VALUES (1, 2);

-- user 2: jane_smith → product_manager
INSERT INTO user_role (user_id, role_id) VALUES (2, 3);

-- user 3: mike_brown → user
INSERT INTO user_role (user_id, role_id) VALUES (3, 1);

-- user 4: emily_davis → admin
INSERT INTO user_role (user_id, role_id) VALUES (4, 2);

-- user 5: david_wilson → product_manager
INSERT INTO user_role (user_id, role_id) VALUES (5, 3);

-- user 6: sarah_miller → user
INSERT INTO user_role (user_id, role_id) VALUES (6, 1);

-- user 7: chris_taylor → user
INSERT INTO user_role (user_id, role_id) VALUES (7, 1);

-- user 8: lisa_anderson → product_manager
INSERT INTO user_role (user_id, role_id) VALUES (8, 3);

-- user 9: kevin_thomas → user
INSERT INTO user_role (user_id, role_id) VALUES (9, 1);

-- user 10: amanda_jackson → admin
INSERT INTO user_role (user_id, role_id) VALUES (10, 2);

-- user 11: robert_white → user
INSERT INTO user_role (user_id, role_id) VALUES (11, 1);

-- user 12: jessica_harris → user
INSERT INTO user_role (user_id, role_id) VALUES (12, 1);

-- user 13: daniel_martin → product_manager
INSERT INTO user_role (user_id, role_id) VALUES (13, 3);

-- user 14: laura_thompson → user
INSERT INTO user_role (user_id, role_id) VALUES (14, 1);

-- user 15: james_garcia → user
INSERT INTO user_role (user_id, role_id) VALUES (15, 1);

-------------------------------------------------------------------------------------------------------------------------------------------
-- test constraints 
select * from users 

delete from users where username like 'no_at_sign'

INSERT INTO users (username, password_hash, name, phone, email, address, is_active) 
VALUES ('no_at_sign', 'hashed999', N'Test User', '0912345678', 'invalid-email@s', N'123 Test St', 0);
-- ❌ Lỗi: CHECK chk_users_email (email MUST contain '')

-- ❌ Phone bắt đầu bằng chữ
INSERT INTO users (username, password_hash, name, phone, email, address) 
VALUES ('test1', '123', N'Test', 'abc1234567', 'test1@gmail.com', N'Hà Nội');

-- ❌ Phone quá ngắn
INSERT INTO users (username, password_hash, name, phone, email, address) 
VALUES ('test2', '123', N'Test', '12345', 'test2@gmail.com', N'Hà Nội');

-- ❌ Phone có khoảng trắng
INSERT INTO users (username, password_hash, name, phone, email, address) 
VALUES ('test3', '123', N'Test', '0912 345 678', 'test3@gmail.com', N'Hà Nội');

-------------------------------------------------------------------------------------------------------------------------------------------

-- Xóa dữ liệu cũ (nếu có)
--TRUNCATE TABLE role_permissions;

-- Insert mới với permission_id
INSERT INTO role_permissions (role_id, permission_id) VALUES 
(1, 1),  -- role user → read (id=1)
(2, 1),  -- role admin → read
(2, 2),  -- role admin → create
(2, 3),  -- role admin → update
(2, 4),  -- role admin → delete
(3, 1),  -- role product_manager → read
(3, 2),  -- role product_manager → create
(3, 3),  -- role product_manager → update
(3, 4);  -- role product_manager → delete

go

-----------------------------------------------------------------------------------------------------------------

-- Add role permission

create or alter proc sp_add_role_permission
	@r_id int,
	@p_id int
as
begin
	
	if not exists (
		select 1 from roles where id = @r_id
	)
	begin
		raiserror('The role id %d doesn''t exist!',16,1,@r_id)
		return
	end

	else if not exists (
		select 1 from permissions where id = @p_id
	)
	begin
		raiserror('The permission id %d doesn''t exist!',16,2,@p_id)
		return
	end

	else if not exists (
		select 1 from role_permissions where role_id = @r_id and permission_id = @p_id

	)
	begin 
		insert into role_permissions(role_id, permission_id) values (@r_id, @p_id)
	end


	else 
	begin
		raiserror('The role id %d already has this permission!',16,3,@r_id)
		return
	end

end

go

exec sp_add_role_permission @r_id = 1, @p_id = 1

go



-- Update role permission

CREATE OR ALTER PROC sp_update_role_permission
    @r_id INT,
    @old_p_id INT,
    @new_p_id INT
AS
BEGIN
    -- 1. Kiểm tra Role tồn tại (kiểm tra sớm nhất)
    IF NOT EXISTS (SELECT 1 FROM roles WHERE id = @r_id)
    BEGIN
        RAISERROR('Role id %d doesn''t exist!', 16, 1, @r_id);
        RETURN;
    END;

    -- 2. Kiểm tra Permission cũ tồn tại trong bảng permissions
    IF NOT EXISTS (SELECT 1 FROM permissions WHERE id = @old_p_id)
    BEGIN
        RAISERROR('Old permission id %d doesn''t exist!', 16, 2, @old_p_id);
        RETURN;
    END;

    -- 3. Kiểm tra Permission mới tồn tại trong bảng permissions
    IF NOT EXISTS (SELECT 1 FROM permissions WHERE id = @new_p_id)
    BEGIN
        RAISERROR('New permission id %d doesn''t exist!', 16, 3, @new_p_id);
        RETURN;
    END;

    -- 4. Kiểm tra Role đang có Permission cũ không? (PHẢI CÓ mới update được)
    IF NOT EXISTS (
        SELECT 1 FROM role_permissions 
        WHERE role_id = @r_id AND permission_id = @old_p_id
    )
    BEGIN
        RAISERROR('Permission %d not found for role %d!', 16, 4, @old_p_id, @r_id);
        RETURN;
    END;

    -- 5. Kiểm tra Role đã có Permission mới chưa? (tránh trùng lặp)
    IF EXISTS (
        SELECT 1 FROM role_permissions 
        WHERE role_id = @r_id AND permission_id = @new_p_id
    )
    BEGIN
        RAISERROR('Role %d already has permission %d!', 16, 5, @r_id, @new_p_id);
        RETURN;
    END;

    -- 6. Thực hiện update
    UPDATE role_permissions 
    SET permission_id = @new_p_id 
    WHERE role_id = @r_id AND permission_id = @old_p_id;

    -- 7. Trả về thông báo thành công
    SELECT 'Permission updated successfully!' AS Message;
END;
GO





-- Delete role_permission
create or alter proc sp_delete_role_permission
    @r_id int,
	@p_id int
as
begin
    if not exists (select 1 from role_permissions where role_id = @r_id and permission_id = @p_id) 
    begin
        raiserror('The pair of role id %d and permission id %d not found!',16,1,@r_id,@p_id)
        return
    end

    delete from role_permissions where role_id = @r_id and permission_id = @p_id
end

go


-----------------------------------------------------------------------------------------------------------------



-- User procs

-----------------------------------------------------------------------------------------------------------------

CREATE OR ALTER PROC sp_add_user
    @username VARCHAR(32),
    @password_hash VARCHAR(255),
    @name NVARCHAR(50),
    @phone VARCHAR(20),
    @email VARCHAR(255),
    @profile_picture_url VARCHAR(2048) = NULL,
    @address NVARCHAR(1000) = NULL,
    @is_active BIT = 1,
    @role_ids VARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    -- Kiểm tra dữ liệu trước khi bắt đầu transaction (có thể nằm ngoài hoặc trong)
    IF EXISTS (SELECT 1 FROM users WHERE username = @username)
    BEGIN
        RAISERROR('Username "%s" already exists!', 16, 1, @username);
        RETURN;
    END
    -- ... kiểm tra email, phone ...

    BEGIN TRANSACTION;
    BEGIN TRY
        DECLARE @user_id INT;

        INSERT INTO users (username, password_hash, name, phone, email, profile_picture_url, address, is_active)
        VALUES (@username, @password_hash, @name, @phone, @email, @profile_picture_url, @address, @is_active);

        SET @user_id = SCOPE_IDENTITY();

        -- Xử lý gán role
        IF @role_ids IS NOT NULL
        BEGIN
            -- Kiểm tra tất cả role có tồn tại không
            DECLARE @invalid_roles INT;
            SELECT @invalid_roles = COUNT(*)
            FROM STRING_SPLIT(@role_ids, ',') 
            WHERE value NOT IN (SELECT CAST(id AS VARCHAR) FROM roles);

            IF @invalid_roles > 0
            BEGIN
                RAISERROR('One or more role IDs are invalid.', 16, 1);
                ROLLBACK TRANSACTION;
                RETURN;
            END

            INSERT INTO user_role (user_id, role_id)
            SELECT @user_id, value
            FROM STRING_SPLIT(@role_ids, ',');
        END
        ELSE
        BEGIN
            -- Gán role mặc định 'user'
            DECLARE @default_role_id INT;
            SELECT @default_role_id = id FROM roles WHERE name = 'user';
            IF @default_role_id IS NOT NULL
                INSERT INTO user_role (user_id, role_id) VALUES (@user_id, @default_role_id);
        END

        COMMIT TRANSACTION;
        SELECT @user_id AS user_id, 'User added successfully!' AS Message;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END


-----------------------------------------------------------------------------------------------------------------


-- =============================================
-- SP_UPDATE_USER - Update user
-- =============================================
CREATE OR ALTER PROC sp_update_user
    @user_id INT,
    @username VARCHAR(32) = NULL,
    @password_hash VARCHAR(255) = NULL,
    @name NVARCHAR(50) = NULL,
    @phone VARCHAR(20) = NULL,
    @email VARCHAR(255) = NULL,
    @profile_picture_url VARCHAR(2048) = NULL,
    @address NVARCHAR(1000) = NULL,
    @is_active BIT = NULL
AS
BEGIN

    IF @username IS NOT NULL AND EXISTS (SELECT 1 FROM users WHERE username = @username AND id <> @user_id)
    BEGIN
        RAISERROR('Username already exists.', 16, 1); RETURN;
    END
    UPDATE users
    SET 
        username = COALESCE(@username, username),
        password_hash = COALESCE(@password_hash, password_hash),
        name = COALESCE(@name, name),
        phone = COALESCE(@phone, phone),
        email = COALESCE(@email, email),
        profile_picture_url = COALESCE(@profile_picture_url, profile_picture_url),
        address = COALESCE(@address, address),
        is_active = COALESCE(@is_active, is_active),
        updated_at = GETDATE()
    WHERE id = @user_id;
END;
GO


-----------------------------------------------------------------------------------------------------------------

CREATE OR ALTER PROC sp_delete_user
    @user_id INT,
    @force_delete BIT = 0
AS
BEGIN
    IF @force_delete = 0
    BEGIN
        UPDATE users SET is_active = 0, updated_at = GETDATE() WHERE id = @user_id;
    END
    ELSE
    BEGIN
        BEGIN TRANSACTION;
        BEGIN TRY
            DELETE FROM users WHERE id = @user_id;
            -- Nếu có bảng khác, có thể xóa thêm ở đây
            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
            THROW;
        END CATCH
    END
END



-----------------------------------------------------------------------------------------------------------------


-- =============================================
-- SP_ASSIGN_ROLE_TO_USER - Gán role
-- =============================================
CREATE OR ALTER PROC sp_assign_role_to_user
    @user_id INT,
    @role_id INT
AS
BEGIN
    INSERT INTO user_role (user_id, role_id)
    VALUES (@user_id, @role_id);
END;
GO

-----------------------------------------------------------------------------------------------------------------

-- =============================================
-- SP_REMOVE_ROLE_FROM_USER - Gỡ role
-- =============================================
CREATE OR ALTER PROC sp_remove_role_from_user
    @user_id INT,
    @role_id INT
AS
BEGIN
    DELETE FROM user_role
    WHERE user_id = @user_id AND role_id = @role_id;
END;
GO

-----------------------------------------------------------------------------------------------------------------

-- =============================================
-- SP_GET_USER_BY_ID - Lấy user kèm roles
-- =============================================
CREATE OR ALTER PROC sp_get_user_by_id
    @user_id INT
AS
BEGIN
    -- 1. Lấy thông tin user
    SELECT 
        id, username, name, phone, email, 
        profile_picture_url, address, is_active,
        created_at, updated_at
    FROM users
    WHERE id = @user_id;

    -- 2. Lấy roles
    SELECT 
        r.id AS role_id,
        r.name AS role_name,
        r.description AS role_description
    FROM user_role ur
    JOIN roles r ON ur.role_id = r.id
    WHERE ur.user_id = @user_id;

    -- 3. Lấy permissions
    SELECT DISTINCT
        p.id AS permission_id,
        p.name AS permission_name
    FROM user_role ur
    JOIN role_permissions rp ON ur.role_id = rp.role_id
    JOIN permissions p ON rp.permission_id = p.id
    WHERE ur.user_id = @user_id;
END;
GO

----------------------------------------------------------------------------------------------------------------

-- =============================================
-- SP_GET_USER_BY_USERNAME - Lấy user theo username
-- =============================================
CREATE OR ALTER PROC sp_get_user_by_username
    @username VARCHAR(32)
AS
BEGIN
    SELECT 
        id, username, password_hash, name, phone, email, 
        profile_picture_url, address, is_active,
        created_at, updated_at
    FROM users
    WHERE username = @username;
END;
GO

----------------------------------------------------------------------------------------

-- =============================================
-- SP_GET_USERS - Tìm kiếm phân trang
-- =============================================
CREATE OR ALTER PROC sp_get_users
    @keyword NVARCHAR(100) = NULL,
    @role_id INT = NULL,
    @is_active BIT = NULL,
    @page INT = 1,
    @page_size INT = 10,
    @sort_by VARCHAR(30) = 'id',
    @sort_order VARCHAR(4) = 'ASC'
AS
BEGIN
    DECLARE @offset INT = (@page - 1) * @page_size;

    SELECT 
        u.id, u.username, u.name, u.phone, u.email,
        u.is_active, u.created_at, u.updated_at,
        STRING_AGG(r.name, ', ') AS roles
    FROM users u
    LEFT JOIN user_role ur ON u.id = ur.user_id
    LEFT JOIN roles r ON ur.role_id = r.id
    WHERE 
        (@keyword IS NULL OR 
         u.username LIKE '%' + @keyword + '%' OR 
         u.name LIKE '%' + @keyword + '%' OR 
         u.email LIKE '%' + @keyword + '%')
        AND (@role_id IS NULL OR ur.role_id = @role_id)
        AND (@is_active IS NULL OR u.is_active = @is_active)
    GROUP BY u.id, u.username, u.name, u.phone, u.email, u.is_active, u.created_at, u.updated_at
    ORDER BY 
        CASE WHEN @sort_by = 'id' AND @sort_order = 'ASC' THEN u.id END ASC,
        CASE WHEN @sort_by = 'id' AND @sort_order = 'DESC' THEN u.id END DESC,
        CASE WHEN @sort_by = 'username' AND @sort_order = 'ASC' THEN u.username END ASC,
        CASE WHEN @sort_by = 'username' AND @sort_order = 'DESC' THEN u.username END DESC,
        CASE WHEN @sort_by = 'name' AND @sort_order = 'ASC' THEN u.name END ASC,
        CASE WHEN @sort_by = 'name' AND @sort_order = 'DESC' THEN u.name END DESC,
        CASE WHEN @sort_by = 'created_at' AND @sort_order = 'ASC' THEN u.created_at END ASC,
        CASE WHEN @sort_by = 'created_at' AND @sort_order = 'DESC' THEN u.created_at END DESC
    OFFSET @offset ROWS
    FETCH NEXT @page_size ROWS ONLY;

    SELECT COUNT(DISTINCT u.id) AS total_count
    FROM users u
    LEFT JOIN user_role ur ON u.id = ur.user_id
    WHERE 
        (@keyword IS NULL OR 
         u.username LIKE '%' + @keyword + '%' OR 
         u.name LIKE '%' + @keyword + '%' OR 
         u.email LIKE '%' + @keyword + '%')
        AND (@role_id IS NULL OR ur.role_id = @role_id)
        AND (@is_active IS NULL OR u.is_active = @is_active);
END;
GO


----------------------------------------------------------------------------------------------------

-- =============================================
-- SP_GET_USERS_BY_ROLE - Lấy user theo role
-- =============================================
CREATE OR ALTER PROC sp_get_users_by_role
    @role_id INT,
    @is_active BIT = NULL,
    @page INT = 1,
    @page_size INT = 10
AS
BEGIN
    DECLARE @offset INT = (@page - 1) * @page_size;

    SELECT 
        u.id, u.username, u.name, u.email, u.phone,
        u.is_active, u.created_at
    FROM users u
    JOIN user_role ur ON u.id = ur.user_id
    WHERE ur.role_id = @role_id
        AND (@is_active IS NULL OR u.is_active = @is_active)
    ORDER BY u.id
    OFFSET @offset ROWS
    FETCH NEXT @page_size ROWS ONLY;

    SELECT COUNT(u.id) AS total_count
    FROM users u
    JOIN user_role ur ON u.id = ur.user_id
    WHERE ur.role_id = @role_id
        AND (@is_active IS NULL OR u.is_active = @is_active);
END;
GO


-------------------------------------------------------------------------------------------

-- =============================================
-- SP_GET_USER_ROLES - Lấy roles của user
-- =============================================
CREATE OR ALTER PROC sp_get_user_roles
    @user_id INT
AS
BEGIN
    SELECT 
        r.id AS role_id,
        r.name AS role_name,
        r.description AS role_description
    FROM user_role ur
    JOIN roles r ON ur.role_id = r.id
    WHERE ur.user_id = @user_id
    ORDER BY r.id;
END;
GO




-- Tăng tốc lọc user theo email, phone
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_phone ON users(phone);

-- Tăng tốc join user_role
CREATE INDEX idx_user_role_user_id ON user_role(user_id);
CREATE INDEX idx_user_role_role_id ON user_role(role_id);

-- Tăng tốc lọc permission
CREATE INDEX idx_role_permissions_role_id ON role_permissions(role_id);






-- update roles descriptions
update roles set description = 'normal user' where id = 1
update roles set description = 'admin with powered permission include manage account, manage product,...' where id = 2
update roles set description = 'product manager: manage product, add/remove/update/hide/show products' where id = 3

select u.id as userid, u.username, r.name from users u inner join user_role ur on u.id = ur.user_id inner join roles r on ur.role_id = r.id  order by u.id asc
select * from user_role
select * from role_permissions











-- =============================================
-- BẢNG: products
-- =============================================
CREATE TABLE products (
    id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(255) NOT NULL,
    description NVARCHAR(MAX) NULL,
    price DECIMAL(18, 2) NOT NULL CHECK (price >= 0), -- Giá bán, không âm
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0), -- Số lượng tồn kho
    category NVARCHAR(100) NULL,
    image_url VARCHAR(2048) NULL,
    is_active BIT DEFAULT 1, -- 1: Đang bán, 0: Ngừng bán
    created_at DATETIME2 DEFAULT GETDATE(),
    updated_at DATETIME2 DEFAULT GETDATE()
);
GO

-- Ràng buộc: Tên sản phẩm không được để trống và có độ dài tối thiểu
ALTER TABLE products ADD CONSTRAINT chk_product_name
CHECK (LEN(name) >= 3);

-- Ràng buộc: Giá bán phải lớn hơn 0 (đã có CHECK ở trên)
-- Ràng buộc: Số lượng tồn kho không âm (đã có CHECK ở trên)
GO








-- =============================================
-- BẢNG: carts
-- =============================================
CREATE TABLE carts (
    id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL UNIQUE, -- Mỗi user chỉ có 1 giỏ hàng
    created_at DATETIME2 DEFAULT GETDATE(),
    updated_at DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
GO

-- Chỉ mục để tăng tốc truy vấn giỏ hàng theo user_id
CREATE INDEX idx_carts_user_id ON carts(user_id);
GO




-- =============================================
-- BẢNG: cart_items
-- =============================================
CREATE TABLE cart_items (
    cart_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    added_at DATETIME2 DEFAULT GETDATE(),
    PRIMARY KEY (cart_id, product_id), -- Khóa chính kết hợp
    FOREIGN KEY (cart_id) REFERENCES carts(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);
GO

-- Chỉ mục để tăng tốc truy vấn
CREATE INDEX idx_cart_items_cart_id ON cart_items(cart_id);
CREATE INDEX idx_cart_items_product_id ON cart_items(product_id);
GO






-- =============================================
-- BẢNG: orders
-- =============================================
CREATE TABLE orders (
    id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    order_date DATETIME2 DEFAULT GETDATE(),
    total_amount DECIMAL(18, 2) NOT NULL CHECK (total_amount >= 0),
    status NVARCHAR(50) DEFAULT 'pending' -- pending, confirmed, shipping, delivered, cancelled
        CHECK (status IN ('pending', 'confirmed', 'shipping', 'delivered', 'cancelled')),
    shipping_address NVARCHAR(500) NOT NULL,
    payment_method NVARCHAR(50) NULL,
    note NVARCHAR(500) NULL,
    created_at DATETIME2 DEFAULT GETDATE(),
    updated_at DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
GO

-- Chỉ mục để tăng tốc truy vấn theo user_id và status
CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_orders_status ON orders(status);
GO









-- =============================================
-- BẢNG: order_details
-- =============================================
CREATE TABLE order_details (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price DECIMAL(18, 2) NOT NULL CHECK (price >= 0), -- Giá tại thời điểm mua
    total_line DECIMAL(18, 2) NOT NULL CHECK (total_line >= 0), -- quantity * price
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);
GO

-- Chỉ mục để tăng tốc truy vấn
CREATE INDEX idx_order_details_order_id ON order_details(order_id);
CREATE INDEX idx_order_details_product_id ON order_details(product_id);
GO










-- =============================================
-- SP_ADD_PRODUCT - Thêm sản phẩm mới
-- =============================================
CREATE OR ALTER PROC sp_add_product
    @name NVARCHAR(255),
    @description NVARCHAR(MAX) = NULL,
    @price DECIMAL(18, 2),
    @stock_quantity INT,
    @category NVARCHAR(100) = NULL,
    @image_url VARCHAR(2048) = NULL,
    @is_active BIT = 1
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (SELECT 1 FROM products WHERE name = @name)
    BEGIN
        RAISERROR('Sản phẩm với tên "%s" đã tồn tại!', 16, 1, @name);
        RETURN;
    END

    INSERT INTO products (name, description, price, stock_quantity, category, image_url, is_active)
    VALUES (@name, @description, @price, @stock_quantity, @category, @image_url, @is_active);

    SELECT SCOPE_IDENTITY() AS product_id, 'Thêm sản phẩm thành công!' AS Message;
END
GO




-- =============================================
-- SP_UPDATE_PRODUCT - Cập nhật sản phẩm
-- =============================================
CREATE OR ALTER PROC sp_update_product
    @product_id INT,
    @name NVARCHAR(255) = NULL,
    @description NVARCHAR(MAX) = NULL,
    @price DECIMAL(18, 2) = NULL,
    @stock_quantity INT = NULL,
    @category NVARCHAR(100) = NULL,
    @image_url VARCHAR(2048) = NULL,
    @is_active BIT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra sản phẩm tồn tại
    IF NOT EXISTS (SELECT 1 FROM products WHERE id = @product_id)
    BEGIN
        RAISERROR('Sản phẩm với ID %d không tồn tại!', 16, 1, @product_id);
        RETURN;
    END

    -- Kiểm tra tên trùng (nếu có thay đổi tên)
    IF @name IS NOT NULL AND EXISTS (SELECT 1 FROM products WHERE name = @name AND id <> @product_id)
    BEGIN
        RAISERROR('Tên sản phẩm "%s" đã tồn tại!', 16, 2, @name);
        RETURN;
    END

    UPDATE products
    SET 
        name = COALESCE(@name, name),
        description = COALESCE(@description, description),
        price = COALESCE(@price, price),
        stock_quantity = COALESCE(@stock_quantity, stock_quantity),
        category = COALESCE(@category, category),
        image_url = COALESCE(@image_url, image_url),
        is_active = COALESCE(@is_active, is_active),
        updated_at = GETDATE()
    WHERE id = @product_id;

    SELECT 'Cập nhật sản phẩm thành công!' AS Message;
END
GO





-- =============================================
-- SP_DELETE_PRODUCT - Xóa sản phẩm
-- =============================================
CREATE OR ALTER PROC sp_delete_product
    @product_id INT,
    @force_delete BIT = 0 -- 0: ẩn (is_active=0), 1: xóa cứng
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM products WHERE id = @product_id)
    BEGIN
        RAISERROR('Sản phẩm với ID %d không tồn tại!', 16, 1, @product_id);
        RETURN;
    END

    IF @force_delete = 0
    BEGIN
        UPDATE products SET is_active = 0, updated_at = GETDATE() WHERE id = @product_id;
        SELECT 'Đã ẩn sản phẩm!' AS Message;
    END
    ELSE
    BEGIN
        BEGIN TRANSACTION;
        BEGIN TRY
            DELETE FROM products WHERE id = @product_id;
            COMMIT TRANSACTION;
            SELECT 'Đã xóa sản phẩm!' AS Message;
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
            THROW;
        END CATCH
    END
END
GO




-- =============================================
-- SP_ADD_TO_CART - Thêm sản phẩm vào giỏ hàng
-- =============================================
ALTER PROC sp_add_to_cart
    @user_id INT,
    @product_id INT,
    @quantity INT = 1
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @cart_id INT;
    DECLARE @current_qty INT;
    DECLARE @stock INT;

    -- Kiểm tra user, product, stock
    IF NOT EXISTS (SELECT 1 FROM users WHERE id = @user_id)
        RAISERROR('Người dùng không tồn tại!', 16, 1) RETURN;
    
    SELECT @stock = stock_quantity FROM products WHERE id = @product_id AND is_active = 1;
    IF @stock IS NULL
        RAISERROR('Sản phẩm không tồn tại hoặc ngừng bán!', 16, 2) RETURN;
    
    -- Lấy cart
    SELECT @cart_id = id FROM carts WHERE user_id = @user_id;
    IF @cart_id IS NULL
    BEGIN
        INSERT INTO carts (user_id) VALUES (@user_id);
        SET @cart_id = SCOPE_IDENTITY();
    END

    -- Kiểm tra nếu đã có thì lấy số lượng hiện tại
    SELECT @current_qty = quantity FROM cart_items WHERE cart_id = @cart_id AND product_id = @product_id;
    
    IF @current_qty IS NULL
    BEGIN
        IF @quantity > @stock
            RAISERROR('Số lượng yêu cầu vượt quá tồn kho!', 16, 3) RETURN;
        INSERT INTO cart_items (cart_id, product_id, quantity) VALUES (@cart_id, @product_id, @quantity);
    END
    ELSE
    BEGIN
        IF (@current_qty + @quantity) > @stock
            RAISERROR('Tổng số lượng trong giỏ vượt quá tồn kho!', 16, 4) RETURN;
        UPDATE cart_items SET quantity = quantity + @quantity WHERE cart_id = @cart_id AND product_id = @product_id;
    END

    SELECT 'Đã thêm sản phẩm vào giỏ hàng!' AS Message;
END
GO



-- =============================================
-- SP_GET_CART - Xem giỏ hàng của user
-- =============================================
CREATE OR ALTER PROC sp_get_cart
    @user_id INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        p.id AS product_id,
        p.name AS product_name,
        p.price,
        ci.quantity,
        (ci.quantity * p.price) AS total_price,
        p.image_url
    FROM carts c
    JOIN cart_items ci ON c.id = ci.cart_id
    JOIN products p ON ci.product_id = p.id
    WHERE c.user_id = @user_id
    ORDER BY ci.added_at DESC;
END
GO




-- =============================================
-- SP_CREATE_ORDER_FROM_CART - Tạo hóa đơn từ giỏ hàng
-- =============================================
ALTER PROC sp_create_order_from_cart
    @user_id INT,
    @shipping_address NVARCHAR(500),
    @payment_method NVARCHAR(50) = NULL,
    @note NVARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @cart_id INT;
    DECLARE @order_id INT;
    DECLARE @total_amount DECIMAL(18,2) = 0;

    BEGIN TRANSACTION;
    BEGIN TRY
        SELECT @cart_id = id FROM carts WHERE user_id = @user_id;
        IF @cart_id IS NULL OR NOT EXISTS (SELECT 1 FROM cart_items WHERE cart_id = @cart_id)
        BEGIN
            RAISERROR('Giỏ hàng trống!', 16, 1);
            ROLLBACK; RETURN;
        END

        -- Kiểm tra tồn kho đủ cho tất cả sản phẩm
        IF EXISTS (
            SELECT 1
            FROM cart_items ci
            JOIN products p ON ci.product_id = p.id
            WHERE ci.cart_id = @cart_id AND p.stock_quantity < ci.quantity
        )
        BEGIN
            RAISERROR('Một số sản phẩm không đủ tồn kho!', 16, 2);
            ROLLBACK; RETURN;
        END

        -- Tính tổng tiền
        SELECT @total_amount = SUM(ci.quantity * p.price)
        FROM cart_items ci
        JOIN products p ON ci.product_id = p.id
        WHERE ci.cart_id = @cart_id;

        -- Tạo đơn
        INSERT INTO orders (user_id, total_amount, shipping_address, payment_method, note, status)
        VALUES (@user_id, @total_amount, @shipping_address, @payment_method, @note, 'pending');
        SET @order_id = SCOPE_IDENTITY();

        -- Thêm chi tiết
        INSERT INTO order_details (order_id, product_id, quantity, price, total_line)
        SELECT @order_id, ci.product_id, ci.quantity, p.price, ci.quantity * p.price
        FROM cart_items ci
        JOIN products p ON ci.product_id = p.id
        WHERE ci.cart_id = @cart_id;

        -- Trừ tồn kho
        UPDATE p
        SET p.stock_quantity = p.stock_quantity - ci.quantity
        FROM products p
        JOIN cart_items ci ON p.id = ci.product_id
        WHERE ci.cart_id = @cart_id;

        -- Xóa giỏ hàng
        DELETE FROM cart_items WHERE cart_id = @cart_id;
        -- (giữ lại carts trống)

        COMMIT TRANSACTION;
        SELECT @order_id AS order_id, 'Tạo đơn thành công!' AS Message;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO


-- =============================================
-- SP_GET_ORDERS_BY_USER - Xem danh sách hóa đơn
-- =============================================
CREATE OR ALTER PROC sp_get_orders_by_user
    @user_id INT,
    @status NVARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        id AS order_id,
        order_date,
        total_amount,
        status,
        shipping_address,
        payment_method,
        note,
        created_at,
        updated_at
    FROM orders
    WHERE user_id = @user_id
        AND (@status IS NULL OR status = @status)
    ORDER BY order_date DESC;
END
GO







-- =============================================
-- SP_GET_ORDER_DETAILS - Xem chi tiết hóa đơn
-- =============================================
CREATE OR ALTER PROC sp_get_order_details
    @order_id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Thông tin hóa đơn
    SELECT 
        o.id AS order_id,
        o.order_date,
        o.total_amount,
        o.status,
        o.shipping_address,
        o.payment_method,
        o.note,
        u.username,
        u.name AS customer_name,
        u.phone,
        u.email
    FROM orders o
    JOIN users u ON o.user_id = u.id
    WHERE o.id = @order_id;

    -- Chi tiết sản phẩm trong hóa đơn
    SELECT 
        od.product_id,
        p.name AS product_name,
        od.quantity,
        od.price,
        od.total_line
    FROM order_details od
    JOIN products p ON od.product_id = p.id
    WHERE od.order_id = @order_id;
END
GO




-- =============================================
-- SP_REMOVE_FROM_CART - Xóa sản phẩm khỏi giỏ hàng
-- =============================================
CREATE OR ALTER PROC sp_remove_from_cart
    @user_id INT,
    @product_id INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @cart_id INT;

    -- Kiểm tra user tồn tại
    IF NOT EXISTS (SELECT 1 FROM users WHERE id = @user_id)
    BEGIN
        RAISERROR('Người dùng với ID %d không tồn tại!', 16, 1, @user_id);
        RETURN;
    END;

    -- Kiểm tra giỏ hàng của user
    SELECT @cart_id = id FROM carts WHERE user_id = @user_id;
    IF @cart_id IS NULL
    BEGIN
        RAISERROR('Giỏ hàng của người dùng trống!', 16, 2);
        RETURN;
    END;

    -- Kiểm tra sản phẩm có trong giỏ không
    IF NOT EXISTS (SELECT 1 FROM cart_items WHERE cart_id = @cart_id AND product_id = @product_id)
    BEGIN
        RAISERROR('Sản phẩm với ID %d không có trong giỏ hàng!', 16, 3, @product_id);
        RETURN;
    END;

    -- Xóa sản phẩm khỏi giỏ
    DELETE FROM cart_items
    WHERE cart_id = @cart_id AND product_id = @product_id;

    SELECT 'Đã xóa sản phẩm khỏi giỏ hàng!' AS Message;
END
GO


-- =============================================
-- SP_UPDATE_CART_ITEM_QUANTITY - Cập nhật số lượng sản phẩm trong giỏ
-- =============================================
CREATE OR ALTER PROC sp_update_cart_item_quantity
    @user_id INT,
    @product_id INT,
    @new_quantity INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @cart_id INT;
    DECLARE @stock INT;

    -- Kiểm tra số lượng hợp lệ (>0)
    IF @new_quantity <= 0
    BEGIN
        RAISERROR('Số lượng phải lớn hơn 0!', 16, 1);
        RETURN;
    END;

    -- Kiểm tra user tồn tại
    IF NOT EXISTS (SELECT 1 FROM users WHERE id = @user_id)
    BEGIN
        RAISERROR('Người dùng với ID %d không tồn tại!', 16, 2, @user_id);
        RETURN;
    END;

    -- Kiểm tra sản phẩm tồn tại và đang hoạt động
    SELECT @stock = stock_quantity FROM products WHERE id = @product_id AND is_active = 1;
    IF @stock IS NULL
    BEGIN
        RAISERROR('Sản phẩm không tồn tại hoặc đã ngừng bán!', 16, 3, @product_id);
        RETURN;
    END;

    -- Kiểm tra số lượng tồn kho đủ
    IF @stock < @new_quantity
    BEGIN
        RAISERROR('Số lượng tồn kho không đủ! (Còn %d)', 16, 4, @stock);
        RETURN;
    END;

    -- Lấy giỏ hàng
    SELECT @cart_id = id FROM carts WHERE user_id = @user_id;
    IF @cart_id IS NULL
    BEGIN
        RAISERROR('Giỏ hàng của người dùng trống!', 16, 5);
        RETURN;
    END;

    -- Kiểm tra sản phẩm có trong giỏ không
    IF NOT EXISTS (SELECT 1 FROM cart_items WHERE cart_id = @cart_id AND product_id = @product_id)
    BEGIN
        RAISERROR('Sản phẩm với ID %d không có trong giỏ hàng!', 16, 6, @product_id);
        RETURN;
    END;

    -- Cập nhật số lượng
    UPDATE cart_items
    SET quantity = @new_quantity
    WHERE cart_id = @cart_id AND product_id = @product_id;

    SELECT 'Đã cập nhật số lượng sản phẩm!' AS Message;
END
GO


-- =============================================
-- SP_CANCEL_ORDER - Hủy đơn hàng (chỉ hủy khi đang pending)
-- =============================================
CREATE OR ALTER PROC sp_cancel_order
    @order_id INT,
    @user_id INT = NULL -- tùy chọn: kiểm tra quyền hủy (chỉ chủ sở hữu hoặc admin mới được hủy)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @current_status NVARCHAR(50);
    DECLARE @order_user_id INT;

    -- Kiểm tra đơn hàng tồn tại
    SELECT @current_status = status, @order_user_id = user_id
    FROM orders
    WHERE id = @order_id;

    IF @current_status IS NULL
    BEGIN
        RAISERROR('Đơn hàng với ID %d không tồn tại!', 16, 1, @order_id);
        RETURN;
    END;

    -- Nếu có truyền user_id, kiểm tra quyền hủy (chỉ người tạo đơn mới hủy được)
    IF @user_id IS NOT NULL AND @order_user_id <> @user_id
    BEGIN
        RAISERROR('Bạn không có quyền hủy đơn hàng này!', 16, 2);
        RETURN;
    END;

    -- Chỉ cho phép hủy nếu đơn hàng đang ở trạng thái pending
    IF @current_status <> 'pending'
    BEGIN
        RAISERROR('Đơn hàng đang ở trạng thái "%s", không thể hủy!', 16, 3, @current_status);
        RETURN;
    END;

    -- Bắt đầu transaction để hoàn lại tồn kho
    BEGIN TRANSACTION;
    BEGIN TRY
        -- Hoàn lại số lượng tồn kho cho từng sản phẩm trong đơn hàng
        UPDATE p
        SET p.stock_quantity = p.stock_quantity + od.quantity
        FROM products p
        JOIN order_details od ON p.id = od.product_id
        WHERE od.order_id = @order_id;

        -- Cập nhật trạng thái đơn hàng thành 'cancelled'
        UPDATE orders
        SET status = 'cancelled', updated_at = GETDATE()
        WHERE id = @order_id;

        COMMIT TRANSACTION;
        SELECT 'Đã hủy đơn hàng và hoàn lại tồn kho!' AS Message;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO




-- ==========================================================
-- 1. STORED PROCEDURE: TÌM KIẾM SẢN PHẨM (CÓ PHÂN TRANG)
-- ==========================================================
CREATE OR ALTER PROC sp_search_products
    @keyword NVARCHAR(255) = NULL,
    @category NVARCHAR(100) = NULL,
    @min_price DECIMAL(18,2) = NULL,
    @max_price DECIMAL(18,2) = NULL,
    @is_active BIT = 1,
    @page INT = 1,
    @page_size INT = 10,
    @sort_by VARCHAR(30) = 'id',
    @sort_order VARCHAR(4) = 'ASC'
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @offset INT = (@page - 1) * @page_size;

    SELECT 
        id, name, description, price, stock_quantity, 
        category, image_url, is_active, created_at, updated_at
    FROM products
    WHERE 
        (@keyword IS NULL OR name LIKE '%' + @keyword + '%' OR description LIKE '%' + @keyword + '%')
        AND (@category IS NULL OR category = @category)
        AND (@min_price IS NULL OR price >= @min_price)
        AND (@max_price IS NULL OR price <= @max_price)
        AND (@is_active IS NULL OR is_active = @is_active)
    ORDER BY 
        CASE WHEN @sort_by = 'id' AND @sort_order = 'ASC' THEN id END ASC,
        CASE WHEN @sort_by = 'id' AND @sort_order = 'DESC' THEN id END DESC,
        CASE WHEN @sort_by = 'price' AND @sort_order = 'ASC' THEN price END ASC,
        CASE WHEN @sort_by = 'price' AND @sort_order = 'DESC' THEN price END DESC,
        CASE WHEN @sort_by = 'name' AND @sort_order = 'ASC' THEN name END ASC,
        CASE WHEN @sort_by = 'name' AND @sort_order = 'DESC' THEN name END DESC,
        CASE WHEN @sort_by = 'stock_quantity' AND @sort_order = 'ASC' THEN stock_quantity END ASC,
        CASE WHEN @sort_by = 'stock_quantity' AND @sort_order = 'DESC' THEN stock_quantity END DESC
    OFFSET @offset ROWS
    FETCH NEXT @page_size ROWS ONLY;

    -- Đếm tổng số bản ghi (cho phân trang)
    SELECT COUNT(id) AS total_count
    FROM products
    WHERE 
        (@keyword IS NULL OR name LIKE '%' + @keyword + '%' OR description LIKE '%' + @keyword + '%')
        AND (@category IS NULL OR category = @category)
        AND (@min_price IS NULL OR price >= @min_price)
        AND (@max_price IS NULL OR price <= @max_price)
        AND (@is_active IS NULL OR is_active = @is_active);
END
GO


-- ==========================================================
-- 2. TRIGGER: TỰ ĐỘNG CẬP NHẬT updated_at (CHO TẤT CẢ BẢNG)
-- ==========================================================
-- Trigger cho bảng Products
CREATE OR ALTER TRIGGER trg_products_updated_at ON products
AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    UPDATE products 
    SET updated_at = GETDATE()
    FROM inserted i
    WHERE products.id = i.id;
END
GO

-- Trigger cho bảng Users
CREATE OR ALTER TRIGGER trg_users_updated_at ON users
AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    UPDATE users 
    SET updated_at = GETDATE()
    FROM inserted i
    WHERE users.id = i.id;
END
GO

-- Trigger cho bảng Orders
CREATE OR ALTER TRIGGER trg_orders_updated_at ON orders
AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    UPDATE orders 
    SET updated_at = GETDATE()
    FROM inserted i
    WHERE orders.id = i.id;
END
GO

-- Trigger cho bảng Carts (phòng khi bạn update giỏ hàng sau này)
CREATE OR ALTER TRIGGER trg_carts_updated_at ON carts
AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    UPDATE carts 
    SET updated_at = GETDATE()
    FROM inserted i
    WHERE carts.id = i.id;
END
GO




CREATE OR ALTER PROC sp_update_order_status
    @order_id INT,
    @new_status NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM orders WHERE id = @order_id)
    BEGIN
        RAISERROR('Đơn hàng không tồn tại!', 16, 1);
        RETURN;
    END
    IF @new_status NOT IN ('pending','confirmed','shipping','delivered','cancelled')
    BEGIN
        RAISERROR('Trạng thái không hợp lệ!', 16, 2);
        RETURN;
    END
    UPDATE orders SET status = @new_status WHERE id = @order_id;
    SELECT 'Cập nhật trạng thái thành công!' AS Message;
END
GO
