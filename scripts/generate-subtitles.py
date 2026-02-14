import whisper
import torch
import sys
from whisper.utils import get_writer
from datetime import timedelta

# WIP - expect breaking changes
# 1. Get audio from the video file (you can export using your editor or use ffmpeg)
# 2. Generate srt subtitles using this script
# 3. My editing software uses ASS format so you can convert .srt to .ass file using (ffmpeg -i input.srt output.ass)
# Extras: This script creates subttile with one word per line add a PR or issue on github and I'll update the script


def format_ts(seconds: float) -> str:
    td = timedelta(seconds=seconds)
    total = int(td.total_seconds())
    hours = total // 3600
    minutes = (total % 3600) // 60
    secs = total % 60
    millis = int((seconds - int(seconds)) * 1000)
    return f"{hours:02}:{minutes:02}:{secs:02},{millis:03}"

# Define the path to your custom .pt model file and audio file
custom_model_path = "/Users/Saurav_Sahu/.cache/whisper/large-v3-turbo.pt" # Replace with the actual path to your .pt file

audio_file_path = sys.argv[1]
OUTPUT_SRT=sys.argv[2]

# Initialize a model with the same architecture as your fine-tuned model
# Example: If your .pt file is a 'small' English-only model
model_id = "large"
model = whisper.load_model(model_id)

# Manually load the state dictionary from your .pt file
# Note: This might require specific handling depending on how the model was saved
try:
    model.load_state_dict(torch.load(custom_model_path))
    print(f"Successfully loaded weights from {custom_model_path}")
except Exception as e:
    print(f"Error loading state_dict")
    # If load_state_dict fails, you might need to adjust the loading logic 
    # or how the model was initially saved (e.g., if the entire model was saved)
    # You could try: model = torch.load(custom_model_path)


# Perform transcription
result = model.transcribe(audio_file_path,
                          language=None,
                          word_timestamps=True)

index = 1
with open(OUTPUT_SRT, "w", encoding="utf-8") as f:
    for segment in result["segments"]:
        for word in segment.get("words", []):
            start = format_ts(word["start"])
            end = format_ts(word["end"])
            text = word["word"].strip()
            print(text)
            print(word)
            print("---")

            f.write(f"{index}\n")
            f.write(f"{start} --> {end}\n")
            f.write(f"{text}\n\n")

            index += 1

print("Finished.")
