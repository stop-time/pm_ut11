﻿////////////////////////////////////////////////////////////////////////////////
// ПРОГРАММНЫЙ ИНТЕРФЕЙС

// Возвращает список процедур-обработчиков обновления библиотеки для всех поддерживаемых версий ИБ.
//
// Пример добавления процедуры-обработчика в список:
//    Обработчик = Обработчики.Добавить();
//    Обработчик.Версия = "1.0.0.0";
//    Обработчик.Процедура = "ОбновлениеИБ.ПерейтиНаВерсию_1_0_0_0";
//    Обработчик.Опциональный = Истина;
//
// Вызывается перед началом обновления данных ИБ.
//
Функция ОбработчикиОбновления() Экспорт
	
	Обработчики = ОбновлениеИнформационнойБазы.НоваяТаблицаОбработчиковОбновления();
	
	// Обработчики, выполняемые при каждом обновлении ИБ
	
	// Обработчики, выполняемые при заполнении пустой ИБ
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "0.0.0.1";
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыУТ.ПервыйЗапуск";
	
	// Обработчики обновления новых версий
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Справочники.Организации.ЗаполнитьРеквизитЮридическоеФизическоеЛицо";
	Обработчик.Опциональный = Истина;
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Документы.ЗаказКлиента.ЗаполнитьСпособДоставкиСамовывоз";
	Обработчик.Опциональный = Истина;
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Документы.ЗаявкаНаВозвратТоваровОтКлиента.ЗаполнитьСпособДоставкиСамовывоз";
	Обработчик.Опциональный = Истина;
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Документы.КоммерческоеПредложениеКлиенту.ЗаполнитьСпособДоставкиСамовывоз";
	Обработчик.Опциональный = Истина;
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Документы.ПеремещениеТоваров.ЗаполнитьСпособДоставкиСамовывоз";
	Обработчик.Опциональный = Истина;
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Документы.РеализацияТоваровУслуг.ЗаполнитьСпособДоставкиСамовывоз";
	Обработчик.Опциональный = Истина;
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Справочники.ТранспортныеСредства.ЗаполнитьВместимостьПредставлениеТранспортныхСредств";
	Обработчик.Опциональный = Истина;
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Справочники.КонтактныеЛицаПартнеров.ЗаполнитьДанныеФизическогоЛица";
	Обработчик.Опциональный = Истина;
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Справочники.Партнеры.УстановитьЗначениеКонстантИспользованиеПартнеровИКонтрагентов";
	Обработчик.Опциональный = Истина;
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Справочники.Партнеры.УстановитьЗначениеРеквизитаЮрФизЛицо";
	Обработчик.Опциональный = Истина;
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Справочники.Контрагенты.ЗаполнитьДокументыКонтрагентовПоДокументамФизЛиц";
	Обработчик.Опциональный = Истина;
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыУТ.ЗаполнитьКонстантыИспользованияСтатусовЗаказов";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыУТ.ЗаполнитьКонстантыИспользованияВнутреннегоСогласованияПродажИВозвратов";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Документы.ЗаявкаНаРасходованиеДенежныхСредств.ЗаполнениеПланированияСуммы";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Справочники.Склады.ЗаполнитьИсточникИнформацииОЦенахДляПечати";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Документы.РаспоряжениеНаИнвентаризациюТоваров.ЗаполнитьИсточникИнформацииОЦенахДляПечати";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Документы.ПересчетТоваров.ЗаполнитьИсточникИнформацииОЦенахДляПечати";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Документы.СписаниеНедостачТоваров.ЗаполнитьИсточникИнформацииОЦенахДляПечати";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Документы.ПорчаТоваров.ЗаполнитьИсточникИнформацииОЦенахДляПечати";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Справочники.Склады.ВключитьИспользованиеОрдерныхСкладов_РаспоряженийНаИнвентаризациюТоваров";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Справочники.Номенклатура.ЗаполнитьПометкуЕстьТоварыДругогоКачества";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Справочники.Номенклатура.ЗаполнитьИспользованиеХарактеристик";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыУТ.ЗаполнитьКонстантуИспользованияСоглашенийСКлиентами";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыУТ.ЗаполнитьКонстантыИспользоватьНесколькоОрганизацийРасчетныхСчетовКасс";

	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыУТ.ЗаполнитьКонстантуИспользоватьНесколькоВалют";

	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыУТ.ЗаполнитьКонстантуИспользоватьНесколькоСкладов";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыУТ.ЗаполнитьКонстантуИспользоватьНесколькоКлассификацийЗадолженности";

	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыУТ.ЗаполнитьКонстантуИспользоватьПричиныОтменыЗаказовПоставщикам";

	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыУТ.ЗаполнитьКонстантуИспользоватьПричиныОтменыЗаказовКлиентов";

	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыУТ.ЗаполнитьКонстантуИспользоватьДоговорыСКлиентами";

	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыУТ.ЗаполнитьКонстантуИспользоватьДоговорыСПоставщиками";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыУТ.ЗаполнитьКонстантуИспользоватьМониторингЦелевыхПоказателей";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыУТ.ЗаполнитьКонстантуНеФормироватьФинансовыйРезультат";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Справочники.ОтветственныеЛицаОрганизаций.ПеренестиДанныеИзСправочникаОрганизации";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "РегистрыНакопления.ЗаказыНаВнутреннееПотребление.ЗаполнитьСкладВРегистре";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Справочники.ХарактеристикиНоменклатуры.УстановитьКонстантуДобавлятьИндивидуальныеХарактеристики";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Справочники.УпаковкиНоменклатуры.УстановитьКонстантуДобавлятьИндивидуальныеУпаковки";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "ВзаиморасчетыСервер.ЗаполнитьПорядокРасчетов";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Документы.ТаможеннаяДекларацияИмпорт.ПеренестиНомерГТДВТовары";

	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Документы.ПеремещениеТоваров.ЗаполнитьВидыЗапасовПолучателей";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "ПланыВидовХарактеристик.СтатьиРасходов.ЗаполнитьВариантРаздельногоУчетаНДС";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Справочники.ВидыЗапасов.ЗаполнитьНалогообложениеНДС";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Документы.ВводОстатков.ЗаполнитьСуммуРеглВТаблЧастях";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Документы.ВводОстатков.ЗаполнитьРеквизитыНДСВТаблЧастях";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Документы.ВводОстатков.ЗаполнитьКоличествоУпаковокПоКоличеству";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Документы.ЗаписьКнигиПокупок.ЗаполнитьДатуПолученияИСобытие";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Документы.ЗаписьКнигиПродаж.ЗаполнитьСобытие";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыУТ.ПереименоватьСхемыКомпоновкиДанныхВидовЦен";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "ВариантыОтчетовУТПереопределяемый.НастроитьВариантыОтчетовПоФункциональнымОпциям";
	Обработчик.Опциональный = Истина;
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Документы.КорректировкаРеализации.ЗаполнитьХозяйственнуюОперацию";
	Обработчик.Опциональный = Истина;
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Документы.КорректировкаПоступления.ЗаполнитьХозяйственнуюОперацию";
	Обработчик.Опциональный = Истина;
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Документы.СборкаТоваров.ЗаполнитьРеквизитСборкаПодДеятельность";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Документы.ПередачаТоваровМеждуОрганизациями.ЗаполнитьРеквизитПередачаПодДеятельность";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Документы.ЗаказПоставщику.ЗаполнитьРеквизитЗакупкаПодДеятельность";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Документы.ПоступлениеТоваровУслуг.ЗаполнитьРеквизитЗакупкиПодДеятельность";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Документы.СчетФактураВыданныйАванс.ЗаполнитьПравилоОтбораАвансов";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Справочники.Номенклатура.ЗаполнитьКодДляПоиска";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыУТ.ОбновитьТипОбъектовАвторизацииГруппыВнешнихПользователейВсеВнешниеПользователи";

	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Справочники.Склады.ВключитьИспользованиеРабочихУчастков";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Справочники.Склады.ВключитьИспользованиеСтатусовОрдеров";

	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Справочники.СкладскиеПомещения.ВключитьИспользованиеРабочихУчастков";

	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "РегистрыСведений.НастройкиАдресныхСкладов.ЗаполнитьНастройкиАдресныхСкладов";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "РегистрыСведений.СостоянияОтгрузки.ОтразитьСостоянияОтгрузки";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "РегистрыСведений.НДССостояниеРеализации0.ЗаполнитьПоДаннымПодтвержденияНулевойСтавкиНДС";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "Документы.СчетФактураВыданный.УстановитьРежимПроведен";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "11.1.0.0";
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыУТ.ЗаполнитьКонстантыИспользоватьПрочиеДоходыРасходыФинансовыйРезультат";
	
	Возврат Обработчики;
	
