﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	ПараметрыФормы = Новый Структура("Отбор, КлючНазначенияИспользования, КлючВарианта, СформироватьПриОткрытии",
			Новый Структура("Номенклатура", ПараметрКоманды),
			"ПоНоменклатуреКонтекст",
			"ПоНоменклатуреКонтекст",
			Истина);

	ОткрытьФорму("Отчет.ТоварыВЯчейках.Форма",
			ПараметрыФормы,
			ПараметрыВыполненияКоманды.Источник,
			ПараметрыВыполненияКоманды.Уникальность,
			ПараметрыВыполненияКоманды.Окно);
КонецПроцедуры
