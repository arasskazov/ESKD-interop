# СПРАВОЧНАЯ ТАБЛИЦА СУЩНОСТЕЙ И АТРИБУТОВ
## Профиль интероперабельности ЭКБ/РЭА (ГОСТ Р 77.403)

---

## СТРУКТУРА ДОКУМЕНТА

| Уровень | Элемент | Описание |
|---------|---------|----------|
| **Модуль** | `eskd_core`, `eskd_2.525_module`, `eskd_2.058_module`, `eskd_binding`, `eskd_profile_interface`, `eskd_profile_ekb` | Логическая группировка схем по функциональному назначению |
| **Раздел** | `Простые типы`, `Изделие`, `Структура`, `Документы`, `Организации` и др. | Тематическая группировка внутри модуля |
| **Сущность** | `eskd_product`, `doc_requisite`, `allowed_component_list` и др. | ComplexType или element, описывающий объект предметной области |
| **Атрибут** | `@id`, `@minOccurs`, `@type` и элементы последовательности | Свойства сущности с типом, обязательностью и семантикой |

---

# МОДУЛЬ 1: ESKD_CORE (БАЗОВЫЕ ТИПЫ)
## Файл: `eskd_core.xsd` | Версия: 0.2 | Namespace: `http://gost.ru/eskd/core/2024`

### Раздел 1: Простые типы (Идентификаторы)

| Сущность | Атрибут/Значение | Тип | Обяз. | Толкование |
|----------|-----------------|-----|-------|------------|
| **GUID** | паттерн `[0-9a-fA-F]{8}-...` | xs:string | — | Глобальный уникальный идентификатор формата UUID v4 для межсистемной идентификации объектов |
| **InternalID** | паттерн `#[0-9]+` | xs:string | — | Внутренний идентификатор в стиле STEP-JSON для временных ссылок внутри одного файла обмена |
| **Designator** | `[A-ZА-Я0-9\.\-\s]+`, 1-256 симв. | xs:string | — | Обозначение изделия/документа по ГОСТ 2.201 (например, `АБВГ.123456.001`) |
| **CodeString** | `[A-Z0-9\-_]+`, 1-64 симв. | xs:string | — | Кодовое значение для классификаторов, системных кодов, коротких идентификаторов |
| **VersionString** | паттерн `[0-9]+(\.[0-9]+)*[A-Z]*` | xs:string | — | Версия/ревизия в формате ГОСТ 2.525/2.058: `001`, `1.0`, `И1`, `А` |

### Раздел 2: Даты и время

| Сущность | Атрибут/Значение | Тип | Обяз. | Толкование |
|----------|-----------------|-----|-------|------------|
| **DateType** | `YYYY-MM-DD` | xs:date | — | Дата в формате ISO 8601 / ГОСТ 7.1 для календарных дат без времени |
| **DateTimeType** | `YYYY-MM-DDThh:mm:ss` | xs:dateTime | — | Дата и время в формате ISO 8601 для фиксации моментов событий |
| **YearMonthType** | `YYYY-MM` | xs:string | — | Год и месяц для периодов, не требующих указания дня |

### Раздел 3: Числовые типы

| Сущность | Атрибут/Значение | Тип | Обяз. | Толкование |
|----------|-----------------|-----|-------|------------|
| **PositiveInteger** | `≥1` | xs:integer | — | Положительное целое число для счётчиков, приоритетов, количеств |
| **NonNegativeInteger** | `≥0` | xs:integer | — | Неотрицательное целое для индексов, опциональных счётчиков |
| **RealNumber** | 18 знаков, 6 после запятой | xs:decimal | — | Вещественное число по ISO 10303-41 для точных инженерных расчётов |
| **PercentageType** | `0.00 - 100.00`, 2 знака | xs:decimal | — | Процентное значение для метрик, степени интероперабельности, заполнения |

### Раздел 4: Текстовые типы

| Сущность | Атрибут/Значение | Тип | Обяз. | Толкование |
|----------|-----------------|-----|-------|------------|
| **ShortText** | 1-256 символов | xs:string | — | Короткий текст для наименований, кодов, заголовков |
| **MediumText** | 0-1024 символа | xs:string | — | Текст средней длины для описаний, пояснений, причин изменений |
| **LongText** | 0-4096 символов | xs:string | — | Длинный текст для подробных описаний, условий, ограничений |
| **UnboundedText** | без ограничений | xs:string | — | Неограниченный текст для свободных комментариев, примечаний |

### Раздел 5: Стадии жизненного цикла

| Сущность | Значение | Толкование | ГОСТ |
|----------|----------|------------|------|
| **LifecycleStageEnum** | `S1_RESEARCH` | Исследование и обоснование разработки | ГОСТ Р 77.102 |
| | `S2_DEVELOPMENT` | Разработка (ЭП, ТП, РКД) | ГОСТ Р 77.102 |
| | `S3_PRODUCTION` | Производство, изготовление, испытания | ГОСТ Р 77.102 |
| | `S4_OPERATION` | Эксплуатация, применение по назначению | ГОСТ Р 77.102 |
| | `S5_REPAIR` | Капитальный ремонт, восстановление | ГОСТ Р 77.102 |
| | `S6_UTILIZATION` | Утилизация, снятие с эксплуатации | ГОСТ Р 77.102 |

### Раздел 6: Перечисления для профилей

| Сущность | Значение | Толкование | Область применения |
|----------|----------|------------|-------------------|
| **ApprovalStatusEnum** | `approved` | Разрешён к применению без ограничений | Перечни ЭКБ/РЭА |
| | `conditionally` | Условно разрешён (с ограничениями) | Перечни ЭКБ/РЭА |
| | `restricted` | Ограниченно допустим | Перечни ЭКБ/РЭА |
| | `deprecated` | Не рекомендуется к новому применению | Перечни ЭКБ/РЭА |
| | `prohibited` | Запрещён к применению | Перечни ЭКБ/РЭА |
| **EquivalenceCategoryEnum** | `original` | Оригинальный компонент | Перечни ЭКБ/РЭА |
| | `domestic_analog` | Отечественный аналог | Перечни ЭКБ/РЭА |
| | `foreign_analog` | Иностранный аналог | Перечни ЭКБ/РЭА |
| | `functional_substitute` | Функциональная замена | Перечни ЭКБ/РЭА |
| **ComplianceLevelEnum** | `full` | Полное соответствие (100% компонентов) | Декларации соответствия |
| | `partial` | Частичное соответствие (с исключениями) | Декларации соответствия |
| | `not_verified` | Не проверено | Декларации соответствия |

