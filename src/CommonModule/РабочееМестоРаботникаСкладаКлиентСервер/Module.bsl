﻿// Процедура дополняет текст заголовка формы необходимым количеством символов,
// для того чтобы текст заголовка отображался в середине формы.
//
// Параметры:
//	Форма - УправляемаяФорма - форма обработки мобильного рабочего места работника склада.
//
Процедура ЦентрироватьТекстЗаголовкаФормы(Форма)
	
	СимволВыравниванияЛев = ".:";
	СимволВыравниванияПрав = ":.";
	
	ТекстЗаголовка = Форма.Заголовок;
	
	Если НЕ ЗначениеЗаполнено(ТекстЗаголовка) Тогда
		Возврат;
	КонецЕсли;
	
	ТекстЗаголовка = СокрЛП(ТекстЗаголовка);
	ДлинаТекста = СтрДлина(ТекстЗаголовка);
	
	Если ДлинаТекста >= Форма.ДлинаТекстаЗаголовкаФормыДляСравнения Тогда
		Возврат;
	КонецЕсли;
	
	КолСимволовДополнения = Цел((Форма.ДлинаТекстаЗаголовкаФормы - ДлинаТекста - 4) / 2);
	СтрокаДополнения = "";
	
	// Дополнить строку заголовка пробелами.
	Пока КолСимволовДополнения > 0 Цикл
		СтрокаДополнения = СтрокаДополнения + " ";
		КолСимволовДополнения = КолСимволовДополнения - 1;
	КонецЦикла;
	
	ТекстЗаголовкаФормы = СимволВыравниванияЛев + СтрокаДополнения + ТекстЗаголовка + СтрокаДополнения + СимволВыравниванияПрав;
	
	Форма.Заголовок = ТекстЗаголовкаФормы;
	
КонецПроцедуры

// Процедура устанавливает текст заголовка формы и центрирует его.
//
// Параметры:
//	Форма - УправляемаяФорма - форма рабочего места,
//	ТекстЗаголовка - Строка - текст заголовка формы.
//
Процедура УстановитьЗаголовокФормы(Форма, ТекстЗаголовка) Экспорт
	
	Форма.Заголовок = ТекстЗаголовка;
	ЦентрироватьТекстЗаголовкаФормы(Форма);
	
КонецПроцедуры

// Функция возвращает структуру кнопки диалога, которая отображается в диалоге
// пользователя.
//
// Параметры:
//	ИмяКоманды - Строка - имя команды, которая будет выполнена при нажатии на кнопку,
//	Представление - Строка - представление кнопки,
//	Выделить - Булево - если <Истина> то надпись на кнопке будет выполнена полужирным шрифтом.
//
// Возвращаемое значение:
//	Структура. Параметры кнопки диалога.
//
Функция НоваяКнопкаДиалога(ИмяКоманды, Представление, Выделить = Ложь) Экспорт
	
	КнопкаДиалога = Новый Структура;
	
	КнопкаДиалога.Вставить("ИмяКоманды", ИмяКоманды);
	КнопкаДиалога.Вставить("Представление", Представление);
	КнопкаДиалога.Вставить("Выделить", Выделить);
	
	Возврат КнопкаДиалога;
	
КонецФункции
