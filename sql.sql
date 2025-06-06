CREATE TABLE partners
(
    id serial,
    organization_type text,
    name text UNIQUE,
    ceo text,
    email text,
    phone text,
    address text,
    tax_id text,
    rating integer,
    PRIMARY KEY (id)
);

INSERT INTO partners (organization_type, name, ceo, email, phone, address, tax_id, rating)
VALUES 
('ЗАО', 'База Строитель', 'Иванова Александра Ивановна', 'aleksandraivanova@ml.ru', '493 123 45 67', '652050, Кемеровская область, город Юрга, ул. Лесная, 15', '2222455179', 7),
('ООО', 'Паркет 29', 'Петров Василий Петрович', 'vppetrov@vl.ru', '987 123 56 78', '164500, Архангельская область, город Северодвинск, ул. Строителей, 18', '3333888520', 7),
('ПАО', 'Стройсервис', 'Соловьев Андрей Николаевич', 'ansolovev@st.ru', '812 223 32 00', '188910, Ленинградская область, город Приморск, ул. Парковая, 21', '4440391035', 7),
('ОАО', 'Ремонт и отделка','Воробьева Екатерина Валерьевна', 'ekaterina.vorobeva@ml.ru', '444 222 33 11', '143960, Московская область, город Реутов, ул. Свободы, 51', '1111520857', 5),
('ЗАО', 'МонтажПро','Степанов Степан Сергеевич', 'stepanov@stepan.ru', '912 888 33 33', '309500, Белгородская область, город Старый Оскол, ул. Рабочая, 122', '5552431140', 10);

CREATE TABLE products
(
    id serial,
    product_type text,
    name text NOT NULL,
    article text NOT NULL,
    min_price_for_partner decimal NOT NULL,
    currency_type text NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO products (product_type, name, article, min_price_for_partner, currency_type)
VALUES
('Паркетная доска', 'Паркетная доска Ясень темный однополосная 14 мм', '8758385', 4456.90, 'RUB'),
('Паркетная доска', 'Инженерная доска Дуб Французская елка однополосная 12 мм', '8858958', 7330.99, 'RUB'),
('Ламинат', 'Ламинат Дуб дымчато-белый 33 класс 12 мм', '7750282', 1799.33, 'RUB'),
('Ламинат', 'Ламинат Дуб серый 32 класс 8 мм с фаской', '7028748', 3890.41, 'RUB'),
('Пробковое покрытие', 'Пробковое напольное клеевое покрытие 32 класс 4 мм', '5012543', 5450.59, 'RUB');

CREATE TABLE sales
(
    id serial NOT NULL,
    product_id integer REFERENCES products(id) NOT NULL,
    partner_id integer REFERENCES partners(id) NOT NULL,
    production_quantity bigint,
    date_of_sale DATE,
    PRIMARY KEY (id)
);

SET datestyle = "ISO, MDY";

INSERT INTO sales (product_id, partner_id, production_quantity, date_of_sale)
VALUES
(1, 1, 15500, '03-23-2023'),
(3, 1, 12350, '12-18-2023'),
(4, 1, 37400, '06-07-2024'),
(2, 2, 35000, '12-02-2022'),
(5, 2, 1250, '05-17-2023'),
(3, 2, 1000, '06-07-2024'),
(1, 2, 7550, '07-01-2024'),
(1, 3, 7250, '01-22-2023'),
(2, 3, 2500, '07-05-2024'),
(4, 4, 59050, '03-05-2023'),
(3, 4, 37200, '03-12-2024'),
(5, 4, 4500, '5-14-2024'),
(3, 5, 50000, '9-19-2023'),
(4, 5, 670000, '11-10-2023'),
(1, 5, 35000, '4-15-2024'),
(2, 5, 25000, '6-12-2024');

-------------------------------------------------------2.0


CREATE TABLE products_type (
    id SERIAL PRIMARY KEY,
    type                 VARCHAR(255),    
    coeff_type_product   NUMERIC(5,2)
);


INSERT INTO products_type (type, coeff_type_product) VALUES
  ('Древесно-плитные материалы', 1.50),
  ('Декоративные панели',        3.50),
  ('Плитка',                     5.25),
  ('Фасадные материалы',         4.50),
  ('Напольные покрытия',         2.17);



CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    id_products_type INT REFERENCES products_type(id),  
    name             VARCHAR(255),                              
    article          VARCHAR(50),                              
    min_cost         NUMERIC(10,2)                            
);

INSERT INTO products (id_products_type, name, article, min_cost) VALUES
  (1, 'Фанера ФСФ 1800х1200х27 мм бежевая береза',                             '6549922', 5100.00),
  (2, 'Мягкие панели прямоугольник велюр цвет оливковый 600х300х35 мм',         '7018556', 1880.00),
  (4, 'Бетонная плитка Белый кирпич микс 30х7,3 см',                           '5028272', 2080.00),
  (3, 'Плитка Мозаика 10x10 см цвет белый глянец',                              '8028248', 2500.00),
  (5, 'Ламинат Дуб Античный серый 32 класс толщина 8 мм с фаской',              '9250282', 4050.00),
  (2, 'Стеновая панель МДФ Флора 1440x500x10 мм',                              '7130981', 2100.56),
  (4, 'Бетонная плитка Красный кирпич 20x6,5 см',                               '5029784', 2760.00),
  (5, 'Ламинат Канди Дизайн 33 класс толщина 8 мм с фаской',                    '9658953', 3200.96),
  (1, 'Плита ДСП 11 мм влагостойкая 594x1815 мм',                               '6026662',  497.69),
  (5, 'Ламинат с натуральным шпоном Дуб Эксперт толщина 6 мм с фаской',          '9159043', 3750.00),
  (3, 'Плитка настенная Формат 20x40 см матовая цвет мята',                      '8588376', 2500.00),
  (1, 'Плита ДСП Кантри 16 мм 900x1200 мм',                                      '6758375', 1050.96),
  (2, 'Стеновая панель МДФ Сосна Полярная 60x280x4мм цвет коричневый',           '7759324', 1700.00),
  (4, 'Клинкерная плитка коричневая 29,8x29,8 см',                               '5118827',  860.00),
  (3, 'Плитка настенная Цветок 60x120 см цвет зелено-голубой',                   '8559898', 2300.00),
  (2, 'Пробковое настенное покрытие 600х300х3 мм белый',                         '7259474', 3300.00),
  (3, 'Плитка настенная Нева 30x60 см цвет серый',                               '8115947', 1700.00),
  (4, 'Гипсовая плитка настенная Дом на берегу кирпич белый 18,5х4,5 см',        '5033136',  499.00),
  (5, 'Ламинат Дуб Северный белый 32 класс толщина 8 мм с фаской',               '9028048', 2550.00),
  (1, 'Дерево волокнистая плита Дуб Винтаж 1200х620х3 мм светло-коричневый',     '6123459',  900.50);


CREATE TABLE partners (
    id             SERIAL      PRIMARY KEY,
    type_partner   VARCHAR(10),    
    name_partner   VARCHAR(255),   
    director       VARCHAR(255),   
    email          VARCHAR(255),    
    phone          VARCHAR(30),   
    legal_address  TEXT,    
    inn            VARCHAR(20) UNIQUE, 
    rating         SMALLINT    
);

