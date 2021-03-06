﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

////////////////////////////////////////////////////////////////////////////////
// ПРОГРАММНЫЙ ИНТЕРФЕЙС

// Заполняет переданный массив именами реквизитов по указанной хозяйственнной операции
//
// Параметры:
//  ХозяйственнаяОперация - ПеречислениеСсылка.ХозяйственныеОперации - значение хозяйственной операции
//  МассивВсехРеквизитов - Массив - содержит имена всех реквизитов
//  МассивРеквизитовОперации - Массив - содержит имена реквизитов для указанной хозяйственной операции
//
Функция ЗаполнитьИменаРеквизитовПоХозяйственнойОперации(ХозяйственнаяОперация, МассивВсехРеквизитов, МассивРеквизитовОперации) Экспорт
	
	МассивВсехРеквизитов = Новый Массив;
	МассивВсехРеквизитов.Добавить("Товары.ПроцентРучнойСкидки");
	МассивВсехРеквизитов.Добавить("Товары.СуммаРучнойСкидки");
	
	МассивРеквизитовОперации = Новый Массив;
	Если ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.РеализацияКлиенту
	 ИЛИ Не ЗначениеЗаполнено(ХозяйственнаяОперация) Тогда
		МассивРеквизитовОперации.Добавить("Товары.ПроцентРучнойСкидки");
		МассивРеквизитовОперации.Добавить("Товары.СуммаРучнойСкидки");
	КонецЕсли;
	
КонецФункции

// Возвращает массив имен ролей с правом "Добавление" для данного документа
//
// Возвращаемое значение:
//  МассивРолей - Массив, содержит имена ролей
//
Функция ИменаРолейСПравомДобавления() Экспорт
	
	МассивРолей = Новый Массив;
	МассивРолей.Добавить("ПолныеПрава");
	МассивРолей.Добавить("ДобавлениеИзменениеЗаданийТорговымПредставителям");
	
	Возврат МассивРолей;
	
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

////////////////////////////////////////////////////////////////////////////////
// Печать

// Формирует печатные формы объектов
//
// Параметры:
//   ИменаМакетов - Строка - Имена макетов, перечисленные через запятую
//   МассивОбъектов - Массив - Массив ссылок на объекты которые нужно распечатать
//   ПараметрыПечати - Структура - Структура дополнительных параметров печати
//   КоллекцияПечатныхФорм - Таблица значений - Сформированные табличные документы
//   ПараметрыВывода - Структура - Параметры сформированных табличных документов
//
Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
	
	Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "БланкЗадания") Тогда
		
		СтруктураБланка = ПолучитьПечатнуюФормуБланкаЗадания(МассивОбъектов, ОбъектыПечати);
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(КоллекцияПечатныхФорм, "БланкЗадания", "Задание", СтруктураБланка.Задание);
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(КоллекцияПечатныхФорм, "БланкЗаказа", "Заказ", СтруктураБланка.Заказ);
			
	КонецЕсли;
	
	Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "СводноеЗадание") Тогда
		
		СводноеЗадание = ПолучитьПечатнуюФормуСводногоЗадания(МассивОбъектов, ОбъектыПечати);
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(КоллекцияПечатныхФорм, "СводноеЗадание", "Сводное задание", СводноеЗадание);
			
	КонецЕсли;
		
КонецПроцедуры

