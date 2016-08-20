What is this?
=============
This a a Docker container running a simple Magento 2 instance in an Apache 2 web server. This container enables to have a quickly ready Magento 2 instance with very few configuration. It is *not* production ready, an dshould be use only to have a tour of Magento 2. 

Requirements
============
The container needs to access a MySQL Database. The `docker-compose.yml` file shows an example of linking the container with a MySQL container.
 
Running the container
=====================
An example of how to run the container is shown in the `docker-compose.yml` file.
At the first startup, the container installs Magento. This operation can take a while and is only required the first time.

Environment Variables
---------------------
The container using Magento CLI to install Magento, with the command `magento setup:install`.
Many environment variables can be set to customize the installation.
Magento 2 documentation describes the parameters accepted by `magento setup:install` command: http://devdocs.magento.com/guides/v2.1/install-gde/install/cli/install-cli-install.html#instgde-install-cli-magento.
Each environment variable corresponds to one of the option accepted by `magento setup:install` command.

The following variables can be defined to customize the installation:


| Environment Variable | Magento CLI Option | Default Value |
|----------------------|--------------------|---------------|
|`MAGENTO_ADMIN_FIRSTNAME`|`--admin-firstname`|Admin|
|`MAGENTO_ADMIN_LASTNAME`|`--admin-lastname`|User|
|`MAGENTO_ADMIN_EMAIL`|`--admin-email`|admin@example.com|
|`MAGENTO_ADMIN_USER`|`--admin-user`|admin|
|`MAGENTO_ADMIN_PASSWORD`|`--admin-password`|magento2|
|`MAGENTO_BASE_URL`|`--base-url`|-|
|`MAGENTO_BACKEND_FRONTNAME`|`--backend-frontname`|admin|
|`MAGENTO_DB_HOST`|`--db-host`|msqyl|
|`MAGENTO_DB_NAME`|`--db-name`|magento2|
|`MAGENTO_DB_USER`|`--db-user`|magento2|
|`MAGENTO_DB_PASSWORD`|`--db-password`|magento2|
|`MAGENTO_DB_PREFIX`|`--db-prefix`|-|
|`MAGENTO_LANGUAGE`|`--language`|-|
|`MAGENTO_CURRENCY`|`--currency`|-|
|`MAGENTO_TIMEZONE`|`--timezone`|-|
|`MAGENTO_USE_REWRITES`|`--use-rewrites`|-|
|`MAGENTO_USE_SECURE`|`--use-secure`|-|
|`MAGENTO_BASE_URL_SECURE`|`--base-url-secure`|-|
|`MAGENTO_USE_SECURE_ADMIN`|`--use-secure-admin`|-|
|`MAGENTO_ADMIN_USE_SECURITY_KEY`|`--admin-use-security-key`|-|
|`MAGENTO_SESSION_SAVE`|`--session-save`|-|
|`MAGENTO_KEY`|`--key`|-|
|`MAGENTO_CLEANUP_DATABASE`|`--cleanup-database`|-|
|`MAGENTO_DB_INIT_STATEMENTS`|`--db-init-statements`|-|
|`MAGENTO_SALES_ORDER_INCREMENT_PREFIX`|`--sales-order-increment-prefix`|-|