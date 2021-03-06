﻿////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.ЗакрыватьПриВыборе = Истина;
	Параметры.ЗакрыватьПриЗакрытииВладельца = Ложь;
	ЗаполнитьЗначенияСвойств(ЭтаФорма, Параметры);
	ЭтапыГрафикаОплаты.Очистить();
	ИдентификаторВызывающейФормы = Параметры.УникальныйИдентификатор;
	ИспользоватьОтрицательныеСуммыПлатежа = Параметры.ИспользоватьОтрицательныеСуммыПлатежа;
	ТолькоПросмотр = Параметры.ТолькоПросмотр;
	ДобавитьКолонкуСуммаПлатежа();
	ЗаполнитьЭтапыОплатыИзВременногоХранилищаСервер(Параметры.АдресВоВременномХранилище);
	РассчитатьИтоговыеПоказатели(ЭтаФорма);
	УчитыватьВариантОплаты = Параметры.УчитыватьВариантОплаты;
	
	Заголовок = ТекстЗаголовкаФормы(ЭтапыГрафикаОплаты.Количество());
	
	Если ТолькоПросмотр Тогда
		
		ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ЭтапыГрафикаОплаты", "ТолькоПросмотр", Истина);
		ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ЭтапыГрафикаОплатыЗаполнитьЭтапыГрафикаОплаты", "Доступность", Ложь);
		ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ЭтапыГрафикаОплатыЗаполнитьЭтапыГрафикаПоПредыдущимЗаказам", "Доступность", Ложь);
		
	КонецЕсли;
	
	Если Не УчитыватьВариантОплаты Тогда
		ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ЭтапыГрафикаОплатыВариантОплаты", "Видимость", Ложь);
		ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ЭтапыГрафикаОплатыЗаполнитьЭтапыГрафикаПоПредыдущимЗаказам", "Видимость", Ложь);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Если Модифицированность И Не Готово Тогда
		
		СписокКнопок = Новый СписокЗначений();
		СписокКнопок.Добавить("Закрыть", НСтр("ru = 'Закрыть'"));
		СписокКнопок.Добавить("НеЗакрывать", НСтр("ru = 'Не закрывать'"));
		
		ОтветНаВопрос = Вопрос(НСтр("ru = 'Все измененные данные будут потеряны. Закрыть форму?'"), СписокКнопок);
		
		Если ОтветНаВопрос = "НеЗакрывать" Тогда
			Отказ = Истина;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ КОМАНД

