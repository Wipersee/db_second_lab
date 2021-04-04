import logging

log_func = logging.getLogger(__name__)
logging.basicConfig(
    filename="work_logs.log",
    level=logging.DEBUG,
    format="%(asctime)s %(levelname)s at row #%(lineno)d %(message)s",
    datefmt="%m-%d-%Y %H:%M:%S",
)