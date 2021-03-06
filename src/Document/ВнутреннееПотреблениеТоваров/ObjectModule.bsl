﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

////////////////////////////////////////////////////////////////////////////////
// ПРОГРАММНЫЙ ИНТЕРФЕЙС

// Процедура ЗаполнитьНаборыЗначенийДоступа заполняет наборы значений доступа
// по объекту в таблице с полями:
//  - НомерНабора     Число                                     (необязательно, если набор один),
//  - ВидДоступа      ПланВидовХарактеристикСсылка.ВидыДоступа, (обязательно),
//  - ЗначениеДоступа Неопределено, СправочникСсылка или др.    (обязательно),
//  - Чтение          Булево (необязательно, если набор для всех прав; устанавливается для одной строки набора),
//  - Добавление      Булево (необязательно, если набор для всех прав; устанавливается для одной строки набора),
//  - Изменение       Булево (необязательно, если набор для всех прав; устанавливается для одной строки набора),
//  - Удаление        Булево (необязательно, если набор для всех прав; устанавливается для одной строки набора).
//
//  Вызывается из процедуры УправлениеДоступом.ЗаписатьНаборыЗначенийДоступа(),
// если объект зарегистрирован в "ПодпискаНаСобытие.ЗаписатьНаборыЗначенийДоступа" и
// из таких же процедур объектов, у которых наборы значений доступа зависят от наборов этого
// объекта (в этом случае объект зарегистрирован в "ПодпискаНаСобытие.ЗаписатьЗависимыеНаборыЗначенийДоступа").
//
// Параметры:
//  Таблица      - ТабличнаяЧасть,
//                 РегистрСведенийНаборЗаписей.НаборыЗначенийДоступа,
//                 ТаблицаЗначений, возвращаемая УправлениеДоступом.ТаблицаНаборыЗначенийДоступа().
//
Процедура ЗаполнитьНаборыЗначенийДоступа(Таблица) Экспорт
	
	СтрокаТаб = Таблица.Добавить();
	СтрокаТаб.ВидДоступа      = ПланыВидовХарактеристик.ВидыДоступа.Организации;
	СтрокаТаб.ЗначениеДоступа = Организация;
	
	СтрокаТаб = Таблица.Добавить();
	СтрокаТаб.ВидДоступа      = ПланыВидовХарактеристик.ВидыДоступа.Склады;
	СтрокаТаб.ЗначениеДоступа = Склад;
	
	СтрокаТаб = Таблица.Добавить();
	СтрокаТаб.ВидДоступа      = ПланыВидовХарактеристик.ВидыДоступа.Подразделения;
	СтрокаТаб.ЗначениеДоступа = Подразделение;
	
КонецПроцедуры

// Устанавливает статус для объекта документа
//
// Параметры:
// 		НовыйСтатус - Строка - Имя статуса, который будет установлен у заказов
// 		ДополнительныеПараметры - Структура - Структура дополнительных параметров установки статуса
//
// Возвращаемое значение:
// 		Булево - Истина, в случае успешной установки нового статуса
//
Функция УстановитьСтатус(НовыйСтатус, ДополнительныеПараметры) Экспорт
	
	Статус = Перечисления.СтатусыВнутреннихПотребленийТоваров[НовыйСтатус];
	
	Возврат ПроверитьЗаполнение();
	
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)

	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	// Приведем тип незаполненного значения у реквизитов
	// - ЗаказНаВнутреннееПотребление табличной части Товары
	// - ДокументРезерваСерий табличной части Серии
	Для Каждого ДанныеСтроки Из Товары Цикл
		Если НЕ ЗначениеЗаполнено(ДанныеСтроки.ЗаказНаВнутреннееПотребление)
			 И ДанныеСтроки.ЗаказНаВнутреннееПотребление <> Неопределено Тогда

			ДанныеСтроки.ЗаказНаВнутреннееПотребление = Неопределено;

		КонецЕсли;
		Если НЕ ЗначениеЗаполнено(ДанныеСтроки.ДокументРезерваСерий)
			 И ДанныеСтроки.ДокументРезерваСерий <> Неопределено Тогда

			ДанныеСтроки.ДокументРезерваСерий = Неопределено;

		КонецЕсли;

	КонецЦикла;
	
	Для Каждого ДанныеСтроки Из Серии Цикл
		Если НЕ ЗначениеЗаполнено(ДанныеСтроки.ДокументРезерваСерий)
			 И ДанныеСтроки.ДокументРезерваСерий <> Неопределено Тогда

			ДанныеСтроки.ДокументРезерваСерий = Неопределено;

		КонецЕсли;
	КонецЦикла;

	ЗаказыСервер.ПроверитьДатуРаспоряжения(ЭтотОбъект);
	ПроведениеСервер.УстановитьРежимПроведения(ЭтотОбъект, РежимЗаписи, РежимПроведения);

	ДополнительныеСвойства.Вставить("ЭтоНовый",    ЭтоНовый());
	ДополнительныеСвойства.Вставить("РежимЗаписи", РежимЗаписи);

	НоменклатураСервер.УдалитьНеиспользуемыеСтрокиСерий(ЭтотОбъект,НоменклатураСервер.ПараметрыУказанияСерий(ЭтотОбъект, Документы.ВнутреннееПотреблениеТоваров));
	
	Если РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда
		ЗаполнитьВидыЗапасов(Отказ);
		ВзаиморасчетыСервер.ЗаполнитьИдентификаторыСтрокВТабличнойЧасти(Товары);
		ВзаиморасчетыСервер.ЗаполнитьИдентификаторыСтрокВТабличнойЧасти(ВидыЗапасов);
	КонецЕсли;
	
	// Очистим реквизиты документа не используемые для хозяйственной операции.
	МассивВсехРеквизитов = Новый Массив;
	МассивРеквизитовОперации = Новый Массив;
	Документы.ВнутреннееПотреблениеТоваров.ПолучитьМассивыРеквизитов(
		ХозяйственнаяОперация,
		МассивВсехРеквизитов,
		МассивРеквизитовОперации
	);
	ДенежныеСредстваСервер.ОчиститьНеиспользуемыеРеквизиты(
		ЭтотОбъект,
		МассивВсехРеквизитов,
		МассивРеквизитовОперации
	);

КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	Перем СкладПоступления;
	Перем РеквизитыШапки;
	
	Если
	 ТипЗнч(ДанныеЗаполнения) = Тип("Структура") И ДанныеЗаполнения.Свойство("ДокументОснование") Тогда
		
		ДанныеЗаполнения.Свойство("РеквизитыШапки", РеквизитыШапки);
		
		Если ДанныеЗаполнения.Свойство("ДатаОтгрузки") И ЗначениеЗаполнено(ДанныеЗаполнения.ДатаОтгрузки) Тогда
			Дата = ДанныеЗаполнения.ДатаОтгрузки;
		Иначе
			Дата = ЗаказыСервер.ПолучитьМаксимальнуюДатуОтгрузкиЗаказа(ДанныеЗаполнения.ДокументОснование);
		КонецЕсли;
		
		ЗаполнитьПоЗаказу(ДанныеЗаполнения.ДокументОснование, РеквизитыШапки);
		
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("Структура") И ДанныеЗаполнения.Свойство("Товары") Тогда
		
		ДанныеЗаполнения.Свойство("РеквизитыШапки", РеквизитыШапки);
		ЗаполнитьЗначенияСвойств(ЭтотОбъект, РеквизитыШапки);
		Товары.Загрузить(ДанныеЗаполнения.Товары.Выгрузить());
		
		ПараметрыУказанияСерий = НоменклатураСервер.ПараметрыУказанияСерий(ЭтотОбъект, Документы.ВнутреннееПотреблениеТоваров);	
		
		НоменклатураСервер.ЗаполнитьСерииПоЗаказам(ЭтотОбъект,ПараметрыУказанияСерий);
		НоменклатураСервер.ЗаполнитьСерииПоFEFO(ЭтотОбъект,ПараметрыУказанияСерий, Ложь);
		
	Иначе
		// Ввод из формы списка.
		
		Организация = ЗначениеНастроекПовтИсп.ПолучитьОрганизациюПоУмолчанию(Организация);
		Склад 		= ЗначениеНастроекПовтИсп.ПолучитьСкладПоУмолчанию(Склад);
		
	КонецЕсли;
	
	ИнициализироватьДокумент(ДанныеЗаполнения);
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Перем МассивВсехРеквизитов;
	Перем МассивРеквизитовОперации;
	
	Документы.ВнутреннееПотреблениеТоваров.ПолучитьМассивыРеквизитов(
		ХозяйственнаяОперация, 
		МассивВсехРеквизитов, 
		МассивРеквизитовОперации
	);
	
	МассивНепроверяемыхРеквизитов = Новый Массив;
	
	ОбщегоНазначенияУТКлиентСервер.ЗаполнитьМассивНепроверяемыхРеквизитов(
		МассивВсехРеквизитов,
		МассивРеквизитовОперации,
		МассивНепроверяемыхРеквизитов
	);
	
	// Проверка количества в т.ч. товары.
	ОбщегоНазначенияУТ.ПроверитьЗаполнениеКоличества(ЭтотОбъект, ПроверяемыеРеквизиты, Отказ);

	// Проверка характеристик в т.ч. товары.
	НоменклатураСервер.ПроверитьЗаполнениеХарактеристик(ЭтотОбъект,МассивНепроверяемыхРеквизитов,Отказ);
	
	// Проверка заполнения серий в т.ч. серии.
	НоменклатураСервер.ПроверитьЗаполнениеСерий(ЭтотОбъект,НоменклатураСервер.ПараметрыУказанияСерий(ЭтотОбъект, Документы.ВнутреннееПотреблениеТоваров),Отказ);
	
	// Если накладная по заказу - то код строки должен быть заполнен.
	Если Не ЗначениеЗаполнено(ЗаказНаВнутреннееПотребление) Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Товары.КодСтроки");
	КонецЕсли;

	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты,МассивНепроверяемыхРеквизитов);

КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)

	ПроведениеСервер.ИнициализироватьДополнительныеСвойстваДляПроведения(Ссылка, ДополнительныеСвойства, РежимПроведения);

	Документы.ВнутреннееПотреблениеТоваров.ИнициализироватьДанныеДокумента(Ссылка, ДополнительныеСвойства);

	ПроведениеСервер.ПодготовитьНаборыЗаписейКРегистрацииДвижений(ЭтотОбъект);

	ЗапасыСервер.ОтразитьТоварыНаСкладах(ДополнительныеСвойства, Движения, Отказ);
	ЗаказыСервер.ОтразитьТоварыКОтгрузке(ДополнительныеСвойства, Движения, Отказ);
	ЗаказыСервер.ОтразитьЗаказыНаВнутреннееПотребление(ДополнительныеСвойства, Движения, Отказ);
	ЗапасыСервер.ОтразитьТоварыОрганизаций(ДополнительныеСвойства, Движения, Отказ);
	ЗапасыСервер.ОтразитьТоварыОрганизацийКПередаче(ДополнительныеСвойства, Движения, Отказ);
	ЗапасыСервер.ОтразитьТоварыКОформлениюОтчетовКомитента(ДополнительныеСвойства, Движения, Отказ);
	ЗапасыСервер.ОтразитьРезервыСерийТоваров(ДополнительныеСвойства, Движения, Отказ);
	ДоходыИРасходыСервер.ОтразитьСебестоимостьТоваров(ДополнительныеСвойства, Движения, Отказ);
	ЗапасыСервер.ОтразитьСвободныеОстатки(ДополнительныеСвойства, Движения, Отказ);
	ЗаказыСервер.ОтразитьДвижениеТоваров(ДополнительныеСвойства, Движения, Отказ);
 	СкладыСервер.ОтразитьДвиженияСерийТоваров(ДополнительныеСвойства, Движения, Отказ);
	
	ЗапасыСервер.ОбеспечениеЗаказов(ДополнительныеСвойства, Движения, Отказ);
	
	ПартионныйУчетСервер.ОтразитьПартииТоваровОрганизацийПоследовательность(ДополнительныеСвойства, ПринадлежностьПоследовательностям, Отказ);
	
	СформироватьСписокРегистровДляКонтроля();

	ПроведениеСервер.ЗаписатьНаборыЗаписей(ЭтотОбъект);

	ПроведениеСервер.ВыполнитьКонтрольРезультатовПроведения(ЭтотОбъект, Отказ);
	
	СкладыСервер.ОтразитьСостоянияОтгрузки(Ссылка, Отказ);

	ПроведениеСервер.ОчиститьДополнительныеСвойстваДляПроведения(ДополнительныеСвойства);

КонецПроцедуры

Процедура ОбработкаУдаленияПроведения(Отказ)

	ПроведениеСервер.ИнициализироватьДополнительныеСвойстваДляПроведения(Ссылка, ДополнительныеСвойства);

	ПроведениеСервер.ПодготовитьНаборыЗаписейКРегистрацииДвижений(ЭтотОбъект);

	СформироватьСписокРегистровДляКонтроля();

	ПроведениеСервер.ЗаписатьНаборыЗаписей(ЭтотОбъект);

	ПроведениеСервер.ВыполнитьКонтрольРезультатовПроведения(ЭтотОбъект, Отказ);
	
	СкладыСервер.ОтразитьСостоянияОтгрузки(Ссылка, Отказ);

	ПроведениеСервер.ОчиститьДополнительныеСвойстваДляПроведения(ДополнительныеСвойства);

КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)

	ЗаказНаВнутреннееПотребление = Документы.ЗаказНаВнутреннееПотребление.ПустаяСсылка();
	СостояниеЗаполненияМногооборотнойТары = Перечисления.СостоянияЗаполненияМногооборотнойТары.ПустаяСсылка();
	ПотреблениеПоЗаказам = Ложь;

	ВидыЗапасов.Очистить();
	Серии.Очистить();
	
	Для Каждого СтрокаТЧ Из Товары Цикл

		СтрокаТЧ.КодСтроки                    = 0;
		СтрокаТЧ.ЗаказНаВнутреннееПотребление = Документы.ЗаказНаВнутреннееПотребление.ПустаяСсылка();
		СтрокаТЧ.ДокументРезерваСерий         = Неопределено;

	КонецЦикла;

	ИнициализироватьДокумент();

	Статус = Метаданные().Реквизиты.Статус.ЗначениеЗаполнения;

КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

////////////////////////////////////////////////////////////////////////////////
//Инициализация и заполнение