&НаКлиенте
Процедура ЗаполнитьЭтапыГрафикаОплаты()
	
	СуммаЭтаповОплаты = ЭтапыГрафикаОплаты.Итог("СуммаПлатежа");
	
	ГрафикСоглашенияЗаполнен = ЗакупкиВызовСервера.ГрафикСоглашенияЗаполнен(Соглашение);
	
	Если СуммаДокумента = 0 Тогда
		
		Если ЭтапыГрафикаОплаты.Количество() = 0 Тогда
			
			Предупреждение(НСтр("ru='Сумма заказанных строк нулевая. Заполнение этапов оплаты не требуется.'"));
			Возврат;
			
		КонецЕсли;
		
		ЭтапыГрафикаОплаты.Очистить();
		ЦенообразованиеКлиент.ОповеститьОНевозможностиЗаполненияЭтаповГрафикаОплаты();
		РассчитатьИтоговыеПоказатели(ЭтаФорма);
		Возврат;
		
	КонецЕсли;
	
	ВариантыОтветов = Новый СписокЗначений;
	ВариантыОтветов.Добавить(КодВозвратаДиалога.Да, НСтр("ru='Перезаполнить таблицу'"));
	ВариантыОтветов.Добавить(КодВозвратаДиалога.Отмена, НСтр("ru='Отменить'"));
	
	ЕстьВопросКПользователю = Истина;
	ТекстВопроса = "";
	ПерезаполнитьЭтапы = Ложь;
	РаспределитьСумму = Ложь;
	
	Если СуммаДокумента = СуммаЭтаповОплаты Тогда
		
		ТекстВопроса = НСтр("ru='Сумма заказанных строк совпадает с суммой этапов оплаты'") + Символы.ПС +
							НСтр("ru='Перезаполнить этапы оплаты %ИсточникЗаполнения%?'");
		
	ИначеЕсли ЭтапыГрафикаОплаты.Количество() > 0 Тогда
		
		ВариантыОтветов.Вставить(1, КодВозвратаДиалога.Нет, НСтр("ru='Распределить сумму'"));
		
		ТекстВопроса = НСтр("ru='Таблица этапов оплаты заполнена'")+ Символы.ПС +
							НСтр("ru='Перезаполнить этапы оплаты %ИсточникЗаполнения% или распределить сумму по имеющимся этапам?'");
		
	Иначе
		
		ПерезаполнитьЭтапы = Истина;
		ЕстьВопросКПользователю = Ложь;
		
	КонецЕсли;
	
	Если ЕстьВопросКПользователю Тогда
		
		ТекстВопроса = СтрЗаменить(ТекстВопроса, "%ИсточникЗаполнения%", ?(ГрафикСоглашенияЗаполнен,НСтр("ru='по соглашению'"),НСтр("ru='по умолчанию'")));
		
		ОтветНаВопрос = Вопрос(ТекстВопроса, ВариантыОтветов);
		
		Если ОтветНаВопрос = КодВозвратаДиалога.Да Тогда
			ПерезаполнитьЭтапы = Истина;
		ИначеЕсли ОтветНаВопрос = КодВозвратаДиалога.Нет Тогда
			РаспределитьСумму = Истина;
		Иначе
			Возврат;
		КонецЕсли;
		
	КонецЕсли;
	
	Если ПерезаполнитьЭтапы Тогда
		
		Если ГрафикСоглашенияЗаполнен Тогда
			
			ЗаполнитьЭтапыОплатыПоСоглашениюСервер(СуммаДокумента);
			ЦенообразованиеКлиент.ОповеститьОбОкончанииЗаполненияЭтаповГрафикаОплаты();
			
		Иначе
			
			Если ЖелаемаяДатаПоступленияКорректна() Тогда
				
				ЦенообразованиеКлиент.ДобавитьЭтапОплатыПоУмолчанию(
					ЭтапыГрафикаОплаты,
					ЖелаемаяДатаПоступления,
					СуммаДокумента,
					ПредопределенноеЗначение("Перечисление.ВариантыОплатыПоставщику.ПредоплатаДоПоступления")
				);
				ЦенообразованиеКлиент.ОповеститьОбОкончанииЗаполненияЭтаповГрафикаОплаты();
				
			Иначе
				Возврат;
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЕсли;
	
	Если РаспределитьСумму Тогда
		
		ЦенообразованиеКлиентСервер.РаспределитьСуммуПоЭтапамГрафикаОплаты(ЭтапыГрафикаОплаты, СуммаДокумента);
		ЦенообразованиеКлиент.ОповеститьОбОкончанииЗаполненияЭтаповГрафикаОплаты();
		
	КонецЕсли;
	
	ПронумероватьТаблицуЭтапов();
	РассчитатьИтоговыеПоказатели(ЭтаФорма);
	Заголовок = ТекстЗаголовкаФормы(ЭтапыГрафикаОплаты.Количество());
	
Конецпроцедуры

