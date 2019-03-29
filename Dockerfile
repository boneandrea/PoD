FROM mcr.microsoft.com/azure-functions/node:2.0

ENV AzureWebJobsScriptRoot=/home/site/wwwroot
COPY . /home/site/wwwroot

RUN apt-get install gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget unzip -y

#MSのDockerイメージは日本語フォント入っていないので文字化けするのでNotoフォントを入れる

RUN mkdir /tmp/noto
WORKDIR /tmp/noto
RUN wget https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip
RUN unzip NotoSansCJKjp-hinted.zip && \
mkdir -p /usr/share/fonts/noto && \
cp *.otf /usr/share/fonts/noto && \
chmod 644 -R /usr/share/fonts/noto/
RUN fc-cache -fv && rm -rf /tmp/noto

# puppeteer
WORKDIR /home/site/wwwroot/MyHttpTrigger
RUN npm install
