﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	ПараметрыФормы = Новый Структура(
		"Отбор, СформироватьПриОткрытии",
		Новый Структура("Сделка", ПараметрКоманды),
		Истина
	);
	ОткрытьФорму(
		"Отчет.СоставПродажи.Форма",
		ПараметрыФормы,
		ПараметрыВыполненияКоманды.Источник,
		ПараметрыВыполненияКоманды.Уникальность,
		ПараметрыВыполненияКоманды.Окно
	);

КонецПроцедуры