КонецФункции

 // Возвращает номер версии библиотеки УправлениеТорговлей.
//
Функция ВерсияБиблиотеки() Экспорт
	
	Возврат "11.1.1.1";
	
КонецФункции

// Неинтерактивное обновление данных ИБ при смене версии библиотеки.
// Обязательная "точка входа" обновления ИБ в библиотеке.
//
Процедура ВыполнитьОбновлениеИнформационнойБазы() Экспорт
	
	ОбновлениеИнформационнойБазы.ВыполнитьИтерациюОбновления(
		"УправлениеТорговлей",
		ВерсияБиблиотеки(), 
		ОбработчикиОбновления()
	);
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Регулярные обработчики для каждого обновления ИБ.

// Обработчик обновления каждой версии УТ 11.
// Обновляет поставляемые профили и группы доступа.
//
Процедура ОбновитьПрофилиГруппДоступа() Экспорт

	УстановитьПривилегированныйРежим(Истина);

	//УправлениеДоступомСлужебный.ОбновитьПараметрыОграниченияДоступа();
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ПрофилиГруппДоступа.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.ПрофилиГруппДоступа КАК ПрофилиГруппДоступа
	|ГДЕ
	|	ПрофилиГруппДоступа.Предопределенный
	|	И (НЕ ПрофилиГруппДоступа.ЭтоГруппа)";
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		Выборка.Ссылка.ПолучитьОбъект().Записать();
	КонецЦикла;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Заполнения пустой ИБ.

// Проверяет необходимость открытия диалога начальной настройки программы.
//
Функция НеобходимаНачальнаяНастройкаПрограммы() Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	1
	|ИЗ
	|	РегистрСведений.ВерсииПодсистем КАК ВерсииПодсистем
	|ГДЕ
	|	ВерсииПодсистем.ОбластьДанных = &ОбластьДанных";
	Если ОбщегоНазначенияПовтИсп.ДоступноИспользованиеРазделенныхДанных() Тогда
		ОбластьДанных = ОбщегоНазначения.ЗначениеРазделителяСеанса();
	Иначе
		ОбластьДанных = -1;
	КонецЕсли;
	Запрос.УстановитьПараметр("ОбластьДанных", ОбластьДанных);
	
	Возврат Запрос.Выполнить().Пустой();
	
КонецФункции

// Проверяет необходимость открытия диалога начальной настройки базовой версии программы.
//
Функция НеобходимаНачальнаяНастройкаБазовойВерсии() Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	ЭтоБазоваяВерсияУТ = Константы.БазоваяВерсияУТ.Получить();
	
	УстановитьПривилегированныйРежим(Ложь);
	
	Возврат ЭтоБазоваяВерсияУТ И НеобходимаНачальнаяНастройкаПрограммы();
	
КонецФункции

// Обработчик первого запуска УТ 11.
//
Процедура ПервыйЗапуск() Экспорт

	Справочники.Валюты.ЗаполнитьВалютыПоУмолчанию();
	Справочники.ЕдиницыИзмерения.ЗаполнитьЕдиницыИзмеренияПоУмолчанию();
	
	ЗаполнитьКонстантыПоУмолчанию();
	
	БизнесПроцессы.СогласованиеПродажи.ИнициализироватьРолиИсполнителей();
	БизнесПроцессы.СогласованиеЗакупки.ИнициализироватьРолиИсполнителей();
	БизнесПроцессы.СогласованиеЦенНоменклатуры.ИнициализироватьРолиИсполнителей();
	БизнесПроцессы.СогласованиеЗаявкиНаВозвратТоваровОтКлиента.ИнициализироватьРолиИсполнителей();
	
	Справочники.Партнеры.ЗаполнитьПредопределенныхПартнеров();
	Справочники.СегментыПартнеров.ЗаполнитьПредопределенныйСегмент();
	Справочники.Организации.ЗаполнитьПредопределеннуюОрганизацию();
	Справочники.СостоянияПроцессов.НачальноеЗаполнениеПоследовательностиЭтаповПроцессовПродаж();
	Справочники.СтатьиДвиженияДенежныхСредств.ЗаполнитьПредопределенныеСтатьиДвиженияДенежныхСредств();
	Справочники.СоглашенияСКлиентами.СоздатьСоглашениеПоУмолчанию();
	
	ПланыВидовХарактеристик.СтатьиДоходов.ЗаполнитьПредопределенныеСтатьиДоходов();
	ПланыВидовХарактеристик.СтатьиРасходов.ЗаполнитьПредопределенныеСтатьиРасходов();
	
	РегистрыСведений.НастройкаМетодовОценкиСтоимостиТоваров.ЗаполнитьНастройкуСпособовРасчетаСебестоимостиТоваров();
	
	МониторингЦелевыхПоказателей.ЗаполнитьСтруктуруЦелейИВариантыАнализа();
	
	ОбменССайтом.УстановитьКодНаименованиеУзлаЭтойИБ();
	ПланыОбмена.МобильноеПриложениеТорговыйПредставитель.НачальноеЗаполнениеКодаУзлаЭтойИБ();
	
	Справочники.Номенклатура.УстановитьКонстантуУникальностьРабочегоНаименования();
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

