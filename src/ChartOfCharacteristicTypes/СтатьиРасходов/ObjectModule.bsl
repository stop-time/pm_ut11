﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

///////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("Структура")
	 И ДанныеЗаполнения.Свойство("ВариантРаспределенияРасходов") Тогда
	 
		Если ДанныеЗаполнения.ВариантРаспределенияРасходов = Перечисления.ВариантыРаспределенияРасходов.НаСебестоимостьТоваров Тогда
			ТипЗначения = Новый ОписаниеТипов("СправочникСсылка.Склады");
		ИначеЕсли ДанныеЗаполнения.ВариантРаспределенияРасходов = Перечисления.ВариантыРаспределенияРасходов.НаПроизводственныеЗатраты Тогда
			ТипЗначения = Новый ОписаниеТипов("СправочникСсылка.СтруктураПредприятия");
		КонецЕсли;
	 
	КонецЕсли;
	
	Если ТипЗначения.Типы().Количество() > 1 Тогда
		ТипЗначения = Новый ОписаниеТипов("СправочникСсылка.Организации");
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Если Предопределенный Тогда
		
		Если ВариантРаспределенияРасходов <> Перечисления.ВариантыРаспределенияРасходов.НаНаправленияДеятельности Тогда
			ТекстСообщения = НСтр("ru = 'Необходимо выбрать вариант распределения ""На направления деятельности""'");
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
				ТекстСообщения,
				ЭтотОбъект,
				"ВариантРаспределенияРасходов",
				,
				Отказ
			);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если Не ЭтоГруппа Тогда
		
		ЭтоПрочиеРасходы = (ТипЗначения.СодержитТип(Тип("СправочникСсылка.ПрочиеРасходы")));
		Если ПрочиеРасходы <> ЭтоПрочиеРасходы Тогда
			ПрочиеРасходы = ЭтоПрочиеРасходы;
		КонецЕсли;
		
		Если ВариантРаспределенияРасходов <> Перечисления.ВариантыРаспределенияРасходов.НаНаправленияДеятельности Тогда
			КорреспондирующийСчет = "";
		КонецЕсли;
		
		Если Не ПустаяСтрока(КорреспондирующийСчет) Тогда
			Если ПустаяСтрока(СтрЗаменить(КорреспондирующийСчет, ".", "")) Тогда
				КорреспондирующийСчет = "";
			ИначеЕсли Прав(СокрЛП(КорреспондирующийСчет), 1) = "." Тогда
				КорреспондирующийСчет = Лев(СокрЛП(КорреспондирующийСчет), СтрДлина(СокрЛП(КорреспондирующийСчет)) - 1);
			КонецЕсли;
		КонецЕсли;
		
		Если Не ОграничитьИспользование
		 И ДоступныеХозяйственныеОперации.Количество() > 0 Тогда
			ДоступныеХозяйственныеОперации.Очистить();
			ДоступныеОперации = "";
		Иначе
			СписокОпераций = Новый СписокЗначений;
			ПланыВидовХарактеристик.СтатьиРасходов.ЗаполнитьСписокХозяйственныхОпераций(СписокОпераций);
			СтрокаДоступныеОперации = "";
			Для Каждого СтрокаТаблицы Из ДоступныеХозяйственныеОперации Цикл
				ЭлементСписка = СписокОпераций.НайтиПоЗначению(СтрокаТаблицы.ХозяйственнаяОперация);
				Если ЭлементСписка <> Неопределено Тогда
					СтрокаДоступныеОперации = СтрокаДоступныеОперации
						+ ?(Не ПустаяСтрока(СтрокаДоступныеОперации), ", ", "")
						+ ЭлементСписка.Представление;
				КонецЕсли;
			КонецЦикла;
			Если ДоступныеОперации <> СтрокаДоступныеОперации Тогда
				ДоступныеОперации = СтрокаДоступныеОперации;
			КонецЕсли;
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецЕсли
