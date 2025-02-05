import mysql.connector
from flask import g

def get_db():
    if 'db' not in g:
        g.db = mysql.connector.connect(
            host="localhost",
            user="pronote",      # Remplacez par votre nouvel utilisateur
            password="pronote@01",   # Remplacez par votre nouveau mot de passe
            database="pronote1"
        )
    return g.db

def close_db(e=None):
    db = g.pop('db', None)
    if db is not None:
        db.close()

def init_app(app):
    """Enregistre la fonction close_db pour être appelée à la fin de chaque requête"""
    app.teardown_appcontext(close_db)
