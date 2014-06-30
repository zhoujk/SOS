--
-- Copyright (C) 2012-2014 52°North Initiative for Geospatial Open Source
-- Software GmbH
--
-- This program is free software; you can redistribute it and/or modify it
-- under the terms of the GNU General Public License version 2 as published
-- by the Free Software Foundation.
--
-- If the program is linked with libraries which are licensed under one of
-- the following licenses, the combination of the program with the linked
-- library is not considered a "derivative work" of the program:
--
--     - Apache License, version 2.0
--     - Apache Software License, version 1.0
--     - GNU Lesser General Public License, version 3
--     - Mozilla Public License, versions 1.0, 1.1 and 2.0
--     - Common Development and Distribution License (CDDL), version 1.0
--
-- Therefore the distribution of the program linked with libraries licensed
-- under the aforementioned licenses, is permitted by the copyright holders
-- if the distribution is compliant with both the GNU General Public
-- License version 2 and the aforementioned licenses.
--
-- This program is distributed in the hope that it will be useful, but
-- WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
-- Public License for more details.
--


ALTER TABLE i18nprocedure          DROP CONSTRAINT IF EXISTS i18nprocedurecodespacefk;
ALTER TABLE i18nfeatureofinterest  DROP CONSTRAINT IF EXISTS i18nfeaturecodespacefk;
ALTER TABLE i18nobservableproperty DROP CONSTRAINT IF EXISTS i18nobspropcodespacefk;
ALTER TABLE i18noffering           DROP CONSTRAINT IF EXISTS i18nofferingcodespacefk;

ALTER TABLE i18nprocedure          DROP CONSTRAINT IF EXISTS i18nprocedure_objectid_codespace_key;
ALTER TABLE i18nfeatureofinterest  DROP CONSTRAINT IF EXISTS i18nfeatureofinterest_objectid_codespace_key;
ALTER TABLE i18nobservableproperty DROP CONSTRAINT IF EXISTS i18nobservableproperty_objectid_codespace_key;
ALTER TABLE i18noffering           DROP CONSTRAINT IF EXISTS i18noffering_objectid_codespace_key;

ALTER TABLE i18nprocedure          ADD COLUMN locale VARCHAR(255) NOT NULL;
ALTER TABLE i18nfeatureofinterest  ADD COLUMN locale VARCHAR(255) NOT NULL;
ALTER TABLE i18nobservableproperty ADD COLUMN locale VARCHAR(255) NOT NULL;
ALTER TABLE i18noffering           ADD COLUMN locale VARCHAR(255) NOT NULL;

UPDATE i18nprocedure          AS i18n SET locale = (SELECT cs.codespace FROM codespace AS cs WHERE cs.codespaceid = i18n.codespace);
UPDATE i18nfeatureofinterest  AS i18n SET locale = (SELECT cs.codespace FROM codespace AS cs WHERE cs.codespaceid = i18n.codespace);
UPDATE i18nobservableproperty AS i18n SET locale = (SELECT cs.codespace FROM codespace AS cs WHERE cs.codespaceid = i18n.codespace);
UPDATE i18noffering           AS i18n SET locale = (SELECT cs.codespace FROM codespace AS cs WHERE cs.codespaceid = i18n.codespace);

ALTER TABLE i18nprocedure          DROP COLUMN codespace;
ALTER TABLE i18nfeatureofinterest  DROP COLUMN codespace;
ALTER TABLE i18nobservableproperty DROP COLUMN codespace;
ALTER TABLE i18noffering           DROP COLUMN codespace;


ALTER TABLE i18nprocedure          ADD CONSTRAINT i18nprocedure_objectid_locale_key UNIQUE(objectid, locale);
ALTER TABLE i18nfeatureofinterest  ADD CONSTRAINT i18nfeatureofinterest_objectid_locale_key UNIQUE(objectid, locale);
ALTER TABLE i18nobservableproperty ADD CONSTRAINT i18nobservableproperty_objectid_locale_key UNIQUE(objectid, locale);
ALTER TABLE i18noffering           ADD CONSTRAINT i18noffering_objectid_locale_key UNIQUE(objectid, locale);