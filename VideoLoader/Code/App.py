import sys
import os
from PySide2.QtWidgets import QApplication, QMainWindow, QTableWidgetItem, QTableWidget, QFileDialog
from UIs.mainwindow import Ui_MainWindow
import requests
from Loader import Loader


'''
TOFIX

file type change 
string in table full size
fix status bar issue

TODO

any video quality download
Playlist download
Channel download
livestream download

'''

class Base(QMainWindow):
    def __init__(self):
        QMainWindow.__init__(self)
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)
        self.ui.ln_path.setText('Videos')
        self.headers = ['url', 'quality', 'filetype']
        self.ui.tbw_data.setColumnCount(len(self.headers))
        self.ui.tbw_data.setHorizontalHeaderLabels(self.headers)
        self.ui.tbw_data.setColumnWidth(0, 600)
        self.ui.spb_id.setMinimum(1)
        self.ui.cb_quality.setEnabled(False)
        self.ui.btn_clean_all.setEnabled(False)
        self.ui.btn_start.setEnabled(False)
        self.ui.btn_add.setEnabled(False)
        self.ui.btn_remove.setEnabled(False)
        self.ui.spb_id.setEnabled(False)
        self.ui.btn_set_url.clicked.connect(self.setUrl)
        self.ui.btn_set_path.clicked.connect(self.selectSavePath)
        self.ui.ln_path.editingFinished.connect(self.setSavePath)
        self.ui.btn_add.clicked.connect(self.addUrl)
        self.ui.btn_remove.clicked.connect(self.removeUrl)
        self.ui.btn_start.clicked.connect(self.startDownload)
        self.ui.btn_clean_all.clicked.connect(self.clearTable)
        self.loader = Loader()
        self.ui.statusBar.showMessage("ready")

# UIs methods 

    def startDownload(self):
        self.ui.statusBar.showMessage("download started")
        queueSize = self.ui.tbw_data.rowCount()
        for i in range(queueSize):
            self.ui.statusBar.showMessage("downloading file {} of {}".format(i, queueSize))
            self.loader.startDownload(i)
        self.ui.statusBar.showMessage("download finished")

    def clearTable(self):
        for i in range(self.ui.tbw_data.rowCount(), -1, -1):
            self.ui.tbw_data.removeRow(i)
        self.ui.btn_start.setEnabled(False)
        self.ui.btn_clean_all.setEnabled(False)
        self.ui.btn_remove.setEnabled(False)
        self.ui.spb_id.setEnabled(False)

    def addUrl(self):
        url = self.ui.ln_url.text()
        qualityText = self.ui.cb_quality.currentText()
        qualityId = self.ui.cb_quality.currentIndex()
        filetype = qualityText.split("_")
        filetype = filetype[-1].split(":")
        filetype = filetype[-1]
        if self.ui.tbw_data.rowCount() == 0:
            self.ui.btn_start.setEnabled(True)
            self.ui.btn_clean_all.setEnabled(True)
            self.ui.btn_remove.setEnabled(True)
            self.ui.spb_id.setEnabled(True)
        self.loader.addTaskRow([url, qualityId])
        self.addRow([url, qualityText, filetype])
        self.ui.cb_quality.clear()
        self.ui.cb_quality.setEnabled(False)
        self.ui.ln_url.setText('')
        self.ui.btn_add.setEnabled(False)

    def selectSavePath(self):
        dialog = QFileDialog()
        url = dialog.getExistingDirectoryUrl()
        self.savePath(url.path())

    def setSavePath(self):
        path = self.ui.ln_path.text()
        if self.checkPath(path):
            self.loader.savePath = str(path)
        else:
            self.loader.savePath = "~/Videos"
            self.ui.ln_path.setText("Error")

    def checkPath(self, path):
        return os.path.exists(path)

    def savePath(self, path):
        self.loader.savePath = str(path)
        self.ui.ln_path.setText(path)

    def setUrl(self):
        url = self.ui.ln_url.text()
        if self.checkUrl(url):
            self.ui.cb_quality.setEnabled(True)
            self.ui.btn_add.setEnabled(True)
            self.setQualityList(self.loader.getQualityList(url))
        else:
            self.ui.ln_url.setText("Error")

    def checkUrl(self, url):
        response = requests.get(url)
        if response.status_code == 200:
            return True
        else:
            return False

# tbw_data methods

    def removeUrl(self):
        id = self.ui.spb_id.value() - 1
        self.ui.tbw_data.removeRow(id)
        self.ui.spb_id.setMaximum(self.ui.tbw_data.rowCount())

    def setQualityList(self, qualities):
        self.ui.cb_quality.clear()
        self.ui.cb_quality.addItems(qualities)

    def addRow(self, row):
        index = self.ui.tbw_data.rowCount()
        self.ui.tbw_data.insertRow(index)
        self.ui.tbw_data.setItem(index, 0, QTableWidgetItem(str(row[0])))
        self.ui.tbw_data.setItem(index, 1, QTableWidgetItem(str(row[1])))
        self.ui.tbw_data.setItem(index, 2, QTableWidgetItem(str(row[2])))
        self.ui.spb_id.setMaximum(self.ui.tbw_data.rowCount())

if __name__ == "__main__":
    app = QApplication([])
    window = Base()
    window.show()
    sys.exit(app.exec_())