INSERT INTO partners (
    type_partner,
    name_partner,
    director,
    email,
    phone,
    legal_address,
    inn,
    rating
) VALUES
  ('ЗАО', 'Стройдвор',               'Андреева Ангелина Николаевна',    'angelina77@kart.ru',         '492 452 22 82',
   '143001, Московская область, город Одинцово, ул. Ленина, 21',          '9432455179',  5),
  ('ЗАО', 'Самоделка',               'Мельников Максим Петрович',       'melnikov.maksim88@hm.ru',    '812 267 19 59',
   '306230, Курская область, город Обоянь, ул. 1 Мая, 89',                '7803888520',  3),
  ('ООО', 'Деревянные изделия',      'Лазарев Алексей Сергеевич',       'aleksejlazarev@al.ru',       '922 467 93 83',
   '238340, Калининградская область, город Светлый, ул. Морская, 12',     '8430391035',  4),
  ('ООО', 'Декор и отделка',         'Саншокова Мадина Муратовна',      'mmsanshokova@lss.ru',        '413 230 30 79',
   '685000, Магаданская область, город Магадан, ул. Горького, 15',         '4318170454',  7),
  ('ООО', 'Паркет',                  'Иванов Дмитрий Сергеевич',        'ivanov.dmitrij@mail.ru',     '921 851 21 22',
   '606440, Нижегородская область, город Бор, ул. Свободы, 3',             '7687851800',  7),
  ('ПАО', 'Дом и сад',               'Аникеева Екатерина Алексеевна',    'ekaterina.anikeeva@ml.ru',   '499 936 29 26',
   '393760, Тамбовская область, город Мичуринск, ул. Красная, 50',         '6119144874',  7),
  ('ОАО', 'Легкий шаг',              'Богданова Ксения Владимировна',   'bogdanova.kseniya@bkv.ru',   '495 445 61 41',
   '307370, Курская область, город Рыльск, ул. Гагарина, 16',              '1122170258',  6),
  ('ПАО', 'СтройМатериалы',          'Холодова Валерия Борисовна',      'holodova@education.ru',      '499 234 56 78',
   '140300, Московская область, город Егорьевск, ул. Советская, 24',       '8355114917',  5),
  ('ОАО', 'Мир отделки',             'Крылов Савелий Тимофеевич',       'stkrylov@mail.ru',           '908 713 51 88',
   '344116, Ростовская область, город Ростов-на-Дону, ул. Артиллерийская, 4','3532367439',  8),
  ('ОАО', 'Технологии комфорта',     'Белов Кирилл Александрович',      'kirill_belov@kir.ru',        '918 432 12 34',
   '164500, Архангельская область, город Северодвинск, ул. Ломоносова, 29','2362431140',  4),
  ('ПАО', 'Твой дом',                'Демидов Дмитрий Александрович',    'dademidov@ml.ru',            '919 698 75 43',
   '354000, Краснодарский край, город Сочи, ул. Больничная, 11',           '4159215346', 10),
  ('ЗАО', 'Новые краски',            'Алиев Дамир Игоревич',            'alievdamir@tk.ru',           '812 823 93 42',
   '187556, Ленинградская область, город Тихвин, ул. Гоголя, 18',          '9032455179',  9),
  ('ОАО', 'Политехник',              'Котов Михаил Михайлович',         'mmkotov56@educat.ru',        '495 895 71 77',
   '143960, Московская область, город Реутов, ул. Новая, 55',              '3776671267',  5),
  ('ОАО', 'СтройАрсенал',            'Семенов Дмитрий Максимович',      'semenov.dm@mail.ru',         '896 123 45 56',
   '242611, Брянская область, город Фокино, ул. Фокино, 23',               '7447864518',  5),
  ('ПАО', 'Декор и порядок',          'Болотов Артем Игоревич',          'artembolotov@ab.ru',         '950 234 12 12',
   '309500, Белгородская область, город Старый Оскол, ул. Цветочная, 20',  '9037040523',  5),
  ('ПАО', 'Умные решения',           'Воронова Анастасия Валерьевна',   'voronova_anastasiya@mail.ru','923 233 27 69',
   '652050, Кемеровская область, город Юрга, ул. Мира, 42',                '6221520857',  3),
  ('ЗАО', 'Натуральные покрытия',    'Горбунов Василий Петрович',       'vpgorbunov24@vvs.ru',        '902 688 28 96',
   '188300, Ленинградская область, город Гатчина, пр. 25 Октября, 17',      '2262431140',  9),
  ('ООО', 'СтройМастер',             'Смирнов Иван Андреевич',          'smirnov_ivan@kv.ru',         '917 234 75 55',
   '184250, Мурманская область, город Кировск, пр. Ленина, 24',             '4155215346',  9),
  ('ООО', 'Гранит',                  'Джумаев Ахмед Умарович',          'dzhumaev.ahmed@amail.ru',    '495 452 55 95',
   '162390, Вологодская область, город Великий Устюг, ул. Железнодорожная, 36','3961234561', 5),
  ('ЗАО', 'Строитель',               'Петров Николай Тимофеевич',       'petrov.nikolaj31@mail.ru',   '916 596 15 55',
   '188910, Ленинградская область, город Приморск, ш. Приморское, 18',      '9600275878', 10);


