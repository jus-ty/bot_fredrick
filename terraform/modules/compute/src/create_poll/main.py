from headless_chrome import create_driver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import time
from datetime import datetime, date, timedelta
import configparser
import os
import boto3

# When running locally!! uncomment
# config = configparser.ConfigParser()                                # Ref: https://zetcode.com/python/configparser/
# config.read('poll-automation/configurations/credentials.ini')
# current_file_directory = os.path.dirname(os.path.abspath(__file__))

def get_ssm_parameters(env):
    """
    Returns parameters from AWS Systems Manager > Parameter Store
    """

    client = boto3.client('ssm')
    all_parameters = {}

    response = client.get_parameters(                       # Ref 1: https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ssm.html#SSM.Client.get_parameters. Ref 2: https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-parameter-store.html
        Names=[
            f'bot_fredrick_email_{env}',
            f'bot_fredrick_password_{env}',
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

    messengerChatboxClass = "xzsf02u.x1a2a7pz.x1n2onr6.x14wi4xw.x1iyjqo2.x1gh3ibb.xisnujt.xeuugli.x1odjw0f.notranslate"
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

    
def create_group_messenger_poll(driver, pollTitle, thread_id, option1, option2):
    """
    Create the poll
    TODO: remove 'option1' and 'option2', introduce array of options with dynamic detection of whatever number of options typed in
    """

    
    # Selenium locating elements. Ref: https://selenium-python.readthedocs.io/locating-elements.html
    # Ref: https://stackoverflow.com/questions/55980282/how-to-find-and-click-on-a-button-element-that-contains-multiple-classes
    ## NOTE: THIS IS A BIT FUCKY - dono why I need to get the url again otherwise this part don't work. adding a longer sleep seems to help, my guess is coz the container isn't as powerful as our personal  consider adding explicit wait, REF: https://stackoverflow.com/questions/69834929/how-to-get-find-elements-by-class-name-to-work-in-python-selenium
    driver.get(f"https://www.facebook.com/messages/t/{thread_id}")
    time.sleep(10)
    ## END OF FUCKY - NESS
    openMoreActionsClass = "x1i10hfl.x1qjc9v5.xjbqb8w.xjqpnuy.xa49m3k.xqeqjp1.x2hbi6w.x13fuv20.xu3j5b3.x1q0q8m5.x26u7qi.x972fbf.xcfux6l.x1qhh985.xm0m39n.x9f619.x1ypdohk.xdl72j9.x2lah0s.xe8uvvx.x2lwn1j.xeuugli.x1n2onr6.x16tdsg8.x1hl2dhg.xggy1nq.x1ja2u2z.x1t137rt.x1o1ewxj.x3x9cwd.x1e5q0jg.x13rtm0m.x3nfvp2.x1q0g3np.x87ps6o.x1lku1pv.x1a2a7pz.x1iorvi4.x150jy0e.xjkvuk6.x1e558r4.x1gslohp.x12nagc.xw3qccf.xsgj6o6"
    driver.find_element(By.CLASS_NAME, openMoreActionsClass).click()                            # Selenium version 4.3.0+ new find_element function. Ref: https://ittutoria.net/attributeerror-webdriver-object-has-no-attribute-find_element_by_css_selector-how-to-solve-this-error%EF%BF%BC/
    time.sleep(5)
    driver.find_element(By.XPATH, "//span[contains(text(), 'Create a poll')]").click()          # Ref: https://stackoverflow.com/questions/57310634/how-to-click-on-before-after-cc-tag-in-selenium-webdriver-with-python
    time.sleep(1)

    # Alternative if do not want to identify using askAQuestionPollClass. Ref: https://stackoverflow.com/questions/32886927/send-keys-without-specifying-element-in-python-selenium-webdriver, Ref 2: https://stackoverflow.com/questions/19268617/sendkeys-in-selenium-web-driver
    askAQuestionPollClass = "x1i10hfl.x9f619.xggy1nq.x1s07b3s.x1kdt53j.x1a2a7pz.x2b8uid.x1lliihq.x1ejq31n.xd10rxx.x1sy0etr.x17r0tee.xjv05ge.x1hq5gj4.x6prxxf.xk50ysn.xktsk01.x1d52u69.x1jx94hy.xzsf02u"
    driver.find_element(By.CLASS_NAME, askAQuestionPollClass).send_keys(f'{pollTitle}', Keys.TAB, f'{option1}', Keys.TAB, f'{option2}', Keys.TAB, Keys.TAB, Keys.ENTER)
    time.sleep(2)

def log_out_messenger(driver):
    """
    Log out of Messenger
    """

    yourProfileClass = "x1i10hfl.x1qjc9v5.xjbqb8w.xjqpnuy.xa49m3k.xqeqjp1.x2hbi6w.x13fuv20.xu3j5b3.x1q0q8m5.x26u7qi.x972fbf.xcfux6l.x1qhh985.xm0m39n.x9f619.x1ypdohk.xdl72j9.x2lah0s.xe8uvvx.xdj266r.x11i5rnm.xat24cr.x1mh8g0r.x2lwn1j.xeuugli.xexx8yu.x4uap5.x18d9i69.xkhd6sd.x1n2onr6.x16tdsg8.x1hl2dhg.xggy1nq.x1ja2u2z.x1t137rt.x1o1ewxj.x3x9cwd.x1e5q0jg.x13rtm0m.x1q0g3np.x87ps6o.x1lku1pv.x1a2a7pz.xzsf02u.x1rg5ohu"
    driver.find_element(By.CLASS_NAME, yourProfileClass).click()
    time.sleep(1)
    driver.find_element(By.XPATH, "//span[contains(text(), 'Log Out')]").click()          # Ref: https://stackoverflow.com/questions/57310634/how-to-click-on-before-after-cc-tag-in-selenium-webdriver-with-python
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
    
    execution_method = "lambda"                  # Options are "local" or "lambda". "local" will resort to opening the browser useful for de-bugging on-screen
    
    if execution_method == "local":
        environment = 'dev'

    elif execution_method == "lambda":
        environment = os.environ['env']
    
    """
    #Use following for no AWS connection:
    #config = configparser.ConfigParser()                                # Ref: https://zetcode.com/python/configparser/
    #config.read('poll-automation/configurations/credentials.ini')
    """

    # TODO: put below into a separate function
    all_ssm_parameters = get_ssm_parameters(environment)

    THREAD_ID = all_ssm_parameters[f'fb_group_chat_thread_id_{environment}']                                 # the group chat ID (found in the URL of the group chat Messenger). Use following for no AWS connection: config['messenger']['devtesting_groupchat_id']
    EMAIL = all_ssm_parameters[f'bot_fredrick_email_{environment}']                                   # TODO: encrypt/mask text. Use following for no AWS connection: config['credentials']['email'] 
    PASSWORD = all_ssm_parameters[f'bot_fredrick_password_{environment}']                                # TODO: encrypt/mask text. Use following for no AWS connection: config['credentials']['password']

    if execution_method == "local":
        #current_file_directory = os.path.dirname(os.path.abspath(__file__))
        #DRIVERPATH = os.path.join(os.path.dirname(current_file_directory), 'drivers/chromedriver')             # need to download drivers (in drivers directory) Ref: https://selenium-python.readthedocs.io/installation.html#drivers. Moving down a directory from the current directory of the file. Ref: https://stackoverflow.com/questions/25701809/how-to-move-down-to-a-parent-directory-in-python
        DRIVERPATH = '/Users/andrewguo/Documents/Learning/GitHub/bot-fredrick/poll-automation/local/chromedriver'           # TODO: change to dynamic path
        
        from selenium import webdriver 
        from selenium.webdriver.chrome.service import Service
        try:
            options = webdriver.ChromeOptions()
            options.add_argument("--incognito")                     # Optional. Selenium always opens a fresh private browser. Ref: https://stackoverflow.com/questions/27630190/python-selenium-incognito-private-mode
            #options.add_argument("--headless")                      # Comment this for testing. Headless mode will hide the Chrome interface. Ref: https://stackoverflow.com/questions/53657215/running-selenium-with-headless-chrome-webdriver
            options.add_experimental_option("detach", True)         # https://stackoverflow.com/questions/51865300/python-selenium-keep-browser-open
            driver = webdriver.Chrome(service=Service(DRIVERPATH), options=options)             # Ref: https://itsmycode.com/executable-path-has-been-deprecated/

        except Exception as e:
            print(e)

    elif execution_method == "lambda":
        # Incognito isn't an option with the lambda layer used.. as long as we don't run this more than once every 2 hours, the cache will reset (on the container and thus, on chrome as well), otherwise need to explicitly force the cache to reset by updating the lambda REF: https://stackoverflow.com/questions/50866472/restarting-aws-lambda-function-to-clear-cache
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
    poll_title = 'Badminton, ' + badminton_time_formatted + '?'

    open_browser(driver, f'https://www.facebook.com/messages/t/{THREAD_ID}/', 'chrome')
    login_facebook(driver, f'{EMAIL}', f'{PASSWORD}')
    create_group_messenger_poll(driver, poll_title, THREAD_ID, 'Yes', 'No')
    write_messenger_message(driver, f'Please vote in poll above for badminton attendance on {badminton_time_formatted}')
    log_out_messenger(driver)
    finish_session(driver)

#lambda_handler("event", "context")                 # Uncomment for execution_method = "local" execution/testing