&НаКлиенте
Процедура ЗаполнитьЭтапыГрафикаПоПредыдущимЗаказам(Команда)
	
	Если НЕ ЗначениеЗаполнено(Партнер) Тогда
		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			НСтр("ru='Поле ""Поставщик"" не заполнено'"), ,
			"Партнер"
		);
		Возврат;
		
	КонецЕсли;
	
	ПронумероватьТаблицуЭтапов();
	РассчитатьИтоговыеПоказатели(ЭтаФорма);
	Если СуммаДокумента = 0 Тогда
		
		Если ЭтапыГрафикаОплаты.Количество() = 0 Тогда
			
			Предупреждение(НСтр("ru='Сумма заказанных строк нулевая. Заполнение этапов оплаты не требуется.'"));
			
		Иначе
			
			ЭтапыГрафикаОплаты.Очистить();
			ЦенообразованиеКлиент.ОповеститьОНевозможностиЗаполненияЭтаповГрафикаОплаты();
			
		КонецЕсли;
		
		Возврат;
		
	КонецЕсли;
	
	КоличествоДокументов = ЗаполнитьШаблоныГрафиков();
	КодГрафика = Неопределено;
	
	Если ШаблоныГрафиков.Количество() > 1 Тогда
		
		АдресТаблицыШаблонов = ПоместитьВоВременноеХранилище(ШаблоныГрафиков);
		КодГрафика = ОткрытьФормуМодально(
			"Документ.ЗаказПоставщику.Форма.ФормаВыбораГрафикаИзПредыдущихЗаказов", 
			Новый Структура("АдресТаблицыШаблонов, КоличествоДокументов", АдресТаблицыШаблонов, КоличествоДокументов)
		);
		
	ИначеЕсли ШаблоныГрафиков.Количество() = 1 Тогда
		
		КодГрафика = ШаблоныГрафиков[0].КодГрафика;
		
	Иначе
		
		ТекстСообщения = НСтр("ru='Для поставщика ""%Поставщик%"", нет проведенных заказов. Заполнение этапов отменено.'");
		ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Поставщик%", Партнер);
		Предупреждение(ТекстСообщения);
		
	КонецЕсли;
	
	Если КодГрафика <> Неопределено Тогда
		
		ЗаполнитьЭтапыГрафикаОплатыПоШаблону(КодГрафика);
		РассчитатьИтоговыеПоказатели(ЭтаФорма);
		ЦенообразованиеКлиент.ОповеститьОбОкончанииЗаполненияЭтаповГрафикаОплаты();
		
	КонецЕсли;
	
	ПронумероватьТаблицуЭтапов();
	РассчитатьИтоговыеПоказатели(ЭтаФорма);
	Заголовок = ТекстЗаголовкаФормы(ЭтапыГрафикаОплаты.Количество());
КонецПроцедуры

&НаКлиенте
Процедура ОК(Команда)
	
	ОчиститьСообщения();
	
	Если ТолькоПросмотр Тогда
		
		Закрыть();
		
	ИначеЕсли ОплатаКорректна() Тогда
		
		Готово = Истина;
		СтруктураОбъекта = Новый Структура();
		СтруктураОбъекта.Вставить("АдресВоВременномХранилище", ПоместитьВоВременноеХранилищеНаСервере());
		
		Закрыть(СтруктураОбъекта);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	Закрыть();
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ТАБЛИЦЫ ФОРМЫ ЭТАПЫ ГРАФИКА ОПЛАТЫ

&НаКлиенте
Процедура ЭтапыГрафикаОплатыПослеУдаления(Элемент)
	
	ПронумероватьТаблицуЭтапов();
	РассчитатьИтоговыеПоказатели(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ЭтапыГрафикаОплатыПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	СортироватьЭтапыОплаты();
	ПронумероватьТаблицуЭтапов();
	РассчитатьИтоговыеПоказатели(ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ЭтапыГрафикаОплатыПроцентПлатежаПриИзменении(Элемент)

	ЦенообразованиеКлиент.ЭтапыГрафикаОплатыПроцентПлатежаПриИзменении(
		Элементы.ЭтапыГрафикаОплаты.ТекущиеДанные,
		ЭтапыГрафикаОплаты,
		СуммаДокумента
	);

КонецПроцедуры

&НаКлиенте
Процедура ЭтапыГрафикаОплатыСуммаПлатежаПриИзменении(Элемент)

	ЦенообразованиеКлиент.ЭтапыГрафикаОплатыСуммаПлатежаПриИзменении(
		Элементы.ЭтапыГрафикаОплаты.ТекущиеДанные,
		ЭтапыГрафикаОплаты,
		СуммаДокумента
	);

КонецПроцедуры

&НаКлиенте
Процедура ЭтапыГрафикаОплатыПриИзменении(Элемент)
	
	Заголовок = ТекстЗаголовкаФормы(ЭтапыГрафикаОплаты.Количество());
	ПронумероватьТаблицуЭтапов();
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

////////////////////////////////////////////////////////////////////////////////
// График оплаты

&НаСервере
Процедура ЗаполнитьЭтапыОплатыПоСоглашениюСервер(Знач СуммаДокумента)
	ПараметрыЗаполнения = Новый Структура;
	ПараметрыЗаполнения.Вставить("ФормаОплаты", ФормаОплаты);
	ПараметрыЗаполнения.Вставить("ЭтапыГрафикаОплаты", ЭтапыГрафикаОплаты);
	ПараметрыЗаполнения.Вставить("Дата", Дата);
	ПараметрыЗаполнения.Вставить("ЖелаемаяДатаПоступления", ЖелаемаяДатаПоступления);
	ПараметрыЗаполнения.Вставить("Соглашение", Соглашение);

	ЗакупкиСервер.ЗаполнитьЭтапыГрафикаОплатыПоСоглашению(ПараметрыЗаполнения, СуммаДокумента);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьЭтапыГрафикаОплатыПоШаблону(КодГрафика)
	
	ЭтапыВыбранногоШаблона = ЭтапыШаблонов.НайтиСтроки(Новый Структура("КодГрафика", КодГрафика));
	
	ПараметрыЗаполнения = Новый Структура;
	ПараметрыЗаполнения.Вставить("ФормаОплаты", ФормаОплаты);
	ПараметрыЗаполнения.Вставить("ЭтапыГрафикаОплаты", ЭтапыГрафикаОплаты);
	ПараметрыЗаполнения.Вставить("Дата", Дата);
	ПараметрыЗаполнения.Вставить("ЖелаемаяДатаПоступления", ЖелаемаяДатаПоступления);
	ПараметрыЗаполнения.Вставить("Соглашение", Соглашение);
	
	ЗакупкиСервер.ЗаполнитьЭтапыГрафикаОплаты(ПараметрыЗаполнения, СуммаДокумента, ЭтапыВыбранногоШаблона, Соглашение.Календарь);
	
КонецПроцедуры

&НаСервере
Функция СформироватьПредставлениеШаблонаГрафика(МассивЭтаповГрафика)
	
	ПредставлениеГрафика = "";
	
	ФормСтрока = "Л = ru_RU; НД = ЛОЖЬ";
	ПарПредмета=НСтр("ru='день,дня,дней,м,день,дня,дней,м,0'");
	
	ШаблонПредставленияЭтапа = НСтр("ru='%ВариантОплаты% %ПроцентПлатежа%% (%Отсрочка%)'");
	
	ПервыйЭтап = Истина;
	
	Для Каждого ЭтапГрафика Из МассивЭтаповГрафика Цикл
		
		Если ЭтапГрафика.ВариантОплаты = Перечисления.ВариантыОплатыПоставщику.ПредоплатаДоПоступления Тогда
			ТекстВариантаОплаты = НСтр("ru='Предоплата'");
		ИначеЕсли ЭтапГрафика.ВариантОплаты = Перечисления.ВариантыОплатыПоставщику.АвансДоПодтверждения Тогда
			ТекстВариантаОплаты = НСтр("ru='Аванс'");
		Иначе
			ТекстВариантаОплаты = НСтр("ru='Кредит'");
		КонецЕсли;
		
		ТекстОтсрочки = Формат(ЭтапГрафика.Сдвиг, "ЧН=0; ЧГ=0") + " " + СтрЗаменить(Прав(ЧислоПрописью(ЭтапГрафика.Сдвиг, ФормСтрока, ПарПредмета), 4)," ", "");
		
		ПредставлениеЭтапа = СтрЗаменить(ШаблонПредставленияЭтапа, "%ВариантОплаты%", ТекстВариантаОплаты);
		ПредставлениеЭтапа = СтрЗаменить(ПредставлениеЭтапа, "%Отсрочка%", ТекстОтсрочки);
		ПредставлениеЭтапа = СтрЗаменить(ПредставлениеЭтапа, "%ПроцентПлатежа%", ЭтапГрафика.ПроцентПлатежа);
		
		Если ПервыйЭтап Тогда
			ПервыйЭтап = Ложь;
			ПредставлениеГрафика = ПредставлениеГрафика + ПредставлениеЭтапа;
		Иначе
			ПредставлениеГрафика = ПредставлениеГрафика + ", " + ПредставлениеЭтапа;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат ПредставлениеГрафика + ".";
	
КонецФункции

&НаСервере
Процедура ПоместитьГрафикВТаблицуШаблонов(ПредставлениеГрафика,
	                                      МассивЭтаповГрафика,
	                                      КодГрафика,
	                                      ДатаПоследнегоИспользования,
	                                      ДокументПоследнегоИспользования)
	
	СтрокаТаблицыГрафиков = ШаблоныГрафиков.Добавить();
	СтрокаТаблицыГрафиков.ПредставлениеГрафика            = ПредставлениеГрафика;
	СтрокаТаблицыГрафиков.КодГрафика                      = КодГрафика;
	СтрокаТаблицыГрафиков.ЧастотаИспользования            = 1;
	СтрокаТаблицыГрафиков.ДатаПоследнегоИспользования     = ДатаПоследнегоИспользования;
	СтрокаТаблицыГрафиков.ДокументПоследнегоИспользования = ДокументПоследнегоИспользования;
	
	Для Каждого ЭтапГрафика Из МассивЭтаповГрафика Цикл
		
		СтрокаЭтапа = ЭтапыШаблонов.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаЭтапа, ЭтапГрафика);
		СтрокаЭтапа.КодГрафика = КодГрафика;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура СформироватьТекстЗапросаПоГрафикамДокументов(ТекстЗапроса)
	
	ТекстЗапроса = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ ПЕРВЫЕ 50
	|	ЗаказПоставщикуЭтапыГрафикаОплаты.Ссылка КАК Ссылка,
	|	ЗаказПоставщикуЭтапыГрафикаОплаты.Ссылка.Соглашение КАК Соглашение,
	|	ЗаказПоставщикуЭтапыГрафикаОплаты.Ссылка.Дата КАК Дата,
	|	ЗаказПоставщикуЭтапыГрафикаОплаты.Ссылка.ЖелаемаяДатаПоступления КАК ЖелаемаяДатаПоступления,
	|	ЗаказПоставщикуЭтапыГрафикаОплаты.Ссылка.МоментВремени КАК МоментВремени
	|ПОМЕСТИТЬ ДокументыЗаказов
	|ИЗ
	|	Документ.ЗаказПоставщику.ЭтапыГрафикаОплаты КАК ЗаказПоставщикуЭтапыГрафикаОплаты
	|ГДЕ
	|	ЗаказПоставщикуЭтапыГрафикаОплаты.Ссылка.ПометкаУдаления = ЛОЖЬ
	|	И ЗаказПоставщикуЭтапыГрафикаОплаты.Ссылка.Проведен = ИСТИНА
	|	И ЗаказПоставщикуЭтапыГрафикаОплаты.Ссылка.Партнер = &Партнер
	|	И ЗаказПоставщикуЭтапыГрафикаОплаты.Ссылка.Ссылка <> &СсылкаНаТекущийЗаказ
	|	И ЗаказПоставщикуЭтапыГрафикаОплаты.Ссылка.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаУПоставщика)
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ДокументыЗаказов.Ссылка КАК ДокументПоследнегоИспользования,
	|	СоглашенияСПоставщиками.Календарь КАК Календарь,
	|	НАЧАЛОПЕРИОДА(ДокументыЗаказов.Дата, ДЕНЬ) КАК ДатаДокумента,
	|	НАЧАЛОПЕРИОДА(ДокументыЗаказов.ЖелаемаяДатаПоступления, ДЕНЬ) КАК ДатаПоступления,
	|	НАЧАЛОПЕРИОДА(ЗаказПоставщикуЭтапыГрафикаОплаты.ДатаПлатежа, ДЕНЬ) КАК ДатаПлатежа,
	|	ЗаказПоставщикуЭтапыГрафикаОплаты.ВариантОплаты КАК ВариантОплаты,
	|	ЗаказПоставщикуЭтапыГрафикаОплаты.ПроцентПлатежа КАК ПроцентПлатежа,
	|	ДокументыЗаказов.Дата КАК ДатаПоследнегоИспользования
	|ИЗ
	|	ДокументыЗаказов КАК ДокументыЗаказов
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.ЗаказПоставщику.ЭтапыГрафикаОплаты КАК ЗаказПоставщикуЭтапыГрафикаОплаты
	|		ПО (ЗаказПоставщикуЭтапыГрафикаОплаты.Ссылка = ДокументыЗаказов.Ссылка)
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.СоглашенияСПоставщиками КАК СоглашенияСПоставщиками
	|		ПО ДокументыЗаказов.Соглашение = СоглашенияСПоставщиками.Ссылка
	|
	|УПОРЯДОЧИТЬ ПО
	|	ДокументыЗаказов.МоментВремени,
	|	ЗаказПоставщикуЭтапыГрафикаОплаты.НомерСтроки
	|ИТОГИ
	|	КОЛИЧЕСТВО(ВариантОплаты),
	|	МАКСИМУМ(ДатаПоследнегоИспользования)
	|ПО
	|	ДокументПоследнегоИспользования";
	
