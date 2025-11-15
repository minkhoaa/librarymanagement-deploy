-- Sample dataset for the LibraryManagement schema built in script.sql
-- Run this after executing script.sql to quickly populate the database with rich demo data.
BEGIN;

TRUNCATE TABLE
    OTP,
    FAVORITEBOOK,
    INVALIDATE_TOKEN,
    ROLE_PERMISSION,
    EVALUATE,
    IMAGE,
    OVERDUE_REPORTDETAIL,
    OVERDUE_REPORT,
    CATEGORY_REPORTDETAIL,
    CATEGORY_REPORT,
    PENALTY_TICKET,
    LOAN_SLIPBOOK,
    DETAIL_BOOKRECEIPT,
    BOOKRECEIPT,
    BOOK_WRITING,
    THEBOOK,
    BOOK,
    HEADERBOOK,
    AUTHOR,
    TYPEBOOK,
    READER,
    PERMISSIONS,
    ROLES,
    TYPEREADER,
    PARAMETERS
RESTART IDENTITY CASCADE;

INSERT INTO TYPEREADER (ID_TYPEREADER, NAME_TYPEREADER) VALUES
    ('3fa85f64-5717-4562-b3fc-2c963f66afa6', 'Reader'),
    ('c5a21a89-7f6b-4d52-9833-bbf7bcd4c001', 'Student'),
    ('71dfbf98-e39c-44fd-b757-63eb5d7eb363', 'Lecturer'),
    ('4b27b24f-d13e-4ea0-8a52-7f3f5ac1564c', 'Researcher'),
    ('8c6032af-7275-4fd4-a32f-289ec7078932', 'VIP')
ON CONFLICT (ID_TYPEREADER) DO NOTHING;

INSERT INTO ROLES (ROLE_NAME, DESCRIPTION) VALUES
    ('Reader', 'Default reader role'),
    ('Admin', 'System administrator with full privileges'),
    ('Librarian', 'Library staff member')
ON CONFLICT (ROLE_NAME) DO NOTHING;

INSERT INTO PERMISSIONS (PERMISSION_NAME, DESCRIPTION) VALUES
    ('ManageBooks', 'Create or update book metadata'),
    ('ManageReaders', 'Approve registrations and update reader profiles'),
    ('ViewReports', 'View operational reports'),
    ('ManageLoans', 'Handle borrow/return flow'),
    ('ManageSystem', 'System-level maintenance operations'),
    ('BorrowBooks', 'Place borrowing requests'),
    ('ConfigureParameters', 'Tweak policy parameters')
ON CONFLICT (PERMISSION_NAME) DO NOTHING;

INSERT INTO ROLE_PERMISSION (ROLE_NAME, PERMISSION_NAME) VALUES
    ('Reader', 'BorrowBooks'),
    ('Librarian', 'ManageBooks'),
    ('Librarian', 'ManageReaders'),
    ('Librarian', 'ManageLoans'),
    ('Librarian', 'ViewReports'),
    ('Admin', 'ManageBooks'),
    ('Admin', 'ManageReaders'),
    ('Admin', 'ManageLoans'),
    ('Admin', 'ViewReports'),
    ('Admin', 'ManageSystem'),
    ('Admin', 'ConfigureParameters')
ON CONFLICT DO NOTHING;

INSERT INTO PARAMETERS (ID_PARAMETER, NAME_PARAMETER, VALUE_PARAMETER) VALUES
    ('1fd6c8ed-98fd-4d08-a217-08c9db18e0e9', 'MaxBorrowBooks', 5),
    ('f34e280a-202f-4d5f-87d5-a8c65b8ef8cc', 'MaxBorrowDays', 14),
    ('87dfe0d0-d557-4e1c-8276-022091e05c83', 'MinReaderAge', 15),
    ('bcd2b1cc-95f8-441a-bdb4-100fef2233ef', 'PenaltyPerLateDay', 3000)
ON CONFLICT DO NOTHING;

INSERT INTO TYPEBOOK (ID_TYPEBOOK, NAME_TYPEBOOK) VALUES
    ('801f9c7e-9350-4b5c-9c15-82bc5eac4290', 'Fiction'),
    ('c6df44b0-5775-4c04-a34c-6b62e1f7c5b5', 'Science'),
    ('1d2dcee0-9ad1-43f9-9b89-3ef1d6400edb', 'Technology'),
    ('84cc0d3b-4a21-4f90-9fba-9ffd1cd71d4d', 'History'),
    ('f72c1ee5-bf42-4a4e-8706-c63d473fa3ec', 'Children'),
    ('d1611459-5421-4db2-9a82-0de8030c4ad1', 'Business')
ON CONFLICT (ID_TYPEBOOK) DO NOTHING;