CREATE TABLE partners_products (
    id SERIAL PRIMARY KEY,
    partner_id  INT REFERENCES partners(id),
    product_id  INT  REFERENCES products(id),
    quantity    INT
);

INSERT INTO partners_products (partner_id, product_id, quantity) VALUES
  (
    (SELECT id FROM partners WHERE name_partner = 'Стройдвор'),
    (SELECT id FROM products WHERE name          = 'Плитка Мозаика 10x10 см цвет белый глянец'),
    2000
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Самоделка'),
    (SELECT id FROM products WHERE name          = 'Ламинат Дуб Античный серый 32 класс толщина 8 мм с фаской'),
    3000
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Деревянные изделия'),
    (SELECT id FROM products WHERE name          = 'Фанера ФСФ 1800х1200х27 мм бежевая береза'),
    1000
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Декор и отделка'),
    (SELECT id FROM products WHERE name          = 'Бетонная плитка Белый кирпич микс 30х7,3 см'),
    9500
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Паркет'),
    (SELECT id FROM products WHERE name          = 'Фанера ФСФ 1800х1200х27 мм бежевая береза'),
    2000
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Дом и сад'),
    (SELECT id FROM products WHERE name          = 'Гипсовая плитка настенная Дом на берегу кирпич белый 18,5х4,5 см'),
    1100
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Легкий шаг'),
    (SELECT id FROM products WHERE name          = 'Плита ДСП Кантри 16 мм 900x1200 мм'),
    5000
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'СтройМатериалы'),
    (SELECT id FROM products WHERE name          = 'Фанера ФСФ 1800х1200х27 мм бежевая береза'),
    2500
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Мир отделки'),
    (SELECT id FROM products WHERE name          = 'Мягкие панели прямоугольник велюр цвет оливковый 600х300х35 мм'),
    6000
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Технологии комфорта'),
    (SELECT id FROM products WHERE name          = 'Стеновая панель МДФ Флора 1440x500x10 мм'),
    7000
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Твой дом'),
    (SELECT id FROM products WHERE name          = 'Плитка Мозаика 10x10 см цвет белый глянец'),
    5000
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Новые краски'),
    (SELECT id FROM products WHERE name          = 'Плитка Мозаика 10x10 см цвет белый глянец'),
    7500
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Политехник'),
    (SELECT id FROM products WHERE name          = 'Фанера ФСФ 1800х1200х27 мм бежевая береза'),
    3000
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'СтройАрсенал'),
    (SELECT id FROM products WHERE name          = 'Гипсовая плитка настенная Дом на берегу кирпич белый 18,5х4,5 см'),
    500
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Декор и порядок'),
    (SELECT id FROM products WHERE name          = 'Пробковое настенное покрытие 600х300х3 мм белый'),
    7000
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Умные решения'),
    (SELECT id FROM products WHERE name          = 'Плита ДСП 11 мм влагостойкая 594x1815 мм'),
    4000
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Натуральные покрытия'),
    (SELECT id FROM products WHERE name          = 'Фанера ФСФ 1800х1200х27 мм бежевая береза'),
    3500
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'СтройМастер'),
    (SELECT id FROM products WHERE name          = 'Фанера ФСФ 1800х1200х27 мм бежевая береза'),
    7900
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Гранит'),
    (SELECT id FROM products WHERE name          = 'Плитка настенная Цветок 60x120 см цвет зелено-голубой'),
    9600
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Строитель'),
    (SELECT id FROM products WHERE name          = 'Плитка настенная Цветок 60x120 см цвет зелено-голубой'),
    1200
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Стройдвор'),
    (SELECT id FROM products WHERE name          = 'Плитка настенная Формат 20x40 см матовая цвет мята'),
    1500
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Самоделка'),
    (SELECT id FROM products WHERE name          = 'Ламинат Канди Дизайн 33 класс толщина 8 мм с фаской'),
    3000
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Деревянные изделия'),
    (SELECT id FROM products WHERE name          = 'Мягкие панели прямоугольник велюр цвет оливковый 600х300х35 мм'),
    3010
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Декор и отделка'),
    (SELECT id FROM products WHERE name          = 'Бетонная плитка Красный кирпич 20x6,5 см'),
    3020
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Паркет'),
    (SELECT id FROM products WHERE name          = 'Ламинат Дуб Античный серый 32 класс толщина 8 мм с фаской'),
    3050
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Дом и сад'),
    (SELECT id FROM products WHERE name          = 'Клинкерная плитка коричневая 29,8x29,8 см'),
    3040
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Легкий шаг'),
    (SELECT id FROM products WHERE name          = 'Ламинат Дуб Северный белый 32 класс толщина 8 мм с фаской'),
    3050
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'СтройМатериалы'),
    (SELECT id FROM products WHERE name          = 'Плитка Мозаика 10x10 см цвет белый глянец'),
    3060
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Мир отделки'),
    (SELECT id FROM products WHERE name          = 'Гипсовая плитка настенная Дом на берегу кирпич белый 18,5х4,5 см'),
    3070
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Технологии комфорта'),
    (SELECT id FROM products WHERE name          = 'Плита ДСП 11 мм влагостойкая 594x1815 мм'),
    5400
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Твой дом'),
    (SELECT id FROM products WHERE name          = 'Плита ДСП Кантри 16 мм 900x1200 мм'),
    5500
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Новые краски'),
    (SELECT id FROM products WHERE name          = 'Плитка настенная Формат 20x40 см матовая цвет мята'),
    5600
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Политехник'),
    (SELECT id FROM products WHERE name          = 'Плита ДСП 11 мм влагостойкая 594x1815 мм'),
    5700
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'СтройАрсенал'),
    (SELECT id FROM products WHERE name          = 'Клинкерная плитка коричневая 29,8x29,8 см'),
    5800
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Декор и порядок'),
    (SELECT id FROM products WHERE name          = 'Мягкие панели прямоугольник велюр цвет оливковый 600х300х35 мм'),
    5900
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Умные решения'),
    (SELECT id FROM products WHERE name          = 'Плита ДСП Кантри 16 мм 900x1200 мм'),
    6000
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Натуральные покрытия'),
    (SELECT id FROM products WHERE name          = 'Стеновая панель МДФ Флора 1440x500x10 мм'),
    6100
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'СтройМастер'),
    (SELECT id FROM products WHERE name          = 'Плита ДСП 11 мм влагостойкая 594x1815 мм'),
    8000
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Гранит'),
    (SELECT id FROM products WHERE name          = 'Бетонная плитка Белый кирпич микс 30х7,3 см'),
    7060
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Строитель'),
    (SELECT id FROM products WHERE name          = 'Плитка настенная Нева 30x60 см цвет серый'),
    6120
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Стройдвор'),
    (SELECT id FROM products WHERE name          = 'Плитка настенная Цветок 60x120 см цвет зелено-голубой'),
    5180
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Самоделка'),
    (SELECT id FROM products WHERE name          = 'Ламинат с натуральным шпоном Дуб Эксперт толщина 6 мм с фаской'),
    4240
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Деревянные изделия'),
    (SELECT id FROM products WHERE name          = 'Ламинат с натуральным шпоном Дуб Эксперт толщина 6 мм с фаской'),
    3300
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Декор и отделка'),
    (SELECT id FROM products WHERE name          = 'Ламинат с натуральным шпоном Дуб Эксперт толщина 6 мм с фаской'),
    2360
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Паркет'),
    (SELECT id FROM products WHERE name          = 'Ламинат Канди Дизайн 33 класс толщина 8 мм с фаской'),
    1420
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Дом и сад'),
    (SELECT id FROM products WHERE name          = 'Плитка настенная Формат 20x40 см матовая цвет мята'),
    1500
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Легкий шаг'),
    (SELECT id FROM products WHERE name          = 'Ламинат Дуб Античный серый 32 класс толщина 8 мм с фаской'),
    1700
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'СтройМатериалы'),
    (SELECT id FROM products WHERE name          = 'Плита ДСП Кантри 16 мм 900x1200 мм'),
    1900
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Мир отделки'),
    (SELECT id FROM products WHERE name          = 'Плитка настенная Цветок 60x120 см цвет зелено-голубой'),
    2100
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Технологии комфорта'),
    (SELECT id FROM products WHERE name          = 'Плита ДСП Кантри 16 мм 900x1200 мм'),
    2300
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Твой дом'),
    (SELECT id FROM products WHERE name          = 'Ламинат Канди Дизайн 33 класс толщина 8 мм с фаской'),
    2500
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Новые краски'),
    (SELECT id FROM products WHERE name          = 'Плитка настенная Цветок 60x120 см цвет зелено-голубой'),
    2700
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Политехник'),
    (SELECT id FROM products WHERE name          = 'Плита ДСП Кантри 16 мм 900x1200 мм'),
    2900
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'СтройАрсенал'),
    (SELECT id FROM products WHERE name          = 'Фанера ФСФ 1800х1200х27 мм бежевая береза'),
    3100
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Декор и порядок'),
    (SELECT id FROM products WHERE name          = 'Гипсовая плитка настенная Дом на берегу кирпич белый 18,5х4,5 см'),
    3300
  ),
  (
    (SELECT id FROM partners WHERE name_partner = 'Умные решения'),
    (SELECT id FROM products WHERE name          = 'Дерево волокнистая плита Дуб Винтаж 1200х620х3 мм светло-коричневый'),
    3500
  );


