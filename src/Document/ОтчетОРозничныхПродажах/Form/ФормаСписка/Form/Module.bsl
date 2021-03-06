﻿
////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ОбщегоНазначенияУТ.НастроитьПодключаемоеОборудование(ЭтаФорма);
	
	// Обработчик подсистемы "Внешние обработки"
	ДополнительныеОтчетыИОбработки.ПриСозданииНаСервере(ЭтаФорма);
	
	КассаККМЗаполнена = ЗначениеЗаполнено(КассаККМ);
	
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ОтчетыОРозничныхПродажахСоздать", "Доступность", НЕ ЗапрещеноДобавлятьНовыеДокументы И КассаККМЗаполнена);
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ОтчетыОРозничныхПродажахСкопировать", "Доступность", НЕ ЗапрещеноДобавлятьНовыеДокументы И КассаККМЗаполнена);
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "КонтекстноеМенюОтчетыОРозничныхПродажахСоздать", "Доступность", НЕ ЗапрещеноДобавлятьНовыеДокументы И КассаККМЗаполнена);
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "КонтекстноеМенюОтчетыОРозничныхПродажахСкопировать", "Доступность", НЕ ЗапрещеноДобавлятьНовыеДокументы И КассаККМЗаполнена);
	
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
	
	Если ИмяСобытия = "Запись_ОтчетОРозничныхПродажах" Тогда
		
		Элементы.ОтчетыОРозничныхПродажах.Обновить();
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	
	КассаККМ = Настройки.Получить("КассаККМ");
	УстановитьОтборДинамическихСписков();
	
	ЗапрещеноДобавлятьНовыеДокументы = ЗапрещеноДобавлятьНовыеДокументы(КассаККМ);
	
	КассаККМЗаполнена = ЗначениеЗаполнено(КассаККМ);
	
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ОтчетыОРозничныхПродажахСоздать", "Доступность", НЕ ЗапрещеноДобавлятьНовыеДокументы И КассаККМЗаполнена);
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ОтчетыОРозничныхПродажахСкопировать", "Доступность", НЕ ЗапрещеноДобавлятьНовыеДокументы И КассаККМЗаполнена);
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "КонтекстноеМенюОтчетыОРозничныхПродажахСоздать", "Доступность", НЕ ЗапрещеноДобавлятьНовыеДокументы И КассаККМЗаполнена);
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "КонтекстноеМенюОтчетыОРозничныхПродажахСкопировать", "Доступность", НЕ ЗапрещеноДобавлятьНовыеДокументы И КассаККМЗаполнена);
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ШАПКИ ФОРМЫ

&НаКлиенте
Процедура КассаОтборПриИзменении(Элемент)
	
	УстановитьОтборДинамическихСписковНаКлиенте();
	УстановитьДоступностьКнопокСозданияНовыхДокументов();
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ТАБЛИЦЫ ФОРМЫ  ОтчетыОРозничныхПродажах

&НаКлиенте
Процедура ОтчетыОРозничныхПродажахПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа)
	
	КассаККМЗаполнена = ЗначениеЗаполнено(КассаККМ);
	Отказ = Не(Не ЗапрещеноДобавлятьНовыеДокументы И КассаККМЗаполнена);
	
КонецПроцедуры

///////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

////////////////////////////////////////////////////////////////////////////////
// Штрихкоды и торговое оборудование

&НаКлиенте
Процедура ОбработатьШтрихкоды(Данные)
	
	МассивСсылок = СсылкаНаЭлементСпискаПоШтрихкоду(Данные.Штрихкод);
	Если МассивСсылок.Количество() > 0 Тогда
		Элементы.ОтчетыОРозничныхПродажах.ТекущаяСтрока = МассивСсылок[0];
		ОткрытьЗначение(МассивСсылок[0]);
	Иначе
		ШтрихкодированиеПечатныхФормКлиент.ОбъектНеНайден(Данные.Штрихкод);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Функция СсылкаНаЭлементСпискаПоШтрихкоду(Штрихкод)
	
	Менеджеры = Новый Массив();
	Менеджеры.Добавить(ПредопределенноеЗначение("Документ.ОтчетОРозничныхПродажах.ПустаяСсылка"));
	Возврат ШтрихкодированиеПечатныхФормКлиент.ПолучитьСсылкуПоШтрихкодуТабличногоДокумента(Штрихкод, Менеджеры);
	
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// Прочее

&НаСервереБезКонтекста
Функция ЗапрещеноДобавлятьНовыеДокументы(КассаККМ)
	
	Реквизиты = Справочники.КассыККМ.РеквизитыКассыККМ(КассаККМ);
	Возврат Реквизиты.ТипКассы = Перечисления.ТипыКассККМ.ФискальныйРегистратор
	    ИЛИ Реквизиты.ТипКассы = Перечисления.ТипыКассККМ.ККМOffline;
	
КонецФункции

// Так же вызывается ПриЗагрузкеДанныхИзНастроекНаСервере
&НаКлиенте
Процедура УстановитьДоступностьКнопокСозданияНовыхДокументов()
	
	ЗапрещеноДобавлятьНовыеДокументы = ЗапрещеноДобавлятьНовыеДокументы(КассаККМ);
	
	КассаККМЗаполнена = ЗначениеЗаполнено(КассаККМ);
	
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ОтчетыОРозничныхПродажахСоздать", "Доступность", НЕ ЗапрещеноДобавлятьНовыеДокументы И КассаККМЗаполнена);
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ОтчетыОРозничныхПродажахСкопировать", "Доступность", НЕ ЗапрещеноДобавлятьНовыеДокументы И КассаККМЗаполнена);
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "КонтекстноеМенюОтчетыОРозничныхПродажахСоздать", "Доступность", НЕ ЗапрещеноДобавлятьНовыеДокументы И КассаККМЗаполнена);
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "КонтекстноеМенюОтчетыОРозничныхПродажахСкопировать", "Доступность", НЕ ЗапрещеноДобавлятьНовыеДокументы И КассаККМЗаполнена);
	
КонецПроцедуры

// Процедура устанавливает отбор динамических списков формы.
//
&НаСервере
Процедура УстановитьОтборДинамическихСписков()
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(ОтчетыОРозничныхПродажах.Отбор, "КассаККМ", КассаККМ, ВидСравненияКомпоновкиДанных.Равно,, ЗначениеЗаполнено(КассаККМ));
	
КонецПроцедуры

// Процедура устанавливает отбор динамических списков формы.
//
&НаКлиенте
Процедура УстановитьОтборДинамическихСписковНаКлиенте()
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(ОтчетыОРозничныхПродажах.Отбор, "КассаККМ", КассаККМ, ВидСравненияКомпоновкиДанных.Равно,, ЗначениеЗаполнено(КассаККМ));
	
КонецПроцедуры
