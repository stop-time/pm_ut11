﻿////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаКлиенте
Процедура ПередЗакрытием(Отказ, СтандартнаяОбработка)
	Отказ = Не СпособЗакрытияВыбран;
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ КОМАНД ФОРМЫ

&НаКлиенте
Процедура ЗакрытьПомощник(Команда)
	СпособЗакрытияВыбран = Истина;
	Закрыть(Истина);
КонецПроцедуры

&НаКлиенте
Процедура ВернутьсяКНастройке(Команда)
	СпособЗакрытияВыбран = Истина;
	Закрыть(Ложь);
КонецПроцедуры