КонецПроцедуры

&НаСервере
Функция ЗаполнитьШаблоныГрафиков()
	
	ШаблоныГрафиков.Очистить();
	ЭтапыШаблонов.Очистить();
	
	ОдинДень = 86400;
	
	Запрос = Новый Запрос;
	СформироватьТекстЗапросаПоГрафикамДокументов(Запрос.Текст);
	Запрос.УстановитьПараметр("Партнер", Партнер);
	Запрос.УстановитьПараметр("СсылкаНаТекущийЗаказ", Ключ);
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат 0;
	КонецЕсли;
	
	СчетГрафиков = 0;
	
	ВыборкаДокумент = Результат.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	Пока ВыборкаДокумент.Следующий() Цикл
		
		КоличествоЭтаповГрафика = ВыборкаДокумент.ВариантОплаты;
		
		Если КоличествоЭтаповГрафика = 0 Тогда
			Продолжить;
		КонецЕсли;
		
		Если ЗначениеЗаполнено(ВыборкаДокумент.Календарь) Тогда
			Календарь = ВыборкаДокумент.Календарь;
		Иначе
			Календарь = Константы.ОсновнойКалендарьПредприятия.Получить();
		КонецЕсли;
		
		НовыйГрафик = Новый Массив();
		ВыборкаГрафик = ВыборкаДокумент.Выбрать();
		ДатаНачала = Неопределено;
		ДатаОкончания = Неопределено;
		Пока ВыборкаГрафик.Следующий() Цикл
			
			СтруктураЭтапа = Новый Структура("ВариантОплаты, ПроцентПлатежа");
			ЗаполнитьЗначенияСвойств(СтруктураЭтапа, ВыборкаГрафик);
			
			ДатаНачала = ВыборкаГрафик.ДатаДокумента;
			Если ВыборкаГрафик.ВариантОплаты = Перечисления.ВариантыОплатыПоставщику.КредитПослеПоступления Тогда
				Если ЗначениеЗаполнено(ВыборкаГрафик.ДатаПоступления) Тогда
					ДатаНачала = ВыборкаГрафик.ДатаПоступления;
				Иначе
					ДатаНачала = ?(ЗначениеЗаполнено(ДатаОкончания), ДатаОкончания, ВыборкаГрафик.ДатаДокумента);
				КонецЕсли;
			КонецЕсли;
			
			ДатаОкончания = ВыборкаГрафик.ДатаПлатежа;
			
			Если ЗначениеЗаполнено(Календарь) Тогда
				СтруктураЭтапа.Вставить("Сдвиг", КалендарныеГрафики.ПолучитьРазностьДатПоКалендарю(Календарь, ДатаНачала, ДатаОкончания));
			Иначе
				СтруктураЭтапа.Вставить("Сдвиг", Цел((ДатаОкончания-ДатаНачала)/ОдинДень));
			КонецЕсли;
			
			НовыйГрафик.Добавить(СтруктураЭтапа);
			
		КонецЦикла;
		
		ПредставлениеГрафика = СформироватьПредставлениеШаблонаГрафика(НовыйГрафик);
		СтрокиГрафиков = ШаблоныГрафиков.НайтиСтроки(Новый Структура("ПредставлениеГрафика", ПредставлениеГрафика));
		Если СтрокиГрафиков.Количество() = 0 Тогда
			
			ПоместитьГрафикВТаблицуШаблонов(
				ПредставлениеГрафика,
				НовыйГрафик,
				СчетГрафиков,
				ВыборкаДокумент.ДатаПоследнегоИспользования,
				ВыборкаДокумент.ДокументПоследнегоИспользования
			);
			СчетГрафиков = СчетГрафиков + 1;
			
		Иначе
			
			СтруктураГрафика = СтрокиГрафиков[0];
			СтруктураГрафика.ЧастотаИспользования = СтруктураГрафика.ЧастотаИспользования + 1;
			Если СтруктураГрафика.ДатаПоследнегоИспользования < ВыборкаДокумент.ДатаПоследнегоИспользования Тогда
				СтруктураГрафика.ДатаПоследнегоИспользования = ВыборкаДокумент.ДатаПоследнегоИспользования;
				СтруктураГрафика.ДокументПоследнегоИспользования = ВыборкаДокумент.ДокументПоследнегоИспользования;
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЦикла;
	
	ШаблоныГрафиков.Сортировать("ЧастотаИспользования Убыв, ДатаПоследнегоИспользования Убыв");
	
	Возврат ВыборкаДокумент.Количество();
	