INSERT INTO AUTHOR (ID_AUTHOR, ID_TYPEBOOK, NAME_AUTHOR, NATIONALITY, BIOGRAPHY) VALUES
    ('6a3f4b20-7786-44a1-9c16-efdfd3c829b8', 'f72c1ee5-bf42-4a4e-8706-c63d473fa3ec', 'Nguyễn Nhật Ánh', 'Việt Nam', 'Writer of beloved Vietnamese children novels'),
    ('5ab33eb4-d576-4e23-93a8-0d62b1f6fd1b', 'd1611459-5421-4db2-9a82-0de8030c4ad1', 'Malcolm Gladwell', 'Canada', 'Business-themed non-fiction author'),
    ('3bf729f9-a20f-4c68-84e6-8c6714bb7a57', 'c6df44b0-5775-4c04-a34c-6b62e1f7c5b5', 'Stephen Hawking', 'United Kingdom', 'Physicist and cosmologist'),
    ('a520b190-2b0f-4d58-8eb6-5b9f9fefde10', '1d2dcee0-9ad1-43f9-9b89-3ef1d6400edb', 'Walter Isaacson', 'United States', 'Biographer focusing on technology pioneers'),
    ('d8516f6b-b91e-4ed9-9b34-4d6d651d4d77', '801f9c7e-9350-4b5c-9c15-82bc5eac4290', 'Dan Brown', 'United States', 'Thriller novelist'),
    ('4d815d49-5b50-4d24-ac9d-82543292170c', '84cc0d3b-4a21-4f90-9fba-9ffd1cd71d4d', 'Yuval Noah Harari', 'Israel', 'Historian and philosopher'),
    ('d09fb3e5-3cb9-43b0-bcb1-44f601acb9dc', '801f9c7e-9350-4b5c-9c15-82bc5eac4290', 'Haruki Murakami', 'Japan', 'Literary fiction novelist'),
    ('b0fa6128-7cfb-4a0d-836e-49b5214001bd', 'd1611459-5421-4db2-9a82-0de8030c4ad1', 'Marie Kondo', 'Japan', 'Lifestyle and productivity writer'),
    ('b8be0ed7-8559-4d4e-abc8-705399a8ce28', '1d2dcee0-9ad1-43f9-9b89-3ef1d6400edb', 'Robert C. Martin', 'United States', 'Software craftsmanship advocate'),
    ('a586ecc5-30ad-44c1-b26c-3df57db4e303', 'd1611459-5421-4db2-9a82-0de8030c4ad1', 'Eric Ries', 'United States', 'Entrepreneur and startup advisor'),
    ('96889fb9-8b59-4f33-9b61-0d293b7624fe', 'f72c1ee5-bf42-4a4e-8706-c63d473fa3ec', 'J.K. Rowling', 'United Kingdom', 'Creator of the Harry Potter series'),
    ('9566916d-0251-4d91-a68a-8036f2fa14de', 'd1611459-5421-4db2-9a82-0de8030c4ad1', 'Daniel Kahneman', 'Israel', 'Psychologist, author of Thinking, Fast and Slow'),
    ('65f2fca2-e3f4-4f43-8ed3-219651350a0a', '801f9c7e-9350-4b5c-9c15-82bc5eac4290', 'Chimamanda Ngozi Adichie', 'Nigeria', 'Contemporary fiction writer')
ON CONFLICT (ID_AUTHOR) DO NOTHING;

INSERT INTO HEADERBOOK (ID_HEADERBOOK, ID_TYPEBOOK, NAME_HEADERBOOK, DESCRIBE_BOOK) VALUES
    ('719a9a42-83c1-42e8-9545-158b3b2a68d0', 'f72c1ee5-bf42-4a4e-8706-c63d473fa3ec', 'Dế Mèn Phiêu Lưu Ký', 'Vietnamese classic coming-of-age adventure'),
    ('e829af9b-1738-458d-b879-96c7c7a0e57d', '84cc0d3b-4a21-4f90-9fba-9ffd1cd71d4d', 'Sapiens', 'Brief history of humankind'),
    ('ddceb7a8-5ed1-4524-886e-3dbb6c95e4b3', '801f9c7e-9350-4b5c-9c15-82bc5eac4290', 'Digital Fortress', 'Techno-thriller novel by Dan Brown'),
    ('f6aa1d1f-2f26-4f75-933d-4d7d05f49faf', '1d2dcee0-9ad1-43f9-9b89-3ef1d6400edb', 'Clean Code', 'Handbook of agile software craftsmanship'),
    ('e916a487-d5e0-469b-bdfb-289adfd7a954', 'c6df44b0-5775-4c04-a34c-6b62e1f7c5b5', 'A Brief History of Time', 'Science classic on cosmology'),
    ('18284d88-aedb-4ee6-9abf-30962ad61b69', 'd1611459-5421-4db2-9a82-0de8030c4ad1', 'The Lean Startup', 'Build-measure-learn startup framework'),
    ('e87bbdf2-919f-4029-9b46-56e6c8007e0b', '801f9c7e-9350-4b5c-9c15-82bc5eac4290', 'Kafka on the Shore', 'Surreal literary fiction'),
    ('cf0a6e33-6cbe-4d25-8f42-5578e2890e1f', 'f72c1ee5-bf42-4a4e-8706-c63d473fa3ec', 'Harry Potter and the Sorcerer''s Stone', 'Magical adventure for young readers'),
    ('f3483bf7-d5a1-4cb2-8b0a-4a0d78d87aea', '1d2dcee0-9ad1-43f9-9b89-3ef1d6400edb', 'The Innovators', 'Chronicles the digital revolution'),
    ('1177c94c-8d0d-4d18-a364-2d8d631ca24a', 'd1611459-5421-4db2-9a82-0de8030c4ad1', 'Thinking, Fast and Slow', 'Behavioral economics classic'),
    ('9f7df528-b6db-44c6-8097-243ffe9fcb5f', 'd1611459-5421-4db2-9a82-0de8030c4ad1', 'The Life-Changing Magic of Tidying Up', 'Decluttering and minimalism guide'),
    ('c04ba1d0-0b12-40f0-933a-2332dbe5285b', '801f9c7e-9350-4b5c-9c15-82bc5eac4290', 'Norwegian Wood', 'Bittersweet coming-of-age story')
