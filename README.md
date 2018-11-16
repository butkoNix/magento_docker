## Установка докера:
* [Docker](https://docs.docker.com/linux/step_one/)
* [Docker Compose](https://docs.docker.com/compose/install/)

sudo apt update
sudo apt install docker
sudo apt install docker-compose

* work with docker without super user access
sudo usermod -aG docker $USER
* relogin user
sudo reboot


## Установка
1. Настроить доступ для файлов (для текущего пользователя и 'www-data' группы)
```bash
sudo ./bin/setup_permissions.sh
```
Если возникла ошибка: 'sudo: ./bin/setup_permissions.sh: command not found', запустить:
```bash
sudo chmod 777 ./bin/setup_permissions.sh
```

2. Настроить контейнеры с префиксом 'test':
```bash
./bin/setup_containers.sh
```

4. Установить проект:
Magento access keys: https://marketplace.magento.com/customer/accessKeys (завести аккаунт, если его нет)
Public Key - это username, Private Key - это password
```bash
./bin/cli.sh composer install
```

5. После установки модулей и остальных файлов/директорий - снова настроить права доступа к файлам проекта:
```bash
sudo ./bin/setup_permissions.sh
```

6. Войти в режим командной строки из контейнера PHP:
```bash
docker exec -it test_php_1 /bin/bash
```

7. Команда для установки Magento 2 с помощью командной строки. Выполняется из контейнера php - test_php_1 (шаг 7)
```bash
./bin/install_data.sh
```

8. После установки проекта - снова настроить права доступа к файлам проекта:
```bash
sudo ./bin/setup_permissions.sh
```

9. Открываем в браузере страницу по адресу: localhost:81, работаем. Доступ к админке: localhost:81/admin:
login: admin
pass: admin1234

10. Основные манипуляции с контейнерами:
```bash
docker-compose -f ./docker/docker-compose.yml -p test start # запуск пущеных в ход контенеров, так же можно и останавливать: stop
docker-compose -f ./docker/docker-compose.yml -p test start {имя контейнера} # запуск конкретного контейнера
docker-compose -f ./docker/docker-compose.yml -p test rm {имя контейнера} # удаляет остановленный контенер
docker-compose -f ./docker/docker-compose.yml -p test build # пытается создать контейнер, если его нет; или пересоздать, если появились изменения в конфигурации
docker-compose -f ./docker/docker-compose.yml -p test up -d # "поднимает" построенные, но не пущеные в ход контейнеры
```
Если нет желания утруждать себя в добавлении контента, можно воспользоваться модулями с предустановленными данными: "sample data", 
для этого нужно выполнить команду из test_php_1 контейнера:
```bash
php bin/magento sampledata:deploy && \
php bin/magento setup:upgrade && \
php bin/magento cache:clean && ./bin/setup_permissions.sh
```

Вспомогательный функционал + PHPStorm
1. Вариант настройки дебаггера для веб:
  a. открыть настройки Ctl+Alt+S
  b. в разделе Languages & Frameworks > PHP > Servers добавить настройки, как на рисунке about_debug/servers.png
  c. в разделе Languages & Frameworks > PHP > Debug > DBGp Proxy добавить настройки, как на рисунке about_debug/dbgproxy.png
  d. посетить https://www.jetbrains.com/phpstorm/marklets/ , под 'Xdebug IDE key: PHPSTORM' нажать кнопку 'Generate' > 
    появятся ссылки, среди которых будут "Start debugger" и "Stop debugger". 
    Можно создать закладки для старта и остановки дебага - скопировать код ссылок в новосозданные закладки. 
    Или выполнить команду в консоли браузера:
```javascript
    document.cookie='XDEBUG_SESSION='+'PHPSTORM'+';path=/;'
```
   Или любым другим доступным спсобом насетапить куки XDEBUG_SESSION со значением PHPSTORM
2. Вариант настройки дебаггера для консольных команд:
    В languages&frameworks->PHP->Servers добавить новый раздел, если еще не добавлен (можно использовать тот, что для веб).
    Взять его "имя" (в нашем случае - test)
    С именем test - дебаг будет настроен без дополнительных настроек, это прописано в файле docker/development/php/Dockerfile
    Если в languages&frameworks->PHP->Servers будет указано другое имя, нужно перебилдить контейнер php с новым именем сервера.
    Или переменную окружения вручную (нужно будет выполнять каждый раз, когда входишь в bash контейнера) :
    ```bash
      export PHP_IDE_CONFIG="serverName={другоеИмя}"
    ```
    Поставить брейк-поинты, запустить консольную команду магенты, дебажить.
3. Посказки в xml конфигах:
	В файле .idea/misc.xml (от корня проекта. phpstorm его может не видеть) нужно заменить докеровский путь атрибута "location" (/var/www/...) 
	к файлам на реальный, например: '/home/path/to/project'
	и выполнить команду:
  ```bash
    docker exec --user $UID:www-data -it test_php_1 php bin/magento dev:urn-catalog:generate .idea/misc.xml  
  ```
4. Подключение к системе управления баз данных:
  a. В разделе View > Tool Windows кликнуть "Database" , в появившейся вкладке нажать на плюсик, выбрать "Data Source > MySQL"
  b. Проставить данные (можно посмотреть в файле ./docker/docker-compose.yml)
    Host: localhost
    Port: 33061
    Database: test
    User: test
    Pass: testpass
  c. Нажать ок - все база подключена, можно просматривать структуру и данные таблиц базы данных магенты
  