# TZ_platform.io-
Дано:
База Данных MySQL
Таблицы:
user(id INT, country_id INT, created_at DATETIME) - содержит список пользователей платформы
country(id INT, name VARCHAR(50)) - содержит список всех стран мира
transaction(id INT, user_id INT, amount DECIMAL(5,2), transaction_type_id INT, created_at DATETIME) - список всех транзакций пользователя: пополнение баланса, траты в системе за пользование сервисом
transaction_type(id INT, unique_name VARCHAR(20)) список типов транзакций unique_name = DEPOSIT, SPEND
campaign(id INT, user_id INT, campaign_category_id INT) Список рекламных кампаний на платформе созданными пользователями
campaign_category(id INT, name VARCHAR(50)) Список категорий кампаний - Игры, Мобильные приложения, Десктопные приложения и т.п.

Задача:
Нужно найти общий DAU по месяцам или дням, DAU - Daily Active Users за период с 2020 года.
Пользователь считается активным если он тратил деньги на платформе (см. transaction таблицу)тип транзакции SPEND.
Нужно выяснить по каким странам/категориям кампаний произошла просадка активных пользователей и за какой период.
На выходе должен быть SQL запросы для последующего
построения графиков по данными в разрезе по времени(день или месяц на выбор)(строить графики не обязательно)

Комментарий к решению: 

Первый запрос -  общий MAU по месяцам  за период с 2020 года
(DISTINCT user.id)  - это для того, что если один пользователь сделал 2-3 (к примеру) покупки в один месяц  - он будет считаться как один активный пользователь относительно месяца
Чтобы посмотреть кол-во просадок (без стран\категории) будет достаточно первого запроса и достаточно 1 графика относительно месяцев.

Второй запрос - в данном запросе считается кол-во активных пользователей  (пользователь может совершать несколько покупок в месяц, пользователь может принадлежать только одной стране, регистрация пользователя не влияет на выборку, пользователь может принадлежать разным категориям компаний) относительно каждого месяца + страны + категории компании. Данные будут получены относительно 3 метрик сразу. Чтобы проанализировать просадку активных пользователей, данные будут выведены от меньшего количества пользователей до большего. Чтобы детально разобрать данные, я бы в операторе WHERE выбрал бы конкретно одну страну/категорию, по которой бы провел анализ просадки (относительно месяцев), построил график. Так как стран\категорий - множество, то строил бы множество графиков