КонецФункции

&НаКлиенте
Функция ЖелаемаяДатаПоступленияКорректна()
	
	ДатаДокумента = НачалоДня(Дата);
		
	Если ЗначениеЗаполнено(ЖелаемаяДатаПоступления) И ЖелаемаяДатаПоступления < ДатаДокумента Тогда
			
		ТекстВопроса = НСтр("ru='Желаемая дата поступления меньше даты документа. Необходимо ввести корректную желаемую дату.'");
		ОтветНаВопрос = Вопрос(ТекстВопроса, РежимДиалогаВопрос.ОКОтмена);
		
		Если ОтветНаВопрос = КодВозвратаДиалога.Отмена Тогда
			Возврат Ложь;
		КонецЕсли;
			
		ЖелаемаяДата  = ДатаДокумента;
		
		Если Не РаботаСДиалогамиКлиент.ВвестиДатуСКонтролемПустогоЗначения(ЖелаемаяДата, НСтр("ru='Введите желаемую дату поступления'"), ЧастиДаты.Дата) Тогда
			Возврат Ложь;
		КонецЕсли;
			
		Если ЖелаемаяДата < ДатаДокумента Тогда
			Предупреждение( НСтр("ru='Желаемая дата поступления меньше даты документа. Этапы оплаты не могут быть заполнены.'"));
			Возврат Ложь;
		Иначе
			ЖелаемаяДатаПоступления = ЖелаемаяДата;
			Возврат Истина;
		КонецЕсли;
		
	Иначе
		
		Возврат Истина;
		
	КонецЕсли;
		
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// Прочее