////////////////////////////////////////////////////////////////////////////////
// Заполнения пустой ИБ.

// Заполняет константы значениями по умолчанию.
// Вызывается при первоначальном заполнении ИБ после заполнения следующих данных
//	- Справочник.ЕдиницыИзмерения
//
Процедура ЗаполнитьКонстантыПоУмолчанию()
	
	// Базовые единицы измерения
	БазоваяЕдиницаИзмеренияДлины = Справочники.ЕдиницыИзмерения.НайтиПоКоду("006");
	Константы.ЕдиницаИзмеренияЛинейныхРазмеров.Установить(БазоваяЕдиницаИзмеренияДлины);
	
	БазоваяЕдиницаИзмеренияВеса = Справочники.ЕдиницыИзмерения.НайтиПоКоду("166");
	Если ЗначениеЗаполнено(БазоваяЕдиницаИзмеренияВеса) Тогда
		Константы.ЕдиницаИзмеренияВеса.Установить(БазоваяЕдиницаИзмеренияВеса);
		Константы.КоэффициентПересчетаВТонны.Установить(0.001);
	КонецЕсли;
	
	БазоваяЕдиницаИзмеренияОбъема = Справочники.ЕдиницыИзмерения.НайтиПоКоду("113");
	Если ЗначениеЗаполнено(БазоваяЕдиницаИзмеренияОбъема) Тогда
		Константы.ЕдиницаИзмеренияОбъема.Установить(БазоваяЕдиницаИзмеренияОбъема);
		Константы.КоэффициентПересчетаВКубическиеМетры.Установить(1);
		Константы.КоэффициентПересчетаВЕдиницыОбъема.Установить(Число(ЗначениеЗаполнено(БазоваяЕдиницаИзмеренияДлины)));
	КонецЕсли;
	
	// ABC/XYZ классификация номенклатуры
	Константы.ПериодABCКлассификацииНоменклатуры.Установить(Перечисления.Периодичность.Месяц);
	Константы.ПериодXYZКлассификацииНоменклатуры.Установить(Перечисления.Периодичность.Месяц);
	Константы.КоличествоПериодовABCКлассификацииНоменклатуры.Установить(1);
	Константы.КоличествоПериодовXYZКлассификацииНоменклатуры.Установить(2);
	Константы.ПодпериодXYZКлассификацииНоменклатуры.Установить(Перечисления.Периодичность.Месяц);
	
	// ABC/XYZ классификация партнеров
	Константы.ПериодABCКлассификацииПартнеров.Установить(Перечисления.Периодичность.Месяц);
	Константы.ПериодXYZКлассификацииПартнеров.Установить(Перечисления.Периодичность.Месяц);
	Константы.КоличествоПериодовABCКлассификацииПартнеров.Установить(1);
	Константы.КоличествоПериодовXYZКлассификацииПартнеров.Установить(2);
	Константы.ПодпериодXYZКлассификацииПартнеров.Установить(Перечисления.Периодичность.Месяц);
	
	// Соглашения с клиентами
	Константы.ИспользованиеСоглашенийСКлиентами.Установить(Перечисления.ИспользованиеСоглашенийСКлиентами.НеИспользовать);
	
	// Расчет товарных ограничений
	Константы.ПериодРасчетаТоварныхОграничений.Установить(Перечисления.Периодичность.Месяц);
	Константы.КоличествоПериодовРасчетаТоварныхОграничений.Установить(2);
	
	// Контроль уникальности номенклатуры
	Константы.КонтролироватьУникальностьНоменклатурыИХарактеристикПоСочетаниюЗначенийРеквизитов.Установить(Истина);
	
	// Номенклатура, продаваемая совместно
	Константы.МинимальнаяДостоверностьНоменклатурыПродаваемойСовместно.Установить(60);
	Константы.МинимальнаяЗначимостьНоменклатурыПродаваемойСовместно.Установить(0);
	Константы.МинимальныйПроцентСлучаевНоменклатурыПродаваемойСовместно.Установить(10);
	Константы.КоличествоПериодовДляАнализаНоменклатурыПродаваемойСовместно.Установить(1);
	Константы.ПериодичностьДляАнализаНоменклатурыПродаваемойСовместно.Установить(Перечисления.Периодичность.Год);
	
	// Дополнительная колонка печатных форм документов
	Константы.ДополнительнаяКолонкаПечатныхФормДокументов.Установить(Перечисления.ДополнительнаяКолонкаПечатныхФормДокументов.НеВыводить);
	
	// Изменения законодательства
	Константы.ДатаНачалаПримененияПостановления1137.Установить('20120401');
	
	// "Инвертные" константы
	Константы.НеИспользоватьПланированиеДенежныхСредств.Установить(НЕ Константы.ИспользоватьПланированиеДенежныхСредств.Получить());
	Константы.НеИспользоватьСчетаНаОплатуКлиентам.Установить(НЕ Константы.ИспользоватьСчетаНаОплатуКлиентам.Получить());
	Константы.НеИспользоватьРаспоряженияНаИнвентаризацию.Установить(НЕ Константы.ИспользоватьРаспоряженияНаИнвентаризацию.Получить());
	
	// По умолчанию используются только партнеры, так как включение признака "Использовать партнеров и контрагентов" не подлежит обратному изменению.
	Константы.ИспользоватьПартнеровКакКонтрагентов.Установить(Истина);
	
	// Использование согласования продаж и возвратов
	Константы.ИспользоватьВнутреннееСогласованиеЗаказовКлиентов.Установить(НЕ Константы.ИспользоватьСогласованиеЧерез1СДокументооборот.Получить());
	Константы.ИспользоватьВнутреннееСогласованиеЗаявокНаВозвратТоваровОтКлиентов.Установить(НЕ Константы.ИспользоватьСогласованиеЧерез1СДокументооборот.Получить());
	Константы.ИспользоватьВнутреннееСогласованиеКоммерческихПредложений.Установить(НЕ Константы.ИспользоватьСогласованиеЧерез1СДокументооборот.Получить());
	Константы.ИспользоватьВнутреннееСогласованиеСоглашенийСКлиентами.Установить(НЕ Константы.ИспользоватьСогласованиеЧерез1СДокументооборот.Получить());
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Обновление новых версий ИБ.