// Заполняет документ на основании заказа на внутреннее потребление или массива заказов
//
// Параметры:
// 		ДанныеЗаполнения - Массив, ДокументСсылка.ЗаказНаВнутреннееПотербление - Ссылка на документ заказа или массив ссылок
// 		РеквизитыШапки - 
//
Процедура ЗаполнитьПоЗаказу(ДанныеЗаполнения, РеквизитыШапки=Неопределено, ЗаполнятьНаДату = Истина)
	
	ТипДанныеЗаполнения = ТипЗнч(ДанныеЗаполнения);
	
	Если ТипДанныеЗаполнения = Тип("Массив") Тогда
		
		ЗаполнитьЗначенияСвойств(ЭтотОбъект, РеквизитыШапки);
		
	ИначеЕсли ТипДанныеЗаполнения = Тип("ДокументСсылка.ЗаказНаВнутреннееПотребление") Тогда
		
		ЗаказНаВнутреннееПотребление = ДанныеЗаполнения;
		
		Запрос = Новый Запрос(
		"ВЫБРАТЬ
		|	Заказы.Ссылка КАК ЗаказНаВнутреннееПотребление,
		|	Заказы.Организация КАК Организация,
		|	Заказы.Подразделение КАК Подразделение,
		|	Заказы.Склад КАК Склад,
		|	Заказы.Сделка КАК Сделка,
		|	Заказы.ХозяйственнаяОперация КАК ХозяйственнаяОперация,
		|	Заказы.Склад.УчетныйВидЦены КАК ВидЦены,
		|	(НЕ Заказы.Проведен) КАК ЕстьОшибкиПроведен,
		|	ВЫБОР
		|		КОГДА Заказы.Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыВнутреннихЗаказов.Закрыт)
		|				ИЛИ Заказы.Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыВнутреннихЗаказов.КВыполнению)
		|			ТОГДА ЛОЖЬ
		|		ИНАЧЕ ИСТИНА
		|	КОНЕЦ КАК ЕстьОшибкиСтатус,
		|	Заказы.Статус КАК СтатусДокумента
		|ИЗ
		|	Документ.ЗаказНаВнутреннееПотребление КАК Заказы
		|ГДЕ
		|	Заказы.Ссылка = &Заказ");
		Запрос.УстановитьПараметр("Заказ", ЗаказНаВнутреннееПотребление);
		РеквизитыЗаказа = Запрос.Выполнить().Выбрать();
		РеквизитыЗаказа.Следующий();
		
		МассивДопустимыхСтатусов = Новый Массив();
		МассивДопустимыхСтатусов.Добавить(Перечисления.СтатусыВнутреннихЗаказов.КВыполнению);
		МассивДопустимыхСтатусов.Добавить(Перечисления.СтатусыВнутреннихЗаказов.Закрыт);
		
		ОбщегоНазначенияУТ.ПроверитьВозможностьВводаНаОсновании(
			РеквизитыЗаказа.ЗаказНаВнутреннееПотребление,
			РеквизитыЗаказа.СтатусДокумента,
			РеквизитыЗаказа.ЕстьОшибкиПроведен,
			РеквизитыЗаказа.ЕстьОшибкиСтатус,
			МассивДопустимыхСтатусов
		);
		
		ЗаполнитьЗначенияСвойств(ЭтотОбъект, РеквизитыЗаказа);
		
	КонецЕсли;
	
	ПотреблениеПоЗаказам = Истина;
	
	Если ТипДанныеЗаполнения = Тип("Массив") Тогда
		МассивЗаказов = ДанныеЗаполнения;
	Иначе	
		МассивЗаказов = Новый Массив;
		МассивЗаказов.Добавить(ЗаказНаВнутреннееПотребление);
	КонецЕсли;
	
	Документы.ВнутреннееПотреблениеТоваров.ЗаполнитьПоОстаткамЗаказов(
		ЭтотОбъект,
		Товары,
		МассивЗаказов);

	ПараметрыУказанияСерий = НоменклатураСервер.ПараметрыУказанияСерий(ЭтотОбъект, Документы.ВнутреннееПотреблениеТоваров);	
	
	НоменклатураСервер.ЗаполнитьСерииПоЗаказам(ЭтотОбъект,ПараметрыУказанияСерий);
	НоменклатураСервер.ЗаполнитьСерииПоFEFO(ЭтотОбъект,ПараметрыУказанияСерий, Ложь);

	ЗаказыСервер.ЗаполнитьЗаказВШапкеПоЗаказамВТабличнойЧасти(ЗаказНаВнутреннееПотребление, Товары, "ЗаказНаВнутреннееПотребление");

КонецПроцедуры

Процедура ИнициализироватьДокумент(ДанныеЗаполнения = Неопределено)
	
	Организация = ЗначениеНастроекПовтИсп.ПолучитьОрганизациюПоУмолчанию(Организация);
	Склад = ЗначениеНастроекПовтИсп.ПолучитьСкладПоУмолчанию(Склад);
	
	Ответственный    = Пользователи.ТекущийПользователь();
	ДатаРаспоряжения = ТекущаяДата();
	Подразделение    = ЗначениеНастроекПовтИсп.ПодразделениеПользователя(Ответственный, Подразделение);
	ВидЦены          = Справочники.Склады.УчетныйВидЦены(Склад);
	
	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьСтатусыВнутреннихПотребленийТоваров") Тогда
		Статус = Перечисления.СтатусыВнутреннихПотребленийТоваров.Отгружено;
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
//Виды запасов

