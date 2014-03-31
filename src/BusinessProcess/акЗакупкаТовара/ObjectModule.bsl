﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

////////////////////////////////////////////////////////////////////////////////
// ПРОГРАММНЫЙ ИНТЕРФЕЙС

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ 

////////////////////////////////////////////////////////////////////////////////
// Обработчики событий бизнес-процесса

Процедура ПередЗаписью(Отказ)
	
	// Даже в случае обмена данными делаем проверку на запись завершенного
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если Автор <> Неопределено И Не Автор.Пустая() Тогда
		АвторСтрокой = Строка(Автор);
	КонецЕсли;
	
	БизнесПроцессыИЗадачиСервер.ПроверитьПраваНаИзменениеСостоянияБизнесПроцесса(ЭтотОбъект);
		
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ ЭтоНовый() И ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка, "Предмет") <> Предмет Тогда
		ИзменитьПредметЗадач();	
	КонецЕсли;
	
КонецПроцедуры	
	
Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка) 
	
	Если ЭтоНовый() Тогда
		Автор = Пользователи.ТекущийПользователь();
		Важность = Перечисления.ВариантыВажностиЗадачи.Обычная;
		Состояние = Перечисления.СостоянияБизнесПроцессов.Активен;
		ЗаказУтвержден = Ложь;
		Исполнитель = Справочники.Пользователи.ПустаяСсылка(); // Для возможности автоподбора в незаполненном поле Исполнитель.
		Проверяющий = Справочники.Пользователи.ПустаяСсылка(); // Для возможности автоподбора в незаполненном поле Исполнитель.
	КонецЕсли;
	
	Если ДанныеЗаполнения <> Неопределено И ТипЗнч(ДанныеЗаполнения) <> Тип("Структура") 
		И ДанныеЗаполнения <> Задачи.ЗадачаИсполнителя.ПустаяСсылка() Тогда
		
			Предмет = ДанныеЗаполнения;
			Проект  = ДанныеЗаполнения.Сделка
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("Структура") Тогда
		ЗаполнитьЗначенияСвойств(ЭтотОбъект,ДанныеЗаполнения);		
	КонецЕсли;	
	
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	МассивНепроверяемыхРеквизитов = Новый Массив();
	//Если Не НаПроверке Тогда
	//	МассивНепроверяемыхРеквизитов.Добавить("Проверяющий");
	//КонецЕсли;
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов);

КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	
	ЗаказУтвержден = Ложь;
	РезультатВыполнения = "";
	ДатаЗавершения = '00010101000000';
	Состояние = Перечисления.СостоянияБизнесПроцессов.Активен;

КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Обработчики событий элементов карты маршрута

////////////////////////////////////////////////////////////////////////////////
// Проверка заполнения реквизитов в заказе клиента