ON CONFLICT (ID_HEADERBOOK) DO NOTHING;

INSERT INTO BOOK (ID_BOOK, ID_HEADERBOOK, PUBLISHER, REPRINT_YEAR, VALUEOFBOOK) VALUES
    ('B000001', '719a9a42-83c1-42e8-9545-158b3b2a68d0', 'Kim Đồng', 2023, 85000),
    ('B000002', 'e829af9b-1738-458d-b879-96c7c7a0e57d', 'Harper', 2022, 230000),
    ('B000003', 'ddceb7a8-5ed1-4524-886e-3dbb6c95e4b3', 'St. Martin''s', 2018, 180000),
    ('B000004', 'f6aa1d1f-2f26-4f75-933d-4d7d05f49faf', 'Prentice Hall', 2021, 350000),
    ('B000005', 'e916a487-d5e0-469b-bdfb-289adfd7a954', 'Bantam', 2020, 250000),
    ('B000006', '18284d88-aedb-4ee6-9abf-30962ad61b69', 'Crown Business', 2022, 280000),
    ('B000007', 'e87bbdf2-919f-4029-9b46-56e6c8007e0b', 'Vintage', 2019, 190000),
    ('B000008', 'cf0a6e33-6cbe-4d25-8f42-5578e2890e1f', 'Bloomsbury', 2021, 210000),
    ('B000009', 'f3483bf7-d5a1-4cb2-8b0a-4a0d78d87aea', 'Simon & Schuster', 2021, 320000),
    ('B000010', '1177c94c-8d0d-4d18-a364-2d8d631ca24a', 'Farrar Straus and Giroux', 2020, 260000),
    ('B000011', '9f7df528-b6db-44c6-8097-243ffe9fcb5f', 'Ten Speed Press', 2020, 150000),
    ('B000012', 'c04ba1d0-0b12-40f0-933a-2332dbe5285b', 'Vintage', 2017, 175000)
ON CONFLICT (ID_BOOK) DO NOTHING;

INSERT INTO THEBOOK (ID_THEBOOK, ID_BOOK, STATUS) VALUES
    ('TB00001', 'B000001', 'Có sẵn'),
    ('TB00002', 'B000001', 'Có sẵn'),
    ('TB00003', 'B000001', 'Có sẵn'),
    ('TB00004', 'B000002', 'Có sẵn'),
    ('TB00005', 'B000002', 'Đã mượn'),
    ('TB00006', 'B000002', 'Có sẵn'),
    ('TB00007', 'B000003', 'Có sẵn'),
    ('TB00008', 'B000003', 'Có sẵn'),
    ('TB00009', 'B000003', 'Có sẵn'),
    ('TB00010', 'B000004', 'Đã mượn'),
    ('TB00011', 'B000004', 'Có sẵn'),
    ('TB00012', 'B000004', 'Có sẵn'),
    ('TB00013', 'B000005', 'Đã mượn'),
    ('TB00014', 'B000005', 'Có sẵn'),
    ('TB00015', 'B000005', 'Có sẵn'),
    ('TB00016', 'B000006', 'Có sẵn'),
    ('TB00017', 'B000006', 'Có sẵn'),
    ('TB00018', 'B000006', 'Đã mượn'),
    ('TB00019', 'B000007', 'Có sẵn'),
    ('TB00020', 'B000007', 'Đã mượn'),
    ('TB00021', 'B000007', 'Có sẵn'),
    ('TB00022', 'B000008', 'Có sẵn'),
    ('TB00023', 'B000008', 'Đã mượn'),
    ('TB00024', 'B000008', 'Có sẵn'),
    ('TB00025', 'B000009', 'Có sẵn'),
    ('TB00026', 'B000009', 'Đã mượn'),
    ('TB00027', 'B000009', 'Có sẵn'),
    ('TB00028', 'B000010', 'Có sẵn'),
    ('TB00029', 'B000010', 'Có sẵn'),
    ('TB00030', 'B000010', 'Có sẵn'),
    ('TB00031', 'B000011', 'Có sẵn'),
    ('TB00032', 'B000011', 'Có sẵn'),
    ('TB00033', 'B000011', 'Đã mượn'),
    ('TB00034', 'B000012', 'Có sẵn'),
    ('TB00035', 'B000012', 'Đã mượn'),
    ('TB00036', 'B000012', 'Có sẵn')