// Обработчик обновления УТ 11.1.0.0 
// Устанавливает значения констант использования статусов в заказах,
// если заказы используются
Процедура ЗаполнитьКонстантыИспользованияСтатусовЗаказов() Экспорт
	
	Константы.ИспользоватьСтатусыЗаказовКлиентов.Установить(Константы.ИспользоватьЗаказыКлиентов.Получить());
	Константы.ИспользоватьСтатусыЗаказовПоставщикам.Установить(Константы.ИспользоватьЗаказыПоставщикам.Получить());
	Константы.ИспользоватьСтатусыЗаявокНаВозврат.Установить(Константы.ИспользоватьЗаявкиНаВозвратТоваровОтКлиентов.Получить());
	Константы.ИспользоватьСтатусыЗаказовНаВнутреннееПотребление.Установить(Константы.ИспользоватьЗаказыНаВнутреннееПотребление.Получить());
	Константы.ИспользоватьСтатусыЗаказовНаПеремещение.Установить(Константы.ИспользоватьЗаказыНаПеремещение.Получить());
	Константы.ИспользоватьСтатусыЗаказовНаСборку.Установить(Константы.ИспользоватьЗаказыНаСборку.Получить());
	
КонецПроцедуры

// Обработчик обновления УТ 11.1.0.0
Процедура ЗаполнитьКонстантыИспользованияВнутреннегоСогласованияПродажИВозвратов() Экспорт
	
	Константы.ИспользоватьВнутреннееСогласованиеЗаказовКлиентов.Установить(НЕ Константы.ИспользоватьСогласованиеЧерез1СДокументооборот.Получить());
	Константы.ИспользоватьВнутреннееСогласованиеЗаявокНаВозвратТоваровОтКлиентов.Установить(НЕ Константы.ИспользоватьСогласованиеЧерез1СДокументооборот.Получить());
	Константы.ИспользоватьВнутреннееСогласованиеКоммерческихПредложений.Установить(НЕ Константы.ИспользоватьСогласованиеЧерез1СДокументооборот.Получить());
	Константы.ИспользоватьВнутреннееСогласованиеСоглашенийСКлиентами.Установить(НЕ Константы.ИспользоватьСогласованиеЧерез1СДокументооборот.Получить());
	
