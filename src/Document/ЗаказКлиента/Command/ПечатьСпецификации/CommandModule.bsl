﻿&НаСервере
Функция ПолучитьПрисоединенныйФайл(ИмяФайла,СсылкаНаОбъект)
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ЗаказКлиентаПрисоединенныеФайлы.Ссылка
		|ИЗ
		|	Справочник.ЗаказКлиентаПрисоединенныеФайлы КАК ЗаказКлиентаПрисоединенныеФайлы
		|ГДЕ
		|	ЗаказКлиентаПрисоединенныеФайлы.Наименование = &Наименование
		|	И ЗаказКлиентаПрисоединенныеФайлы.ВладелецФайла = &Ссылка";

	Запрос.УстановитьПараметр("Наименование", ИмяФайла);
	Запрос.УстановитьПараметр("Ссылка", СсылкаНаОбъект);

	Результат = Запрос.Выполнить();

	ВыборкаДетальныеЗаписи = Результат.Выбрать();

	Если ВыборкаДетальныеЗаписи.Следующий() Тогда
		Возврат ВыборкаДетальныеЗаписи.Ссылка;
	Иначе
		Возврат Неопределено;
	КонецЕсли;



КонецФункции

&НаСервере
Функция ДобавитьФайлСервер(СсылкаНаОбъект,ИмяФайлаБезРасширения,АдресФайлаВоВременномХранилище)
	Возврат ПрисоединенныеФайлы.ДобавитьФайл(
			СсылкаНаОбъект,
			ИмяФайлаБезРасширения,
			"docx", 
			ТекущаяДата(), 
			ТекущаяДата(), 
			АдресФайлаВоВременномХранилище, 
			Неопределено,
			Ложь,
			"");
			
	
КонецФункции


&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	СформироватьПечатнуюФормуСпецификации(ПараметрКоманды, Неопределено);
	
КонецПроцедуры


/////////////////////////////////////////////////////////////////////////////

Функция ПадежС(z1,Знач z2=2,Знач z3="*",z4=0) Экспорт
	z5=Найти(z1,"-");
	z6=?(z5=0,"","-"+ПадежС(Сред(z1,z5+1,СтрДлина(z1)-z5+1),z2,z3,z4));
	z1=НРег(?(z5=0,z1,Лев(z1,z5-1)));
	z7=Прав(z1,3);z8=Прав(z7,2);z9=Прав(z8,1);
	z5=СтрДлина(z1);
	za=Найти("ая ия ел ок яц ий па да ца ша ба та га ка",z8);
	zb=Найти("аеёийоуэюяжнгхкчшщ",Лев(z7,1));
	zc=Макс(z2,-z2);
	zd=?(za=4,5,Найти("айяь",z9));
	zd=?((zc=1)или(z9=".")или((z4=2)и(Найти("оиеу"+?(z3="ч","","бвгджзклмнпрстфхцчшщъ"),z9)>0))или((z4=1)и(Найти("мия мяэ лия кия жая лея",z7)>0)),9,?((zd=4)и(z3="ч"),2,?(z4=1,?(Найти("оеиую",z9)+Найти("их ых аа еа ёа иа оа уа ыа эа юа яа",z8)>0,9,?(z3<>"ч",?(za=1,7,?(z9="а",?(za>18,1,6),9)),?(((Найти("ой ый",z8)>0)и(z5>4)и(Прав(z1,4)<>"опой"))или((zb>10)и(za=16)),8,zd))),zd)));
	ze=Найти("лец вей бей дец пец мец нец рец вец аец иец ыец бер",z7);
	zf=?((zd=8)и(zc<>5),?((zb>15)или(Найти("жий ний",z7)>0),"е","о"),?(z1="лев","ьв",?((Найти("аеёийоуэюя",Сред(z1,z5-3 ,1))=0)и((zb>11)или(zb=0))и(ze<>45),"",?(za=7,"л",?(za=10,"к",?(za=13,"йц",?(ze=0,"",?(ze<12,"ь"+?(ze=1,"ц",""),?(ze<37,"ц",?(ze<49,"йц","р"))))))))));
	//  zf=?((zd=9)или((z4=3)и(z3="ы")),z1,Лев(z1,z5-?((zd>6)или(zf<>""),2,?(zd>0,1,0)))+zf+СокрП(Сред("а у а "+Сред("оыые",Найти("внч",z9)+1,1)+"ме "+?(Найти("гжкхш",Лев(z8,1))>0,"и","ы")+" е у ойе я ю я ем"+?(za=16,"и","е")+" и е ю ейе и и ь ьюи и и ю ейи ойойу ойойойойуюойойгомуго"+?((zf="е")или(za=16)или((zb>12)и(zb<16)),"и","ы")+"мм",10*zd+2*zc-3,2)));
	zf=?((zd=9)или((z4=3)и(Прав(z1,1)="ы")),z1,Лев(z1,z5-?((zd>6)или(zf<>""),2,?(zd>0,1,0)))+zf+СокрП(Сред("а у а "+Сред("оыые",Найти("внч",z9)+1,1)+"ме "+?(Найти("гжкхш",Лев(z8,1))>0,"и","ы")+" е у ойе я ю я ем"+?(za=16,"и","е")+" и е ю ейе и и ь ьюи и и ю ейи ойойу ойойойойуюойойгомуго"+?((zf="е")или(za=16)или((zb>12)и(zb<16)),"и","ы")+"мм",10*zd+2*zc-3,2)));
	Возврат ?(""=z1,"",?(z4>0,ВРег(Лев(zf,1))+?((z2<0)и(z4>1),".",Сред(zf,2)),zf)+z6);