3.0
-- --------------------------------------------------
-- 1) Таблица «Цеха» (workshops)
-- --------------------------------------------------
CREATE TABLE workshops (
    id               SERIAL       PRIMARY KEY,
    name              VARCHAR(255),
    type              VARCHAR(100),
    workers_count     INTEGER       
);

INSERT INTO workshops (name, type, workers_count) VALUES
  ('Проектный',    'Проектирование', 4),
  ('Расчетный',    'Проектирование', 5),
  ('Раскроя',      'Обработка',      5),
  ('Обработки',    'Обработка',      6),
  ('Сушильный',    'Сушка',          3),
  ('Покраски',     'Обработка',      5),
  ('Столярный',    'Обработка',      7),
  ('Изготовления изделий из искусственного камня и композитных материалов', 'Обработка', 3),
  ('Изготовления мягкой мебели', 'Обработка', 5),
  ('Монтажа стеклянных, зеркальных вставок и других изделий', 'Сборка', 2),
  ('Сборки',       'Сборка',         6),
  ('Упаковки',     'Сборка',         4);


-- --------------------------------------------------
-- 2) Справочник «Тип продукции» (product_types)
-- --------------------------------------------------
CREATE TABLE product_types (
    id                   SERIAL       PRIMARY KEY,
    type_name            VARCHAR(100),
    coeff_type           NUMERIC(4,2)       
);

