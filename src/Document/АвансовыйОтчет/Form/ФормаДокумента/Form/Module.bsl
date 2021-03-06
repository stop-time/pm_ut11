﻿
///////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Обработчик механизма "ВерсионированиеОбъектов"
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтаФорма);
	
	// Обработчик подсистемы "Внешние обработки"
	ДополнительныеОтчетыИОбработки.ПриСозданииНаСервере(ЭтаФорма);
	
	ТекущаяВалюта = Объект.Валюта;
	ОстатокПерерасход = Объект.ПолученныеАвансы.Итог("Сумма") - Объект.ИтогоИзрасходовано;
	
	ПроисходитРедактирование = Ложь;
	ИспользуетсяОбменСБухгалтериейПредприятия = ПолучитьФункциональнуюОпцию("ИспользуетсяОбменСБухгалтериейПредприятия");
	ЗакупкиСервер.УстановитьРежимВыбораГруппЭлементовСклада(Элементы.Склад);
	
	Элементы.ГруппаКомментарий.Картинка = ОбщегоНазначенияУТ.ПолучитьКартинкуКомментария(Объект.Комментарий);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(РезультатВыбора, ИсточникВыбора)

	Если ИсточникВыбора.ИмяФормы = "ОбщаяФорма.ПодборПоРасчетамСПартнерами" Тогда
		ПолучитьОплатуПоставщикамИзХранилища(РезультатВыбора.АдресПлатежейВХранилище);
		РассчитатьСуммуДокумента();
		
	ИначеЕсли ИсточникВыбора.ИмяФормы = "Документ.ПоступлениеТоваровУслуг.Форма.ФормаВыбораПоступленияОтПодотчетника"
	 И (ТипЗнч(РезультатВыбора) = Тип("Структура")) Тогда
	 
		СтрокаТаблицы = Элементы.ЗакупкаЗаНаличныйРасчет.ТекущиеДанные;
		Если СтрокаТаблицы <> Неопределено Тогда
			ЗаполнитьЗначенияСвойств(СтрокаТаблицы, РезультатВыбора);
			Если Не ЗначениеЗаполнено(Объект.Склад) Тогда
				Объект.Склад = РезультатВыбора.Склад;
			КонецЕсли;
		КонецЕсли;
		РассчитатьСуммуДокумента();
		
	КонецЕсли;
	
	Если Окно <> Неопределено Тогда
		Окно.Активизировать();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// Обработчик механизма "ДатыЗапретаИзменения"
	ДатыЗапретаИзменения.ОбъектПриЧтенииНаСервере(ЭтаФорма, ТекущийОбъект);
	
	Если Объект.ИтогоПолучено <= Объект.ИтогоИзрасходовано Тогда
		Перерасход = Объект.ИтогоПолучено - Объект.ИтогоИзрасходовано;
		Остаток = 0;
	Иначе
		Перерасход = 0;
		Остаток = Объект.ИтогоПолучено - Объект.ИтогоИзрасходовано;
	КонецЕсли;
	
	Элементы.ГруппаКомментарий.Картинка = ОбщегоНазначенияУТ.ПолучитьКартинкуКомментария(Объект.Комментарий);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	Если ПараметрыЗаписи.РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда
		
		Если Остаток > 0 И Объект.ИтогоИзрасходовано <> 0 Тогда
			
			ТекстВопроса = НСтр("ru = 'Полученные авансы превышают расходы. Сумма полученных авансов будет скорректирована. Продолжить?'");
			Ответ = Вопрос(ТекстВопроса, РежимДиалогаВопрос.ДаНет, , КодВозвратаДиалога.Да);
			Если Ответ = КодВозвратаДиалога.Нет Тогда
				Отказ = Истина;
			КонецЕсли;
				
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	Элементы.ГруппаКомментарий.Картинка = ОбщегоНазначенияУТ.ПолучитьКартинкуКомментария(Объект.Комментарий);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	ОстатокПерерасход = Объект.ИтогоПолучено - Объект.ИтогоИзрасходовано;
	
КонецПроцедуры

///////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ШАПКИ ФОРМЫ

