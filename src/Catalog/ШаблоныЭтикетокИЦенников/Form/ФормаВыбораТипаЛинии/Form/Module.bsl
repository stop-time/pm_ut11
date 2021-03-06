﻿
////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если ТипЗнч(Параметры.ТипЛинии) = Тип("ТипЛинииЯчейкиТабличногоДокумента") Тогда
		Типы = ТипЛинииЯчейкиТабличногоДокумента;
	ИначеЕсли ТипЗнч(Параметры.ТипЛинии) = Тип("ТипЛинииРисункаТабличногоДокумента") Тогда
		Типы = ТипЛинииРисункаТабличногоДокумента;
	КонецЕсли;
	
	Для Каждого Тип Из Типы Цикл
		Элементы.ТипЛинии.СписокВыбора.Добавить(Тип);
	КонецЦикла;
	
	ТипЛинии = Параметры.ТипЛинии;
	Толщина = Параметры.Толщина;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ШАПКИ ФОРМЫ

&НаКлиенте
Процедура ТипЛинииПриИзменении(Элемент)
	
	Если ТипЛинии = ТипЛинииЯчейкиТабличногоДокумента.НетЛинии
		Или ТипЛинии = ТипЛинииЯчейкиТабличногоДокумента.Двойная
		Или ТипЛинии = ТипЛинииРисункаТабличногоДокумента.НетЛинии Тогда
		Элементы.Толщина.ТолькоПросмотр = Истина;
		Толщина = 1;
	Иначе
		Элементы.Толщина.ТолькоПросмотр = Ложь;
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ КОМАНД ФОРМЫ

&НаКлиенте
Процедура ОК(Команда)
	Закрыть(Новый Структура("ТипЛинии, Толщина", ТипЛинии, Толщина));
КонецПроцедуры