-- Наполняем таблицу product_types
INSERT INTO product_types (type_name, coeff_type) VALUES
  ('Гостиные',       3.50),
  ('Прихожие',       5.60),
  ('Мягкая мебель',  3.00),
  ('Кровати',        4.70),
  ('Шкафы',          1.50),
  ('Комоды',         2.30);


-- --------------------------------------------------
-- 3) Справочник «Тип материала» (materials)
-- --------------------------------------------------
CREATE TABLE materials (
    id                     SERIAL       PRIMARY KEY,
    material_name          VARCHAR(100), 
    loss_percentage        NUMERIC(5,4)
);

-- Наполняем таблицу materials
INSERT INTO materials (material_name, loss_percentage) VALUES
  ('Мебельный щит из массива дерева', 0.0080),
  ('Ламинированное ДСП',               0.0070),
  ('Фанера',                           0.0055),
  ('МДФ',                              0.0030);


CREATE TABLE products (
    id                   SERIAL       PRIMARY KEY,
    product_type_id      INT          NOT NULL  REFERENCES product_types(id),
    name                 VARCHAR(255) NOT NULL,
    article              VARCHAR(50)  NOT NULL,
    min_cost             NUMERIC(12,2) NOT NULL,
    material_id          INT          NOT NULL  REFERENCES materials(id)
);


