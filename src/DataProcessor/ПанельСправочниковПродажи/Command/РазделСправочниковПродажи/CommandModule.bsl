﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	#Если ВебКлиент Тогда
	ОкноОткрытияПанели = ПараметрыВыполненияКоманды.Окно;
	#Иначе
	ОкноОткрытияПанели = ПараметрыВыполненияКоманды.Источник;
	#КонецЕсли 
	
	ОткрытьФорму(
		"Обработка.ПанельСправочниковПродажи.Форма.ПанельСправочниковПродажи",
		,
		ПараметрыВыполненияКоманды.Источник,
		ПараметрыВыполненияКоманды.Уникальность,
		ОкноОткрытияПанели
	);
	
КонецПроцедуры
