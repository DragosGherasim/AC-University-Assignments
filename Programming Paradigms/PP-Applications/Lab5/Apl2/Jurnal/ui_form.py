# -*- coding: utf-8 -*-

################################################################################
## Form generated from reading UI file 'form.ui'
##
## Created by: Qt User Interface Compiler version 6.4.3
##
## WARNING! All changes made in this file will be lost when recompiling UI file!
################################################################################

from PySide6.QtCore import (QCoreApplication, QDate, QDateTime, QLocale,
    QMetaObject, QObject, QPoint, QRect,
    QSize, QTime, QUrl, Qt)
from PySide6.QtGui import (QBrush, QColor, QConicalGradient, QCursor,
    QFont, QFontDatabase, QGradient, QIcon,
    QImage, QKeySequence, QLinearGradient, QPainter,
    QPalette, QPixmap, QRadialGradient, QTransform)
from PySide6.QtWidgets import (QApplication, QLabel, QMainWindow, QPlainTextEdit,
    QPushButton, QSizePolicy, QWidget)

class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        if not MainWindow.objectName():
            MainWindow.setObjectName(u"MainWindow")
        MainWindow.resize(600, 397)
        self.centralwidget = QWidget(MainWindow)
        self.centralwidget.setObjectName(u"centralwidget")
        self.quote_lbl = QLabel(self.centralwidget)
        self.quote_lbl.setObjectName(u"quote_lbl")
        self.quote_lbl.setGeometry(QRect(20, 0, 551, 81))
        font = QFont()
        font.setFamilies([u"aakar"])
        font.setPointSize(14)
        self.quote_lbl.setFont(font)
        self.quote_lbl.setAlignment(Qt.AlignCenter)
        self.quote_lbl.setWordWrap(True)
        self.intrari_jurnal_txt = QPlainTextEdit(self.centralwidget)
        self.intrari_jurnal_txt.setObjectName(u"intrari_jurnal_txt")
        self.intrari_jurnal_txt.setGeometry(QRect(13, 99, 571, 181))
        self.save_btn = QPushButton(self.centralwidget)
        self.save_btn.setObjectName(u"save_btn")
        self.save_btn.setGeometry(QRect(20, 330, 83, 24))
        self.clear_text_btn = QPushButton(self.centralwidget)
        self.clear_text_btn.setObjectName(u"clear_text_btn")
        self.clear_text_btn.setGeometry(QRect(250, 280, 83, 24))
        self.load_btn = QPushButton(self.centralwidget)
        self.load_btn.setObjectName(u"load_btn")
        self.load_btn.setGeometry(QRect(490, 330, 83, 24))
        MainWindow.setCentralWidget(self.centralwidget)

        self.retranslateUi(MainWindow)

        QMetaObject.connectSlotsByName(MainWindow)
    # setupUi

    def retranslateUi(self, MainWindow):
        MainWindow.setWindowTitle(QCoreApplication.translate("MainWindow", u"Jurnal", None))
        self.quote_lbl.setText(QCoreApplication.translate("MainWindow", u"Quote", None))
        self.intrari_jurnal_txt.setPlainText(QCoreApplication.translate("MainWindow", u"Intrari Jurnal", None))
        self.save_btn.setText(QCoreApplication.translate("MainWindow", u"Save", None))
        self.clear_text_btn.setText(QCoreApplication.translate("MainWindow", u"Clear Text", None))
        self.load_btn.setText(QCoreApplication.translate("MainWindow", u"Load", None))
    # retranslateUi

