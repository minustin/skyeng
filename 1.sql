-- https://www.db-fiddle.com/f/hhcT8qxkeFYQHRwBYkpATq/0
-- Задание: Спроектировать схему БД для хранения библиотеки. Интересуют авторы и книги.
--
-- Дополнительное задание: Написать SQL который вернет список книг, написанный ровно 3-мя соавторами. Результат: книга - количество соавторов.
-- Решение должно быть представлено в виде ссылки на https://www.db-fiddle.com/.



CREATE TABLE `skyeng_authors` (
  `book_id` bigint(20) UNSIGNED NOT NULL,
  `writer_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Дамп данных таблицы `skyeng_authors`
--

INSERT INTO `skyeng_authors` (`book_id`, `writer_id`) VALUES
(1, 1),
(2, 1),
(2, 2),
(3, 1),
(3, 2),
(3, 3),
(4, 1),
(4, 2),
(4, 3),
(5, 2),
(5, 4),
(5, 6),
(5, 7),
(6, 3);

-- --------------------------------------------------------

--
-- Структура таблицы `skyeng_books`
--

CREATE TABLE `skyeng_books` (
  `book_id` bigint(20) UNSIGNED NOT NULL,
  `book_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Дамп данных таблицы `skyeng_books`
--

INSERT INTO `skyeng_books` (`book_id`, `book_name`) VALUES
(1, 'Book with 1 author'),
(2, 'Book with 2 authors'),
(3, 'Book with 3 authors'),
(4, 'Book with 3 authors -2'),
(5, 'Book with 4 authors'),
(6, 'Book with 1 author -2');

-- --------------------------------------------------------

--
-- Структура таблицы `skyeng_writers`
--

CREATE TABLE `skyeng_writers` (
  `writer_id` bigint(20) UNSIGNED NOT NULL,
  `writer_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Дамп данных таблицы `skyeng_writers`
--

INSERT INTO `skyeng_writers` (`writer_id`, `writer_name`) VALUES
(1, 'Author 1'),
(2, 'Author 2'),
(3, 'Author 3'),
(4, 'Author 4'),
(5, 'Author 5'),
(6, 'Author 6'),
(7, 'Author 7'),
(8, 'Author 8');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `skyeng_authors`
--
ALTER TABLE `skyeng_authors`
  ADD PRIMARY KEY (`book_id`,`writer_id`);

--
-- Индексы таблицы `skyeng_books`
--
ALTER TABLE `skyeng_books`
  ADD PRIMARY KEY (`book_id`);

--
-- Индексы таблицы `skyeng_writers`
--
ALTER TABLE `skyeng_writers`
  ADD PRIMARY KEY (`writer_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `skyeng_books`
--
ALTER TABLE `skyeng_books`
  MODIFY `book_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT для таблицы `skyeng_writers`
--
ALTER TABLE `skyeng_writers`
  MODIFY `writer_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;



SELECT b.book_name, count(*) as cnt FROM skyeng_books b
JOIN skyeng_authors a
ON a.book_id = b.book_id
GROUP BY b.book_id
HAVING cnt=3;


