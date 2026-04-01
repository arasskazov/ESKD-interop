# Правила расширения профиля интероперабельности ЭКБ/РЭА

## Содержание

1. [Общие положения](#1-общие-положения)
2. [Принцип неизменности ядра](#2-принцип-неизменности-ядра)
3. [Допустимые расширения](#3-допустимые-расширения)
4. [Недопустимые действия](#4-недопустимые-действия)
5. [Механизмы расширения](#5-механизмы-расширения)
6. [Регистрация расширений](#6-регистрация-расширений)
7. [Примеры расширений](#7-примеры-расширений)
8. [Приложения](#8-приложения)

---

## 1. Общие положения

### 1.1. Назначение

Настоящий документ устанавливает правила расширения профиля интероперабельности для обмена перечнями разрешённых радиоэлектронной аппаратуры (РЭА) и электронной компонентной базы (ЭКБ) без изменения ядра профиля.

### 1.2. Область применения

Правила применяются при:
- Добавлении отраслевых требований к профилю ЭКБ/РЭА
- Расширении атрибутов для специфических предметных областей
- Создании профилей для конкретных отраслей (авиация, космос, ОПК)
- Интеграции с корпоративными стандартами организаций

### 1.3. Нормативные ссылки

| Обозначение | Наименование |
|-------------|--------------|
| ГОСТ Р 77.403-202X | Система поддержки жизненного цикла изделия. Профили интероперабельности |
| ГОСТ Р 2.525-2024 | Электронная структура изделия конструктивная. Формат данных |
| ГОСТ Р 2.058-2023 | Реквизитная часть электронных конструкторских документов |
| ГОСТ Р ИСО 10303-21 | Представление данных об изделии и обмен этими данными. Часть 21. Методы реализации |

### 1.4. Термины и определения

| Термин | Определение |
|--------|-------------|
| **Ядро профиля** | Набор обязательных элементов и атрибутов, определяющих минимальные требования профиля |
| **Расширение профиля** | Дополнительные элементы и атрибуты, добавляемые к ядру без его изменения |
| **Namespace расширения** | Пространство имён XML для идентификации элементов расширения |
| **Обратная совместимость** | Способность расширенного профиля обрабатываться системами, поддерживающими только ядро |

---

## 2. Принцип неизменности ядра

### 2.1. Определение ядра

Ядро профиля включает:

| Компонент | Элементы | Статус |
|-----------|----------|--------|
| **Обязательные атрибуты** | listId, listName, effectiveDate, itemId, componentRef, approvalStatus, equivalenceCategory | 🔒 Заблокировано |
| **Обязательные элементы** | allowed_component_list, allowed_component_item, compliance_assertion | 🔒 Заблокировано |
| **Типы данных** | Designator, CodeString, DateType, ApprovalStatusEnum, EquivalenceCategoryEnum | 🔒 Заблокировано |
| **Связи** | Ссылки между перечнями, компонентами, декларациями | 🔒 Заблокировано |

### 2.2. Требования к ядру

| Требование | Описание | Проверка |
|------------|----------|----------|
| **Неизменность** | Ядро не может быть изменено расширениями | XSD валидация |
| **Обязательность** | Все обязательные элементы ядра должны присутствовать | Schematron |
| **Совместимость** | Расширения не должны нарушать валидацию ядра | Тестирование |
| **Документирование** | Все изменения должны быть задокументированы | Ручная проверка |

### 2.3. Версионирование ядра

| Версия | Статус | Изменения |
|--------|--------|-----------|
| 1.0 | Активная | Базовая версия ядра |
| 1.1 | Планируется | Минорные исправления |
| 2.0 | Не запланирована | Мажорные изменения (требует нового профиля) |

**Примечание:** Изменения ядра версии 1.x требуют выпуска новой мажорной версии профиля (2.0).

---

## 3. Допустимые расширения

### 3.1. Классификация расширений

| Тип | Описание | Пример |
|-----|----------|--------|
| **Тип A: Дополнительные атрибуты** | Добавление опциональных атрибутов к существующим элементам | industryCode, securityLevel |
| **Тип B: Дополнительные элементы** | Добавление новых элементов в контент-модель | certificationInfo, testResults |
| **Тип C: Новые типы данных** | Создание новых простых и сложных типов | TemperatureRangeType, VoltageType |
| **Тип D: Отраслевые профили** | Специализация профиля для отрасли | Авиация, Космос, ОПК |

### 3.2. Требования к расширениям

| Требование | Описание | Критерий |
|------------|----------|----------|
| **Наследование** | Расширения должны наследовать типы ядра | xs:extension |
| **Namespace** | Расширения должны использовать отдельный namespace | http://gost.ru/eskd/profile/ekb/2024/extension/{industry} |
| **Опциональность** | Все элементы расширения должны быть minOccurs="0" | Не нарушает валидацию ядра |
| **Документирование** | Каждое расширение должно иметь документацию | xs:annotation |
| **Тестирование** | Расширения должны проходить тесты совместимости | Conformance tests |

---

## 4. Недопустимые действия

### 4.1. Запрещённые изменения ядра

| Действие | Статус | Обоснование |
|----------|--------|-------------|
| Изменение обязательности атрибутов ядра | ❌ Запрещено | Нарушает контракт профиля |
| Удаление элементов ядра | ❌ Запрещено | Нарушает семантику профиля |
| Изменение типов данных ядра | ❌ Запрещено | Нарушает валидацию |
| Переопределение через xs:restriction | ❌ Запрещено | Нарушает наследование |
| Изменение namespace ядра | ❌ Запрещено | Нарушает идентификацию |

### 4.2. Примеры недопустимых действий

```xml
<!-- ❌ НЕДОПУСТИМО: Изменение обязательности атрибута ядра -->
<xs:complexType name="AllowedComponentItemType">
  <xs:complexContent>
    <xs:restriction base="eskd-ekb:AllowedComponentItemType">
      <xs:sequence>
        <!-- Изменение minOccurs с 1 на 0 -->
        <xs:element name="approvalStatus" type="eskd-ekb:ApprovalStatusEnum" minOccurs="0"/>
      </xs:sequence>
    </xs:restriction>
  </xs:complexContent>
</xs:complexType>

<!-- ❌ НЕДОПУСТИМО: Удаление элемента ядра -->
<xs:complexType name="AllowedComponentListType">
  <xs:complexContent>
    <xs:restriction base="eskd-ekb:AllowedComponentListType">
      <xs:sequence>
        <!-- Удаление обязательного элемента -->
        <!-- <xs:element name="effectiveDate" ... /> -->
      </xs:sequence>
    </xs:restriction>
  </xs:complexContent>
</xs:complexType>

<!-- ❌ НЕДОПУСТИМО: Изменение типа данных ядра -->
<xs:complexType name="AllowedComponentItemType">
  <xs:complexContent>
    <xs:extension base="eskd-ekb:AllowedComponentItemType">
      <xs:sequence>
        <!-- Переопределение типа атрибута ядра -->
        <xs:attribute name="approvalStatus" type="xs:string"/>
      </xs:sequence>
    </xs:extension>
  </xs:complexContent>
</xs:complexType>
```

---

## 5. Механизмы расширения

### 5.1. Наследование через xs:extension

```xml
<!-- ✅ ДОПУСТИМО: Расширение через наследование -->
<xs:complexType name="ExtendedComponentItemType">
  <xs:annotation>
    <xs:documentation>
      Расширенный тип позиции перечня для авиационной отрасли.
      Добавляет атрибуты сертификации и квалификации.
    </xs:documentation>
  </xs:annotation>
  <xs:complexContent>
    <xs:extension base="eskd-ekb:AllowedComponentItemType">
      <xs:sequence>
        <xs:element name="certificationInfo" type="ekb-aviation:CertificationType" minOccurs="0"/>
        <xs:element name="qualificationLevel" type="ekb-aviation:QualificationEnum" minOccurs="0"/>
        <xs:element name="flightCriticality" type="ekb-aviation:CriticalityEnum" minOccurs="0"/>
      </xs:sequence>
    </xs:extension>
  </xs:complexContent>
</xs:complexType>
```

### 5.2. Дополнительные атрибуты через xs:any

```xml
<!-- ✅ ДОПУСТИМО: Расширение через xs:any -->
<xs:complexType name="ProfileExtensionType">
  <xs:annotation>
    <xs:documentation>
      Точка расширения для добавления отраслевых атрибутов.
      processContents="lax" позволяет валидировать элементы при наличии схемы.
    </xs:documentation>
  </xs:annotation>
  <xs:sequence>
    <xs:any namespace="##other" processContents="lax" 
            minOccurs="0" maxOccurs="unbounded">
      <xs:annotation>
        <xs:documentation>
          Отраслевые расширения размещаются в своём namespace.
        </xs:documentation>
      </xs:annotation>
    </xs:any>
  </xs:sequence>
</xs:complexType>
```

### 5.3. Отдельный namespace для расширений

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    ПРОСТРАНСТВА ИМЁН (NAMESPACES)                       │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  Ядро профиля:                                                          │
│  http://gost.ru/eskd/profile/ekb/2024                                   │
│                                                                         │
│  Расширения:                                                            │
│  http://gost.ru/eskd/profile/ekb/2024/extension/aviation               │
│  http://gost.ru/eskd/profile/ekb/2024/extension/space                  │
│  http://gost.ru/eskd/profile/ekb/2024/extension/defense                │
│  http://gost.ru/eskd/profile/ekb/2024/extension/automotive             │
│  http://gost.ru/eskd/profile/ekb/2024/extension/{organization}         │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### 5.4. Подстановка элементов через substitutionGroup

```xml
<!-- ✅ ДОПУСТИМО: Подстановка элементов -->
<xs:element name="extendedComponentItem" 
            type="ekb-aviation:ExtendedComponentItemType"
            substitutionGroup="eskd-ekb:allowed_component_item">
  <xs:annotation>
    <xs:documentation>
      Расширенная позиция перечня для авиационной отрасли.
      Может использоваться вместо базового allowed_component_item.
    </xs:documentation>
  </xs:annotation>
</xs:element>
```

---

## 6. Регистрация расширений

### 6.1. Процесс регистрации

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    ПРОЦЕСС РЕГИСТРАЦИИ РАСШИРЕНИЯ                       │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  1. Разработка расширения                                               │
│     • Создать XSD-файл расширения                                       │
│     • Импортировать ядро профиля                                        │
│     • Использовать уникальный namespace                                 │
│                                                                         │
│  2. Тестирование расширения                                             │
│     • Проверить валидацию XSD                                           │
│     • Проверить совместимость с ядром                                   │
│     • Подготовить примеры данных                                        │
│                                                                         │
│  3. Документирование                                                    │
│     • Описать назначение расширения                                     │
│     • Указать область применения                                        │
│     • Подготовить руководство по использованию                          │
│                                                                         │
│  4. Подача заявки                                                       │
│     • Отправить в ТК 482 "Интеграция данных"                            │
│     • Предоставить пакет документов                                     │
│     • Получить approval                                                 │
│                                                                         │
│  5. Публикация                                                          │
│     • Добавить в каталог расширений                                     │
│     • Опубликовать документацию                                         │
│     • Уведомить участников обмена                                       │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### 6.2. Пакет документов для регистрации

| Документ | Описание | Статус |
|----------|----------|--------|
| `extension_specification.md` | Спецификация расширения | Обязательно |
| `extension_schema.xsd` | XSD-схема расширения | Обязательно |
| `extension_examples.xml` | Примеры данных | Обязательно |
| `conformance_report.md` | Отчёт о тестировании | Обязательно |
| `user_guide.md` | Руководство пользователя | Рекомендуется |

### 6.3. Форма спецификации расширения

```markdown
# Спецификация расширения {extensionId}

## Общие сведения
- **Идентификатор:** {extensionId}
- **Наименование:** {extensionName}
- **Версия:** {version}
- **Namespace:** {namespace}
- **Дата:** {date}

## Область применения
{Описание отрасли/организации}

## Требуемые модули
- {moduleRef}

## Новые элементы
| Элемент | Тип | Обязательность | Описание |
|---------|-----|----------------|----------|
| {name} | {type} | {minOccurs} | {description} |

## Новые атрибуты
| Атрибут | Тип | Обязательность | Описание |
|---------|-----|----------------|----------|
| {name} | {type} | {use} | {description} |

## Совместимость
- Версия ядра: {coreVersion}
- Обратная совместимость: {yes/no}

## Контакты
- Разработчик: {organization}
- Email: {email}
```

---

## 7. Примеры расширений

### 7.1. Расширение для авиационной отрасли

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema"
           xmlns:eskd-ekb="http://gost.ru/eskd/profile/ekb/2024"
           xmlns:ekb-aviation="http://gost.ru/eskd/profile/ekb/2024/extension/aviation"
           targetNamespace="http://gost.ru/eskd/profile/ekb/2024/extension/aviation"
           elementFormDefault="qualified"
           version="1.0">

  <xs:import namespace="http://gost.ru/eskd/profile/ekb/2024"
             schemaLocation="../profile/eskd_profile_ekb.xsd"/>

  <xs:annotation>
    <xs:documentation>
      Расширение профиля ЭКБ/РЭА для авиационной отрасли.
      Основано на требованиях ГОСТ Р 59193 и отраслевых стандартах.
    </xs:documentation>
  </xs:annotation>

  <!-- Типы данных расширения -->
  <xs:simpleType name="QualificationEnum">
    <xs:restriction base="xs:string">
      <xs:enumeration value="OT"/>
      <xs:enumeration value="VP"/>
      <xs:enumeration value="SPACE"/>
      <xs:enumeration value="AVIATION"/>
    </xs:restriction>
  </xs:simpleType>

  <xs:simpleType name="CriticalityEnum">
    <xs:restriction base="xs:string">
      <xs:enumeration value="critical"/>
      <xs:enumeration value="essential"/>
      <xs:enumeration value="nonEssential"/>
    </xs:restriction>
  </xs:simpleType>

  <xs:complexType name="CertificationType">
    <xs:sequence>
      <xs:element name="certificateNumber" type="xs:string"/>
      <xs:element name="certificateDate" type="xs:date"/>
      <xs:element name="certificateAuthority" type="xs:string"/>
      <xs:element name="certificateValidity" type="xs:date"/>
    </xs:sequence>
  </xs:complexType>

  <!-- Расширенный тип позиции перечня -->
  <xs:complexType name="ExtendedComponentItemType">
    <xs:complexContent>
      <xs:extension base="eskd-ekb:AllowedComponentItemType">
        <xs:sequence>
          <xs:element name="certificationInfo" type="ekb-aviation:CertificationType" minOccurs="0"/>
          <xs:element name="qualificationLevel" type="ekb-aviation:QualificationEnum" minOccurs="0"/>
          <xs:element name="flightCriticality" type="ekb-aviation:CriticalityEnum" minOccurs="0"/>
        </xs:sequence>
      </xs:extension>
    </xs:complexContent>
  </xs:complexType>

  <!-- Элемент расширения -->
  <xs:element name="extendedComponentItem" 
              type="ekb-aviation:ExtendedComponentItemType"
              substitutionGroup="eskd-ekb:allowed_component_item"/>

</xs:schema>
```

### 7.2. Расширение для организации

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema"
           xmlns:eskd-ekb="http://gost.ru/eskd/profile/ekb/2024"
           xmlns:ekb-org="http://gost.ru/eskd/profile/ekb/2024/extension/org001"
           targetNamespace="http://gost.ru/eskd/profile/ekb/2024/extension/org001"
           elementFormDefault="qualified"
           version="1.0">

  <xs:import namespace="http://gost.ru/eskd/profile/ekb/2024"
             schemaLocation="../profile/eskd_profile_ekb.xsd"/>

  <xs:annotation>
    <xs:documentation>
      Корпоративное расширение профиля ЭКБ/РЭА для АО "Организация001".
      Добавляет атрибуты внутреннего учёта и контроля.
    </xs:documentation>
  </xs:annotation>

  <!-- Корпоративные атрибуты -->
  <xs:attributeGroup name="CorporateAttGroup">
    <xs:attribute name="internalCode" type="xs:string" use="optional"/>
    <xs:attribute name="warehouseLocation" type="xs:string" use="optional"/>
    <xs:attribute name="responsiblePerson" type="xs:string" use="optional"/>
    <xs:attribute name="lastAuditDate" type="xs:date" use="optional"/>
  </xs:attributeGroup>

  <!-- Расширение позиции перечня -->
  <xs:complexType name="CorporateComponentItemType">
    <xs:complexContent>
      <xs:extension base="eskd-ekb:AllowedComponentItemType">
        <xs:attributeGroup ref="ekb-org:CorporateAttGroup"/>
      </xs:extension>
    </xs:complexContent>
  </xs:complexType>

</xs:schema>
```

### 7.3. Пример использования расширения в XML

```xml
<?xml version="1.0" encoding="UTF-8"?>
<eskd-ekb:EkbProfileRoot 
    xmlns:eskd-ekb="http://gost.ru/eskd/profile/ekb/2024"
    xmlns:ekb-aviation="http://gost.ru/eskd/profile/ekb/2024/extension/aviation"
    profileNamespace="http://gost.ru/eskd/profile/ekb/2024">

  <eskd-pi:metadata>
    <!-- Метаданные профиля -->
  </eskd-pi:metadata>

  <eskd-ekb:allowedComponentLists>
    <eskd-ekb:allowed_component_list id="LIST-001">
      <eskd-ekb:listId>ПЛ-ЭКБ-2024-001</eskd-ekb:listId>
      <eskd-ekb:listName>Базовый перечень ЭКБ</eskd-ekb:listName>
      <eskd-ekb:effectiveDate>2024-01-01</eskd-ekb:effectiveDate>
      <eskd-ekb:allowedItems>
        
        <!-- Позиция с расширением для авиации -->
        <ekb-aviation:extendedComponentItem id="ITEM-001">
          <eskd-ekb:itemId>ПЛ-001</eskd-ekb:itemId>
          <eskd-ekb:componentRef>PROD-001</eskd-ekb:componentRef>
          <eskd-ekb:approvalStatus>approved</eskd-ekb:approvalStatus>
          <eskd-ekb:equivalenceCategory>domestic_analog</eskd-ekb:equivalenceCategory>
          
          <!-- Элементы расширения -->
          <ekb-aviation:certificationInfo>
            <ekb-aviation:certificateNumber>AV-CERT-2024-001</ekb-aviation:certificateNumber>
            <ekb-aviation:certificateDate>2024-01-15</ekb-aviation:certificateDate>
            <ekb-aviation:certificateAuthority>Авиарегистр</ekb-aviation:certificateAuthority>
            <ekb-aviation:certificateValidity>2026-01-15</ekb-aviation:certificateValidity>
          </ekb-aviation:certificationInfo>
          <ekb-aviation:qualificationLevel>AVIATION</ekb-aviation:qualificationLevel>
          <ekb-aviation:flightCriticality>critical</ekb-aviation:flightCriticality>
        </ekb-aviation:extendedComponentItem>
        
      </eskd-ekb:allowedItems>
    </eskd-ekb:allowed_component_list>
  </eskd-ekb:allowedComponentLists>

</eskd-ekb:EkbProfileRoot>
```

---

## 8. Приложения

### Приложение A. Чек-лист проверки расширения

```markdown
## Чек-лист проверки расширения

### Структура
- [ ] XSD-схема расширения валидна
- [ ] Namespace расширения уникален
- [ ] Импорт ядра профиля корректен
- [ ] Наследование через xs:extension

### Совместимость
- [ ] Все элементы расширения minOccurs="0"
- [ ] Нет изменений обязательности атрибутов ядра
- [ ] Нет удаления элементов ядра
- [ ] Нет изменения типов данных ядра

### Документация
- [ ] Спецификация расширения подготовлена
- [ ] Примеры данных предоставлены
- [ ] Руководство пользователя написано
- [ ] Отчёт о тестировании приложен

### Регистрация
- [ ] Заявка в ТК 482 подана
- [ ] Approval получен
- [ ] Расширение добавлено в каталог
- [ ] Участники обмена уведомлены
```

### Приложение B. Каталог расширений

| Идентификатор | Наименование | Namespace | Статус |
|---------------|--------------|-----------|--------|
| ekb-aviation-1.0 | Авиационная отрасль | .../extension/aviation | Активно |
| ekb-space-1.0 | Космическая отрасль | .../extension/space | Активно |
| ekb-defense-1.0 | ОПК | .../extension/defense | Активно |
| ekb-auto-1.0 | Автомобильная отрасль | .../extension/automotive | Планируется |
| ekb-org001-1.0 | АО "Организация001" | .../extension/org001 | Активно |