### Раздел 7: Группы атрибутов (переиспользуемые)

| Группа | Атрибут | Тип | Use | Толкование |
|--------|---------|-----|-----|------------|
| **idAttGroup** | `@id` | xs:ID | optional | Уникальный идентификатор в пределах одного XML-документа для внутренних ссылок |
| **guidAttGroup** | `@guid` | GUID | optional | Глобальный уникальный идентификатор (UUID) для межфайловой и межсистемной идентификации |
| **refAttGroup** | `@ref` | xs:IDREF | optional | Ссылка на целевой объект по его `@id` в том же документе |
| **changeAttGroup** | `@changeStatus` | enum | optional | Статус изменения: `new`, `modified`, `deleted`, `unchanged` для инкрементального обмена |
| | `@changeDate` | DateTimeType | optional | Дата и время последнего изменения объекта |
| | `@changeReason` | MediumText | optional | Причина изменения (например, "Исправление ошибки", "Обновление ТУ") |
| | `@changeAuthor` | ShortText | optional | Автор изменения (ФИО или идентификатор пользователя) |
| **securityAttGroup** | `@securityClassification` | enum | optional | Гриф безопасности: `UNCLASSIFIED`, `CONFIDENTIAL`, `SECRET`, `TOP_SECRET`, `COMPANY_SENSITIVE`, `PROPRIETARY` |
| | `@caveat` | CodeString | optional | Дополнительное ограничение в кодовой форме (например, `EXPORT_CONTROL`) |
| | `@exportControl` | xs:boolean | optional, default=false | Признак экспортного контроля: `true` = объект под контролем |

### Раздел 8: Абстрактные базовые типы (для наследования)

| Сущность | Наследует | Элементы/Атрибуты | Назначение |
|----------|-----------|-------------------|------------|
| **BaseEntityType** | — | `description?`, атрибуты `idAttGroup+guidAttGroup+changeAttGroup+securityAttGroup` | Базовый тип для всех сущностей предметной области; обеспечивает единый набор метаданных |
| **BaseReferenceType** | — | `@ref` (required), `@refType?` | Базовый тип для полиморфных ссылок между объектами; совместим с EXPRESS REFERENCES (ISO 10303) |
| **BaseDocumentType** | BaseEntityType | `title`, `description?`, атрибуты базового типа | Базовый тип для документов в ГОСТ Р 2.525 и 2.058 |
| **BaseOrganizationType** | BaseEntityType | `name`, `shortName?`, атрибуты базового типа | Базовый тип для организаций; используется в обоих модулях |
| **BasePersonType** | BaseEntityType | `lastName`, `firstName`, `patronymic?`, атрибуты базового типа | Базовый тип для физических лиц; используется в ГОСТ Р 2.058 |
| **BaseMeasureType** | — | `value`, `unit`, `@uncertainty?`, `@measurementType?` | Базовый тип для величин с единицами измерения; совместим с ISO 10303-41 measure_schema |

---

# МОДУЛЬ 2: ESKD_2.525_MODULE (СТРУКТУРА ИЗДЕЛИЯ)
## Файл: `eskd_2.525_module.xsd` | Версия: 1.0 | Namespace: `http://gost.ru/eskd/2.525/2024`

### Раздел 1: Простые типы (специфичные для 2.525)

| Сущность | Значение | Толкование | Источник |
|----------|----------|------------|----------|
| **MakeOrBuyEnum** | `.MADE.` | Изготовленное собственными силами | ГОСТ Р 2.525, табл. А.4 |
| | `.BOUGHT.` | Покупное изделие | ГОСТ Р 2.525, табл. А.4 |
| | `.COOPERATED.` | Кооперированное (изготовление по кооперации) | ГОСТ Р 2.525, табл. А.4 |
| | `.NOT_KNOWN.` | Неизвестно / не определено | ГОСТ Р 2.525, табл. А.4 |
| **ProductTypeEnum** | `.PART.` | Деталь | ГОСТ 23945.0 |
| | `.ASSEMBLY.` | Сборочная единица | ГОСТ 23945.0 |
| | `.KIT.` | Комплект | ГОСТ 23945.0 |
| | `.COMPLEX.` | Комплекс | ГОСТ 23945.0 |
| | `.MATERIAL.` | Материал | ГОСТ 23945.0 |
| | `.SOFTWARE.` | Программное изделие | ГОСТ 23945.0 |
| | `.DATA.` | Данные (база данных) | ГОСТ 23945.0 |
| | `.VIRTUAL.` | Виртуальная сборочная единица | ГОСТ 23945.0 |
| **DocumentKindEnum** | `DRAWING` | Чертеж | ГОСТ 2.102 |
| | `SPECIFICATION` | Спецификация | ГОСТ 2.102 |
| | `TECHNICAL_CONDITIONS` | Технические условия | ГОСТ 2.102 |
| | `OPERATION_MANUAL` | Руководство по эксплуатации | ГОСТ 2.102 |
| | `E_MODEL_ASSEMBLY` | Электронная модель сборочной единицы (ЭМСБ) | ГОСТ Р 2.525 |
| | `E_MODEL_PART` | Электронная модель детали (ЭМД) | ГОСТ Р 2.525 |
| **RepresentationTypeEnum** | `digital` | Электронная форма представления | ГОСТ Р 2.525, табл. А.12 |
| | `hard` | Бумажная форма представления | ГОСТ Р 2.525, табл. А.12 |
| **ContextApplicationEnum** | `OKPD2` | Классификация по ОКПД2 | ГОСТ Р 2.525 |
| | `OKPS` | Классификация по ОКПС | ГОСТ Р 2.525 |
| | `STRUCTURE_TYPE` | Вид структуры изделия | ГОСТ Р 2.525 |
| | `N/A` | Классификация не применяется | ГОСТ Р 2.525 |
| **OrganizationRoleEnum** | `DESIGNER` | Разработчик изделия | ГОСТ Р 2.525, табл. А.14 |
| | `MANUFACTURER` | Изготовитель изделия | ГОСТ Р 2.525, табл. А.14 |
| | `SUPPLIER` | Поставщик изделия | ГОСТ Р 2.525, табл. А.14 |
| | `OWNER` | Владелец подлинников КД | ГОСТ Р 2.525, табл. А.14 |
| | `MAINTAINER` | Организация технического обслуживания | ГОСТ Р 2.525, табл. А.14 |
| | `CUSTOMER` | Заказчик изделия | ГОСТ Р 2.525, табл. А.14 |