КонецПроцедуры

// Обработчик обновления УТ 11.1.0.0
// Заполняет новую константу "ИспользоватьСоглашенияСКлиентами" 
//
Процедура ЗаполнитьКонстантуИспользованияСоглашенийСКлиентами() Экспорт
	
	ИспользованиеСоглашенийСКлиентами = Константы.ИспользованиеСоглашенийСКлиентами.Получить();
	
	Если ИспользованиеСоглашенийСКлиентами <> Перечисления.ИспользованиеСоглашенийСКлиентами.НеИспользовать Тогда
		Константы.ИспользоватьСоглашенияСКлиентами.Установить(Истина);
	КонецЕсли;
	
КонецПроцедуры

// Обработчик обновления УТ 11.1.0.0
// Заполняет новую константу "ИспользоватьНесколькоКлассификацийЗадолженности" 
//
Процедура ЗаполнитьКонстантуИспользоватьНесколькоКлассификацийЗадолженности() Экспорт
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ ПЕРВЫЕ 2
	|	ВариантыКлассификацииЗадолженности.Ссылка
	|ИЗ
	|	Справочник.ВариантыКлассификацииЗадолженности КАК ВариантыКлассификацииЗадолженности");
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	Если Выборка.Количество() > 1 Тогда
		Константы.ИспользоватьНесколькоКлассификацийЗадолженности.Установить(Истина);
	КонецЕсли;
	
КонецПроцедуры

// Обработчик обновления УТ 11.1.0.0
// Заполняет новую константу "ИспользоватьНесколькоВалют" 
//
Процедура ЗаполнитьКонстантуИспользоватьНесколькоВалют() Экспорт
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ ПЕРВЫЕ 2
	|	Валюты.Ссылка
	|ИЗ
	|	Справочник.Валюты КАК Валюты");
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	Если Выборка.Количество() > 1 Тогда
		Константы.ИспользоватьНесколькоВалют.Установить(Истина);
	КонецЕсли;
	Константы.НеИспользоватьНесколькоВалют.Установить(Не Константы.ИспользоватьНесколькоВалют.Получить());
	
КонецПроцедуры

// Обработчик обновления УТ 11.1.0.0
// Заполняет новую константу "ИспользоватьНесколькоСкладов" 
//
Процедура ЗаполнитьКонстантуИспользоватьНесколькоСкладов() Экспорт
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ ПЕРВЫЕ 2
	|	Склады.Ссылка
	|ИЗ
	|	Справочник.Склады КАК Склады");
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	Если Выборка.Количество() > 1 Тогда
		Константы.ИспользоватьНесколькоСкладов.Установить(Истина);
	КонецЕсли;
	Константы.НеИспользоватьНесколькоСкладов.Установить(Не Константы.ИспользоватьНесколькоСкладов.Получить());
	
КонецПроцедуры

// Обработчик обновления УТ 11.1.0.0
// Заполняет новую константу "ИспользоватьПричиныОтменыЗаказовПоставщикам" 
//
Процедура ЗаполнитьКонстантуИспользоватьПричиныОтменыЗаказовПоставщикам() Экспорт
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	ПричиныОтменыЗаказовКлиентов.Ссылка
	|ИЗ
	|	Справочник.ПричиныОтменыЗаказовКлиентов КАК ПричиныОтменыЗаказовКлиентов");
	
	Если Не Запрос.Выполнить().Пустой() Тогда
		Константы.ИспользоватьПричиныОтменыЗаказовКлиентов.Установить(Истина);
	КонецЕсли;
	
