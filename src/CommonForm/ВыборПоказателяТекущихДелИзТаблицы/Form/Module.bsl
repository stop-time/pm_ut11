﻿////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ДобавляемыеРеквизиты = ПолучитьМассивДобавляемыхРеквизитов(Параметры.Показатель, Параметры.ПоляТаблицы);
	ИзменитьРеквизиты(ДобавляемыеРеквизиты);
	
	ТаблицаДанных = ПолучитьТаблицуДанныхПоказателя(Параметры.ПоляТаблицы, Параметры.ДанныеТаблицы);
	ЗначениеВРеквизитФормы(ТаблицаДанных, Параметры.Показатель);
	
	СоздатьТаблицуПоказателей(Параметры.Показатель, Параметры.Группа, Параметры.ПоляТаблицы, Параметры.ДанныеТаблицы);
	
	Заголовок = Параметры.Заголовок;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ УПРАВЛЕНИЯ ФОРМЫ

&НаКлиенте
Процедура Подключаемый_ОбработатьВыборТабличногоПоказателя(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ОбработатьВыборТабличногоПоказателя(Элемент, ВыбраннаяСтрока, Поле);
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ, ИСПОЛНЯЕМЫЕ НА КЛИЕНТЕ

// Выполняет обработку выбора для табличного показателя в форме
//
// Параметры:
//  Элемент - таблица-показатель, для которого требуется обработать выбор
//  СтрокаТаблицы - выбранная строка таблицы
//  КолонкаТаблицы - выбранная колонка таблицы
//
&НаКлиенте
Процедура ОбработатьВыборТабличногоПоказателя(Элемент, СтрокаТаблицы, КолонкаТаблицы)

	ИмяПоказателя = Элемент.Имя;
	Группа 		  = Элементы[ИмяПоказателя].Родитель;
	
	Если Группа = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ДанныеСтрокиТаблицы = Элемент.ДанныеСтроки(СтрокаТаблицы);
	
	СтруктураПараметров = ТекущиеДелаКлиент.ПолучитьСтруктуруПараметровФормы(ИмяПоказателя, ДанныеСтрокиТаблицы);
	ИмяОткрываемойФормы = ТекущиеДелаКлиент.ПолучитьИмяФормы(ИмяПоказателя, Группа.Имя);
	
	Если ИмяОткрываемойФормы = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ОткрытьФорму(ИмяОткрываемойФормы, СтруктураПараметров);
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ, ИСПОЛНЯЕМЫЕ НА СЕРВЕРЕ

// Создает таблицу формы, содержащую показатели
//
// Параметры:
//  Показатель - имя-показателя
//  Группа - имя группы, в которую входит показатель
//  ПоляТаблицы - список значений, содержащий данные о полях таблицы
//  ДанныеТаблицы - список значений, содержащий данные таблицы
//
&НаСервере
Процедура СоздатьТаблицуПоказателей(Показатель, Группа, ПоляТаблицы, ДанныеТаблицы)
	
	// Добавление группы
	ГруппаПоказателя = Элементы.Добавить(Группа, Тип("ГруппаФормы"));
	ГруппаПоказателя.Вид = ВидГруппыФормы.ОбычнаяГруппа;
	ГруппаПоказателя.Отображение = ОтображениеОбычнойГруппы.Нет;
	ГруппаПоказателя.Группировка = ГруппировкаПодчиненныхЭлементовФормы.Вертикальная;
	ГруппаПоказателя.ОтображатьЗаголовок = Ложь;
	
	// Добавление таблицы формы
	Элемент = Элементы.Добавить(Показатель, Тип("ТаблицаФормы"), ГруппаПоказателя);
	Элемент.ПутьКДанным = Показатель;
	Элемент.ПоложениеКоманднойПанели = ПоложениеКоманднойПанелиЭлементаФормы.Нет;
	Элемент.ТолькоПросмотр = Истина;
	Элемент.РастягиватьПоВертикали = Истина;
	
	// Добавление колонок таблицы формы
	Для Каждого ЭлементДанных из ПоляТаблицы Цикл
		ИмяПоляТаблицы = Показатель + ЭлементДанных.Представление;
		ЭлементТаблицы = Элементы.Добавить(ИмяПоляТаблицы, Тип("ПолеФормы"), Элемент);
		ЭлементТаблицы.ПутьКДанным = Показатель + "." + ЭлементДанных.Представление;
		
		СтруктураОписанияПоля = ЭлементДанных.Значение;
		Если ЗначениеЗаполнено(СтруктураОписанияПоля.Заголовок) Тогда
			ЭлементТаблицы.Заголовок = СтруктураОписанияПоля.Заголовок;
		КонецЕсли;
			
	КонецЦикла;
		
	Элемент.УстановитьДействие("Выбор", "Подключаемый_ОбработатьВыборТабличногоПоказателя");
	
КонецПроцедуры

// Создает таблицу формы, содержащую показатели
//
// Параметры:
//  Показатель - имя-показателя
//  Группа - имя группы, в которую входит показатель
//
// Возвращаемое значение
//  Массив добавляемых реквизитов
//
&НаСервере
Функция ПолучитьМассивДобавляемыхРеквизитов(Показатель, ПоляТаблицы)
	
	Массив = Новый Массив();	
	
	РеквизитТаблица = Новый РеквизитФормы(Показатель, Новый ОписаниеТипов("ТаблицаЗначений"));
	Массив.Добавить(РеквизитТаблица);
	
	Для Каждого ЭлементДанных из ПоляТаблицы Цикл
		СтруктураОписанияПоля = ЭлементДанных.Значение;
		Массив.Добавить(Новый РеквизитФормы(ЭлементДанных.Представление, СтруктураОписанияПоля.ОписаниеТипов, Показатель));
	КонецЦикла;
	
	Возврат Массив;
	
КонецФункции

// Возвращает таблицу значений, содержащую данные показателей
//
// Параметры:
//  Поля таблицы - список значений, содержащий данные о полях таблицы
//  Данные таблицы - список значений, содержащий данные для таблицы показателей
//
// Возвращаемое значение
//  Таблица значений, содержащая данные показателей
//
&НаСервере
Функция ПолучитьТаблицуДанныхПоказателя(ПоляТаблицы, ДанныеТаблицы)
	
	ТаблицаЗначений = Новый ТаблицаЗначений();
	
	Для Каждого ЭлементСписка из ПоляТаблицы Цикл
		ТаблицаЗначений.Колонки.Добавить(ЭлементСписка.Представление);
	КонецЦикла;
	
	Для Каждого ЭлементДанных из ДанныеТаблицы Цикл
		
		СтруктураЗначения = ЭлементДанных.Значение;
		НоваяСтрока = ТаблицаЗначений.Добавить();
		
		Для Каждого ЭлементСтруктуры из СтруктураЗначения Цикл
			НоваяСтрока[ЭлементСтруктуры.Ключ] = ЭлементСтруктуры.Значение;
		КонецЦикла;
		
	КонецЦикла;
	
	Возврат ТаблицаЗначений;
	
КонецФункции