Функция ВременныеТаблицыДанныхДокумента() Экспорт
	
	Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|	&Дата КАК Дата,
	|	&Организация КАК Организация,
	|	&Склад КАК Склад,
	|	Неопределено КАК Партнер,
	|	Неопределено КАК Контрагент,
	|	ЗНАЧЕНИЕ(Справочник.СоглашенияСПоставщиками.ПустаяСсылка) КАК Соглашение,
	|	ЗНАЧЕНИЕ(Справочник.ДоговорыКонтрагентов.ПустаяСсылка) КАК Договор,
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК Валюта,
	|	&НалогообложениеНДС КАК НалогообложениеНДС,
	|	ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.СборкаТоваров) КАК ХозяйственнаяОперация,
	|	Ложь КАК ЕстьСделкиВТабличнойЧасти,
	|
	|	ВЫБОР КОГДА СтруктураПредприятия.ВариантОбособленногоУчетаТоваров = ЗНАЧЕНИЕ(Перечисление.ВариантыОбособленногоУчетаТоваров.ПоПодразделению)
	|		И &ФормироватьВидыЗапасовПоПодразделениямМенеджерам
	|	ТОГДА
	|		&Подразделение
	|	ИНАЧЕ
	|		ЗНАЧЕНИЕ(Справочник.СтруктураПредприятия.ПустаяСсылка)
	|	КОНЕЦ КАК Подразделение,
	|
	|	ВЫБОР КОГДА СтруктураПредприятия.ВариантОбособленногоУчетаТоваров = ЗНАЧЕНИЕ(Перечисление.ВариантыОбособленногоУчетаТоваров.ПоМенеджерамПодразделения)
	|		И &ФормироватьВидыЗапасовПоПодразделениямМенеджерам
	|	ТОГДА
	|		&Менеджер
	|	ИНАЧЕ
	|		ЗНАЧЕНИЕ(Справочник.Пользователи.ПустаяСсылка)
	|	КОНЕЦ КАК Менеджер,
	|
	|	ВЫБОР КОГДА ЕСТЬNULL(СделкиСКлиентами.ОбособленныйУчетТоваровПоСделке, Ложь)
	|		И &ФормироватьВидыЗапасовПоСделкам
	|	ТОГДА
	|		&Сделка
	|	ИНАЧЕ
	|		ЗНАЧЕНИЕ(Справочник.СделкиСКлиентами.ПустаяСсылка)
	|	КОНЕЦ КАК Сделка
	|	
	|ПОМЕСТИТЬ ТаблицаДанныхДокумента
	|ИЗ
	|	Справочник.Организации КАК Организации
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		Справочник.СтруктураПредприятия КАК СтруктураПредприятия
	|	ПО
	|		СтруктураПредприятия.Ссылка = &Подразделение
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		Справочник.СделкиСКлиентами КАК СделкиСКлиентами
	|	ПО
	|		СделкиСКлиентами.Ссылка = &Сделка
	|ГДЕ
	|	Организации.Ссылка = &Организация
	|;
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТаблицаТоваров.НомерСтроки КАК НомерСтроки,
	|	ТаблицаТоваров.Номенклатура КАК Номенклатура,
	|	ТаблицаТоваров.Характеристика КАК Характеристика,
	|	ТаблицаТоваров.Количество КАК Количество,
	|	ТаблицаТоваров.ДокументРеализации КАК ДокументРеализации,
	|	ТаблицаТоваров.СтатьяРасходов КАК СтатьяРасходов,
	|	ТаблицаТоваров.АналитикаРасходов КАК АналитикаРасходов,
	|	ТаблицаТоваров.ЗаказНаВнутреннееПотребление КАК Заказ,
	|	ТаблицаТоваров.КодСтроки КАК КодСтроки
	|	
	|ПОМЕСТИТЬ ВтТаблицаТоваров
	|ИЗ
	|	&ТаблицаТоваров КАК ТаблицаТоваров
	|;
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТаблицаТоваров.НомерСтроки КАК НомерСтроки,
	|	ТоварыЗаказа.Ссылка.Назначение КАК Назначение
	|	
	|ПОМЕСТИТЬ ВтТоварыПодЗаказ
	|ИЗ
	|	ВтТаблицаТоваров КАК ТаблицаТоваров
	|
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.ЗаказНаВнутреннееПотребление.Товары КАК ТоварыЗаказа
	|	ПО
	|		ТаблицаТоваров.Заказ = ТоварыЗаказа.Ссылка
	|		И ТаблицаТоваров.КодСтроки = ТоварыЗаказа.КодСтроки
	|		И ТаблицаТоваров.Номенклатура = ТоварыЗаказа.Номенклатура
	|		И ТаблицаТоваров.Характеристика = ТоварыЗаказа.Характеристика
	|ГДЕ
	|	ТаблицаТоваров.Заказ <> Неопределено
	|	И ТоварыЗаказа.ВариантОбеспечения = ЗНАЧЕНИЕ(Перечисление.ВариантыОбеспечения.ПодЗаказ)
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	НомерСтроки
	|;
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТаблицаТоваров.НомерСтроки КАК НомерСтроки,
	|	ТаблицаТоваров.Номенклатура КАК Номенклатура,
	|	ТаблицаТоваров.Характеристика КАК Характеристика,
	|	ТаблицаТоваров.Количество КАК Количество,
	|	&Склад КАК Склад,
	|	ТаблицаТоваров.ДокументРеализации КАК ДокументРеализации,
	|	&Сделка КАК Сделка,
	|	ЗНАЧЕНИЕ(Перечисление.СтавкиНДС.ПустаяСсылка) КАК СтавкаНДС,
	|	0 КАК СуммаСНДС,
	|	0 КАК СуммаНДС,
	|	0 КАК СуммаВознаграждения,
	|	0 КАК СуммаНДСВознаграждения,
	|	ТаблицаТоваров.СтатьяРасходов КАК СтатьяРасходов,
	|	ТаблицаТоваров.АналитикаРасходов КАК АналитикаРасходов,
	|	ЕСТЬNULL(ТоварыПодЗаказ.Назначение, ЗНАЧЕНИЕ(Справочник.Назначения.ПустаяСсылка)) КАК Назначение
	|	
	|ПОМЕСТИТЬ ТаблицаТоваров
	|ИЗ
	|	ВтТаблицаТоваров КАК ТаблицаТоваров
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		ВтТоварыПодЗаказ КАК ТоварыПодЗаказ
	|	ПО
	|		ТаблицаТоваров.НомерСтроки = ТоварыПодЗаказ.НомерСтроки
	|;
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТаблицаВидыЗапасов.НомерСтроки КАК НомерСтроки,
	|	ТаблицаВидыЗапасов.Номенклатура КАК Номенклатура,
	|	ТаблицаВидыЗапасов.Характеристика КАК Характеристика,
	|	ТаблицаВидыЗапасов.ДокументРеализации КАК ДокументРеализации,
	|	ТаблицаВидыЗапасов.ВидЗапасов КАК ВидЗапасов,
	|	ТаблицаВидыЗапасов.НомерГТД КАК НомерГТД,
	|	ТаблицаВидыЗапасов.Количество КАК Количество,
	|	ЗНАЧЕНИЕ(Справочник.Склады.ПустаяСсылка) КАК СкладОтгрузки,
	|	&Склад КАК Склад,
	|	&Сделка КАК Сделка,
	|	ТаблицаВидыЗапасов.СтатьяРасходов КАК СтатьяРасходов,
	|	ТаблицаВидыЗапасов.АналитикаРасходов КАК АналитикаРасходов
	|	
	|ПОМЕСТИТЬ ТаблицаВидыЗапасов
	|ИЗ
	|	&ТаблицаВидыЗапасов КАК ТаблицаВидыЗапасов
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Номенклатура,
	|	Характеристика
	|");
	
	МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.УстановитьПараметр("Дата", Дата);
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("Склад", Склад);
	Запрос.УстановитьПараметр("Менеджер", Ответственный);
	Запрос.УстановитьПараметр("Подразделение", Подразделение);
	Запрос.УстановитьПараметр("Сделка", Сделка);
	Запрос.УстановитьПараметр("ХозяйственнаяОперация", ХозяйственнаяОперация);
	Запрос.УстановитьПараметр("НалогообложениеНДС", ПотреблениеДляДеятельности);
	Запрос.УстановитьПараметр("ФормироватьВидыЗапасовПоПодразделениямМенеджерам", ПолучитьФункциональнуюОпцию("ФормироватьВидыЗапасовПоПодразделениямМенеджерам"));
	Запрос.УстановитьПараметр("ФормироватьВидыЗапасовПоСделкам", ПолучитьФункциональнуюОпцию("ФормироватьВидыЗапасовПоСделкам"));
	Запрос.УстановитьПараметр("ТаблицаТоваров", ЗапасыСервер.ТаблицаДополненнаяОбязательнымиКолонками(Товары.Выгрузить()));
	Запрос.УстановитьПараметр("ТаблицаВидыЗапасов", ЗапасыСервер.ТаблицаДополненнаяОбязательнымиКолонками(ВидыЗапасов.Выгрузить()));
	
	Запрос.Выполнить();
	
	Если ВидыЗапасовУказаныВручную Тогда
		ДополнительныеСвойства.Вставить("ИспользоватьОстаткиНаКонецМесяца", Истина);
	КонецЕсли;
	
	Возврат МенеджерВременныхТаблиц;
	
