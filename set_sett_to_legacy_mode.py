import os
import sys
import json

# The likely sett config file locations:
home_directory = os.path.expanduser('~')
sett_config_file_path_linux_macos = os.path.join(home_directory, '.config','sett','config.json')
sett_config_file_path_windows = os.path.join(home_directory,'AppData','Roaming','sett','config.json')

# Create a standard set config file if none exists
if not os.path.isfile(sett_config_file_path_linux_macos) and not os.path.isfile(sett_config_file_path_windows):
    print("[INFO] Sett config file not found, trying to create")
    cmd = 'sett config --create'
    os.system(cmd)

# Check where the sett config file is located
if os.path.isfile(sett_config_file_path_linux_macos):
    sett_config_file_path = sett_config_file_path_linux_macos
elif os.path.isfile(sett_config_file_path_windows):
    sett_config_file_path = sett_config_file_path_windows
else:
    print("[ERROR] Could not locate sett config file")
    sys.exit("[ERROR] Could not locate sett config file")

print(f"[INFO] Sett config file location:'{sett_config_file_path}'")

# Read the JSON config file
with open(sett_config_file_path, 'r', encoding='utf-8') as json_file:
    config_data = json.load(json_file)

# Check if "legacy_mode" exists in the config data
if 'legacy_mode' not in config_data:
    print(f"[WARNING] Could not find 'legacy_mode' in config file:'{sett_config_file_path}'")
    #print("[WARNING] The current contents is:")
    #json_str = json.dumps(config_data, indent=4)
    #print(json_str)
    print("[WARNING] Trying to add 'legacy_mode'")
    
# Set sett to legacy mode:
config_data['legacy_mode'] = True
    
# Write legacy_mode value to sett config
with open(sett_config_file_path, 'w', encoding='utf-8') as json_file:
    json.dump(config_data, json_file)

    print('[INFO] Sett config file updated successfully with legacy mode enabeled')
