# OpenCart-Gulp framework
## Что нужно
* node ^6.9.1
* npm ^3.10.0

## Склонируйте репозиторий
`$ git clone http://art-lemon.com:4040/summary/box-shop-gulp.git`

Нужно глобально установить *gulp* и *bower*

В консоли необходимо прописать `npm install gulp bower -g`

Создайте файл `options.json`, в котором необходимо указать
```
{
    "markup": "html", // html или pug
    "env": "dev", // dev или prod
    "uncss": false, // true или false
    "proxy": "opencart.local" // адрес, на котором запущен сайт на локальном сервере
}
```

## Установите зависимости
```
npm install
bower install
```

## Проверка
Убедитесь, что вы правильно подключились к базе данных, проверьте файлы `config.php` и `admin/config.php`, проверьте работу локального сервера

## Всё готово для запуска
Для проксирующего сервера
```
gulp
```
Если не нужно прокси, а нужно только сбилдить файлы
```
gulp build
```

## Особенность для front-end разработчика
Ели на фронте используется `nunjacks-render`, то все теги `<img>` должны быть объявлены через функции.

Если в папке `data`, то вызывать `dataImage`
```
{{ dataImage('path-to-image', { title: 'Мой тайтл', alt: 'Мой alt' }) }}
```

Если в папке `images`, то вызывать `image`
```
{{ image('path-to-image', { title: 'Мой тайтл', alt: 'Мой alt' }) }}
```
Объект вторым аргументом необязателен