КонецФункции

Процедура СформироватьВременнуюТаблицуТоваровИАналитики(МенеджерВременныхТаблиц) Экспорт
	
	Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|	ТаблицаТоваров.Номенклатура КАК Номенклатура,
	|	ТаблицаТоваров.Характеристика КАК Характеристика,
	|	ТаблицаТоваров.Склад КАК Склад,
	|
	|	ТаблицаДанныхДокумента.Подразделение,
	|	ТаблицаДанныхДокумента.Менеджер,
	|	ТаблицаДанныхДокумента.Сделка,
	|	ТаблицаТоваров.Назначение КАК Назначение,
	|
	|	ЗНАЧЕНИЕ(Справочник.Партнеры.ПустаяСсылка) КАК Партнер,
	|	ЗНАЧЕНИЕ(Справочник.СоглашенияСПоставщиками.ПустаяСсылка) КАК Соглашение,
	|	ЗНАЧЕНИЕ(Перечисление.ТипыНалогообложенияНДС.ПустаяСсылка) КАК НалогообложениеНДС,
	|
	|	ТаблицаТоваров.Количество КАК Количество
	|	
	|ПОМЕСТИТЬ ТаблицаТоваровИАналитики
	|ИЗ
	|	ТаблицаТоваров КАК ТаблицаТоваров
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		ТаблицаДанныхДокумента КАК ТаблицаДанныхДокумента
	|	ПО
	|		Истина
	|;
	|");
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	Запрос.Выполнить();
	
КонецПроцедуры

Функция ПроверитьИзменениеРеквизитовДокумента(МенеджерВременныхТаблиц)
	
	Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|	ДанныеДокумента.Организация КАК Организация,
	|	ДанныеДокумента.Склад КАК Склад,
	|	ВЫБОР КОГДА ДанныеДокумента.Подразделение.ВариантОбособленногоУчетаТоваров = ЗНАЧЕНИЕ(Перечисление.ВариантыОбособленногоУчетаТоваров.ПоПодразделению)
	|		И &ФормироватьВидыЗапасовПоПодразделениямМенеджерам
	|		И Не ЕСТЬNULL(ДанныеДокумента.Сделка.ОбособленныйУчетТоваровПоСделке, Ложь)
	|	ТОГДА
	|		ДанныеДокумента.Подразделение
	|	ИНАЧЕ
	|		ЗНАЧЕНИЕ(Справочник.СтруктураПредприятия.ПустаяСсылка)
	|	КОНЕЦ КАК Подразделение,
	|
	|	ВЫБОР КОГДА ДанныеДокумента.Подразделение.ВариантОбособленногоУчетаТоваров = ЗНАЧЕНИЕ(Перечисление.ВариантыОбособленногоУчетаТоваров.ПоМенеджерамПодразделения)
	|		И &ФормироватьВидыЗапасовПоПодразделениямМенеджерам
	|		И Не ЕСТЬNULL(ДанныеДокумента.Сделка.ОбособленныйУчетТоваровПоСделке, Ложь)
	|	ТОГДА
	|		ДанныеДокумента.Ответственный
	|	ИНАЧЕ
	|		ЗНАЧЕНИЕ(Справочник.Пользователи.ПустаяСсылка)
	|	КОНЕЦ КАК Менеджер,
	|
	|	ВЫБОР КОГДА ЕСТЬNULL(ДанныеДокумента.Сделка.ОбособленныйУчетТоваровПоСделке, Ложь)
	|		И &ФормироватьВидыЗапасовПоСделкам
	|	ТОГДА
	|		ДанныеДокумента.Сделка
	|	ИНАЧЕ
	|		ЗНАЧЕНИЕ(Справочник.СделкиСКлиентами.ПустаяСсылка)
	|	КОНЕЦ КАК Сделка
	|
	|ПОМЕСТИТЬ СохраненныеДанныеДокумента
	|ИЗ
	|	Документ.ВнутреннееПотреблениеТоваров КАК ДанныеДокумента
	|ГДЕ
	|	ДанныеДокумента.Ссылка = &Ссылка
	|;
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВЫБОР КОГДА ДанныеДокумента.Организация <> СохраненныеДанные.Организация ТОГДА
	|		Истина
	|	КОГДА ДанныеДокумента.Склад <> СохраненныеДанные.Склад ТОГДА
	|		Истина
	|	КОГДА ДанныеДокумента.Подразделение <> СохраненныеДанные.Подразделение ТОГДА
	|		Истина
	|	КОГДА ДанныеДокумента.Менеджер <> СохраненныеДанные.Менеджер ТОГДА
	|		Истина
	|	КОГДА ДанныеДокумента.Сделка <> СохраненныеДанные.Сделка ТОГДА
	|		Истина
	|	ИНАЧЕ
	|		Ложь
	|	КОНЕЦ КАК РеквизитыИзменены
	|ИЗ
	|	ТаблицаДанныхДокумента КАК ДанныеДокумента
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		СохраненныеДанныеДокумента КАК СохраненныеДанные
	|	ПО
	|		Истина
	|");
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.УстановитьПараметр("ФормироватьВидыЗапасовПоПодразделениямМенеджерам", ПолучитьФункциональнуюОпцию("ФормироватьВидыЗапасовПоПодразделениямМенеджерам"));
	Запрос.УстановитьПараметр("ФормироватьВидыЗапасовПоСделкам", ПолучитьФункциональнуюОпцию("ФормироватьВидыЗапасовПоСделкам"));
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		РеквизитыИзменены = Выборка.РеквизитыИзменены;
	Иначе
		РеквизитыИзменены = Ложь;
	КонецЕсли;
	
	Возврат РеквизитыИзменены;
	
