# Name: Akshath Jain
# Date: 1/25/2020
# Purpose: converts an mp4 to GIF
# Copyright: © 2020, Akshath Jain. All rights reserved.

# pip install MoviePy
import moviepy.editor as mp

file = "video.mp4"
output = "example.gif"
fps = 27
quality = 0.35

video = mp.VideoFileClip(file)
video = video.resize(width=400)
video.write_gif(output, fps=fps)
