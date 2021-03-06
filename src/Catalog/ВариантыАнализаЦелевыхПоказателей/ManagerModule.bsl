﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

////////////////////////////////////////////////////////////////////////////////
// ПРОГРАММНЫЙ ИНТЕРФЕЙС

// Возвращает настройки оформления по умолчанию для вариантов анализа 
//
// Возвращаемое значение:
//	Структура - структура, содержащая настройки оформления
//
Функция НастройкиОформленияПоУмолчанию(ПокомпонентноеСравнение = Ложь) Экспорт
	
	// Сформируем настройки цветов
	ЦветовыеНастройки = Новый Структура;
	
	НаборЦветов = Новый Соответствие;
	НаборЦветов.Вставить("Значение", WebЦвета.СинийСоСтальнымОттенком);
	НаборЦветов.Вставить("Прогноз", WebЦвета.КрасноФиолетовый);
	НаборЦветов.Вставить("ЦелевоеЗначение", WebЦвета.ЛимонноЗеленый);
	НаборЦветов.Вставить("ПозитивноеОтклонение", WebЦвета.Синий);
	НаборЦветов.Вставить("НегативноеОтклонение", WebЦвета.Красный);
	НаборЦветов.Вставить("ЗонаДопустимыхОтклонений", WebЦвета.Золотой);
	
	ЦветовыеНастройки.Вставить("Цвета", НаборЦветов);
	
	ХранилищеНастроекОформления = Новый ХранилищеЗначения(ЦветовыеНастройки);
	
	// Сформируем настройки параметров вывода
	ТолькоЦветОсновнойСерии = ПокомпонентноеСравнение;
	ГрадиентДляПокомпонетногоСравнения = ПокомпонентноеСравнение;
	ВыделятьМаксимальноеЗначениеДляПокомпонетногоСравнения = Ложь;
	ВыводитьМаркерТочекПрогноза = Истина;
	ОтображатьЛегенду = Истина;
	
	СтруктураНастроекОформления  = Новый Структура("ХранилищеНастроекОформления, 
	|ТолькоЦветОсновнойСерии,
	|ГрадиентДляПокомпонетногоСравнения,
	|ВыделятьМаксимальноеЗначениеДляПокомпонетногоСравнения,
	|ВыводитьМаркерТочекПрогноза,
	|ОтображатьЛегенду", 
	ХранилищеНастроекОформления, 
	ТолькоЦветОсновнойСерии,
	ГрадиентДляПокомпонетногоСравнения,
	ВыделятьМаксимальноеЗначениеДляПокомпонетногоСравнения,
	ВыводитьМаркерТочекПрогноза,
	ОтображатьЛегенду);
	
	Возврат СтруктураНастроекОформления;
	
КонецФункции

// Помещает во временное хранилище схему компоновки данных,
// настройки компоновки данных и пользовательские настройки и возвращает их адреса
//
// Параметры:
//	ВариантАнализаСсылка - Ссылка, СправочникСсылка.ВариантыАнализаЦелевыхПоказателей - вариант анализа, для которого возвращаются адреса
//
// Возвращаемое значение:
//	Структура - структура, содержащая адреса
//
Функция АдресаСхемыКомпоновкиДанныхИПользовательскихНастроек(ВариантАнализаСсылка) Экспорт
	
	Адреса = Новый Структура("СхемаКомпоновкиДанных, НастройкиКомпоновкиДанных, ПользовательскиеНастройки");
	
	// Получим схему компоновки данных
	Если ЗначениеЗаполнено(ВариантАнализаСсылка.Владелец.СхемаКомпоновкиДанных) ИЛИ ВариантАнализаСсылка.Владелец.ХранилищеСхемыКомпоновкиДанных.Получить() = Неопределено Тогда
		СхемаИНастройки = Справочники.СтруктураЦелей.ОписаниеИСхемаКомпоновкиДанныхЦелиПоИмениМакета(ВариантАнализаСсылка.Владелец, ВариантАнализаСсылка.Владелец.СхемаКомпоновкиДанных);
		СхемаКомпоновкиДанных = СхемаИНастройки.СхемаКомпоновкиДанных;
	Иначе
		СхемаКомпоновкиДанных = ВариантАнализаСсылка.Владелец.ХранилищеСхемыКомпоновкиДанных.Получить();
	КонецЕсли;
	
	Адреса.СхемаКомпоновкиДанных = ПоместитьВоВременноеХранилище(СхемаКомпоновкиДанных, Новый УникальныйИдентификатор());
	
	Настройки = ВариантАнализаСсылка.Владелец.ХранилищеНастроекКомпоновкиДанных.Получить();
	
	Если ЗначениеЗаполнено(Настройки) Тогда
		Адреса.НастройкиКомпоновкиДанных = ПоместитьВоВременноеХранилище(Настройки, Новый УникальныйИдентификатор());
	КонецЕсли;
	
	ПользовательскиеНастройки = ВариантАнализаСсылка.ХранилищеПользовательскихНастроекКомпоновкиДанных.Получить();
	
	Если ЗначениеЗаполнено(ПользовательскиеНастройки) Тогда
		Адреса.ПользовательскиеНастройки = ПоместитьВоВременноеХранилище(ПользовательскиеНастройки, Новый УникальныйИдентификатор());
	КонецЕсли;
	
	Возврат Адреса;
	
КонецФункции
#КонецЕсли