&НаКлиенте
Процедура ДатаПриИзменении(Элемент)
	
	КодОтвета = Неопределено;
	
	Для Каждого СтрокаТаблицы Из Объект.ОплатаПоставщикам Цикл
		
		Если СтрокаТаблицы.СуммаВзаиморасчетов > 0
		 И СтрокаТаблицы.ВалютаВзаиморасчетов <> Объект.Валюта Тогда
		 	
			Если КодОтвета = Неопределено Тогда
				КодОтвета = Вопрос(НСтр("ru = 'Очистить суммы взаиморасчетов?'"), РежимДиалогаВопрос.ДаНет);
			КонецЕсли;
			Если КодОтвета = КодВозвратаДиалога.Да Тогда
				СтрокаТаблицы.СуммаВзаиморасчетов = 0;
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЦикла;
	
	ДатаПриИзмененииСервер();
	
КонецПроцедуры

&НаКлиенте
Процедура ОрганизацияПриИзменении(Элемент)
	ОрганизацияПриИзмененииСервер();
КонецПроцедуры

&НаКлиенте
Процедура ВалютаПриИзменении(Элемент)
	
	// При смене валюты очистим сумму в валюте взаиморасчетов.
	Если ТекущаяВалюта <> Объект.Валюта
	   И Объект.ОплатаПоставщикам.Итог("СуммаВзаиморасчетов") <> 0
	Тогда
		Для Каждого СтрокаТаблицы Из Объект.ОплатаПоставщикам Цикл
			СтрокаТаблицы.СуммаВзаиморасчетов = 0;
			Если Не ЗначениеЗаполнено(СтрокаТаблицы.Заказ) Тогда
				СтрокаТаблицы.ВалютаВзаиморасчетов = Неопределено;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Если ТекущаяВалюта <> Объект.Валюта
	   И ЗначениеЗаполнено(ТекущаяВалюта)
	   И ЗначениеЗаполнено(Объект.Валюта)
	Тогда
		ПересчетСуммДокументаВВалюту();
	КонецЕсли;
		
	ТекущаяВалюта = Объект.Валюта;
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ПодотчетноеЛицоПриИзмененииСервер(ПодотчетноеЛицо, Подразделение)
	
	Подразделение = Справочники.ФизическиеЛица.ПодразделениеФизическогоЛица(ПодотчетноеЛицо);
	
КонецПроцедуры

&НаКлиенте
Процедура ПодотчетноеЛицоПриИзменении(Элемент)
	
	Если Не ЗначениеЗаполнено(Объект.Подразделение) Тогда
		ПодотчетноеЛицоПриИзмененииСервер(Объект.ПодотчетноеЛицо, Объект.Подразделение);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура КомментарийНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ОбщегоНазначенияКлиент.ОткрытьФормуРедактированияКомментария(Элемент.ТекстРедактирования, Объект.Комментарий, Модифицированность);
	
КонецПроцедуры

///////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ТАБЛИЦЫ ФОРМЫ ПОЛУЧЕННЫЕ АВАНСЫ

&НаКлиенте
Процедура ДокументАвансаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)

	СтандартнаяОбработка = Ложь;

	СписокПараметры = Новый Структура("Организация, ПодотчетноеЛицо, Валюта, Подразделение", 
		Объект.Организация,
		Объект.ПодотчетноеЛицо,
		Объект.Валюта,
		Объект.Подразделение
	);
	Структура = ОткрытьФормуМодально("РегистрНакопления.ДенежныеСредстваУПодотчетныхЛиц.Форма.ФормаВыбораВыданныхАвансов", СписокПараметры, Элемент);

	СтрокаТаблицы = Элементы.ПолученныеАвансы.ТекущиеДанные;
	Если СтрокаТаблицы <> Неопределено И Структура <> Неопределено Тогда
		ЗаполнитьЗначенияСвойств(СтрокаТаблицы, Структура);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПолученныеАвансыПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	РассчитатьСуммуДокумента();
	
КонецПроцедуры

&НаКлиенте
Процедура ПолученныеАвансыПослеУдаления(Элемент)
	
	РассчитатьСуммуДокумента();
	
КонецПроцедуры

///////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ТАБЛИЦЫ ФОРМЫ ОПЛАТА ПОСТАВЩИКАМ

&НаКлиенте
Процедура ОплатаПоставщикамПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	
	СтрокаТаблицы = Элементы.ОплатаПоставщикам.ТекущиеДанные;
	ФинансыКлиент.УстановитьПустуюСсылкуНаЗаказ(
		СтрокаТаблицы.Заказ,
		Ложь // ЭтоРасчетыСКлиентами
	);
	
КонецПроцедуры