Функция ПолучитьПечатнуюФормуБланкаЗадания(МассивОбъектов, ОбъектыПечати)
		
	БланкЗадания = Новый ТабличныйДокумент();
	БланкЗаказа = Новый ТабличныйДокумент();
	
	БланкЗадания.КлючПараметровПечати = "ПАРАМЕТРЫ_ПЕЧАТИ_ЗаданиеТорговомуПредставителю_БланкЗадания";
	БланкЗаказа.КлючПараметровПечати = "ПАРАМЕТРЫ_ПЕЧАТИ_ЗаданиеТорговомуПредставителю_БланкЗаказа";
	
	Запрос = Новый Запрос();
	Запрос.УстановитьПараметр("МассивОбъектов", МассивОбъектов);
	Запрос.Текст = ПолучитьТекстЗапросаДляФормированияПечатнойФормыБланкаЗадания();
	
	ДанныеОтчета = Запрос.Выполнить().Выбрать();
	
	ПервыйДокумент = Истина;
	СтруктураПараметровПечати = ПолучитьНастройкиПечатиЗадания();
	
	Пока ДанныеОтчета.Следующий() Цикл
		
		МакетБланкаЗадания = УправлениеПечатью.ПолучитьМакет("Документ.ЗаданиеТорговомуПредставителю.ПФ_MXL_БланкЗадания");
		МакетБланкаЗаказа = УправлениеПечатью.ПолучитьМакет("Документ.ЗаданиеТорговомуПредставителю.ПФ_MXL_БланкЗаказа");
		
		Если Не ПервыйДокумент Тогда
			БланкЗадания.ВывестиГоризонтальныйРазделительСтраниц();
			БланкЗаказа.ВывестиГоризонтальныйРазделительСтраниц();
		КонецЕсли;
		
		ПервыйДокумент = Ложь;
		
		НомерСтрокиНачалоБланка = БланкЗадания.ВысотаТаблицы + 1;
		НомерСтрокиНачалоТоварногоСостава = БланкЗаказа.ВысотаТаблицы + 1;
		
		
		//////////////////////////////////////////////////////////////////////////////
		// ВЫВОД БЛАНКА ЗАДАНИЯ
		
		ОбластьМакета = МакетБланкаЗадания.ПолучитьОбласть("Шапка");
		
		ЗаголовокДокумента = ОбщегоНазначенияУТКлиентСервер.СформироватьЗаголовокДокумента(ДанныеОтчета, НСтр("ru='Задание торговому представителю'"));
		ОбластьМакета.Параметры.ТекстЗаголовка = ЗаголовокДокумента;
		
		ОбластьМакета.Параметры.ТорговыйПредставитель = ДанныеОтчета.ТорговыйПредставитель;
		ОбластьМакета.Параметры.Куратор = ДанныеОтчета.Куратор;
		ОбластьМакета.Параметры.ДатаВизита = Формат(ДанныеОтчета.ДатаВизитаПлан, "ДФ=дд.ММ.гггг");
		ОбластьМакета.Параметры.Нач = ?(ЗначениеЗаполнено(ДанныеОтчета.ВремяНачала),Формат(ДанныеОтчета.ВремяНачала,"ДФ=чч:мм"),"____");
		ОбластьМакета.Параметры.Кон = ?(ЗначениеЗаполнено(ДанныеОтчета.ВремяОкончания),Формат(ДанныеОтчета.ВремяОкончания,"ДФ=чч:мм"),"____");
		
		Адрес = ФормированиеПечатныхФорм.ПолучитьАдресИзКонтактнойИнформации(ДанныеОтчета.Партнер);
		Телефон = ФормированиеПечатныхФорм.ПолучитьТелефонИзКонтактнойИнформации(ДанныеОтчета.Партнер);
		
		ИнформацияОПартнере = СокрЛП(ДанныеОтчета.Партнер) + ?(ПустаяСтрока(Адрес),"", ", Адрес: " + Адрес) + ?(ПустаяСтрока(Телефон), "", ", Телефон: " + Телефон);
		
		ОбластьМакета.Параметры.ИнформацияОПартнере = ИнформацияОПартнере;
		ШтрихкодированиеПечатныхФорм.ВывестиШтрихкодВТабличныйДокумент(БланкЗадания, МакетБланкаЗадания, ОбластьМакета, ДанныеОтчета.Ссылка);
		БланкЗадания.Вывести(ОбластьМакета);
		
		// Вывод задач, определенных в задании
		
		Если СтруктураПараметровПечати.ВыводитьЗадачи Тогда
			ТаблицаЗадачи = ДанныеОтчета.Задачи.Выгрузить();
			
			Если ТаблицаЗадачи.Количество()>0 Тогда
				
				ОбластьМакета = МакетБланкаЗадания.ПолучитьОбласть("ПустаяСтрока");
				БланкЗадания.Вывести(ОбластьМакета);
			
				ОбластьМакета = МакетБланкаЗадания.ПолучитьОбласть("ЗадачиШапка");
				БланкЗадания.Вывести(ОбластьМакета);
				
				Для Каждого СтрокаЗадачи из ТаблицаЗадачи Цикл
					ОбластьМакета = МакетБланкаЗадания.ПолучитьОбласть("ЗадачиСтрока");
					ОбластьМакета.Параметры.НомерСтроки = СтрокаЗадачи.НомерСтроки;
					ОбластьМакета.Параметры.ОписаниеЗадачи = СтрокаЗадачи.ОписаниеЗадачи;
					БланкЗадания.Вывести(ОбластьМакета);
				КонецЦикла;
			КонецЕсли;
		КонецЕсли;
		
		// Вывод секции произвольных заметок торгового представителя
		
		Если СтруктураПараметровПечати.ВыводитьЗаметки И СтруктураПараметровПечати.КоличествоСтрокЗаметок > 0 Тогда
			
			ОбластьМакета = МакетБланкаЗадания.ПолучитьОбласть("ПустаяСтрока");
			БланкЗадания.Вывести(ОбластьМакета);
			
			ОбластьМакета = МакетБланкаЗадания.ПолучитьОбласть("ЗаметкиШапка");
			БланкЗадания.Вывести(ОбластьМакета);
			
			ВыведеноСтрок = 0;
			Пока ВыведеноСтрок < СтруктураПараметровПечати.КоличествоСтрокЗаметок Цикл
				ОбластьМакета = МакетБланкаЗадания.ПолучитьОбласть("ЗаметкиСтрока");
				БланкЗадания.Вывести(ОбластьМакета);
				ВыведеноСтрок = ВыведеноСтрок + 1;
			КонецЦикла;
		
		КонецЕсли;
		
		//////////////////////////////////////////////////////////////////////////////
		// ВЫВОД БЛАНКА ЗАКАЗА
		
		// Вывод условий заказа, определенных в задании
		
		ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("Шапка");
		
		ОбластьМакета.Параметры.Партнер = ДанныеОтчета.Партнер;
		ОбластьМакета.Параметры.Контрагент = ДанныеОтчета.Контрагент;
		ОбластьМакета.Параметры.Валюта = ДанныеОтчета.Валюта;
		
		Если НЕ ДанныеОтчета.ДетализацияПоНоменклатуре Тогда
			ОбластьМакета.Параметры.ЗаголовокСумма = "Сумма:";
			ОбластьМакета.Параметры.Сумма = ДанныеОтчета.СуммаПлан;
		КонецЕсли;
		
		ОбластьМакета.Параметры.Склад = ДанныеОтчета.Склад;
		
		ШтрихкодированиеПечатныхФорм.ВывестиШтрихкодВТабличныйДокумент(БланкЗаказа, МакетБланкаЗаказа, ОбластьМакета, ДанныеОтчета.Ссылка);
		БланкЗаказа.Вывести(ОбластьМакета);
		
		// Вывод графика оплаты
		
		Если СтруктураПараметровПечати.ВыводитьГрафикОплаты Тогда
			
			ТаблицаЭтапыГрафикаОплаты = ДанныеОтчета.ЭтапыГрафикаОплаты.Выгрузить();
			
			Если ТаблицаЭтапыГрафикаОплаты.Количество()>0 ИЛИ СтруктураПараметровПечати.КоличествоСтрокГрафикаОплаты>0 Тогда
				
				ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ГрафикОплатыШапка");
				БланкЗаказа.Вывести(ОбластьМакета);
								
				Если ТаблицаЭтапыГрафикаОплаты.Количество()>0 Тогда
					Для Каждого СтрокаЭтапыГрафикаОплаты из ТаблицаЭтапыГрафикаОплаты Цикл
						ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ГрафикОплатыСтрока");
						ОбластьМакета.Параметры.НомерСтроки = СтрокаЭтапыГрафикаОплаты.НомерСтроки;
						ОбластьМакета.Параметры.ВариантОплаты = СтрокаЭтапыГрафикаОплаты.ВариантОплаты;
						ОбластьМакета.Параметры.ДатаПлатежа = СтрокаЭтапыГрафикаОплаты.ДатаПлатежа;
						ОбластьМакета.Параметры.ПроцентПлатежа = СтрокаЭтапыГрафикаОплаты.ПроцентПлатежа;
						БланкЗаказа.Вывести(ОбластьМакета);
					КонецЦикла;
				Иначе
					ВыведеноСтрок = 0;
					Пока ВыведеноСтрок < СтруктураПараметровПечати.КоличествоСтрокГрафикаОплаты Цикл
						ВыведеноСтрок = ВыведеноСтрок + 1;
						ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ГрафикОплатыСтрока");
						ОбластьМакета.Параметры.НомерСтроки = ВыведеноСтрок;
						БланкЗаказа.Вывести(ОбластьМакета);
					КонецЦикла;
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
				
		// Вывод товарного состава задания
		
		ИспользуютсяСкидки = ПолучитьФункциональнуюОпцию("ИспользоватьРучныеСкидкиВПродажах");
		
		ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ТоварыЗаголовок");
		БланкЗаказа.Вывести(ОбластьМакета);

		ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ТоварыШапка|НомерСтроки");
		БланкЗаказа.Вывести(ОбластьМакета);
		
		КолонкаКодов = ФормированиеПечатныхФорм.ИмяДополнительнойКолонки();
		ВыводитьКоды = ЗначениеЗаполнено(КолонкаКодов);
		
		Если ВыводитьКоды Тогда
			ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ТоварыШапка|КолонкаКодов");
			ОбластьМакета.Параметры.ИмяКолонкиКодов = КолонкаКодов;
			БланкЗаказа.Присоединить(ОбластьМакета);
		КонецЕсли;
		
		Если ДанныеОтчета.ДетализацияПоНоменклатуре Тогда
			ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ТоварыШапка|Номенклатура");
		Иначе
			ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ТоварыШапка|НоменклатураБезПлана");
		КонецЕсли;
		
		БланкЗаказа.Присоединить(ОбластьМакета);
				
		Если ДанныеОтчета.ДетализацияПоНоменклатуре Тогда
			ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ТоварыШапка|КоличествоПлан");
			БланкЗаказа.Присоединить(ОбластьМакета);
		КонецЕсли;
		
		ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ТоварыШапка|ДанныеЗаказа");
		БланкЗаказа.Присоединить(ОбластьМакета);
		
		Если ИспользуютсяСкидки Тогда
			ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ТоварыШапка|Скидки");
			БланкЗаказа.Присоединить(ОбластьМакета);
		КонецЕсли;
		
		ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ТоварыШапка|Комментарий");
		БланкЗаказа.Присоединить(ОбластьМакета);
		
		ОбластьШапки = БланкЗаказа.Область(БланкЗаказа.ВысотаТаблицы, ,БланкЗаказа.ВысотаТаблицы, );
		БланкЗаказа.ПовторятьПриПечатиСтроки = ОбластьШапки;
		
		ТаблицаТовары = ДанныеОтчета.Товары.Выгрузить();
		
		НомерСтроки = 0;
		Для Каждого СтрокаТовары из ТаблицаТовары Цикл
			
			Если НЕ ФормированиеПечатныхФорм.ПроверитьЗаполнениеНоменклатуры(СтрокаТовары, СтрокаТовары.НомерСтроки) Тогда
				Продолжить;
			КонецЕсли;
			
			НомерСтроки = НомерСтроки + 1;
			
			ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ТоварыСтрока|НомерСтроки");
			ОбластьМакета.Параметры.НомерСтроки = НомерСтроки;
			БланкЗаказа.Вывести(ОбластьМакета);
			
			Если ВыводитьКоды Тогда
				ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ТоварыСтрока|КолонкаКодов");
				ОбластьМакета.Параметры.Артикул = СтрокаТовары[КолонкаКодов];
				БланкЗаказа.Присоединить(ОбластьМакета);
			КонецЕсли;
			
			Если ДанныеОтчета.ДетализацияПоНоменклатуре Тогда
				ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ТоварыСтрока|Номенклатура");
			Иначе
				ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ТоварыСтрока|НоменклатураБезПлана");
			КонецЕсли;
			
			ОбластьМакета.Параметры.Номенклатура = НоменклатураКлиентСервер.ПредставлениеНоменклатурыДляПечати(
				СтрокаТовары.НаименованиеПолное,
				СтрокаТовары.Характеристика,
				, // Упаковка
				, // Серия
				СтрокаТовары.Содержание
			);
			БланкЗаказа.Присоединить(ОбластьМакета);
			
			Если ДанныеОтчета.ДетализацияПоНоменклатуре Тогда
				ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ТоварыСтрока|КоличествоПлан");
				ОбластьМакета.Параметры.КоличествоПлан = СтрокаТовары.КоличествоПлан;
				БланкЗаказа.Присоединить(ОбластьМакета);
			КонецЕсли;
			
			ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ТоварыСтрока|ДанныеЗаказа");
			ОбластьМакета.Параметры.ЕдиницаИзмерения = СтрокаТовары.ЕдиницаИзмерения;
			ОбластьМакета.Параметры.Цена = СтрокаТовары.Цена;
			БланкЗаказа.Присоединить(ОбластьМакета);
			
			Если ИспользуютсяСкидки Тогда
				ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ТоварыСтрока|Скидки");
				БланкЗаказа.Присоединить(ОбластьМакета);
			КонецЕсли;
			
			ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ТоварыСтрока|Комментарий");
			ОбластьМакета.Параметры.Комментарий = СокрЛП(СтрокаТовары.Комментарий);
			БланкЗаказа.Присоединить(ОбластьМакета);
			
		КонецЦикла;
		
		// Дополнение таблицы товаров пустыми строками - для возможности указания незапланированного товара
		
		ВыведеноДополнительныхСтрок = 0;
		
		Пока ВыведеноДополнительныхСтрок < СтруктураПараметровПечати.КоличествоСтрокНоменклатуры Цикл
			
			НомерСтроки = НомерСтроки + 1;
			
			ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ТоварыСтрока|НомерСтроки");
			ОбластьМакета.Параметры.НомерСтроки = НомерСтроки;
			БланкЗаказа.Вывести(ОбластьМакета);
			
			Если ВыводитьКоды Тогда
				ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ТоварыСтрока|КолонкаКодов");
				БланкЗаказа.Присоединить(ОбластьМакета);
			КонецЕсли;
			
			Если ДанныеОтчета.ДетализацияПоНоменклатуре Тогда
				ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ТоварыСтрока|Номенклатура");
			Иначе
				ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ТоварыСтрока|НоменклатураБезПлана");
			КонецЕсли;
			
			БланкЗаказа.Присоединить(ОбластьМакета);
						
			Если ДанныеОтчета.ДетализацияПоНоменклатуре Тогда
				ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ТоварыСтрока|КоличествоПлан");
				БланкЗаказа.Присоединить(ОбластьМакета);
			КонецЕсли;
			
			ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ТоварыСтрока|ДанныеЗаказа");
			БланкЗаказа.Присоединить(ОбластьМакета);
			
			Если ИспользуютсяСкидки Тогда
				ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ТоварыСтрока|Скидки");
				БланкЗаказа.Присоединить(ОбластьМакета);
			КонецЕсли;
			
			ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ТоварыСтрока|Комментарий");
			БланкЗаказа.Присоединить(ОбластьМакета);
			
			ВыведеноДополнительныхСтрок = ВыведеноДополнительныхСтрок + 1;
		КонецЦикла;
		
		ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ПодвалСумма");
		БланкЗаказа.Вывести(ОбластьМакета);
		
		Если ИспользуютсяСкидки Тогда
			ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ПодвалСкидки");
			БланкЗаказа.Вывести(ОбластьМакета);
		КонецЕсли;
		
		ОбластьМакета = МакетБланкаЗаказа.ПолучитьОбласть("ПодвалПодпись");
		БланкЗаказа.Вывести(ОбластьМакета);
		
		УправлениеПечатью.ЗадатьОбластьПечатиДокумента(БланкЗадания, НомерСтрокиНачалоБланка, ОбъектыПечати, ДанныеОтчета.Ссылка);
		УправлениеПечатью.ЗадатьОбластьПечатиДокумента(БланкЗаказа, НомерСтрокиНачалоТоварногоСостава, ОбъектыПечати, ДанныеОтчета.Ссылка);
		
	КонецЦикла;
	
	БланкЗадания.ВерхнийКолонтитул.ТекстСлева = ЗаголовокДокумента;
	БланкЗадания.АвтоМасштаб = Истина;
	
	БланкЗаказа.ВерхнийКолонтитул.ТекстСлева = ЗаголовокДокумента;
	БланкЗаказа.АвтоМасштаб = Истина;
	
	СтруктураБланка = Новый Структура();
	СтруктураБланка.Вставить("Задание", БланкЗадания);
	СтруктураБланка.Вставить("Заказ", БланкЗаказа);
	
	Возврат СтруктураБланка;
	
