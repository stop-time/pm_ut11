﻿&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ОткрытьФорму(
		"Отчет.УсловияЗакупок.Форма",
		Новый Структура("Отбор,СформироватьПриОткрытии", Новый Структура("Партнер", ПараметрКоманды), Истина),
		,
		"Партнер=" + ПараметрКоманды,
		ПараметрыВыполненияКоманды.Окно
	);
		
КонецПроцедуры