КонецПроцедуры

// Обработчик обновления УТ 11.1.0.0
// Заполняет новую константу "ИспользоватьПричиныОтменыЗаказовКлиентов" 
//
Процедура ЗаполнитьКонстантуИспользоватьПричиныОтменыЗаказовКлиентов() Экспорт
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	ПричиныОтменыЗаказовПоставщикам.Ссылка
	|ИЗ
	|	Справочник.ПричиныОтменыЗаказовПоставщикам КАК ПричиныОтменыЗаказовПоставщикам");
	
	Если Не Запрос.Выполнить().Пустой() Тогда
		Константы.ИспользоватьПричиныОтменыЗаказовПоставщикам.Установить(Истина);
	КонецЕсли;
	
КонецПроцедуры

// Обработчик обновления УТ 11.1.0.0
// Заполняет новую константу "ЗаполнитьКонстантуИспользоватьДоговорыСКлиентами" 
//
Процедура ЗаполнитьКонстантуИспользоватьДоговорыСКлиентами() Экспорт
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	СоглашенияСКлиентами.Ссылка
	|ИЗ
	|	Справочник.СоглашенияСКлиентами КАК СоглашенияСКлиентами
	|ГДЕ
	|	СоглашенияСКлиентами.ИспользуютсяДоговорыКонтрагентов");
	
	Если Не Запрос.Выполнить().Пустой() Тогда
		Константы.ИспользоватьДоговорыСКлиентами.Установить(Истина);
	КонецЕсли;
	
КонецПроцедуры

// Обработчик обновления УТ 11.1.0.0
// Заполняет новую константу "ЗаполнитьКонстантуИспользоватьДоговорыСПоставщиками" 
//
Процедура ЗаполнитьКонстантуИспользоватьДоговорыСПоставщиками() Экспорт
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	СоглашенияСПоставщиками.Ссылка
	|ИЗ
	|	Справочник.СоглашенияСПоставщиками КАК СоглашенияСПоставщиками
	|ГДЕ
	|	СоглашенияСПоставщиками.ИспользуютсяДоговорыКонтрагентов");
	
	Если Не Запрос.Выполнить().Пустой() Тогда
		Константы.ИспользоватьДоговорыСПоставщиками.Установить(Истина);
	КонецЕсли;
	
КонецПроцедуры

// Обработчик обновления УТ 11.1.0.0
// Заполняет новую константу "ИспользоватьМониторингЦелевыхПоказателей" 
//
Процедура ЗаполнитьКонстантуИспользоватьМониторингЦелевыхПоказателей() Экспорт
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ ПЕРВЫЕ 2
	|	ИсточникиДанныхПоказателей.ВариантАнализа
	|ИЗ
	|	РегистрСведений.ИсточникиДанныхВариантовАнализаЦелевыхПоказателей КАК ИсточникиДанныхПоказателей");
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	Если Выборка.Количество() > 1 Тогда
		Константы.ИспользоватьМониторингЦелевыхПоказателей.Установить(Истина);
	КонецЕсли;
	
КонецПроцедуры

// Обработчик обновления УТ 11.1.0.0
// Заполняет новую константу "НеФормироватьФинансовыйРезультат" 
//
Процедура ЗаполнитьКонстантуНеФормироватьФинансовыйРезультат() Экспорт
	
	ФормироватьФинансовыйРезультат = Константы.ФормироватьФинансовыйРезультат.Получить();
	Константы.НеФормироватьФинансовыйРезультат.Установить(Не ФормироватьФинансовыйРезультат);
	
КонецПроцедуры

