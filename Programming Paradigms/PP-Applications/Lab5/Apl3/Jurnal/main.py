from PySide6.QtWidgets import QApplication
import MainWindow as mw
import sys

if __name__ == "__main__":
    app = QApplication(sys.argv)
    widget = mw.MainWindow()
    widget.show()
    sys.exit(app.exec())