ON CONFLICT (ID_THEBOOK) DO NOTHING;

INSERT INTO BOOK_WRITING (ID_HEADERBOOK, ID_AUTHOR) VALUES
    ('719a9a42-83c1-42e8-9545-158b3b2a68d0', '6a3f4b20-7786-44a1-9c16-efdfd3c829b8'),
    ('e829af9b-1738-458d-b879-96c7c7a0e57d', '4d815d49-5b50-4d24-ac9d-82543292170c'),
    ('ddceb7a8-5ed1-4524-886e-3dbb6c95e4b3', 'd8516f6b-b91e-4ed9-9b34-4d6d651d4d77'),
    ('f6aa1d1f-2f26-4f75-933d-4d7d05f49faf', 'b8be0ed7-8559-4d4e-abc8-705399a8ce28'),
    ('e916a487-d5e0-469b-bdfb-289adfd7a954', '3bf729f9-a20f-4c68-84e6-8c6714bb7a57'),
    ('18284d88-aedb-4ee6-9abf-30962ad61b69', 'a586ecc5-30ad-44c1-b26c-3df57db4e303'),
    ('e87bbdf2-919f-4029-9b46-56e6c8007e0b', 'd09fb3e5-3cb9-43b0-bcb1-44f601acb9dc'),
    ('cf0a6e33-6cbe-4d25-8f42-5578e2890e1f', '96889fb9-8b59-4f33-9b61-0d293b7624fe'),
    ('f3483bf7-d5a1-4cb2-8b0a-4a0d78d87aea', 'a520b190-2b0f-4d58-8eb6-5b9f9fefde10'),
    ('1177c94c-8d0d-4d18-a364-2d8d631ca24a', '9566916d-0251-4d91-a68a-8036f2fa14de'),
    ('9f7df528-b6db-44c6-8097-243ffe9fcb5f', 'b0fa6128-7cfb-4a0d-836e-49b5214001bd'),
    ('c04ba1d0-0b12-40f0-933a-2332dbe5285b', 'd09fb3e5-3cb9-43b0-bcb1-44f601acb9dc'),
    ('e87bbdf2-919f-4029-9b46-56e6c8007e0b', '65f2fca2-e3f4-4f43-8ed3-219651350a0a');

