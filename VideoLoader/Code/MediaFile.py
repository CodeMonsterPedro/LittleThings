from pytube import YouTube
from datetime import datetime
import os

class MediaFile:

    def __init__(self, url, bestQuality=False):
        self.url = url
        self.is_best_quality = bestQuality
        self.fps = 0
        self.abr = 0
        self.video_stream = 0
        self.audio_stream = 0
        self.video = 0
        self.audio = 0
        yt = YouTube(url)
        self.streams = yt.streams
        self.file_name = self.removeSpaces(self.streams[0].default_filename)

    def __del__(self):
        if self.video:
            self.clear()

    def clear(self):
        self.removeFiles()
        self.file_name = ''

    def removeFiles(self):
        os.remove(self.video)
        os.remove(self.audio)
        self.video_stream = 0
        self.audio_stream = 0
        self.abr = 0
        self.fps = 0

    def removeSpaces(self, name):
        l = list(name)
        for i in range(len(l)):
            if l[i] == ' ':
                l[i] = '_'
        return ''.join(l)   
    
    def getTargetFileName(self):
        return self.file_name + ".mp4"

    def download(self, save_path):
        print("Start downloading")
        start = datetime.now()
        self.video = self.video_stream.download(output_path=save_path, filename='video_' + self.file_name + '.' + self.video_stream.subtype)
        self.audio = self.audio_stream.download(output_path=save_path, filename='audio_' + self.file_name + '.' + self.audio_stream.subtype)
        end = datetime.now()
        print("Download time: {}".format(str(end-start)))

    def getQualityList(self):
        videoStrams = []
        audioStreams = []
        for i in range(len(self.streams)):
            item = self.streams[i]
            if item.type == "video":
                videoStrams.append(("resolution:{}_fps:{}_codec:{}_filetype:{}".format(item.resolution, item.fps, item.video_codec, item.subtype), i))
            else:
                audioStreams.append(("abr:{}_audio_codec:{}_filetype:{}".format(item.abr, item.audio_codec, item.subtype), i))
        return (videoStrams, audioStreams)
    
    def setQuality(self, video_id, audio_id):
        self.video_stream = self.streams[video_id]
        self.fps = self.video_stream.fps
        self.audio_stream = self.streams[audio_id]
        self.abr = self.audio_stream.abr[:-2]
