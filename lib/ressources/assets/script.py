import json
import re

# Load the JSON data
with open('dictionary_old.json', 'r', encoding='utf-8') as file:
    data = json.load(file)

# Define a function to replace \u00e9 with é
def replace_e_accent(match):
    return 'é'

# Use a regular expression to find and replace \u00e9
pattern = r'\\u00e9'
for key in data:
    data[key] = re.sub(pattern, replace_e_accent, data[key])

# Save the modified JSON data
with open('dictionary.json', 'w', encoding='utf-8') as file:
    json.dump(data, file, ensure_ascii=False, indent=4)