from os import path
from airflow.models import Variable
from dbt_airflow_factory.airflow_dag_factory import AirflowDagFactory


dag = AirflowDagFactory(path.dirname(path.abspath(__file__)), Variable.get("env")).create()
