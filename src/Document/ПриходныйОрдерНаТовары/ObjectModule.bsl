﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ 

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	Перем ИмяПоля;
	Перем ДокументОснование;
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("Структура") Тогда
		
		Распоряжение    = ДанныеЗаполнения.Распоряжение;
		Склад           = ДанныеЗаполнения.Склад;
		Помещение       = ДанныеЗаполнения.Помещение;
		ДатаПоступления = ДанныеЗаполнения.ДатаПоступления;
		ЗонаПриемки     = ДанныеЗаполнения.ЗонаПриемки;
		СкладскаяОперация = Документы.ПриходныйОрдерНаТовары.СкладскаяОперацияПоРаспоряжению(Распоряжение);
		
		Если СкладскаяОперация = Перечисления.СкладскиеОперации.ПриемкаПоПеремещению Тогда
			ЗаполнитьТоварыПоТоварамКПоступлению("НоменклатураКоличество",ДатаПоступления);
			Документы.ПриходныйОрдерНаТовары.ЗаполнитьСерииПоОтгрузкеПриПеремещении(ЭтотОбъект,Ложь);
		Иначе
			ЗаполнитьТоварыПоТоварамКПоступлению("Номенклатура",ДатаПоступления);
			//{ ООО "АСТЭК" Разработчик: Бурыкин Александр  18.11.2013	
			Если  Найти(Строка(ЭтотОбъект.Распоряжение),"поставщик")>0 Тогда
				ЭтотОбъект.акЗаказКлиента = ЭтотОбъект.Распоряжение.ДокументОснование;	
			Иначе
				ЭтотОбъект.акЗаказКлиента = ЭтотОбъект.Распоряжение.акЗаказКлиента;
			КонецЕсли;
			ЗаполнитьГрузовыеМестаКПоступлению();
			//}
			
		КонецЕсли;
		
	КонецЕсли;
	
	ИнициализироватьДокумент(ДанныеЗаполнения);

КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)

	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	ПроведениеСервер.УстановитьРежимПроведения(ЭтотОбъект, РежимЗаписи, РежимПроведения);

	ДополнительныеСвойства.Вставить("ЭтоНовый",    ЭтоНовый());
	ДополнительныеСвойства.Вставить("РежимЗаписи", РежимЗаписи);

	НоменклатураСервер.УдалитьНеиспользуемыеСтрокиСерий(ЭтотОбъект,НоменклатураСервер.ПараметрыУказанияСерий(ЭтотОбъект, Документы.ПриходныйОрдерНаТовары));
	
	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьСтатусыПриходныхОрдеров", Новый Структура("Склад", Склад)) Тогда
		Статус = Перечисления.СтатусыПриходныхОрдеров.Принят;
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)

	ПроведениеСервер.ИнициализироватьДополнительныеСвойстваДляПроведения(Ссылка, ДополнительныеСвойства, РежимПроведения);

	Документы.ПриходныйОрдерНаТовары.ИнициализироватьДанныеДокумента(Ссылка, ДополнительныеСвойства);

	ПроведениеСервер.ПодготовитьНаборыЗаписейКРегистрацииДвижений(ЭтотОбъект);

	ЗапасыСервер.ОтразитьТоварыНаСкладах(ДополнительныеСвойства, Движения, Отказ);
	ЗаказыСервер.ОтразитьТоварыКПоступлению(ДополнительныеСвойства, Движения, Отказ);
	ЗапасыСервер.ОтразитьСвободныеОстатки(ДополнительныеСвойства, Движения, Отказ);
	ЗаказыСервер.ОтразитьДвижениеТоваров(ДополнительныеСвойства, Движения, Отказ);
	СкладыСервер.ОтразитьТоварыВСкладскихЯчейках(ДополнительныеСвойства, Движения, Отказ);
 	СкладыСервер.ОтразитьДвиженияСерийТоваров(ДополнительныеСвойства, Движения, Отказ);
	
	СформироватьСписокРегистровДляКонтроля();

	ПроведениеСервер.ЗаписатьНаборыЗаписей(ЭтотОбъект);

	ПроведениеСервер.ВыполнитьКонтрольРезультатовПроведения(ЭтотОбъект, Отказ);

	ПроведениеСервер.ОчиститьДополнительныеСвойстваДляПроведения(ДополнительныеСвойства);

КонецПроцедуры

Процедура ОбработкаУдаленияПроведения(Отказ)

	ПроведениеСервер.ИнициализироватьДополнительныеСвойстваДляПроведения(Ссылка, ДополнительныеСвойства);

	ПроведениеСервер.ПодготовитьНаборыЗаписейКРегистрацииДвижений(ЭтотОбъект);

	СформироватьСписокРегистровДляКонтроля();

	ПроведениеСервер.ЗаписатьНаборыЗаписей(ЭтотОбъект);

	ПроведениеСервер.ВыполнитьКонтрольРезультатовПроведения(ЭтотОбъект, Отказ);

	ПроведениеСервер.ОчиститьДополнительныеСвойстваДляПроведения(ДополнительныеСвойства);

КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)

	Серии.Очистить();
	СостояниеЗаполненияМногооборотнойТары = Перечисления.СостоянияЗаполненияМногооборотнойТары.ПустаяСсылка();
	ИнициализироватьДокумент();

КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)

	СтруктураПараметров = Новый Структура("Склад,Помещение",Склад, Помещение);
	
	МассивНепроверяемыхРеквизитов = Новый Массив;
	
	Если Не СкладыСервер.ИспользоватьСкладскиеПомещения(Склад) Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Помещение");
	КонецЕсли;
	
	АдресноеХранение = СкладыСервер.ИспользоватьАдресноеХранение(Склад, Помещение);
	
	Если Не АдресноеХранение Тогда
		МассивНепроверяемыхРеквизитов.Добавить("ЗонаПриемки");
	ИначеЕсли Не ПолучитьФункциональнуюОпцию("ИспользоватьУпаковкиНоменклатуры") Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Товары.Упаковка");
		ТекстСообщения = НСтр("ru='В настройках программы не включено использование упаковок номенклатуры, 
		|поэтому нельзя оформить документ по складу с адресным хранением остатков. Обратитесь к администратору'");
		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,,,,Отказ);
	КонецЕсли;	
	
	Если (Не АдресноеХранение
		Или Статус = Перечисления.СтатусыПриходныхОрдеров.КПоступлению)Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Товары.Упаковка");
	КонецЕсли;
	
	Если Статус = Перечисления.СтатусыПриходныхОрдеров.КПоступлению Тогда
		
		МассивНепроверяемыхРеквизитов.Добавить("Товары.КоличествоУпаковок");
		МассивНепроверяемыхРеквизитов.Добавить("Товары.Количество");
		
	КонецЕсли;
	
	НоменклатураСервер.ПроверитьЗаполнениеХарактеристик(ЭтотОбъект,МассивНепроверяемыхРеквизитов,Отказ);
	
	НоменклатураСервер.ПроверитьЗаполнениеСерий(ЭтотОбъект, НоменклатураСервер.ПараметрыУказанияСерий(ЭтотОбъект, Документы.ПриходныйОрдерНаТовары),Отказ);
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов);
	
	ОбщегоНазначенияУТ.ПроверитьЗаполнениеКоличества(ЭтотОбъект, ПроверяемыеРеквизиты, Отказ);
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

////////////////////////////////////////////////////////////////////////////////
// Инициализация и заполнение