INSERT INTO products (product_type_id, name, article, min_cost, material_id) VALUES
  -- Гостиные
  (1, 'Комплект мебели для гостиной Ольха горная',            '1549922', 160507.00, 1),
  (1, 'Стенка для гостиной Вишня темная',                     '1018556', 216907.00, 1),

  -- Прихожие
  (2, 'Прихожая Венге Винтаж',                                '3028272',  24970.00, 2),
  (2, 'Тумба с вешалкой Дуб натуральный',                      '3029272',  18206.00, 2),
  (2, 'Прихожая-комплект Дуб темный',                          '3028248', 177509.00, 1),

  -- Мягкая мебель
  (3, 'Диван-кровать угловой Книжка',                          '7118827',  85900.00, 1),
  (3, 'Диван модульный Телескоп',                              '7137981',  75900.00, 1),
  (3, 'Диван-кровать Соло',                                    '7029787', 120345.00, 1),
  (3, 'Детский диван Выкатной',                                '7758953',  25990.00, 3),

  -- Кровати
  (4, 'Кровать с подъемным механизмом с матрасом 1600х2000 Венге','6026662',  69500.00, 1),
  (4, 'Кровать с матрасом 90х2000 Венге',                      '6159043',  55600.00, 2),
  (4, 'Кровать универсальная Дуб натуральный',                 '6588376',  37900.00, 2),
  (4, 'Кровать с ящиками Ясень белый',                          '6758375',  46750.00, 3),

  -- Шкафы
  (5, 'Шкаф-купе 3-х дверный Сосна белая',                     '2759324', 131560.00, 2),
  (5, 'Стеллаж Бук натуральный',                               '2118827',  38700.00, 1),
  (5, 'Шкаф 4 дверный с ящиками Ясень серый',                  '2559898', 160151.00, 3),
  (5, 'Шкаф-пенал Береза белый',                                '2259474',  40500.00, 3),

  -- Комоды
  (6, 'Комод 6 ящиков Вишня светлая',                           '4115947',  61235.00, 1),
  (6, 'Комод 4 ящика Вишня светлая',                            '4033136',  41200.00, 1),
  (6, 'Тумба под ТВ',                                           '4028048',  12350.00, 4);


-- --------------------------------------------------
-- 5) Таблица «Связь продукции с цехами — Упаковка» (product_workshops)
-- --------------------------------------------------

CREATE TABLE product_workshops (
    id            SERIAL       PRIMARY KEY,
    product_id    INT          NOT NULL  REFERENCES products(id),
    workshop_id   INT          NOT NULL  REFERENCES workshops(id),
    coefficient   NUMERIC(4,2) NOT NULL  -- Доля/коэффициент (например, 0.2, 0.3 и т. д.)
);

-- Перед вставкой убедимся, что в таблице workshops уже есть строка с name = 'Упаковки'
-- и получим её id, а также соответствующие product.id по product.name.

