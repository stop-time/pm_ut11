﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда


////////////////////////////////////////////////////////////////////////////////
// ПРОГРАММНЫЙ ИНТЕРФЕЙС

// Функция возвращает статус кассовой смены
//
// Параметры
//  КассоваяСменаСсылка  - Ссылка на смену
//
// Возвращаемое значение:
//   КассоваяСменаСсылка   - Статус кассовой смены
//
Функция СтатусКассовойСмены(КассоваяСменаСсылка) Экспорт

	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	КассоваяСмена.СтатусКассовойСмены КАК СтатусКассовойСмены
	|ИЗ
	|	Документ.КассоваяСмена КАК КассоваяСмена
	|ГДЕ
	|	КассоваяСмена.Ссылка = &Ссылка";
	
	Запрос.УстановитьПараметр("Ссылка", КассоваяСменаСсылка);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		Возврат Выборка.СтатусКассовойСмены;
	Иначе
		Возврат Перечисления.СтатусыКассовойСмены.ПустаяСсылка();
	КонецЕсли;
	
КонецФункции

#КонецЕсли