Процедура ЗаполнитьТоварыПоТоварамКПоступлению(ВидЗаполнения,ДатаПоступления) Экспорт

	Если СкладскаяОперация = Перечисления.СкладскиеОперации.ПриемкаПоПеремещению Тогда
		
		СкладОтправитель = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Распоряжение, "СкладОтправитель");
		
		Если ТипЗнч(Распоряжение) = Тип("ДокументСсылка.ЗаказНаПеремещение") Тогда
			ТекстЗапросаПоРаспоряжениям =
			" В (ВЫБРАТЬ РАЗЛИЧНЫЕ
			|	ПеремещениеТоваров.Ссылка КАК Распоряжение 
			|ИЗ
			|	Документ.ПеремещениеТоваров КАК ПеремещениеТоваров
			|ГДЕ
			|	ПеремещениеТоваров.Товары.ЗаказНаПеремещение = &Распоряжение)";
		Иначе
			ТекстЗапросаПоРаспоряжениям =
			" = &Распоряжение ";
		КонецЕсли;
		
		Если ПолучитьФункциональнуюОпцию("ИспользоватьОрдернуюСхемуПриОтгрузке", Новый Структура("Склад",СкладОтправитель)) Тогда
			
			УстановитьПривилегированныйРежим(Истина);
			
			Запрос = Новый Запрос;
			
			Если ВидЗаполнения = "НоменклатураКоличество"
				Или ВидЗаполнения = "Номенклатура" Тогда
				
				ТекстЗапроса =
				"ВЫБРАТЬ
				|	ВложенныйЗапрос.Номенклатура,
				|	ВложенныйЗапрос.Характеристика,
				|	ВложенныйЗапрос.Упаковка,
				|   СУММА(ВложенныйЗапрос.Количество) КАК КоличествоОстаток,";
				Если ВидЗаполнения = "НоменклатураКоличество" Тогда
					
					ТекстЗапроса = ТекстЗапроса + "
					|	СУММА(ВложенныйЗапрос.КоличествоУпаковок) КАК КоличествоУпаковок,
					|	СУММА(ВложенныйЗапрос.Количество) КАК Количество ";
				Иначе
					
					ТекстЗапроса = ТекстЗапроса + "
					|	0 КАК КоличествоУпаковок, 
					|	0 КАК Количество ";
				КонецЕсли;
				ТекстЗапроса = ТекстЗапроса + "
				|ИЗ
				|	(ВЫБРАТЬ
				|		РасходныйОрдерНаТоварыТовары.Номенклатура КАК Номенклатура,
				|		РасходныйОрдерНаТоварыТовары.Характеристика КАК Характеристика,
				|		РасходныйОрдерНаТоварыТовары.Упаковка КАК Упаковка,
				|		РасходныйОрдерНаТоварыТовары.КоличествоУпаковок КАК КоличествоУпаковок,
				|		РасходныйОрдерНаТоварыТовары.Количество КАК Количество
				|	ИЗ
				|		Документ.РасходныйОрдерНаТовары.Товары КАК РасходныйОрдерНаТоварыТовары
				|	ГДЕ
				|		РасходныйОрдерНаТоварыТовары.Ссылка.Распоряжение " + ТекстЗапросаПоРаспоряжениям + "
				|		И РасходныйОрдерНаТоварыТовары.Ссылка.Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыРасходныхОрдеров.Отгружен)
				|		И РасходныйОрдерНаТоварыТовары.Ссылка.Проведен
				|	
				|	ОБЪЕДИНИТЬ ВСЕ
				|	
				|	ВЫБРАТЬ
				|		ПриходныйОрдерНаТовары.Номенклатура,
				|		ПриходныйОрдерНаТовары.Характеристика,
				|		ПриходныйОрдерНаТовары.Упаковка,
				|		-ПриходныйОрдерНаТовары.КоличествоУпаковок,
				|		-ПриходныйОрдерНаТовары.Количество
				|	ИЗ
				|		Документ.ПриходныйОрдерНаТовары.Товары КАК ПриходныйОрдерНаТовары
				|	ГДЕ
				|		ПриходныйОрдерНаТовары.Ссылка.Распоряжение = &Распоряжение
				|		И ПриходныйОрдерНаТовары.Ссылка <> &ТекущийПриходныйОрдер
				|		И ПриходныйОрдерНаТовары.Ссылка.Проведен) КАК ВложенныйЗапрос
				|
				|СГРУППИРОВАТЬ ПО
				|	ВложенныйЗапрос.Номенклатура,
				|	ВложенныйЗапрос.Характеристика,
				|	ВложенныйЗапрос.Упаковка
				|
				|ИМЕЮЩИЕ
				|	СУММА(ВложенныйЗапрос.Количество) > 0";
				
				
			ИначеЕсли ВидЗаполнения = "Количество" Тогда
			ТекстЗапроса =
				"ВЫБРАТЬ
				|	ТаблицаТоваров.Номенклатура,
				|	ТаблицаТоваров.Характеристика,
				|	ТаблицаТоваров.НомерСтроки
				|ПОМЕСТИТЬ ТаблицаНомеклатурыДляЗапроса
				|ИЗ
				|	&ТаблицаТоваров КАК ТаблицаТоваров
				|;
				|
				|////////////////////////////////////////////////////////////////////////////////
				|ВЫБРАТЬ
				|	ВложенныйЗапрос.Номенклатура,
				|	ВложенныйЗапрос.Характеристика,
				|	ВложенныйЗапрос.Упаковка,
				|	СУММА(ВложенныйЗапрос.КоличествоУпаковок) КАК КоличествоУпаковок,
				|	СУММА(ВложенныйЗапрос.Количество) КАК Количество
				|ПОМЕСТИТЬ ТаблицаНепринятыхТоваров
				|ИЗ
				|	(ВЫБРАТЬ
				|		РасходныйОрдерНаТоварыТовары.Номенклатура КАК Номенклатура,
				|		РасходныйОрдерНаТоварыТовары.Характеристика КАК Характеристика,
				|		РасходныйОрдерНаТоварыТовары.Упаковка КАК Упаковка,
				|		РасходныйОрдерНаТоварыТовары.КоличествоУпаковок КАК КоличествоУпаковок,
				|		РасходныйОрдерНаТоварыТовары.Количество КАК Количество
				|	ИЗ
				|		Документ.РасходныйОрдерНаТовары.Товары КАК РасходныйОрдерНаТоварыТовары
				|	ГДЕ
				|		РасходныйОрдерНаТоварыТовары.Ссылка.Распоряжение " + ТекстЗапросаПоРаспоряжениям + "
				|		И РасходныйОрдерНаТоварыТовары.Ссылка.Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыРасходныхОрдеров.Отгружен)
				|		И РасходныйОрдерНаТоварыТовары.Ссылка.Проведен
				|	
				|	ОБЪЕДИНИТЬ ВСЕ
				|	
				|	ВЫБРАТЬ
				|		ПриходныйОрдерНаТовары.Номенклатура,
				|		ПриходныйОрдерНаТовары.Характеристика,
				|		ПриходныйОрдерНаТовары.Упаковка,
				|		-ПриходныйОрдерНаТовары.КоличествоУпаковок,
				|		-ПриходныйОрдерНаТовары.Количество
				|	ИЗ
				|		Документ.ПриходныйОрдерНаТовары.Товары КАК ПриходныйОрдерНаТовары
				|	ГДЕ
				|		ПриходныйОрдерНаТовары.Ссылка.Распоряжение = &Распоряжение
				|		И ПриходныйОрдерНаТовары.Ссылка <> &ТекущийПриходныйОрдер
				|		И ПриходныйОрдерНаТовары.Ссылка.Проведен) КАК ВложенныйЗапрос
				|
				|СГРУППИРОВАТЬ ПО
				|	ВложенныйЗапрос.Номенклатура,
				|	ВложенныйЗапрос.Характеристика,
				|	ВложенныйЗапрос.Упаковка
				|
				|ИМЕЮЩИЕ
				|	СУММА(ВложенныйЗапрос.Количество) > 0
				|;
				|
				|////////////////////////////////////////////////////////////////////////////////
				|ВЫБРАТЬ
				|	ТаблицаНомеклатурыДляЗапроса.Номенклатура,
				|	ТаблицаНомеклатурыДляЗапроса.Характеристика,
				|	МИНИМУМ(ТаблицаНомеклатурыДляЗапроса.НомерСтроки) КАК НомерСтроки
				|ПОМЕСТИТЬ ТаблицаТоваров
				|ИЗ
				|	ТаблицаНомеклатурыДляЗапроса КАК ТаблицаНомеклатурыДляЗапроса
				|
				|СГРУППИРОВАТЬ ПО
				|	ТаблицаНомеклатурыДляЗапроса.Номенклатура,
				|	ТаблицаНомеклатурыДляЗапроса.Характеристика
				|;
				|
				|////////////////////////////////////////////////////////////////////////////////
				|ВЫБРАТЬ
				|	ТаблицаТоваров.Номенклатура,
				|	ТаблицаТоваров.Характеристика,
				|	ТаблицаНепринятыхТоваров.Упаковка,
				|	ТаблицаНепринятыхТоваров.КоличествоУпаковок КАК КоличествоУпаковок,
				|	ТаблицаНепринятыхТоваров.Количество КАК Количество,
				|	ТаблицаТоваров.НомерСтроки КАК НомерСтроки
				|ИЗ
				|	ТаблицаТоваров КАК ТаблицаТоваров
				|		ЛЕВОЕ СОЕДИНЕНИЕ ТаблицаНепринятыхТоваров КАК ТаблицаНепринятыхТоваров
				|		ПО ТаблицаТоваров.Номенклатура = ТаблицаНепринятыхТоваров.Номенклатура
				|			И ТаблицаТоваров.Характеристика = ТаблицаНепринятыхТоваров.Характеристика
				|
				|УПОРЯДОЧИТЬ ПО
				|	ТаблицаТоваров.НомерСтроки";
				
				Запрос.УстановитьПараметр("ТаблицаТоваров",Товары.Выгрузить(,"Номенклатура,Характеристика,НомерСтроки"));
			КонецЕсли;	
			
			Запрос.Текст = ТекстЗапроса;
			Запрос.УстановитьПараметр("Распоряжение",Распоряжение);
			Запрос.УстановитьПараметр("ТекущийПриходныйОрдер",Ссылка);
			
			Товары.Загрузить(Запрос.Выполнить().Выгрузить());
			
			Возврат;
		КонецЕсли;	
	КонецЕсли;

	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.УстановитьПараметр("Склад", Склад);
	Запрос.УстановитьПараметр("Распоряжение", Распоряжение);
	Если ЗначениеЗаполнено(ДатаПоступления) Тогда
		Запрос.УстановитьПараметр("ДатаОстатков", КонецДня(ДатаПоступления));
	Иначе
		Запрос.УстановитьПараметр("ДатаОстатков", ДатаПоступления);
	КонецЕсли;
		
	Если ВидЗаполнения = "Номенклатура" Или ВидЗаполнения = "НоменклатураКоличество" Тогда

		Товары.Очистить();

		ТекстЗапроса =
		"ВЫБРАТЬ
		|	ТоварыКПоступлению.Номенклатура      КАК Номенклатура,
		|	ТоварыКПоступлению.Характеристика    КАК Характеристика,";

		Если ВидЗаполнения = "НоменклатураКоличество" Тогда

			ТекстЗапроса = ТекстЗапроса + "
				|	СУММА(ТоварыКПоступлению.Количество) КАК Количество,
				|	СУММА(ТоварыКПоступлению.Количество) КАК КоличествоУпаковок ";
		Иначе

			ТекстЗапроса = ТекстЗапроса + "
				|	СУММА(ТоварыКПоступлению.Количество) КАК КоличествоРегистр, 
				|	0 КАК КоличествоУпаковок, 
				|	0 КАК Количество ";
		КонецЕсли;

		ТекстЗапроса = ТекстЗапроса + "
		|ИЗ
		|	(ВЫБРАТЬ
		|		ТоварыКПоступлению.Номенклатура      КАК Номенклатура,
		|		ТоварыКПоступлению.Характеристика    КАК Характеристика,
		|		ТоварыКПоступлению.КПоступлениюОстаток
		|		 - ТоварыКПоступлению.ПринимаетсяОстаток КАК Количество
		|	ИЗ
		|		РегистрНакопления.ТоварыКПоступлению.Остатки(&ДатаОстатков,
		|				ДокументПоступления = &Распоряжение
		|				И Склад = &Склад) КАК ТоварыКПоступлению
		|	
		|	ОБЪЕДИНИТЬ ВСЕ
		|	
		|	ВЫБРАТЬ
		|		ТоварыКПоступлению.Номенклатура,
		|		ТоварыКПоступлению.Характеристика,
		|		ВЫБОР КОГДА ТоварыКПоступлению.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) ТОГДА
		|				-ТоварыКПоступлению.КПоступлению
		|			ИНАЧЕ ТоварыКПоступлению.КПоступлению
		|			КОНЕЦ
		|			- ВЫБОР КОГДА ТоварыКПоступлению.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) ТОГДА
		|				- ТоварыКПоступлению.Принимается
		|			ИНАЧЕ ТоварыКПоступлению.Принимается
		|		КОНЕЦ 
		|	ИЗ
		|		РегистрНакопления.ТоварыКПоступлению КАК ТоварыКПоступлению
		|	ГДЕ
		|		ТоварыКПоступлению.Регистратор = &Ссылка
		|		И ТоварыКПоступлению.Активность
		|		И ТоварыКПоступлению.Склад = &Склад
		|		И ТоварыКПоступлению.ДокументПоступления = &Распоряжение
		|
		|) КАК ТоварыКПоступлению
		|
		|СГРУППИРОВАТЬ ПО
		|	ТоварыКПоступлению.Номенклатура,
		|	ТоварыКПоступлению.Характеристика
		|
		|ИМЕЮЩИЕ
		|	СУММА(ТоварыКПоступлению.Количество) > 0
		|
		|УПОРЯДОЧИТЬ ПО
		|	Номенклатура.Наименование,
		|	Характеристика.Наименование
		|";
		Запрос.Текст = ТекстЗапроса;
		Результат = Запрос.Выполнить();
		Если Не Результат.Пустой() Тогда

			Товары.Загрузить(Результат.Выгрузить());

		Иначе

			ТекстСообщения = НСтр("ru = 'Нет товаров для заполнения по распоряжению ""%Распоряжение%"".'");
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Распоряжение%", Распоряжение);
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, ЭтотОбъект, "Распоряжение");

		КонецЕсли;

	Иначе
		ТекстЗапроса =
		
		"ВЫБРАТЬ
		|	Таблица.Номенклатура КАК Номенклатура,
		|	Таблица.Характеристика КАК Характеристика,
		|	Таблица.НомерСтроки КАК НомерСтроки
		|ПОМЕСТИТЬ ТаблицаНоменклатурыДляЗапроса
		|ИЗ
		|	&Таблица КАК Таблица
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	Таблица.Номенклатура КАК Номенклатура,
		|	Таблица.Характеристика КАК Характеристика,
		|	МИНИМУМ(Таблица.НомерСтроки) КАК НомерСтроки
		|ПОМЕСТИТЬ ТаблицаНоменклатуры
		|ИЗ
		|	ТаблицаНоменклатурыДляЗапроса КАК Таблица
		|
		|СГРУППИРОВАТЬ ПО
		|	Таблица.Номенклатура,
		|	Таблица.Характеристика
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ТоварыКПоступлению.Номенклатура КАК Номенклатура,
		|	ТоварыКПоступлению.Характеристика КАК Характеристика,
		|	ТоварыКПоступлению.КПоступлениюОстаток - ТоварыКПоступлению.ПринимаетсяОстаток КАК Количество
		|ПОМЕСТИТЬ ТоварыКПоступлению
		|ИЗ
		|	РегистрНакопления.ТоварыКПоступлению.Остатки(&ДатаОстатков
		|			,
		|			ДокументПоступления = &Распоряжение
		|				И Склад = &Склад) КАК ТоварыКПоступлению
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ТоварыКПоступлению.Номенклатура,
		|	ТоварыКПоступлению.Характеристика,
		|	ВЫБОР
		|		КОГДА ТоварыКПоступлению.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)
		|			ТОГДА -ТоварыКПоступлению.КПоступлению
		|		ИНАЧЕ ТоварыКПоступлению.КПоступлению
		|	КОНЕЦ - ВЫБОР
		|		КОГДА ТоварыКПоступлению.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)
		|			ТОГДА -ТоварыКПоступлению.Принимается
		|		ИНАЧЕ ТоварыКПоступлению.Принимается
		|	КОНЕЦ
		|ИЗ
		|	РегистрНакопления.ТоварыКПоступлению КАК ТоварыКПоступлению
		|ГДЕ
		|	ТоварыКПоступлению.Регистратор = &Ссылка
		|	И ТоварыКПоступлению.Активность = ИСТИНА
		|	И ТоварыКПоступлению.Склад = &Склад
		|	И ТоварыКПоступлению.ДокументПоступления = &Распоряжение
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ТаблицаНоменклатуры.Номенклатура КАК Номенклатура,
		|	ТаблицаНоменклатуры.Характеристика КАК Характеристика,
		|	МИНИМУМ(ТаблицаНоменклатуры.НомерСтроки) КАК НомерСтрокиСтарый,
		|	СУММА(ЕСТЬNULL(ТоварыКПоступлению.Количество, 0)) КАК Количество,
		|	СУММА(ЕСТЬNULL(ТоварыКПоступлению.Количество, 0)) КАК КоличествоУпаковок
		|ИЗ
		|	ТаблицаНоменклатуры КАК ТаблицаНоменклатуры
		|		ЛЕВОЕ СОЕДИНЕНИЕ ТоварыКПоступлению КАК ТоварыКПоступлению
		|		ПО ТаблицаНоменклатуры.Номенклатура = ТоварыКПоступлению.Номенклатура
		|			И ТаблицаНоменклатуры.Характеристика = ТоварыКПоступлению.Характеристика
		|
		|СГРУППИРОВАТЬ ПО
		|	ТаблицаНоменклатуры.Номенклатура,
		|	ТаблицаНоменклатуры.Характеристика
		|
		|УПОРЯДОЧИТЬ ПО
		|	НомерСтрокиСтарый
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|УНИЧТОЖИТЬ ТаблицаНоменклатурыДляЗапроса
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|УНИЧТОЖИТЬ ТаблицаНоменклатуры
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|УНИЧТОЖИТЬ ТоварыКПоступлению";	
		
		Запрос.УстановитьПараметр("Таблица", Товары.Выгрузить());
		Запрос.Текст = ТекстЗапроса;
		
		Товары.Загрузить(Запрос.Выполнить().Выгрузить());
	КонецЕсли;

	Если ВидЗаполнения = "Количество"
		Или ВидЗаполнения = "НоменклатураКоличество" Тогда
		
		Если СкладыСервер.ИспользоватьАдресноеХранение(Склад, Помещение) Тогда
			РазбитьПоУпаковкамСправочно();
		КонецЕсли;
		
	КонецЕсли;
	
	