КонецФункции

Функция ПадежП(Знач z1,Знач z2,z3=0) Экспорт
	
	z1=СокрЛП(z1);z4=Найти(z1+" "," ")+1;z5=Лев(z1,z4-2);z6=Прав(z5,2);
	z7=?((Найти("ая ий ый",z6)>0)и(Найти("ющий нный",Сред(z1,z4-5,4))=0)и(z3=0),"1","*");
	Возврат НРег(?((z6="ая")или(Прав(z6,1)="а"),ПадежС(z5,z2,z7,1)+" "+ПадежС(Сред(z1,z4),z2),ПадежС(z5,z2,"ч",1)+?((z6="ий")и(Найти(z1," ")=0),""," "+?(z7="1",ПадежП(Сред(z1,z4),z2,Число(z7)),Сред(z1,z4)))));
КонецФункции

Функция Падеж(Знач z1,Знач z2,z3=0) Экспорт
	
	z1 = z1+" ";
	ФИО="";
	Пока Найти(z1," ") Цикл
		z11 = Лев(z1,Найти(z1," ")-1);
		z1 = Сред(z1,Найти(z1," ")+1);
		Если ЗначениеЗаполнено(ФИО) Тогда
			ФИО = ФИО + " ";
		КонецЕсли;	
		ФИО = ФИО+ВРег(Лев(ПадежП(z11,2,),1))+Сред(ПадежП(z11,2,),2);
	КонецЦикла;	
	возврат ФИО;
КонецФункции	

Функция СократитьФИО(Знач z1)
	
	//
	РезультатФИО = "";
	
	//
	z1 = СтрЗаменить(z1, "  ", " ");
	z1 = СтрЗаменить(z1, "  ", " ");
	
	//
	z1 = СокрЛП(СтрЗаменить(z1, " ", Символы.ПС));
	
	//
	ТекстовыйДокумент = Новый ТекстовыйДокумент;
	ТекстовыйДокумент.УстановитьТекст(z1);
	
	//
	Для Сч = 1 По ТекстовыйДокумент.КоличествоСтрок() Цикл
		
		//
		ТекущаяСтрока = СокрЛП(ТекстовыйДокумент.ПолучитьСтроку(Сч));
		
		//
		Если Сч = 1 Тогда
			РезультатФИО = РезультатФИО + СокрЛП(ТекущаяСтрока) + " ";
			Продолжить;
		КонецЕсли;	
		
		//
		РезультатФИО = РезультатФИО + ВРЕГ(Лев(СокрЛП(ТекущаяСтрока), 1)) + ".";
		
	КонецЦикла;	
	
	//
	Возврат РезультатФИО;
	
КонецФункции

// 
Функция ЧислоПрописьюСокращенно(Число) 
	
	//
	Окончание = "";
	
	//
	ЧислоСтрока = Строка(Число);
	
	//
	ПоследняяПраваяЦифра = Число(Прав(ЧислоСтрока, 1));
	Если ПоследняяПраваяЦифра = 1 Тогда
		Окончание = "-го";
	ИначеЕсли ПоследняяПраваяЦифра >= 2 И ПоследняяПраваяЦифра < 5 Тогда
		Окончание = "-х";	
	Иначе
		Окончание = "-и";
	КонецЕсли;	
	
	//	
	Возврат "" + Число + Окончание;
	
КонецФункции

///////////////////////////////////////////////////////////////////////////// 