КонецФункции

Функция ПолучитьПечатнуюФормуСводногоЗадания(МассивОбъектов, ОбъектыПечати)
		
	СводноеЗадание = Новый ТабличныйДокумент();
	СводноеЗадание.КлючПараметровПечати = "ПАРАМЕТРЫ_ПЕЧАТИ_СводноеЗаданиеТорговмуПредставителю";
	
	Запрос = Новый Запрос();
	Запрос.УстановитьПараметр("МассивОбъектов", МассивОбъектов);
	Запрос.Текст = ПолучитьТекстЗапросаДляФормированияПечатнойФормыСводногоЗадания();
	
	ДанныеОтчета = Запрос.Выполнить().Выбрать();
	
	МакетСводногоЗадания = УправлениеПечатью.ПолучитьМакет("Документ.ЗаданиеТорговомуПредставителю.ПФ_MXL_СводноеЗадание");
	ПервыйДокумент = Истина;
	ТекущийТорговыйПредставитель = Неопределено;
	
	СтруктураПараметровПечати = ПолучитьНастройкиПечатиЗадания();
	
	НомерСтроки = 0;
	
	Пока ДанныеОтчета.Следующий() Цикл
		
		Если ДанныеОтчета.ТорговыйПредставитель <> ТекущийТорговыйПредставитель Тогда
			
			Если Не ПервыйДокумент Тогда
				ВывестиПодвал(МакетСводногоЗадания, СводноеЗадание);
				ВывестиРасходы(МакетСводногоЗадания, СводноеЗадание, СтруктураПараметровПечати);
				
				СводноеЗадание.ВывестиГоризонтальныйРазделительСтраниц();
			КонецЕсли;
			
			НомерСтрокиНачалоБланка = СводноеЗадание.ВысотаТаблицы + 1;
			НомерСтроки = 0;
			ПервыйДокумент = Ложь;
			
			ОбластьМакета = МакетСводногоЗадания.ПолучитьОбласть("Шапка");
			ОбластьМакета.Параметры.ТекстЗаголовка = "Сводное задание торговому представителю";
			ОбластьМакета.Параметры.ТорговыйПредставитель = ДанныеОтчета.ТорговыйПредставитель;
			ШтрихкодированиеПечатныхФорм.ВывестиШтрихкодВТабличныйДокумент(СводноеЗадание, МакетСводногоЗадания, ОбластьМакета, ДанныеОтчета.Ссылка);
			СводноеЗадание.Вывести(ОбластьМакета);
			
			ОбластьМакета = МакетСводногоЗадания.ПолучитьОбласть("ПартнерШапка");
			СводноеЗадание.Вывести(ОбластьМакета);
			
			Если СтруктураПараметровПечати.ВыводитьЗадачиВСводномЗадании Тогда
				ОбластьМакета = МакетСводногоЗадания.ПолучитьОбласть("ЗадачиШапка");
				СводноеЗадание.Вывести(ОбластьМакета);
			КонецЕсли;
			
		КонецЕсли;
		
		НомерСтроки = НомерСтроки + 1;
		
		ОбластьМакета = МакетСводногоЗадания.ПолучитьОбласть("ПартнерСтрока");
		ОбластьМакета.Параметры.НомерСтроки = НомерСтроки;
		ОбластьМакета.Параметры.Дата = Формат(ДанныеОтчета.ДатаВизитаПлан, "ДФ=дд.ММ.гггг");
		
		Если ЗначениеЗаполнено(ДанныеОтчета.ВремяНачала) Тогда
			Время = Формат(ДанныеОтчета.ВремяНачала,"ДФ=чч:мм") + ?(ЗначениеЗаполнено(ДанныеОтчета.ВремяОкончания),"-" + Формат(ДанныеОтчета.ВремяОкончания,"ДФ=чч:мм"),"");
		Иначе
			Время = "";
		КонецЕсли;
		ОбластьМакета.Параметры.Время = Время;
		
		Адрес = ФормированиеПечатныхФорм.ПолучитьАдресИзКонтактнойИнформации(ДанныеОтчета.Партнер);
		Телефон = ФормированиеПечатныхФорм.ПолучитьТелефонИзКонтактнойИнформации(ДанныеОтчета.Партнер);
		
		ИнформацияОПартнере = СокрЛП(ДанныеОтчета.Партнер) + ?(ПустаяСтрока(Адрес),"", ", Адрес: " + Адрес) + ?(ПустаяСтрока(Телефон), "", ", Телефон: " + Телефон);
		
		ОбластьМакета.Параметры.ИнформацияОПартнере = ИнформацияОПартнере;
		СводноеЗадание.Вывести(ОбластьМакета);
		
		Если СтруктураПараметровПечати.ВыводитьЗадачиВСводномЗадании Тогда
			// Вывод задач, определенных в задании
			ТаблицаЗадачи = ДанныеОтчета.Задачи.Выгрузить();
			
			Для Каждого СтрокаЗадачи из ТаблицаЗадачи Цикл
				ОбластьМакета = МакетСводногоЗадания.ПолучитьОбласть("ЗадачиСтрока");
				ОбластьМакета.Параметры.ОписаниеЗадачи = СтрокаЗадачи.ОписаниеЗадачи;
				СводноеЗадание.Вывести(ОбластьМакета);
			КонецЦикла;
		КонецЕсли;
		
		ТекущийТорговыйПредставитель = ДанныеОтчета.ТорговыйПредставитель;
		
		УправлениеПечатью.ЗадатьОбластьПечатиДокумента(СводноеЗадание, НомерСтрокиНачалоБланка, ОбъектыПечати, ДанныеОтчета.Ссылка);
		
	КонецЦикла;
		
	ВывестиПодвал(МакетСводногоЗадания, СводноеЗадание);
	ВывестиРасходы(МакетСводногоЗадания, СводноеЗадание, СтруктураПараметровПечати);
		
	СводноеЗадание.АвтоМасштаб = Истина;
	
	Возврат СводноеЗадание;
	
