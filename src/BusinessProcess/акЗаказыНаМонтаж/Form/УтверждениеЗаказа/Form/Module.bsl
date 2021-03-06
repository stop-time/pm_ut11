﻿////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	НачальныйПризнакВыполнения = Объект.Выполнена;
	ЗадачаОбъект = РеквизитФормыВЗначение("Объект");
	ЗаданиеОбъект = ЗадачаОбъект.БизнесПроцесс.ПолучитьОбъект();
	ЗначениеВРеквизитФормы(ЗаданиеОбъект, "Задание");

	ИспользоватьДатуИВремяВСрокахЗадач = ПолучитьФункциональнуюОпцию("ИспользоватьДатуИВремяВСрокахЗадач");
	Элементы.СрокИсполненияВремя.Видимость = ИспользоватьДатуИВремяВСрокахЗадач;
	Элементы.СрокНачалаИсполненияВремя.Видимость = ИспользоватьДатуИВремяВСрокахЗадач;
	Элементы.ДатаИсполнения.Формат = ?(ИспользоватьДатуИВремяВСрокахЗадач, "ДЛФ=DT", "ДЛФ=D");

	БизнесПроцессыИЗадачиСервер.ФормаЗадачиПриСозданииНаСервере(
		ЭтаФорма, Объект, Элементы.ГруппаСостояние, Элементы.ДатаИсполнения
	);
	
	
КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ КОМАНД ФОРМЫ

&НаКлиенте
Процедура ЗаписатьИЗакрытьВыполнить()
	БизнесПроцессыИЗадачиКлиент.ЗаписатьИЗакрытьВыполнить(ЭтаФорма);
КонецПроцедуры


// ЭТАП УТВЕРЖДЕНИЕ

&НаКлиенте
Процедура ВыполненоВыполнить()
	Если ВыполнитьЗадачу() тогда
		БизнесПроцессыИЗадачиКлиент.ЗаписатьИЗакрытьВыполнить(ЭтаФорма,ИСТИНА,Новый Структура("ЗаказКлиента",Задание.ЗаказКлиента));
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура Отклонить(Команда)
	Если Не ПустаяСтрока(Объект.РезультатВыполнения) тогда
		ОтклонитьЗадачу();
	Иначе
		Сообщить("Не заполнен результат выполнения");
		Возврат;
	КонецЕсли;
	БизнесПроцессыИЗадачиКлиент.ЗаписатьИЗакрытьВыполнить(ЭтаФорма,ИСТИНА,Новый Структура("ЗаказКлиента",Задание.ЗаказКлиента));
КонецПроцедуры

&НаСервере
Функция  ВыполнитьЗадачу()
	Если Не ЗначениеЗаполнено(Задание.ЗаказКлиента.ДатаОтгрузки) тогда
		Сообщить("Не заполнена дата отгрузки для заказа, невозможно определить плановую дату доставки");
		Возврат ЛОЖЬ;	
	КонецЕсли;
	
	ЗадачаОбъект = РеквизитФормыВЗначение("Объект");
	ЗаданиеОбъект = ЗадачаОбъект.БизнесПроцесс.ПолучитьОбъект();	
	ЗаданиеОбъект.ЗаказУтвержден = Истина;
	ЗаданиеОбъект.Записать();
	Возврат ИСТИНА;
КонецФункции

&НаСервере
Процедура ОтклонитьЗадачу()
	ЗадачаОбъект = РеквизитФормыВЗначение("Объект");
	ЗаданиеОбъект = ЗадачаОбъект.БизнесПроцесс.ПолучитьОбъект();	
	ЗаданиеОбъект.Комментарий = Объект.РезультатВыполнения;
	ЗаданиеОбъект.Записать();
	
	ЗаказОбъект = Задание.ЗаказКлиента.ПолучитьОбъект();
	ЗаказОбъект.Статус = Перечисления.СтатусыЗаказовКлиентов.Согласован;
	Попытка
		ЗаказОбъект.Записать(РежимЗаписиДокумента.Проведение);
	Исключение
		ЗаказОбъект.Записать(РежимЗаписиДокумента.Запись);
	КонецПопытки;
КонецПроцедуры




