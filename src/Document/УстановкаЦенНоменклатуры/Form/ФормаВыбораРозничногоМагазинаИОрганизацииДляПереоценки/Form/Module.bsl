﻿
////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ КОМАНД ФОРМЫ

&НаКлиенте
Процедура Печать(Команда)
	
	Отказ = Ложь;
	
	ОчиститьСообщения();
	
	Если Не ЗначениеЗаполнено(Организация) Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Не заполнено поле ""Организация""'"),,"Организация",,Отказ);
	КонецЕсли;
	Если Не ЗначениеЗаполнено(РозничныйМагазин) Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Не заполнено поле ""Розничный магазин""'"),,"РозничныйМагазин",,Отказ);
	КонецЕсли;
	
	Если Не Отказ Тогда
		
		ПараметрыВыбора = Новый Структура;
		ПараметрыВыбора.Вставить("Организация",      Организация);
		ПараметрыВыбора.Вставить("РозничныйМагазин", РозничныйМагазин);
		
		Закрыть(ПараметрыВыбора);
		
	КонецЕсли;
	
КонецПроцедуры