КонецФункции

// Выводит секцию подвала
//
// Параметры:
//  Макет - макет, на основе которого формируется табличный документ
//  ТабличныйДокумент - итоговый табличный документ, в который выводится секция
//
Процедура ВывестиПодвал(Макет, ТабличныйДокумент)
	
	ОбластьМакета = Макет.ПолучитьОбласть("Подвал");
	ОбластьЯчеек = ТабличныйДокумент.Вывести(ОбластьМакета);
	ОбластьЯчеек.ВысотаСтроки = 1;
	
КонецПроцедуры

// Выводит секцию расходов
//
// Параметры:
//  Макет - макет, на основе которого формируется табличный документ
//  ТабличныйДокумент - итоговый табличный документ, в который выводится секция
//  СтруктураПараметровПечати - структура, содержащая настройки печати
//
Процедура ВывестиРасходы(Макет, ТабличныйДокумент, СтруктураПараметровПечати)
	
	Если СтруктураПараметровПечати.ВыводитьРасходы И СтруктураПараметровПечати.КоличествоСтрокРасходов > 0 Тогда
		
		ОбластьМакета = Макет.ПолучитьОбласть("ПустаяСтрока");
		ТабличныйДокумент.Вывести(ОбластьМакета);
		
		ОбластьМакета = Макет.ПолучитьОбласть("РасходыШапка");
		ТабличныйДокумент.Вывести(ОбластьМакета);
		
		ВыведеноСтрок = 0;
		Пока ВыведеноСтрок < СтруктураПараметровПечати.КоличествоСтрокРасходов Цикл
			ОбластьМакета = Макет.ПолучитьОбласть("РасходыСтрока");
			ОбластьМакета.Параметры.НомерСтроки = ВыведеноСтрок + 1;
			ТабличныйДокумент.Вывести(ОбластьМакета);
			ВыведеноСтрок = ВыведеноСтрок + 1;
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

