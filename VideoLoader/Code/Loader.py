from re import S
from pytube import YouTube
from datetime import datetime

class Loader:

    def __init__(self):
        self.urls = []
        self.qualityId = []
        self.filetypes = []
        self.savePath = 'Videos'

    def downloadStream(self, url, streamId):
        start = datetime.now()
        yt = YouTube(url)
        streams = yt.streams
        item = streams[streamId]
        print("\nstart download a stream {} with:".format(streamId))
        if item.type == "video":
            print("resolution: {}\nfps: {}\nvideo_codec: {}\n".format(item.resolution, item.fps, item.video_codec))
            streams[streamId].download(output_path=self.savePath, filename_prefix="{}_{}_{}_".format(item.resolution, item.fps, streamId))
        else:
            print("abr:{}_audio_codec:{}".format(item.abr, item.audio_codec))
            streams[streamId].download(output_path=self.savePath, filename_prefix="{}_{}_{}_".format(item.abr, item.audio_codec, streamId))
        end = datetime.now()
        print("time spended on download: {}".format(str(end-start)))

    def getQualityList(self, url):
        yt = YouTube(url)
        streams = yt.streams
        result = []
        for item in streams:
            if item.type == "video":
                result.append("resolution:{}_fps:{}_codec:{}_filetype:{}".format(item.resolution, item.fps, item.video_codec, item.subtype))
            else:
                result.append("abr:{}_audio_codec:{}_filetype:{}".format(item.abr, item.audio_codec, item.subtype))
        return result

    def addTaskRow(self, row):
        self.urls.append(row[0])
        self.qualityId.append(row[1])

    def startDownload(self, i):
        self.downloadStream(self.urls[i], self.qualityId[i])

    def getStreamInfo(self):
        url = self.urls[-1]
        qualityText = self.getQualityList(url)[self.qualityId[-1]]
        filetype = qualityText.split(":")[-1]
        yt = YouTube(url)
        streams = yt.streams
        item = streams[self.qualityId[-1]]
        size = item.filesize / 1000000.0
        if size > 1000:
            size = size / 1000.0
            size = float(int(size * 10)) / 10.0
            size = "{} GB".format(size)
        else:
            size = float(int(size * 10)) / 10.0
            size = "{} MB".format(size)
        return (url, qualityText, filetype, size)