// Возвращает структуру данных со сводным описанием контрагента
//
// Параметры: 
//  СписокСведений - список значений со значениями параметров организации
//   СписокСведений формируется функцией СведенияОЮрФизЛице
//  Список         - список запрашиваемых параметров организации
//  СПрефиксом     - Признак выводить или нет префикс параметра организации
//
// Возвращаемое значение:
//  Строка - описатель организации / контрагента / физ.лица.
//
Функция ОписаниеОрганизации(СписокСведений, Список = "", СПрефиксом = Истина) Экспорт
	
	Если ПустаяСтрока(Список) Тогда
		Список = "ПолноеНаименование,ИНН,ЮридическийАдрес,Телефоны,НомерСчета,Банк,БИК,КоррСчет";
	КонецЕсли;
	
	Результат = "";
	
	СоответствиеПараметров = Новый Соответствие();
	СоответствиеПараметров.Вставить("ПолноеНаименование", " ");
	СоответствиеПараметров.Вставить("ИНН",                " ИНН ");
	СоответствиеПараметров.Вставить("КПП",                " КПП ");
	СоответствиеПараметров.Вставить("ЮридическийАдрес",   " ");
	СоответствиеПараметров.Вставить("ФактическийАдрес",   " ");
	СоответствиеПараметров.Вставить("Телефоны",           " тел.: ");
	СоответствиеПараметров.Вставить("НомерСчета",         " р/с ");
	СоответствиеПараметров.Вставить("Банк",               " в банке ");
	СоответствиеПараметров.Вставить("БИК",                " БИК ");
	СоответствиеПараметров.Вставить("КоррСчет",           " к/с ");
	СоответствиеПараметров.Вставить("КодПоОКПО",          " Код по ОКПО ");
	
	Список          = Список + ?(Прав(Список, 1) = ",", "", ",");
	ЧислоПараметров = СтрЧислоВхождений(Список, ",");
	
	Для Счетчик = 1 по ЧислоПараметров Цикл
		
		ПозЗапятой = Найти(Список, ",");
		
		Если ПозЗапятой > 0  Тогда
			
			ИмяПараметра = Лев(Список, ПозЗапятой - 1);
			Список       = Сред(Список, ПозЗапятой + 1, СтрДлина(Список));
			
			Попытка
				СтрокаДополнения = "";
				СписокСведений.Свойство(ИмяПараметра, СтрокаДополнения);
				
				Если ПустаяСтрока(СтрокаДополнения) Тогда
					Продолжить;
				КонецЕсли;
				
				Префикс = СоответствиеПараметров[ИмяПараметра];
				Если Не ПустаяСтрока(Результат)  Тогда
					Результат = Результат + Символы.ПС;
				КонецЕсли; 
				
				Результат = Результат + ?(СПрефиксом = Истина, Префикс, "") + СтрокаДополнения;
			Исключение
				
				ТекстСообщения  = НСтр("ru='Не удалось определить значение параметра организации: %ИмяПараметра%'");
				ТекстСообщения  = СтрЗаменить(ТекстСообщения,"%ИмяПараметра%",ИмяПараметра);
				Сообщение       = Новый СообщениеПользователю();
				Сообщение.Текст = ТекстСообщения;
				Сообщение.Сообщить();
				
			КонецПопытки;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат СокрЛП(Результат);
	
КонецФункции // ОписаниеОрганизации()

//
//
Функция ПолучитьЗначениеСвойства(Номенклатура, Свойство)
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	НоменклатураДополнительныеРеквизиты.Значение КАК ЗначениеСвойства
	|ИЗ
	|	Справочник.Номенклатура.ДополнительныеРеквизиты КАК НоменклатураДополнительныеРеквизиты
	|ГДЕ
	|	НоменклатураДополнительныеРеквизиты.Свойство = &Свойство
	|	И НоменклатураДополнительныеРеквизиты.Ссылка = &Номенклатура";
	
	Запрос.УстановитьПараметр("Свойство", Свойство);
	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
	Резульат = Запрос.Выполнить();
	Если Резульат.Пустой() Тогда
		Возврат "";
	Иначе
		Выборка = Резульат.Выбрать();
		Выборка.Следующий();
		Возврат Выборка.ЗначениеСвойства;
	КонецЕсли;
	
КонецФункции