Функция ПолучитьТекстЗапросаДляФормированияПечатнойФормыБланкаЗадания()
	
	ТекстЗапроса = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ЗаданиеТорговомуПредставителю.Ссылка КАК Ссылка,
	|	ЗаданиеТорговомуПредставителю.Номер КАК Номер,
	|	ЗаданиеТорговомуПредставителю.Дата КАК Дата,
	|	ЗаданиеТорговомуПредставителю.Организация КАК Организация,
	|	ЗаданиеТорговомуПредставителю.Организация.Префикс КАК Префикс,
	|	ЗаданиеТорговомуПредставителю.Партнер КАК Партнер,
	|	ЗаданиеТорговомуПредставителю.Контрагент КАК Контрагент,
	|	ЗаданиеТорговомуПредставителю.ДатаВизитаПлан КАК ДатаВизитаПлан,
	|	ЗаданиеТорговомуПредставителю.ВремяНачала КАК ВремяНачала,
	|	ЗаданиеТорговомуПредставителю.ВремяОкончания КАК ВремяОкончания,
	|	ЗаданиеТорговомуПредставителю.ЦенаВключаетНДС КАК ЦенаВключаетНДС,
	|	ЗаданиеТорговомуПредставителю.Валюта КАК Валюта,
	|	ЗаданиеТорговомуПредставителю.СуммаПлан КАК СуммаПлан,
	|	ЗаданиеТорговомуПредставителю.ТорговыйПредставитель КАК ТорговыйПредставитель,
	|	ЗаданиеТорговомуПредставителю.Куратор КАК Куратор,
	|	ЗаданиеТорговомуПредставителю.Склад КАК Склад,
	|	ЗаданиеТорговомуПредставителю.ДетализацияПоНоменклатуре,
	|	ЗаданиеТорговомуПредставителю.Товары.(
	|		НомерСтроки КАК НомерСтроки,
	|		Номенклатура КАК Номенклатура,
	|		Номенклатура.НаименованиеПолное КАК НаименованиеПолное,
	|		ВЫБОР
	|			КОГДА ЗаданиеТорговомуПредставителю.Товары.Упаковка = ЗНАЧЕНИЕ(Справочник.УпаковкиНоменклатуры.ПустаяСсылка)
	|				ТОГДА ЗаданиеТорговомуПредставителю.Товары.Номенклатура.ЕдиницаИзмерения.Наименование
	|			ИНАЧЕ ЗаданиеТорговомуПредставителю.Товары.Упаковка.Наименование
	|		КОНЕЦ КАК ЕдиницаИзмерения,
	|		КоличествоПлан КАК КоличествоПлан,
	|		Цена КАК Цена,
	|		Характеристика.НаименованиеПолное КАК Характеристика,
	|		Комментарий КАК Комментарий,
	|		Номенклатура.Код КАК Код,
	|		Номенклатура.Артикул КАК Артикул,
	|		Содержание КАК Содержание
	|	),
	|	ЗаданиеТорговомуПредставителю.Задачи.(
	|		НомерСтроки,
	|		ОписаниеЗадачи
	|	),
	|	ЗаданиеТорговомуПредставителю.ЭтапыГрафикаОплаты.(
	|		НомерСтроки КАК НомерСтроки,
	|		ВариантОплаты,
	|		ДатаПлатежа,
	|		ПроцентПлатежа
	|	),
	|	Константы.ИспользоватьХарактеристикиНоменклатуры КАК ИспользуютсяХарактеристики
	|ИЗ
	|	Документ.ЗаданиеТорговомуПредставителю КАК ЗаданиеТорговомуПредставителю
	|		ЛЕВОЕ СОЕДИНЕНИЕ Константы КАК Константы
	|		ПО (ИСТИНА)
	|ГДЕ
	|	ЗаданиеТорговомуПредставителю.Ссылка В(&МассивОбъектов)
	|
	|УПОРЯДОЧИТЬ ПО
	|	Ссылка";
	
	Возврат ТекстЗапроса;
	
