from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime, timedelta
import psycopg2

def aggregate_daily_sales():
    # Kết nối tới Target Data Warehouse
    dw_conn = psycopg2.connect(
        host="warehouse-db",
        port=5432,
        dbname="dw_db",
        user="dw_user",
        password="dw_password"
    )
    cursor = dw_conn.cursor()
    
    # Transform logic: Tổng hợp dữ liệu từ staging CDC vào bảng Fact
    query = """
    INSERT INTO fact_daily_sales (sale_date, total_orders, total_revenue, completed_orders, last_updated)
    SELECT 
        CURRENT_DATE as sale_date,
        COUNT(order_id) as total_orders,
        COALESCE(SUM(quantity * price), 0) as total_revenue,
        COUNT(CASE WHEN status = 'COMPLETED' THEN 1 END) as completed_orders,
        NOW() as last_updated
    FROM stg_orders_cdc
    ON CONFLICT (sale_date) 
    DO UPDATE SET 
        total_orders = EXCLUDED.total_orders,
        total_revenue = EXCLUDED.total_revenue,
        completed_orders = EXCLUDED.completed_orders,
        last_updated = NOW();
    """
    cursor.execute(query)
    dw_conn.commit()
    cursor.close()
    dw_conn.close()

default_args = {
    'owner': 'data_engineer',
    'start_date': datetime(2026, 1, 1),
    'retries': 1,
    'retry_delay': timedelta(minutes=1),
}

with DAG(
    'cdc_order_aggregation_etl',
    default_args=default_args,
    schedule_interval='*/5 * * * *',  # Chạy 5 phút 1 lần
    catchup=False
) as dag:

    run_etl = PythonOperator(
        task_id='transform_and_load_sales_fact',
        python_callable=aggregate_daily_sales
    )