// Обработчик обновления УТ 11.1.0.0
// Заполняет новые константы:
// "ИспользоватьНесколькоОрганизаций"
// "ИспользоватьНесколькоКасс"
// "ИспользоватьНесколькоРасчетныхСчетов"
// "ИспользоватьНесколькоРасчетныхСчетовКасс"
//
Процедура ЗаполнитьКонстантыИспользоватьНесколькоОрганизацийРасчетныхСчетовКасс() Экспорт
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ ПЕРВЫЕ 2
	|	Организации.Ссылка
	|ИЗ
	|	Справочник.Организации КАК Организации");
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	ИспользоватьНесколькоОрганизаций = Выборка.Количество() > 1;
	Если ИспользоватьНесколькоОрганизаций Тогда
		Константы.ИспользоватьНесколькоОрганизаций.Установить(Истина);
	КонецЕсли;
	
	Если ИспользоватьНесколькоОрганизаций Тогда
		
		Константы.ИспользоватьНесколькоКасс.Установить(Истина);
		Константы.ИспользоватьНесколькоРасчетныхСчетов.Установить(Истина);
		Константы.ИспользоватьНесколькоРасчетныхСчетовКасс.Установить(Истина);
		
	Иначе
		
		Запрос = Новый Запрос(
		"ВЫБРАТЬ ПЕРВЫЕ 2
		|	Кассы.Ссылка
		|ИЗ
		|	Справочник.Кассы КАК Кассы");
		
		Результат = Запрос.Выполнить();
		Выборка = Результат.Выбрать();
		ИспользоватьНесколькоКасс = Выборка.Количество() > 1;
		
		Запрос = Новый Запрос(
		"ВЫБРАТЬ ПЕРВЫЕ 2
		|	БанковскиеСчетаОрганизаций.Ссылка
		|ИЗ
		|	Справочник.БанковскиеСчетаОрганизаций КАК БанковскиеСчетаОрганизаций");
		
		Результат = Запрос.Выполнить();
		Выборка = Результат.Выбрать();
		ИспользоватьНесколькоРасчетныхСчетов = Выборка.Количество() > 1;
		
		Если ИспользоватьНесколькоКасс Тогда
			Константы.ИспользоватьНесколькоКасс.Установить(Истина);
		КонецЕсли;
		Если ИспользоватьНесколькоРасчетныхСчетов Тогда
			Константы.ИспользоватьНесколькоРасчетныхСчетов.Установить(Истина);
		КонецЕсли;
		Если ИспользоватьНесколькоКасс Или ИспользоватьНесколькоРасчетныхСчетов Тогда
			Константы.ИспользоватьНесколькоРасчетныхСчетовКасс.Установить(Истина);
		КонецЕсли;
		
	КонецЕсли;
	
	Константы.НеИспользоватьНесколькоОрганизаций.Установить(Не Константы.ИспользоватьНесколькоОрганизаций.Получить());
	
КонецПроцедуры

// Обработчик обновления УТ 11.1.0.0
// Заполняет новые константы:
// "ИспользоватьУчетПрочихДоходовРасходов"
// "ФормироватьФинансовыйРезультат"
//
Процедура ЗаполнитьКонстантыИспользоватьПрочиеДоходыРасходыФинансовыйРезультат() Экспорт
	
	Константы.ИспользоватьУчетПрочихДоходовРасходов.Установить(Истина);
	Константы.ФормироватьФинансовыйРезультат.Установить(Истина);
	
КонецПроцедуры

// Обработчик обновления УТ 11.1.0.0
// Выполняет переименование схемы компоновки данных в видах цен.
//
Процедура ПереименоватьСхемыКомпоновкиДанныхВидовЦен() Экспорт
	
	НачатьТранзакцию();
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	ВидыЦен.Ссылка
	|ИЗ
	|	Справочник.ВидыЦен КАК ВидыЦен
	|ГДЕ
	|	ВидыЦен.СхемаКомпоновкиДанных ПОДОБНО ""ОтборНоменклатуры""");
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	Пока Выборка.Следующий()  Цикл
		Объект = Выборка.Ссылка.ПолучитьОбъект();
		Объект.СхемаКомпоновкиДанных = "Типовой";
		Объект.Записать();
	КонецЦикла;
	
	ЗафиксироватьТранзакцию();
	
КонецПроцедуры


// Обработчик обновления УТ 11.1.0.0
// Выполняет обновление группы ВсеВнешниеПользователи .
//
Процедура ОбновитьТипОбъектовАвторизацииГруппыВнешнихПользователейВсеВнешниеПользователи() Экспорт

	СправочникОъект = Справочники.ГруппыВнешнихПользователей.ВсеВнешниеПользователи.ПолучитьОбъект();
	СправочникОъект.ТипОбъектовАвторизации = Неопределено;
	СправочникОъект.Записать();

КонецПроцедуры



