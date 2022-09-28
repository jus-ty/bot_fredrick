from headless_chrome import create_driver
from selenium import webdriver 
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import time
from datetime import datetime, date, timedelta
import configparser
import os
import boto3


def get_ssm_parameters(env):
    """
    Returns parameters from AWS Systems Manager > Parameter Store
    """

    client = boto3.client('ssm')
    all_parameters = {}

    response = client.get_parameters(                       # Ref 1: https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ssm.html#SSM.Client.get_parameters. Ref 2: https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-parameter-store.html
        Names=[
            'bot_fredrick_email',
            'bot_fredrick_pass',
            f'fb_group_chat_thread_id_{env}',
        ],
        WithDecryption=True
    )
    
    for parameter in response['Parameters']:
        all_parameters[parameter['Name']] = parameter['Value']
    
    return all_parameters


def badminton_time(day, twenty_four_hr_time):
    """
    Calculates next day based on input and converts the 24 hour time to 12 hour time to be clear
    """

    today = date.today()                                                                # Ref: https://stackoverflow.com/questions/4909577/python-django-why-am-i-getting-this-error-attributeerror-method-descriptor
    today_formatted = today.strftime("%U %Y")                                           # Reason for this random %U %Y, datetime is not picking up a date correctly when only specifying the day of the week. Ref: https://stackoverflow.com/questions/66326630/python-strptime-ignoring-a

    # calculate the date of the next 'day' specified
    weekday_as_int = datetime.strptime(day + today_formatted, "%A%U %Y")
    weekday_as_int_converted = weekday_as_int.strftime("%u")                            # %u: Monday = 1, Sunday = 7, Ref: https://docs.python.org/3/library/datetime.html
    date_of_next_day = today + timedelta( ((int(weekday_as_int_converted) - 1) - today.weekday()) % 7 )                             # Ref: https://stackoverflow.com/questions/8801084/how-to-calculate-next-friday, Ref 2: https://stackoverflow.com/questions/12906402/type-object-datetime-datetime-has-no-attribute-datetime
    date_of_next_day_formatted = date_of_next_day.strftime("%a %d/%m/%Y")
    
    # re-formats 'twenty_four_hr_time' to 12 hour time
    format_time = datetime.strptime(twenty_four_hr_time, "%H:%M")                       # Ref: https://stackoverflow.com/questions/13855111/how-can-i-convert-24-hour-time-to-12-hour-time
    twelve_hour_time = format_time.strftime("%I:%M %p")

    return date_of_next_day_formatted, twelve_hour_time

