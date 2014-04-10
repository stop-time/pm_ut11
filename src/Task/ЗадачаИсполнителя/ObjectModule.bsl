﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

////////////////////////////////////////////////////////////////////////////////
// ПРОГРАММНЫЙ ИНТЕРФЕЙС

// Возвращает Истина, если в задаче указан исполнитель или роль исполнителя.
//
Функция РеквизитыАдресацииЗаполнены() Экспорт
	
	Возврат НЕ Исполнитель.Пустая() ИЛИ НЕ РольИсполнителя.Пустая();

КонецФункции

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ 

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	ЗадачаБылаВыполнена = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка, "Выполнена");
	Если НЕ ЗадачаБылаВыполнена И Выполнена Тогда
		
		Если НЕ РеквизитыАдресацииЗаполнены() Тогда
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
				НСтр("ru = 'Необходимо указать исполнителя задачи.'"),,,
				"Объект.Исполнитель", Отказ);
			Возврат;
		КонецЕсли;
		
	ИначеЕсли ЗадачаБылаВыполнена И Выполнена Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			НСтр("ru = 'Эта задача уже была выполнена ранее.'"),,,, Отказ);
		Возврат;
	КонецЕсли;
	
	Если СрокИсполнения <> '00010101' И ДатаНачала > СрокИсполнения Тогда
		//АК Петр иногда бывает
		
		//ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
		//	НСтр("ru = 'Дата начала исполнения не должна превышать крайний срок.'"),,,
		//	"Объект.ДатаНачала", Отказ);
		//Возврат;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
		
	ЗадачаБылаВыполнена = Ложь;
	Если НЕ Ссылка.Пустая() Тогда
		ЗадачаБылаВыполнена = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка, "Выполнена");
	КонецЕсли;
	Если НЕ ЗадачаБылаВыполнена И Выполнена Тогда
		
		Если СостояниеБизнесПроцесса = Перечисления.СостоянияБизнесПроцессов.Остановлен Тогда
			ВызватьИсключение НСтр("ru = 'Нельзя выполнять задачи остановленных бизнес-процессов.'");
		КонецЕсли;	
		
		// Если задача выполнена, то запишем в реквизит Исполнитель того
		// пользователя, который фактически выполнил задачу. Это нам потом
		// потребуется для отчетов. Такую запись делаем только в том
		// случае, если в базе было не выполнено, а в объекте стало выполнено
		Если НЕ ЗначениеЗаполнено(Исполнитель) Тогда
			Исполнитель = Пользователи.ТекущийПользователь();
		КонецЕсли;
		Если ДатаИсполнения = Дата(1, 1, 1) Тогда
			ДатаИсполнения = ТекущаяДатаСеанса();
		КонецЕсли;
	КонецЕсли;
	
	Если Важность.Пустая() Тогда
		Важность = Перечисления.ВариантыВажностиЗадачи.Обычная;
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(СостояниеБизнесПроцесса) Тогда
		СостояниеБизнесПроцесса = Перечисления.СостоянияБизнесПроцессов.Активен;
	КонецЕсли;
	
	ПредметСтрокой = ОбщегоНазначения.ПредметСтрокой(Предмет);
	
	ПредыдущаяПометкаУдаления = Ложь;
	Если НЕ Ссылка.Пустая() Тогда
		ПредыдущаяПометкаУдаления = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка, "ПометкаУдаления");
	КонецЕсли;
	
	Если ПредыдущаяПометкаУдаления <> ПометкаУдаления Тогда
		БизнесПроцессыИЗадачиСервер.ПриПометкеУдаленияЗадачи(Ссылка, ПометкаУдаления);
	КонецЕсли;
	
	Если НЕ Ссылка.Пустая() Тогда
		ПредыдущееСостояние = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка, "СостояниеБизнесПроцесса");
		Если ПредыдущееСостояние <> СостояниеБизнесПроцесса Тогда
			УстановитьСостояниеПодчиненныхБизнесПроцессов(СостояниеБизнесПроцесса);
		КонецЕсли;	
	КонецЕсли;
	
	Если Выполнена И Не ПринятаКИсполнению Тогда
		ПринятаКИсполнению = Истина;
		ДатаПринятияКИсполнению = ТекущаяДатаСеанса();
	КонецЕсли;	
		
	// СтандартныеПодсистемы.УправлениеДоступом
	УстановитьПривилегированныйРежим(Истина);
	ГруппаИсполнителейЗадач = БизнесПроцессыИЗадачиСервер.ГруппаИсполнителейЗадач(РольИсполнителя, 
		ОсновнойОбъектАдресации, ДополнительныйОбъектАдресации);
	УстановитьПривилегированныйРежим(Ложь);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	// Заполнение реквизита ДатаПринятияКИсполнению
	Если ПринятаКИсполнению И ДатаПринятияКИсполнению = Дата('00010101') Тогда
		ДатаПринятияКИсполнению = ТекущаяДатаСеанса();
	КонецЕсли;
	

	// ИГОРЬ 07 04 2014
	// Отправим на почту при записи сообщение
	
	Если не Отказ И Не ЗначениеЗаполнено(Ссылка) тогда
		ОтправитьПисьмо();
	КонецеСЛИ;
	
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения)
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("ЗадачаОбъект.ЗадачаИсполнителя") Тогда
		ЗаполнитьЗначенияСвойств(ЭтотОбъект, ДанныеЗаполнения, 
			"БизнесПроцесс,ТочкаМаршрута,Наименование,Исполнитель,РольИсполнителя,ОсновнойОбъектАдресации," + 
			"ДополнительныйОбъектАдресации,Важность,ДатаИсполнения,Автор,Описание,СрокИсполнения," + 
			"ДатаНачала,РезультатВыполнения,Предмет");
		Дата = ТекущаяДатаСеанса();
	КонецЕсли;
	Если НЕ ЗначениеЗаполнено(Важность) Тогда
		Важность = Перечисления.ВариантыВажностиЗадачи.Обычная;
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(СостояниеБизнесПроцесса) Тогда
		СостояниеБизнесПроцесса = Перечисления.СостоянияБизнесПроцессов.Активен;
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

