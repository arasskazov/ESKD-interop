<?xml version="1.0" encoding="UTF-8"?>
<!--
  ============================================================================
  SCHEMATRON ПРАВИЛА ДЛЯ ВАЛИДАЦИИ ПРОФИЛЕЙ ИНТЕРОПЕРАБЕЛЬНОСТИ ЕСКД
  ============================================================================
  Основано на:
  - ГОСТ Р 77.403 (Профили интероперабельности)
  - ГОСТ Р 2.525-2024 (Электронная структура изделия)
  - ГОСТ Р 2.058-2023 (Реквизитная часть КД)
  - ГОСТ Р 77.302 (Общие данные об изделии)
  - ГОСТ Р 77.402 (Программные средства поддержки ЖЦ)
  
  Профили:
  - ekb-rerea-1.0 (Разрешённые перечни ЭКБ/РЭА)
  - nsi-reference-1.0 (Нормативно-справочная информация)
  
  Уровни правил:
  - error: Критические ошибки (блокируют валидацию)
  - warning: Предупреждения (не блокируют, но требуют внимания)
  - info: Информационные сообщения
  ============================================================================
-->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
            xmlns:xs="http://www.w3.org/2001/XMLSchema"
            xmlns:xsd="http://www.w3.org/2001/XMLSchema"
            queryBinding="xslt2"
            schemaVersion="ISO">
  
  <sch:title>Правила валидации профилей интероперабельности ЕСКД</sch:title>
  <sch:ns prefix="eskd-core" uri="http://gost.ru/eskd/core/2024"/>
  <sch:ns prefix="eskd-pi" uri="http://gost.ru/eskd/profile/interface/2024"/>
  <sch:ns prefix="eskd-ekb" uri="http://gost.ru/eskd/profile/ekb/2024"/>
  <sch:ns prefix="eskd-nsi" uri="http://gost.ru/eskd/profile/nsi/2024"/>
  <sch:ns prefix="eskd-2525" uri="http://gost.ru/eskd/2.525/2024"/>
  <sch:ns prefix="eskd-2058" uri="http://gost.ru/eskd/2.058/2023"/>
  
  <!-- ========================================================================
       РАЗДЕЛ 1: ОБЩИЕ ПРАВИЛА ДЛЯ ВСЕХ ПРОФИЛЕЙ
       ======================================================================== -->
  
  <sch:pattern id="common-rules">
    <sch:title>Общие правила для всех профилей интероперабельности</sch:title>
    
    <!-- RULE-COM-001: Степень интероперабельности в допустимом диапазоне -->
    <sch:rule context="eskd-pi:metadata/eskd-pi:interoperabilityDegree">
      <sch:assert test="number(.) &gt;= 0.0 and number(.) &lt;= 1.0"
                  role="error"
                  id="RULE-COM-001">
        Степень интероперабельности должна быть в диапазоне от 0.0 до 1.0.
        Текущее значение: <sch:value-of select="."/>
      </sch:assert>
      <sch:report test="number(.) &lt; 0.8"
                  role="warning"
                  id="RULE-COM-001-W">
        Низкая степень интероперабельности (&lt; 0.8). 
        Рекомендуется увеличить покрытие требований профиля.
      </sch:report>
    </sch:rule>
    
    <!-- RULE-COM-002: Дата генерации не в будущем -->
    <sch:rule context="eskd-pi:ProfileRootType/@generatedDate">
      <sch:assert test=".&lt;= current-dateTime()"
                  role="error"
                  id="RULE-COM-002">
        Дата генерации файла не может быть в будущем.
        Указана дата: <sch:value-of select="."/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-COM-003: Версия профиля соответствует формату семантического версионирования -->
    <sch:rule context="eskd-pi:metadata/eskd-pi:profileVersion">
      <sch:assert test="matches(., '^\d+\.\d+(\.\d+)?$')"
                  role="error"
                  id="RULE-COM-003">
        Версия профиля должна соответствовать формату семантического версионирования (мажорная.минорная.патч).
        Текущее значение: <sch:value-of select="."/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-COM-004: Хотя бы один требуемый модуль указан -->
    <sch:rule context="eskd-pi:metadata/eskd-pi:requiredModules">
      <sch:assert test="count(eskd-pi:moduleRef) &gt;= 1"
                  role="error"
                  id="RULE-COM-004">
        Должен быть указан хотя бы один требуемый модуль ядра.
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-COM-005: Стадии ЖЦ из допустимого перечня (ГОСТ Р 77.102) -->
    <sch:rule context="eskd-pi:metadata/eskd-pi:applicableLifecycleStages/eskd-pi:stage">
      <sch:let name="validStages" value="'S1_RESEARCH S2_DEVELOPMENT S3_PRODUCTION S4_OPERATION S5_REPAIR S6_UTILIZATION'"/>
      <sch:assert test="contains($validStages, .)"
                  role="error"
                  id="RULE-COM-005">
        Стадия жизненного цикла должна быть из допустимого перечня ГОСТ Р 77.102.
        Допустимые значения: S1_RESEARCH, S2_DEVELOPMENT, S3_PRODUCTION, S4_OPERATION, S5_REPAIR, S6_UTILIZATION.
        Текущее значение: <sch:value-of select="."/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-COM-006: Процессы ЖЦ из допустимого перечня (ГОСТ Р 77.102) -->
    <sch:rule context="eskd-pi:metadata/eskd-pi:applicableProcesses/eskd-pi:process">
      <sch:let name="validProcesses" value="'P1_MANAGEMENT P1.1_STRATEGIC P1.2_PROJECT P1.3_CONFIG P1.4_RISK P1.5_QUALITY P2_TECHNICAL P2.1_REQUIREMENTS P2.2_DESIGN P2.3_INTEGRATION P2.4_MAINTENANCE P3_SUPPORT P3.1_INFO P3.2_COMMUNICATION'"/>
      <sch:assert test="contains($validProcesses, .)"
                  role="error"
                  id="RULE-COM-006">
        Процесс жизненного цикла должен быть из допустимого перечня ГОСТ Р 77.102.
        Текущее значение: <sch:value-of select="."/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-COM-007: Программные средства из ГОСТ Р 77.402 -->
    <sch:rule context="eskd-pi:metadata/eskd-pi:softwareTools/eskd-pi:toolRef">
      <sch:let name="validTools" value="'СУПР СУБП СУТР СУДИ-КТ СУДИ-ПЭ СНСИ СЭДО САПР САПР-К САПР-Т САПР-Э САПР-ТП САПР-УП САПР-ЭРД СМФА СИА СТГД СМК СУОК СУЭФ СУИТ СУОФ СПК СУРП'"/>
      <sch:assert test="contains($validTools, .)"
                  role="warning"
                  id="RULE-COM-007">
        Программное средство должно быть из перечня ГОСТ Р 77.402.
        Текущее значение: <sch:value-of select="."/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-COM-008: Namespace профиля соответствует идентификатору -->
    <sch:rule context="eskd-pi:ProfileRootType">
      <sch:let name="profileId" value="eskd-pi:metadata/eskd-pi:profileId"/>
      <sch:let name="namespace" value="@profileNamespace"/>
      <sch:assert test="contains($namespace, $profileId)"
                  role="warning"
                  id="RULE-COM-008">
        Namespace профиля должен содержать идентификатор профиля.
        ProfileId: <sch:value-of select="$profileId"/>, Namespace: <sch:value-of select="$namespace"/>
      </sch:assert>
    </sch:rule>
    
  </sch:pattern>
  
  <!-- ========================================================================
       РАЗДЕЛ 2: ПРАВИЛА ДЛЯ ПРОФИЛЯ ЭКБ/РЭА (ekb-rerea-1.0)
       ======================================================================== -->
  
  <sch:pattern id="ekb-rules">
    <sch:title>Правила валидации профиля ЭКБ/РЭА</sch:title>
    
    <!-- RULE-EKB-001: Дата окончания действия перечня >= даты вступления в силу -->
    <sch:rule context="eskd-ekb:allowed_component_list">
      <sch:assert test="not(eskd-ekb:expirationDate) or 
                        xs:date(eskd-ekb:expirationDate) &gt;= xs:date(eskd-ekb:effectiveDate)"
                  role="error"
                  id="RULE-EKB-001">
        Дата окончания действия перечня не может быть раньше даты вступления в силу.
        effectiveDate: <sch:value-of select="eskd-ekb:effectiveDate"/>, 
        expirationDate: <sch:value-of select="eskd-ekb:expirationDate"/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-EKB-002: Каждый перечень должен содержать хотя бы одну позицию -->
    <sch:rule context="eskd-ekb:allowed_component_list">
      <sch:assert test="count(eskd-ekb:allowedItems/eskd-ekb:allowedItem) &gt;= 1"
                  role="error"
                  id="RULE-EKB-002">
        Разрешённый перечень должен содержать хотя бы одну позицию.
        Перечень: <sch:value-of select="eskd-ekb:listId"/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-EKB-003: Для критичных компонентов рекомендуется указать testReportRef -->
    <sch:rule context="eskd-ekb:allowed_component_item[eskd-ekb:criticality='critical']">
      <sch:assert test="exists(eskd-ekb:testReportRef)"
                  role="warning"
                  id="RULE-EKB-003">
        Для критичных компонентов рекомендуется указывать ссылку на отчёт об испытаниях (testReportRef).
        Компонент: <sch:value-of select="eskd-ekb:componentRef"/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-EKB-004: Приоритет замены должен быть положительным числом -->
    <sch:rule context="eskd-ekb:replacement_item">
      <sch:assert test="number(eskd-ekb:priority) &gt;= 1"
                  role="error"
                  id="RULE-EKB-004">
        Приоритет замены должен быть положительным числом (1 = высший приоритет).
        Текущее значение: <sch:value-of select="eskd-ekb:priority"/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-EKB-005: Группа замен должна содержать хотя бы одну замену -->
    <sch:rule context="eskd-ekb:replacement_group">
      <sch:assert test="count(eskd-ekb:replacementItems/eskd-ekb:replacementItem) &gt;= 1"
                  role="error"
                  id="RULE-EKB-005">
        Группа допустимых замен должна содержать хотя бы одну замену.
        Группа: <sch:value-of select="eskd-ekb:groupId"/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-EKB-006: При partial compliance должен быть указан nonCompliantItems -->
    <sch:rule context="eskd-ekb:compliance_assertion[eskd-ekb:complianceLevel='partial']">
      <sch:assert test="exists(eskd-ekb:nonCompliantItems) and 
                        string-length(normalize-space(eskd-ekb:nonCompliantItems)) &gt; 0"
                  role="error"
                  id="RULE-EKB-006">
        При уровне соответствия 'partial' должен быть заполнен перечень несоответствующих компонентов.
        Декларация: <sch:value-of select="eskd-ekb:assertionId"/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-EKB-007: Срок действия декларации не должен быть в прошлом -->
    <sch:rule context="eskd-ekb:compliance_assertion[eskd-ekb:validUntil]">
      <sch:assert test="xs:date(eskd-ekb:validUntil) &gt;= current-date()"
                  role="warning"
                  id="RULE-EKB-007">
        Срок действия декларации истёк или истекает.
        validUntil: <sch:value-of select="eskd-ekb:validUntil"/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-EKB-008: Условно разрешённые компоненты должны иметь ограничения -->
    <sch:rule context="eskd-ekb:allowed_component_item[eskd-ekb:approvalStatus='conditionally']">
      <sch:assert test="exists(eskd-ekb:applicationConstraints) and 
                        string-length(normalize-space(eskd-ekb:applicationConstraints)) &gt; 0"
                  role="error"
                  id="RULE-EKB-008">
        Условно разрешённые компоненты должны иметь указания по ограничениям применения.
        Компонент: <sch:value-of select="eskd-ekb:componentRef"/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-EKB-009: Запрещённые компоненты не должны быть в активных перечнях -->
    <sch:rule context="eskd-ekb:allowed_component_item[eskd-ekb:approvalStatus='prohibited']">
      <sch:assert test="not(../../eskd-ekb:allowed_component_list[not(eskd-ekb:expirationDate) or xs:date(eskd-ekb:expirationDate) &gt;= current-date()])"
                  role="error"
                  id="RULE-EKB-009">
        Запрещённые компоненты не должны присутствовать в активных перечнях.
        Компонент: <sch:value-of select="eskd-ekb:componentRef"/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-EKB-010: Отечественные аналоги должны иметь countryOfOrigin = RU -->
    <sch:rule context="eskd-ekb:allowed_component_item[eskd-ekb:equivalenceCategory='domestic_analog']">
      <sch:assert test="eskd-ekb:countryOfOrigin = 'RU'"
                  role="warning"
                  id="RULE-EKB-010">
        Для отечественных аналогов рекомендуется указывать countryOfOrigin = 'RU'.
        Компонент: <sch:value-of select="eskd-ekb:componentRef"/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-EKB-011: Декларация соответствия должна ссылаться на существующий перечень -->
    <sch:rule context="eskd-ekb:compliance_assertion">
      <sch:let name="listRef" value="eskd-ekb:allowedListRef"/>
      <sch:assert test="exists(//eskd-ekb:allowed_component_list[@id = $listRef])"
                  role="error"
                  id="RULE-EKB-011">
        Декларация соответствия должна ссылаться на существующий разрешённый перечень.
        allowedListRef: <sch:value-of select="$listRef"/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-EKB-012: Дата проверки соответствия не в будущем -->
    <sch:rule context="eskd-ekb:compliance_assertion[eskd-ekb:verificationDate]">
      <sch:assert test="xs:date(eskd-ekb:verificationDate) &lt;= current-date()"
                  role="error"
                  id="RULE-EKB-012">
        Дата проверки соответствия не может быть в будущем.
        verificationDate: <sch:value-of select="eskd-ekb:verificationDate"/>
      </sch:assert>
    </sch:rule>
    
  </sch:pattern>
  
  <!-- ========================================================================
       РАЗДЕЛ 3: ПРАВИЛА ДЛЯ ПРОФИЛЯ НСИ (nsi-reference-1.0)
       ======================================================================== -->
  
  <sch:pattern id="nsi-rules">
    <sch:title>Правила валидации профиля НСИ</sch:title>
    
    <!-- RULE-NSI-001: Каждый классификатор должен содержать хотя бы одну запись -->
    <sch:rule context="eskd-nsi:classifier">
      <sch:assert test="count(eskd-nsi:entries/eskd-nsi:entry) &gt;= 1"
                  role="error"
                  id="RULE-NSI-001">
        Классификатор должен содержать хотя бы одну запись.
        Классификатор: <sch:value-of select="eskd-nsi:classifierCode"/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-NSI-002: Каждый справочник должен содержать хотя бы одну запись -->
    <sch:rule context="eskd-nsi:referenceBook">
      <sch:assert test="count(eskd-nsi:records/eskd-nsi:record) &gt;= 1"
                  role="error"
                  id="RULE-NSI-002">
        Справочник должен содержать хотя бы одну запись.
        Справочник: <sch:value-of select="eskd-nsi:referenceName"/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-NSI-003: Дата окончания действия классификатора >= даты вступления в силу -->
    <sch:rule context="eskd-nsi:classifier">
      <sch:assert test="not(eskd-nsi:expirationDate) or 
                        xs:date(eskd-nsi:expirationDate) &gt;= xs:date(eskd-nsi:effectiveDate)"
                  role="error"
                  id="RULE-NSI-003">
        Дата окончания действия классификатора не может быть раньше даты вступления в силу.
        effectiveDate: <sch:value-of select="eskd-nsi:effectiveDate"/>, 
        expirationDate: <sch:value-of select="eskd-nsi:expirationDate"/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-NSI-004: Родительская запись должна существовать в том же классификаторе -->
    <sch:rule context="eskd-nsi:entry[eskd-nsi:parentCode]">
      <sch:let name="parentCode" value="eskd-nsi:parentCode"/>
      <sch:assert test="exists(../eskd-nsi:entry[@id = $parentCode]) or 
                        exists(../eskd-nsi:entry[eskd-nsi:code = $parentCode])"
                  role="error"
                  id="RULE-NSI-004">
        Родительская запись должна существовать в том же классификаторе.
        parentCode: <sch:value-of select="$parentCode"/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-NSI-005: Уровень иерархии должен быть положительным числом -->
    <sch:rule context="eskd-nsi:entry[eskd-nsi:hierarchyLevel]">
      <sch:assert test="number(eskd-nsi:hierarchyLevel) &gt;= 1 and 
                        number(eskd-nsi:hierarchyLevel) &lt;= 10"
                  role="error"
                  id="RULE-NSI-005">
        Уровень иерархии должен быть числом от 1 до 10.
        Текущее значение: <sch:value-of select="eskd-nsi:hierarchyLevel"/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-NSI-006: Каждая запись справочника должна иметь хотя бы один атрибут -->
    <sch:rule context="eskd-nsi:record">
      <sch:assert test="count(eskd-nsi:attributes/eskd-nsi:attribute) &gt;= 1"
                  role="error"
                  id="RULE-NSI-006">
        Каждая запись справочника должна иметь хотя бы один атрибут.
        Запись: <sch:value-of select="eskd-nsi:recordId"/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-NSI-007: Код классификатора из допустимого перечня -->
    <sch:rule context="eskd-nsi:classifier/eskd-nsi:classifierCode">
      <sch:let name="validCodes" value="'OKPD2 OKP OKV OKEI OKFS OKOGU INTERNAL'"/>
      <sch:assert test="contains($validCodes, .)"
                  role="warning"
                  id="RULE-NSI-007">
        Код классификатора должен быть из допустимого перечня.
        Допустимые значения: OKPD2, OKP, OKV, OKEI, OKFS, OKOGU, INTERNAL.
        Текущее значение: <sch:value-of select="."/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-NSI-008: Тип справочника из допустимого перечня -->
    <sch:rule context="eskd-nsi:referenceBook/eskd-nsi:referenceType">
      <sch:let name="validTypes" value="'materials units organizations persons documents products equipment tools'"/>
      <sch:assert test="contains($validTypes, .)"
                  role="warning"
                  id="RULE-NSI-008">
        Тип справочника должен быть из допустимого перечня.
        Текущее значение: <sch:value-of select="."/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-NSI-009: Статус записи из допустимого перечня -->
    <sch:rule context="eskd-nsi:entry/eskd-nsi:status | eskd-nsi:record/eskd-nsi:status">
      <sch:let name="validStatuses" value="'active archived draft pending'"/>
      <sch:assert test="contains($validStatuses, .)"
                  role="error"
                  id="RULE-NSI-009">
        Статус записи должен быть из допустимого перечня.
        Допустимые значения: active, archived, draft, pending.
        Текущее значение: <sch:value-of select="."/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-NSI-010: Владелец справочника должен ссылаться на существующую организацию -->
    <sch:rule context="eskd-nsi:referenceBook[eskd-nsi:owner]">
      <sch:let name="ownerRef" value="eskd-nsi:owner"/>
      <sch:assert test="exists(//eskd-2058:organization[@id = $ownerRef]) or 
                        exists(//eskd-nsi:record[@id = $ownerRef])"
                  role="error"
                  id="RULE-NSI-010">
        Владелец справочника должен ссылаться на существующую организацию.
        owner: <sch:value-of select="$ownerRef"/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-NSI-011: Связанные записи должны существовать -->
    <sch:rule context="eskd-nsi:record/eskd-nsi:relatedRecords/eskd-nsi:relatedRecord">
      <sch:let name="recordRef" value="eskd-nsi:recordRef"/>
      <sch:assert test="exists(//eskd-nsi:record[@id = $recordRef])"
                  role="error"
                  id="RULE-NSI-011">
        Связанная запись должна существовать.
        recordRef: <sch:value-of select="$recordRef"/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-NSI-012: Маппинг НСИ должен иметь хотя бы одно правило -->
    <sch:rule context="eskd-nsi:nsi_mapping">
      <sch:assert test="count(eskd-nsi:mappings/eskd-nsi:mapping) &gt;= 1"
                  role="error"
                  id="RULE-NSI-012">
        Маппинг НСИ должен содержать хотя бы одно правило маппинга.
        Маппинг: <sch:value-of select="@id"/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-NSI-013: Тип маппинга из допустимого перечня -->
    <sch:rule context="eskd-nsi:nsi_mapping/eskd-nsi:mappings/eskd-nsi:mapping/eskd-nsi:mappingType">
      <sch:let name="validTypes" value="'direct derived manual'"/>
      <sch:assert test="contains($validTypes, .)"
                  role="error"
                  id="RULE-NSI-013">
        Тип маппинга должен быть из допустимого перечня.
        Допустимые значения: direct, derived, manual.
        Текущее значение: <sch:value-of select="."/>
      </sch:assert>
    </sch:rule>
    
  </sch:pattern>
  
  <!-- ========================================================================
       РАЗДЕЛ 4: ПРАВИЛА ИНТЕГРАЦИИ С ГОСТ 2.525 И 2.058
       ======================================================================== -->
  
  <sch:pattern id="integration-rules">
    <sch:title>Правила интеграции с ГОСТ 2.525 и ГОСТ 2.058</sch:title>
    
    <!-- RULE-INT-001: Ссылка на компонент должна существовать в 2.525 -->
    <sch:rule context="eskd-ekb:allowed_component_item/eskd-ekb:componentRef">
      <sch:let name="compRef" value="."/>
      <sch:assert test="exists(//eskd-2525:eskd_product[@id = $compRef]) or 
                        exists(//eskd-ekb:allowed_component_list/eskd-ekb:componentRef)"
                  role="error"
                  id="RULE-INT-001">
        Ссылка на компонент должна существовать в модуле 2.525 или в перечне.
        componentRef: <sch:value-of select="$compRef"/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-INT-002: Орган утверждения должен существовать в 2.058 -->
    <sch:rule context="eskd-ekb:allowed_component_list/eskd-ekb:issuingAuthority">
      <sch:let name="authRef" value="."/>
      <sch:assert test="exists(//eskd-2058:organization[@id = $authRef])"
                  role="error"
                  id="RULE-INT-002">
        Орган утверждения должен существовать в модуле 2.058.
        issuingAuthority: <sch:value-of select="$authRef"/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-INT-003: Документ утверждения должен существовать в 2.525 -->
    <sch:rule context="eskd-ekb:allowed_component_list/eskd-ekb:approvalDocument/eskd-ekb:documentRef">
      <sch:let name="docRef" value="."/>
      <sch:assert test="exists(//eskd-2525:document[@id = $docRef]) or 
                        exists(//eskd-2058:doc_requisite[@id = $docRef])"
                  role="error"
                  id="RULE-INT-003">
        Документ утверждения должен существовать в модуле 2.525 или 2.058.
        documentRef: <sch:value-of select="$docRef"/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-INT-004: Производитель должен существовать в 2.058 -->
    <sch:rule context="eskd-ekb:allowed_component_item[eskd-ekb:manufacturer]">
      <sch:let name="mfgRef" value="eskd-ekb:manufacturer"/>
      <sch:assert test="exists(//eskd-2058:organization[@id = $mfgRef])"
                  role="warning"
                  id="RULE-INT-004">
        Производитель должен существовать в модуле 2.058.
        manufacturer: <sch:value-of select="$mfgRef"/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-INT-005: Отчёт об испытаниях должен существовать в 2.525 -->
    <sch:rule context="eskd-ekb:allowed_component_item[eskd-ekb:testReportRef]">
      <sch:let name="testRef" value="eskd-ekb:testReportRef"/>
      <sch:assert test="exists(//eskd-2525:document[@id = $testRef]) or 
                        exists(//eskd-2058:doc_requisite[@id = $testRef])"
                  role="warning"
                  id="RULE-INT-005">
        Отчёт об испытаниях должен существовать в модуле 2.525 или 2.058.
        testReportRef: <sch:value-of select="$testRef"/>
      </sch:assert>
    </sch:rule>
    
    <!-- RULE-INT-006: Декларация соответствия должна ссылаться на существующее изделие -->
    <sch:rule context="eskd-ekb:compliance_assertion/eskd-ekb:productRef">
      <sch:let name="prodRef" value="."/>
      <sch:assert test="exists(//eskd-2525:eskd_product[@id = $prodRef])"
                  role="error"
                  id="RULE-INT-006">
        Декларация соответствия должна ссылаться на существующее изделие.
        productRef: <sch:value-of select="$prodRef"/>
      </sch:assert>
    </sch:rule>
    
  </sch:pattern>
  
  <!-- ========================================================================
       РАЗДЕЛ 5: ПРАВИЛА КАЧЕСТВА ДАННЫХ
       ======================================================================== -->
  
  <sch:pattern id="data-quality-rules">
    <sch:title>Правила качества данных</sch:title>
    
    <!-- RULE-DQ-001: Предупреждение о скором истечении срока действия перечня -->
    <sch:rule context="eskd-ekb:allowed_component_list[eskd-ekb:expirationDate]">
      <sch:let name="daysUntilExpiry" value="xs:date(eskd-ekb:expirationDate) - current-date()"/>
      <sch:report test="$daysUntilExpiry &lt; 90 and $daysUntilExpiry &gt;= 0"
                  role="warning"
                  id="RULE-DQ-001">
        Срок действия перечня истекает менее чем через 90 дней.
        expirationDate: <sch:value-of select="eskd-ekb:expirationDate"/>, 
        Осталось дней: <sch:value-of select="$daysUntilExpiry"/>
      </sch:report>
    </sch:rule>
    
    <!-- RULE-DQ-002: Предупреждение о декларациях без верификатора -->
    <sch:rule context="eskd-ekb:compliance_assertion[not(eskd-ekb:verifierRef)]">
      <sch:report test="true()"
                  role="warning"
                  id="RULE-DQ-002">
        Декларация соответствия не содержит ссылку на верификатора.
        Рекомендуется указать организацию или лицо, выполнившее проверку.
        Декларация: <sch:value-of select="eskd-ekb:assertionId"/>
      </sch:report>
    </sch:rule>
    
    <!-- RULE-DQ-003: Предупреждение о заменам без анализа влияния -->
    <sch:rule context="eskd-ekb:replacement_item[not(eskd-ekb:impactAnalysis)]">
      <sch:report test="true()"
                  role="warning"
                  id="RULE-DQ-003">
        Замена компонента не содержит анализ влияния на изделие.
        Рекомендуется заполнить impactAnalysis для критичных замен.
        Замена: <sch:value-of select="@id"/>
      </sch:report>
    </sch:rule>
    
    <!-- RULE-DQ-004: Предупреждение о классификаторах без синонимов -->
    <sch:rule context="eskd-nsi:entry[not(eskd-nsi:synonyms)]">
      <sch:report test="true()"
                  role="info"
                  id="RULE-DQ-004">
        Запись классификатора не содержит синонимов.
        Для улучшения поиска рекомендуется добавить синонимы.
        Запись: <sch:value-of select="eskd-nsi:code"/>
      </sch:report>
    </sch:rule>
    
    <!-- RULE-DQ-005: Предупреждение о записях без атрибутов -->
    <sch:rule context="eskd-nsi:record[count(eskd-nsi:attributes/eskd-nsi:attribute) &lt; 3]">
      <sch:report test="true()"
                  role="warning"
                  id="RULE-DQ-005">
        Запись справочника содержит менее 3 атрибутов.
        Для полноценного описания рекомендуется минимум 3 атрибута.
        Запись: <sch:value-of select="eskd-nsi:recordId"/>
      </sch:report>
    </sch:rule>
    
    <!-- RULE-DQ-006: Предупреждение о маппингах без правил трансформации -->
    <sch:rule context="eskd-nsi:nsi_mapping/eskd-nsi:mappings/eskd-nsi:mapping[eskd-nsi:mappingType='derived']">
      <sch:assert test="exists(eskd-nsi:transformationRule) and 
                        string-length(normalize-space(eskd-nsi:transformationRule)) &gt; 0"
                  role="warning"
                  id="RULE-DQ-006">
        Для маппингов типа 'derived' рекомендуется указать правило трансформации.
        Маппинг: <sch:value-of select="@id"/>
      </sch:assert>
    </sch:rule>
    
  </sch:pattern>
  
  <!-- ========================================================================
       РАЗДЕЛ 6: ДИАГНОСТИЧЕСКИЕ СООБЩЕНИЯ
       ======================================================================== -->
  
  <sch:pattern id="diagnostic-messages">
    <sch:title>Диагностические сообщения</sch:title>
    
    <!-- DIAG-001: Информация о количестве объектов в файле -->
    <sch:rule context="eskd-ekb:EkbProfileRoot | eskd-nsi:NsiProfileRoot">
      <sch:report test="true()"
                  role="info"
                  id="DIAG-001">
        Статистика файла:
        - Разрешённых перечней: <sch:value-of select="count(.//eskd-ekb:allowed_component_list)"/>
        - Позиций перечней: <sch:value-of select="count(.//eskd-ekb:allowed_component_item)"/>
        - Групп замен: <sch:value-of select="count(.//eskd-ekb:replacement_group)"/>
        - Замен: <sch:value-of select="count(.//eskd-ekb:replacement_item)"/>
        - Деклараций соответствия: <sch:value-of select="count(.//eskd-ekb:compliance_assertion)"/>
        - Классификаторов: <sch:value-of select="count(.//eskd-nsi:classifier)"/>
        - Справочников: <sch:value-of select="count(.//eskd-nsi:referenceBook)"/>
        - Записей НСИ: <sch:value-of select="count(.//eskd-nsi:record)"/>
      </sch:report>
    </sch:rule>
    
    <!-- DIAG-002: Информация о степени интероперабельности -->
    <sch:rule context="eskd-pi:metadata/eskd-pi:interoperabilityDegree">
      <sch:let name="degree" value="number(.)"/>
      <sch:report test="$degree &gt;= 0.9"
                  role="info"
                  id="DIAG-002-A">
        Отличная степень интероперабельности: <sch:value-of select="."/> (≥ 0.9)
      </sch:report>
      <sch:report test="$degree &gt;= 0.8 and $degree &lt; 0.9"
                  role="info"
                  id="DIAG-002-B">
        Хорошая степень интероперабельности: <sch:value-of select="."/> (0.8 - 0.9)
      </sch:report>
      <sch:report test="$degree &lt; 0.8"
                  role="warning"
                  id="DIAG-002-C">
        Требуется улучшение степени интероперабельности: <sch:value-of select="."/> (&lt; 0.8)
      </sch:report>
    </sch:rule>
    
  </sch:pattern>
  
</sch:schema>