&НаСервере
Функция ПоместитьВоВременноеХранилищеНаСервере()
	
	Возврат ПоместитьВоВременноеХранилище(ЭтапыГрафикаОплаты.Выгрузить(), ИдентификаторВызывающейФормы);
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Процедура РассчитатьИтоговыеПоказатели(Форма)
	
	ПредыдущееЗначениеДаты = Дата(1,1,1);
	Форма.НомерСтрокиПолнойОплаты = 0;
	ПроцентПлатежейОбщий = 0;
	
	СоответствиеВариантовОплаты = Новый Соответствие;
	СоответствиеВариантовОплаты.Вставить(ПредопределенноеЗначение("Перечисление.ВариантыОплатыКлиентом.АвансДоОбеспечения"),
		Новый Структура("Сумма, Проценты", "СуммаАвансаДоОбеспечения", "ПроцентАвансаДоОбеспечения")
	);
	СоответствиеВариантовОплаты.Вставить(ПредопределенноеЗначение("Перечисление.ВариантыОплатыКлиентом.ПредоплатаДоОтгрузки"),
		Новый Структура("Сумма, Проценты", "СуммаПредоплатыДоОтгрузки", "ПроцентПредоплатыДоОтгрузки")
	);
	СоответствиеВариантовОплаты.Вставить(ПредопределенноеЗначение("Перечисление.ВариантыОплатыКлиентом.КредитПослеОтгрузки"),
		Новый Структура("Сумма, Проценты", "СуммаКредитаПослеОтгрузки", "ПроцентКредитаПослеОтгрузки")
	);
	
	Для Каждого ТекСтрока Из Форма.ЭтапыГрафикаОплаты Цикл
		ПроцентПлатежейОбщий = ПроцентПлатежейОбщий + ТекСтрока.ПроцентПлатежа;
		ТекСтрока.ПроцентЗаполненНеВерно = (ПроцентПлатежейОбщий > 100);
		ТекСтрока.ДатаЗаполненаНеВерно = (ПредыдущееЗначениеДаты > ТекСтрока.ДатаПлатежа);
		ПредыдущееЗначениеДаты = ТекСтрока.ДатаПлатежа;
		Если ПроцентПлатежейОбщий = 100 Тогда
			Форма.НомерСтрокиПолнойОплаты = ТекСтрока.НомерСтроки;
		КонецЕсли;
		ИменаЭлементов = СоответствиеВариантовОплаты[ТекСтрока.ВариантОплаты];
		Если ИменаЭлементов <> Неопределено Тогда
			Форма[ИменаЭлементов.Сумма] = Форма[ИменаЭлементов.Сумма] + ТекСтрока.СуммаПлатежа;
			Форма[ИменаЭлементов.Проценты] = Форма[ИменаЭлементов.Проценты] + ТекСтрока.ПроцентПлатежа;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция ОплатаКорректна()
	
	Отказ = Ложь;
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("ЖелаемаяДатаПоступления", ЖелаемаяДатаПоступления);
	СтруктураПараметров.Вставить("Дата", Дата);
	СтруктураПараметров.Вставить("Валюта", Валюта);

	ЗакупкиСервер.ПроверитьКорректностьЭтаповГрафикаОплатыПоТаблицеЗначений(ЭтапыГрафикаОплаты, СуммаДокумента, УчитыватьВариантОплаты, Отказ,, СтруктураПараметров);
	Возврат Не Отказ;
	
