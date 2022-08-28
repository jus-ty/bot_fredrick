from selenium import webdriver 
from selenium.webdriver.common.by import By

import pyautogui
import time


THREAD_ID = '5024734647638392'
EMAIL = 'andyjustincloud@gmail.com'
PASSWORD = 'hdw&lwLzx251D'
DRIVERPATH = "/Users/andrewguo/Documents/Learning/GitHub/bot-fredrick/drivers/chromedriver"             # need to download drivers (in drivers directory) Ref: https://selenium-python.readthedocs.io/installation.html#drivers

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


# Selenium always opens a fresh private browser. Ref: https://stackoverflow.com/questions/27630190/python-selenium-incognito-private-mode
#driver = webdriver.Chrome(PATH)
#driver.get('https://www.facebook.com/messages/t/5024734647638392/')

try:
    options = webdriver.ChromeOptions()
    options.add_argument("--incognito")
    options.add_experimental_option("detach", True)     # https://stackoverflow.com/questions/51865300/python-selenium-keep-browser-open
    driver = webdriver.Chrome(DRIVERPATH, options=options)

except Exception as e:
    print(e)


def open_browser(driver, url, browserType = "chrome"):    
    """
    Based off specified web browser, open the web browser to specified url
    """

    if browserType == "chrome":
        try:
            driver.get(url)
            time.sleep(2)

        except Exception as e:
            print (e, 'Facebook Messenger')


def login_facebook(driver, EMAIL, PASSWORD):
    """
    Log into facebook messenger
    """

    #browser.find_element(By.NAME, 'username').send_keys('MYEMAIL', Keys.TAB, 'MYPW', Keys.ENTER)

    write_with_sleep(f'{EMAIL}', 1) # TODO: replace with AWS SSM parameter value
    press_with_sleep('tab', 1)
    write_with_sleep(f'{PASSWORD}', 1) # TODO: replace with AWS SSM parameter value
    press_with_sleep('tab', 1)
    press_with_sleep('enter', 10)
    time.sleep(2)
    
    
def create_group_messenger_poll(driver, pollTitle, option1, option2):
    """
    Create the poll
    """

    # https://stackoverflow.com/questions/55980282/how-to-find-and-click-on-a-button-element-that-contains-multiple-classes
    openMoreActionsClass = "qi72231t.o9w3sbdw.nu7423ey.tav9wjvu.flwp5yud.tghlliq5.gkg15gwv.s9ok87oh.s9ljgwtm.lxqftegz.bf1zulr9.frfouenu.bonavkto.djs4p424.r7bn319e.bdao358l.fsf7x5fv.tgm57n0e.jez8cy9q.s5oniofx.dnr7xe2t.aeinzg81.om3e55n1.cr00lzj9.rn8ck1ys.s3jn8y49.g4tp4svg.o9erhkwx.dzqi5evh.hupbnkgi.hvb2xoa8.fxk3tzhb.jl2a5g8c.f14ij5to.l3ldwz01.icdlwmnq.d2hqwtrz.fzd7ma4j.o9wcebwi.lcfup58g.i0rxk2l3.laatuukc.b7mnygb8.iec8yc8l"
    driver.find_element(By.CLASS_NAME, openMoreActionsClass).click()    
    time.sleep(1)
    driver.find_element(By.XPATH, "//span[contains(text(), 'Create a poll')]").click()          # https://stackoverflow.com/questions/57310634/how-to-click-on-before-after-cc-tag-in-selenium-webdriver-with-python


    write_with_sleep(f'{pollTitle}', 1)
    press_with_sleep('tab', 1)
    write_with_sleep(f'{option1}', 1)
    press_with_sleep('tab', 1)
    write_with_sleep(f'{option2}', 1)
    press_with_sleep('tab', 1)
    press_with_sleep('tab', 1)
    press_with_sleep('enter', 1)


open_browser(driver, f'https://www.facebook.com/messages/t/{THREAD_ID}/')
login_facebook(driver, f'{EMAIL}', f'{PASSWORD}')
create_group_messenger_poll(driver, '[AG] testing', 'option1', 'option2')