-- Заполняем product_workshops:
INSERT INTO product_workshops (product_id, workshop_id, coefficient) VALUES
  (
    -- «Диван модульный Телескоп» ⇒ коэфф. 0.2, цех «Упаковки»
    (SELECT id FROM products  WHERE name = 'Диван модульный Телескоп'),
    (SELECT id FROM workshops WHERE name = 'Упаковки'),
    0.20
  ),
  (
    -- «Диван-кровать Соло» ⇒ коэфф. 0.3
    (SELECT id FROM products  WHERE name = 'Диван-кровать Соло'),
    (SELECT id FROM workshops WHERE name = 'Упаковки'),
    0.30
  ),
  (
    -- «Детский диван Выкатной» ⇒ коэфф. 0.5
    (SELECT id FROM products  WHERE name = 'Детский диван Выкатной'),
    (SELECT id FROM workshops WHERE name = 'Упаковки'),
    0.50
  ),
  (
    -- «Кровать с подъемным механизмом с матрасом 1600х2000 Венге» ⇒ коэфф. 0.5
    (SELECT id FROM products  WHERE name = 'Кровать с подъемным механизмом с матрасом 1600х2000 Венге'),
    (SELECT id FROM workshops WHERE name = 'Упаковки'),
    0.50
  ),
  (
    -- «Кровать с матрасом 90х2000 Венге» ⇒ коэфф. 0.5
    (SELECT id FROM products  WHERE name = 'Кровать с матрасом 90х2000 Венге'),
    (SELECT id FROM workshops WHERE name = 'Упаковки'),
    0.50
  ),
  (
    -- «Кровать универсальная Дуб натуральный» ⇒ коэфф. 0.3
    (SELECT id FROM products  WHERE name = 'Кровать универсальная Дуб натуральный'),
    (SELECT id FROM workshops WHERE name = 'Упаковки'),
    0.30
  ),
  (
    -- «Кровать с ящиками Ясень белый» ⇒ коэфф. 0.2
    (SELECT id FROM products  WHERE name = 'Кровать с ящиками Ясень белый'),
    (SELECT id FROM workshops WHERE name = 'Упаковки'),
    0.20
  ),
  (
    -- «Шкаф-купе 3-х дверный Сосна белая» ⇒ коэфф. 0.5
    (SELECT id FROM products  WHERE name = 'Шкаф-купе 3-х дверный Сосна белая'),
    (SELECT id FROM workshops WHERE name = 'Упаковки'),
    0.50
  ),
  (
    -- «Стеллаж Бук натуральный» ⇒ коэфф. 0.2
    (SELECT id FROM products  WHERE name = 'Стеллаж Бук натуральный'),
    (SELECT id FROM workshops WHERE name = 'Упаковки'),
    0.20
  ),
  (
    -- «Шкаф 4 дверный с ящиками Ясень серый» ⇒ коэфф. 0.5
    (SELECT id FROM products  WHERE name = 'Шкаф 4 дверный с ящиками Ясень серый'),
    (SELECT id FROM workshops WHERE name = 'Упаковки'),
    0.50
  ),
  (
    -- «Шкаф-пенал Береза белый» ⇒ коэфф. 0.5
    (SELECT id FROM products  WHERE name = 'Шкаф-пенал Береза белый'),
    (SELECT id FROM workshops WHERE name = 'Упаковки'),
    0.50
  ),
  (
    -- «Комод 6 ящиков Вишня светлая» ⇒ коэфф. 0.2
    (SELECT id FROM products  WHERE name = 'Комод 6 ящиков Вишня светлая'),
    (SELECT id FROM workshops WHERE name = 'Упаковки'),
    0.20
  ),
  (
    -- «Комод 4 ящика Вишня светлая» ⇒ коэфф. 0.2
    (SELECT id FROM products  WHERE name = 'Комод 4 ящика Вишня светлая'),
    (SELECT id FROM workshops WHERE name = 'Упаковки'),
    0.20
  ),
  (
    -- «Тумба под ТВ» ⇒ коэфф. 0.3
    (SELECT id FROM products  WHERE name = 'Тумба под ТВ'),
    (SELECT id FROM workshops WHERE name = 'Упаковки'),
    0.30
  );


-- --------------------------------------------------
-- Готовая структура БД:
-- 
--   TABLE workshops              -- Цеха/участки производства
--   TABLE product_types          -- Справочник «Типы продукции» + коэффициенты
--   TABLE materials              -- Справочник «Типы материалов» + потери сырья
--   TABLE products               -- Конкретная продукция с ссылкой на тип и на материал
--   TABLE product_workshops      -- Коэффициенты упаковки (или любого другого цеха) для каждой продукции
-- --------------------------------------------------
