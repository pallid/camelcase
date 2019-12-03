
#Область ПрограммныйИнтерфейс

// Соединяет массив переданных строк в одну строку в "Верблюжьей нотации".
//
// Параметры:
//   Строки - Массив - Массив, содержащий объединяемые строки.
//
//  Возвращаемое значение:
//   Строка - Строка, содержащая соединенные исходные строки.
//
Функция Соединить(Знач Строки) Экспорт
	Если Строки.Количество() = 0 Тогда
		Возврат "";
	КонецЕсли;	
	НормализованныйМассив = Новый Массив;
	Для Каждого СтрокаМассива из Строки Цикл
		Строка =  ТРег(Лев(СтрокаМассива, 1)) + Прав(СтрокаМассива, СтрДлина(СтрокаМассива)-1);
		НормализованныйМассив.Добавить(Строка);
	КонецЦикла;	
	Возврат СтрСоединить(НормализованныйМассив);
КонецФункции	

// Разделяет строку на массив подстрок в "Верблюжьей нотации".
//
// Параметры:
//   Строка - Строка - Разделяемая строка, в "Верблюжьей нотации".
//
//  Возвращаемое значение:
//   Массив - Массив со строками, которые получились в результате разделения исходной строки.
//
Функция Разделить(Знач Строка) Экспорт
	
	Если СтрДлина(Строка) = 0 Тогда
		Массив = Новый Массив;
		Массив.Добавить("");
		Возврат Массив;
	КонецЕсли;
	
	Частицы = Новый Массив;
	ПредыдущийКласс = 0;
	Класс = 0;
	МассивПустых = Новый Массив;
	
	Для Индекс = 0 По СтрДлина(Строка) Цикл
		Если Индекс >= СтрДлина(Строка) Тогда
			Прервать;
		КонецЕсли;
		Символ = Сред(Строка, Индекс+1, 1);
		Если ЭтоСимволНижнегоРегистра(Символ) Тогда
			Класс = 1;
		ИначеЕсли ЭтоСимволВерхнегоРегистра(Символ) Тогда
			Класс = 2;
		ИначеЕсли ЭтоЦифра(Символ) Тогда
			Класс = 3;
		Иначе
			Класс = 4;
		КонецЕсли;
		
		Если Класс = ПредыдущийКласс Тогда
			Частицы[Частицы.Количество()-1].Добавить(Символ);
		Иначе
			Массив = Новый Массив;
			Массив.Добавить(Символ);
			Частицы.Добавить(Массив);
		КонецЕсли;
		ПредыдущийКласс = Класс;
	КонецЦикла;
	
	Для Индекс = 0 По Частицы.Количество()-1 Цикл 
		Если Индекс >= Частицы.Количество()-1 Тогда
			Прервать;
		КонецЕсли;
		ОбработкатьПоследовательностьОтВерхнегоРегистраКНижнему(Частицы, Индекс);	
	КонецЦикла;

	Результат = СобратьМассивСтрокИзРезультатов(Частицы);	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Пример: "PDFД", "окумент" в "PDF", "Документ"
Процедура ОбработкатьПоследовательностьОтВерхнегоРегистраКНижнему(Частицы, Индекс)
	Если ЭтоСимволВерхнегоРегистра(Частицы[Индекс][0]) И ЭтоСимволНижнегоРегистра(Частицы[Индекс+1][0]) Тогда	 
		Значение = Частицы[Индекс][Частицы[Индекс].Количество()-1];
		МассивПеребора = Новый Массив;
		МассивПеребора.Добавить(Значение);
		Для Каждого Стр из Частицы[Индекс+1] Цикл
			МассивПеребора.Добавить(Стр);
		КонецЦикла;
		Частицы[Индекс+1] = МассивПеребора;	 
		Частицы[Индекс].Удалить(Частицы[Индекс].Количество()-1);		 			 
	КонецЕсли;
КонецПроцедуры

Функция СобратьМассивСтрокИзРезультатов(Частицы)
	Результат = Новый Массив;
	Для каждого Массив из Частицы Цикл	
		Если Массив.Количество() = 0 Тогда
			Продолжить;
		КонецЕсли;
		СобраннаяСтрока = СтрСоединить(Массив);
		Результат.Добавить(СобраннаяСтрока);
	КонецЦикла;
	Возврат Результат;
КонецФункции	

Функция ЭтоСимволНижнегоРегистра(Знач Символ)
	Набор = Кириллица()+Английские();
	Результат = Найти(Набор, Символ);
	Возврат ПроверкаРезультата(Результат);	
КонецФункции

Функция ЭтоСимволВерхнегоРегистра(Знач Символ)
	Набор = Врег(Кириллица()+Английские());
	Результат = Найти(Набор, Символ);
	Возврат ПроверкаРезультата(Результат);	
КонецФункции

Функция ЭтоЦифра(Знач Символ)
	Набор = "0123456789";
	Результат = Найти(Набор, Символ);
	Возврат ПроверкаРезультата(Результат);		
КонецФункции

Функция ПроверкаРезультата(Знач Результат)
	Если Результат = 0 Тогда
		Возврат Ложь;
	Иначе
		Возврат Истина;
	КонецЕсли;
КонецФункции

Функция Кириллица()
	Возврат "абвгдеёжзиклмнопрстуфхцчшщъыьэюя";
КонецФункции

Функция Английские()
	Возврат "abcdefghijklmnopqrstuvwxyz";
КонецФункции

#КонецОбласти