&НаКлиенте
Процедура ОплатаПоставщикамПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	РассчитатьСуммуДокумента();
	
КонецПроцедуры

&НаКлиенте
Процедура ОплатаПоставщикамПослеУдаления(Элемент)
	
	РассчитатьСуммуДокумента();
	
КонецПроцедуры

&НаКлиенте
Процедура ОплатаПоставщикамПоставщикПриИзменении(Элемент)
	
	СтрокаТаблицы = Элементы.ОплатаПоставщикам.ТекущиеДанные;
	ФинансыКлиент.УстановитьПустуюСсылкуНаЗаказ(СтрокаТаблицы.Заказ, Ложь);

	Если СтрокаТаблицы = Неопределено
	 ИЛИ Не ЗначениеЗаполнено(СтрокаТаблицы.Поставщик)
	 ИЛИ ЗначениеЗаполнено(СтрокаТаблицы.Контрагент)
	Тогда
		Возврат;
	КонецЕсли;
	
	КонтрагентПоУмолчанию = ПолучитьКонтрагентаПартнераПоУмолчанию(СтрокаТаблицы.Поставщик);
	Если КонтрагентПоУмолчанию <> Неопределено Тогда
		СтрокаТаблицы.Контрагент = КонтрагентПоУмолчанию;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОплатаПоставщикамСуммаПриИзменении(Элемент)

	СтрокаТаблицы = Элементы.ОплатаПоставщикам.ТекущиеДанные;
	СтрокаТаблицы.СуммаВзаиморасчетов = 0;
	
КонецПроцедуры

&НаКлиенте
Процедура ОплатаПоставщикамЗаказНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтрокаТаблицы = Элементы.ОплатаПоставщикам.ТекущиеДанные;
	ФинансыКлиент.ДокументРасчетовНачалоВыбора(
		Объект.Организация,
		СтрокаТаблицы.Поставщик,
		СтрокаТаблицы.Контрагент,
		Неопределено, // Соглашение
		Ложь,  // ЭтоРасчетыСКлиентами
		Ложь, // ВыборОснованияПлатежа
		Элемент,
		СтандартнаяОбработка
	);
	
КонецПроцедуры

&НаКлиенте
Процедура ОплатаПоставщикамЗаказОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	СтрокаТаблицы = Элементы.ОплатаПоставщикам.ТекущиеДанные;	
	Если ТипЗнч(ВыбранноеЗначение) = Тип("Структура") Тогда
		ЗаполнитьЗначенияСвойств(СтрокаТаблицы, ВыбранноеЗначение);
		Модифицированность = Истина;
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура ОплатаПоставщикамВалютаВзаиморасчетовПриИзменении(Элемент)
	
	СтрокаТаблицы = Элементы.ОплатаПоставщикам.ТекущиеДанные;
	СтрокаТаблицы.СуммаВзаиморасчетов = 0;
	
КонецПроцедуры

///////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ТАБЛИЦЫ ФОРМЫ ЗАКУПКА ЗА НАЛИЧНЫЙ РАСЧЕТ

&НаКлиенте
Процедура ЗакупкаЗаНаличныйРасчетПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	РассчитатьСуммуДокумента();
	
КонецПроцедуры

&НаКлиенте
Процедура ЗакупкаЗаНаличныйРасчетПослеУдаления(Элемент)
	
	РассчитатьСуммуДокумента();
	
КонецПроцедуры

&НаКлиенте
Процедура ЗакупкаЗаНаличныйРасчетДокументПоступленияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)

	СтандартнаяОбработка = Ложь;

	СписокПараметры = Новый Структура("Организация, ПодотчетноеЛицо, Валюта", 
		Объект.Организация,
		Объект.ПодотчетноеЛицо,
		Объект.Валюта
	);
	Если ИспользуетсяОбменСБухгалтериейПредприятия
	 И ЗначениеЗаполнено(Объект.Склад) Тогда
		СписокПараметры.Вставить("Склад", Объект.Склад);
	КонецЕсли;
	ПараметрыФормы = Новый Структура("Отбор", СписокПараметры);
	ОткрытьФорму("Документ.ПоступлениеТоваровУслуг.Форма.ФормаВыбораПоступленияОтПодотчетника", ПараметрыФормы, ЭтаФорма);
	
КонецПроцедуры

///////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ТАБЛИЦЫ ФОРМЫ ПРОЧИЕ РАСХОДЫ