INSERT INTO READER (ID_READER, ID_TYPEREADER, NAME_READER, SEX, ADDRESS, EMAIL, DOB, PHONE, READER_USERNAME, READER_PASSWORD, TOTAL_DEBT, ROLE_NAME) VALUES
    ('DG00001', 'c5a21a89-7f6b-4d52-9833-bbf7bcd4c001', 'Trần Minh Khoa', 'Nam', 'Thủ Đức, TP.HCM', 'khoa.tran@example.com', '1998-05-12', '0912000001', 'khoa.tran', 'hashed-password-1', 0, 'Reader'),
    ('DG00002', 'c5a21a89-7f6b-4d52-9833-bbf7bcd4c001', 'Lê Thị Thu Uyên', 'Nữ', 'Quận 3, TP.HCM', 'uyen.le@example.com', '2000-08-22', '0912000002', 'uyen.le', 'hashed-password-2', 0, 'Reader'),
    ('DG00003', '4b27b24f-d13e-4ea0-8a52-7f3f5ac1564c', 'Nguyễn Văn Tuấn', 'Nam', 'Quận 7, TP.HCM', 'tuan.research@example.com', '1989-11-03', '0912000003', 'tuan.ng', 'hashed-password-3', 5000, 'Reader'),
    ('DG00004', '3fa85f64-5717-4562-b3fc-2c963f66afa6', 'Phạm Quỳnh Anh', 'Nữ', 'Quận 1, TP.HCM', 'quynhanh.pham@example.com', '1995-01-15', '0912000004', 'anh.pham', 'hashed-password-4', 0, 'Reader'),
    ('DG00005', '71dfbf98-e39c-44fd-b757-63eb5d7eb363', 'Đỗ Hoàng Long', 'Nam', 'Quận Bình Thạnh, TP.HCM', 'long.do@example.com', '1984-04-09', '0912000005', 'long.do', 'hashed-password-5', 0, 'Librarian'),
    ('DG00006', 'c5a21a89-7f6b-4d52-9833-bbf7bcd4c001', 'Vũ Thị Thanh', 'Nữ', 'Quận Phú Nhuận, TP.HCM', 'thanh.vu@example.com', '1999-12-01', '0912000006', 'thanh.vu', 'hashed-password-6', 0, 'Reader'),
    ('DG00007', '4b27b24f-d13e-4ea0-8a52-7f3f5ac1564c', 'Bùi Duy Kiệt', 'Nam', 'TP. Thủ Đức', 'duykiet.bui@example.com', '1992-06-18', '0912000007', 'kiet.bui', 'hashed-password-7', 20000, 'Reader'),
    ('DG00008', '3fa85f64-5717-4562-b3fc-2c963f66afa6', 'Hoàng Mỹ Linh', 'Nữ', 'Quận Tân Bình, TP.HCM', 'linh.hoang@example.com', '1996-03-27', '0912000008', 'linh.hoang', 'hashed-password-8', 15000, 'Reader'),
    ('DG00009', '8c6032af-7275-4fd4-a32f-289ec7078932', 'Lê Quang Phúc', 'Nam', 'Quận 5, TP.HCM', 'phuc.vip@example.com', '1988-07-07', '0912000009', 'phuc.le', 'hashed-password-9', 0, 'Reader'),
    ('DG00010', '71dfbf98-e39c-44fd-b757-63eb5d7eb363', 'Phạm Đức Mạnh', 'Nam', 'Quận 10, TP.HCM', 'manh.pham@example.com', '1983-10-21', '0912000010', 'manh.pham', 'hashed-password-10', 0, 'Librarian'),
    ('DG00011', '71dfbf98-e39c-44fd-b757-63eb5d7eb363', 'Nguyễn Thanh Hà', 'Nữ', 'TP. Thủ Đức', 'ha.nguyen@example.com', '1985-02-05', '0912000011', 'ha.nguyen', 'hashed-password-11', 0, 'Admin'),
    ('DG00012', 'c5a21a89-7f6b-4d52-9833-bbf7bcd4c001', 'Đặng Gia Bảo', 'Nam', 'Quận Gò Vấp, TP.HCM', 'bao.dang@example.com', '2001-09-19', '0912000012', 'bao.dang', 'hashed-password-12', 0, 'Reader'),
    ('DG00026', 'c5a21a89-7f6b-4d52-9833-bbf7bcd4c001', 'Ngô Tường Vy', 'Nữ', 'Quận 2, TP.HCM', 'vy.ngo@example.com', '1999-04-23', '0912000026', 'vy.ngo', 'hashed-password-26', 0, 'Reader'),
    ('DG00027', '71dfbf98-e39c-44fd-b757-63eb5d7eb363', 'Phan Minh Trí', 'Nam', 'Quận Bình Tân, TP.HCM', 'tri.phan@example.com', '1987-11-30', '0912000027', 'tri.phan', 'hashed-password-27', 0, 'Librarian'),
    ('DG00028', '3fa85f64-5717-4562-b3fc-2c963f66afa6', 'Đinh Bảo Ngọc', 'Nữ', 'Quận 9, TP.HCM', 'ngoc.dinh@example.com', '1995-08-14', '0912000028', 'ngoc.dinh', 'hashed-password-28', 5000, 'Reader'),
    ('DG00029', '4b27b24f-d13e-4ea0-8a52-7f3f5ac1564c', 'Trương Quốc Huy', 'Nam', 'Quận 4, TP.HCM', 'huy.truong@example.com', '1991-02-08', '0912000029', 'huy.truong', 'hashed-password-29', 0, 'Reader'),
    ('DG00030', '8c6032af-7275-4fd4-a32f-289ec7078932', 'Võ Ngọc Hân', 'Nữ', 'Quận Phú Nhuận, TP.HCM', 'han.vo@example.com', '1990-07-01', '0912000030', 'han.vo', 'hashed-password-30', 0, 'Reader')
ON CONFLICT (ID_READER) DO NOTHING;

INSERT INTO BOOKRECEIPT (ID_BOOKRECEIPT, ID_READER, RECEIVED_DATE) VALUES
    ('297c3f2e-ba1d-4afe-9c82-8d22a06b2a67', 'DG00010', '2024-01-10'),
    ('7b26d2de-cb72-4d5e-b9b5-047c505796a2', 'DG00010', '2024-02-05'),
    ('c5d11270-d2f6-4b94-a0a7-33dcb162d432', 'DG00011', '2024-03-12')
ON CONFLICT (ID_BOOKRECEIPT) DO NOTHING;

INSERT INTO DETAIL_BOOKRECEIPT (ID_BOOKRECEIPT, ID_BOOK, QUANTITY, UNITPRICE) VALUES
    ('297c3f2e-ba1d-4afe-9c82-8d22a06b2a67', 'B000001', 10, 82000),
    ('297c3f2e-ba1d-4afe-9c82-8d22a06b2a67', 'B000004', 5, 340000),
    ('297c3f2e-ba1d-4afe-9c82-8d22a06b2a67', 'B000006', 4, 275000),
    ('7b26d2de-cb72-4d5e-b9b5-047c505796a2', 'B000002', 6, 220000),
    ('7b26d2de-cb72-4d5e-b9b5-047c505796a2', 'B000008', 8, 205000),
    ('7b26d2de-cb72-4d5e-b9b5-047c505796a2', 'B000010', 4, 255000),
    ('c5d11270-d2f6-4b94-a0a7-33dcb162d432', 'B000005', 5, 240000),
    ('c5d11270-d2f6-4b94-a0a7-33dcb162d432', 'B000009', 3, 315000),
    ('c5d11270-d2f6-4b94-a0a7-33dcb162d432', 'B000011', 7, 145000);

