import os
import random
import sqlite3
from collections import namedtuple

Quote = namedtuple("quote", ["id", "content", "author"])

class DatabaseQuotes:
    CREATE_CMD = '''CREATE TABLE IF NOT EXISTS quotes (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    content VARCHAR(100) UNIQUE,
                    author VARCHAR(100) NOT NULL)'''
    INSERT_CMD = '''INSERT OR IGNORE INTO quotes(content, author)   
                    VALUES (?, ?)''' # pentru a nu adauga un quote deja existent
    SELECT_BY_ID_CMD = '''SELECT * FROM quotes WHERE id = ?'''

    CURRENT_PATH = os.path.dirname(os.path.abspath(__file__))
    DATABASE_PATH = os.path.join(CURRENT_PATH, 'quotes.db')

    def __init__(self):
        with sqlite3.connect(self.DATABASE_PATH) as db:
            cursor = db.cursor()    # pt a putea executa comenzi SQL
            cursor.execute(self.CREATE_CMD)
            cursor.close()

    def insert(self, quote):
        with sqlite3.connect(self.DATABASE_PATH) as db:
            cursor = db.cursor()
            cursor.execute(self.INSERT_CMD,
                           (quote.content, quote.author))
            cursor.close()

    def select_by_id(self, quote_id):
        with sqlite3.connect(self.DATABASE_PATH) as db:
            cursor = db.cursor()
            cursor.execute(self.SELECT_BY_ID_CMD, (quote_id,))
            row = cursor.fetchone()     # pt a prelua prima inregistrare din setul de rezultate
            cursor.close()
            if row:
                return Quote(*row)      # row (id, content, author) -> *row = [row[0], row[1], row[2]]
            return None

    def generate_rand_id(self):
        with sqlite3.connect(self.DATABASE_PATH) as db:
            cursor = db.cursor()
            cursor.execute("SELECT MAX(id) from quotes")
            max_id = cursor.fetchone()[0]   # pentru prima coloana a row-ului gasit
            cursor.close()
            return random.randint(1, max_id)



