# pylint: disable=missing-module-docstring

import time
import uuid
import pyautogui

def press_with_sleep(key_input: list, sleep_value: int):
    """
    Takes key press input and sleep value
    """
    pyautogui.press(key_input)
    time.sleep(sleep_value)

def write_with_sleep(write_input: str, sleep_value: int):
    """
    Takes write input and sleep value
    """
    pyautogui.write(write_input)
    time.sleep(sleep_value)

THREAD_ID = '5024734647638392'

# DEBUG INFO
RUN_ID = uuid.uuid4()
print(f'RUN_ID: {RUN_ID}')

# Console command to open web browser -- STEPS MAY BE DIFFERENT FOR VM!

# Open firefox
press_with_sleep('winleft', 1)
write_with_sleep('terminal', 1)
press_with_sleep('enter', 1)
write_with_sleep('firefox &', 1)
press_with_sleep('enter', 3)

# Log into facebook messenger
press_with_sleep('f11', 1)
write_with_sleep(f'https://www.facebook.com/messages/t/{THREAD_ID}', 3)
press_with_sleep('enter', 3)
write_with_sleep('<email>', 1) # TODO: replace with AWS SSM parameter value
press_with_sleep('tab', 1)
write_with_sleep('<password>', 1) # TODO: replace with AWS SSM parameter value
press_with_sleep('tab', 1)
press_with_sleep('enter', 10)

# Create the poll
pyautogui.click('image_assets/add.png')
time.sleep(1)
pyautogui.click('image_assets/poll.png')
time.sleep(1)
write_with_sleep(f'[JW] Badminton this week?', 1)
press_with_sleep('tab', 1)
write_with_sleep('Yes', 1)
press_with_sleep('tab', 1)
write_with_sleep('No', 1)
press_with_sleep('tab', 1)
press_with_sleep('tab', 1)
press_with_sleep('enter', 1)
press_with_sleep('f11', 1)

## TODO: rm ~/.mozilla/firefox/*release*/*.sqlite to remove history