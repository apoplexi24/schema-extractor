-- Check if tradebook database exists and create if not
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'tradebook')
BEGIN
    CREATE DATABASE tradebook;
END
GO

USE tradebook;

-- Check if customer_details table exists and create if not
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'customer_details')
BEGIN
    CREATE TABLE customer_details (
        customer_id INT PRIMARY KEY,
        first_name NVARCHAR(50),
        last_name NVARCHAR(50),
        email NVARCHAR(100),
        phone_number NVARCHAR(15),
        address NVARCHAR(255),
        created_at DATETIME DEFAULT GETDATE()
    );
END

-- Check if stock_tradebook table exists and create if not
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'stock_tradebook')
BEGIN
    CREATE TABLE stock_tradebook (
        trade_id INT PRIMARY KEY,
        customer_id INT,
        stock_symbol NVARCHAR(10),
        trade_type NVARCHAR(4),
        quantity INT,
        price DECIMAL(10, 2),
        trade_date DATETIME DEFAULT GETDATE(),
        FOREIGN KEY (customer_id) REFERENCES customer_details(customer_id)
    );
END

-- Check if customer_app_activity table exists and create if not
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'customer_app_activity')
BEGIN
    CREATE TABLE customer_app_activity (
        activity_id INT PRIMARY KEY,
        customer_id INT,
        activity_type NVARCHAR(50),
        activity_timestamp DATETIME DEFAULT GETDATE(),
        device_info NVARCHAR(255),
        FOREIGN KEY (customer_id) REFERENCES customer_details(customer_id)
    );
END

-- Insert sample data into customer_details table
INSERT INTO customer_details (customer_id, first_name, last_name, email, phone_number, address)
VALUES 
(1, 'Amit', 'Sharma', 'amit.sharma@example.com', '9876543210', '123 MG Road, Delhi'),
(2, 'Priya', 'Verma', 'priya.verma@example.com', '8765432109', '456 Brigade Road, Bangalore'),
(3, 'Raj', 'Patel', 'raj.patel@example.com', '7654321098', '789 Marine Drive, Mumbai'),
(4, 'Sita', 'Rao', 'sita.rao@example.com', '6543210987', '101 Park Street, Kolkata'),
(5, 'Vikram', 'Singh', 'vikram.singh@example.com', '5432109876', '202 Anna Salai, Chennai'),
(6, 'Anjali', 'Nair', 'anjali.nair@example.com', '4321098765', '303 MG Road, Pune'),
(7, 'Rohit', 'Kumar', 'rohit.kumar@example.com', '3210987654', '404 Brigade Road, Hyderabad'),
(8, 'Neha', 'Gupta', 'neha.gupta@example.com', '2109876543', '505 Marine Drive, Ahmedabad'),
(9, 'Arjun', 'Mehta', 'arjun.mehta@example.com', '1098765432', '606 Park Street, Jaipur'),
(10, 'Kavita', 'Joshi', 'kavita.joshi@example.com', '0987654321', '707 Anna Salai, Lucknow');

-- Insert sample data into stock_tradebook table
INSERT INTO stock_tradebook (trade_id, customer_id, stock_symbol, trade_type, quantity, price)
VALUES 
(1, 1, 'TCS', 'BUY', 10, 3500.00),
(2, 2, 'INFY', 'SELL', 5, 1500.00),
(3, 3, 'RELI', 'BUY', 20, 2500.00),
(4, 4, 'WIPRO', 'BUY', 15, 550.00),
(5, 5, 'HDFC', 'SELL', 8, 2700.00),
(6, 6, 'ICICI', 'BUY', 12, 600.00),
(7, 7, 'SBIN', 'SELL', 25, 450.00),
(8, 8, 'BHARTIARTL', 'BUY', 18, 700.00),
(9, 9, 'ADANIPORTS', 'SELL', 30, 800.00),
(10, 10, 'ITC', 'BUY', 22, 220.00);

-- Insert sample data into customer_app_activity table
INSERT INTO customer_app_activity (activity_id, customer_id, activity_type, activity_timestamp, device_info)
VALUES 
(1, 1, 'Login', GETDATE(), 'OnePlus 9'),
(2, 2, 'Trade', GETDATE(), 'Samsung Galaxy S21'),
(3, 3, 'Logout', GETDATE(), 'Xiaomi Mi 11'),
(4, 4, 'Login', GETDATE(), 'Apple iPhone 12'),
(5, 5, 'Trade', GETDATE(), 'Google Pixel 5'),
(6, 6, 'Logout', GETDATE(), 'OnePlus 8T'),
(7, 7, 'Login', GETDATE(), 'Samsung Galaxy Note 20'),
(8, 8, 'Trade', GETDATE(), 'Apple iPhone 11'),
(9, 9, 'Logout', GETDATE(), 'Xiaomi Mi 10'),
(10, 10, 'Login', GETDATE(), 'Google Pixel 4a');

-- Check if company database exists and create if not
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'company')
BEGIN
    CREATE DATABASE company;
END
GO

USE company;

-- Check if company_revenue table exists and create if not
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'company_revenue')
BEGIN
    CREATE TABLE company_revenue (
        revenue_id INT PRIMARY KEY,
        company_name NVARCHAR(255),
        revenue_amount DECIMAL(18, 2),
        revenue_date DATE
    );
END

-- Insert sample data into company_revenue table
INSERT INTO company_revenue (revenue_id, company_name, revenue_amount, revenue_date)
VALUES 
(1, 'TCS', 5000000.00, '2023-01-01'),
(2, 'Infosys', 4500000.00, '2023-01-01'),
(3, 'Reliance', 7000000.00, '2023-01-01'),
(4, 'Wipro', 3000000.00, '2023-01-01'),
(5, 'HDFC', 6000000.00, '2023-01-01'),
(6, 'ICICI', 4000000.00, '2023-01-01'),
(7, 'SBI', 5500000.00, '2023-01-01'),
(8, 'Bharti Airtel', 3500000.00, '2023-01-01'),
(9, 'Adani Ports', 6500000.00, '2023-01-01'),
(10, 'ITC', 2500000.00, '2023-01-01');

-- Check if company_board_directors table exists and create if not
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'company_board_directors')
BEGIN
    CREATE TABLE company_board_directors (
        director_id INT PRIMARY KEY,
        company_name NVARCHAR(255),
        director_name NVARCHAR(255),
        appointment_date DATE
    );
END

-- Insert sample data into company_board_directors table
INSERT INTO company_board_directors (director_id, company_name, director_name, appointment_date)
VALUES 
(1, 'TCS', 'Natarajan Chandrasekaran', '2017-02-21'),
(2, 'Infosys', 'Salil Parekh', '2018-01-02'),
(3, 'Reliance', 'Mukesh Ambani', '2002-07-24'),
(4, 'Wipro', 'Thierry Delaporte', '2020-07-06'),
(5, 'HDFC', 'Sashidhar Jagdishan', '2020-10-27'),
(6, 'ICICI', 'Sandeep Bakhshi', '2018-10-15'),
(7, 'SBI', 'Dinesh Kumar Khara', '2020-10-07'),
(8, 'Bharti Airtel', 'Sunil Bharti Mittal', '1995-07-07'),
(9, 'Adani Ports', 'Karan Adani', '2016-01-01'),
(10, 'ITC', 'Sanjiv Puri', '2017-05-16');