КонецФункции

Функция ПолучитьТекстЗапросаДляФормированияПечатнойФормыСводногоЗадания()
	
	ТекстЗапроса = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ЗаданиеТорговомуПредставителю.Ссылка КАК Ссылка,
	|	ЗаданиеТорговомуПредставителю.Номер КАК Номер,
	|	ЗаданиеТорговомуПредставителю.Дата КАК Дата,
	|	ЗаданиеТорговомуПредставителю.Партнер КАК Партнер,
	|	ЗаданиеТорговомуПредставителю.ДатаВизитаПлан КАК ДатаВизитаПлан,
	|	ЗаданиеТорговомуПредставителю.ВремяНачала КАК ВремяНачала,
	|	ЗаданиеТорговомуПредставителю.ВремяОкончания КАК ВремяОкончания,
	|	ЗаданиеТорговомуПредставителю.ТорговыйПредставитель КАК ТорговыйПредставитель,
	|	ЗаданиеТорговомуПредставителю.Задачи.(
	|		ОписаниеЗадачи
	|	)
	|ИЗ
	|	Документ.ЗаданиеТорговомуПредставителю КАК ЗаданиеТорговомуПредставителю
	|ГДЕ
	|	ЗаданиеТорговомуПредставителю.Ссылка В(&МассивОбъектов)
	|
	|УПОРЯДОЧИТЬ ПО
	|	ТорговыйПредставитель,
	|	ДатаВизитаПлан,
	|	ВремяНачала";
	
	Возврат ТекстЗапроса;
	
