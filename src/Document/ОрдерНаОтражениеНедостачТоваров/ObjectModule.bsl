﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ 

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)

	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
    
	Если СкладыСервер.ИспользоватьАдресноеХранение(Склад,Помещение) Тогда
		ПроверитьБлокировкуЯчеек(Отказ);
		Если Отказ Тогда
			Возврат;
		КонецЕсли;
	КонецЕсли;

	ПроведениеСервер.УстановитьРежимПроведения(ЭтотОбъект, РежимЗаписи, РежимПроведения);

	ДополнительныеСвойства.Вставить("ЭтоНовый",    ЭтоНовый());
	ДополнительныеСвойства.Вставить("РежимЗаписи", РежимЗаписи);

КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	ПроведениеСервер.ИнициализироватьДополнительныеСвойстваДляПроведения(Ссылка, ДополнительныеСвойства, РежимПроведения);

	Документы.ОрдерНаОтражениеНедостачТоваров.ИнициализироватьДанныеДокумента(Ссылка, ДополнительныеСвойства);

	ПроведениеСервер.ПодготовитьНаборыЗаписейКРегистрацииДвижений(ЭтотОбъект);

	ЗапасыСервер.ОтразитьТоварыНаСкладах(ДополнительныеСвойства, Движения, Отказ);
	ЗапасыСервер.ОтразитьТоварыКОформлениюИзлишковНедостач(ДополнительныеСвойства, Движения, Отказ);
	ЗапасыСервер.ОтразитьСвободныеОстатки(ДополнительныеСвойства, Движения, Отказ);
	
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

	ИнициализироватьДокумент();

КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	МассивНепроверяемыхРеквизитов = Новый Массив;

	ОбщегоНазначенияУТ.ПроверитьЗаполнениеКоличества(ЭтотОбъект, ПроверяемыеРеквизиты, Отказ);
	
	Если Не СкладыСервер.ИспользоватьАдресноеХранение(Склад,Помещение) Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Товары.Ячейка");
		МассивНепроверяемыхРеквизитов.Добавить("Товары.Упаковка");
	ИначеЕсли Не ПолучитьФункциональнуюОпцию("ИспользоватьУпаковкиНоменклатуры") Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Товары.Упаковка");
		ТекстСообщения = НСтр("ru='В настройках программы не включено использование упаковок номенклатуры, 
		|поэтому нельзя оформить документ по складу с адресным хранением остатков. Обратитесь к администратору'");
		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,,,,Отказ);
	КонецЕсли;
	МассивНепроверяемыхРеквизитов.Добавить("ДокументОснование");
	
	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьСкладскиеПомещения", Новый Структура("Склад", Склад)) Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Помещение");
	КонецЕсли;
	НоменклатураСервер.ПроверитьЗаполнениеХарактеристик(ЭтотОбъект,МассивНепроверяемыхРеквизитов,Отказ);
	НоменклатураСервер.ПроверитьЗаполнениеСерий(ЭтотОбъект,
НоменклатураСервер.ПараметрыУказанияСерий(ЭтотОбъект, 		Документы.ОрдерНаОтражениеНедостачТоваров),Отказ,МассивНепроверяемыхРеквизитов);
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов);
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	ИнициализироватьДокумент(ДанныеЗаполнения);
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

////////////////////////////////////////////////////////////////////////////////
// Инициализация и заполнение

Процедура ИнициализироватьДокумент(ДанныеЗаполнения = Неопределено)

	Ответственный = Пользователи.ТекущийПользователь();
	Склад         = ЗначениеНастроекПовтИсп.ПолучитьСкладПоУмолчанию(Склад);

КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Прочее

Процедура ПроверитьБлокировкуЯчеек(Отказ)
	
	Блокировка = Новый БлокировкаДанных;
	ЭлементБлокировки = Блокировка.Добавить("РегистрСведений.БлокировкиСкладскихЯчеек");
	ЭлементБлокировки.Режим          = РежимБлокировкиДанных.Разделяемый;
	ЭлементБлокировки.ИсточникДанных = Товары;
	ЭлементБлокировки.ИспользоватьИзИсточникаДанных("Ячейка", "Ячейка");
	
	Блокировка.Заблокировать();
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	БлокировкиСкладскихЯчеек.Ячейка КАК Ячейка,
	|	БлокировкиСкладскихЯчеек.ТипБлокировки КАК ТипБлокировки
	|ИЗ
	|	РегистрСведений.БлокировкиСкладскихЯчеек КАК БлокировкиСкладскихЯчеек
	|ГДЕ
	|	БлокировкиСкладскихЯчеек.Ячейка В (&МассивЯчеек)
	|
	|СГРУППИРОВАТЬ ПО
	|	БлокировкиСкладскихЯчеек.Ячейка,
	|	БлокировкиСкладскихЯчеек.ТипБлокировки
	|
	|УПОРЯДОЧИТЬ ПО
	|	Ячейка";
	
	Запрос.УстановитьПараметр("МассивЯчеек", Товары.ВыгрузитьКолонку("Ячейка"));
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		ТекстСообщения = НСтр("ru='Ячейка %Ячейка% заблокирована: тип блокировки ""%ТипБлокировки%""'");
		ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Ячейка%", Выборка.Ячейка);
		ТекстСообщения = СтрЗаменить(ТекстСообщения, "%ТипБлокировки%", Выборка.ТипБлокировки);
		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,,,,Отказ);
	КонецЦикла;
	
КонецПроцедуры

Процедура СформироватьСписокРегистровДляКонтроля()

	Массив = Новый Массив;
	
	ДополнительныеСвойства.ДляПроведения.Вставить("РегистрыДляКонтроля", Массив);

КонецПроцедуры

#КонецЕсли