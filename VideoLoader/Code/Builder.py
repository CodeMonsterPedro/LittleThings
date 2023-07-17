from moviepy.editor import *
import os

class Builder:

    def __init__(self):
        self.savePath = ''

    def build(self, mediaClip):
        mediaClip.download(self.savePath)
        videoClip = VideoFileClip(mediaClip.video, audio=False)
        audioClip = AudioFileClip(mediaClip.audio)
        videoClip = videoClip.set_audio(audioClip)
        videoClip.write_videofile(filename=self.savePath + mediaClip.getTargetFileName(), fps=mediaClip.fps, audio=True, threads=8)
        mediaClip.removeFiles()