﻿
////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ПоказыватьНедействительныхПользователей = Ложь;
	
	Если Не Параметры.РежимВыбора Тогда
		
		// только если не режим выбора, делаем фильтрацию
		
		Если ПоказыватьНедействительныхПользователей Тогда
			ОбщегоНазначенияКлиентСервер.УдалитьЭлементыГруппыОтбора(ПользователиСписок.Отбор, "Недействителен");
		Иначе	
			ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(
				ПользователиСписок.Отбор,
				"Недействителен",
				Ложь);
		КонецЕсли;
			
	КонецЕсли;
	
	ИспользоватьГруппы = ПолучитьФункциональнуюОпцию("ИспользоватьГруппыПользователей");
	
	Если ТипЗнч(Параметры.ТекущаяСтрока) = Тип("СправочникСсылка.ГруппыПользователей") Тогда
		Если ИспользоватьГруппы Тогда
			Элементы.ГруппыПользователей.ТекущаяСтрока = Параметры.ТекущаяСтрока;
		Иначе
			Параметры.ТекущаяСтрока = Неопределено;
		КонецЕсли;
	Иначе
		ТекущийЭлемент = Элементы.ПользователиСписок;
		Элементы.ГруппыПользователей.ТекущаяСтрока = Справочники.ГруппыПользователей.ВсеПользователи;
		ОбновитьЗначениеПараметраКомпоновкиДанных(ПользователиСписок, "ГруппаПользователей", Справочники.ГруппыПользователей.ВсеПользователи);
		ОбновитьЗначениеПараметраКомпоновкиДанных(ПользователиСписок, "ВыбиратьИерархически", Истина);
	КонецЕсли;
	
	// Настройка постоянных данных для списка пользователей
	ОбновитьЗначениеПараметраКомпоновкиДанных(ПользователиСписок, "ПустойУникальныйИдентификатор", Новый УникальныйИдентификатор("00000000-0000-0000-0000-000000000000"));
	ГруппаПользователейВсеПользователи = Справочники.ГруппыПользователей.ВсеПользователи;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ОбновитьСодержимоеФормыПриИзмененииГруппы();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "Запись_ГруппыПользователей" Тогда
		Если Источник = Элементы.ГруппыПользователей.ТекущаяСтрока Тогда
			Элементы.ПользователиСписок.Обновить();
		КонецЕсли;
	КонецЕсли;
	
	Если ИмяСобытия = "Запись_НастройкиПродажДляПользователей" Тогда
		Элементы.ПользователиСписок.Обновить();
		Элементы.ГруппыПользователей.Обновить();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	
	Если Настройки[ВыбиратьИерархически] = Неопределено Тогда
		ВыбиратьИерархически = Истина;
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ШАПКИ ФОРМЫ

&НаКлиенте
Процедура ГруппыПользователейПриАктивизацииСтроки(Элемент)
	
	ОбновитьСодержимоеФормыПриИзмененииГруппы();
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбиратьИерархическиПриИзменении(Элемент)
	
	ОбновитьСодержимоеФормыПриИзмененииГруппы();
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ТАБЛИЦЫ ФОРМЫ ГРУППЫ ПОЛЬЗОВАТЕЛЕЙ

&НаКлиенте
Процедура ГруппыПользователейВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Поле = Элементы.ГруппыПользователейПроцентРучнойСкидки
		ИЛИ Поле = Элементы.ГруппыПользователейПроцентРучнойНаценки Тогда
		
		СтандартнаяОбработка = Ложь;
		ТекущиеДанные = Элементы.ГруппыПользователей.ТекущиеДанные;
		
		Ссылка = НастройкиПродажДляПользователейВызовСервера.НастройкаОграниченийПоОбъекту(ТекущиеДанные.Ссылка);
		Если Ссылка = Неопределено Тогда
			ПараметрыФормы = Новый Структура("ЗначенияЗаполнения", Новый Структура("Владелец", ТекущиеДанные.Ссылка));
		Иначе
			ПараметрыФормы = Новый Структура("Ключ", Ссылка);
		КонецЕсли;
		ОткрытьФорму("Справочник.НастройкиПродажДляПользователей.Форма.ФормаЭлемента", ПараметрыФормы);
		
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ТАБЛИЦЫ ФОРМЫ ПОЛЬЗОВАТЕЛИ СПИСОК