Процедура УстановитьСостояниеПодчиненныхБизнесПроцессов(НовоеСостояние)
	
	НачатьТранзакцию();
	Попытка
		ПодчиненныеБизнесПроцессы = БизнесПроцессыИЗадачиСервер.БизнесПроцессыГлавнойЗадачи(Ссылка);
		Если ПодчиненныеБизнесПроцессы <> Неопределено Тогда
			Для Каждого ПодчиненныйБизнесПроцесс Из ПодчиненныеБизнесПроцессы Цикл
				БизнесПроцессОбъект = ПодчиненныйБизнесПроцесс.ПолучитьОбъект();
				БизнесПроцессОбъект.Заблокировать();
				БизнесПроцессОбъект.Состояние = НовоеСостояние;
				БизнесПроцессОбъект.Записать();
			КонецЦикла;	
		КонецЕсли;	
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		ВызватьИсключение;
	КонецПопытки;
	
КонецПроцедуры



Процедура ОтправитьПисьмо()
	Если ОбщегоНазначенияУТ.ЕстьРеквизитОбъекта(БизнесПроцесс,"Предмет") тогда
		мПредмет = БизнесПроцесс.Предмет;
	Иначе
		мПредмет = "";
	КонецЕсли;
	
	Если ОбщегоНазначенияУТ.ЕстьРеквизитОбъекта(БизнесПроцесс,"ЗаказКлиента") тогда
		мЗаказКлиента = БизнесПроцесс.ЗаказКлиента;
	Иначе
		мЗаказКлиента = "";
	КонецЕсли;
	
	
	мОписание = ?(ПустаяСтрока(Описание),БизнесПроцесс.Наименование,Описание);
	
	Текст = "";
	Текст = Текст  + "Автор задачи: "+ПараметрыСеанса.ТекущийПользователь + Символы.ПС;
	Текст = Текст  + "Важность: "+Важность+ Символы.ПС;
	Текст = Текст  + "Дата постановки задачи: "+ТекущаяДата() + Символы.ПС;
	Текст = Текст  + "Описание: "+мОписание + Символы.ПС;
	Текст = Текст  + "Предмет: "+ мПредмет + Символы.ПС;
	Текст = Текст  + "Заказ клиента: "+ мЗаказКлиента + Символы.ПС;
	Текст = Текст  + "Срок исполнения: "+СрокИсполнения;
	
	НовоеПисьмо = Документы.ЭлектронноеПисьмоИсходящее.СоздатьДокумент();
	НовоеПисьмо.Дата = ТекущаяДата();
	НовоеПисьмо.Автор = ПараметрыСеанса.ТекущийПользователь;
	НовоеПисьмо.Важность = Перечисления.ВариантыВажностиВзаимодействия.Высокая;
	НовоеПисьмо.Ответственный = ПараметрыСеанса.ТекущийПользователь;
	НовоеПисьмо.ОтправительПредставление = ПараметрыСеанса.ТекущийПользователь.Наименование;
	НовоеПисьмо.Рассмотрено = Истина;
	
	ТаблицаКИ = Исполнитель.КонтактнаяИнформация;
	НайденныеСтроки = ТаблицаКИ.НайтиСтроки(Новый Структура("Вид", 
	Справочники.ВидыКонтактнойИнформации.EmailПользователя));
	
	Если НайденныеСтроки.Количество() = 0 тогда
		//Сообщить("Не заполнен адрес электронной почты для "+Исполнитель);
		Возврат;	
	КонецЕсли;
	СтрокаEMail = НайденныеСтроки[0];
	
	
	НовоеПисьмо.СписокПолучателейПисьма = СтрокаEMail.АдресЭП;
	НовыйПолучатель = НовоеПисьмо.ПолучателиПисьма.Добавить();
	НовыйПолучатель.Адрес = СтрокаEMail.АдресЭП;
	НовыйПолучатель.Контакт = Исполнитель;
	НовыйПолучатель.Представление = Исполнитель;
	
	
	НовоеПисьмо.СтатусПисьма = Перечисления.СтатусыИсходящегоЭлектронногоПисьма.Исходящее;
	НовоеПисьмо.Текст = Текст;
	НовоеПисьмо.Тема = Наименование;
	НовоеПисьмо.ТипТекста = Перечисления.ТипыТекстовЭлектронныхПисем.ПростойТекст;
	НовоеПисьмо.УчетнаяЗапись = Справочники.УчетныеЗаписиЭлектроннойПочты.СистемнаяУчетнаяЗаписьЭлектроннойПочты;
	
	НовоеПисьмо.Записать();
	Взаимодействия.ВыполнитьОтправкуПисьма(НовоеПисьмо);
	
КонецПроцедуры

#КонецЕсли
