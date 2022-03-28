from pytube import YouTube
from datetime import datetime

class Loader:

    def __init__(self):
        self.urls = []
        self.qualityId = []
        self.filetypes = []
        self.savePath = '~/Videos'

    def downloadStream(self, url, streamId):
        start = datetime.now()
        yt = YouTube(url)
        streams = yt.streams
        item = streams[streamId]
        print("start download a stream {} with: \n".format(streamId))
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
        print("\nFor source: {}".format(yt.title))
        print("available list of quality: ")
        for row in streams:
            print(row)
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
