# CDC - ETL - BI Pipeline Demo Stack

## Các dịch vụ trong hệ thống
- **Source DB**: PostgreSQL (Port 5432) - Cơ sở dữ liệu giao dịch
- **CDC**: Debezium Connect (Port 8083) - Bắt biến động WAL log
- **Message Broker**: Apache Kafka (Port 9092 / 29092)
- **Data Warehouse**: PostgreSQL (Port 5433) - Kho dữ liệu phân tích
- **Orchestrator**: Apache Airflow (Port 8080)
- **BI Tool**: Apache Superset (Port 8088)

## Các bước vận hành

1. **Khởi chạy hệ thống**:
   ```bash
   docker-compose up -d