### Раздел 2: Изделие (Product)

| Сущность | Элемент/Атрибут | Тип | Обяз. | Толкование |
|----------|-----------------|-----|-------|------------|
| **eskd_product** | `@id` (наследуется) | xs:ID | optional | Уникальный идентификатор экземпляра в документе |
| | `id` | Designator | **required** | Обозначение изделия по ГОСТ 2.201 (например, `АБВГ.123456.001`) |
| | `name` | ShortText | **required** | Наименование изделия по конструкторской документации |
| | `frame_of_reference` | xs:IDREFS | optional | Ссылки на product_context для классификации изделия по ОКПД2/ОКПС |
| | `product_type` | ProductTypeEnum | **required** | Вид изделия: деталь, сборочная единица, комплект и т.д. |
| | `product_contexts/context_ref` | xs:IDREF | optional, unbounded | Ссылки на контексты применения изделия |

### Раздел 3: Версия изделия (Product Definition Formation)

| Сущность | Элемент/Атрибут | Тип | Обяз. | Толкование |
|----------|-----------------|-----|-------|------------|
| **eskd_product_definition_formation** | `id` | VersionString | **required** | Обозначение версии: номер изменения (`001`, `1.0`, `А`, `Б`) |
| | `of_product` | xs:IDREF | **required** | Ссылка на eskd_product — определяет, к какому изделию относится версия |
| | `make_or_buy` | MakeOrBuyEnum | **required** | Классификация по источнику: изготовленное, покупное, кооперированное |
| | `standard` | xs:boolean | **required** | Признак стандартной продукции: `true` = стандартное изделие |

### Раздел 4: Описание изделия в контексте (Product Definition)

| Сущность | Элемент/Атрибут | Тип | Обяз. | Толкование |
|----------|-----------------|-----|-------|------------|
| **product_definition** | `id` | CodeString | **required** | Идентификатор описания в контексте (правила — в стандарте организации) |
| | `formation` | xs:IDREF | **required** | Ссылка на eskd_product_definition_formation — к какой версии относится описание |
| | `frame_of_reference` | xs:IDREF | **required** | Ссылка на product_definition_context; для ЭСК = "конструктивная структура" |

### Раздел 5: Контексты (Product Context)

| Сущность | Элемент/Атрибут | Тип | Обяз. | Толкование |
|----------|-----------------|-----|-------|------------|
| **product_context** | `id` | CodeString | **required** | Идентификатор контекста классификации |
| | `application` | ContextApplicationEnum | **required** | Область применения: ОКПД2, ОКПС, Вид структуры |
| | `discipline_type` | CodeString | optional | Код дисциплины (например, `28.94` для ОКПД2) |
| | `name` | ShortText | **required** | Наименование контекста (пример: "Части оборудования без электрических соединений") |
| **product_definition_context** | `id` | CodeString | **required** | Идентификатор контекста описания |
| | `application` | ShortText | **required** | Область применения (пример: "Вид структуры") |
| | `life_cycle_stage` | LifecycleStageEnum | optional | Стадия ЖЦ по ГОСТ Р 77.102 |
| | `name` | ShortText | **required** | Наименование контекста (для ЭСК = "конструктивная структура") |

### Раздел 6-7: Связи между изделиями и версиями

| Сущность | Элемент/Атрибут | Тип | Обяз. | Толкование |
|----------|-----------------|-----|-------|------------|
| **product_relationship** | `id` | CodeString | **required** | Идентификатор связи |
| | `name` | ShortText | **required** | Наименование связи |
| | `relating_product` | xs:IDREF | **required** | Ссылка на исходное изделие |
| | `related_product` | xs:IDREF | **required** | Ссылка на связанное изделие |
| | `relationship_type` | CodeString | **required** | Тип связи (значения — в стандарте организации) |
| | `basis` | MediumText | optional | Условия применения связи |
| | `definition` | MediumText | optional | Описание связи |
| **product_definition_formation_relationship** | `id` | CodeString | **required** | Идентификатор связи версий |
| | `name` | ShortText | optional | Наименование связи |
| | `relating_product_definition_formation` | xs:IDREF | **required** | Ссылка на исходную версию |
| | `related_product_definition_formation` | xs:IDREF | **required** | Ссылка на связанную версию |

### Раздел 8: Структура изделия (Assembly Component Usage)

| Сущность | Элемент/Атрибут | Тип | Обяз. | Толкование |
|----------|-----------------|-----|-------|------------|
| **assembly_component_usage** | `id` | CodeString | **required** | Идентификатор вхождения |
| | `name` | ShortText | **required** | Наименование связи вхождения |
| | `relating_product_definition` | xs:IDREF | **required** | Ссылка на описание родительского изделия |
| | `related_product_definition` | xs:IDREF | **required** | Ссылка на описание составной части |
| | `reference_designator` | CodeString | optional | Обозначение позиции на чертеже/схеме (`1`, `А1`, `В2`) |
| **next_assembly_usage_occurrence** | *(наследует все поля assembly_component_usage)* | — | — | Вхождение в родительское изделие без дополнительных атрибутов |
| **quantified_assembly_component_usage** | `quantity` | xs:IDREF | **required** | Ссылка на measure_with_unit — количество с единицей измерения (`4 шт.`, `0.4 м.`) |
| **assembly_component_usage_substitute** | `id` | CodeString | **required** | Идентификатор замены |
| | `base` | xs:IDREF | **required** | Ссылка на основное вхождение СЧ |
| | `substitute` | xs:IDREF | **required** | Ссылка на вхождение заменяющей СЧ |
| | `ranking` | PositiveInteger | **required** | Приоритет использования (1 = высший) |
| | `ranking_rationale` | MediumText | **required** | Пояснение по применению данной замены |
| **make_from_usage_option** | `id` | CodeString | **required** | Идентификатор связи с материалом |
| | `name` | ShortText | **required** | Наименование связи |
| | `relating_product_definition` | xs:IDREF | **required** | Ссылка на изделие, для которого задаётся материал |
| | `related_product_definition` | xs:IDREF | **required** | Ссылка на описание материала/заготовки |
| | `ranking` | PositiveInteger | **required** | Приоритет использования материала |
| | `quantity` | xs:IDREF | optional | Ссылка на measure_with_unit — количество материала (`0.32 кг`) |

