FROM tensorflow/tensorflow

ENV TZ=Asia/Shanghai

COPY requirement.txt /requirement.txt
#COPY pip.conf /root/.pip/pip.conf 				for mirror in China
#COPY source.list /etc/apt/sources.list			for mirror in China
# COPY jupyter_notebook_config.py /root/.jupyter/
USER root

RUN apt-get update \
  && apt-get install -y wget \
  && cd / \
  && wget https://downloads.sourceforge.net/project/ta-lib/ta-lib/0.4.0/ta-lib-0.4.0-src.tar.gz \
	&& tar xvf ta-lib-0.4.0-src.tar.gz \
	&& cd ta-lib \
	&& ./configure --prefix=/usr \
	&& make \
	&& make install \
	&& pip install -r /requirement.txt \
	&& cd .. \
	&& rm -rf ta-lib \
	&& rm ta-lib-0.4.0-src.tar.gz \
	&& apt-get update \
	&& curl https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o /chrome.deb \
	&& dpkg -i /chrome.deb || apt-get install -yf \
	&& rm /chrome.deb \
	&& curl https://chromedriver.storage.googleapis.com/2.40/chromedriver_linux64.zip -o /usr/local/bin/chromedriver.zip \
	&& apt-get install unzip \
	&& unzip /usr/local/bin/chromedriver.zip \
	&& mv /chromedriver /usr/local/bin/ \
	&& rm /usr/local/bin/chromedriver.zip \
	&& chmod +x /usr/local/bin/chromedriver \
	&& pip install Tushare

EXPOSE 8888
#  apt-get update \
#    && apt-get install -y --no-install-recommends ffmpeg \
#    && apt-get clean \
#    && rm -rf /var/lib/apt/lists/* \
#    &&
