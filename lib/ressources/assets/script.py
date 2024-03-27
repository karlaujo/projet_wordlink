import json

# Load the JSON data from the file
with open('dictionary_old.json', 'r') as file:
    data = json.load(file)

# Create a new dictionary to store the unique data
unique_data = {}

# Iterate over the dictionary and remove duplicates
for word, description in data.items():
    if word not in unique_data:
        unique_data[word] = description

# Save the unique data to a new JSON file
with open('dictionary.json', 'w') as file:
    json.dump(unique_data, file, indent=4)