### Раздел 11: Документы (Document)

| Сущность | Элемент/Атрибут | Тип | Обяз. | Толкование |
|----------|-----------------|-----|-------|------------|
| **document** | `id` | Designator | **required** | Обозначение документа по ГОСТ 2.201 |
| | `kind` | DocumentKindEnum | **required** | Вид конструкторского документа (чертёж, спецификация, ТУ и др.) |
| **eskd_document_version** | `id` | CodeString | **required** | Идентификатор версии документа |
| | `version` | VersionString | **required** | Обозначение версии или номер изменения (`001`, `1.0`, `И1`) |
| | `items/item_ref` | xs:IDREF | optional, unbounded | Ссылки на eskd_document_item — файлы или части документа |
| **eskd_document_item** | `id` | CodeString | **required** | Обозначение составной части (имя файла, обозначение книги) |
| | `name` | ShortText | optional | Наименование составной части |
| | `representation` | RepresentationTypeEnum | **required** | Форма представления: `digital` (электронная) или `hard` (бумажная) |
| | `data_type` | CodeString | optional | Формат содержимого: `PDF`, `DWG`, `STEP`, `XML` |
| | `location` | MediumText | optional | Место хранения подлинника: `АС УДИ`, `сервер`, `архив` |
| **document_product_association** | `id` | CodeString | **required** | Идентификатор связи |
| | `related_product` | xs:IDREF | **required** | Ссылка на изделие/версию/описание изделия |
| | `relating_document` | xs:IDREF | optional | Ссылка на документ |

### Раздел 12: Организации (2.525)

| Сущность | Элемент/Атрибут | Тип | Обяз. | Толкование |
|----------|-----------------|-----|-------|------------|
| **organization** | `id` | CodeString | **required** | Код организации: ИНН, внутренний код (`АБВГ`, `7725792300`) |
| **organization_role** | `id` | CodeString | **required** | Идентификатор роли |
| | `name` | OrganizationRoleEnum | **required** | Наименование роли: Разработчик, Изготовитель, Поставщик и др. |
| **eskd_organization_product_assignment** | `id` | CodeString | **required** | Идентификатор назначения |
| | `assigned_product` | xs:IDREF | **required** | Ссылка на изделие |
| | `assigned_organization` | xs:IDREF | **required** | Ссылка на организацию |
| | `role` | xs:IDREF | **required** | Ссылка на роль организации |

### Раздел 13: Единицы измерения

| Сущность | Элемент/Атрибут | Тип | Обяз. | Толкование |
|----------|-----------------|-----|-------|------------|
| **measure_with_unit** | `id` | CodeString | **required** | Идентификатор величины |
| *(наследует BaseMeasureType)* | `value` | RealNumber | **required** | Числовое значение величины |
| | `unit` | CodeString | **required** | Код единицы измерения (ОКЕИ/ISO) |
| | `@uncertainty` | RealNumber | optional | Стандартная неопределённость измерения |
| | `@measurementType` | enum | optional | Тип измерения: `calculated`, `measured`, `nominal` и др. |
| **context_dependent_unit** | `id` | CodeString | **required** | Обозначение единицы: `шт.`, `м.`, `кг.`, `мм.` |
| | `name` | ShortText | **required** | Наименование единицы: `Штука`, `Метр`, `Килограмм` |

---

# МОДУЛЬ 3: ESKD_2.058_MODULE (РЕКВИЗИТЫ ДОКУМЕНТОВ)
## Файл: `eskd_2.058_module.xsd` | Версия: 1.0 | Namespace: `http://gost.ru/eskd/2.058/2023`

### Раздел 1: Простые типы (специфичные для 2.058)

| Сущность | Значение | Толкование | Источник |
|----------|----------|------------|----------|
| **DocHandlingTypeEnum** | `DEVELOPMENT` | Разработка документа | ГОСТ Р 2.058, табл. 1 |
| | `REVISION` | Пересмотр документа | ГОСТ Р 2.058, табл. 1 |
| | `APPROVAL` | Согласование документа | ГОСТ Р 2.058, табл. 1 |
| | `RELEASE` | Выпуск документа | ГОСТ Р 2.058, табл. 1 |
| | `CANCEL` | Аннулирование документа | ГОСТ Р 2.058, табл. 1 |
| **SignatureTypeEnum** | `ORIGINAL` | Подпись подлинника | ГОСТ Р 2.058 |
| | `COPY` | Подпись копии | ГОСТ Р 2.058 |
| | `ELECTRONIC` | Электронная подпись | ГОСТ Р 2.058 |
| | `ENHANCED_ELECTRONIC` | Усиленная электронная подпись | ГОСТ Р 2.058 |
| **StatusTypeEnum** | `DRAFT` | Черновик | ГОСТ Р 2.058, табл. 4 |
| | `IN_REVIEW` | На согласовании | ГОСТ Р 2.058, табл. 4 |
| | `APPROVED` | Утверждён | ГОСТ Р 2.058, табл. 4 |
| | `RELEASED` | Выпущен в обращение | ГОСТ Р 2.058, табл. 4 |
| **LiteraEnum** | `A` | Стадия А: Техническое предложение | ГОСТ 2.103 |
| | `B` | Стадия Б: Эскизный проект | ГОСТ 2.103 |
| | `C` | Стадия В: Технический проект | ГОСТ 2.103 |
| | `D` | Стадия Г: Рабочая документация | ГОСТ 2.103 |
| | `I` | Стадия И: Серийное производство | ГОСТ 2.103 |
| **DirectiveTypeEnum** | `ORDER` | Приказ | ГОСТ Р 2.058 |
| | `DIRECTIVE` | Распоряжение | ГОСТ Р 2.058 |
| | `DECISION` | Решение | ГОСТ Р 2.058 |
| **ApplicabilityTypeEnum** | `SERIAL` | Серийное применение | ГОСТ Р 2.058 |
| | `EXPERIMENTAL` | Опытное применение | ГОСТ Р 2.058 |
| | `REPAIR` | Ремонтное применение | ГОСТ Р 2.058 |
| **DocFormEnum** | `ELECTRONIC` | Исходный КД в электронной форме | ГОСТ Р 2.058, п. 12.3 |
| | `PAPER` | Исходный КД в бумажной форме | ГОСТ Р 2.058, п. 12.3 |
| | `BOTH` | Обе формы | ГОСТ Р 2.058, п. 12.3 |
| **ProjectionMethodEnum** | `FIRST_ANGLE` | Метод первого угла (европейский) | ГОСТ Р 2.058, п. 16.6 |
| | `THIRD_ANGLE` | Метод третьего угла (американский) | ГОСТ Р 2.058, п. 16.6 |

