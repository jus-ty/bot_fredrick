from selenium import webdriver 
from selenium.webdriver.common.by import By

import pyautogui
import time

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


# need to download drivers (in drivers directory) Ref: https://selenium-python.readthedocs.io/installation.html#drivers



PATH = "/Users/andrewguo/Documents/Learning/GitHub/bot-fredrick/drivers/chromedriver"

# Selenium always opens a fresh private browser. Ref: https://stackoverflow.com/questions/27630190/python-selenium-incognito-private-mode
#driver = webdriver.Chrome(PATH)
#driver.get('https://www.facebook.com/messages/t/5024734647638392/')



#"https://www.realestate.com.au/buy/"
#aria-label="Apply filters and search"
#aria-label="Open more actions"


def open_facebook_messenger(PATH):    
    try:
        # Connect
        options = webdriver.ChromeOptions()
        options.add_argument("--incognito")
        #chrome_options = Options()
        options.add_experimental_option("detach", True)     # https://stackoverflow.com/questions/51865300/python-selenium-keep-browser-open
        driver = webdriver.Chrome(PATH, options=options)
        driver.get("https://www.facebook.com/messages/t/5024734647638392/")
        #driver.get("https://www.domain.com.au/")
        #driver.get("https://www.realestate.com.au/buy/")
        time.sleep(2)

        nextstep(driver)    

        #browser.find_element(By.NAME, 'username').send_keys('MYEMAIL', Keys.TAB, 'MYPW', Keys.ENTER)
    except Exception as e:
        print (e, 'Facebook Messenger')



def nextstep(driver):


        write_with_sleep('andyjustincloud@gmail.com', 1) # TODO: replace with AWS SSM parameter value
        press_with_sleep('tab', 1)
        write_with_sleep('hdw&lwLzx251D', 1) # TODO: replace with AWS SSM parameter value
        press_with_sleep('tab', 1)
        press_with_sleep('enter', 10)
        time.sleep(2)
        
        
        #driver.find_element(By.NAME, "Rural").click()
        #driver.find_element(By.XPATH, "//button[contains(text(), 'Rural')]").click()
        

        #driver.find_element(By.CLASS_NAME, "css-oih30v").click()      # works for domain (search button)
        #driver.find_element(By.CLASS_NAME, "ButtonBase-sc-18zziu4-0.ksPwGW.SubmitSearchButton__StyledButton-sc-7ign35-0.duRQpz").click()      # works for REA (search button)
        
        #driver.find_elements_by_css_selector("[aria-label=Open more actions]").click()
        #driver.find_element_by_xpath("//button[@aria-label=Open more actions']").click() 
        #driver.find_element_by_xpath("//div[@aria-label='Open more actions']/div[@class='qi72231t']").click()
        #driver.find_element('xpath', "//div[@aria-label='Open more actions']/div[@class='qi72231t']").click()
        #driver.find_element(By.CSS_SELECTOR, '[aria-label=Open more actions]').click()
        
        # https://stackoverflow.com/questions/55980282/how-to-find-and-click-on-a-button-element-that-contains-multiple-classes
        openMoreActionsClass = "qi72231t.o9w3sbdw.nu7423ey.tav9wjvu.flwp5yud.tghlliq5.gkg15gwv.s9ok87oh.s9ljgwtm.lxqftegz.bf1zulr9.frfouenu.bonavkto.djs4p424.r7bn319e.bdao358l.fsf7x5fv.tgm57n0e.jez8cy9q.s5oniofx.dnr7xe2t.aeinzg81.om3e55n1.cr00lzj9.rn8ck1ys.s3jn8y49.g4tp4svg.o9erhkwx.dzqi5evh.hupbnkgi.hvb2xoa8.fxk3tzhb.jl2a5g8c.f14ij5to.l3ldwz01.icdlwmnq.d2hqwtrz.fzd7ma4j.o9wcebwi.lcfup58g.i0rxk2l3.laatuukc.b7mnygb8.iec8yc8l"
        driver.find_element(By.CLASS_NAME, openMoreActionsClass).click()    
        #driver.find_element(By.XPATH, "//div[contains(text(), 'Open more actions')]").click()      # does not work
        time.sleep(1)
        driver.find_element(By.XPATH, "//span[contains(text(), 'Create a poll')]").click()          # https://stackoverflow.com/questions/57310634/how-to-click-on-before-after-cc-tag-in-selenium-webdriver-with-python
        #driver.find_element(By.CLASS_NAME, pollClass).click()  
        #xpath = "/html/body/div[1]/div/div[1]/div/div[3]/div/div/div/div[1]/div[1]/div[2]/div/div/div/div/div/div/div[2]/div/div/div[2]/div/span[1]/div/svg/g/path"
        #pollxpath = "/html/body/div[1]/div/div[1]/div/div[3]/div/div/div/div[2]/div/div/div[1]/div[1]/div/div/div[1]/div/div[1]/div/div[2]/div/div/div/div[1]/div/div[2]/div/div/div/div/span"
        #driver.find_element(By.XPATH, xpath).click()

        write_with_sleep('[AG] testing', 1)
        press_with_sleep('tab', 1)
        write_with_sleep('option1', 1)
        press_with_sleep('tab', 1)
        write_with_sleep('option2', 1)
        press_with_sleep('tab', 1)
        press_with_sleep('tab', 1)
        press_with_sleep('enter', 1)
        

open_facebook_messenger(PATH)
