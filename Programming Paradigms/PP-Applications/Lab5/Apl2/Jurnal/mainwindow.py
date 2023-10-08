# This Python file uses the following encoding: utf-8
import sys
import random
import time
import os

from PySide6.QtWidgets import QApplication, QMainWindow, QPushButton, QLabel
from PyQt5.QtGui import QTextCursor, QColor

# Important:
# You need to run the following command to generate the ui_form.py file
#     pyside6-uic form.ui -o ui_form.py, or
#     pyside2-uic form.ui -o ui_form.py
from ui_form import Ui_MainWindow

class MainWindow(QMainWindow):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)

        with open('Citate.txt') as f:
            self.quotes = [line.strip() for line in f.readlines()]

        self.show_quote()

        self.ui.save_btn.clicked.connect(self.save_in_jurnal)
        self.ui.clear_text_btn.clicked.connect(self.clear_text)
        self.ui.load_btn.clicked.connect(self.load_jurnal)

    def save_in_jurnal(self):
        timestamp = time.strftime('%Y-%m-%d %H-%M-%S')
        text = self.ui.intrari_jurnal_txt.toPlainText()

        if os.path.exists("Jurnal.txt"):
            with open("Jurnal.txt", "r+") as f:
                content = f.read()
                f.seek(0)
                f.write(f"{timestamp}: {text}\n{content}")
        else:
            with open("Jurnal.txt", "w") as f:
                content = f.read()
                f.write(f"{timestamp}: {text}\n{content}")

        text = "Intrarea a fost introdusa cu succes !"
        cursor = self.ui.intrari_jurnal_txt.textCursor()

        color = QColor("green")
        cursor.insertHtml(f"<br><span style='color: {color.name()}'><i>{text}</i></span>")

    def load_jurnal(self):
        self.clear_text()

        if os.path.exists("Jurnal.txt") and os.path.getsize("Jurnal.txt") != 0:
            with open("Jurnal.txt", "r") as f:
                cursor = self.ui.intrari_jurnal_txt.textCursor()

                text = "Jurnal a fost incarcat cu succes"
                color = QColor("green")
                cursor.insertHtml(f"<span style='color: {color.name()}'><i>{text}</i></span><br>")

                content = f.read()
                cursor.insertHtml(f"<span>{content}</span>")
        else:
            cursor = self.ui.intrari_jurnal_txt.textCursor()

            text = "Jurnal nu a fost incarcat !"
            color = QColor("red")
            cursor.insertHtml(f"<span style='color: {color.name()}'><i>{text}</i></span>")

    def clear_text(self):
        self.ui.intrari_jurnal_txt.clear()

    def show_quote(self):
        new_quote = random.choice(self.quotes)
        self.ui.quote_lbl.setText(new_quote)

if __name__ == "__main__":
    app = QApplication(sys.argv)
    widget = MainWindow()
    widget.show()
    sys.exit(app.exec())
