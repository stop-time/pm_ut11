﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	УправлениеПечатьюКлиент.ВыполнитьКомандуПечати(
		"Документ.АктОРасхожденияхПриПоступленииТоваров",
		"ТОРГ3",
		ПараметрКоманды,
		Неопределено,
		Новый Структура("ПечатьВНоменклатуреПоставщика", Истина)
	);
	
КонецПроцедуры
