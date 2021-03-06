﻿
///////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ОбщегоНазначенияУТ.НастроитьПодключаемоеОборудование(ЭтаФорма);
	
	// Обработчик подсистемы "Внешние обработки"
	ДополнительныеОтчетыИОбработки.ПриСозданииНаСервере(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	МенеджерОборудованияКлиент.ПодключитьОборудованиеПриОткрытииФормы(ЭтаФорма, "СканерШтрихкода");
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	
	МенеджерОборудованияКлиент.ОтключитьОборудованиеПриЗакрытииФормы(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// ПодключаемоеОборудование
	Если Источник = "ПодключаемоеОборудование" И ВводДоступен() Тогда
		Если ИмяСобытия = "ScanData" Тогда
			ОбработатьШтрихкоды(МенеджерОборудованияКлиент.ПреобразоватьДанныеСоСканераВСтруктуру(Параметр));
		КонецЕсли;
	КонецЕсли;
	// Конец ПодключаемоеОборудование
	
КонецПроцедуры

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	
	Организация     = Настройки.Получить("Организация");
	ПодотчетноеЛицо = Настройки.Получить("ПодотчетноеЛицо");
	Валюта          = Настройки.Получить("Валюта");
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(Список.Отбор, "Организация", Организация, ВидСравненияКомпоновкиДанных.Равно,, ЗначениеЗаполнено(Организация));
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(Список.Отбор, "ПодотчетноеЛицо", ПодотчетноеЛицо, ВидСравненияКомпоновкиДанных.Равно,, ЗначениеЗаполнено(ПодотчетноеЛицо));
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(Список.Отбор, "Валюта", Валюта, ВидСравненияКомпоновкиДанных.Равно,, ЗначениеЗаполнено(Валюта));
	
	УстановитьВидимость();
	
КонецПроцедуры

///////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ШАПКИ ФОРМЫ

&НаКлиенте
Процедура ОрганизацияОтборПриИзменении(Элемент)
	
	ОрганизацияОтборПриИзмененииСервер();
	
КонецПроцедуры

&НаКлиенте
Процедура ПодотчетноеЛицоОтборПриИзменении(Элемент)
	
	ПодотчетноеЛицоОтборПриИзмененииСервер();
	
КонецПроцедуры

&НаКлиенте
Процедура ВалютаОтборПриИзменении(Элемент)
	
	ВалютаОтборПриИзмененииСервер();
	
КонецПроцедуры

///////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

///////////////////////////////////////////////////////////////////////////////
// При изменении реквизитов

&НаСервере
Процедура ОрганизацияОтборПриИзмененииСервер()
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(Список.Отбор, "Организация", Организация, ВидСравненияКомпоновкиДанных.Равно,, ЗначениеЗаполнено(Организация));
	УстановитьВидимость();
	
КонецПроцедуры

&НаСервере
Процедура ПодотчетноеЛицоОтборПриИзмененииСервер()
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(Список.Отбор, "ПодотчетноеЛицо", ПодотчетноеЛицо, ВидСравненияКомпоновкиДанных.Равно,, ЗначениеЗаполнено(ПодотчетноеЛицо));
	УстановитьВидимость();
	
КонецПроцедуры

&НаСервере
Процедура ВалютаОтборПриИзмененииСервер()
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(Список.Отбор, "Валюта", Валюта, ВидСравненияКомпоновкиДанных.Равно,, ЗначениеЗаполнено(Валюта));
	УстановитьВидимость();
	
КонецПроцедуры

///////////////////////////////////////////////////////////////////////////////
// Штрихкоды и торговое оборудование

&НаКлиенте
Функция СсылкаНаЭлементСпискаПоШтрихкоду(Штрихкод)
	
	Менеджеры = Новый Массив();
	Менеджеры.Добавить(ПредопределенноеЗначение("Документ.АвансовыйОтчет.ПустаяСсылка"));
	Возврат ШтрихкодированиеПечатныхФормКлиент.ПолучитьСсылкуПоШтрихкодуТабличногоДокумента(Штрихкод, Менеджеры);
	
КонецФункции

&НаКлиенте
Процедура ОбработатьШтрихкоды(Данные)
	
	МассивСсылок = СсылкаНаЭлементСпискаПоШтрихкоду(Данные.Штрихкод);
	Если МассивСсылок.Количество() > 0 Тогда
		Элементы.Список.ТекущаяСтрока = МассивСсылок[0];
		ОткрытьЗначение(МассивСсылок[0]);
	Иначе
		ШтрихкодированиеПечатныхФормКлиент.ОбъектНеНайден(Данные.Штрихкод);
	КонецЕсли;
	
КонецПроцедуры

///////////////////////////////////////////////////////////////////////////////
// Прочее

&НаСервере
Процедура УстановитьВидимость()
	
	Элементы.Организация.Видимость = Не ЗначениеЗаполнено(Организация);
	Элементы.ПодотчетноеЛицо.Видимость = Не ЗначениеЗаполнено(ПодотчетноеЛицо);
	Элементы.Валюта.Видимость = Не ЗначениеЗаполнено(Валюта);
	
КонецПроцедуры