КонецФункции

&НаСервере
Процедура ЗаполнитьЭтапыОплатыИзВременногоХранилищаСервер(АдресВоВременномХранилище)
	
	ЭтапыОплаты = ПолучитьИзВременногоХранилища(АдресВоВременномХранилище);
	
	Для Каждого ТекСтрока Из ЭтапыОплаты Цикл
		НоваяСтрока = ЭтапыГрафикаОплаты.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, ТекСтрока);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ТекстЗаголовкаФормы(КоличествоЭтаповОплаты)
	
	Если КоличествоЭтаповОплаты > 0 Тогда
		ТекстЗаголовка = НСтр("ru = 'Этапы оплаты (%КоличествоЭтаповОплаты%)'");
	Иначе
		ТекстЗаголовка = НСтр("ru = 'Этапы оплаты'");
	КонецЕсли;
	
	ТекстЗаголовка = СтрЗаменить(ТекстЗаголовка, "%КоличествоЭтаповОплаты%", КоличествоЭтаповОплаты);
	
	Возврат ТекстЗаголовка;
	
КонецФункции

&НаСервере
Процедура СортироватьЭтапыОплаты()
	Если УчитыватьВариантОплаты Тогда
		АдресВоВременномХранилище = ПоместитьВоВременноеХранилищеНаСервере();
		ЭтапыГрафикаОплаты.Загрузить(ВзаиморасчетыСервер.СортироватьЭтапыОплатыПоставщику(АдресВоВременномХранилище));
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПронумероватьТаблицуЭтапов()
	НомерСтроки = 1;
	Для каждого СтрокаТаблицы Из ЭтапыГрафикаОплаты Цикл
		СтрокаТаблицы.НомерСтроки = НомерСтроки;
		НомерСтроки = НомерСтроки + 1;
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура ДобавитьКолонкуСуммаПлатежа()
	
	ЭтапыГрафикаОплатыЗначение = РеквизитФормыВЗначение("ЭтапыГрафикаОплаты");
	ЭтапыГрафикаОплатыЗначение.Колонки.Добавить("СуммаПлатежа", Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(15, 2, 
										?(ИспользоватьОтрицательныеСуммыПлатежа, ДопустимыйЗнак.Любой, ДопустимыйЗнак.Неотрицательный))));
										
	ДобавляемыеКолонки = Новый Массив();
	ДобавляемыеКолонки.Добавить(Новый РеквизитФормы("СуммаПлатежа", Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(15, 2, 
										?(ИспользоватьОтрицательныеСуммыПлатежа, ДопустимыйЗнак.Любой, ДопустимыйЗнак.Неотрицательный))),
										"ЭтапыГрафикаОплаты", "СуммаПлатежа", Истина));
	ИзменитьРеквизиты(ДобавляемыеКолонки,);
	ЗначениеВРеквизитФормы(ЭтапыГрафикаОплатыЗначение, "ЭтапыГрафикаОплаты");
	
	НовоеПоле = Элементы.Добавить("ЭтапыГрафикаОплатыСуммаПлатежа", Тип("ПолеФормы"),Элементы.ЭтапыГрафикаОплаты);
	НовоеПоле.ПутьКДанным         = "ЭтапыГрафикаОплаты.СуммаПлатежа";
	НовоеПоле.РежимРедактирования = РежимРедактированияКолонки.ВходПриВводе;
	НовоеПоле.Вид                 = ВидПоляФормы.ПолеВвода;
	НовоеПоле.ТолькоПросмотр      = ТолькоПросмотр;
	НовоеПоле.УстановитьДействие("ПриИзменении","ЭтапыГрафикаОплатыСуммаПлатежаПриИзменении");
	НовоеПоле.Заголовок = "Сумма платежа";
	НовоеПоле.Видимость = Истина;
	
КонецПроцедуры