﻿////////////////////////////////////////////////////////////////////////////////
// КОД ПРОЦЕДУР И ФУНКЦИЙ модуля ДатыЗапретаИзмененияПереопределяемый
// для поддержки библиотечного подхода разработки
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// ПРОГРАММНЫЙ ИНТЕРФЕЙС

// Вызывается из переопределяемого модуля
Процедура НастройкаИнтерфейса(Знач НастройкиРаботыИнтерфейса) Экспорт
	
	НастройкиРаботыИнтерфейса.ИспользоватьВнешнихПользователей = Истина;
	
КонецПроцедуры

// Вызывается из переопределяемого модуля
Процедура ЗаполнитьИсточникиДанныхДляПроверкиЗапретаИзменения(Знач ИсточникиДанных) Экспорт
	
	// Данные(Таблица, ПолеДаты, Раздел, ПолеОбъекта)
	
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.АвансовыйОтчет",                       "Дата", "АвансовыеОтчеты", "Организация");
	
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ВзаимозачетЗадолженности",             "Дата", "ВзаимозачетыСписанияЗадолженности", "Организация");	
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ВзаимозачетЗадолженности",             "Дата", "ВзаимозачетыСписанияЗадолженности", "КонтрагентДебитор");	
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ВзаимозачетЗадолженности",             "Дата", "ВзаимозачетыСписанияЗадолженности", "КонтрагентКредитор");	
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.СписаниеЗадолженности",                "Дата", "ВзаимозачетыСписанияЗадолженности", "Организация");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.СписаниеЗадолженности",                "Дата", "ВзаимозачетыСписанияЗадолженности", "Контрагент");
	
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.АктВыполненныхРабот",                  "Дата", "ПродажиВозвратыОтКлиентов", "Организация");
 	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ВозвратТоваровОтКлиента",              "Дата", "ПродажиВозвратыОтКлиентов", "Организация");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.КорректировкаРеализации",              "Дата", "ПродажиВозвратыОтКлиентов", "Организация");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ОтчетКомиссионера",                    "Дата", "ПродажиВозвратыОтКлиентов", "Организация");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ОтчетКомиссионераОСписании",           "Дата", "ПродажиВозвратыОтКлиентов", "Организация");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ОтчетОРозничныхПродажах",              "Дата", "ПродажиВозвратыОтКлиентов", "Организация");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.РеализацияТоваровУслуг",               "Дата", "ПродажиВозвратыОтКлиентов", "Организация");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.РеализацияУслугПрочихАктивов",         "Дата", "ПродажиВозвратыОтКлиентов", "Организация");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.СчетФактураВыданный",                  "Дата", "ПродажиВозвратыОтКлиентов", "Организация");

	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ВозвратТоваровПоставщику",             "Дата", "ЗакупкиВозвратыПоставщикамПеремещенияСборки", "Организация");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.КорректировкаПоступления",             "Дата", "ЗакупкиВозвратыПоставщикамПеремещенияСборки", "Организация");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ОтчетКомитенту",                       "Дата", "ЗакупкиВозвратыПоставщикамПеремещенияСборки", "Организация");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ОтчетКомитентуОСписании",              "Дата", "ЗакупкиВозвратыПоставщикамПеремещенияСборки", "Организация");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ПоступлениеТоваровУслуг",              "Дата", "ЗакупкиВозвратыПоставщикамПеремещенияСборки", "Организация");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ПоступлениеУслугПрочихАктивов",        "Дата", "ЗакупкиВозвратыПоставщикамПеремещенияСборки", "Организация");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ПеремещениеТоваров",                   "Дата", "ЗакупкиВозвратыПоставщикамПеремещенияСборки", "Организация");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.СборкаТоваров",                        "Дата", "ЗакупкиВозвратыПоставщикамПеремещенияСборки", "Организация");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ТаможеннаяДекларацияИмпорт",           "Дата", "ЗакупкиВозвратыПоставщикамПеремещенияСборки", "Организация");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.СчетФактураПолученный",                "Дата", "ЗакупкиВозвратыПоставщикамПеремещенияСборки", "Организация");
	
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ВнутреннееПотреблениеТоваров",         "Дата", "СписанияОприходованияТоваров", "Организация");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ОприходованиеИзлишковТоваров",         "Дата", "СписанияОприходованияТоваров", "Организация");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ПересортицаТоваров",                   "Дата", "СписанияОприходованияТоваров", "Организация");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ПорчаТоваров",                         "Дата", "СписанияОприходованияТоваров", "Организация");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ПрочееОприходованиеТоваров",           "Дата", "СписанияОприходованияТоваров", "Организация");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.СписаниеНедостачТоваров",              "Дата", "СписанияОприходованияТоваров", "Организация");
	
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ВозвратТоваровМеждуОрганизациями",                        "Дата", "РегламентныеОперации", "");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ОтчетПоКомиссииМеждуОрганизациями",                       "Дата", "РегламентныеОперации", "");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ПередачаТоваровМеждуОрганизациями",                       "Дата", "РегламентныеОперации", "");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.РаспределениеДоходовИРасходовПоНаправлениямДеятельности", "Дата", "РегламентныеОперации", "");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.РаспределениеРасходовБудущихПериодов",                    "Дата", "РегламентныеОперации", "");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.РаспределениеРасходовНаСебестоимостьТоваров",             "Дата", "РегламентныеОперации", "");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.РасчетСебестоимостиТоваров",                              "Дата", "РегламентныеОперации", "");
	
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ВыпискаПоРасчетномуСчету",             "Дата", "Банк", "БанковскийСчет");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ОтчетБанкаПоОперациямЭквайринга",      "Дата", "Банк", "ДоговорЭквайринга.БанковскийСчет");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ПоступлениеБезналичныхДенежныхСредств","Дата", "Банк", "БанковскийСчет");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.СписаниеБезналичныхДенежныхСредств",   "Дата", "Банк", "БанковскийСчет");
	
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ОперацияПоПлатежнойКарте",             "Дата", "Касса", "Касса");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ПриходныйКассовыйОрдер",               "Дата", "Касса", "Касса");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.РасходныйКассовыйОрдер",               "Дата", "Касса", "Касса");
	
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ОрдерНаОтражениеИзлишковТоваров",             "Дата", "СкладскиеОперации", "Склад");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ОрдерНаОтражениеНедостачТоваров",             "Дата", "СкладскиеОперации", "Склад");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ОрдерНаОтражениеПорчиТоваров",                "Дата", "СкладскиеОперации", "Склад");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ОрдерНаОтражениеРезультатовПересчетовТоваров","Дата", "СкладскиеОперации", "Склад");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ОрдерНаПеремещениеТоваров",                   "Дата", "СкладскиеОперации", "Склад");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ОтборРазмещениеТоваров",                      "Дата", "СкладскиеОперации", "Склад");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ОтражениеРезультатовПроверкиОрдераНаТовары",  "Дата", "СкладскиеОперации", "Склад");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ПересчетТоваров",                             "Дата", "СкладскиеОперации", "Склад");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ПриходныйОрдерНаТовары",                      "Дата", "СкладскиеОперации", "Склад");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.РасходныйОрдерНаТовары",                      "Дата", "СкладскиеОперации", "Склад");
	
КонецПроцедуры

// Вызывается из переопределяемого модуля
Процедура ПередПроверкойЗапретаИзменения(Объект,
                                         ПроверкаЗапретаИзменения,
                                         УзелПроверкиЗапретаЗагрузки,
                                         СообщитьОЗапрете) Экспорт
	
	// При работе помощника зачета оплаты не учитывается дата запрета изменения.
	Если Объект.ДополнительныеСвойства.Свойство("ПроверкаДатыЗапретаИзменения") Тогда
		ПроверкаЗапретаИзменения = Объект.ДополнительныеСвойства.ПроверкаДатыЗапретаИзменения;
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ
