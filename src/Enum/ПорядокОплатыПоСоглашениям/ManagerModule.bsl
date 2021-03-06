﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда


// Функция определяет порядок оплаты по умолчанию.
//
// Параметры:
//	Валюта - СправочниеСсылка.Валюты - Валюта соглашения
//
// Возвращаемое значение:
//	ПеречислениеСсылка.ПорядокОплатыПоСоглашениям
//
Функция ПолучитьПорядокОплатыПоУмолчанию(Валюта, НалогообложениеНДС) Экспорт
	
	ВалютаРегламентированногоУчета = Константы.ВалютаРегламентированногоУчета.Получить();
	Если Валюта = ВалютаРегламентированногоУчета Тогда
		Если НалогообложениеНДС <> Перечисления.ТипыНалогообложенияНДС.ПродажаНаЭкспорт Тогда
			ПорядокОплаты = Перечисления.ПорядокОплатыПоСоглашениям.РасчетыВРубляхОплатаВРублях;
		Иначе
			ПорядокОплаты = Перечисления.ПорядокОплатыПоСоглашениям.ПустаяСсылка();
		КонецЕсли;
	Иначе
		Если НалогообложениеНДС = Перечисления.ТипыНалогообложенияНДС.ПродажаНаЭкспорт Тогда
			ПорядокОплаты = Перечисления.ПорядокОплатыПоСоглашениям.РасчетыВВалютеОплатаВВалюте;
		Иначе
			ПорядокОплаты = Перечисления.ПорядокОплатыПоСоглашениям.РасчетыВВалютеОплатаВРублях;
		КонецЕсли;
	КонецЕсли;
	
	Возврат ПорядокОплаты;

КонецФункции // ПолучитьПорядокОплатыПоУмолчанию()

#КонецЕсли