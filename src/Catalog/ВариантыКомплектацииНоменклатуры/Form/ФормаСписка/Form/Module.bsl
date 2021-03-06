﻿
////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	// Варианты комплектации определяются только для товаров.
	ВладелецВариантов = Неопределено;
	Если Параметры.Свойство("Отбор") И Параметры.Отбор.Свойство("Владелец", ВладелецВариантов)
		И ЗначениеЗаполнено(ВладелецВариантов) Тогда

		ЗначенияРеквизитов = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(ВладелецВариантов,
									Новый Структура("ТипНоменклатуры"));
		Если ЗначенияРеквизитов.ТипНоменклатуры <> Перечисления.ТипыНоменклатуры.Товар
			И ЗначенияРеквизитов.ТипНоменклатуры <> Перечисления.ТипыНоменклатуры.МногооборотнаяТара Тогда

			АвтоЗаголовок = Ложь;

			ТекстЗаголовка = НСтр("ru = 'Варианты комплектации используются только для товаров'");
			Заголовок      = ТекстЗаголовка;

			Элементы.Список.ТолькоПросмотр = Истина;

		КонецЕсли;

	КонецЕсли;

КонецПроцедуры
