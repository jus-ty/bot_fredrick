from selenium import webdriver 
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys

import time
from datetime import datetime, date, timedelta


THREAD_ID = '5024734647638392'                  # the group chat ID (found in the URL of the group chat Messenger)
EMAIL = 'andyjustincloud@gmail.com'             # TODO: replace with AWS SSM parameter value
PASSWORD = 'hdw&lwLzx251D'                      # TODO: replace with AWS SSM parameter value
DRIVERPATH = "/Users/andrewguo/Documents/Learning/GitHub/bot-fredrick/drivers/chromedriver"             # need to download drivers (in drivers directory) Ref: https://selenium-python.readthedocs.io/installation.html#drivers



try:
    options = webdriver.ChromeOptions()
    options.add_argument("--incognito")                 # Optional. Selenium always opens a fresh private browser. Ref: https://stackoverflow.com/questions/27630190/python-selenium-incognito-private-mode
    options.add_experimental_option("detach", True)     # https://stackoverflow.com/questions/51865300/python-selenium-keep-browser-open
    driver = webdriver.Chrome(DRIVERPATH, options=options)

except Exception as e:
    print(e)


def badminton_time(day, twenty_four_hr_time):
    """
    Calculates next day based on input and converts the 24 hour time to 12 hour time to be clear
    
    TODO: day input type in eg. Thursday and automatically calculate
    """

    today = date.today()                                                    # Ref: https://stackoverflow.com/questions/4909577/python-django-why-am-i-getting-this-error-attributeerror-method-descriptor
    thursday = today + timedelta( (3-today.weekday()) % 7 )                 # Ref: https://stackoverflow.com/questions/12906402/type-object-datetime-datetime-has-no-attribute-datetime
    thursday_reformat = thursday.strftime("%a %d/%m/%Y")

    format_time = datetime.strptime(twenty_four_hr_time, "%H:%M")                       # Ref: https://stackoverflow.com/questions/13855111/how-can-i-convert-24-hour-time-to-12-hour-time
    twelve_hour_time = format_time.strftime("%I:%M %p")

    return thursday_reformat, twelve_hour_time


def open_browser(driver, url, browserType = "chrome"):    
    """
    Based off specified web browser, open the web browser to specified url
    """

    if browserType == "chrome":
        try:
            driver.get(url)                             #Use for testing, driver.get('https://www.facebook.com/messages/t/5024734647638392/')
            time.sleep(2)

        except Exception as e:
            print (e, 'Facebook Messenger')


def login_facebook(driver, EMAIL, PASSWORD):
    """
    Log into facebook messenger
    """

    driver.find_element(By.NAME, 'email').send_keys(f'{EMAIL}', Keys.TAB, f'{PASSWORD}', Keys.ENTER)                    # HTML, name="email". Ref: https://stackoverflow.com/questions/72455584/use-selenium-to-fill-the-username-and-password-on-this-site
    time.sleep(7)

    
def create_group_messenger_poll(driver, pollTitle, option1, option2):
    """
    Create the poll
    """

    # Selenium locating elements. Ref: https://selenium-python.readthedocs.io/locating-elements.html
    # Ref: https://stackoverflow.com/questions/55980282/how-to-find-and-click-on-a-button-element-that-contains-multiple-classes
    openMoreActionsClass = "qi72231t.o9w3sbdw.nu7423ey.tav9wjvu.flwp5yud.tghlliq5.gkg15gwv.s9ok87oh.s9ljgwtm.lxqftegz.bf1zulr9.frfouenu.bonavkto.djs4p424.r7bn319e.bdao358l.fsf7x5fv.tgm57n0e.jez8cy9q.s5oniofx.dnr7xe2t.aeinzg81.om3e55n1.cr00lzj9.rn8ck1ys.s3jn8y49.g4tp4svg.o9erhkwx.dzqi5evh.hupbnkgi.hvb2xoa8.fxk3tzhb.jl2a5g8c.f14ij5to.l3ldwz01.icdlwmnq.d2hqwtrz.fzd7ma4j.o9wcebwi.lcfup58g.i0rxk2l3.laatuukc.b7mnygb8.iec8yc8l"
    driver.find_element(By.CLASS_NAME, openMoreActionsClass).click()                            # Selenium version 4.3.0+ new find_element function. Ref: https://ittutoria.net/attributeerror-webdriver-object-has-no-attribute-find_element_by_css_selector-how-to-solve-this-error%EF%BF%BC/
    time.sleep(1)
    driver.find_element(By.XPATH, "//span[contains(text(), 'Create a poll')]").click()          # Ref: https://stackoverflow.com/questions/57310634/how-to-click-on-before-after-cc-tag-in-selenium-webdriver-with-python
    time.sleep(1)

    # Alternative if do not want to identify using askAQuestionPollClass. Ref: https://stackoverflow.com/questions/32886927/send-keys-without-specifying-element-in-python-selenium-webdriver, Ref 2: https://stackoverflow.com/questions/19268617/sendkeys-in-selenium-web-driver
    askAQuestionPollClass = "qi72231t.bdao358l.s3jn8y49.k14qyeqv.mz1h5j5e.icdlwmnq.hsphh064.b6ax4al1.pkdwr69g.sc980dfb.kq3l28k4.rc95jfaf.f52gun2r.c0v9jzqx.k1z55t6l.tpi2lg9u.rj0o91l8.p9ctufpz.k0kqjr44.pbevjfx6"
    driver.find_element(By.CLASS_NAME, askAQuestionPollClass).send_keys(f'{pollTitle}', Keys.TAB, f'{option1}', Keys.TAB, f'{option2}', Keys.TAB, Keys.TAB, Keys.ENTER)


badminton_time_scheduled = badminton_time("thurs", "19:00")

open_browser(driver, f'https://www.facebook.com/messages/t/{THREAD_ID}/', 'chrome')
login_facebook(driver, f'{EMAIL}', f'{PASSWORD}')
create_group_messenger_poll(driver, '[AG] Badminton, ' + str(badminton_time_scheduled[0]) + ', ' + str(badminton_time_scheduled[1]) + '?', 'option1', 'option2')

