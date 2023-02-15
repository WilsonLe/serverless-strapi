FROM amazon/aws-lambda-nodejs:16
WORKDIR /var/task
RUN npm i python3
COPY dist/src /var/task/src
COPY dist/build /var/task/build
COPY dist/config /var/task/config
COPY database /var/task/database
COPY public /var/task/public
COPY package*.json /var/task
COPY favicon* /var/task
COPY .env /var/task
RUN npm install
RUN npm install --platform=linux --arch=x64 sharp
RUN chmod -R 755 /var/task
CMD [ "/var/task/src/app.strapiHandler" ]