INSERT INTO LOAN_SLIPBOOK (ID_LOANSLIPBOOK, ID_THEBOOK, ID_READER, BORROW_DATE, RETURN_DATE, LOAN_PERIOD, FINE_AMOUNT, IS_RETURNED) VALUES
    ('f8b63501-6a2a-4af7-9a28-e6329a2b68fe', 'TB00002', 'DG00001', '2024-01-15', '2024-01-25', 10, 0, TRUE),
    ('ef4361a2-4b2c-4053-ab6f-3d8f128e6af4', 'TB00005', 'DG00002', '2024-03-02', NULL, 14, 0, FALSE),
    ('259cd0f7-1b93-44b9-93a3-20f8e6e8ffc2', 'TB00008', 'DG00003', '2024-02-15', '2024-03-05', 14, 5000, TRUE),
    ('3c95f340-9d8e-40fd-9650-aca0e933cbcb', 'TB00010', 'DG00004', '2024-03-15', NULL, 14, 0, FALSE),
    ('fcb17feb-76f1-4fb3-a59c-01e633598369', 'TB00013', 'DG00007', '2024-03-10', NULL, 14, 0, FALSE),
    ('c3b48aae-3779-4f6a-a3de-14617545973d', 'TB00018', 'DG00008', '2024-03-20', NULL, 14, 0, FALSE),
    ('0d1c8792-e54b-4be9-8a3a-70a1f2ff8905', 'TB00020', 'DG00009', '2024-03-08', NULL, 14, 0, FALSE),
    ('8df9bbab-6b57-4c07-826d-53e658cf1391', 'TB00023', 'DG00001', '2024-02-28', '2024-03-12', 14, 0, TRUE),
    ('c93b0b04-7f32-4f0b-8c1d-a4ffca1808bc', 'TB00026', 'DG00005', '2024-03-01', NULL, 21, 0, FALSE),
    ('1ad261ef-55a0-4fd7-a2e8-555393ca2f35', 'TB00015', 'DG00006', '2024-01-25', '2024-02-02', 10, 0, TRUE),
    ('9e2c51f7-1cd4-4d8a-b346-b719b82c1d70', 'TB00033', 'DG00003', '2024-03-12', NULL, 14, 0, FALSE),
    ('f4fa170f-654a-42e5-b980-aac9d918f6ad', 'TB00035', 'DG00012', '2024-03-18', NULL, 14, 0, FALSE),
    ('a88b6c9d-5ea8-4d34-8e7c-023f8bbda0e0', 'TB00006', 'DG00001', '2024-02-05', '2024-02-18', 13, 0, TRUE),
    ('dbe7eb37-d9f0-4d0c-9c56-ec7ae700b6c4', 'TB00011', 'DG00005', '2024-01-12', '2024-01-28', 16, 2000, TRUE),
    ('2bdeec7f-6adf-48b2-bb7f-6d749562d9e9', 'TB00030', 'DG00004', '2024-02-20', NULL, 14, 0, FALSE),
    ('f7bf9acf-8663-4df8-92a1-844b40614659', 'TB00014', 'DG00009', '2024-02-10', '2024-02-20', 10, 0, TRUE),
    ('f72a3b09-295e-4db7-b3b5-86017974f6d7', 'TB00027', 'DG00010', '2024-03-05', NULL, 18, 0, FALSE),
    ('0647cd7e-3f71-4d2c-a4c2-578654dc41d2', 'TB00032', 'DG00011', '2024-02-18', '2024-03-04', 15, 0, TRUE),
    ('a4c27f31-3b5b-41ef-9f8e-2fb9f76380dd', 'TB00017', 'DG00002', '2024-03-10', NULL, 12, 0, FALSE),
    ('5a2deaf7-6437-4528-8a88-e1af80f208ef', 'TB00029', 'DG00008', '2024-02-01', '2024-02-16', 15, 0, TRUE)
    ,
    ('af9a4c7f-8d11-49de-8f6d-7151a4551b2e', 'TB00003', 'DG00026', '2024-03-05', NULL, 14, 0, FALSE),
    ('be4a3fd3-1c54-4e33-b64a-798fb4341f92', 'TB00007', 'DG00027', '2024-02-12', '2024-02-25', 13, 0, TRUE),
    ('c5fa9f8a-9471-4bde-a408-7c41d5767e59', 'TB00012', 'DG00028', '2024-03-18', NULL, 14, 0, FALSE),
    ('d4e5aa2c-e7f6-4f48-8234-3fa281a7c451', 'TB00024', 'DG00029', '2024-02-27', '2024-03-10', 12, 0, TRUE),
    ('e9bd832f-0c8c-48bc-965c-5bc67dea8367', 'TB00031', 'DG00030', '2024-03-08', NULL, 14, 0, FALSE)
ON CONFLICT (ID_LOANSLIPBOOK) DO NOTHING;

INSERT INTO PENALTY_TICKET (ID_PENALTY, ID_READER, CREATED_DATE, AMOUNT_COLLECTED, AMOUNT_REMAINING) VALUES
    ('e4988840-52d9-4c33-bd77-3d01c7f750ec', 'DG00003', '2024-03-06 10:15:00', 20000, 5000),
    ('13fd1892-3852-4bfe-93d4-86a84f1e3723', 'DG00008', '2024-02-20 09:10:00', 0, 15000),
    ('cf1bcb1e-25b7-4c31-9453-2342635ee11e', 'DG00002', '2024-01-30 15:30:00', 10000, 0)