КонецФункции

// Возвращает настройки печати бланка задания
//
// Возвращаемое значение:
//  Структура, содержащая настройки
//
Функция ПолучитьНастройкиПечатиЗадания()
	
	НастройкиПечатиБланка = Новый Структура();
	
	НастройкиПечатиБланка.Вставить("ВыводитьЗадачиВСводномЗадании", Ложь);
	НастройкиПечатиБланка.Вставить("ВыводитьГрафикОплаты", Истина);
	НастройкиПечатиБланка.Вставить("ВыводитьЗадачи", Истина);
	НастройкиПечатиБланка.Вставить("ВыводитьРасходы", Истина);
	НастройкиПечатиБланка.Вставить("ВыводитьЗаметки", Истина);
	НастройкиПечатиБланка.Вставить("КоличествоСтрокГрафикаОплаты", 3);
	НастройкиПечатиБланка.Вставить("КоличествоСтрокНоменклатуры", 5);
	НастройкиПечатиБланка.Вставить("КоличествоСтрокРасходов", 5);
	НастройкиПечатиБланка.Вставить("КоличествоСтрокЗаметок", 5);
	
	УстановитьЗначенияПараметровИзНастроек(НастройкиПечатиБланка);
	
	Возврат НастройкиПечатиБланка;

КонецФункции

// Устанавливает значения параметров настройки печати
//
// Параметры:
//  СтруктураНастроекПечати - структура, содержащая настройки печати
//
Процедура УстановитьЗначенияПараметровИзНастроек(СтруктураНастроекПечати)
	
	Для Каждого ЭлементСтруктуры из СтруктураНастроекПечати Цикл
		ИмяПараметра = ЭлементСтруктуры.Ключ;
		ЗначениеПараметра = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить("Документ.ЗаданиеТорговомуПредставителю.НастройкиПечатиБланковЗадания", ИмяПараметра);
		
		Если ЗначениеПараметра <> Неопределено Тогда
			СтруктураНастроекПечати[ИмяПараметра] = ЗначениеПараметра;
		КонецЕсли;
	КонецЦикла;

КонецПроцедуры
#КонецЕсли