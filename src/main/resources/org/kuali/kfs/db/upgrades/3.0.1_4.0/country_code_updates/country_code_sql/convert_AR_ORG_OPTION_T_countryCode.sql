--
-- The Kuali Financial System, a comprehensive financial management system for higher education.
-- 
-- Copyright 2005-2014 The Kuali Foundation
-- 
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU Affero General Public License as
-- published by the Free Software Foundation, either version 3 of the
-- License, or (at your option) any later version.
-- 
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Affero General Public License for more details.
-- 
-- You should have received a copy of the GNU Affero General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
--

-- This script will migrate a column in a table from the former Rice country 
-- codes which were based on FIPS 10-4 (with some minor differences) to the new
-- Rice country codes which are based on ISO 3166-1.  This script may not 
-- properly execute on columns with a primary key or unique constraint as some
-- of the former codes have merged (i.e. - all US Minor Outlying Islands have 
-- been unified under a single code, UM).  This script also does not take any 
-- action on codes that are not part of the list of former Rice country codes.
--
-- Table Name: 	AR_ORG_OPTION_T
-- Column Name: ORG_POSTAL_CNTRY_CD
--
-- In order to avoid collisions between the former codes and the new codes, the 
-- codes are first changed to an interim, unique code.  Once that change is 
-- complete, they are changed to the new, correct code.
--
-- Change to temporary code
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='A0' where ORG_POSTAL_CNTRY_CD='AA';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='A1' where ORG_POSTAL_CNTRY_CD='AC';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='A3' where ORG_POSTAL_CNTRY_CD='AG';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='A4' where ORG_POSTAL_CNTRY_CD='AJ';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='A7' where ORG_POSTAL_CNTRY_CD='AN';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='A9' where ORG_POSTAL_CNTRY_CD='AQ';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='B1' where ORG_POSTAL_CNTRY_CD='AS';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='B2' where ORG_POSTAL_CNTRY_CD='AT';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='B3' where ORG_POSTAL_CNTRY_CD='AU';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='B4' where ORG_POSTAL_CNTRY_CD='AV';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='B5' where ORG_POSTAL_CNTRY_CD='AY';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='B6' where ORG_POSTAL_CNTRY_CD='BA';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='B8' where ORG_POSTAL_CNTRY_CD='BC';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='B9' where ORG_POSTAL_CNTRY_CD='BD';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='C1' where ORG_POSTAL_CNTRY_CD='BF';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='C2' where ORG_POSTAL_CNTRY_CD='BG';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='C3' where ORG_POSTAL_CNTRY_CD='BH';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='C4' where ORG_POSTAL_CNTRY_CD='BK';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='C5' where ORG_POSTAL_CNTRY_CD='BL';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='C6' where ORG_POSTAL_CNTRY_CD='BM';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='C7' where ORG_POSTAL_CNTRY_CD='BN';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='C8' where ORG_POSTAL_CNTRY_CD='BO';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='C9' where ORG_POSTAL_CNTRY_CD='BP';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='D0' where ORG_POSTAL_CNTRY_CD='BQ';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='D2' where ORG_POSTAL_CNTRY_CD='BS';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='D4' where ORG_POSTAL_CNTRY_CD='BU';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='D6' where ORG_POSTAL_CNTRY_CD='BX';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='D7' where ORG_POSTAL_CNTRY_CD='BY';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='D9' where ORG_POSTAL_CNTRY_CD='CB';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='E0' where ORG_POSTAL_CNTRY_CD='CD';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='E1' where ORG_POSTAL_CNTRY_CD='CE';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='E2' where ORG_POSTAL_CNTRY_CD='CF';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='E3' where ORG_POSTAL_CNTRY_CD='CG';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='E4' where ORG_POSTAL_CNTRY_CD='CH';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='E5' where ORG_POSTAL_CNTRY_CD='CI';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='E6' where ORG_POSTAL_CNTRY_CD='CJ';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='E7' where ORG_POSTAL_CNTRY_CD='CK';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='E9' where ORG_POSTAL_CNTRY_CD='CN';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='F1' where ORG_POSTAL_CNTRY_CD='CQ';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='F2' where ORG_POSTAL_CNTRY_CD='CR';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='F3' where ORG_POSTAL_CNTRY_CD='CS';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='F4' where ORG_POSTAL_CNTRY_CD='CT';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='F7' where ORG_POSTAL_CNTRY_CD='CW';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='F9' where ORG_POSTAL_CNTRY_CD='CZ';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='G0' where ORG_POSTAL_CNTRY_CD='DA';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='G2' where ORG_POSTAL_CNTRY_CD='DO';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='G3' where ORG_POSTAL_CNTRY_CD='DR';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='G6' where ORG_POSTAL_CNTRY_CD='EI';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='G7' where ORG_POSTAL_CNTRY_CD='EK';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='G8' where ORG_POSTAL_CNTRY_CD='EN';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='H0' where ORG_POSTAL_CNTRY_CD='ES';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='H2' where ORG_POSTAL_CNTRY_CD='EU';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='H3' where ORG_POSTAL_CNTRY_CD='EZ';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='H4' where ORG_POSTAL_CNTRY_CD='FA';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='H5' where ORG_POSTAL_CNTRY_CD='FG';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='I0' where ORG_POSTAL_CNTRY_CD='FP';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='I1' where ORG_POSTAL_CNTRY_CD='FQ';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='I3' where ORG_POSTAL_CNTRY_CD='FS';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='I4' where ORG_POSTAL_CNTRY_CD='GA';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='I5' where ORG_POSTAL_CNTRY_CD='GB';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='I6' where ORG_POSTAL_CNTRY_CD='GE';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='I7' where ORG_POSTAL_CNTRY_CD='GG';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='J0' where ORG_POSTAL_CNTRY_CD='GJ';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='J1' where ORG_POSTAL_CNTRY_CD='GK';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='J3' where ORG_POSTAL_CNTRY_CD='GM';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='J4' where ORG_POSTAL_CNTRY_CD='GO';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='J6' where ORG_POSTAL_CNTRY_CD='GQ';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='J9' where ORG_POSTAL_CNTRY_CD='GV';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='K1' where ORG_POSTAL_CNTRY_CD='GZ';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='K2' where ORG_POSTAL_CNTRY_CD='HA';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='K5' where ORG_POSTAL_CNTRY_CD='HO';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='K6' where ORG_POSTAL_CNTRY_CD='HQ';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='K9' where ORG_POSTAL_CNTRY_CD='IC';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='L4' where ORG_POSTAL_CNTRY_CD='IP';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='L6' where ORG_POSTAL_CNTRY_CD='IS';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='L8' where ORG_POSTAL_CNTRY_CD='IV';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='L9' where ORG_POSTAL_CNTRY_CD='IY';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='M0' where ORG_POSTAL_CNTRY_CD='IZ';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='M1' where ORG_POSTAL_CNTRY_CD='JA';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='M4' where ORG_POSTAL_CNTRY_CD='JN';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='M6' where ORG_POSTAL_CNTRY_CD='JQ';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='M7' where ORG_POSTAL_CNTRY_CD='JU';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='N0' where ORG_POSTAL_CNTRY_CD='KN';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='N1' where ORG_POSTAL_CNTRY_CD='KQ';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='N2' where ORG_POSTAL_CNTRY_CD='KR';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='N3' where ORG_POSTAL_CNTRY_CD='KS';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='N4' where ORG_POSTAL_CNTRY_CD='KT';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='N5' where ORG_POSTAL_CNTRY_CD='KU';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='N8' where ORG_POSTAL_CNTRY_CD='LE';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='N9' where ORG_POSTAL_CNTRY_CD='LG';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='O0' where ORG_POSTAL_CNTRY_CD='LH';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='O1' where ORG_POSTAL_CNTRY_CD='LI';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='O2' where ORG_POSTAL_CNTRY_CD='LO';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='O3' where ORG_POSTAL_CNTRY_CD='LQ';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='O4' where ORG_POSTAL_CNTRY_CD='LS';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='O5' where ORG_POSTAL_CNTRY_CD='LT';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='O8' where ORG_POSTAL_CNTRY_CD='MA';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='O9' where ORG_POSTAL_CNTRY_CD='MB';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='P0' where ORG_POSTAL_CNTRY_CD='MC';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='P2' where ORG_POSTAL_CNTRY_CD='MF';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='P3' where ORG_POSTAL_CNTRY_CD='MG';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='P4' where ORG_POSTAL_CNTRY_CD='MH';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='P5' where ORG_POSTAL_CNTRY_CD='MI';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='P8' where ORG_POSTAL_CNTRY_CD='MN';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='P9' where ORG_POSTAL_CNTRY_CD='MO';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='Q0' where ORG_POSTAL_CNTRY_CD='MP';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='Q1' where ORG_POSTAL_CNTRY_CD='MQ';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='Q4' where ORG_POSTAL_CNTRY_CD='MU';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='Q6' where ORG_POSTAL_CNTRY_CD='MW';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='R0' where ORG_POSTAL_CNTRY_CD='NA';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='R2' where ORG_POSTAL_CNTRY_CD='NE';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='R4' where ORG_POSTAL_CNTRY_CD='NG';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='R5' where ORG_POSTAL_CNTRY_CD='NH';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='R6' where ORG_POSTAL_CNTRY_CD='NI';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='S1' where ORG_POSTAL_CNTRY_CD='NS';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='S2' where ORG_POSTAL_CNTRY_CD='NU';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='S4' where ORG_POSTAL_CNTRY_CD='OC';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='S5' where ORG_POSTAL_CNTRY_CD='PA';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='S6' where ORG_POSTAL_CNTRY_CD='PC';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='S8' where ORG_POSTAL_CNTRY_CD='PF';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='S9' where ORG_POSTAL_CNTRY_CD='PG';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='T2' where ORG_POSTAL_CNTRY_CD='PM';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='T3' where ORG_POSTAL_CNTRY_CD='PO';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='T4' where ORG_POSTAL_CNTRY_CD='PP';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='T5' where ORG_POSTAL_CNTRY_CD='PS';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='T6' where ORG_POSTAL_CNTRY_CD='PU';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='T9' where ORG_POSTAL_CNTRY_CD='RM';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='U1' where ORG_POSTAL_CNTRY_CD='RP';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='U2' where ORG_POSTAL_CNTRY_CD='RQ';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='U3' where ORG_POSTAL_CNTRY_CD='RS';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='U6' where ORG_POSTAL_CNTRY_CD='SB';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='U7' where ORG_POSTAL_CNTRY_CD='SC';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='U8' where ORG_POSTAL_CNTRY_CD='SE';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='U9' where ORG_POSTAL_CNTRY_CD='SF';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='V0' where ORG_POSTAL_CNTRY_CD='SG';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='V5' where ORG_POSTAL_CNTRY_CD='SN';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='V7' where ORG_POSTAL_CNTRY_CD='SP';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='V8' where ORG_POSTAL_CNTRY_CD='SR';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='V9' where ORG_POSTAL_CNTRY_CD='ST';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='W0' where ORG_POSTAL_CNTRY_CD='SU';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='W1' where ORG_POSTAL_CNTRY_CD='SV';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='W2' where ORG_POSTAL_CNTRY_CD='SW';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='W4' where ORG_POSTAL_CNTRY_CD='SZ';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='W5' where ORG_POSTAL_CNTRY_CD='TC';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='W6' where ORG_POSTAL_CNTRY_CD='TD';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='W7' where ORG_POSTAL_CNTRY_CD='TE';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='W9' where ORG_POSTAL_CNTRY_CD='TI';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='X0' where ORG_POSTAL_CNTRY_CD='TK';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='X1' where ORG_POSTAL_CNTRY_CD='TL';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='X2' where ORG_POSTAL_CNTRY_CD='TN';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='X3' where ORG_POSTAL_CNTRY_CD='TO';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='X4' where ORG_POSTAL_CNTRY_CD='TP';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='X5' where ORG_POSTAL_CNTRY_CD='TS';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='X6' where ORG_POSTAL_CNTRY_CD='TU';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='X9' where ORG_POSTAL_CNTRY_CD='TX';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='Y2' where ORG_POSTAL_CNTRY_CD='UK';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='Y3' where ORG_POSTAL_CNTRY_CD='UP';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='Y4' where ORG_POSTAL_CNTRY_CD='UR';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='Z0' where ORG_POSTAL_CNTRY_CD='VI';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='Z1' where ORG_POSTAL_CNTRY_CD='VM';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='Z2' where ORG_POSTAL_CNTRY_CD='VQ';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='Z3' where ORG_POSTAL_CNTRY_CD='VT';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='Z4' where ORG_POSTAL_CNTRY_CD='WA';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='Z5' where ORG_POSTAL_CNTRY_CD='WE';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='Z7' where ORG_POSTAL_CNTRY_CD='WI';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='Z8' where ORG_POSTAL_CNTRY_CD='WQ';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='00' where ORG_POSTAL_CNTRY_CD='WZ';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='01' where ORG_POSTAL_CNTRY_CD='YM';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='02' where ORG_POSTAL_CNTRY_CD='YO';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='03' where ORG_POSTAL_CNTRY_CD='ZA';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='04' where ORG_POSTAL_CNTRY_CD='ZI';
-- Change to final code
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='AW' where ORG_POSTAL_CNTRY_CD='A0';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='AG' where ORG_POSTAL_CNTRY_CD='A1';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='DZ' where ORG_POSTAL_CNTRY_CD='A3';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='AZ' where ORG_POSTAL_CNTRY_CD='A4';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='AD' where ORG_POSTAL_CNTRY_CD='A7';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='AS' where ORG_POSTAL_CNTRY_CD='A9';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='AU' where ORG_POSTAL_CNTRY_CD='B1';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='AU' where ORG_POSTAL_CNTRY_CD='B2';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='AT' where ORG_POSTAL_CNTRY_CD='B3';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='AI' where ORG_POSTAL_CNTRY_CD='B4';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='AQ' where ORG_POSTAL_CNTRY_CD='B5';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='BH' where ORG_POSTAL_CNTRY_CD='B6';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='BW' where ORG_POSTAL_CNTRY_CD='B8';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='BM' where ORG_POSTAL_CNTRY_CD='B9';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='BS' where ORG_POSTAL_CNTRY_CD='C1';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='BD' where ORG_POSTAL_CNTRY_CD='C2';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='BZ' where ORG_POSTAL_CNTRY_CD='C3';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='BA' where ORG_POSTAL_CNTRY_CD='C4';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='BO' where ORG_POSTAL_CNTRY_CD='C5';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='MM' where ORG_POSTAL_CNTRY_CD='C6';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='BJ' where ORG_POSTAL_CNTRY_CD='C7';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='BY' where ORG_POSTAL_CNTRY_CD='C8';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='SB' where ORG_POSTAL_CNTRY_CD='C9';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='UM' where ORG_POSTAL_CNTRY_CD='D0';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='TF' where ORG_POSTAL_CNTRY_CD='D2';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='BG' where ORG_POSTAL_CNTRY_CD='D4';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='BN' where ORG_POSTAL_CNTRY_CD='D6';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='BI' where ORG_POSTAL_CNTRY_CD='D7';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='KH' where ORG_POSTAL_CNTRY_CD='D9';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='TD' where ORG_POSTAL_CNTRY_CD='E0';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='LK' where ORG_POSTAL_CNTRY_CD='E1';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='CG' where ORG_POSTAL_CNTRY_CD='E2';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='CD' where ORG_POSTAL_CNTRY_CD='E3';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='CN' where ORG_POSTAL_CNTRY_CD='E4';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='CL' where ORG_POSTAL_CNTRY_CD='E5';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='KY' where ORG_POSTAL_CNTRY_CD='E6';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='CC' where ORG_POSTAL_CNTRY_CD='E7';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='KM' where ORG_POSTAL_CNTRY_CD='E9';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='MP' where ORG_POSTAL_CNTRY_CD='F1';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='AU' where ORG_POSTAL_CNTRY_CD='F2';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='CR' where ORG_POSTAL_CNTRY_CD='F3';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='CF' where ORG_POSTAL_CNTRY_CD='F4';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='CK' where ORG_POSTAL_CNTRY_CD='F7';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='CS' where ORG_POSTAL_CNTRY_CD='F9';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='DK' where ORG_POSTAL_CNTRY_CD='G0';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='DM' where ORG_POSTAL_CNTRY_CD='G2';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='DO' where ORG_POSTAL_CNTRY_CD='G3';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='IE' where ORG_POSTAL_CNTRY_CD='G6';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='GQ' where ORG_POSTAL_CNTRY_CD='G7';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='EE' where ORG_POSTAL_CNTRY_CD='G8';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='SV' where ORG_POSTAL_CNTRY_CD='H0';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='TF' where ORG_POSTAL_CNTRY_CD='H2';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='CZ' where ORG_POSTAL_CNTRY_CD='H3';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='FK' where ORG_POSTAL_CNTRY_CD='H4';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='GF' where ORG_POSTAL_CNTRY_CD='H5';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='PF' where ORG_POSTAL_CNTRY_CD='I0';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='UM' where ORG_POSTAL_CNTRY_CD='I1';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='TF' where ORG_POSTAL_CNTRY_CD='I3';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='GM' where ORG_POSTAL_CNTRY_CD='I4';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='GA' where ORG_POSTAL_CNTRY_CD='I5';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='DE' where ORG_POSTAL_CNTRY_CD='I6';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='GE' where ORG_POSTAL_CNTRY_CD='I7';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='GD' where ORG_POSTAL_CNTRY_CD='J0';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='GG' where ORG_POSTAL_CNTRY_CD='J1';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='DE' where ORG_POSTAL_CNTRY_CD='J3';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='TF' where ORG_POSTAL_CNTRY_CD='J4';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='GU' where ORG_POSTAL_CNTRY_CD='J6';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='GN' where ORG_POSTAL_CNTRY_CD='J9';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='PS' where ORG_POSTAL_CNTRY_CD='K1';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='HT' where ORG_POSTAL_CNTRY_CD='K2';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='HN' where ORG_POSTAL_CNTRY_CD='K5';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='UM' where ORG_POSTAL_CNTRY_CD='K6';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='IS' where ORG_POSTAL_CNTRY_CD='K9';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='FR' where ORG_POSTAL_CNTRY_CD='L4';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='IL' where ORG_POSTAL_CNTRY_CD='L6';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='CI' where ORG_POSTAL_CNTRY_CD='L8';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='NT' where ORG_POSTAL_CNTRY_CD='L9';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='IQ' where ORG_POSTAL_CNTRY_CD='M0';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='JP' where ORG_POSTAL_CNTRY_CD='M1';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='NO' where ORG_POSTAL_CNTRY_CD='M4';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='UM' where ORG_POSTAL_CNTRY_CD='M6';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='TF' where ORG_POSTAL_CNTRY_CD='M7';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='KP' where ORG_POSTAL_CNTRY_CD='N0';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='UM' where ORG_POSTAL_CNTRY_CD='N1';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='KI' where ORG_POSTAL_CNTRY_CD='N2';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='KR' where ORG_POSTAL_CNTRY_CD='N3';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='CX' where ORG_POSTAL_CNTRY_CD='N4';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='KW' where ORG_POSTAL_CNTRY_CD='N5';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='LB' where ORG_POSTAL_CNTRY_CD='N8';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='LV' where ORG_POSTAL_CNTRY_CD='N9';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='LT' where ORG_POSTAL_CNTRY_CD='O0';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='LR' where ORG_POSTAL_CNTRY_CD='O1';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='SK' where ORG_POSTAL_CNTRY_CD='O2';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='UM' where ORG_POSTAL_CNTRY_CD='O3';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='LI' where ORG_POSTAL_CNTRY_CD='O4';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='LS' where ORG_POSTAL_CNTRY_CD='O5';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='MG' where ORG_POSTAL_CNTRY_CD='O8';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='MQ' where ORG_POSTAL_CNTRY_CD='O9';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='MO' where ORG_POSTAL_CNTRY_CD='P0';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='YT' where ORG_POSTAL_CNTRY_CD='P2';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='MN' where ORG_POSTAL_CNTRY_CD='P3';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='MS' where ORG_POSTAL_CNTRY_CD='P4';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='MW' where ORG_POSTAL_CNTRY_CD='P5';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='MC' where ORG_POSTAL_CNTRY_CD='P8';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='MA' where ORG_POSTAL_CNTRY_CD='P9';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='MU' where ORG_POSTAL_CNTRY_CD='Q0';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='UM' where ORG_POSTAL_CNTRY_CD='Q1';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='OM' where ORG_POSTAL_CNTRY_CD='Q4';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='ME' where ORG_POSTAL_CNTRY_CD='Q6';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='AN' where ORG_POSTAL_CNTRY_CD='R0';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='NU' where ORG_POSTAL_CNTRY_CD='R2';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='NE' where ORG_POSTAL_CNTRY_CD='R4';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='VU' where ORG_POSTAL_CNTRY_CD='R5';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='NG' where ORG_POSTAL_CNTRY_CD='R6';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='SR' where ORG_POSTAL_CNTRY_CD='S1';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='NI' where ORG_POSTAL_CNTRY_CD='S2';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='ZZ' where ORG_POSTAL_CNTRY_CD='S4';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='PY' where ORG_POSTAL_CNTRY_CD='S5';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='PN' where ORG_POSTAL_CNTRY_CD='S6';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='XP' where ORG_POSTAL_CNTRY_CD='S8';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='XS' where ORG_POSTAL_CNTRY_CD='S9';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='PA' where ORG_POSTAL_CNTRY_CD='T2';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='PT' where ORG_POSTAL_CNTRY_CD='T3';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='PG' where ORG_POSTAL_CNTRY_CD='T4';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='PW' where ORG_POSTAL_CNTRY_CD='T5';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='GW' where ORG_POSTAL_CNTRY_CD='T6';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='MH' where ORG_POSTAL_CNTRY_CD='T9';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='PH' where ORG_POSTAL_CNTRY_CD='U1';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='PR' where ORG_POSTAL_CNTRY_CD='U2';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='RU' where ORG_POSTAL_CNTRY_CD='U3';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='PM' where ORG_POSTAL_CNTRY_CD='U6';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='KN' where ORG_POSTAL_CNTRY_CD='U7';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='SC' where ORG_POSTAL_CNTRY_CD='U8';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='ZA' where ORG_POSTAL_CNTRY_CD='U9';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='SN' where ORG_POSTAL_CNTRY_CD='V0';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='SG' where ORG_POSTAL_CNTRY_CD='V5';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='ES' where ORG_POSTAL_CNTRY_CD='V7';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='RS' where ORG_POSTAL_CNTRY_CD='V8';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='LC' where ORG_POSTAL_CNTRY_CD='V9';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='SD' where ORG_POSTAL_CNTRY_CD='W0';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='SJ' where ORG_POSTAL_CNTRY_CD='W1';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='SE' where ORG_POSTAL_CNTRY_CD='W2';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='CH' where ORG_POSTAL_CNTRY_CD='W4';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='AE' where ORG_POSTAL_CNTRY_CD='W5';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='TT' where ORG_POSTAL_CNTRY_CD='W6';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='TF' where ORG_POSTAL_CNTRY_CD='W7';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='TJ' where ORG_POSTAL_CNTRY_CD='W9';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='TC' where ORG_POSTAL_CNTRY_CD='X0';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='TK' where ORG_POSTAL_CNTRY_CD='X1';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='TO' where ORG_POSTAL_CNTRY_CD='X2';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='TG' where ORG_POSTAL_CNTRY_CD='X3';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='ST' where ORG_POSTAL_CNTRY_CD='X4';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='TN' where ORG_POSTAL_CNTRY_CD='X5';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='TR' where ORG_POSTAL_CNTRY_CD='X6';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='TM' where ORG_POSTAL_CNTRY_CD='X9';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='GB' where ORG_POSTAL_CNTRY_CD='Y2';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='UA' where ORG_POSTAL_CNTRY_CD='Y3';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='SU' where ORG_POSTAL_CNTRY_CD='Y4';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='VG' where ORG_POSTAL_CNTRY_CD='Z0';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='VN' where ORG_POSTAL_CNTRY_CD='Z1';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='VI' where ORG_POSTAL_CNTRY_CD='Z2';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='VA' where ORG_POSTAL_CNTRY_CD='Z3';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='NA' where ORG_POSTAL_CNTRY_CD='Z4';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='PS' where ORG_POSTAL_CNTRY_CD='Z5';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='EH' where ORG_POSTAL_CNTRY_CD='Z7';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='UM' where ORG_POSTAL_CNTRY_CD='Z8';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='SZ' where ORG_POSTAL_CNTRY_CD='00';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='YE' where ORG_POSTAL_CNTRY_CD='01';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='YU' where ORG_POSTAL_CNTRY_CD='02';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='ZM' where ORG_POSTAL_CNTRY_CD='03';
UPDATE AR_ORG_OPTION_T SET ORG_POSTAL_CNTRY_CD='ZW' where ORG_POSTAL_CNTRY_CD='04';
