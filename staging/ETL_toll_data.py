# import the libraries
from datetime import timedelta
# The DAG object; we'll need this to instantiate a DAG
from airflow import DAG
# Operators; we need this to write tasks!
from airflow.operators.bash_operator import BashOperator
# This makes scheduling easy
from airflow.utils.dates import days_ago

default_args = {
    'owner': 'Gyasi, Frederick',
    'start_date': days_ago(0),
    'email': ['gyasifred@gmail.com'],
    'email_on_failure': True,
    'email_on_retry': True,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}
# defining the DAG
dag = DAG(
    'ETL_toll_data',
    default_args=default_args,
    description='Apache Airflow Final Assignment',
    schedule_interval=timedelta(days=1),
)
# define the tasks

# define the task named extract_transform_and_load to call the shell script
extract_transform_load = BashOperator(
    task_id="extract_transform_load",
    bash_command="Extract_Transform_data.sh",
    dag=dag,
)

# task pipeline
extract_transform_load