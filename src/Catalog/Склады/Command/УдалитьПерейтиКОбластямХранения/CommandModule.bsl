﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	Отбор = Новый Структура;
	Отбор.Вставить("Владелец", ПараметрКоманды);
	
	ОткрытьФорму("Справочник.ОбластиХранения.ФормаСписка",Новый Структура("Отбор", Отбор),,ПараметрКоманды,ПараметрыВыполненияКоманды.Окно);
КонецПроцедуры
