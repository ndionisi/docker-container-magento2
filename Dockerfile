FROM debian:jessie

ENV MAGENTO_VERSION 2.1
ENV MAGENTO_SAMPLE_DATA_VERSION 2.1.0
ENV MAGENTO_REPOSITORY_URL https://github.com/magento/magento2.git
ENV MAGENTO_SAMPLE_DATA_REPOSITORY_URL https://github.com/magento/magento2-sample-data
ENV MAGENTO_DOCROOT_PATH magento2

# Install required packages with apt-get
RUN apt-get update && apt-get install -y \
    curl \
    git \
    links \
    php5 \
    php5-curl \
    php5-gd \
    php5-intl \
    php5-mcrypt \
    php5-mysql \
    php5-xsl \
  && rm -rf /var/lib/apt/lists/*

# Install composer
WORKDIR /tmp

RUN curl -sS https://getcomposer.org/installer | php \
  && mv composer.phar /usr/local/bin/composer

# Install Magento 2
WORKDIR /var/www/html

RUN git clone "$MAGENTO_REPOSITORY_URL" "$MAGENTO_DOCROOT_PATH" \
  && cd "$MAGENTO_DOCROOT_PATH" \
  && git checkout "$MAGENTO_VERSION" \
  && rm -r .git \
  && composer install \
  && ln -s "/var/www/html/$MAGENTO_DOCROOT_PATH/bin/magento" "/usr/local/bin"

WORKDIR /opt

# Install Magento 2 Sample data
RUN git clone "$MAGENTO_SAMPLE_DATA_REPOSITORY_URL" magento2-sample-data \
  && cd magento2-sample-data \
  && git checkout "$MAGENTO_SAMPLE_DATA_VERSION" \
  && rm -r .git \
  && php -f /opt/magento2-sample-data/dev/tools/build-sample-data.php -- --ce-source="/var/www/html/$MAGENTO_DOCROOT_PATH"

RUN chown -R www-data:www-data "/var/www/html/$MAGENTO_DOCROOT_PATH" "/opt/magento2-sample-data"

# Configure Apache 2
RUN sed -i "s/;always_populate_raw_post_data/always_populate_raw_post_data/" /etc/php5/apache2/php.ini \
  && a2enmod rewrite \
  && echo '<Directory "/var/www/html">\n   AllowOverride  All\n   Order allow,deny\n   Allow from all\n</Directory>' >> /etc/apache2/sites-available/000-default.conf \
  && echo 'ServerName localhost' >> /etc/apache2/apache2.conf

COPY resources/bootstrap-magento /usr/local/bin/
COPY resources/checkDatabaseState.php /opt

WORKDIR "/var/www/html/$MAGENTO_APACHE_PATH"

EXPOSE 80

CMD ["bootstrap-magento"]