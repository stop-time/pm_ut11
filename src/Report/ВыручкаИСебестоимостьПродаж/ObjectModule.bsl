﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда


///////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)

	СегментыСервер.ВключитьОтборПоСегментуПартнеровВСКД(КомпоновщикНастроек);
	СегментыСервер.ВключитьОтборПоСегментуНоменклатурыВСКД(КомпоновщикНастроек);

	СтандартнаяОбработка = Ложь;
	
	Параметр = НастройкаПараметра("ПоказыватьПродажи");
	Параметр.Использование = Истина;

	ДанныеПоПродажам = НастройкаПараметра("ДанныеПоПродажам").Значение;
	Если ДанныеПоПродажам = 3 Тогда //В валюте регл. учета

		СФормироватьЗаголовкиПолей(Строка(Константы.ВалютаРегламентированногоУчета.Получить()));

	Иначе

		СФормироватьЗаголовкиПолей(Строка(Константы.ВалютаУправленческогоУчета.Получить()));

	КонецЕсли;
	
	МассивЗаголовковРесурсов = Новый Массив;
	НастройкиОтчета = КомпоновщикНастроек.ПолучитьНастройки();
	Для Каждого  ЭлементВыбора Из НастройкиОтчета.Выбор.Элементы Цикл

		Если Не ТипЗнч(ЭлементВыбора) = Тип("ВыбранноеПолеКомпоновкиДанных") Тогда
			Продолжить;
		КонецЕсли;

		Если СхемаКомпоновкиданных.ПоляИтога.Найти(ЭлементВыбора.Поле) <> Неопределено Тогда
			Если Не ПустаяСтрока(ЭлементВыбора.Заголовок) Тогда
				МассивЗаголовковРесурсов.Добавить(ЭлементВыбора.Заголовок);
			Иначе
				ПолеНабораДанных = СхемаКомпоновкиДанных.НаборыДанных.ВыручкаИСебестоимостьПродаж.Поля.найти(ЭлементВыбора.Поле);
				Если ПолеНабораДанных <> Неопределено Тогда
					МассивЗаголовковРесурсов.Добавить(ПолеНабораДанных.Заголовок);
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;

	КонецЦикла;

	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	МакетКомпоновки = КомпоновщикМакета.Выполнить(СхемаКомпоновкиДанных, НастройкиОтчета, ДанныеРасшифровки);

	Для Каждого ТекМакет Из МакетКомпоновки.Макеты Цикл

		Если ТипЗнч(ТекМакет.Макет) <> Тип("МакетОбластиКомпоновкиДанных") Тогда
			Продолжить;
		КонецЕсли;

		Для Каждого СтрокаТаблицыКомпоновки Из ТекМакет.Макет Цикл
			Для Каждого ЯчейкаТаблицыОбластиКомпоновки Из СтрокаТаблицыКомпоновки.Ячейки Цикл
				Для Каждого Элемент Из ЯчейкаТаблицыОбластиКомпоновки.Элементы Цикл
					Если МассивЗаголовковРесурсов.Найти(Элемент.Значение) <> Неопределено Тогда

						Параметр = ЯчейкаТаблицыОбластиКомпоновки.Оформление.Элементы.Найти(Новый ПараметрКомпоновкиДанных("ГоризонтальноеПоложение"));
						Параметр.Значение = ГоризонтальноеПоложение.Центр;
						Параметр.Использование = Истина;

					КонецЕсли;
				КонецЦикла;
			КонецЦикла;
		КонецЦикла;

	КонецЦикла;

	//Создадим и инициализируем процессор компоновки
	ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновки.Инициализировать(МакетКомпоновки, , ДанныеРасшифровки, Истина);

	//Создадим и инициализируем процессор вывода результата
	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
	ПроцессорВывода.УстановитьДокумент(ДокументРезультат);

	//Обозначим начало вывода
	ПроцессорВывода.НачатьВывод();
	ТаблицаЗафиксирована = Ложь;

	ДокументРезультат.ФиксацияСверху = 0;
	//Основной цикл вывода отчета
	Пока Истина Цикл
		//Получим следующий элемент результата компоновки
		ЭлементРезультата = ПроцессорКомпоновки.Следующий();

		Если ЭлементРезультата = Неопределено Тогда
			//Следующий элемент не получен - заканчиваем цикл вывода
			Прервать;
		Иначе
			// Зафиксируем шапку
			Если  Не ТаблицаЗафиксирована 
				  И ЭлементРезультата.ЗначенияПараметров.Количество() > 0 
				  И ТипЗнч(КомпоновщикНастроек.Настройки.Структура[0]) <> Тип("ДиаграммаКомпоновкиДанных") Тогда

				ТаблицаЗафиксирована = Истина;
				ДокументРезультат.ФиксацияСверху = ДокументРезультат.ВысотаТаблицы;

			КонецЕсли;
			//Элемент получен - выведем его при помощи процессора вывода
			ПроцессорВывода.ВывестиЭлемент(ЭлементРезультата);
		КонецЕсли;
	КонецЦикла;

	ПроцессорВывода.ЗакончитьВывод();

КонецПроцедуры

///////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

///////////////////////////////////////////////////////////////////////////////
// Прочее

Функция НастройкаПараметра(ИмяПараметра)

	ПараметрДанных = КомпоновщикНастроек.Настройки.ПараметрыДанных.Элементы.Найти(ИмяПараметра);
	Если ПараметрДанных <> Неопределено Тогда
		ПараметрПользовательскойНастройки = КомпоновщикНастроек.ПользовательскиеНастройки.Элементы.Найти(ПараметрДанных.ИдентификаторПользовательскойНастройки);
		Если ПараметрПользовательскойНастройки <> Неопределено Тогда
			Возврат ПараметрПользовательскойНастройки;
		Иначе
			Возврат ПараметрДанных;
		КонецЕсли;
	КонецЕсли;
	Возврат Неопределено;

КонецФункции

Процедура СФормироватьЗаголовкиПолей(ПредставлениеВалюты)

	МассивПолей = Новый Массив;
	МассивПолей.Добавить("ВаловаяПрибыль");
	МассивПолей.Добавить("Выручка");
	МассивПолей.Добавить("Себестоимость");
	МассивПолей.Добавить("ДопРасходы");

	Для Каждого ПолеНабораДанных Из СхемаКомпоновкиДанных.НаборыДанных.ВыручкаИСебестоимостьПродаж.Поля Цикл
		Если ТипЗнч(ПолеНабораДанных) = Тип("ПолеНабораДанныхСхемыКомпоновкиДанных") Тогда

			Если МассивПолей.Найти(ПолеНабораДанных.Поле) <> Неопределено Тогда 
				ПолеНабораДанных.Заголовок = ПолеНабораДанных.Заголовок + " (" + ПредставлениеВалюты + ")";
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;

КонецПроцедуры




#КонецЕсли