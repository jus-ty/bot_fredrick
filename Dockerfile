FROM public.ecr.aws/lambda/python:3.7

# Copy function code
COPY terraform/modules/compute/src/create_poll/main.py ${LAMBDA_TASK_ROOT}


# Install requirements
COPY requirements.txt  .
RUN  pip3 install -r requirements.txt --target "${LAMBDA_TASK_ROOT}"

# Install Google Chrome
#RUN apt-get update
RUN yum install -y wget
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
RUN yum remove -y ImageMagick.x86_64

# Update YUM database
RUN yum makecache

RUN yum install -y libwayland-client
RUN yum localinstall -y google-chrome-stable_current_x86_64.rpm

# Download the chrome driver
RUN version=$(curl -s "https://chromedriver.storage.googleapis.com/LATEST_RELEASE")
RUN wget -qP /tmp/ "https://chromedriver.storage.googleapis.com/${version}/chromedriver_linux64.zip"
RUN sudo unzip -o /tmp/chromedriver_linux64.zip -d /usr/bin

# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD [ "main.lambda_handler" ]