﻿////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если ЗначениеЗаполнено(Запись.Помещение)
		И Не ЗначениеЗаполнено(Запись.Склад) Тогда
		Запись.Склад = Запись.Помещение.Владелец;
	КонецЕсли;
	
	Если Запись.ИсходныйКлючЗаписи.Пустой() Тогда
		УстановитьПараметрыФункциональныхОпцийФормы(Новый Структура("Склад", Запись.Склад));
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	УстановитьПараметрыФункциональныхОпцийФормы(Новый Структура("Склад", Запись.Склад));
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ШАПКИ ФОРМЫ

&НаКлиенте
Процедура СкладПриИзменении(Элемент)
	УстановитьПараметрыФункциональныхОпцийФормы(Новый Структура("Склад", Запись.Склад));
КонецПроцедуры