def write_messenger_message(driver, text):
    """
    Sends 'text' to the Messenger chat
    """

    messengerChatboxClass = "pbevjfx6.icdlwmnq.om3e55n1.l4e6dv8b.cgu29s5g.effxes4x.lgak1ieh.aeinzg81.mm05nxu8.notranslate"
    driver.find_element(By.CLASS_NAME, messengerChatboxClass).send_keys(text, Keys.ENTER) 

    time.sleep(2)


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
    TODO: remove 'option1' and 'option2', introduce array of options with dynamic detection of whatever number of options typed in
    """

    
    # Selenium locating elements. Ref: https://selenium-python.readthedocs.io/locating-elements.html
    # Ref: https://stackoverflow.com/questions/55980282/how-to-find-and-click-on-a-button-element-that-contains-multiple-classes
    ## NOTE: THIS IS A BIT FUCKY - dono why I need to get the url again otherwise this part don't work. adding a longer sleep seems to help, my guess is coz the container isn't as powerful as our personal  consider adding explicit wait, REF: https://stackoverflow.com/questions/69834929/how-to-get-find-elements-by-class-name-to-work-in-python-selenium
    driver.get("https://www.facebook.com/messages/t/5024734647638392")
    time.sleep(10)
    ## END OF FUCKY - NESS
    openMoreActionsClass = 'qi72231t.o9w3sbdw.nu7423ey.tav9wjvu.flwp5yud.tghlliq5.gkg15gwv.s9ok87oh.s9ljgwtm.lxqftegz.bf1zulr9.frfouenu.bonavkto.djs4p424.r7bn319e.bdao358l.fsf7x5fv.tgm57n0e.jez8cy9q.s5oniofx.dnr7xe2t.aeinzg81.om3e55n1.cr00lzj9.rn8ck1ys.s3jn8y49.g4tp4svg.o9erhkwx.dzqi5evh.hupbnkgi.hvb2xoa8.fxk3tzhb.jl2a5g8c.f14ij5to.l3ldwz01.icdlwmnq.d2hqwtrz.fzd7ma4j.o9wcebwi.lcfup58g.i0rxk2l3.laatuukc.b7mnygb8.iec8yc8l'
    driver.find_element(By.CLASS_NAME, openMoreActionsClass).click()                            # Selenium version 4.3.0+ new find_element function. Ref: https://ittutoria.net/attributeerror-webdriver-object-has-no-attribute-find_element_by_css_selector-how-to-solve-this-error%EF%BF%BC/
    time.sleep(5)
    driver.find_element(By.XPATH, "//span[contains(text(), 'Create a poll')]").click()          # Ref: https://stackoverflow.com/questions/57310634/how-to-click-on-before-after-cc-tag-in-selenium-webdriver-with-python
    time.sleep(1)

    # Alternative if do not want to identify using askAQuestionPollClass. Ref: https://stackoverflow.com/questions/32886927/send-keys-without-specifying-element-in-python-selenium-webdriver, Ref 2: https://stackoverflow.com/questions/19268617/sendkeys-in-selenium-web-driver
    askAQuestionPollClass = "qi72231t.bdao358l.s3jn8y49.k14qyeqv.mz1h5j5e.icdlwmnq.hsphh064.b6ax4al1.pkdwr69g.sc980dfb.kq3l28k4.rc95jfaf.f52gun2r.c0v9jzqx.k1z55t6l.tpi2lg9u.rj0o91l8.p9ctufpz.k0kqjr44.pbevjfx6"
    driver.find_element(By.CLASS_NAME, askAQuestionPollClass).send_keys(f'{pollTitle}', Keys.TAB, f'{option1}', Keys.TAB, f'{option2}', Keys.TAB, Keys.TAB, Keys.ENTER)
    time.sleep(2)

def finish_session(driver):
    """
    Complete the session
    """
    driver.quit()                       # All windows related to driver instance will quit. Ref: https://www.geeksforgeeks.org/how-to-use-close-and-quit-method-in-selenium-python/

def lambda_handler(event, context):
    """
    Functionality of the script
    """

    """
    #Use following for no AWS connection:
    #config = configparser.ConfigParser()                                # Ref: https://zetcode.com/python/configparser/
    #config.read('poll-automation/configurations/credentials.ini')
    """
    environment = 'dev'                 # TODO: have this and the below initialization of credentials in a function and be called inside 'main' function
    all_ssm_parameters = get_ssm_parameters(environment)

    THREAD_ID = all_ssm_parameters[f'fb_group_chat_thread_id_{environment}']                                 # the group chat ID (found in the URL of the group chat Messenger). Use following for no AWS connection: config['messenger']['devtesting_groupchat_id']
    EMAIL = all_ssm_parameters['bot_fredrick_email']                                   # TODO: encrypt/mask text. Use following for no AWS connection: config['credentials']['email'] 
    PASSWORD = all_ssm_parameters['bot_fredrick_pass']                                # TODO: encrypt/mask text. Use following for no AWS connection: config['credentials']['password']

    # Incognito isn't an option with the docker image used.. as long as we don't run this more than once every 2 hours, the cache will reset (on the container and thus, on chrome as well), otherwise need to explicitly force the cache to reset by updating the lambda REF: https://stackoverflow.com/questions/50866472/restarting-aws-lambda-function-to-clear-cache
    options = [
        "--headless",
        "--single-process",
        "--disable-dev-shm-usage",
        "--disable-gpu",
        "--no-sandbox"
    ]
    driver = create_driver(options)

    badminton_time_scheduled = badminton_time("Thursday", "19:00")
    badminton_time_formatted = str(badminton_time_scheduled[0]) + ', ' + str(badminton_time_scheduled[1])
    poll_title = '[JW] Badminton, ' + badminton_time_formatted + '?'

    open_browser(driver, f'https://www.facebook.com/messages/t/{THREAD_ID}/', 'chrome')
    login_facebook(driver, f'{EMAIL}', f'{PASSWORD}')
    create_group_messenger_poll(driver, poll_title, 'Yes', 'No')
    write_messenger_message(driver, f'Please vote in poll above for badminton attendance on {badminton_time_formatted}')
    finish_session(driver)