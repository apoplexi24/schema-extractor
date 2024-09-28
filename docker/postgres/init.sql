-- Create table for app user details similar to GA analytics

CREATE TABLE app_user_details (
    user_id SERIAL PRIMARY KEY,
    client_id VARCHAR(255) UNIQUE,
    first_seen_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    last_seen_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    device_category VARCHAR(50),
    operating_system VARCHAR(100),
    browser VARCHAR(100),
    country VARCHAR(100),
    city VARCHAR(100),
    user_type VARCHAR(50),
    sessions INTEGER DEFAULT 0,
    pageviews INTEGER DEFAULT 0,
    total_time_spent INTERVAL DEFAULT '0 seconds',
    bounce_rate NUMERIC(5,2),
    conversion_rate NUMERIC(5,2)
);

-- Create index for faster queries
CREATE INDEX idx_app_user_details_client_id ON app_user_details(client_id);
CREATE INDEX idx_app_user_details_last_seen_date ON app_user_details(last_seen_date);

-- Create table for user sessions
CREATE TABLE user_sessions (
    session_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES app_user_details(user_id),
    session_start TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    session_end TIMESTAMP WITH TIME ZONE,
    duration INTERVAL,
    source VARCHAR(100),
    medium VARCHAR(100),
    campaign VARCHAR(100),
    landing_page VARCHAR(255),
    exit_page VARCHAR(255),
    pageviews INTEGER DEFAULT 0,
    events INTEGER DEFAULT 0
);

-- Create index for faster queries
CREATE INDEX idx_user_sessions_user_id ON user_sessions(user_id);
CREATE INDEX idx_user_sessions_session_start ON user_sessions(session_start);

-- Populate app_user_details table with Indian users
INSERT INTO app_user_details (client_id, device_category, operating_system, browser, country, city, user_type, sessions, pageviews, total_time_spent, bounce_rate, conversion_rate)
VALUES
    ('IN001', 'Mobile', 'Android', 'Chrome', 'India', 'Mumbai', 'New', 3, 15, '00:45:30', 20.5, 3.2),
    ('IN002', 'Desktop', 'Windows', 'Firefox', 'India', 'Delhi', 'Returning', 7, 42, '02:15:00', 15.3, 5.7),
    ('IN003', 'Tablet', 'iOS', 'Safari', 'India', 'Bangalore', 'New', 2, 8, '00:20:15', 35.0, 1.8),
    ('IN004', 'Mobile', 'Android', 'Samsung Internet', 'India', 'Chennai', 'Returning', 5, 27, '01:30:45', 18.7, 4.5),
    ('IN005', 'Desktop', 'macOS', 'Chrome', 'India', 'Kolkata', 'New', 1, 4, '00:10:30', 50.0, 0.0),
    ('IN006', 'Mobile', 'iOS', 'Chrome', 'India', 'Hyderabad', 'Returning', 9, 63, '03:45:00', 12.1, 7.8),
    ('IN007', 'Desktop', 'Linux', 'Firefox', 'India', 'Pune', 'New', 2, 11, '00:35:20', 27.3, 2.5),
    ('IN008', 'Mobile', 'Android', 'Opera', 'India', 'Ahmedabad', 'Returning', 6, 38, '02:00:15', 16.5, 6.2),
    ('IN009', 'Tablet', 'Android', 'Chrome', 'India', 'Jaipur', 'New', 1, 5, '00:15:45', 40.0, 1.0),
    ('IN010', 'Desktop', 'Windows', 'Edge', 'India', 'Lucknow', 'Returning', 4, 22, '01:10:30', 22.7, 3.9);

-- Populate user_sessions table with corresponding session data
INSERT INTO user_sessions (user_id, session_start, session_end, duration, source, medium, campaign, landing_page, exit_page, pageviews, events)
VALUES
    (1, '2023-05-01 10:00:00+05:30', '2023-05-01 10:15:30+05:30', '00:15:30', 'Google', 'Organic', 'None', '/home', '/products', 5, 3),
    (2, '2023-05-02 14:30:00+05:30', '2023-05-02 15:00:00+05:30', '00:30:00', 'Facebook', 'Social', 'Summer_Sale', '/sale', '/checkout', 8, 6),
    (3, '2023-05-03 09:45:00+05:30', '2023-05-03 09:55:15+05:30', '00:10:15', 'Direct', 'None', 'None', '/about', '/contact', 4, 2),
    (4, '2023-05-04 18:20:00+05:30', '2023-05-04 18:50:45+05:30', '00:30:45', 'Instagram', 'Social', 'Influencer_1', '/special-offer', '/cart', 7, 5),
    (5, '2023-05-05 11:30:00+05:30', '2023-05-05 11:40:30+05:30', '00:10:30', 'Bing', 'Organic', 'None', '/services', '/services', 4, 1),
    (6, '2023-05-06 16:00:00+05:30', '2023-05-06 16:45:00+05:30', '00:45:00', 'Email', 'Email', 'Newsletter_May', '/blog', '/subscribe', 9, 7),
    (7, '2023-05-07 13:15:00+05:30', '2023-05-07 13:32:50+05:30', '00:17:50', 'Twitter', 'Social', 'Product_Launch', '/new-arrival', '/product-details', 6, 4),
    (8, '2023-05-08 20:45:00+05:30', '2023-05-08 21:15:15+05:30', '00:30:15', 'AdWords', 'PPC', 'Summer_Collection', '/summer', '/size-guide', 8, 5),
    (9, '2023-05-09 10:30:00+05:30', '2023-05-09 10:45:45+05:30', '00:15:45', 'YouTube', 'Social', 'Tutorial_1', '/how-to', '/faq', 5, 2),
    (10, '2023-05-10 17:00:00+05:30', '2023-05-10 17:25:30+05:30', '00:25:30', 'Referral', 'Partner', 'Affiliate_1', '/special-discount', '/thank-you', 7, 4);
