﻿// Функция возвращает курс ставку НДС
//
// Параметры:
//  Валюта - СправочникСсылка.Валюты, валюта, по которой необходимо получить курс
//  ДатаКурса - Дата, календарная дата, на которую необходимо получить курс валюты
//
// Возвращаемое значение:
//	Курс переданной валюты на переданную дату, 1 в случае отсутствия значения.
//
Функция ПолучитьСтавкуНДС(СтавкаНДС) Экспорт

	Возврат УчетНДСПереопределяемый.ПолучитьСтавкуНДС(СтавкаНДС);

КонецФункции // ПолучитьСтавкуНДС()