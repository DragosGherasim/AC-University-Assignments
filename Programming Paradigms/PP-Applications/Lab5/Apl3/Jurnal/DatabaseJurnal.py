import os
import sqlite3
from collections import namedtuple

Jurnal = namedtuple("jurnal", ["id", "timestamp", "content"])

class DatabaseJurnal:
    CREATE_CMD = '''CREATE TABLE IF NOT EXISTS jurnal(
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    timestamp VARCHAR[30] NOT NULL,
                    content VARCHAR[100] NOT NULL)'''

    INSERT_CMD = '''INSERT INTO jurnal(timestamp, content)
                    VALUES (?, ?)'''

    SELECT_ALL_CMD = '''SELECT * FROM jurnal'''

    CURRENT_PATH = os.path.dirname(os.path.abspath(__file__))
    DATABASE_PATH = os.path.join(CURRENT_PATH, 'jurnal.db')

    def __init__(self):
        with sqlite3.connect(self.DATABASE_PATH) as db:
            cursor = db.cursor()
            cursor.execute(self.CREATE_CMD)
            cursor.close()

    def insert(self, jurnal):
        with sqlite3.connect(self.DATABASE_PATH) as db:
            cursor = db.cursor()
            cursor.execute(self.INSERT_CMD,
                           (jurnal.timestamp, jurnal.content))
            cursor.close()

    def select_all(self):
        with sqlite3.connect(self.DATABASE_PATH) as db:
            cursor = db.cursor()
            cursor.execute(self.SELECT_ALL_CMD)
            rows = cursor.fetchall()
            cursor.close()
            return [Jurnal(*row) for row in rows]