### Раздел 2: Реквизиты документа (doc_requisite)

| Сущность | Элемент/Атрибут | Тип | Обяз. | Толкование |
|----------|-----------------|-----|-------|------------|
| **doc_requisite** | `designator` | Designator | **required** | Обозначение документа по ГОСТ 2.201 |
| | `legal_owner` | xs:IDREF | **required** | Ссылка на организацию — владельца подлинника |
| | `creation_date` | DateType | **required** | Дата разработки документа |
| | `litera` | LiteraEnum | optional | Литера стадии разработки (А, Б, В, Г, И, О...) |
| | `applicability` | ApplicabilityTypeEnum | optional | Тип применяемости: серийное, опытное, ремонтное |
| | `restriction` | LongText | optional | Ограничения на использование и распространение |
| | `doc_form` | DocFormEnum | optional | Форма представления исходного КД: электронная/бумажная |
| | `doc_format` | CodeString | optional | Формат данных содержательной части: `PDF`, `DWG`, `STEP` |
| | `doc_creating_system` | ShortText | optional | САПР/система, в которой разработан документ (с версией) |
| | `doc_location` | MediumText | optional | Место размещения исходного КД: `АС УДИ`, `сервер` |
| | `first_doc` | xs:IDREF | optional | Ссылка на документ первичного применения (п. 13 ГОСТ Р 2.058) |

### Раздел 3: Версии и изменения (version)

| Сущность | Элемент/Атрибут | Тип | Обяз. | Толкование |
|----------|-----------------|-----|-------|------------|
| **version** | `version_id` | VersionString | **required** | Номер изменения или версия документа |
| | `doc_requisite` | xs:IDREF | **required** | Ссылка на реквизиты документа, к которому относится версия |
| | `directive_ref` | xs:IDREF | optional | Ссылка на распорядительный документ об изменении |
| | `change_date` | DateType | **required** | Дата внесения изменения |
| | `change_reason` | LongText | optional | Причина внесения изменения |
| | `change_author` | xs:IDREF | optional | Ссылка на лицо, внесшее изменение |

### Раздел 4-6: Действия, подписи, состояния

| Сущность | Элемент/Атрибут | Тип | Обяз. | Толкование |
|----------|-----------------|-----|-------|------------|
| **doc_handling** | `id` | CodeString | **required** | Идентификатор действия |
| | `handling_type` | DocHandlingTypeEnum | **required** | Тип действия: разработка, пересмотр, согласование, выпуск |
| | `handling_date` | DateTimeType | **required** | Дата и время выполнения действия |
| | `handling_person` | xs:IDREF | **required** | Ссылка на лицо, выполнившее действие |
| | `handling_organization` | xs:IDREF | optional | Ссылка на организацию, выполнившую действие |
| | `doc_requisite` | xs:IDREF | **required** | Ссылка на реквизиты документа |
| | `version` | xs:IDREF | optional | Ссылка на версию документа |
| | `handling_result` | MediumText | optional | Результат выполнения действия |
| **person_signature** | `id` | CodeString | **required** | Идентификатор подписи |
| | `person` | xs:IDREF | **required** | Ссылка на подписавшее лицо |
| | `signature_type` | SignatureTypeEnum | **required** | Тип подписи: подлинник, копия, электронная, усиленная |
| | `signature_date` | DateTimeType | **required** | Дата и время подписания |
| | `doc_requisite` | xs:IDREF | **required** | Ссылка на реквизиты документа |
| | `version` | xs:IDREF | optional | Ссылка на версию документа |
| | `role` | ShortText | **required** | Роль подписавшего: `Разработал`, `Проверил`, `Нормоконтроль` |
| | `certificate_info` | LongText | optional | Сведения о сертификате электронной подписи |
| | `certificate_validity` | DateType | optional | Срок действия сертификата |
| **status** | `id` | CodeString | **required** | Идентификатор состояния |
| | `status_type` | StatusTypeEnum | **required** | Тип состояния: черновик, на согласовании, утверждён, выпущен |
| | `status_date` | DateTimeType | **required** | Дата и время установления состояния |
| | `doc_requisite` | xs:IDREF | **required** | Ссылка на реквизиты документа |
| | `version` | xs:IDREF | optional | Ссылка на версию документа |
| | `basis` | LongText | optional | Основание для установления состояния |
| | `previous_status` | xs:IDREF | optional | Ссылка на предыдущее состояние (для истории) |

### Раздел 7-9: Применяемость, распорядительные документы, организации

