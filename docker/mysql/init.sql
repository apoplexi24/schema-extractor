-- Create table for stock prices every 15 minutes
CREATE TABLE stock_prices_15min (
    id INT AUTO_INCREMENT PRIMARY KEY,
    symbol VARCHAR(10) NOT NULL,
    timestamp DATETIME NOT NULL,
    open_price DECIMAL(10, 2) NOT NULL,
    high_price DECIMAL(10, 2) NOT NULL,
    low_price DECIMAL(10, 2) NOT NULL,
    close_price DECIMAL(10, 2) NOT NULL,
    volume INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_symbol_timestamp (symbol, timestamp)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create table for stock metadata
CREATE TABLE stocks (
    symbol VARCHAR(10) PRIMARY KEY,
    company_name VARCHAR(255) NOT NULL,
    sector VARCHAR(100),
    industry VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add foreign key constraint
ALTER TABLE stock_prices_15min
ADD CONSTRAINT fk_stock_prices_15min_symbol
FOREIGN KEY (symbol) REFERENCES stocks(symbol);

-- Populate stocks table with Indian stocks
INSERT INTO stocks (symbol, company_name, sector, industry) VALUES
('RELIANCE', 'Reliance Industries Limited', 'Energy', 'Oil & Gas'),
('TCS', 'Tata Consultancy Services Limited', 'Technology', 'IT Services'),
('HDFCBANK', 'HDFC Bank Limited', 'Financial Services', 'Banking'),
('INFY', 'Infosys Limited', 'Technology', 'IT Services'),
('HINDUNILVR', 'Hindustan Unilever Limited', 'Consumer Goods', 'FMCG'),
('ICICIBANK', 'ICICI Bank Limited', 'Financial Services', 'Banking'),
('SBIN', 'State Bank of India', 'Financial Services', 'Banking'),
('BHARTIARTL', 'Bharti Airtel Limited', 'Communication', 'Telecom'),
('ITC', 'ITC Limited', 'Consumer Goods', 'FMCG'),
('KOTAKBANK', 'Kotak Mahindra Bank Limited', 'Financial Services', 'Banking'),
('WIPRO', 'Wipro Limited', 'Technology', 'IT Services'),
('ASIANPAINT', 'Asian Paints Limited', 'Consumer Goods', 'Paints'),
('MARUTI', 'Maruti Suzuki India Limited', 'Automobile', 'Passenger Vehicles'),
('LT', 'Larsen & Toubro Limited', 'Construction', 'Engineering'),
('AXISBANK', 'Axis Bank Limited', 'Financial Services', 'Banking');

-- Populate stock_prices_15min table with sample data
INSERT INTO stock_prices_15min (symbol, timestamp, open_price, high_price, low_price, close_price, volume) VALUES
('RELIANCE', '2023-05-01 09:15:00', 2100.00, 2110.50, 2095.00, 2105.25, 1000000),
('TCS', '2023-05-01 09:15:00', 3200.00, 3215.75, 3190.50, 3210.00, 500000),
('HDFCBANK', '2023-05-01 09:15:00', 1650.00, 1660.25, 1645.50, 1655.75, 750000),
('INFY', '2023-05-01 09:15:00', 1300.00, 1310.50, 1295.00, 1305.25, 600000),
('HINDUNILVR', '2023-05-01 09:15:00', 2600.00, 2615.75, 2590.50, 2610.00, 300000),
('ICICIBANK', '2023-05-01 09:15:00', 900.00, 910.25, 895.50, 905.75, 800000),
('SBIN', '2023-05-01 09:15:00', 550.00, 555.50, 547.00, 552.25, 1200000),
('BHARTIARTL', '2023-05-01 09:15:00', 750.00, 755.75, 745.50, 752.00, 700000),
('ITC', '2023-05-01 09:15:00', 400.00, 405.25, 398.50, 402.75, 1500000),
('KOTAKBANK', '2023-05-01 09:15:00', 1800.00, 1810.50, 1795.00, 1805.25, 400000),
('WIPRO', '2023-05-01 09:15:00', 400.00, 405.75, 398.50, 403.00, 550000),
('ASIANPAINT', '2023-05-01 09:15:00', 3000.00, 3015.25, 2990.50, 3010.75, 200000),
('MARUTI', '2023-05-01 09:15:00', 8500.00, 8550.50, 8480.00, 8525.25, 100000),
('LT', '2023-05-01 09:15:00', 2200.00, 2215.75, 2190.50, 2210.00, 350000),
('AXISBANK', '2023-05-01 09:15:00', 950.00, 960.25, 945.50, 955.75, 650000);
