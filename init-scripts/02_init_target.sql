-- Data Warehouse Schema
CREATE TABLE IF NOT EXISTS stg_orders_cdc (
    event_id SERIAL PRIMARY KEY,
    order_id INT,
    customer_name VARCHAR(100),
    product_name VARCHAR(100),
    quantity INT,
    price DECIMAL(10, 2),
    status VARCHAR(20),
    op_type VARCHAR(10),
    event_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS fact_daily_sales (
    sale_date DATE PRIMARY KEY,
    total_orders INT DEFAULT 0,
    total_revenue DECIMAL(12, 2) DEFAULT 0.00,
    completed_orders INT DEFAULT 0,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);