| Сущность | Элемент/Атрибут | Тип | Обяз. | Толкование |
|----------|-----------------|-----|-------|------------|
| **applicability** | `id` | CodeString | **required** | Идентификатор применяемости |
| | `applicability_type` | ApplicabilityTypeEnum | **required** | Тип применяемости: серийное, опытное, ремонтное |
| | `doc_requisite` | xs:IDREF | **required** | Ссылка на реквизиты документа |
| | `product` | xs:IDREF | optional | Ссылка на изделие, для которого применяется документ |
| | `effectivity` | LongText | optional | Условия применяемости: серийные номера, даты выпуска |
| | `litera` | LiteraEnum | optional | Литера стадии для данной применяемости |
| **directive** | `id` | CodeString | **required** | Идентификатор распорядительного документа |
| | `directive_type` | DirectiveTypeEnum | **required** | Тип: приказ, распоряжение, решение, протокол |
| | `directive_number` | CodeString | **required** | Номер распорядительного документа |
| | `directive_date` | DateType | **required** | Дата распорядительного документа |
| | `issuing_organization` | xs:IDREF | **required** | Ссылка на организацию, издавшую документ |
| | `affected_docs/doc_ref` | xs:IDREF | optional, unbounded | Ссылки на документы, затрагиваемые изменением |
| | `directive_text` | LongText | optional | Текст распорядительного документа |
| **organization** (2.058) | `id` | CodeString | **required** | Код организации: ИНН, внутренний код |
| | `inn` | CodeString | optional | ИНН юридического лица |
| | `kpp` | CodeString | optional | КПП организации |
| | `ogrn` | CodeString | optional | ОГРН организации |
| | `address` | LongText | optional | Юридический адрес |
| | `contact_info/phone` | ShortText | optional | Телефон |
| | `contact_info/email` | xs:string | optional | Электронная почта |
| | `contact_info/website` | xs:anyURI | optional | Веб-сайт |
| **person** | `id` | CodeString | **required** | Идентификатор лица: табельный номер, внутренний ID |
| | `position` | ShortText | optional | Должность лица |
| | `organization` | xs:IDREF | optional | Ссылка на организацию, где работает лицо |
| | `email` | xs:string | optional | Электронная почта |
| | `phone` | ShortText | optional | Телефон |
| | `certificate_info` | LongText | optional | Сведения о сертификате электронной подписи |
| | `certificate_validity` | DateType | optional | Срок действия сертификата |
| **person_organization_assignment** | `id` | CodeString | **required** | Идентификатор назначения |
| | `person` | xs:IDREF | **required** | Ссылка на лицо |
| | `organization` | xs:IDREF | **required** | Ссылка на организацию |
| | `role` | AssignmentRoleEnum | **required** | Роль лица в организации |
| | `start_date` | DateType | optional | Дата начала назначения |
| | `end_date` | DateType | optional | Дата окончания назначения |
| | `is_primary` | xs:boolean | optional, default=true | Признак основного места работы |

### Раздел 10: Содержательная часть документа

| Сущность | Элемент/Атрибут | Тип | Обяз. | Толкование |
|----------|-----------------|-----|-------|------------|
| **doc_content** | `doc_requisite` | xs:IDREF | **required** | Ссылка на реквизиты документа |
| **file** (вложенный) | `file_name` | ShortText | **required** | Имя файла содержательной части (п. 16.1 ГОСТ Р 2.058) |
| | `file_size` | NonNegativeInteger | optional | Размер файла в байтах (п. 16.2) |
| | `file_format` | CodeString | optional | Формат данных файла: `PDF`, `DWG`, `STEP` (п. 16.3) |
| | `scale` | ShortText | optional | Масштаб изображения/чертежа (п. 16.4) |
| | `unit_of_measure` | CodeString | optional | Единица измерения размеров (п. 16.5) |
| | `projection_method` | ProjectionMethodEnum | optional | Метод проецирования: первый/третий угол (п. 16.6) |
| | `file_hash` | CodeString | optional | Хеш-сумма файла для контроля целостности |
| | `file_location` | MediumText | optional | Место размещения файла (п. 12.6) |

---

# МОДУЛЬ 4: ESKD_BINDING (СВЯЗЫВАНИЕ МОДУЛЕЙ)
## Файл: `eskd_binding.xsd` | Версия: 0.2 | Namespace: `http://gost.ru/eskd/binding/2024`

### Раздел 1: Маппинг между стандартами

| Сущность | Элемент/Атрибут | Тип | Обяз. | Толкование |
|----------|-----------------|-----|-------|------------|
| **productToDocRequisiteMapping** | `productRef` | xs:IDREF | **required** | Ссылка на eskd_product (модуль 2.525) |
| | `docRequisiteRef` | xs:IDREF | optional | Ссылка на doc_requisite (модуль 2.058); может отсутствовать для виртуальных изделий |
| **documentToDocRequisiteMapping** | `documentRef` | xs:IDREF | **required** | Ссылка на document (модуль 2.525) |
| | `docRequisiteRef` | xs:IDREF | **required** | Ссылка на doc_requisite (модуль 2.058); обязательно для всех конструкторских документов |
| **versionMapping** | `productVersionRef` | xs:IDREF | **required** | Ссылка на eskd_product_definition_formation (2.525) |
| | `docVersionRef` | xs:IDREF | optional | Ссылка на version (2.058); может отсутствовать для стандартных изделий |
| **organizationMapping** | `organization2525Ref` | xs:IDREF | optional | Ссылка на organization (2.525) |
| | `organization2058Ref` | xs:IDREF | optional | Ссылка на organization (2.058); содержит расширенную информацию (ИНН, КПП, адрес) |
| | *правило* | — | — | Хотя бы одна из ссылок должна быть заполнена (XSD assert) |

---

# МОДУЛЬ 5: ESKD_PROFILE_INTERFACE (ИНТЕРФЕЙС ПРОФИЛЯ)
## Файл: `eskd_profile_interface.xsd` | Версия: 0.2 | Namespace: `http://gost.ru/eskd/profile/interface/2024`

### Раздел 1: Метаданные профиля

| Сущность | Элемент/Атрибут | Тип | Обяз. | Толкование |
|----------|-----------------|-----|-------|------------|
| **ProfileMetadataType** | `profileId` | CodeString | **required** | Уникальный идентификатор профиля: `{domain}-{purpose}-{version}`, пример: `ekb-rerea-1.0` |
| | `profileVersion` | VersionString | **required** | Версия профиля в формате семантического версионирования: `1.0.0` |
| | `profileName` | ShortText | **required** | Человекочитаемое наименование профиля |
| | `description` | LongText | optional | Подробное описание назначения и области применения профиля |
| | `requiredModules/moduleRef` | CodeString | **required**, unbounded | Ссылки на требуемые модули ядра: `eskd_core`, `eskd_2.525_module`, `eskd_2.058_module`, `eskd_binding` |
| | `applicableLifecycleStages/stage` | LifecycleStageEnum | optional, unbounded | Стадии ЖЦ, на которых применяется профиль (ГОСТ Р 77.102) |
| | `interoperabilityDegree` | PercentageType | **required** | Степень интероперабельности: `0.00`–`1.00`; рассчитывается по методике ГОСТ Р 77.403 |
| | `externalReferences/reference` | ShortText | optional, unbounded | Внешние нормативные ссылки: `ГОСТ Р 2.525-2024`, `ISO 10303-21` |

### Раздел 2: Абстрактный корневой тип профиля