&НаСервере 
Функция ПолучитьДанныеШапки(СсылкаНаОбъект)
	//
	ТекстЗапроса = "ВЫБРАТЬ
	|	Документ.Соглашение,
	|	Документ.Соглашение.Дата КАК Дата,
	|	Документ.Соглашение.Номер КАК Номер,
	|	Документ.Партнер КАК Партнер,
	|	Документ.Организация КАК Организация,
	|	Документ.Соглашение.АК_ОрганизацияБанковскийСчет КАК ОрганизацияБанковскийСчет,
	|	ЕСТЬNULL(Документ.Организация.НаименованиеПолное, """") КАК ОрганизацияНаименованиеПолное,
	|	Документ.Контрагент КАК Контрагент,
	|	Документ.Соглашение.АК_КонтрагентБанковскийСчет КАК КонтрагентБанковскийСчет,
	|	ЕСТЬNULL(Документ.Контрагент.НаименованиеПолное, """") КАК КонтрагентНаименованиеПолное,
	|	Документ.Контрагент.АК_ТекущийРуководитель КАК КонтрагентРуководитель,
	|	ЕСТЬNULL(Документ.Контрагент.АК_ТекущийРуководитель.Наименование, """") КАК КонтрагентРуководительНаименование,
	|	Документ.Контрагент.АК_ТекущийРуководитель.АК_Должность КАК КонтрагентРуководительДолжность,
	|	1 КАК НомерСпецификации,
	|	Документ.Валюта
	|ИЗ
	|	Документ.КоммерческоеПредложениеКлиенту КАК Документ
	|ГДЕ
	|	Документ.Ссылка = &Ссылка";
	
	//
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "Документ.КоммерческоеПредложениеКлиенту", СсылкаНаОбъект.Метаданные().ПолноеИмя());
	
	//			   
	Запрос = Новый Запрос;
	Запрос.Текст = ТекстЗапроса;
	Запрос.УстановитьПараметр("Ссылка", СсылкаНаОбъект);
	
	//
	Возврат Запрос.Выполнить().Выгрузить();	
КонецФункции

&НаСервере 
Функция ПолучитьДанныеТабЧасти(Ссылка)
	ТекстЗапроса = "ВЫБРАТЬ
	               |	Товары.Номенклатура,
	               |	Товары.Характеристика КАК Характеристика,
	               |	Товары.Номенклатура.Артикул КАК Артикул,
	               |	Товары.Номенклатура.Код КАК Код,
	               |	Товары.КоличествоУпаковок КАК Количество,
	               |	ВЫБОР
	               |		КОГДА Товары.СуммаРучнойСкидки <> 0
	               |			ТОГДА ВЫРАЗИТЬ(Товары.Цена - Товары.СуммаРучнойСкидки / Товары.КоличествоУпаковок КАК ЧИСЛО(15, 2))
	               |		ИНАЧЕ ВЫБОР
	               |				КОГДА Товары.СуммаАвтоматическойСкидки <> 0
	               |					ТОГДА ВЫРАЗИТЬ(Товары.Цена - Товары.СуммаАвтоматическойСкидки / Товары.КоличествоУпаковок КАК ЧИСЛО(15, 2))
	               |				ИНАЧЕ Товары.Цена
	               |			КОНЕЦ
	               |	КОНЕЦ КАК Цена,
	               |	ВЫБОР
	               |		КОГДА Товары.Ссылка.ЦенаВключаетНДС
	               |			ТОГДА Товары.Сумма
	               |		ИНАЧЕ Товары.Сумма + Товары.СуммаНДС
	               |	КОНЕЦ КАК Сумма,
	               |	Товары.СтавкаНДС,
	               |	Товары.Номенклатура.Описание КАК Описание,
	               |	Товары.СуммаНДС,
	               |	ВЫБОР
	               |		КОГДА Товары.Ссылка.НалогообложениеНДС = ЗНАЧЕНИЕ(Перечисление.ТипыНалогообложенияНДС.ПродажаНеОблагаетсяНДС)
	               |			ТОГДА ЛОЖЬ
	               |		ИНАЧЕ ИСТИНА
	               |	КОНЕЦ КАК УчитыватьНДС,
	               |	Товары.НомерСтроки,
				   |	Товары.АК_ПризнакНестандарт КАК Нестандарт,
				   |	Товары.АК_НестандартОписание КАК НестандартОписание
	               |ИЗ
	               |	Документ.ЗаказКлиента.Товары КАК Товары
	               |ГДЕ
	               |	Товары.Ссылка = &Ссылка";
	
	//
	Запрос = Новый Запрос;						   
	Запрос.Текст = ТекстЗапроса;
	
	//                                    
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	//
	Выборка = Запрос.Выполнить().Выбрать();
	СтруктураСтрок = Новый Структура;
	н = 1;
	Пока выборка.Следующий() Цикл
		ТекСтрока = Новый Структура("Номенклатура,Характеристика,Артикул,
		|Код,Количество,Цена,Сумма,СтавкаНДС,Описание,СуммаНДС,УчитыватьНДС,НомерСтроки,Нестандарт,НестандартОписание");
		ЗаполнитьЗначенияСвойств(ТекСтрока,Выборка);
		СтруктураСтрок.Вставить("Строка"+н,ТекСтрока);
		н=н+1;
	КонецЦикла;
	Возврат СтруктураСтрок;
	
КонецФункции

&НаСервере 
Функция ПолучитьДанные(Ссылка)
	СтруктураДанных = Новый Структура;	
	Шапка=ПолучитьДанныеШапки(Ссылка);
	Если Шапка.Количество() > 0 Тогда
		Выборка = Шапка[0];
		СтруктураДанных.Вставить("Соглашение",Выборка.Соглашение);
		Дата=Выборка.Дата;
		СтруктураДанных.Вставить("Дата",Дата);
		СтруктураДанных.Вставить("Номер",Выборка.Номер);
		СтруктураДанных.Вставить("Валюта",Выборка.Валюта);
		//
		СтруктураДанных.Вставить("НомерСпецификации",Выборка.НомерСпецификации);
		//
		Организация=Выборка.Организация;
		СтруктураДанных.Вставить("Организация",Организация);
		СтруктураДанных.Вставить("ОрганизацияНаименованиеПолное",Выборка.ОрганизацияНаименованиеПолное);
		ОтветсвенныеЛица = ОтветственныеЛицаСервер.ПолучитьОтветственныеЛицаОрганизации(Выборка.Организация,Ссылка.Дата);
		СтруктураДанных.Вставить("ОтветсвенныеЛица",ОтветсвенныеЛица);
		СтруктураДанных.Вставить("ОрганизацияРуководитель",ОтветсвенныеЛица.Руководитель);
		ОрганизацияРуководительНаименование = ОтветсвенныеЛица.Руководитель.Наименование;
		СтруктураДанных.Вставить("ОрганизацияРуководительНаименование",ОрганизацияРуководительНаименование);
		СтруктураДанных.Вставить("ОрганизацияРуководительДолжность","" +  ОтветсвенныеЛица.РуководительДолжность + " " + Организация.НаименованиеСокращенное);
		
		ОрганизацияРуководительСклонениеФИО = Падеж(СтруктураДанных.ОрганизацияРуководительНаименование, 2, );
		СтруктураДанных.Вставить("ОрганизацияРуководительСокращенно",СократитьФИО(ОрганизацияРуководительНаименование));
		ОрганизацияБанковскийСчет = Выборка.ОрганизацияБанковскийСчет;
		СтруктураДанных.Вставить("ОрганизацияБанковскийСчет",ОрганизацияБанковскийСчет);
		Если НЕ ЗначениеЗаполнено(ОрганизацияБанковскийСчет) Тогда
			СтруктураДанных.Вставить("ОрганизацияБанковскийСчет",ЗначениеНастроекПовтИсп.ПолучитьБанковскийСчетОрганизацииПоУмолчанию(Организация));
		КонецЕсли;		
		//
		СведенияОрганизация = ФормированиеПечатныхФорм.СведенияОЮрФизЛице(Организация, Ссылка.Дата, , ОрганизацияБанковскийСчет);
		СведенияОрганизацияСтрокаСРеквизитами =  ОписаниеОрганизации(СведенияОрганизация, "ПолноеНаименование,ЮридическийАдрес,ИНН,КПП,НомерСчета,КоррСчет,Банк,БИК,Телефоны");
		СтруктураДанных.Вставить("ОрганизацияРеквизиты",СведенияОрганизацияСтрокаСРеквизитами);
		//
		Партнер = Выборка.Партнер;
		СтруктураДанных.Вставить("Партнер",Партнер);	
		//
		Контрагент = Выборка.Контрагент;
		КонтрагентНаименованиеПолное = Выборка.КонтрагентНаименованиеПолное;
		КонтрагентРуководитель = Выборка.КонтрагентРуководитель;
		КонтрагентРуководительНаименование = Выборка.КонтрагентРуководительНаименование;
		КонтрагентРуководительДолжность = Выборка.КонтрагентРуководительДолжность;
		
		СтруктураДанных.Вставить("Контрагент",Контрагент);
		СтруктураДанных.Вставить("КонтрагентНаименованиеПолное",КонтрагентНаименованиеПолное);
		СтруктураДанных.Вставить("КонтрагентРуководитель",КонтрагентРуководитель);
		СтруктураДанных.Вставить("КонтрагентРуководительНаименование",КонтрагентРуководительНаименование);
		СтруктураДанных.Вставить("КонтрагентРуководительДолжность",КонтрагентРуководительДолжность);
		//
		КонтрагентРуководительСклонениеФИО = Падеж(КонтрагентРуководительНаименование, 2, );
		КонтрагентРуководительСокращенно = СократитьФИО(КонтрагентРуководительНаименование);
		СтруктураДанных.Вставить("КонтрагентРуководительСклонениеФИО",КонтрагентРуководительСклонениеФИО);
		СтруктураДанных.Вставить("КонтрагентРуководительСокращенно",КонтрагентРуководительСокращенно);
		//
		КонтрагентБанковскийСчет = Выборка.КонтрагентБанковскийСчет;
		Если НЕ ЗначениеЗаполнено(КонтрагентБанковскийСчет) Тогда
			КонтрагентБанковскийСчет = ЗначениеНастроекПовтИсп.ПолучитьБанковскийСчетКонтрагентаПоУмолчанию(Контрагент);
		КонецЕсли;
		СтруктураДанных.Вставить("КонтрагентБанковскийСчет",КонтрагентБанковскийСчет);
		//
		СведенияКонтрагент = ФормированиеПечатныхФорм.СведенияОЮрФизЛице(Контрагент, Ссылка.Дата, , КонтрагентБанковскийСчет);
		СведенияКонтрагентСтрокаСРеквизитами =  ОписаниеОрганизации(СведенияКонтрагент, "ПолноеНаименование,ЮридическийАдрес,ИНН,КПП,НомерСчета,КоррСчет,Банк,БИК,Телефоны");
		СтруктураДанных.Вставить("СведенияКонтрагентСтрокаСРеквизитами",СведенияКонтрагентСтрокаСРеквизитами);
		
		
	КонецЕсли;
	Возврат СтруктураДанных;
КонецФункции

&НаСервере
Функция ПолучитьМакетВорд()
	Шаблон = Документы.ЗаказКлиента.получитьМакет("Шаблон");
    АдресФайлаВХранилище = ПоместитьВоВременноеХранилище(Шаблон);
    
    Возврат АдресФайлаВХранилище; 	
КонецФункции

&НаСервере
Функция ПолучитьСуммуПрописью(Сумма,Валюта)
	Возврат РаботаСКурсамиВалют.СформироватьСуммуПрописью(Сумма, Валюта);	
КонецФункции

&НаСервере
Функция ПолучитьБанковскийСчетКонтрагентаПоУмолчанию(Контрагент)
	Возврат ЗначениеНастроекПовтИсп.ПолучитьБанковскийСчетКонтрагентаПоУмолчанию(Контрагент);	
КонецФункции

&НаСервере
Функция СведенияОЮрФизЛице (Контрагент,Дата,КонтрагентБанковскийСчет)
	Возврат ФормированиеПечатныхФорм.СведенияОЮрФизЛице(Контрагент,Дата,,КонтрагентБанковскийСчет);	
КонецФункции

&НаСервере
Функция ПолучитьГабаритыИзСтроки(СтрокаДляАнализа)       
	Возврат АК_ОбщегоНазначения.ПолучитьГабаритыИзСтроки(Строка(СтрокаДляАнализа));
КонецФункции

&НаКлиенте
Процедура СформироватьПечатнуюФормуСпецификации(МассивОбъектов, ОбъектыПечати)
	
	Для Каждого СсылкаНаОбъект Из МассивОбъектов Цикл
		//Чечин Петр. проверим сущесвование файла
		ИмяФайлаБезРасширения = "Спецификация_"+СтрЗаменить(СтрЗаменить(Строка(СсылкаНаОбъект)," ","_"),":","-");
		//присоединенныйФайл = ПолучитьПрисоединенныйФайл(ИмяФайлаБезРасширения,СсылкаНаОбъект);
		//Если ЗначениеЗаполнено(ПрисоединенныйФайл) Тогда
		//	ДанныеФайла = ПрисоединенныеФайлыКлиент.ПолучитьДанныеФайла(ПрисоединенныйФайл,,Истина);
		//	ПрисоединенныеФайлыКлиент.ОткрытьФайл(ДанныеФайла,Истина);				
		//	Продолжить;
		//КонецЕсли;
		
		//получить объект из макета. 
		АдресВХранилище = ПолучитьМакетВорд();
		ДвоичныеДанные = ПолучитьИзВременногоХранилища(АдресВХранилище);		
		//предоставим возможность пользователю выбрать каталог
		
		КаталокВФ = КаталогВременныхФайлов();
		ИмяФайла = КаталокВФ + ИмяФайлаБезРасширения +".docx";
		
		
		ДвоичныеДанные.Записать(ИмяФайла);
		
		Попытка  
			КомОбъект = Новый COMОбъект("Word.Application");    
			ДокументВорд =КомОбъект.Documents.Add(ИмяФайла);				
		Исключение   
			//если ошибка 
			КомОбъект.Application.Quit();				
			Сообщить("Произошла ошибка открытия файла Microsoft Word", СтатусСообщения.Важное);
			Возврат;
		КонецПопытки;
		
		Ссылка = СсылкаНаОбъект;
		
		//сохраняем шаблом под нужным именем - это единсвенный способ установить имя файла.
		ДокументВорд.Application.ActiveDocument.SaveAS(ИмяФайла);
		
		//
		СтруктураДанных = ПолучитьДанные(СсылкаНаОбъект);
		//
		КонтрагентБанковскийСчет = СтруктураДанных.КонтрагентБанковскийСчет;
		Если НЕ ЗначениеЗаполнено(КонтрагентБанковскийСчет) Тогда
			КонтрагентБанковскийСчет = ПолучитьБанковскийСчетКонтрагентаПоУмолчанию(СтруктураДанных.Контрагент);
		КонецЕсли;
		СведенияКонтрагент = СведенияОЮрФизЛице(СтруктураДанных.Контрагент, 
		                                        СтруктураДанных.Дата,
												КонтрагентБанковскийСчет);
		ОстаткиРеквизитов = ОписаниеОрганизации(СведенияКонтрагент, "ИНН")+Символы.ПС+
		ОписаниеОрганизации(СведенияКонтрагент, "КПП")+Символы.ПС+
		ОписаниеОрганизации(СведенияКонтрагент, "НомерСчета,КоррСчет,Банк,БИК")+Символы.ПС+
		ОписаниеОрганизации(СведенияКонтрагент, "Телефоны");																		 
	
		ЗаменитьПараметр(ДокументВорд,"НомерДоговора",СтруктураДанных.Номер);
		ЗаменитьПараметр(ДокументВорд,"ДатаДоговора",Формат(СтруктураДанных.Дата, "ДЛФ=ДД"));
		
		ЗаменитьПараметр(ДокументВорд,"НомерСпецификации",СтруктураДанных.НомерСпецификации);
		ЗаменитьПараметр(ДокументВорд,"ОрганизацияПолноеНаименование",СтруктураДанных.ОрганизацияНаименованиеПолное);
		ЗаменитьПараметр(ДокументВорд,"КонтрагентПолноеНаименование",СтруктураДанных.КонтрагентНаименованиеПолное);
		ЗаменитьПараметр(ДокументВорд,"КонтрагентРеквизиты1",ОписаниеОрганизации(СведенияКонтрагент, "ЮридическийАдрес"));
		ЗаменитьПараметр(ДокументВорд,"КонтрагентРеквизиты2",ОстаткиРеквизитов);

		//
		
		//
		НомерСтроки = 1;
		КоличествоВсего = 0;
		СуммаВсего = 0;
		СуммаНДС = 0;
		СуммаНДСВсего = 0;
		
		//
		ДокументВорд.Tables(1).Select(); // если этого не сделать, то не находит таблицу
		НомерСтроки = 6;
		ТЗ = ПолучитьДанныеТабЧасти(СсылкаНаОбъект);
		Для Каждого ТекСтрока ИЗ ТЗ Цикл
			Выборка = ТекСтрока.Значение;
			УчитыватьНДС = Выборка.УчитыватьНДС;
			НомерСтроки = НомерСтроки +1;
			Если Выборка.СуммаНДС = 0 И УчитыватьНДС Тогда
				СуммаНДС = "---";
			Иначе
				СуммаНДС = Формат(Выборка.СуммаНДС,"ЧЦ=15; ЧДЦ=2");
			КонецЕсли;
			//2014-06-24 Чечин Петр. Печатаем не стандартные размеры
			ОписаниеНестандарта = "";
			Номенклатура = Выборка.Номенклатура;
			Характеристика = Выборка.Характеристика;
			
			Если Выборка.Нестандарт Тогда
				ГабаритыНестандарт = ПолучитьГабаритыИзСтроки(Выборка.НестандартОписание);
				ОписаниеНестандарта = ?(СокрЛП(Выборка.НестандартОписание)<>"",
				"/нестандарт "+СтрЗаменить(СокрЛП(Выборка.НестандартОписание),ГабаритыНестандарт,""),
				"");
				
				//если есть в описании габариты, замених их
				Если ГабаритыНестандарт <> "" Тогда
					//1.ищем в наименовании
					ГабаритыСтандарт = ПолучитьГабаритыИзСтроки(Выборка.Номенклатура);
					Если ГабаритыСтандарт <> "" Тогда
						Номенклатура = СтрЗаменить(Выборка.Номенклатура,ГабаритыСтандарт,ГабаритыНестандарт);		
					КонецЕсли;
					//2.ищем в характеристике
					ГабаритыСтандарт = ПолучитьГабаритыИзСтроки(Выборка.Характеристика);
					Если ГабаритыСтандарт <> "" Тогда
						Характеристика = СтрЗаменить(Выборка.Характеристика,ГабаритыСтандарт,ГабаритыНестандарт);		
					КонецЕсли;
					
				КонецЕсли;
			КонецЕсли;			
			
			ДокументВорд.Tables(1).Cell(НомерСтроки, 2).Range.Text = Строка(Выборка.НомерСтроки);
			ДокументВорд.Tables(1).Cell(НомерСтроки, 3).Range.Text = Строка(Номенклатура)+ОписаниеНестандарта;
			ДокументВорд.Tables(1).Cell(НомерСтроки, 4).Range.Text = Строка(Характеристика);
			ДокументВорд.Tables(1).Cell(НомерСтроки, 5).Range.Text = Строка(Выборка.Описание);
			ДокументВорд.Tables(1).Cell(НомерСтроки, 6).Range.Text = Строка(Выборка.Артикул);
			ДокументВорд.Tables(1).Cell(НомерСтроки, 7).Range.Text = Строка(Выборка.Код);
			ДокументВорд.Tables(1).Cell(НомерСтроки, 8).Range.Text = Формат(Выборка.Количество,"ЧЦ=15; ЧДЦ=2");
			ДокументВорд.Tables(1).Cell(НомерСтроки, 9).Range.Text = Формат(Выборка.Цена,"ЧЦ=15; ЧДЦ=2");
			ДокументВорд.Tables(1).Cell(НомерСтроки, 10).Range.Text = Строка(Выборка.СтавкаНДС);
			ДокументВорд.Tables(1).Cell(НомерСтроки, 11).Range.Text = Строка(СуммаНДС);
			ДокументВорд.Tables(1).Cell(НомерСтроки, 12).Range.Text = Формат(Выборка.Сумма,"ЧЦ=15; ЧДЦ=2");
			Если Выборка.НомерСтроки < ТЗ.Количество() Тогда
				ДокументВорд.Tables(1).Cell(НомерСтроки, 12).Select(); // выбираем последнюю ячейку в последней строке (хз зачем, но видимо так надо было)					
				ДокументВорд.Application.Selection.InsertRowsBelow(1);    //<<<<<< тут добавляется строка снизу					
			КонецЕсли; 				
			//
			КоличествоВсего = КоличествоВсего + Выборка.Количество;
			СуммаВсего = СуммаВсего + Выборка.Сумма;
			СуммаНДСВсего   = СуммаНДСВсего + Выборка.СуммаНДС;
			
		КонецЦикла;	
		ЗаменитьПараметр(ДокументВорд,"СуммаНДС",Формат(СуммаНДС, "ЧДЦ=2; ЧН=0,00"));
		ЗаменитьПараметр(ДокументВорд,"КоличествоВсего",КоличествоВсего);
		ЗаменитьПараметр(ДокументВорд,"СуммаВсего",Формат(СуммаВсего,"ЧЦ=15; ЧДЦ=2"));
		
		СуммаПрописью = ПолучитьСуммуПрописью(СуммаВсего, СтруктураДанных.Валюта);
		Если СуммаНДСВсего > 0 Тогда
			СуммаПрописью = СуммаПрописью + " (в т.ч. НДС: " +  ПолучитьСуммуПрописью(СуммаНДСВсего, СтруктураДанных.Валюта) + " руб. )";
		КонецЕсли;
		
		ЗаменитьПараметр(ДокументВорд,"СуммаПрописью",СуммаПрописью);
		
		//
		ЗаменитьПараметр(ДокументВорд,"ОрганизацияРеквизиты",СтруктураДанных.ОрганизацияРеквизиты);
		ЗаменитьПараметр(ДокументВорд,"ОрганизацияРуководительДолжность",СтруктураДанных.ОрганизацияРуководительДолжность);
		ЗаменитьПараметр(ДокументВорд,"ОрганизацияРуководитель",СтруктураДанных.ОрганизацияРуководительСокращенно);
		
		ЗаменитьПараметр(ДокументВорд,"КонтрагентРеквизиты",СтруктураДанных.СведенияКонтрагентСтрокаСРеквизитами);
		ЗаменитьПараметр(ДокументВорд,"КонтрагентРуководительДолжность",СтруктураДанных.КонтрагентРуководительДолжность);
		ЗаменитьПараметр(ДокументВорд,"КонтрагентРуководитель",СтруктураДанных.КонтрагентРуководительСокращенно);
		
		
		
		//ДокументВорд.Application.Visible = Истина;
		ДокументВорд.Application.ActiveDocument.SaveAS(ИмяФайла);
		ДокументВорд.Application.ActiveDocument.Close();
		КомОбъект.Application.Quit(); 
		//2013-04-17
		//сохраняем файл в прикрепленные и открываем на редактирование.
		
		//ЗапуститьПриложение(ИмяФайла);
		Попытка
			АдресФайлаВоВременномХранилище = ПоместитьВоВременноеХранилище(Новый ДвоичныеДанные(ИмяФайла), СсылкаНаОбъект.УникальныйИдентификатор());
			Файл = ДобавитьФайлСервер(СсылкаНаОбъект,ИмяФайлаБезРасширения,АдресФайлаВоВременномХранилище);
		Исключение
			Сообщить("Не удалось записать спецификацию для документа: "+ОписаниеОшибки()+" "+СсылкаНаОбъект,СтатусСообщения.ОченьВажное);
		КонецПопытки;
		УдалитьФайлы(ИмяФайла);
		Попытка
			ДанныеФайла = ПрисоединенныеФайлыКлиент.ПолучитьДанныеФайла(Файл,,Истина);
			ПрисоединенныеФайлыКлиент.ОткрытьФайл(ДанныеФайла,истина ); //ложь);
		Исключение
			Сообщить("Не удалось открыть спецификацию для редактирования");
		КонецПопытки;
		

	КонецЦикла;
	
КонецПроцедуры // 

&НаКлиенте
Процедура ЗаменитьПараметр(Документ,Ключ,Значение)
	Замена = Документ.Content.Find;
	Замена.Execute("["+Ключ+"]", Ложь, Истина, Ложь, , , Истина, , Ложь, Лев(Строка(Значение),250));
КонецПроцедуры