КонецФункции

Процедура СформироватьДоступныеВидыЗапасов(МенеджерВременныхТаблиц) Экспорт
	
	ЗапасыСервер.ВидыЗапасовНеОбособленныеИОбособленные(
		Организация,
		Сделка,
		Ответственный,
		Подразделение,
		МенеджерВременныхТаблиц
	);
	
КонецПроцедуры

Процедура СообщитьОбОшибкахЗаполненияВидовЗапасов(ТаблицаОшибок, МенеджерВременныхТаблиц)
	
	Если ТаблицаОшибок.Количество() > 0 Тогда
		
		СтруктураАналитики = ЗапасыСервер.АналитикаОбособленноУчетаДокумента(МенеджерВременныхТаблиц);
				
		ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Списание превышает остаток товара организации %1 на складе %2 %3 %4'"),
			Организация,
			Склад,
			СтруктураАналитики.СтрокаАналитики,
			СтруктураАналитики.Аналитика
		);
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			ТекстСообщения,
			ЭтотОбъект
		);
	
		Для Каждого СтрокаТаблицы Из ТаблицаОшибок Цикл
			
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Номенклатура: %1, недостаточно %2 %3'"),
				НоменклатураКлиентСервер.ПредставлениеНоменклатуры(СтрокаТаблицы.Номенклатура, СтрокаТаблицы.Характеристика),
				СтрокаТаблицы.Количество,
				СтрокаТаблицы.ЕдиницаИзмерения
			);
			Если СтрокаТаблицы.НеУказанНомерГТД Тогда
				ТекстСообщения = ТекстСообщения + НСтр("ru = ' с указанными номерами ГТД'");
			КонецЕсли;
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
				ТекстСообщения,
				Ссылка
			);
			
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ЗаполнитьВидыЗапасов(Отказ)
	
	УстановитьПривилегированныйРежим(Истина);
	
	МенеджерВременныхТаблиц = ВременныеТаблицыДанныхДокумента();
	ПерезаполнитьВидыЗапасов = ДополнительныеСвойства.Свойство("ПерезаполнитьВидыЗапасов");
	Если Не Проведен
	 ИЛИ ПерезаполнитьВидыЗапасов
	 ИЛИ ПроверитьИзменениеРеквизитовДокумента(МенеджерВременныхТаблиц)
	 ИЛИ ПроверитьИзменениеТоваров(МенеджерВременныхТаблиц) Тогда
	 
		СформироватьДоступныеВидыЗапасов(МенеджерВременныхТаблиц);
		ЗапасыСервер.УстановитьБлокировкуОстатковТоваровОрганизаций(МенеджерВременныхТаблиц);
		ЗапасыСервер.ТаблицаОстатковТоваровОрганизаций(Ссылка, Организация, Дата, ДополнительныеСвойства, МенеджерВременныхТаблиц);
		ТаблицаОшибок = ЗапасыСервер.ТаблицаОшибокЗаполненияВидовЗапасов();
		
		ЗапасыСервер.ЗаполнитьВидыЗапасовДокумента(
			МенеджерВременныхТаблиц,
			ДополнительныеСвойства,
			ВидыЗапасов,
			ТаблицаОшибок,
			Отказ
		);
		ВидыЗапасов.Свернуть("Номенклатура, Характеристика, ВидЗапасов, НомерГТД", "Количество");
		ЗаполнитьСтатьюРасходовВидовЗапасов();
		СообщитьОбОшибкахЗаполненияВидовЗапасов(ТаблицаОшибок, МенеджерВременныхТаблиц);
		
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
//Прочее

