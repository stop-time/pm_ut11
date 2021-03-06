﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда


Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	ПараметрРегистратор = ОбщегоНазначенияУТКлиентСервер.ПолучитьПараметр(КомпоновщикНастроек.ФиксированныеНастройки, "Документ");
	
	Если ПараметрРегистратор <> Неопределено Тогда
		ДокументыРасчетов = ПолучитьДокументыРасчетовСПоставщиками(ПараметрРегистратор.Значение);
		ЭлементыОтбора = ОбщегоНазначенияКлиентСервер.НайтиЭлементыИГруппыОтбора(КомпоновщикНастроек.Настройки.Отбор, "ДокументПередачи");
		Для каждого ЭлементОтбора из ЭлементыОтбора Цикл
			ЭлементОтбора.ПравоеЗначение = ДокументыРасчетов;
			ЭлементОтбора.Использование = Истина;
			Прервать;
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

Функция ПолучитьДокументыРасчетовСПоставщиками(Документ)
	
	Запрос = Новый Запрос("
		|ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
		|	Товары.ДокументРеализации КАК  ДокументРеализации
		|ИЗ
		|	Документ.ВозвратТоваровОтКлиента.Товары КАК Товары
		|ГДЕ
		|	Товары.Ссылка В (&Документ)
		|ОБЪЕДИНИТЬ ВСЕ
		|ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	Товары.ДокументРеализации КАК  ДокументРеализации
		|ИЗ
		|	Документ.ВыкупВозвратнойТарыКлиентом.Товары КАК Товары
		|ГДЕ
		|	Товары.Ссылка В (&Документ)
		|ОБЪЕДИНИТЬ ВСЕ
		|ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	РеализацияТоваровУслуг.Ссылка КАК  ДокументРеализации
		|ИЗ
		|	Документ.РеализацияТоваровУслуг КАК РеализацияТоваровУслуг
		|ГДЕ
		|	Товары.Ссылка В (&Документ)
		|");
		
	Если ТипЗнч(Документ) <> Тип("СписокЗначений") Тогда
		СписокДокументов = Новый СписокЗначений();
		СписокДокументов.Добавить(Документ);
	Иначе
		СписокДокументов = Документ;
	КонецЕсли;
		
	Запрос.УстановитьПараметр("Документ", СписокДокументов);
	МассивДокументов = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("ДокументРеализации");
	СписокОтбора = Новый СписокЗначений();
	СписокОтбора.ЗагрузитьЗначения(МассивДокументов);
	Возврат СписокОтбора;
	
КонецФункции
 
#КонецЕсли