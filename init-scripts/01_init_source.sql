-- Source OLTP Database Schema & Initial Data
CREATE TABLE IF NOT EXISTS orders (
    order_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Seed data ban dau
INSERT INTO orders (customer_name, product_name, quantity, price, status) VALUES
('Pham Cuong', 'Laptop Dell XPS 15', 1, 1500.00, 'COMPLETED'),
('Nguyen Van A', 'Logitech MX Master 3S', 2, 99.00, 'COMPLETED'),
('Tran Thi B', 'Keychron K2 Keyboard', 1, 85.00, 'PENDING');