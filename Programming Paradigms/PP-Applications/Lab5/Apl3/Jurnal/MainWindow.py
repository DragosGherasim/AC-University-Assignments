# This Python file uses the following encoding: utf-8
import time
import os
import re
from collections import namedtuple

import DatabaseQuotes as dbq
import DatabaseJurnal as dbj

from PySide6.QtWidgets import QMainWindow
from PyQt5.QtGui import QColor

# Important:
# You need to run the following command to generate the ui_form.py file
#     pyside6-uic form.ui -o ui_form.py, or
#     pyside2-uic form.ui -o ui_form.py
from ui_form import Ui_MainWindow

Quote = namedtuple("quote", ["id", "content", "author"])
Jurnal = namedtuple("jurnal", ["id", "timestamp", "content"])

class MainWindow(QMainWindow):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)

        self.databaseq = dbq.DatabaseQuotes()
        self.databasej = dbj.DatabaseJurnal()

        self.add_quotes_db()
        self.show_quote()

        self.ui.save_btn.clicked.connect(self.save_in_jurnal)
        self.ui.clear_text_btn.clicked.connect(self.clear_text)
        self.ui.load_btn.clicked.connect(self.load_jurnal)

    def save_in_jurnal(self):
        timestamp_ = time.strftime('%Y-%m-%d %H-%M-%S')
        content_ = self.ui.intrari_jurnal_txt.toPlainText()

        self.databasej.insert(Jurnal(id = None,
                                     timestamp = timestamp_,
                                     content = content_))

        text = "Intrarea a fost introdusa cu succes !"
        cursor = self.ui.intrari_jurnal_txt.textCursor()

        color = QColor("green")
        cursor.insertHtml(f"<br><span style='color: {color.name()}'><i>{text}</i></span>")

    def load_jurnal(self):
        self.clear_text()

        if os.path.exists(self.databasej.DATABASE_PATH):
            entries = self.databasej.select_all()

            if entries:
                cursor = self.ui.intrari_jurnal_txt.textCursor()

                text = "Jurnal a fost incarcat cu succes"
                color = QColor("green")
                cursor.insertHtml(f"<span style='color: {color.name()}'><i>{text}</i></span><br>")

                for entry in entries:
                    cursor.insertHtml(f"<span>{entry.timestamp + ': ' + entry.content}</span>")
            else:
                cursor = self.ui.intrari_jurnal_txt.textCursor()

                text = "Jurnalul este gol"
                color = QColor("red")
                cursor.insertHtml(f"<span style='color: {color.name()}'><i>{text}</i></span><br>")

        else:
            cursor = self.ui.intrari_jurnal_txt.textCursor()

            text = "Baza de date a jurnalului nu a fost creata!"
            color = QColor("red")
            cursor.insertHtml(f"<span style='color: {color.name()}'><i>{text}</i></span>")

    def clear_text(self):
        self.ui.intrari_jurnal_txt.clear()

    def add_quotes_db(self):
        with open('Citate.txt') as f:
            lines = [line.strip() for line in f.readlines()]

        pattern = r'(.+)\s+\((.+)\)'
        for line in lines:
            match = re.search(pattern, line)

            content_ = match.group(1)
            author_ = match.group(2)
            self.databaseq.insert(Quote(id = None,
                                        content = content_,
                                        author = author_))

    def show_quote(self):
        new_quote = self.databaseq.select_by_id(int(self.databaseq.generate_rand_id()))
        self.ui.quote_lbl.setText(f"{new_quote.content} ({new_quote.author})")