КонецПроцедуры

Процедура РазбитьПоУпаковкамСправочно()
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Таблица.Номенклатура КАК Номенклатура,
	|	Таблица.Характеристика КАК Характеристика,
	|	Таблица.НомерСтроки КАК НомерСтроки,
	|	Таблица.Количество КАК Количество
	|ПОМЕСТИТЬ ТаблицаНоменклатурыДляЗапроса
	|ИЗ
	|	&Таблица КАК Таблица
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Таблица.Номенклатура КАК Номенклатура,
	|	МИНИМУМ(Таблица.НомерСтроки) КАК НомерСтроки,
	|	ВЫРАЗИТЬ(Таблица.Номенклатура КАК Справочник.Номенклатура).НаборУпаковок КАК НаборУпаковок,
	|	Таблица.Характеристика КАК Характеристика,
	|	СУММА(Таблица.Количество) КАК Количество
	|ПОМЕСТИТЬ ТаблицаНоменклатуры
	|ИЗ
	|	ТаблицаНоменклатурыДляЗапроса КАК Таблица
	|
	|СГРУППИРОВАТЬ ПО
	|	Таблица.Номенклатура,
	|	ВЫРАЗИТЬ(Таблица.Номенклатура КАК Справочник.Номенклатура).НаборУпаковок,
	|	Таблица.Характеристика
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТаблицаНоменклатуры.Номенклатура КАК Номенклатура,
	|	ТаблицаНоменклатуры.Количество,
	|	ТаблицаНоменклатуры.НомерСтроки,
	|	ТаблицаНоменклатуры.Характеристика КАК Характеристика,
	|	ЕСТЬNULL(УпаковкиНоменклатуры.Коэффициент, 1) КАК КоличествоВУпаковке,
	|	ЕСТЬNULL(УпаковкиНоменклатуры.Ссылка, ЗНАЧЕНИЕ(Справочник.УпаковкиНоменклатуры.ПустаяСсылка)) КАК Упаковка,
	|	ЕСТЬNULL(УпаковкиНоменклатуры.ЕдиницаИзмерения.Представление, """") КАК ЕдиницаИзмеренияУпаковкиПредставление
	|ИЗ
	|	ТаблицаНоменклатуры КАК ТаблицаНоменклатуры
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.УпаковкиНоменклатуры КАК УпаковкиНоменклатуры
	|		ПО (ТаблицаНоменклатуры.Номенклатура = УпаковкиНоменклатуры.Владелец
	|				ИЛИ ТаблицаНоменклатуры.НаборУпаковок = УпаковкиНоменклатуры.Владелец)
	|			И ((НЕ УпаковкиНоменклатуры.ПометкаУдаления))
	|			И ТаблицаНоменклатуры.Количество >= УпаковкиНоменклатуры.Коэффициент
	|
	|УПОРЯДОЧИТЬ ПО
	|	ТаблицаНоменклатуры.НомерСтроки,
	|	КоличествоВУпаковке,
	|	ЕдиницаИзмеренияУпаковкиПредставление";
	
	ТаблицаНоменклатуры = Товары.Выгрузить();
	Запрос.УстановитьПараметр("Таблица",ТаблицаНоменклатуры);
	
	Товары.Очистить();
	
	Выборка = Запрос.Выполнить().Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	
	ТекНомерСтроки = Неопределено;
	ТекНоменклатура = Неопределено;
	ТекХарактеристика = Неопределено;
	Количество = Неопределено;
	
	Пока Выборка.Следующий() Цикл
		
		Если Выборка.НомерСтроки <> ТекНомерСтроки Тогда
			
			Если Количество <> Неопределено Тогда
				НоваяСтрока = Товары.Добавить();
				НоваяСтрока.Количество = Количество;
				НоваяСтрока.КоличествоУпаковок = Количество;
				
				НоваяСтрока.Номенклатура = ТекНоменклатура;
				НоваяСтрока.Характеристика = ТекХарактеристика;
			КонецЕсли;
			
			ТекНомерСтроки              = Выборка.НомерСтроки;
			ТекНоменклатура             = Выборка.Номенклатура; 
			ТекХарактеристика           = Выборка.Характеристика;
			
			Количество = Выборка.Количество;
			
		КонецЕсли;
		
		Если Количество <> Неопределено Тогда
			КоличествоВДокумент = Цел(Количество / Выборка.КоличествоВУпаковке);
			
			Если КоличествоВДокумент > 0 Тогда
				
				НоваяСтрока = Товары.Добавить();
				НоваяСтрока.Количество = КоличествоВДокумент * Выборка.КоличествоВУпаковке;
				НоваяСтрока.КоличествоУпаковок = КоличествоВДокумент;
				НоваяСтрока.Упаковка = Выборка.Упаковка;
				
				НоваяСтрока.Номенклатура = ТекНоменклатура;
				НоваяСтрока.Характеристика = ТекХарактеристика;
				
				Если Количество = КоличествоВДокумент * Выборка.КоличествоВУпаковке Тогда
					Количество = Неопределено;
				Иначе
					Количество = Количество - КоличествоВДокумент * Выборка.КоличествоВУпаковке;
				КонецЕсли;
				
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Если Количество <> Неопределено Тогда
		НоваяСтрока = Товары.Добавить();
		НоваяСтрока.Количество = Количество;
		НоваяСтрока.КоличествоУпаковок = Количество;
		
		НоваяСтрока.Номенклатура = ТекНоменклатура;
		НоваяСтрока.Характеристика = ТекХарактеристика;
	КонецЕсли;
	
КонецПроцедуры

Процедура ИнициализироватьДокумент(ДанныеЗаполнения = Неопределено)

	Ответственный = Пользователи.ТекущийПользователь();
	
	Склад = ЗначениеНастроекПовтИсп.ПолучитьСкладПоУмолчанию(Склад);
	Если ЗначениеЗаполнено(Склад) Тогда
		Если СкладыСервер.ИспользоватьАдресноеХранение(Склад,Помещение) Тогда
			ЗонаПриемки = Справочники.СкладскиеЯчейки.ЗонаПриемкиПоУмолчанию(Склад,Помещение);
		КонецЕсли;
	КонецЕсли;
	
	СкладскаяОперация = Документы.ПриходныйОрдерНаТовары.СкладскаяОперацияПоРаспоряжению(Распоряжение);
	
	Если ПолучитьФункциональнуюОпцию("ИспользоватьСтатусыПриходныхОрдеров", Новый Структура("Склад", Склад)) Тогда
		Статус = Метаданные().Реквизиты.Статус.ЗначениеЗаполнения;
	Иначе
		Статус = Перечисления.СтатусыПриходныхОрдеров.Принят;
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Прочее

Процедура СформироватьСписокРегистровДляКонтроля()

	Массив = Новый Массив;
	ДополнительныеСвойства.ДляПроведения.Вставить("РегистрыДляКонтроля", Массив);

КонецПроцедуры



//{ ООО "АСТЭК" Разработчик: Бурыкин Александр  11.11.2013 
Процедура ЗаполнитьГрузовыеМестаКПоступлению() Экспорт
	
	// Загрузка Количества грузовых места в таблицу ТОВАРЫ приходного ордера
	ТабЧастьтовары = ЭтотОбъект.Товары.Выгрузить();
	
	Для каждого строка Из ТабЧастьтовары Цикл
		НоменклатураТовары = строка.номенклатура.получитьОбъект();
		//получить недостающее количество или количество упаковок
		Отбор = новый структура("Номенклатура,Характеристика",строка.номенклатура,строка.Характеристика);
		МассивТоваровРаспоряжения = ЭтотОбъект.Распоряжение.Товары.НайтиСтроки(Отбор);
		Для каждого СтрокаТоваровРаспоряжения ИЗ МассивТоваровРаспоряжения  цикл
			строка.количество = СтрокаТоваровРаспоряжения.Количество;
		КонецЦикла;
		строка.акКоличествоГрузовыхМестПлан = НоменклатураТовары.акКоличествоГрузовыхМест * строка.количество;
		строка.акКоличествоПлан = строка.количество;
		строка.количество = 0;  //это - количествоФакт
		строка.акУникальныйИдентификатор = Новый УникальныйИдентификатор;
	КонецЦикла;	
	
	ЭтотОбъект.Товары.Загрузить(ТабЧастьтовары);
	
	// Заполнение табличной части грузовые места
	
	ГрузМеста = новый ТаблицаЗначений ;
	ГрузМеста.Колонки.Добавить("Номенклатура");
	ГрузМеста.Колонки.Добавить("Характеристика");
	ГрузМеста.Колонки.Добавить("НомерГрузовогоМеста");	
	ГрузМеста.Колонки.Добавить("НаименованиеГрузовогоМеста");
	ГрузМеста.Колонки.Добавить("ШтрихКодГрузовогоМеста");
	ГрузМеста.Колонки.Добавить("КоличествоПринять");
	ГрузМеста.Колонки.Добавить("КоличествоПринято");
	ГрузМеста.Колонки.Добавить("акУникальныйИдентификатор");
	
	Для каждого СтрокаТовары ИЗ ТабЧастьтовары Цикл		
		Если СтрокаТовары.акКоличествоГрузовыхМестПлан > 0 Тогда
			ЗапросРегистраГрузМест = новый Запрос;
			Если ПроверитьНаличиеХарактеристики(СтрокаТовары.номенклатура.ссылка) Тогда
				ЗапросРегистраГрузМест.Текст = "ВЫБРАТЬ
				|	НоменклатураакГрузовыеМеста.Ссылка КАК номенклатура,
				|	НоменклатураакГрузовыеМеста.ГрузовоеМесто,
				|	НоменклатураакГрузовыеМеста.Количество,
				|	ХарактеристикиНоменклатуры.Ссылка
				|ИЗ
				|	Справочник.Номенклатура.акГрузовыеМеста КАК НоменклатураакГрузовыеМеста,
				|	Справочник.ХарактеристикиНоменклатуры КАК ХарактеристикиНоменклатуры
				|ГДЕ
				|	НоменклатураакГрузовыеМеста.Ссылка = &Номенклатура
				|	И ХарактеристикиНоменклатуры.Ссылка = &ХарактеристикаНоменклатуры";
				
				ЗапросРегистраГрузМест.УстановитьПараметр("Номенклатура",СтрокаТовары.номенклатура.ссылка);
				ЗапросРегистраГрузМест.УстановитьПараметр("ХарактеристикаНоменклатуры",СтрокаТовары.Характеристика.ссылка);
				
				РегистрМест = ЗапросРегистраГрузМест.Выполнить().Выгрузить();
			ИНАЧЕ
				ЗапросРегистраГрузМест.Текст ="ВЫБРАТЬ
				|	НоменклатураакГрузовыеМеста.Ссылка КАК номенклатура,
				|	НоменклатураакГрузовыеМеста.ГрузовоеМесто,
				|	НоменклатураакГрузовыеМеста.Количество
				|ИЗ
				|	Справочник.Номенклатура.акГрузовыеМеста КАК НоменклатураакГрузовыеМеста
				|ГДЕ
				|	НоменклатураакГрузовыеМеста.Ссылка = &Номенклатура";
								
				ЗапросРегистраГрузМест.УстановитьПараметр("Номенклатура",СтрокаТовары.номенклатура.ссылка);
			
				
				РегистрМест = ЗапросРегистраГрузМест.Выполнить().Выгрузить();
				
			КонецЕсли;
			
			Если ПроверитьНаличиеХарактеристики(СтрокаТовары.номенклатура.ссылка) Тогда
				ЗапросШтрихкодов = новый запрос;			
				ЗапросШтрихкодов.Текст =  "ВЫБРАТЬ
				                          |	акШтрихкодыГрузовыхМест.Номенклатура,
				                          |	акШтрихкодыГрузовыхМест.ХарактеристикаНоменклатуры,
				                          |	акШтрихкодыГрузовыхМест.ШтрихкодГрузовогоМеста,
				                          |	акШтрихкодыГрузовыхМест.ЗаказКлиента,
				                          |	акШтрихкодыГрузовыхМест.НазваниеГрузовогоМеста
				                          |ИЗ
				                          |	РегистрСведений.акШтрихкодыГрузовыхМест КАК акШтрихкодыГрузовыхМест
				                          |ГДЕ
				                          |	акШтрихкодыГрузовыхМест.Номенклатура = &Номенклатура
				                          |	И акШтрихкодыГрузовыхМест.ХарактеристикаНоменклатуры = &ХарактеристикаНоменклатуры";
				
				ЗапросШтрихкодов.УстановитьПараметр("Номенклатура",СтрокаТовары.номенклатура.ссылка);
				ЗапросШтрихкодов.УстановитьПараметр("ХарактеристикаНоменклатуры",СтрокаТовары.Характеристика.ссылка);
				
				ТаблицаШтрихкодов =ЗапросШтрихкодов.Выполнить().Выгрузить();
			ИНАЧЕ
				ЗапросШтрихкодов = новый запрос;			
				ЗапросШтрихкодов.Текст =  "ВЫБРАТЬ
				|	акШтрихкодыГрузовыхМест.Номенклатура,
				|	акШтрихкодыГрузовыхМест.ХарактеристикаНоменклатуры,
				|	акШтрихкодыГрузовыхМест.ШтрихкодГрузовогоМеста,
				|	акШтрихкодыГрузовыхМест.ЗаказКлиента,
				|	акШтрихкодыГрузовыхМест.НазваниеГрузовогоМеста
				|ИЗ
				|	РегистрСведений.акШтрихкодыГрузовыхМест КАК акШтрихкодыГрузовыхМест
				|ГДЕ
				|	акШтрихкодыГрузовыхМест.Номенклатура = &Номенклатура";
				
				ЗапросШтрихкодов.УстановитьПараметр("Номенклатура",СтрокаТовары.номенклатура.ссылка);
				
				ТаблицаШтрихкодов =ЗапросШтрихкодов.Выполнить().Выгрузить();
				
			КонецЕсли;
			Для Каждого СтрокаРегистра ИЗ РегистрМест Цикл
				НоваяСтрокаГрузовогоМеста = ГрузМеста.Добавить();			
				НоваяСтрокаГрузовогоМеста.номенклатура =  СтрокаРегистра.номенклатура;
				НоваяСтрокаГрузовогоМеста.Характеристика =   СтрокаТовары.характеристика;
				НоваяСтрокаГрузовогоМеста.НаименованиеГрузовогоМеста =  СтрокаРегистра.ГрузовоеМесто;				
				НоваяСтрокаГрузовогоМеста.КоличествоПринять =  СтрокаТовары.количество * СтрокаРегистра.количество;    
				НоваяСтрокаГрузовогоМеста.КоличествоПринято =  0;
				НоваяСтрокаГрузовогоМеста.акУникальныйИдентификатор = СтрокаТовары.акУникальныйИдентификатор;
				
				
				ВыбранныйШтрихкод = новый Структура("НазваниеГрузовогоМеста,ХарактеристикаНоменклатуры,ЗаказКлиента",СтрокаРегистра.ГрузовоеМесто,СтрокаТовары.Характеристика.ссылка,ЭтотОбъект.акЗаказКлиента);
				МассивШтрихкодов = ТаблицаШтрихкодов.НайтиСтроки(ВыбранныйШтрихкод);
				Попытка
					НоваяСтрокаГрузовогоМеста.ШтрихКодГрузовогоМеста =  МассивШтрихкодов.Получить(0).штрихкодГрузовогоМеста;
				Исключение
					НоваяСтрокаГрузовогоМеста.ШтрихКодГрузовогоМеста = "";
				КонецПопытки;
				
			КонецЦикла;
		КонецЕсли;
	КонецЦикла;
	ЭтотОбъект.акГрузовыеМеста.Загрузить(ГрузМеста);	
	ПересчитатьГрузовыеМестаПланТовара(ЭтотОбъект);
КонецПроцедуры
//}

//{ ООО "АСТЭК" Разработчик: Бурыкин Александр  11.11.2013
&НаСервере
Функция ПроверитьНаличиеХарактеристики(ВыбраннаяНоменклатура);
	
	Если ВыбраннаяНоменклатура.ВидНоменклатуры.ИспользованиеХарактеристик = Перечисления.ВариантыИспользованияХарактеристикНоменклатуры.НеИспользовать Тогда
		ХарактеристикаЕсть = Ложь;
	Иначе
		ХарактеристикаЕсть = Истина;
	КонецЕсли;
	
	Возврат ХарактеристикаЕсть;
КонецФункции
//}

    //{ ООО "АСТЭК" Разработчик: Бурыкин Александр  11.11.2013
   &НаСервере
Процедура ПересчитатьГрузовыеМестаПланТовара(ЭтотОбъект)

	///
	Для каждого СтрокаТовары Из  ЭтотОбъект.Товары Цикл	  
		ЗапросРегистраГрузМест = новый Запрос;
		ЗапросРегистраГрузМест.Текст = "ВЫБРАТЬ
		|	ГрузовыеМеста.Владелец,
		|	ГрузовыеМеста.Ссылка,
		|	ГрузовыеМеста.Количество
		|ИЗ
		|	Справочник.акГрузовыеМеста КАК ГрузовыеМеста
		|ГДЕ
		|	ГрузовыеМеста.Владелец = &Номенклатура";
		
		ЗапросРегистраГрузМест.УстановитьПараметр("Номенклатура",СтрокаТовары.Номенклатура);
		
		ГрузовыеМеста =  ЗапросРегистраГрузМест.Выполнить().Выгрузить();
		
		Для Каждого Строка ИЗ ГрузовыеМеста Цикл
			Номенклатура = Строка.владелец;
			НаименованиеГрузовогоМеста = Строка.ссылка;
			КоличествоПринятьНовое   = Строка.количество;
			Для каждого ГрузовоеМесто Из ЭтотОбъект.акГрузовыеМеста Цикл 
				Если  ГрузовоеМесто.Номенклатура = Номенклатура И
					ГрузовоеМесто.НаименованиеГрузовогоМеста = НаименованиеГрузовогоМеста Тогда
					ГрузовоеМесто.КоличествоПринять =  СтрокаТовары.акКоличествоПлан * КоличествоПринятьНовое;
				КонецЕсли;
			КонецЦикла;
		КонецЦикла;
	КонецЦикла;
	
	ПересчитатьГрузовыеМеста(ЭтотОбъект);
КонецПроцедуры    
  //}
  
  
 //{ ООО "АСТЭК" Разработчик: Бурыкин Александр  11.11.2013
// Пересчитывает количество грузовых мест которые надо принять в табличной части товары прходного ордера
&НаСервере
Процедура ПересчитатьГрузовыеМеста(ЭтотОбъект)	
	
	
Для каждого СтрокаТовары Из  ЭтотОбъект.Товары Цикл		
	
	//Пересчет мест План и Факт в таблице ТОВАРЫ	
	Номенклатура = СтрокаТовары.Номенклатура;
	Характеристика = СтрокаТовары.Характеристика;	
	СтрокаТовары.акколичествоГрузовыхМестПлан =0;
	СтрокаТовары.акколичествоГрузовыхМестФакт = 0;
	СтрокаТовары.количествоУпаковок=0;
	Значение = 1000; 
	
	
	Отбор = новый структура("акУникальныйИдентификатор,Номенклатура",СтрокаТовары.акУникальныйИдентификатор,СтрокаТовары.Номенклатура);
	Для каждого СтрокаГрузовыеМеста Из ЭтотОбъект.акГрузовыеМеста.НайтиСтроки(Отбор) Цикл		
		СтрокаТовары.акколичествоГрузовыхМестПлан = СтрокаТовары.акколичествоГрузовыхМестПлан + СтрокаГрузовыеМеста.КоличествоПринять; 
		СтрокаТовары.акколичествоГрузовыхМестФакт = СтрокаТовары.акколичествоГрузовыхМестФакт + СтрокаГрузовыеМеста.КоличествоПринято; 
		СтрокаТовары.количествоУпаковок = Цел(Мин(Значение,(СтрокаГрузовыеМеста.КоличествоПринято*СтрокаТовары.акКоличествоПлан)/СтрокаГрузовыеМеста.КоличествоПринять));  
		Значение = СтрокаТовары.количествоУпаковок;		
	КонецЦикла;
	
КонецЦикла;


КонецПроцедуры   
 //}

 

#КонецЕсли