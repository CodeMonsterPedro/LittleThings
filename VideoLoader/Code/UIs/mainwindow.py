# -*- coding: utf-8 -*-

################################################################################
## Form generated from reading UI file 'mainwindow.ui'
##
## Created by: Qt User Interface Compiler version 6.5.1
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
from PySide6.QtWidgets import (QApplication, QComboBox, QLineEdit, QMainWindow,
    QPushButton, QSizePolicy, QStatusBar, QWidget)

class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        if not MainWindow.objectName():
            MainWindow.setObjectName(u"MainWindow")
        MainWindow.resize(809, 222)
        self.centralwidget = QWidget(MainWindow)
        self.centralwidget.setObjectName(u"centralwidget")
        self.cb_quality = QComboBox(self.centralwidget)
        self.cb_quality.setObjectName(u"cb_quality")
        self.cb_quality.setGeometry(QRect(10, 110, 581, 31))
        self.btn_set_url = QPushButton(self.centralwidget)
        self.btn_set_url.setObjectName(u"btn_set_url")
        self.btn_set_url.setGeometry(QRect(680, 70, 111, 31))
        self.ln_url = QLineEdit(self.centralwidget)
        self.ln_url.setObjectName(u"ln_url")
        self.ln_url.setGeometry(QRect(10, 70, 661, 31))
        self.btn_start = QPushButton(self.centralwidget)
        self.btn_start.setObjectName(u"btn_start")
        self.btn_start.setGeometry(QRect(600, 110, 191, 71))
        self.ln_path = QLineEdit(self.centralwidget)
        self.ln_path.setObjectName(u"ln_path")
        self.ln_path.setGeometry(QRect(10, 30, 661, 31))
        self.btn_set_path = QPushButton(self.centralwidget)
        self.btn_set_path.setObjectName(u"btn_set_path")
        self.btn_set_path.setGeometry(QRect(680, 30, 111, 31))
        self.cb_audio = QComboBox(self.centralwidget)
        self.cb_audio.setObjectName(u"cb_audio")
        self.cb_audio.setGeometry(QRect(10, 150, 581, 31))
        MainWindow.setCentralWidget(self.centralwidget)
        self.statusBar = QStatusBar(MainWindow)
        self.statusBar.setObjectName(u"statusBar")
        MainWindow.setStatusBar(self.statusBar)

        self.retranslateUi(MainWindow)

        QMetaObject.connectSlotsByName(MainWindow)
    # setupUi

    def retranslateUi(self, MainWindow):
        MainWindow.setWindowTitle(QCoreApplication.translate("MainWindow", u"MainWindow", None))
        self.btn_set_url.setText(QCoreApplication.translate("MainWindow", u"Check", None))
        self.ln_url.setPlaceholderText(QCoreApplication.translate("MainWindow", u"url", None))
        self.btn_start.setText(QCoreApplication.translate("MainWindow", u"Start download", None))
        self.ln_path.setPlaceholderText(QCoreApplication.translate("MainWindow", u"Save path", None))
        self.btn_set_path.setText(QCoreApplication.translate("MainWindow", u"Save path", None))
    # retranslateUi

