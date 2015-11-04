﻿////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

////////////////////////////////////////////////////////////////////////////////
// Обработчики операций

// Соответствует операции GetExchangePlans
Функция ПолучитьПланыОбменаКонфигурации()
	
	Возврат СтроковыеФункцииКлиентСервер.ПолучитьСтрокуИзМассиваПодстрок(
		ОбменДаннымиВМоделиСервисаПовтИсп.ПланыОбменаСинхронизацииДанных()
	);
КонецФункции

// Соответствует операции PrepareExchangeExecution
Функция ЗапланироватьВыполнениеОбменаДанными(ОбластиДляОбменаДаннымиСтрокой)
	
	ОбластиДляОбменаДанными = ЗначениеИзСтрокиВнутр(ОбластиДляОбменаДаннымиСтрокой);
	
	Для Каждого Элемент Из ОбластиДляОбменаДанными Цикл
		
		ЗначениеРазделителя = Элемент.Ключ;
		СценарийОбменаДанными = Элемент.Значение;
		
		Параметры = Новый Массив;
		Параметры.Добавить(СценарийОбменаДанными);
		
		Попытка
			ОчередьЗаданий.ЗапланироватьВыполнениеЗадания(
			"ОбменДаннымиВМоделиСервиса.ВыполнитьОбменДанными", Параметры, "1",, ЗначениеРазделителя);
		Исключение
			Если ИнформацияОбОшибке().Описание <> ОчередьЗаданий.ПолучитьТекстИсключенияДублированиеЗаданийСОдинаковымКлючом() Тогда
				ВызватьИсключение;
			КонецЕсли;
		КонецПопытки;
		
	КонецЦикла;
	
	Возврат "";
КонецФункции

// Соответствует операции StartExchangeExecutionInFirstDataBase
Функция ВыполнитьДействиеСценарияОбменаДаннымиВПервойИнформационнойБазе(ИндексСтрокиСценария, СценарийОбменаДаннымиСтрокой)
	
	СценарийОбменаДанными = ЗначениеИзСтрокиВнутр(СценарийОбменаДаннымиСтрокой);
	
	СтрокаСценария = СценарийОбменаДанными[ИндексСтрокиСценария];
	
	Ключ = СтрокаСценария.ИмяПланаОбмена + СтрокаСценария.КодУзлаИнформационнойБазы;
	
	Параметры = Новый Массив;
	Параметры.Добавить(ИндексСтрокиСценария);
	Параметры.Добавить(СценарийОбменаДанными);
	
	Попытка
		ОчередьЗаданий.ЗапланироватьВыполнениеЗадания(
			"ОбменДаннымиВМоделиСервиса.ВыполнитьДействиеСценарияОбменаДаннымиВПервойИнформационнойБазе", 
			Параметры, Ключ,, СтрокаСценария.ЗначениеРазделителяПервойИнформационнойБазы);
	Исключение
		Если ИнформацияОбОшибке().Описание <> ОчередьЗаданий.ПолучитьТекстИсключенияДублированиеЗаданийСОдинаковымКлючом() Тогда
			ВызватьИсключение;
		КонецЕсли;
	КонецПопытки;
	
	Возврат "";
КонецФункции

// Соответствует операции StartExchangeExecutionInSecondDataBase
Функция ВыполнитьДействиеСценарияОбменаДаннымиВоВторойИнформационнойБазе(ИндексСтрокиСценария, СценарийОбменаДаннымиСтрокой)
	
	СценарийОбменаДанными = ЗначениеИзСтрокиВнутр(СценарийОбменаДаннымиСтрокой);
	
	СтрокаСценария = СценарийОбменаДанными[ИндексСтрокиСценария];
	
	Ключ = СтрокаСценария.ИмяПланаОбмена + СтрокаСценария.КодУзлаИнформационнойБазы;
	
	Параметры = Новый Массив;
	Параметры.Добавить(ИндексСтрокиСценария);
	Параметры.Добавить(СценарийОбменаДанными);
	
	Попытка
		ОчередьЗаданий.ЗапланироватьВыполнениеЗадания(
			"ОбменДаннымиВМоделиСервиса.ВыполнитьДействиеСценарияОбменаДаннымиВоВторойИнформационнойБазе", 
			Параметры, Ключ,, СтрокаСценария.ЗначениеРазделителяВторойИнформационнойБазы);
	Исключение
		Если ИнформацияОбОшибке().Описание <> ОчередьЗаданий.ПолучитьТекстИсключенияДублированиеЗаданийСОдинаковымКлючом() Тогда
			ВызватьИсключение;
		КонецЕсли;
	КонецПопытки;
	
	Возврат "";
КонецФункции

// Соответствует операции TestConnection
Функция ПроверитьПодключение(СтруктураНастроекСтрокой, ВидТранспортаСтрокой, СообщениеОбОшибке)
	
	Отказ = Ложь;
	
	// Проверяем подключение обработки транспорта сообщений обмена
	ОбменДаннымиСервер.ПроверитьПодключениеОбработкиТранспортаСообщенийОбмена(Отказ,
			ЗначениеИзСтрокиВнутр(СтруктураНастроекСтрокой),
			Перечисления.ВидыТранспортаСообщенийОбмена[ВидТранспортаСтрокой],
			СообщениеОбОшибке
	);
	
	Если Отказ Тогда
		Возврат Ложь;
	КонецЕсли;
	
	// Проверяем подключение к управляющему приложению через WEB-сервис
	Попытка
		ОбменДаннымиВМоделиСервисаПовтИсп.ПолучитьWSПроксиСервисаОбмена();
	Исключение
		СообщениеОбОшибке = КраткоеПредставлениеОшибки(ИнформацияОбОшибке());
		Возврат Ложь;
	КонецПопытки;
	
	Возврат Истина;
КонецФункции
