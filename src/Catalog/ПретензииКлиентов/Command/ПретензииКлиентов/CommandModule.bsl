﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ОткрытьФорму("Справочник.ПретензииКлиентов.ФормаСписка",
	             Новый Структура("Отбор",Новый Структура("Партнер",ПараметрКоманды)),
	             ПараметрыВыполненияКоманды.Источник,
	             ПараметрыВыполненияКоманды.Источник.КлючУникальности,
	             ПараметрыВыполненияКоманды.Окно);
	
КонецПроцедуры