| Сущность | Элемент/Атрибут | Тип | Обяз. | Толкование |
|----------|-----------------|-----|-------|------------|
| **ProfileRootType** (abstract) | `metadata` | ProfileMetadataType | **required** | Обязательные метаданные профиля |
| | `xs:any` (namespace=##other) | — | optional, unbounded | Точка расширения: профиль добавляет свои элементы из своего namespace; `processContents="lax"` позволяет валидацию при наличии схемы |
| | `@profileNamespace` | xs:anyURI | **required** | Namespace профиля; должен совпадать с targetNamespace схемы профиля |
| | `@generatedDate` | DateTimeType | optional | Дата и время генерации файла обмена для отслеживания актуальности |
| **ProfileRoot** (element, abstract) | — | — | — | Абстрактный корневой элемент для substitutionGroup; конкретные профили наследуют через него |

### Раздел 3: Вспомогательные типы

| Сущность | Элемент/Атрибут | Тип | Обяз. | Толкование |
|----------|-----------------|-----|-------|------------|
| **ProfileReferenceType** | `profileId` | CodeString | **required** | Идентификатор профиля для ссылки |
| | `profileVersion` | VersionString | optional | Версия профиля |
| | `compatibilityLevel` | enum (`full`/`partial`) | optional | Уровень совместимости: полная или частичная |

---

# МОДУЛЬ 6: ESKD_PROFILE_EKB (ПРОФИЛЬ ЭКБ/РЭА)
## Файл: `eskd_profile_ekb.xsd` | Версия: 1.0 | Namespace: `http://gost.ru/eskd/profile/ekb/2024`

### Раздел 1: Простые типы (специфичные для ЭКБ/РЭА)

| Сущность | Значение | Толкование | Применение |
|----------|----------|------------|------------|
| **ApprovalStatusEnum** | `approved` | Разрешён к применению без ограничений | allowed_component_item |
| | `conditionally` | Условно разрешён (с ограничениями по применению) | allowed_component_item |
| | `restricted` | Ограниченно допустим (только для определённых применений) | allowed_component_item |
| | `deprecated` | Не рекомендуется к новому применению | allowed_component_item |
| | `prohibited` | Запрещён к применению | allowed_component_item |
| **EquivalenceCategoryEnum** | `original` | Оригинальный компонент (базовый) | allowed_component_item |
| | `domestic_analog` | Отечественный аналог | allowed_component_item |
| | `foreign_analog` | Иностранный аналог | allowed_component_item |
| | `functional_substitute` | Функциональная замена (не полная эквивалентность) | allowed_component_item |
| **ComplianceLevelEnum** | `full` | Полное соответствие: 100% компонентов из перечня | compliance_assertion |
| | `partial` | Частичное соответствие: есть исключения | compliance_assertion |
| | `not_verified` | Соответствие не проверялось | compliance_assertion |
| **ComponentCriticalityEnum** | `critical` | Критичный: отказ компонента приводит к отказу изделия | allowed_component_item |
| | `important` | Важный: влияет на характеристики изделия | allowed_component_item |
| | `standard` | Стандартный: общее применение | allowed_component_item |
| **QualificationLevelEnum** | `OT` | Общепромышленное исполнение | allowed_component_item |
| | `VP` | Военное исполнение | allowed_component_item |
| | `SPACE` | Космическое исполнение | allowed_component_item |
| | `AUTO` | Автомобильное исполнение | allowed_component_item |
| | `MEDICAL` | Медицинское исполнение | allowed_component_item |

### Раздел 2: Разрешённый перечень (AllowedComponentList)

| Сущность | Элемент/Атрибут | Тип | Обяз. | Толкование |
|----------|-----------------|-----|-------|------------|
| **AllowedComponentListType** | `listId` | Designator | **required** | Обозначение перечня: `ПЛ-ЭКБ-2024-001` |
| | `listName` | ShortText | **required** | Наименование перечня |
| | `approvalDocument` | DocumentReferenceType | **required** | Ссылка на нормативный документ об утверждении перечня (приказ, протокол) |
| | `issuingAuthority` | xs:IDREF | **required** | Ссылка на организацию — орган утверждения (из 2.058) |
| | `effectiveDate` | DateType | **required** | Дата вступления перечня в силу |
| | `expirationDate` | DateType | optional | Дата окончания действия перечня (если применимо) |
| | `scopeDescription` | LongText | optional | Область применения перечня (какие изделия/проекты) |
| | `applicableProducts/productRef` | xs:IDREF | optional, unbounded | Ссылки на eskd_product, для которых применяется перечень |
| | `allowedItems/allowedItem` | AllowedComponentItemType | **required**, unbounded | Позиции разрешённого перечня |

### Раздел 3: Позиция перечня (AllowedComponentItem)

| Сущность | Элемент/Атрибут | Тип | Обяз. | Толкование |
|----------|-----------------|-----|-------|------------|
| **AllowedComponentItemType** | `itemId` | CodeString | **required** | Идентификатор позиции в перечне |
| | `componentRef` | xs:IDREF | **required** | Ссылка на компонент: eskd_product (2.525) или ekb_component |
| | `approvalStatus` | ApprovalStatusEnum | **required** | Статус допуска компонента в перечень |
| | `equivalenceCategory` | EquivalenceCategoryEnum | **required** | Категория эквивалентности: оригинал, отечественный аналог и др. |
| | `manufacturer` | xs:IDREF | optional | Ссылка на организацию-производителя (из 2.058) |
| | `countryOfOrigin` | CodeString | optional | Страна происхождения (код ОК 025-2002: `RU`, `CN`, `US`) |
| | `applicationConstraints` | LongText | optional | Ограничения применения компонента |
| | `operatingConditions` | LongText | optional | Допустимые условия эксплуатации (температура, влажность и др.) |
| | `associatedReplacementGroupRef` | xs:IDREF | optional | Ссылка на группу допустимых замен |
| | `qualificationStatus` | QualificationLevelEnum | optional | Статус квалификации: общепромышленное, военное, космическое |
| | `criticality` | ComponentCriticalityEnum | optional | Критичность компонента для функционирования изделия |
| | `testReportRef` | xs:IDREF | optional | Ссылка на отчёт об испытаниях (document из 2.525) |
| | `notes` | LongText | optional | Дополнительные примечания к позиции |

### Раздел 4: Группа допустимых замен (ReplacementGroup)

| Сущность | Элемент/Атрибут | Тип | Обяз. | Толкование |
|----------|-----------------|-----|-------|------------|
| **ReplacementGroupType** | `groupId` | CodeString | **required** | Идентификатор группы замен |
| | `baseComponentRef` | xs:IDREF | **required** | Ссылка на базовый компонент (основное вхождение) |
| | `replacementReason` | LongText | optional | Причина формирования группы замен (снятие с производства, импортозамещение) |
| | `replacementItems/replacementItem` | ReplacementItemType | **required**, unbounded | Список допустимых замен |
| **ReplacementItemType** | `replacementProductRef` | xs:IDREF | **required** | Ссылка на заменяющий компонент (eskd_product) |
| | `priority` | PositiveInteger | **required** | Приоритет применения: `1` = высший приоритет |
| | `equivalenceLevel` | enum (`full`/`partial`/`functional`/`temporary`) | **required** | Уровень эквивалентности: полная, частичная, функциональная, временная замена |
| | `usageConditions` | LongText | optional | Условия применения замены |
| | `approvalDocumentRef` | xs:IDREF | optional | Ссылка на документ-основание замены |
| | `impactAnalysis` | LongText | optional | Анализ влияния замены на изделие (рекомендуется заполнять) |

### Раздел 5: Декларация соответствия (ComplianceAssertion)

| Сущность | Элемент/Атрибут | Тип | Обяз. | Толкование |
|----------|-----------------|-----|-------|------------|
| **ComplianceAssertionType** | `assertionId` | CodeString | **required** | Идентификатор декларации |
| | `productRef` | xs:IDREF | **required** | Ссылка на изделие (eskd_product из 2.525) |
| | `allowedListRef` | xs:IDREF | **required** | Ссылка на разрешённый перечень |
| | `complianceLevel` | ComplianceLevelEnum | **required** | Уровень соответствия: full, partial, not_verified |
| | `nonCompliantItems` | LongText | optional* | Перечень несоответствующих компонентов; **обязателен**, если `complianceLevel='partial'` |
| | `verificationDate` | DateType | optional | Дата проверки соответствия |
| | `verifierRef` | xs:IDREF | optional | Ссылка на организацию/лицо, выполнившее проверку |
| | `verificationMethod` | ShortText | optional | Метод проверки: `автоматическая`, `ручная`, `смешанная` |
| | `validUntil` | DateType | optional | Срок действия декларации |

### Раздел 6: Ссылки и контексты

| Сущность | Элемент/Атрибут | Тип | Обяз. | Толкование |
|----------|-----------------|-----|-------|------------|
| **DocumentReferenceType** | `documentRef` | xs:IDREF | **required** | Ссылка на документ в 2.525 или 2.058 |
| | `documentVersionRef` | xs:IDREF | optional | Ссылка на конкретную версию документа |
| | `fragmentRef` | CodeString | optional | Ссылка на фрагмент документа (раздел, пункт, страница) |

### Раздел 7: Корневой элемент профиля

| Сущность | Элемент/Атрибут | Тип | Обяз. | Толкование |
|----------|-----------------|-----|-------|------------|
| **EkbProfileRoot** | *(наследует ProfileRootType)* | — | — | Корневой элемент профиля ЭКБ/РЭА; использует substitutionGroup для наследования от абстрактного ProfileRoot |
| | `@profileNamespace` | xs:anyURI | **required** | Namespace профиля: `http://gost.ru/eskd/profile/ekb/2024` |
| | `metadata` | ProfileMetadataType | **required** | Метаданные профиля (обязательные) |
| | `allowedComponentLists` | complex | optional | Контейнер для allowed_component_list и allowed_component_item |
| | `replacementGroups` | complex | optional | Контейнер для replacement_group и replacement_item |
| | `complianceAssertions` | complex | optional | Контейнер для compliance_assertion |

---

# ПРИЛОЖЕНИЕ: СВОДНАЯ ТАБЛИЦА ОБЯЗАТЕЛЬНЫХ АТРИБУТОВ ПО УРОВНЯМ

| Уровень | Обязательные атрибуты (M) | Рекомендуемые (R) | Опциональные (O) |
|---------|---------------------------|-------------------|------------------|
| **Ядро (Core)** | `@id`, `id`, `name`, `product_type`, `effectiveDate`, `approvalStatus`, `equivalenceCategory` | `description`, `frame_of_reference`, `litera`, `applicability` | `notes`, `operatingConditions`, `criticality`, `testReportRef` |
| **Структура (2.525)** | `id`, `name`, `of_product`, `make_or_buy`, `standard`, `formation`, `frame_of_reference` | `reference_designator`, `quantity`, `ranking_rationale` | `basis`, `definition`, `location` |
| **Реквизиты (2.058)** | `designator`, `legal_owner`, `creation_date`, `version_id`, `handling_type`, `signature_type`, `status_type` | `litera`, `applicability`, `change_reason`, `certificate_info` | `restriction`, `doc_format`, `impactAnalysis` |
| **Профиль ЭКБ** | `listId`, `listName`, `itemId`, `componentRef`, `approvalStatus`, `equivalenceCategory`, `complianceLevel` | `expirationDate`, `manufacturer`, `countryOfOrigin`, `qualificationStatus`, `testReportRef` | `applicationConstraints`, `operatingConditions`, `notes`, `validUntil` |

---

> **Примечание:** 
> - **Обяз.** = атрибут должен присутствовать и быть заполнен для соответствия уровню А (базовый)
> - **Реком.** = атрибут рекомендуется заполнять для достижения уровня В (расширенный)
> - **Опц.** = атрибут заполняется по необходимости для уровня С (полный) или отраслевых расширений
> - Все ссылки (`xs:IDREF`) должны указывать на существующие объекты с соответствующим `@id` в пределах документа или связанных модулей

---

## Словарь перевода связей:

| Оригинал (англ.) | Перевод (рус.) |
|-----------------|----------------|
| "has" | "имеет версии" |
| "contains" | "содержит" |
| "owner" | "владелец" |
| "works in" | "работает в" |
| "contains items" | "содержит позиции" |
| "contains replacements" | "содержит замены" |
| "against" | "по перечню" |
| "for product" | "для изделия" |
| "linked via Binding" | "связано через Binding" |
| "references component" | "ссылается на компонент" |
| "manufacturer" | "производитель" |
| "issued by" | "утверждён организацией" |
| "approved by" | "утверждён документом" |
| "verified by" | "проверено лицом" |
| "replacement" | "заменяет продукт" |
| "has replacement group" | "имеет группу замен" |
| "mapped" | "сопоставлено" |
| "unified" | "унифицировано" |