&НаКлиенте
Процедура ПрочиеРасходыПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	РассчитатьСуммуДокумента();
	
КонецПроцедуры

&НаКлиенте
Процедура ПрочиеРасходыПослеУдаления(Элемент)
	
	РассчитатьСуммуДокумента();
	
КонецПроцедуры

&НаСервере
Процедура ПрочиеРасходыСтатьяРасходовПриИзмененииСервер(СтатьяРасходов, АналитикаРасходов);
	
	Если Не ЗначениеЗаполнено(АналитикаРасходов) Тогда
		АналитикаРасходов = ПланыВидовХарактеристик.СтатьиРасходов.ПолучитьАналитикуРасходовПоУмолчанию(
			СтатьяРасходов,
			Объект
		);
	Иначе
		ДоходыИРасходыСервер.ОчиститьАналитикуПрочихРасходов(СтатьяРасходов, АналитикаРасходов);	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПрочиеРасходыСтатьяРасходовПриИзменении(Элемент)
	
	СтрокаТаблицы = Элементы.ПрочиеРасходы.ТекущиеДанные;
	Если ЗначениеЗаполнено(СтрокаТаблицы.СтатьяРасходов) Тогда
		ПрочиеРасходыСтатьяРасходовПриИзмененииСервер(
			СтрокаТаблицы.СтатьяРасходов,
			СтрокаТаблицы.АналитикаРасходов
		);
	Иначе
		СтрокаТаблицы.АналитикаРасходов = Неопределено;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПрочиеРасходыПериодВозникновенияРасходаНачалоВыбораИзСписка(Элемент, СтандартнаяОбработка)
	
	СтрокаТаблицы = Элементы.ПрочиеРасходы.ТекущиеДанные;
	СтрокаТаблицы.ПериодВозникновенияРасхода = ФинансыКлиент.ПериодВозникновенияРасхода(
		ЭтаФорма,
		Объект.Дата,
		Элемент,
		СтандартнаяОбработка
	);
	
КонецПроцедуры

///////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ КОМАНД ФОРМЫ

// Процедура используется в автотесте процесса продаж.
//
&НаКлиенте
Процедура АвтоТест_ЗаполнитьПолученныеАвансы(Команда) Экспорт
	
	СтруктураРеквизитов = Новый Структура;
	СтруктураРеквизитов.Вставить("Организация");
	СтруктураРеквизитов.Вставить("Валюта");
	СтруктураРеквизитов.Вставить("ПодотчетноеЛицо", "Подотчетное лицо");
	СтруктураРеквизитов.Вставить("Подразделение");
	
	Если ОбщегоНазначенияУТКлиент.ВозможноЗаполнениеТабличнойЧасти(ЭтаФорма, Объект.ПолученныеАвансы, СтруктураРеквизитов) Тогда
		ЗаполнитьПолученныеАвансы();
		РассчитатьСуммуДокумента();
	КонецЕсли;
	
КонецПроцедуры

// Процедура используется в автотесте процесса продаж.
//
&НаКлиенте
Процедура АвтоТест_ЗаполнитьЗакупки(Команда) Экспорт
	
	СтруктураРеквизитов = Новый Структура;
	СтруктураРеквизитов.Вставить("Организация");
	СтруктураРеквизитов.Вставить("Валюта");
	СтруктураРеквизитов.Вставить("ПодотчетноеЛицо", "Подотчетное лицо");
	Если ИспользуетсяОбменСБухгалтериейПредприятия Тогда
		СтруктураРеквизитов.Вставить("Склад");
	КонецЕсли;

	Если ОбщегоНазначенияУТКлиент.ВозможноЗаполнениеТабличнойЧасти(ЭтаФорма, Объект.ЗакупкаЗаНаличныйРасчет, СтруктураРеквизитов) Тогда
		ЗаполнитьЗакупкиЗаНаличныйРасчет();
		РассчитатьСуммуДокумента();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПодборПоОстаткам(Команда)
	
	СтруктураРеквизитов = Новый Структура;
	СтруктураРеквизитов.Вставить("Организация");
	СтруктураРеквизитов.Вставить("Валюта");
	
	Если ОбщегоНазначенияУТКлиент.ВозможноЗаполнениеТабличнойЧасти(ЭтаФорма, Неопределено, СтруктураРеквизитов) Тогда
		
		ПараметрыПодбора = Новый Структура("
			|Организация, 
			|Валюта,
			|СуммаДокумента,
			|ДатаДокумента,
			|ХозяйственнаяОперация
			|",
			Объект.Организация, 
			Объект.Валюта,
			Остаток,
			Объект.Дата,
			ПредопределенноеЗначение("Перечисление.ХозяйственныеОперации.АвансовыйОтчет")
		);
		ОткрытьФорму(
			"ОбщаяФорма.ПодборПоРасчетамСПартнерами",
			ПараметрыПодбора, 
			ЭтаФорма
		);
		
	КонецЕсли;
	
