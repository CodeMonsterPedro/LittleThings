import sys
import os
from PySide6.QtWidgets import QApplication, QMainWindow, QTableWidgetItem, QTableWidget, QFileDialog
from UIs.mainwindow import Ui_MainWindow
import requests
from MediaFile import MediaFile
from Builder import Builder


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
        self.ui.cb_quality.setEnabled(False)
        self.ui.cb_audio.setEnabled(False)
        self.ui.btn_start.setEnabled(False)
        self.ui.btn_set_url.clicked.connect(self.setUrl)
        self.ui.btn_set_path.clicked.connect(self.selectSavePath)
        self.ui.ln_path.editingFinished.connect(self.setSavePath)
        self.ui.btn_start.clicked.connect(self.startDownload)
        self.ui.statusBar.showMessage("ready")
        self.qualityList = []
        self.audioList = []
        self.mediaFile = 0
        self.builder = Builder()

    def __del__(self):
        pass

# UIs methods 

    def startDownload(self):
        self.mediaFile.setQuality(self.qualityList[self.ui.cb_quality.currentIndex()][1], self.audioList[self.ui.cb_audio.currentIndex()][1])
        self.builder.build(self.mediaFile)

    def selectSavePath(self):
        dialog = QFileDialog()
        url = dialog.getExistingDirectoryUrl()
        self.savePath(url.path())

    def setSavePath(self):
        path = self.ui.ln_path.text()
        if self.checkPath(path):
            self.builder.savePath = str(path)
        else:
            self.builder.savePath = "~/Videos"
            self.ui.ln_path.setText("Error")

    def checkPath(self, path):
        return os.path.exists(path)

    def savePath(self, path):
        self.builder.savePath = str(path + '/')
        self.ui.ln_path.setText(path)

    def setUrl(self):
        url = self.ui.ln_url.text()
        if self.checkUrl(url):
            self.ui.cb_quality.setEnabled(True)
            self.ui.cb_audio.setEnabled(True)
            self.mediaFile = MediaFile(url)
            streams = self.mediaFile.getQualityList()
            self.qualityList = streams[0].copy()
            self.audioList = streams[1].copy()
            tmp = []
            for row in streams[0]:
                tmp.append(row[0])
            self.setQualityList(tmp)
            tmp = []
            for row in streams[1]:
                tmp.append(row[0])
            self.setAudioList(tmp)
            self.ui.btn_start.setEnabled(True)
        else:
            self.ui.ln_url.setText("Error")

    def checkUrl(self, url):
        response = requests.get(url)
        if response.status_code == 200:
            return True
        else:
            return False

# tbw_data methods

    def setQualityList(self, qualities):
        self.ui.cb_quality.clear()
        self.ui.cb_quality.addItems(qualities)

    def setAudioList(self, audios):
        self.ui.cb_audio.clear()
        self.ui.cb_audio.addItems(audios)

if __name__ == "__main__":
    app = QApplication([])
    window = Base()
    window.show()
    sys.exit(app.exec_())
    window.mediaFile.clear()