ON CONFLICT (ID_PENALTY) DO NOTHING;

INSERT INTO CATEGORY_REPORT (ID_CATEGORYREPORT, MONTH_REPORT, YEAR_REPORT, TOTAL_BORROWCOUNT) VALUES
    ('79faa628-0ec7-4d5d-9f9e-8894430ebdc2', 1, 2024, 120),
    ('0f0ec629-8e76-4714-a61d-7f61ddd42d77', 2, 2024, 98),
    ('3b6e01fc-1ec1-4ce3-af07-5ff1dd7d02d1', 3, 2024, 150)
ON CONFLICT (ID_CATEGORYREPORT) DO NOTHING;

INSERT INTO CATEGORY_REPORTDETAIL (ID_CATEGORYREPORT, ID_TYPEBOOK, BORROW_COUNT, BORROW_RATIO) VALUES
    ('79faa628-0ec7-4d5d-9f9e-8894430ebdc2', '801f9c7e-9350-4b5c-9c15-82bc5eac4290', 35, 0.29),
    ('79faa628-0ec7-4d5d-9f9e-8894430ebdc2', 'c6df44b0-5775-4c04-a34c-6b62e1f7c5b5', 18, 0.15),
    ('79faa628-0ec7-4d5d-9f9e-8894430ebdc2', '1d2dcee0-9ad1-43f9-9b89-3ef1d6400edb', 28, 0.23),
    ('79faa628-0ec7-4d5d-9f9e-8894430ebdc2', 'f72c1ee5-bf42-4a4e-8706-c63d473fa3ec', 22, 0.18),
    ('0f0ec629-8e76-4714-a61d-7f61ddd42d77', '801f9c7e-9350-4b5c-9c15-82bc5eac4290', 30, 0.31),
    ('0f0ec629-8e76-4714-a61d-7f61ddd42d77', '1d2dcee0-9ad1-43f9-9b89-3ef1d6400edb', 25, 0.26),
    ('0f0ec629-8e76-4714-a61d-7f61ddd42d77', '84cc0d3b-4a21-4f90-9fba-9ffd1cd71d4d', 18, 0.18),
    ('0f0ec629-8e76-4714-a61d-7f61ddd42d77', 'c6df44b0-5775-4c04-a34c-6b62e1f7c5b5', 12, 0.12),
    ('3b6e01fc-1ec1-4ce3-af07-5ff1dd7d02d1', '801f9c7e-9350-4b5c-9c15-82bc5eac4290', 42, 0.28),
    ('3b6e01fc-1ec1-4ce3-af07-5ff1dd7d02d1', '1d2dcee0-9ad1-43f9-9b89-3ef1d6400edb', 37, 0.25),
    ('3b6e01fc-1ec1-4ce3-af07-5ff1dd7d02d1', 'f72c1ee5-bf42-4a4e-8706-c63d473fa3ec', 32, 0.21),
    ('3b6e01fc-1ec1-4ce3-af07-5ff1dd7d02d1', 'd1611459-5421-4db2-9a82-0de8030c4ad1', 25, 0.17);

INSERT INTO OVERDUE_REPORT (ID_OVERDUEREPORT, CREATED_DATE) VALUES
    ('8689f51b-2c12-4a5a-b049-5078e1bc105d', '2024-03-05'),
    ('732e9bae-9793-4bb1-b7df-cf2d4c185141', '2024-03-20')
ON CONFLICT (ID_OVERDUEREPORT) DO NOTHING;

INSERT INTO OVERDUE_REPORTDETAIL (ID_OVERDUEREPORT, ID_THEBOOK, BORROW_DATE, LATE_DAYS) VALUES
    ('8689f51b-2c12-4a5a-b049-5078e1bc105d', 'TB00008', '2024-02-15', 5),
    ('8689f51b-2c12-4a5a-b049-5078e1bc105d', 'TB00002', '2024-01-15', 2),
    ('732e9bae-9793-4bb1-b7df-cf2d4c185141', 'TB00005', '2024-03-02', 6),
    ('732e9bae-9793-4bb1-b7df-cf2d4c185141', 'TB00010', '2024-03-15', 3);

