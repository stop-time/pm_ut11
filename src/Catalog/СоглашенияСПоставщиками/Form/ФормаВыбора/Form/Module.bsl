﻿////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Список.Параметры.УстановитьЗначениеПараметра("ДатаДокумента", ?(ЗначениеЗаполнено(Параметры.ДатаДокумента), НачалоДня(Параметры.ДатаДокумента), НачалоДня(ТекущаяДата())));
	Список.Параметры.УстановитьЗначениеПараметра("ДоступноДляЗакупки", ?(ЗначениеЗаполнено(Параметры.ДоступноДляЗакупки), Параметры.ДоступноДляЗакупки, Ложь));
	Если Параметры.Отбор.Свойство("Партнер") Тогда
		Партнер = Параметры.Отбор.Партнер;
	КонецЕсли;
	Если Параметры.Отбор.Свойство("ХозяйственнаяОперация") Тогда
		ХозяйственнаяОперация = Параметры.Отбор.ХозяйственнаяОперация;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	
	Менеджер      = Настройки.Получить("Менеджер");
	Организация   = Настройки.Получить("Организация");
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(Список.Отбор, "Менеджер", Менеджер, ВидСравненияКомпоновкиДанных.Равно,, ЗначениеЗаполнено(Менеджер));
	
	МассивОрганизаций = Новый Массив();
	МассивОрганизаций.Добавить(Организация);
	МассивОрганизаций.Добавить(ПредопределенноеЗначение("Справочник.Организации.ПустаяСсылка"));
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(Список.Отбор, "Организация", МассивОрганизаций, ВидСравненияКомпоновкиДанных.ВСписке,, ЗначениеЗаполнено(Организация));
	
КонецПроцедуры

//////////////////////////////////////////////////////////////////////////////////
//// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ УПРАВЛЕНИЯ ФОРМЫ

&НаКлиенте
Процедура ОрганизацияПриИзменении(Элемент)
	
	МассивОрганизаций = Новый Массив();
	МассивОрганизаций.Добавить(Организация);
	МассивОрганизаций.Добавить(ПредопределенноеЗначение("Справочник.Организации.ПустаяСсылка"));
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(Список.Отбор, "Организация", МассивОрганизаций, ВидСравненияКомпоновкиДанных.ВСписке,, ЗначениеЗаполнено(Организация));
	
КонецПроцедуры

&НаКлиенте
Процедура МенеджерПриИзменении(Элемент)
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(Список.Отбор, "Менеджер", Менеджер, ВидСравненияКомпоновкиДанных.Равно,, ЗначениеЗаполнено(Менеджер));
	
КонецПроцедуры

&НаКлиенте
Процедура СписокПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа)
	
	Если Копирование Тогда
		Возврат;
	КонецЕсли;

	Отказ = Истина;
	
	ПараметрыОтбора = Новый Структура();
	ПараметрыОтбора.Вставить("Организация", Организация);
	ПараметрыОтбора.Вставить("Партнер", Партнер);
	Если ЗначениеЗаполнено(ХозяйственнаяОперация) Тогда
		ПараметрыОтбора.Вставить("ХозяйственнаяОперация", ХозяйственнаяОперация);
	КонецЕсли;
	
	ОткрытьФорму(
		"Справочник.СоглашенияСПоставщиками.ФормаОбъекта",
		Новый Структура("ЗначенияЗаполнения", ПараметрыОтбора),
		,
		,
	);
	
КонецПроцедуры

