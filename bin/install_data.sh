#!/usr/bin/env bash

php bin/magento setup:install --backend-frontname="admin" --db-host="mysql" --db-name="test" --db-user="root" --db-password="rootpass" --db-prefix="test" --base-url="http://localhost:82" --language="en_US" --timezone="UTC" --currency="USD" --use-rewrites="1" --use-secure="0" --use-secure-admin="0" --admin-use-security-key="0" --admin-user="admin" --admin-password="admin1234" --admin-email="example@mail.com" --admin-firstname="admin" --admin-lastname="admin"