КонецПроцедуры

///////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

///////////////////////////////////////////////////////////////////////////////
// Прочее

&НаСервере
Процедура ДатаПриИзмененииСервер()
	
	ОтветственныеЛицаСервер.ПриИзмененииСвязанныхРеквизитовДокумента(Объект);
	
КонецПроцедуры

&НаСервере
Процедура ОрганизацияПриИзмененииСервер()
	
	ОтветственныеЛицаСервер.ПриИзмененииСвязанныхРеквизитовДокумента(Объект);
	
КонецПроцедуры

&НаСервере
Процедура ПолучитьОплатуПоставщикамИзХранилища(АдресПлатежейВХранилище)

	ТаблицаПлатежей = ПолучитьИзВременногоХранилища(АдресПлатежейВХранилище);
	Для Каждого СтрокаТаблицы Из ТаблицаПлатежей Цикл
		НоваяСтрока = Объект.ОплатаПоставщикам.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаТаблицы);
		НоваяСтрока.Поставщик = СтрокаТаблицы.Партнер;
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьПолученныеАвансы()

	Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|	ДенежныеСредства.РасчетныйДокумент КАК ДокументАванса,
	|	ДенежныеСредства.РасчетныйДокумент.ЗаявкаНаРасходованиеДенежныхСредств КАК ЗаявкаНаРасходованиеДенежныхСредств,
	|	ДенежныеСредства.СуммаОстаток КАК Сумма
	|ИЗ
	|	РегистрНакопления.ДенежныеСредстваУПодотчетныхЛиц.Остатки(&Дата,
	|		Организация = &Организация
	|		И ПодотчетноеЛицо = &ПодотчетноеЛицо
	|		И Валюта = &Валюта
	|		И (РасчетныйДокумент.Подразделение = &Подразделение
	|			ИЛИ РасчетныйДокумент.Подразделение = ЗНАЧЕНИЕ(Справочник.СтруктураПредприятия.ПустаяСсылка))
	|	) КАК ДенежныеСредства
	|
	|ГДЕ
	|	ДенежныеСредства.СуммаОстаток > 0
	|");
	Запрос.УстановитьПараметр("Дата", Новый Граница(КонецДня(Объект.Дата), ВидГраницы.Включая));
	Запрос.УстановитьПараметр("Организация", Объект.Организация);
	Запрос.УстановитьПараметр("ПодотчетноеЛицо", Объект.ПодотчетноеЛицо);
	Запрос.УстановитьПараметр("Подразделение", Объект.Подразделение);
	Запрос.УстановитьПараметр("Валюта", Объект.Валюта);
	
	Объект.ПолученныеАвансы.Загрузить(Запрос.Выполнить().Выгрузить());
	
	Если Объект.ПолученныеАвансы.Количество() = 0 Тогда
		Текст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'У подотчетного лица отсутствуют выданные авансы, за которые он не отчитался перед организацией %1 в валюте %2'"),
			Объект.Организация,
			Объект.Валюта
		);
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(Текст);
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьЗакупкиЗаНаличныйРасчет()

	Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|	ДенежныеСредства.РасчетныйДокумент КАК ДокументПоступления,
	|	-ДенежныеСредства.СуммаОстаток КАК Сумма
	|ИЗ
	|	РегистрНакопления.ДенежныеСредстваКСписаниюСПодотчетныхЛиц.Остатки(&Дата,
	|		Организация = &Организация
	|		И ПодотчетноеЛицо = &ПодотчетноеЛицо
	|		И Валюта = &Валюта
	|	) КАК ДенежныеСредства
	|
	|ГДЕ
	|	ДенежныеСредства.СуммаОстаток < 0
	|	И (&Склад = Неопределено
	|		ИЛИ ДенежныеСредства.РасчетныйДокумент.Склад = &Склад
	|		ИЛИ ДенежныеСредства.РасчетныйДокумент.Склад.Родитель = &Склад
	|	)
	|");
	Запрос.УстановитьПараметр("Дата", Новый Граница(КонецДня(Объект.Дата), ВидГраницы.Включая));
	Запрос.УстановитьПараметр("Организация", Объект.Организация);
	Запрос.УстановитьПараметр("ПодотчетноеЛицо", Объект.ПодотчетноеЛицо);
	Запрос.УстановитьПараметр("Валюта", Объект.Валюта);
	Запрос.УстановитьПараметр("Склад", Объект.Склад);
	
	Объект.ЗакупкаЗаНаличныйРасчет.Загрузить(Запрос.Выполнить().Выгрузить());
	
	Если Объект.ЗакупкаЗаНаличныйРасчет.Количество() = 0 Тогда
		Текст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'У подотчетного лица отсутствуют оформленные закупки, за которые он не отчитался перед организацией %1 в валюте %2'"),
			Объект.Организация,
			Объект.Валюта
		);
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(Текст);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьСуммуДокумента()
	
	Объект.ИтогоПолучено = Объект.ПолученныеАвансы.Итог("Сумма");
	Объект.ИтогоИзрасходовано = Объект.ОплатаПоставщикам.Итог("Сумма")
		+ Объект.ЗакупкаЗаНаличныйРасчет.Итог("Сумма")
		+ Объект.ПрочиеРасходы.Итог("Сумма");
	Если Объект.ИтогоПолучено <= Объект.ИтогоИзрасходовано Тогда
		Перерасход = Объект.ИтогоПолучено - Объект.ИтогоИзрасходовано;
		Остаток = 0;
	Иначе
		Перерасход = 0;
		Остаток = Объект.ИтогоПолучено - Объект.ИтогоИзрасходовано;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПересчетСуммДокументаВВалютуСервер()
	
	СтруктураКурсовТекущейВалюты = РаботаСКурсамиВалют.ПолучитьКурсВалюты(ТекущаяВалюта, Объект.Дата);
	СтруктураКурсовНовойВалюты = РаботаСКурсамиВалют.ПолучитьКурсВалюты(Объект.Валюта, Объект.Дата);
	
	МассивТабличныхЧастей = Новый Массив;
	МассивТабличныхЧастей.Добавить(Объект.ПолученныеАвансы);
	МассивТабличныхЧастей.Добавить(Объект.ОплатаПоставщикам);
	МассивТабличныхЧастей.Добавить(Объект.ЗакупкаЗаНаличныйРасчет);
	МассивТабличныхЧастей.Добавить(Объект.ПрочиеРасходы);
	
	Для Каждого ТабличнаяЧасть из МассивТабличныхЧастей Цикл
	
		Для Каждого СтрокаТаблицы Из ТабличнаяЧасть Цикл
			СтрокаТаблицы.Сумма = РаботаСКурсамиВалютКлиентСервер.ПересчитатьИзВалютыВВалюту(
				СтрокаТаблицы.Сумма,
				ТекущаяВалюта,
				Объект.Валюта,
				СтруктураКурсовТекущейВалюты.Курс,
				СтруктураКурсовНовойВалюты.Курс,
				СтруктураКурсовТекущейВалюты.Кратность,
				СтруктураКурсовНовойВалюты.Кратность
			);
		КонецЦикла;
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ПересчетСуммДокументаВВалюту()
	
	Если Объект.ИтогоПолучено <> 0
	 ИЛИ Объект.ИтогоИзрасходовано <> 0
	Тогда
	
		ТекстВопроса = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Пересчитать суммы в документе в валюту %1 ?'"), Объект.Валюта);
		
		КодОтвета = Вопрос(ТекстВопроса, РежимДиалогаВопрос.ДаНет);
		Если КодОтвета = КодВозвратаДиалога.Да Тогда
			
			ПересчетСуммДокументаВВалютуСервер();
			РассчитатьСуммуДокумента();
			
			Текст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Суммы в документе пересчитаны в валюту %1'"), Объект.Валюта);
			ПоказатьОповещениеПользователя(НСтр("ru = 'Суммы пересчитаны'"),, Текст, БиблиотекаКартинок.Информация32);
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ПолучитьКонтрагентаПартнераПоУмолчанию(Партнер)
	
	Возврат ПартнерыИКонтрагенты.ПолучитьКонтрагентаПартнераПоУмолчанию(Партнер);
	
КонецФункции
