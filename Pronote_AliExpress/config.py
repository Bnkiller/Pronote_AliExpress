import os
from urllib.parse import quote_plus

class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY') or os.urandom(32)
    
    # Configuration SQLAlchemy
    DB_PASS = quote_plus("pronote@01")  # Échapper les caractères spéciaux
    SQLALCHEMY_DATABASE_URI = f"mysql+pymysql://pronote:{DB_PASS}@localhost/pronote1"
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SQLALCHEMY_POOL_RECYCLE = 280
    SQLALCHEMY_POOL_SIZE = 10
