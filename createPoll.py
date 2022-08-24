# pylint: disable=missing-module-docstring

import time
import uuid
import pyautogui
import os


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
EMAIL = 'andyjustincloud@gmail.com'
PASSWORD = 'hdw&lwLzx251D'

# DEBUG INFO
RUN_ID = uuid.uuid4()
print(f'RUN_ID: {RUN_ID}')

# Console command to open web browser -- STEPS MAY BE DIFFERENT FOR VM!

def open_browser(browserType, url):
    """
    Based off specified web browser, open the web browser
    """
    
    if browserType == "chrome":
        os.system("open -na \"Google Chrome\" --args --incognito " + url)
        time.sleep(5)               # sleep for 5 seconds to allow web browser to load

    elif browserType == "firefox":
        # Open firefox
        press_with_sleep('winleft', 1)
        write_with_sleep('terminal', 1)
        press_with_sleep('enter', 1)
        write_with_sleep('firefox &', 1)
        press_with_sleep('enter', 3)

        press_with_sleep('f11', 1)         ## full screen (Windows)
        write_with_sleep(f'{url}', 3)
        press_with_sleep('enter', 3)

def login_facebook(EMAIL, PASSWORD):
    """
    Log into facebook messenger
    """

    #press_with_sleep('f11', 1)         ## full screen (Windows)
    #write_with_sleep(f'https://www.facebook.com/messages/t/{THREAD_ID}', 3)
    #press_with_sleep('enter', 3)
    write_with_sleep(f'{EMAIL}', 1) # TODO: replace with AWS SSM parameter value
    press_with_sleep('tab', 1)
    write_with_sleep(f'{PASSWORD}', 1) # TODO: replace with AWS SSM parameter value
    press_with_sleep('tab', 1)
    press_with_sleep('enter', 10)

def create_group_messenger_poll(pollTitle, option1, option2):
    """
    Create the poll
    """
    time.sleep(10)
    write_with_sleep('test1', 1)
    pyautogui.click('image_assets/svgexport-21.png')
    write_with_sleep('test2', 1)
    time.sleep(1)
    pyautogui.click('image_assets/svgexport-31.png')
    time.sleep(1)
    write_with_sleep(f'{pollTitle}', 1)
    press_with_sleep('tab', 1)
    write_with_sleep(f'{option1}', 1)
    press_with_sleep('tab', 1)
    write_with_sleep(f'{option2}', 1)
    press_with_sleep('tab', 1)
    press_with_sleep('tab', 1)
    press_with_sleep('enter', 1)
    press_with_sleep('f11', 1)


open_browser('chrome', f'https://www.facebook.com/messages/t/{THREAD_ID}/')
login_facebook(f'{EMAIL}', f'{PASSWORD}')
create_group_messenger_poll('[AG] testing', 'option1', 'option2')

## TODO: rm ~/.mozilla/firefox/*release*/*.sqlite to remove history