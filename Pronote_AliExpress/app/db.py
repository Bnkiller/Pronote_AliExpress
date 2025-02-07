import mysql.connector
from flask import g
import os
from dotenv import load_dotenv

# Charger les variables d'environnement
load_dotenv()

def get_db():
    if 'db' not in g:
        g.db = mysql.connector.connect(
            host=os.getenv('DB_HOST'),
            user=os.getenv('DB_USER'),
            password=os.getenv('DB_PASSWORD'),
            database=os.getenv('DB_NAME')
        )
    return g.db

def close_db(e=None):
    db = g.pop('db', None)
    if db is not None:
        db.close()

def init_app(app):
    """Enregistre la fonction close_db pour être appelée à la fin de chaque requête"""
    app.teardown_appcontext(close_db)
