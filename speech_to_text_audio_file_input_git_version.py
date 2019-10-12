import speech_recognition as sr


# give the audio file name
audio_file_name = 'male_recording'

r = sr.Recognizer()

# Capture data from file
my_data = sr.AudioFile(audio_file_name+ '.wav')

with my_data as source:
    audio = r.record(source, duration = 60)


# Speech Recognition
text = r.recognize_google_cloud(audio)

# Save file
with open('{}.txt'.format(audio_file_name), 'w') as outfile:
    outfile.write(text)