INSERT INTO IMAGE (ID_IMG, ID_BOOK, ID_READER, ID_AUTHOR, URL) VALUES
    ('d81f0dad-4044-4f0d-8b04-e49a04790e22', 'B000001', NULL, NULL, 'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=600&q=80'),
    ('6dfbe4bc-929d-4b27-8acd-7dfb7a4cde67', 'B000002', NULL, NULL, 'https://covers.openlibrary.org/b/isbn/9780062316097-L.jpg'),
    ('4c71f863-cd67-4093-8cc9-42fbaa2ee05b', 'B000003', NULL, NULL, 'https://covers.openlibrary.org/b/isbn/9780312944926-L.jpg'),
    ('69bcb6c2-c399-4ffc-b7d3-a1eaf3f4cb8d', 'B000004', NULL, NULL, 'https://covers.openlibrary.org/b/isbn/9780132350884-L.jpg'),
    ('c5163171-17af-4d0d-8db7-05d00411b103', 'B000005', NULL, NULL, 'https://covers.openlibrary.org/b/isbn/9780553380163-L.jpg'),
    ('5f36bfce-fd3f-46c5-b55a-47bb9ece688a', 'B000006', NULL, NULL, 'https://covers.openlibrary.org/b/isbn/9780307887894-L.jpg'),
    ('53c1ff54-c401-4b9b-9da4-2c3b7306a66c', 'B000007', NULL, NULL, 'https://covers.openlibrary.org/b/isbn/9781400079278-L.jpg'),
    ('b24a48cb-e775-4431-9af2-4d5527f9da3b', 'B000008', NULL, NULL, 'https://covers.openlibrary.org/b/isbn/9780439708180-L.jpg'),
    ('d65e1a36-0703-4fc5-bb10-128c21ef8fd1', 'B000009', NULL, NULL, 'https://covers.openlibrary.org/b/isbn/9781476708706-L.jpg'),
    ('bb1b288b-e9d0-4de4-b6c1-b3a1c446c766', 'B000010', NULL, NULL, 'https://covers.openlibrary.org/b/isbn/9780374533557-L.jpg'),
    ('0e2f27c9-8b15-48b5-a4c6-0222a01d6adb', 'B000011', NULL, NULL, 'https://covers.openlibrary.org/b/isbn/9781607747307-L.jpg'),
    ('a2da89bb-a89f-4606-9f35-e5e30c1bdb41', 'B000012', NULL, NULL, 'https://covers.openlibrary.org/b/isbn/9780375704024-L.jpg'),
    ('f4dfae71-8621-48b1-9ce9-472bdfe96423', NULL, 'DG00008', NULL, 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=400&q=80'),
    ('a430e547-bfd4-4248-89bf-c583f8f44bdb', NULL, NULL, '3bf729f9-a20f-4c68-84e6-8c6714bb7a57', 'https://upload.wikimedia.org/wikipedia/commons/d/d4/Stephen_Hawking.StarChild.jpg'),
    ('81540b80-8f71-474f-8909-277cf3dbd87c', NULL, 'DG00003', NULL, 'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?auto=format&fit=crop&w=400&q=80')
ON CONFLICT (ID_IMG) DO NOTHING;

INSERT INTO EVALUATE (ID_EVALUATE, ID_READER, ID_BOOK, EVA_COMMENT, EVA_STAR, CREATE_DATE) VALUES
    ('a33104bc-8e1a-4a0d-9db3-c944c8450b96', 'DG00001', 'B000001', 'Truyện tuổi thơ rất dễ thương.', 5, '2024-01-26 09:20:00'),
    ('fa9655f5-cfe5-4d4f-a4ca-631fa4fbb5ab', 'DG00003', 'B000003', 'Nội dung gay cấn, nhưng dịch hơi cũ.', 4, '2024-03-05 14:05:00'),
    ('d760edb1-3745-42a1-8ad1-0b32e3a094a0', 'DG00007', 'B000005', 'Đọc khá khó, phù hợp độc giả nghiên cứu.', 4, '2024-02-11 16:40:00'),
    ('4999433e-47cd-4b4b-8d14-67a28b1aec17', 'DG00008', 'B000008', 'Bìa sách đẹp, nội dung cuốn hút.', 5, '2024-03-01 10:15:00'),
    ('6de4cd32-37b9-48fd-9046-c18fcc1bc04a', 'DG00002', 'B000004', 'Tài liệu hay cho lập trình viên.', 5, '2024-02-18 13:55:00')
ON CONFLICT (ID_EVALUATE) DO NOTHING;

INSERT INTO FAVORITEBOOK (ID_READER, ID_BOOK, CREATE_DAY) VALUES
    ('DG00001', 'B000008', '2024-02-28'),
    ('DG00003', 'B000005', '2024-03-06'),
    ('DG00006', 'B000004', '2024-01-25'),
    ('DG00008', 'B000007', '2024-03-01'),
    ('DG00009', 'B000009', '2024-03-08'),
    ('DG00012', 'B000001', '2024-03-18');

INSERT INTO OTP (ID_OTP, OTP, EXPIRATION_TIME, ID_READER) VALUES
    ('0267dd03-dc5b-4cdf-9d18-b38653ad1c1e', 452198, '2024-03-20 10:00:00', 'DG00001'),
    ('8479f887-87cd-4258-9d3f-494176677d45', 113422, '2024-03-21 08:30:00', 'DG00008'),
    ('7f13d421-1a40-4d1b-a7d8-e99598701bf3', 774510, '2024-03-22 09:00:00', 'DG00012')
ON CONFLICT (ID_OTP) DO NOTHING;

INSERT INTO INVALIDATE_TOKEN (ID_TOKEN, EXPIRY_TIME) VALUES
    ('1fb5d20e-3223-4c8b-bb46-1d958f9a97d4', '2024-03-15 12:00:00'),
    ('74d8bf1e-4140-4fb0-8e0d-7e931968d703', '2024-03-18 08:30:00'),
    ('ae067dc5-0528-4a5c-8c20-5e2326b5d012', '2024-03-18 08:45:00');

COMMIT;