Процедура СформироватьСписокРегистровДляКонтроля()

	Массив = Новый Массив;
	// Контроль при перепроведении и отмене проведения
	Если Не ДополнительныеСвойства.ЭтоНовый Тогда
		Массив.Добавить(Движения.ТоварыКОтгрузке);
	КонецЕсли;

	Если ДополнительныеСвойства.РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда
		Массив.Добавить(Движения.ЗаказыНаВнутреннееПотребление);
		Массив.Добавить(Движения.ДвижениеТоваров);
		Массив.Добавить(Движения.СвободныеОстатки);
		Если НоменклатураСервер.ПараметрыУказанияСерий(ЭтотОбъект, Документы.ВнутреннееПотреблениеТоваров).ИспользоватьСерииНоменклатуры Тогда
			Массив.Добавить(Движения.РезервыСерийТоваров);
			Массив.Добавить(Движения.ТоварыНаСкладах);
		КонецЕсли;
	КонецЕсли;

	Массив.Добавить(Движения.ОбеспечениеЗаказов);
	
	ДополнительныеСвойства.ДляПроведения.Вставить("РегистрыДляКонтроля", Массив);

КонецПроцедуры

// Функция проверят изменение табличной части "Товары" относительно табличной части "Виды запасов" документа.
//
// Параметры:
//	МенеджерВременныхТаблиц - Менеджер временных таблиц
//
// Возвращаемое значение:
//	Булево - Истина - товары изменены
//           Ложь - товары не изменены
//
Функция ПроверитьИзменениеТоваров(МенеджерВременныхТаблиц)
	
	Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|	ТаблицаТоваров.Номенклатура КАК Номенклатура,
	|	ТаблицаТоваров.Характеристика КАК Характеристика
	|ИЗ (
	|	ВЫБРАТЬ
	|		ТаблицаТоваров.Номенклатура КАК Номенклатура,
	|		ТаблицаТоваров.Характеристика КАК Характеристика,
	|		ТаблицаТоваров.СтатьяРасходов КАК СтатьяРасходов,
	|		ТаблицаТоваров.АналитикаРасходов КАК АналитикаРасходов,
	|		ТаблицаТоваров.Назначение КАК Назначение,
	|		ТаблицаТоваров.Количество КАК Количество
	|	ИЗ
	|		ТаблицаТоваров КАК ТаблицаТоваров
	|
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		ТаблицаВидыЗапасов.Номенклатура КАК Номенклатура,
	|		ТаблицаВидыЗапасов.Характеристика КАК Характеристика,
	|		ТаблицаВидыЗапасов.СтатьяРасходов КАК СтатьяРасходов,
	|		ТаблицаВидыЗапасов.АналитикаРасходов КАК АналитикаРасходов,
	|		ТаблицаВидыЗапасов.ВидЗапасов.Назначение КАК Назначение,
	|		-ТаблицаВидыЗапасов.Количество КАК Количество
	|	ИЗ
	|		ТаблицаВидыЗапасов КАК ТаблицаВидыЗапасов
	|
	|	) КАК ТаблицаТоваров
	|
	|СГРУППИРОВАТЬ ПО
	|	ТаблицаТоваров.Номенклатура,
	|	ТаблицаТоваров.Характеристика,
	|	ТаблицаТоваров.СтатьяРасходов,
	|	ТаблицаТоваров.АналитикаРасходов,
	|	ТаблицаТоваров.Назначение
	|
	|ИМЕЮЩИЕ
	|	СУММА(ТаблицаТоваров.Количество) <> 0
	|");
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;

	РезультатЗапрос = Запрос.Выполнить();
	
	Возврат (Не РезультатЗапрос.Пустой());
	
КонецФункции

// Процедура заполняет статью и аналитику расходов видов запасов документа.
//
Процедура ЗаполнитьСтатьюРасходовВидовЗапасов()
	
	СтруктураПоиска = Новый Структура("Номенклатура, Характеристика");
	Для Каждого СтрокаТоваров Из Товары Цикл

		КоличествоТоваров = СтрокаТоваров.Количество;
		
		ЗаполнитьЗначенияСвойств(СтруктураПоиска, СтрокаТоваров);
		Для Каждого СтрокаЗапасов Из ВидыЗапасов.НайтиСтроки(СтруктураПоиска) Цикл

			Если СтрокаЗапасов.Количество = 0 Тогда
				Продолжить;
			КонецЕсли;
			
			Количество = Мин(КоличествоТоваров, СтрокаЗапасов.Количество);

			НоваяСтрока = ВидыЗапасов.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаЗапасов);
			
			НоваяСтрока.СтатьяРасходов = СтрокаТоваров.СтатьяРасходов;
			НоваяСтрока.АналитикаРасходов = СтрокаТоваров.АналитикаРасходов;
			НоваяСтрока.ФизическоеЛицо = СтрокаТоваров.ФизическоеЛицо;
			НоваяСтрока.Количество = Количество;

			СтрокаЗапасов.Количество = СтрокаЗапасов.Количество - НоваяСтрока.Количество;
			
			КоличествоТоваров = КоличествоТоваров - НоваяСтрока.Количество;

			Если КоличествоТоваров = 0 Тогда
				Прервать;
			КонецЕсли;

		КонецЦикла;
		
	КонецЦикла;
	
	МассивУдаляемыхСтрок = ВидыЗапасов.НайтиСтроки(Новый Структура("Количество", 0));
	Для Каждого СтрокаТаблицы Из МассивУдаляемыхСтрок Цикл
		ВидыЗапасов.Удалить(СтрокаТаблицы);
	КонецЦикла;
		
КонецПроцедуры // ЗаполнитьСтатьюРасходовВидовЗапасов()

#КонецЕсли
