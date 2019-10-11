import pyaudio
import pprint
p = pyaudio.PyAudio()
device = [p.get_device_info_by_index(i) for i in range(p.get_device_count())]
pprint.pprint(device)