&НаКлиенте
Процедура ПользователиСписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Поле = Элементы.ПроцентРучнойСкидки
		ИЛИ Поле = Элементы.ПроцентРучнойНаценки Тогда
		
		СтандартнаяОбработка = Ложь;
		ТекущиеДанные = Элементы.ПользователиСписок.ТекущиеДанные;
		
		Ссылка = НастройкиПродажДляПользователейВызовСервера.НастройкаОграниченийПоОбъекту(ТекущиеДанные.Ссылка);
		Если Ссылка = Неопределено Тогда
			ПараметрыФормы = Новый Структура("ЗначенияЗаполнения", Новый Структура("Владелец", ТекущиеДанные.Ссылка));
		Иначе
			ПараметрыФормы = Новый Структура("Ключ", Ссылка);
		КонецЕсли;
		ОткрытьФорму("Справочник.НастройкиПродажДляПользователей.Форма.ФормаЭлемента", ПараметрыФормы);
		
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ КОМАНД ФОРМЫ

&НаКлиенте
Процедура ПоказыватьНедействительныхПользователей(Команда)
	
	ПоказыватьНедействительныхПользователей = Не ПоказыватьНедействительныхПользователей;
	
	Элементы.ФормаПоказыватьНедействительныхПользователей.Пометка = ПоказыватьНедействительныхПользователей;
	
	Если ПоказыватьНедействительныхПользователей Тогда
		ОбщегоНазначенияКлиентСервер.УдалитьЭлементыГруппыОтбора(ПользователиСписок.Отбор, "Недействителен");
	Иначе	
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(
			ПользователиСписок.Отбор,
			"Недействителен",
			Ложь);
	КонецЕсли;
		
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

////////////////////////////////////////////////////////////////////////////////
// Прочее

&НаКлиенте
Процедура ОбновитьСодержимоеФормыПриИзмененииГруппы()
	
	Если НЕ ИспользоватьГруппы
	 ИЛИ Элементы.ГруппыПользователей.ТекущаяСтрока = ГруппаПользователейВсеПользователи Тогда
		//
		Элементы.ГруппаПоказыватьПользователейДочернихГрупп.ТекущаяСтраница = Элементы.ГруппаНельзяУстановитьСвойство;
		ОбновитьЗначениеПараметраКомпоновкиДанных(ПользователиСписок, "ВыбиратьИерархически", Истина);
		ОбновитьЗначениеПараметраКомпоновкиДанных(ПользователиСписок, "ГруппаПользователей", ГруппаПользователейВсеПользователи);
	Иначе
		Элементы.ГруппаПоказыватьПользователейДочернихГрупп.ТекущаяСтраница = Элементы.ГруппаУстановитьСвойство;
		ОбновитьЗначениеПараметраКомпоновкиДанных(ПользователиСписок, "ВыбиратьИерархически", ВыбиратьИерархически);
		ОбновитьЗначениеПараметраКомпоновкиДанных(ПользователиСписок, "ГруппаПользователей", Элементы.ГруппыПользователей.ТекущаяСтрока);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ОбновитьЗначениеПараметраКомпоновкиДанных(Знач ВладелецПараметров, Знач ИмяПараметра, Знач ЗначениеПараметра)
	
	Для каждого Параметр Из ВладелецПараметров.Параметры.Элементы Цикл
		Если Строка(Параметр.Параметр) = ИмяПараметра Тогда
			Если Параметр.Использование И Параметр.Значение = ЗначениеПараметра Тогда
				Возврат;
			КонецЕсли;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	ВладелецПараметров.Параметры.УстановитьЗначениеПараметра(ИмяПараметра, ЗначениеПараметра);
	
КонецПроцедуры