Процедура ПроверитьПередСозданиемЗадач(ТочкаМаршрутаБизнесПроцесса, ФормируемыеЗадачи, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
	Если Предмет = Неопределено Или Предмет.Пустая() Тогда
		Возврат;
	КонецЕсли;

КонецПроцедуры

Процедура ПроверитьПриСозданииЗадач(ТочкаМаршрутаБизнесПроцесса, ФормируемыеЗадачи, Отказ)
	
	Для каждого Задача Из ФормируемыеЗадачи Цикл
		
		Задача.Автор = Автор;
		Задача.АвторСтрокой = Строка(Автор);
		//Если ТипЗнч(Исполнитель) = Тип("СправочникСсылка.РолиИсполнителей") Тогда
		//	Задача.РольИсполнителя = Исполнитель;
		//Иначе	
		//	Задача.Исполнитель = Исполнитель;
		//КонецЕсли;
		Задача.ДатаНачала = ТекущаяДата();
		Задача.Наименование = НаименованиеЗадачиДляПроверить();
		Задача.СрокИсполнения = СрокИсполненияЗадачиДляПроверить();
		Задача.Важность = Важность;
		Задача.Предмет = Предмет;
		
	КонецЦикла;

КонецПроцедуры

Процедура ПроверитьПриВыполнении(ТочкаМаршрутаБизнесПроцесса, Задача, Отказ)
	// Вставить содержимое обработчика.
		
	РезультатПроверки = РезультатВыполненияТочкиПроверить(Задача) + РезультатПроверки;
	Проверяющий=Задача.Исполнитель;
	Записать();	
КонецПроцедуры

Процедура ПринятПроверкаУсловия(ТочкаМаршрутаБизнесПроцесса, Результат)
	Результат = ЗаказПроверен;
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Исправление ошибок заполенения реквизитов в заказе клиента

Процедура ИсправитьПриСозданииЗадач(ТочкаМаршрутаБизнесПроцесса, ФормируемыеЗадачи, Отказ)
	Для каждого Задача Из ФормируемыеЗадачи Цикл		
		Задача.Автор = Проверяющий;
		Задача.АвторСтрокой = Строка(Автор);
		Задача.ДатаНачала = ТекущаяДата();
		Задача.Наименование = НаименованиеЗадачиДляИсправить();
		Задача.СрокИсполнения = СрокИсполненияЗадачиДляИсправить();
		Задача.Важность = Важность;
		Задача.Предмет = Предмет;
		Задача.Исполнитель = Предмет.Менеджер;
	КонецЦикла;
	
КонецПроцедуры

Процедура ИсправитьПриВыполнении(ТочкаМаршрутаБизнесПроцесса, Задача, Отказ)
	// Вставить содержимое обработчика.
	РезультатПроверки = РезультатВыполненияТочкиИсправить(Задача) + РезультатПроверки;
	Записать();		
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Создание заказов поставщиками и работа с ними

Процедура ЗаказПоставщикуПередСозданиемВложенныхБизнесПроцессов(ТочкаМаршрутаБизнесПроцесса, ФормируемыеБизнесПроцессы, Отказ)
	 Запрос	=	Новый Запрос;
	 Запрос.Текст = "ВЫБРАТЬ РАЗЛИЧНЫЕ
	                //|	НоменклатураДополнительныеРеквизиты.Ссылка   Как Номенклатура,
					|	НоменклатураДополнительныеРеквизиты.Значение КАК поставщик
	                |ИЗ
	                |	Справочник.Номенклатура.ДополнительныеРеквизиты КАК НоменклатураДополнительныеРеквизиты
	                |ГДЕ
	                |	НоменклатураДополнительныеРеквизиты.Свойство = &Производитель
	                |	И НоменклатураДополнительныеРеквизиты.Ссылка В
	                |			(ВЫБРАТЬ РАЗЛИЧНЫЕ
	                |				Товары.Номенклатура
	                |			ИЗ
	                |				Документ.ЗаказКлиента.Товары КАК Товары
	                |			ГДЕ
	                |				Товары.Ссылка = &Предмет
					|			И   Товары.Номенклатура.ВидНоменклатуры<>&ВидНоменклатуры)";
	Запрос.УстановитьПараметр("Производитель",ПланыВидовХарактеристик.ДополнительныеРеквизитыИСведения.АК_Производитель);
	Запрос.УстановитьПараметр("Предмет",Предмет);
	Запрос.УстановитьПараметр("ВидНоменклатуры",Справочники.ВидыНоменклатуры.НайтиПоНаименованию("Услуга"));

	Поставщики=Запрос.Выполнить().Выгрузить();
	
	//ВедущаяЗадачаДействия = Задачи.ЗадачаИсполнителя.СоздатьЗадачу();
	//ВедущаяЗадачаДействия.Дата = ТекущаяДата();
	//ВедущаяЗадачаДействия.БизнесПроцесс = Ссылка;
	//ВедущаяЗадачаДействия.ТочкаМаршрута = ТочкаМаршрутаБизнесПроцесса;		
	//ВедущаяЗадачаДействия.Записать();

	Если Поставщики.Количество()=0 Тогда
		//ВедущаяЗадачаДействия.Выполнена=Истина;
		//ВедущаяЗадачаДействия.Записать();
		Возврат;
	КонецЕсли;
	Поставщики.Свернуть("Поставщик");
	Для каждого строка из Поставщики Цикл
		//Если строка.Номенклатура.ВидНоменклатуры= Тогда
		//	Продолжить;
		//КонецЕсли;
		НовыйБП=БизнесПроцессы.акВыполнениеЗакупки.СоздатьБизнесПроцесс();
		ПараметрыБП=Новый Структура;
		ПараметрыБП.Вставить("ЗаказКлиента",Предмет);
		ПараметрыБП.Вставить("Автор",Проверяющий);
		ПараметрыБП.Вставить("Поставщик",Строка.Поставщик);
		ПараметрыБП.Вставить("Важность",Строка.Поставщик);
		НовыйБП.Заполнить(ПараметрыБП);		
		//НовыйБП.ВедущаяЗадача = ВедущаяЗадачаДействия.Ссылка;
		НовыйБП.Дата=ТекущаяДата();
		НовыйБП.ДатаНачала=ТекущаяДата();
		НовыйБП.Записать();
		НовыйБП.Старт();
		ФормируемыеБизнесПроцессы.Добавить(НовыйБП);
	КонецЦикла
	                                                          
КонецПроцедуры
      
Процедура ЗаказПоставщикуПриВыполнении(ТочкаМаршрутаБизнесПроцесса, Задача, Отказ)
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Переводим заказ клиента в статус к отгрузке

Процедура УстановитьКОтгрузкеПриСозданииЗадач(ТочкаМаршрутаБизнесПроцесса, ФормируемыеЗадачи, Отказ)
	
	Для каждого Задача Из ФормируемыеЗадачи Цикл
		
		Задача.Автор = Автор;
		Задача.АвторСтрокой = Строка(Автор);
		//Если ТипЗнч(Исполнитель) = Тип("СправочникСсылка.РолиИсполнителей") Тогда
		//	Задача.РольИсполнителя = Исполнитель;
		//Иначе	
		//	Задача.Исполнитель = Исполнитель;
		//КонецЕсли;
		Задача.ДатаНачала = ТекущаяДата();
		Задача.Наименование = НаименованиеЗадачиДляУстановитьКОтгрузке();
		Задача.СрокИсполнения = СрокИсполненияЗадачиДляУстановитьКОтгрузке();
		Задача.Важность = Важность;
		Задача.Предмет = Предмет;
		
	КонецЦикла;

КонецПроцедуры

Процедура УстановитьКОтгрузкеПриВыполнении(ТочкаМаршрутаБизнесПроцесса, Задача, Отказ)
	//Если ЗаказыПоставщика.Количество() = 0 тогда
	//	Отказ = Истина;
	//	Сообщить("Заказ покупателя не размещен в заказах поставщика",СтатусСообщения.Внимание);	
	//КонецЕсли;
	//
	//Для каждого ТекДокумент из ЗаказыПоставщика цикл
	//	Если  НЕ ТекДокумент.Документ.ПометкаУдаления Тогда
	//		Если ТекДокумент.Документ.Статус <> Перечисления.СтатусыЗаказовПоставщикам.Согласован тогда
	//			Отказ = Истина;
	//			Сообщить("Не установлен статус 'согласован' у документа " + ТекДокумент.Документ,СтатусСообщения.Внимание);	
	//		КонецЕсли;
	//		Если НЕ ЗначениеЗаполнено(ТекДокумент.Документ.ЖелаемаяДатаПоступления) и НЕ ЗначениеЗаполнено(ТекДокумент.Документ.ДатаПервогоПоступления) тогда
	//			Отказ = Истина;
	//			Сообщить("Не установлена дата поступления у документа " + ТекДокумент.Документ,СтатусСообщения.Внимание);	
	//		КонецЕсли;	
	//	КонецЕсли;
	//КонецЦикла;
КонецПроцедуры


Процедура ЗаказНаДоставкуПриСозданииВложенныхБизнесПроцессов(ТочкаМаршрутаБизнесПроцесса, ФормируемыеБизнесПроцессы, Отказ)
	Для каждого ТекСтр из ФормируемыеБизнесПроцессы цикл
		ТекСтр.ЗаказКлиента = ЗаказКлиента;	
	КонецЦикла;
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ	

Процедура ИзменитьПредметЗадач()

	УстановитьПривилегированныйРежим(Истина);
	НачатьТранзакцию();
	Попытка
		Запрос = Новый Запрос(
			"ВЫБРАТЬ
			|	Задачи.Ссылка КАК Ссылка
			|ИЗ
			|	Задача.ЗадачаИсполнителя КАК Задачи
			|ГДЕ
			|	Задачи.БизнесПроцесс = &БизнесПроцесс");

		Запрос.УстановитьПараметр("БизнесПроцесс", Ссылка);
		Результат = Запрос.Выполнить();
		
		Блокировка = Новый БлокировкаДанных;
		ВыборкаДетальныеЗаписи = Результат.Выбрать();
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			ЭлементБлокировки = Блокировка.Добавить("Задача.ЗадачаИсполнителя");
			ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
			ЭлементБлокировки.УстановитьЗначение("Ссылка", ВыборкаДетальныеЗаписи.Ссылка);
		КонецЦикла;
		Блокировка.Заблокировать();
		
		ВыборкаДетальныеЗаписи.Сбросить();
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			ЗадачаОбъект = ВыборкаДетальныеЗаписи.Ссылка.ПолучитьОбъект();
			ЗадачаОбъект.Предмет = Предмет;
			// Не выполняем предварительную блокировку данных для редактирования, т.к.
			// это изменение имеет более высокий приоритет над открытыми формами задач.
			ЗадачаОбъект.Записать();
		КонецЦикла;
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		ВызватьИсключение;
	КонецПопытки;

КонецПроцедуры 

Функция НаименованиеЗадачиДляПроверить()
	
	Возврат БизнесПроцессы.акЗакупкаТовара.ТочкиМаршрута.Проверить.НаименованиеЗадачи + ": Заказ клиента № " +Прав(Предмет.Номер,6);	
	
КонецФункции

Функция СрокИсполненияЗадачиДляПроверить()
	
	Возврат КонецДня(ТекущаяДата());	
	
КонецФункции

Функция НаименованиеЗадачиДляИсправить()
	
	Возврат БизнесПроцессы.акЗакупкаТовара.ТочкиМаршрута.Исправить.НаименованиеЗадачи + ": Заказ клиента № " +Прав(Предмет.Номер,6)	
	
КонецФункции

Функция СрокИсполненияЗадачиДляИсправить()
	
	Возврат КонецДня(ТекущаяДата());	
	
КонецФункции


Функция НаименованиеЗадачиДляУстановитьКОтгрузке()
	
	Возврат БизнесПроцессы.акЗакупкаТовара.ТочкиМаршрута.УстановитьКОтгрузке.НаименованиеЗадачи + ": Заказ клиента № " +Прав(Предмет.Номер,6)	
	
КонецФункции

Функция СрокИсполненияЗадачиДляУстановитьКОтгрузке()
	
	Возврат КонецДня(ТекущаяДата());	
	
КонецФункции


Функция РезультатВыполненияТочкиПроверить(Знач ЗадачаСсылка)
	
	СтрокаФормат = ?(ЗаказПроверен,
	    НСтр("ru = '%1, %2 выполнил(а) задачу:
		           |%3
		           |'"),
		НСтр("ru = '%1, %2 вернул(а) задачу:
		           |%3
		           |'"));
	ЗадачаДанные = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(ЗадачаСсылка, 
		"РезультатВыполнения,ДатаИсполнения,Исполнитель");
	Комментарий = СокрЛП(ЗадачаДанные.РезультатВыполнения);
	Комментарий = ?(ПустаяСтрока(Комментарий), "", Комментарий + Символы.ПС);
	Результат = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(СтрокаФормат, 
	              ЗадачаДанные.ДатаИсполнения,
	              ЗадачаДанные.Исполнитель,
	              Комментарий);
	
	Возврат Результат;
	
КонецФункции

Функция РезультатВыполненияТочкиИсправить(Знач ЗадачаСсылка)
	
	СтрокаФормат =  НСтр("ru = '%1, %2 выполнил(а) задачу:
		           |%3
		           |'");
	ЗадачаДанные = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(ЗадачаСсылка, 
		"РезультатВыполнения,ДатаИсполнения,Исполнитель");
	Комментарий = СокрЛП(ЗадачаДанные.РезультатВыполнения);
	Комментарий = ?(ПустаяСтрока(Комментарий), "", Комментарий + Символы.ПС);
	Результат = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(СтрокаФормат, 
	              ЗадачаДанные.ДатаИсполнения,
	              ЗадачаДанные.Исполнитель,
	              Комментарий);
	
	Возврат Результат;
	
КонецФункции




////////////////////////////////////////////////////////////////////////////////
// Инициализация и заполнение



////////////////////////////////////////////////////////////////////////////////
// Прочее	






#КонецЕсли
