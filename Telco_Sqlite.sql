/*******************************************************************************
   Drop Tables
********************************************************************************/

DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Plans;
DROP TABLE IF EXISTS Subscriptions;
DROP TABLE IF EXISTS Messages;
DROP TABLE IF EXISTS Notifications;
DROP TABLE IF EXISTS Usage;
DROP TABLE IF EXISTS Billing;
DROP TABLE IF EXISTS Devices;
DROP TABLE IF EXISTS Locations;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Services;
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Complaints;
DROP TABLE IF EXISTS Repairs;

/*******************************************************************************
   Create Tables
********************************************************************************/

CREATE TABLE Customers
(
    customer_id INTEGER PRIMARY KEY,
    name TEXT,
    address TEXT,
    contact_number TEXT
);

CREATE TABLE Plans (
    plan_id INTEGER PRIMARY KEY,
    plan_name TEXT,
    description TEXT,
    price REAL
);

CREATE TABLE Subscriptions (
    subscription_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    plan_id INTEGER,
    service_id INTEGER,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (plan_id) REFERENCES Plans(plan_id),
    FOREIGN KEY (service_id) REFERENCES Services(service_id)
);

-- Create other tables in a similar fashion

CREATE TABLE Messages (
    message_id INTEGER PRIMARY KEY,
    sender_id INTEGER,
    receiver_id INTEGER,
    message_content TEXT,
    sent_date TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (receiver_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Notifications (
    notification_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    notification_content TEXT,
    date_sent TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);


CREATE TABLE Usage (
    usage_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    date DATE,
    duration INTEGER, -- Duration in minutes or seconds
    data_used REAL, -- Data used in MB or GB
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Billing (
    billing_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    subscription_id INTEGER,
    billing_date DATE,
    amount REAL,
    payment_status TEXT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (subscription_id) REFERENCES Subscriptions(subscription_id)
);

CREATE TABLE Devices (
    device_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    device_type TEXT,
    brand TEXT,
    model TEXT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Locations (
    location_id INTEGER PRIMARY KEY,
    location_name TEXT,
    address TEXT,
    coverage_area TEXT
);

CREATE TABLE Employees (
    employee_id INTEGER PRIMARY KEY,
    name TEXT,
    position TEXT,
    department TEXT,
    contact_details TEXT
);

CREATE TABLE Orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date DATE,
    order_status TEXT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Services (
    service_id INTEGER PRIMARY KEY,
    service_name TEXT,
    description TEXT,
    price REAL
);

CREATE TABLE Payments (
    payment_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    payment_date DATE,
    amount REAL,
    payment_method TEXT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Complaints (
    complaint_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    date DATE,
    description TEXT,
    status TEXT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Repairs (
    repair_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    device_id INTEGER,
    date DATE,
    description TEXT,
    status TEXT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (device_id) REFERENCES Devices(device_id)
);

/*******************************************************************************
   Create Primary Key Unique Indexes
********************************************************************************/

/*******************************************************************************
   Create Foreign Keys
********************************************************************************/


CREATE INDEX idx_customer_id_subscriptions ON Subscriptions (customer_id);
CREATE INDEX idx_plan_id_subscriptions ON Subscriptions (plan_id);
CREATE INDEX idx_service_id_subscriptions ON Subscriptions (service_id);

CREATE INDEX idx_sender_id_messages ON Messages (sender_id);
CREATE INDEX idx_receiver_id_messages ON Messages (receiver_id);

CREATE INDEX idx_customer_id_notifications ON Notifications (customer_id);

CREATE INDEX idx_customer_id_usage ON Usage (customer_id);

CREATE INDEX idx_customer_id_billing ON Billing (customer_id);
CREATE INDEX idx_subscription_id_billing ON Billing (subscription_id);

CREATE INDEX idx_customer_id_devices ON Devices (customer_id);

CREATE INDEX idx_customer_id_orders ON Orders (customer_id);

CREATE INDEX idx_customer_id_payments ON Payments (customer_id);

CREATE INDEX idx_customer_id_complaints ON Complaints (customer_id);

CREATE INDEX idx_customer_id_repairs ON Repairs (customer_id);
CREATE INDEX idx_device_id_repairs ON Repairs (device_id);


/*******************************************************************************
   Populate Tables
********************************************************************************/

-- Inserting customers
INSERT INTO Customers (name, address, contact_number) VALUES
('John Doe', '123 Main St, Anytown, USA', '+1234567890'),
('Alice Smith', '456 Elm St, Otherville, USA', '+1987654321'),
('Bob Johnson', '789 Oak St, Anycity, USA', '+1122334455'),
('Emily Brown', '321 Pine St, Newville, USA', '+1555666777'),
('Michael Wilson', '654 Maple St, Anothercity, USA', '+1444222111'),
('Sarah Davis', '987 Cedar St, Someplace, USA', '+1999888777'),
('David Martinez', '234 Birch St, Elsewhere, USA', '+1666333444'),
('Jennifer Taylor', '876 Walnut St, Nowhere, USA', '+1888999000'),
('James Rodriguez', '543 Spruce St, Anywhere, USA', '+1777666555'),
('Emma Thomas', '210 Cherry St, Somewhere, USA', '+1222111333');

-- Inserting plans
INSERT INTO Plans (plan_name, description, price) VALUES
('Basic', 'Basic plan with limited data and minutes', 29.99),
('Standard', 'Standard plan with moderate data and minutes', 49.99),
('Premium', 'Premium plan with unlimited data and minutes', 79.99);

-- Inserting subscriptions
INSERT INTO Subscriptions (customer_id, plan_id, start_date, end_date) VALUES
(1, 1, '2024-01-01', '2024-12-31'),
(2, 2, '2024-01-15', '2024-12-31'),
(3, 3, '2024-02-01', '2024-12-31'),
(4, 1, '2024-03-01', '2024-12-31'),
(5, 2, '2024-01-01', '2024-12-31'),
(6, 3, '2024-02-15', '2024-12-31'),
(7, 1, '2024-03-01', '2024-12-31'),
(8, 2, '2024-01-01', '2024-12-31'),
(9, 3, '2024-02-01', '2024-12-31'),
(10, 1, '2024-03-15', '2024-12-31');

-- Inserting usage
INSERT INTO Usage (customer_id, date, duration, data_used) VALUES
(1, '2024-03-23', 60, 500),
(2, '2024-03-22', 45, 300),
(3, '2024-03-21', 30, 200),
(4, '2024-03-20', 25, 150),
(5, '2024-03-19', 20, 100),
(6, '2024-03-18', 15, 50),
(7, '2024-03-17', 10, 25),
(8, '2024-03-16', 5, 10),
(9, '2024-03-15', 5, 10),
(10, '2024-03-14', 5, 10);

-- Inserting billing
INSERT INTO Billing (customer_id, subscription_id, billing_date, amount, payment_status) VALUES
(1, 1, '2024-03-25', 29.99, 'Paid'),
(2, 2, '2024-03-25', 49.99, 'Paid'),
(3, 3, '2024-03-25', 79.99, 'Paid'),
(4, 4, '2024-03-25', 29.99, 'Paid'),
(5, 5, '2024-03-25', 49.99, 'Paid'),
(6, 6, '2024-03-25', 79.99, 'Paid'),
(7, 7, '2024-03-25', 29.99, 'Paid'),
(8, 8, '2024-03-25', 49.99, 'Paid'),
(9, 9, '2024-03-25', 79.99, 'Paid'),
(10, 10, '2024-03-25', 29.99, 'Paid');

-- Inserting devices
INSERT INTO Devices (customer_id, device_type, brand, model) VALUES
(1, 'Smartphone', 'Apple', 'iPhone 12'),
(2, 'Smartphone', 'Samsung', 'Galaxy S21'),
(3, 'Smartphone', 'Google', 'Pixel 6'),
(4, 'Smartphone', 'OnePlus', '9 Pro'),
(5, 'Smartphone', 'Xiaomi', 'Mi 11'),
(6, 'Smartphone', 'Huawei', 'P40 Pro'),
(7, 'Smartphone', 'Sony', 'Xperia 5 III'),
(8, 'Smartphone', 'LG', 'Velvet'),
(9, 'Smartphone', 'Motorola', 'Edge+'),
(10, 'Smartphone', 'Nokia', '8.3');

-- Inserting locations
INSERT INTO Locations (location_name, address, coverage_area) VALUES
('Central Office', '100 Telecom Ave, Metro City, USA', 'Metro City and surrounding areas'),
('North Office', '200 Broad St, Northtown, USA', 'Northtown and surrounding areas'),
('South Office', '300 Main St, Southville, USA', 'Southville and surrounding areas');

-- Inserting employees
INSERT INTO Employees (name, position, department, contact_details) VALUES
('John Smith', 'Manager', 'Operations', '+1234567890'),
('Alice Johnson', 'Supervisor', 'Customer Service', '+1987654321'),
('Bob Brown', 'Technician', 'Technical Support', '+1122334455');

-- Inserting orders
INSERT INTO Orders (customer_id, order_date, order_status) VALUES
(1, '2024-03-23', 'Pending'),
(2, '2024-03-22', 'Completed'),
(3, '2024-03-21', 'Completed'),
(4, '2024-03-20', 'Pending'),
(5, '2024-03-19', 'Completed'),
(6, '2024-03-18', 'Completed'),
(7, '2024-03-17', 'Pending'),
(8, '2024-03-16', 'Completed'),
(9, '2024-03-15', 'Completed'),
(10, '2024-03-14', 'Pending');

-- Inserting services
INSERT INTO Services (service_name, description, price) VALUES
('Voicemail', 'Voicemail service for missed calls', 5.99),
('Caller ID', 'Caller identification service', 3.99),
('International Roaming', 'Service for using mobile phone abroad', 9.99),
('Data Pack', 'Additional data pack for high-speed internet', 12.99);

-- Inserting payments
INSERT INTO Payments (customer_id, payment_date, amount, payment_method) VALUES
(1, '2024-03-25', 29.99, 'Credit Card'),
(2, '2024-03-25', 49.99, 'PayPal'),
(3, '2024-03-25', 79.99, 'Bank Transfer'),
(4, '2024-03-25', 29.99, 'Credit Card'),
(5, '2024-03-25', 49.99, 'PayPal'),
(6, '2024-03-25', 79.99, 'Bank Transfer'),
(7, '2024-03-25', 29.99, 'Credit Card'),
(8, '2024-03-25', 49.99, 'PayPal'),
(9, '2024-03-25', 79.99, 'Bank Transfer'),
(10, '2024-03-25', 29.99, 'Credit Card');

-- Inserting complaints
INSERT INTO Complaints (customer_id, date, description, status) VALUES
(1, '2024-03-23', 'Network connectivity issues', 'Pending'),
(2, '2024-03-22', 'Billing discrepancy', 'Resolved'),
(3, '2024-03-21', 'Poor call quality', 'Resolved'),
(4, '2024-03-20', 'Device malfunction', 'Pending'),
(5, '2024-03-19', 'Slow internet speed', 'Resolved'),
(6, '2024-03-18', 'Coverage issues', 'Resolved'),
(7, '2024-03-17', 'Billing inquiry', 'Pending'),
(8, '2024-03-16', 'Service activation problem', 'Resolved'),
(9, '2024-03-15', 'Data usage discrepancy', 'Resolved'),
(10, '2024-03-14', 'Device repair delay', 'Pending');

-- Inserting repairs
INSERT INTO Repairs (customer_id, device_id, date, description, status) VALUES
(1, 1, '2024-03-24', 'Screen replacement', 'Pending'),
(2, 2, '2024-03-23', 'Battery replacement', 'Resolved'),
(3, 3, '2024-03-22', 'Network antenna repair', 'Resolved'),
(4, 4, '2024-03-21', 'Speaker repair', 'Pending'),
(5, 5, '2024-03-20', 'Screen calibration', 'Resolved'),
(6, 6, '2024-03-19', 'Coverage antenna replacement', 'Resolved'),
(7, 7, '2024-03-18', 'SIM card replacement', 'Pending'),
(8, 8, '2024-03-17', 'Activation port repair', 'Resolved'),
(9, 9, '2024-03-16', 'Data connection repair', 'Resolved'),
(10, 10, '2024-03-15', 'Display panel replacement', 'Pending');

-- Inserting messages
INSERT INTO Messages (sender_id, receiver_id, message_content, sent_date) VALUES
(1, 2, 'Hey Alice, how are you?', '2024-03-23 08:30:00'),
(2, 1, 'Hi John, I''m good, thanks! How about you?', '2024-03-23 08:35:00'),
(3, 4, 'Hey Bob, can you help me with something?', '2024-03-22 10:00:00'),
(4, 3, 'Sure Emily, what do you need?', '2024-03-22 10:05:00'),
(5, 6, 'Hi Michael, did you receive my email?', '2024-03-21 14:00:00'),
(6, 5, 'Yes Sarah, I got it. I''ll look into it.', '2024-03-21 14:05:00'),
(7, 8, 'Hey David, are you free for a quick chat?', '2024-03-20 11:30:00'),
(8, 7, 'Sorry Jennifer, I''m in a meeting right now.', '2024-03-20 11:35:00'),
(9, 10, 'Emma, did you get your device repaired?', '2024-03-19 16:45:00'),
(10, 9, 'Yes James, finally! It took longer than expected though.', '2024-03-19 16:50:00');

-- Inserting notifications
INSERT INTO Notifications (customer_id, notification_content, date_sent) VALUES
(1, 'Your monthly bill has been generated.', '2024-03-25 09:00:00'),
(2, 'New plan options available. Check them out!', '2024-03-25 09:00:00'),
(3, 'Upgrade your plan for better benefits.', '2024-03-25 09:00:00'),
(4, 'Your device repair request is being processed.', '2024-03-25 09:00:00'),
(5, 'Thank you for your recent payment.', '2024-03-25 09:00:00'),
(6, 'Stay connected with our latest offers.', '2024-03-25 09:00:00'),
(7, 'Customer satisfaction survey coming soon.', '2024-03-25 09:00:00'),
(8, 'Join us for our upcoming webinar on new services.', '2024-03-25 09:00:00'),
(9, 'Data usage alert: You''ve reached 90% of your limit.', '2024-03-25 09:00:00'),
(10, 'Device upgrade options available. Contact us for more info.', '2024-03-25 09:00:00');

-- more transactions:

-- Inserting messages
INSERT INTO Messages (sender_id, receiver_id, message_content, sent_date) VALUES
(5, 6, 'Hey Sarah, are you available for a call?', '2024-03-25 11:00:00'),
(6, 7, 'Hey David, do you have any updates on the project?', '2024-03-25 11:05:00'),
(7, 8, 'Jennifer, can you attend the meeting tomorrow?', '2024-03-25 11:10:00'),
(8, 9, 'James, did you receive the latest report?', '2024-03-25 11:15:00'),
(9, 10, 'Emma, could you please send me the presentation?', '2024-03-25 11:20:00'),
(10, 1, 'John, we need to discuss the budget for next quarter.', '2024-03-25 11:25:00'),
(1, 2, 'Alice, can you provide an update on the marketing campaign?', '2024-03-25 11:30:00'),
(2, 3, 'Bob, I need your input on the new product design.', '2024-03-25 11:35:00'),
(3, 4, 'Emily, are you available for a quick chat?', '2024-03-25 11:40:00'),
(4, 5, 'Michael, did you receive the shipment confirmation?', '2024-03-25 11:45:00'),
(5, 1, 'John, can you review the proposal before the meeting?', '2024-03-25 11:50:00'),
(6, 2, 'Alice, please schedule a meeting with the sales team.', '2024-03-25 11:55:00'),
(7, 3, 'Bob, I need your assistance with a client issue.', '2024-03-25 12:00:00'),
(8, 4, 'Emily, did you finalize the budget for the project?', '2024-03-25 12:05:00'),
(9, 5, 'Michael, can you provide an update on the production status?', '2024-03-25 12:10:00'),
(10, 6, 'Sarah, we need to discuss the marketing strategy.', '2024-03-25 12:15:00'),
(1, 7, 'David, please prepare the financial report for the meeting.', '2024-03-25 12:20:00'),
(2, 8, 'Jennifer, can you coordinate the logistics for the event?', '2024-03-25 12:25:00'),
(3, 9, 'James, I need your approval on the project plan.', '2024-03-25 12:30:00'),
(4, 10, 'Emma, have you finalized the client presentation?', '2024-03-25 12:35:00');

-- Inserting notifications
INSERT INTO Notifications (customer_id, notification_content, date_sent) VALUES
(5, 'Data usage alert: You''ve reached 90% of your limit.', '2024-03-25 09:00:00'),
(6, 'Device upgrade options available. Contact us for more info.', '2024-03-25 09:00:00'),
(7, 'Thank you for your recent payment.', '2024-03-25 09:00:00'),
(8, 'Stay connected with our latest offers.', '2024-03-25 09:00:00'),
(9, 'Your monthly bill has been generated.', '2024-03-25 09:00:00'),
(10, 'Upgrade your plan for better benefits.', '2024-03-25 09:00:00'),
(1, 'New plan options available. Check them out!', '2024-03-25 09:00:00'),
(2, 'Customer satisfaction survey coming soon.', '2024-03-25 09:00:00'),
(3, 'Join us for our upcoming webinar on new services.', '2024-03-25 09:00:00'),
(4, 'Your device repair request is being processed.', '2024-03-25 09:00:00'),
(5, 'Data usage alert: You''ve reached 90% of your limit.', '2024-03-25 09:00:00'),
(6, 'Device upgrade options available. Contact us for more info.', '2024-03-25 09:00:00'),
(7, 'Thank you for your recent payment.', '2024-03-25 09:00:00'),
(8, 'Stay connected with our latest offers.', '2024-03-25 09:00:00'),
(9, 'Your monthly bill has been generated.', '2024-03-25 09:00:00'),
(10, 'Upgrade your plan for better benefits.', '2024-03-25 09:00:00'),
(1, 'New plan options available. Check them out!', '2024-03-25 09:00:00'),
(2, 'Customer satisfaction survey coming soon.', '2024-03-25 09:00:00'),
(3, 'Join us for our upcoming webinar on new services.', '2024-03-25 09:00:00'),
(4, 'Your device repair request is being processed.', '2024-03-25 09:00:00');

-- Inserting more usage data
INSERT INTO Usage (customer_id, date, duration, data_used) VALUES
(5, '2024-03-25', 20, 100),
(6, '2024-03-25', 15, 50),
(7, '2024-03-25', 10, 25),
(8, '2024-03-25', 5, 10),
(9, '2024-03-25', 5, 10),
(10, '2024-03-25', 5, 10),
(1, '2024-03-24', 60, 500),
(2, '2024-03-24', 45, 300),
(3, '2024-03-24', 30, 200),
(4, '2024-03-24', 25, 150),
(5, '2024-03-24', 20, 100),
(6, '2024-03-24', 15, 50),
(7, '2024-03-24', 10, 25),
(8, '2024-03-24', 5, 10),
(9, '2024-03-24', 5, 10),
(10, '2024-03-24', 5, 10),
(1, '2024-03-23', 60, 500),
(2, '2024-03-23', 45, 300),
(3, '2024-03-23', 30, 200),
(4, '2024-03-23', 25, 150);

-- Inserting more billing data
INSERT INTO Billing (customer_id, subscription_id, billing_date, amount, payment_status) VALUES
(5, 5, '2024-03-25', 49.99, 'Paid'),
(6, 6, '2024-03-25', 79.99, 'Paid'),
(7, 7, '2024-03-25', 29.99, 'Paid'),
(8, 8, '2024-03-25', 49.99, 'Paid'),
(9, 9, '2024-03-25', 79.99, 'Paid'),
(10, 10, '2024-03-25', 29.99, 'Paid'),
(1, 1, '2024-03-24', 29.99, 'Paid'),
(2, 2, '2024-03-24', 49.99, 'Paid'),
(3, 3, '2024-03-24', 79.99, 'Paid'),
(4, 4, '2024-03-24', 29.99, 'Paid'),
(5, 5, '2024-03-24', 49.99, 'Paid'),
(6, 6, '2024-03-24', 79.99, 'Paid'),
(7, 7, '2024-03-24', 29.99, 'Paid'),
(8, 8, '2024-03-24', 49.99, 'Paid'),
(9, 9, '2024-03-24', 79.99, 'Paid'),
(10, 10, '2024-03-24', 29.99, 'Paid'),
(1, 1, '2024-03-23', 29.99, 'Paid'),
(2, 2, '2024-03-23', 49.99, 'Paid'),
(3, 3, '2024-03-23', 79.99, 'Paid'),
(4, 4, '2024-03-23', 29.99, 'Paid');

-- Inserting more payments data
INSERT INTO Payments (customer_id, payment_date, amount, payment_method) VALUES
(1, '2024-03-25', 29.99, 'Credit Card'),
(2, '2024-03-25', 49.99, 'PayPal'),
(3, '2024-03-25', 79.99, 'Bank Transfer'),
(4, '2024-03-25', 29.99, 'Credit Card'),
(5, '2024-03-25', 49.99, 'PayPal'),
(6, '2024-03-25', 79.99, 'Bank Transfer'),
(7, '2024-03-25', 29.99, 'Credit Card'),
(8, '2024-03-25', 49.99, 'PayPal'),
(9, '2024-03-25', 79.99, 'Bank Transfer'),
(10, '2024-03-25', 29.99, 'Credit Card'),
(1, '2024-03-25', 29.99, 'Credit Card'),
(2, '2024-03-25', 49.99, 'PayPal'),
(3, '2024-03-25', 79.99, 'Bank Transfer'),
(4, '2024-03-25', 29.99, 'Credit Card'),
(5, '2024-03-25', 49.99, 'PayPal'),
(6, '2024-03-25', 79.99, 'Bank Transfer'),
(7, '2024-03-25', 29.99, 'Credit Card'),
(8, '2024-03-25', 49.99, 'PayPal'),
(9, '2024-03-25', 79.99, 'Bank Transfer'),
(10, '2024-03-25', 29.99, 'Credit Card');
