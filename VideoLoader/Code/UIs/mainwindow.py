# -*- coding: utf-8 -*-

################################################################################
## Form generated from reading UI file 'mainwindow.ui'
##
## Created by: Qt User Interface Compiler version 5.15.2
##
## WARNING! All changes made in this file will be lost when recompiling UI file!
################################################################################

from PySide2.QtCore import *
from PySide2.QtGui import *
from PySide2.QtWidgets import *


class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        if not MainWindow.objectName():
            MainWindow.setObjectName(u"MainWindow")
        MainWindow.resize(814, 736)
        self.centralwidget = QWidget(MainWindow)
        self.centralwidget.setObjectName(u"centralwidget")
        self.tbw_data = QTableWidget(self.centralwidget)
        self.tbw_data.setObjectName(u"tbw_data")
        self.tbw_data.setGeometry(QRect(10, 200, 781, 361))
        self.cb_quality = QComboBox(self.centralwidget)
        self.cb_quality.setObjectName(u"cb_quality")
        self.cb_quality.setGeometry(QRect(10, 110, 661, 31))
        self.btn_add = QPushButton(self.centralwidget)
        self.btn_add.setObjectName(u"btn_add")
        self.btn_add.setGeometry(QRect(680, 110, 111, 31))
        self.btn_set_url = QPushButton(self.centralwidget)
        self.btn_set_url.setObjectName(u"btn_set_url")
        self.btn_set_url.setGeometry(QRect(680, 70, 111, 31))
        self.ln_url = QLineEdit(self.centralwidget)
        self.ln_url.setObjectName(u"ln_url")
        self.ln_url.setGeometry(QRect(10, 70, 661, 31))
        self.btn_start = QPushButton(self.centralwidget)
        self.btn_start.setObjectName(u"btn_start")
        self.btn_start.setGeometry(QRect(320, 590, 191, 71))
        self.btn_clean_all = QPushButton(self.centralwidget)
        self.btn_clean_all.setObjectName(u"btn_clean_all")
        self.btn_clean_all.setGeometry(QRect(680, 150, 111, 31))
        self.ln_path = QLineEdit(self.centralwidget)
        self.ln_path.setObjectName(u"ln_path")
        self.ln_path.setGeometry(QRect(10, 30, 661, 31))
        self.btn_set_path = QPushButton(self.centralwidget)
        self.btn_set_path.setObjectName(u"btn_set_path")
        self.btn_set_path.setGeometry(QRect(680, 30, 111, 31))
        self.spb_id = QSpinBox(self.centralwidget)
        self.spb_id.setObjectName(u"spb_id")
        self.spb_id.setGeometry(QRect(490, 150, 61, 31))
        self.btn_remove = QPushButton(self.centralwidget)
        self.btn_remove.setObjectName(u"btn_remove")
        self.btn_remove.setGeometry(QRect(560, 150, 111, 31))
        MainWindow.setCentralWidget(self.centralwidget)
        self.statusBar = QStatusBar(MainWindow)
        self.statusBar.setObjectName(u"statusBar")
        MainWindow.setStatusBar(self.statusBar)

        self.retranslateUi(MainWindow)

        QMetaObject.connectSlotsByName(MainWindow)
    # setupUi

    def retranslateUi(self, MainWindow):
        MainWindow.setWindowTitle(QCoreApplication.translate("MainWindow", u"MainWindow", None))
        self.btn_add.setText(QCoreApplication.translate("MainWindow", u"Add", None))
        self.btn_set_url.setText(QCoreApplication.translate("MainWindow", u"Check", None))
        self.ln_url.setPlaceholderText(QCoreApplication.translate("MainWindow", u"url", None))
        self.btn_start.setText(QCoreApplication.translate("MainWindow", u"Start download", None))
        self.btn_clean_all.setText(QCoreApplication.translate("MainWindow", u"Clean all", None))
        self.ln_path.setPlaceholderText(QCoreApplication.translate("MainWindow", u"Save path", None))
        self.btn_set_path.setText(QCoreApplication.translate("MainWindow", u"Save path", None))
        self.btn_remove.setText(QCoreApplication.translate("MainWindow", u"Remove", None))
    # retranslateUi

