/* 1.0 Clean-correct existing SourceCode information prior to coversion
SELECT ID, SourceCode FROM Registry WHERE SourceCode = 'DA/ATF'

Script to find Incorrect Sourcecodes
	SELECT --Registry.ID, 
		Registry.SourceCode 
	FROM Registry
	LEFT JOIN EventRegistry ON EventRegistry.RegistryID = Registry.ID
	WHERE EventRegistry.RegistryID IS Null
	AND IsNull(Registry.SourceCode, '') <> ''
*/

/* Backup registry sourcecodes  */
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = '_BackupRegistrySourcecodeIndex')
	BEGIN
		PRINT 'Dropping Table _BackupRegistrySourcecodeIndex'
		DROP  Table _BackupRegistrySourcecodeIndex
	END
GO
PRINT 'Creating Registry Sourcecode index backup'
	SELECT ID, Sourcecode INTO _BackupRegistrySourcecodeIndex FROM Registry 

/* Backup EventRegistry */
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = '_BackupEventRegistry')
	BEGIN
		PRINT 'Dropping Table _BackupEventRegistry'
		DROP  Table _BackupEventRegistry
	END
GO
PRINT 'Creating EventRegistry backup'
	SELECT * INTO _BackupEventRegistry FROM EventRegistry 
	
	
/* Create Temp table _RegistryXref */
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = '_RegistryXref')
	BEGIN
		PRINT 'Dropping Table _RegistryXref'
		DROP  Table _RegistryXref
	END
GO

PRINT 'Creating _RegistryXref table'

CREATE TABLE [_RegistryXref] (
 [ID] [int] NOT NULL,
 [SourceCode] [varchar](255) Null
 )
 GO

PRINT 'Adding Values >  _RegistryXref table'
	INSERT INTO _RegistryXref
	SELECT ID, Sourcecode FROM Registry 


/* OldCodeNewCodeXref  */
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = '_OldCodeNewCodeXref')
	BEGIN
		PRINT 'Dropping Table _OldCodeNewCodeXref'
		DROP  Table _OldCodeNewCodeXref
	END

GO
		CREATE TABLE [_OldCodeNewCodeXref] (
		[ID] [int] IDENTITY (1, 1) NOT NULL,
		[OldSourceCode] [varchar](255),
		[NewSourceCode] [varchar](255),
		CONSTRAINT [PK_OldCodeNewCodeXrefID] PRIMARY KEY  NONCLUSTERED 
		(
			[ID]
		)  ON [IDX] 
		) ON [PRIMARY]


/* Add OldCode NewCode Xref records */
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('NDS01', 'NDS01')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('NDS-01', 'NDS01')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('NDS-02', 'NDS02')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('NDS03', 'NDS03')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('NDS04', 'NDS04')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('NDS06', 'NDS06')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('LETTER', 'LETTER')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('Y', 'Y')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('CJSPIEGEL ', 'SPIEGEL-07')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DA-SPIEGEL', 'SPIEGEL-07')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DA-DD2007', 'DA-DD2007')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DA/NDLM', 'NDLM')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DA/COMM HO', 'CHB')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DA/GRANDVA', 'GRNDVLYMC')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DA/LOWRY', 'DA/LOWRY')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DA/MONTROS', 'MONTROSE')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DA/SAFEWAY', 'SAFEWAY 07')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('SAFEWAY', 'SAFEWAY 07')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('PHONE CALL', 'PHONE CALL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('FREDERIC (', 'FREDERIC 07')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('WPFL', 'WPFL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('WPL0303', 'WPFL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('MM-REGIS', 'MM-REGIS')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BOMOBL', 'BONFIL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BOBLDN', 'BONFIL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BOLOC05', 'BONFIL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BOLOC1', 'BONFIL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BOLOC2', 'BONFIL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BOMGMT', 'BONFIL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BONSHHS', 'BONFIL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BRONCOS DF', 'BBCDFL06')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BRONCOSDFL', 'BBCDFL06')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BODEN', 'BONFIL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BODEN1', 'BONFIL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BODEN2', 'BONFIL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BOHIG1', 'BONFIL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BOHIG2', 'BONFIL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BOHIGH02', 'BONFIL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BBLWRY', 'BONFIL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BOLOW1', 'BONFIL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BOLOWR1', 'BONFIL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BOLOW3', 'BONFIL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BOLOWR3', 'BONFIL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BOLOW05', 'BONFIL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BOLOWO5', 'BONFIL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BOPBLO', 'BONFIL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BOPBL1', 'BONFIL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DAC/BOWCDC', 'DAC/BOWCDC')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BOWES', 'BONFIL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BOWEST', 'BONFIL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BOWES#5WES', 'BONFIL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BOWES5', 'BONFIL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BOWES5 WES', 'BONFIL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('BOWES7', 'BONFIL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DAC-NDS 05', 'DAC-NDS05')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('NDS07', 'NDS 07')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DA/ST ANDR', 'St. Andrews 4/15')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DA-REGISTR', 'DA')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('NEB.ORG.RE', 'DA')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('NO ORGAN/T', 'DA')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DA/OUTSIDE', 'DA-Outside Request')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DA-LC', 'DAC-LC')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DA-COLFAX ', 'Colfax Expo (May 07)')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DIABETES/E', 'DIABETES-EXPO')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DA-FTGF(11', 'DA-FTGF (11/4)')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DA/FROM TH', 'From the Heart (TCH)')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DA-LAMAR R', 'Lamar RD (Aug)')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DA-MADD', '1')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DA/CELEBRA', 'Celebra (6/9)')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DA-CHILD S', 'Child Safety (5/12)')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DA-UWYO', 'UWYO 4/07')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DA-UWYU', 'UWYO 4/07')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DA02', '2')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('NJHF07', 'NJC06')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DAC P/SL ', 'P/SLDD')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('P/SL KEEP', 'P/SLDD')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DA/CURRENT', 'DA-Current HF (3/20)')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DA/VAMEDIC', '15')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DA-NDLM(DO', 'NDLM (Douglas)')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DA/ST ANTH', 'SAC - WPFL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DA-SAC-WPF', 'SAC - WPFL')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('MM03', 'MM04')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('CSU-06', 'CSUNODAC06')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('CSU06/NODA', 'CSUNODAC06')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DA-PCHS 4/', 'PCHS (4/9)')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('CU  Boulde', 'CU BOULDER')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('CU0102', 'CU BOULDER')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('CU-Boulder', 'CU BOULDER')
INSERT INTO _OldCodeNewCodeXref (OldSourceCode, NewSourceCode) VALUES ('DA/CU', 'CU BOULDER')


----------------	
	
PRINT 'Fixing indivual Source Codes in _RegistryXref Table'
/* Fat Fingered Source Codes in Registry Table */
PRINT '... Denver West CDC Incorrect Source Code'

/*  Dever West CDC Incorrect Source Code */
Update _RegistryXref SET SourceCode = 'BODENW'
WHERE ID IN(
10130,
1213
)


PRINT '... Lowry Mobile Team 5 Incorrect Source Code'
/*  Lowry Mobile Team 5 Incorrect Source Code */
Update _RegistryXref SET SourceCode = 'BOLOWO5'
WHERE ID IN(
10597
)


PRINT '... National Donor Sabbath 2001 Incorrect Source Code'
/*  National Donor Sabbath 2001 Incorrect Source Code */
Update _RegistryXref SET SourceCode = 'NDS01'
WHERE ID IN(
774,
777, 
7398, 
1, 
19, 
31, 
60, 
94, 
95, 
97, 
100, 
102, 
145, 
147, 
156, 
159, 
238, 
239, 
240, 
257, 
288, 
698, 
958, 
962, 
976, 
979, 
984, 
986, 
1008, 
1019, 
1388, 
1389, 
1408, 
1499, 
1501, 
1544, 
1545, 
1568, 
1576, 
1597, 
1600, 
1602, 
1604, 
1617, 
1634, 
1635, 
1644, 
1662, 
1666, 
1695, 
1697, 
1716, 
1722, 
1738, 
1739, 
1745, 
1758, 
1765, 
1788, 
1830, 
1879, 
1885, 
1902, 
1951, 
1965, 
1974, 
1985, 
1988, 
1989, 
2007, 
2018, 
2059, 
2074, 
2083, 
2096, 
2133, 
2172, 
2177, 
2201, 
2205, 
2218, 
2276, 
2280, 
2298, 
2304, 
2306, 
2309, 
2317, 
2329, 
2342, 
2355, 
2383, 
2405, 
2416, 
2422, 
2431, 
2441, 
2448, 
2461, 
2463, 
2467, 
2468, 
2487, 
2489, 
2507, 
2510, 
2537, 
2559, 
2592, 
2595, 
2600, 
2606, 
2610, 
2637, 
2677, 
2700, 
2703, 
2711, 
2736, 
2758, 
2796, 
2802, 
2816, 
2835, 
2861, 
2879, 
2880, 
2887, 
2905, 
2914, 
2916, 
2936, 
2948, 
2956, 
2987, 
2989, 
2992, 
2999, 
3004, 
3029, 
3058, 
3062, 
3079, 
3102, 
3114, 
3127, 
3135, 
3136, 
3149, 
3159, 
3168, 
3181, 
3194, 
3219, 
3289, 
3298, 
3299, 
3314, 
3325, 
3336, 
3340, 
3347, 
3356, 
3364, 
3379, 
3390, 
3394, 
3420, 
3432, 
3433, 
3452, 
3453, 
3475, 
3490, 
3499, 
3504, 
3532, 
3557, 
3564, 
3567, 
3585, 
3610, 
3613, 
3621, 
3632, 
3645, 
3659, 
3673, 
3676, 
3686, 
3700, 
3709, 
3714, 
3725, 
3735, 
3749, 
3751, 
3776, 
3779, 
3781, 
3792, 
3831, 
3853, 
3859, 
3861, 
3867, 
3882, 
3907, 
3973, 
3993, 
4013, 
4017, 
4023, 
4042, 
4053, 
4055, 
4056, 
4067, 
4069, 
4070, 
4114, 
4137, 
4403, 
4404, 
4405, 
4481, 
4518, 
4571, 
4845, 
4928, 
4929, 
4978, 
4993, 
5020, 
5075, 
5097, 
5144, 
5180, 
5211, 
5218, 
5219, 
5242, 
5255, 
5265, 
5271, 
5286, 
5289, 
5302, 
5325, 
5331, 
5338, 
5342, 
5351, 
5356, 
5369, 
5373, 
5377, 
5383, 
5397, 
5461, 
5467, 
5470, 
5481, 
5484, 
5487, 
5510, 
5529, 
5537, 
5545, 
5567, 
5608, 
5609, 
5612, 
5619, 
5645, 
5648, 
5665, 
5675, 
5682, 
5684, 
5692, 
5696, 
5698, 
5700, 
5713, 
5718, 
5732, 
5746, 
5752, 
5776, 
5805, 
5815, 
5818, 
5827, 
5829, 
5851, 
5852, 
5854, 
5860, 
5869, 
5870, 
5871, 
5876, 
5884, 
5887, 
5888, 
5893, 
5913, 
5922, 
5930, 
5937, 
5963, 
5965, 
5970, 
6000, 
6010, 
6020, 
6036, 
6045, 
6092, 
6093, 
6101, 
6118, 
6119, 
6131, 
6137, 
6142, 
6152, 
6188, 
6203, 
6209, 
6215, 
6219, 
6235, 
6249, 
6265, 
6267, 
6268, 
6279, 
6323, 
6330, 
6342, 
6347, 
6354, 
6374, 
6376, 
6377, 
6380, 
6383, 
6392, 
6407, 
6434, 
6448, 
6504, 
6505, 
6506, 
6508, 
6518, 
6530, 
6590, 
6596, 
6601, 
6604, 
6618, 
6619, 
6633, 
6664, 
6669, 
6674, 
6706, 
6813, 
6822, 
6825, 
6849, 
6850, 
6880, 
6882, 
6890, 
6891, 
6926, 
6931, 
6933, 
6946, 
6949, 
6969, 
6979, 
6998, 
7016, 
7027, 
7034, 
7043, 
7045, 
7072, 
7090, 
7105, 
7137, 
7149, 
7150, 
7167, 
7168, 
7195, 
7215, 
7258, 
7265, 
7295, 
7346, 
7353, 
7361, 
7373, 
7374, 
7388, 
7435, 
7444, 
7475, 
7484, 
7528, 
7531, 
7554, 
7573, 
7588, 
7596, 
7602, 
7607, 
7611, 
7653, 
7659, 
7691, 
7706, 
7740, 
7759, 
7771, 
7780, 
7783, 
7809, 
7827, 
7830, 
7835, 
7842, 
7871, 
7887, 
7901, 
7919, 
7977, 
7988, 
8015, 
8022, 
8036, 
8039, 
8044, 
8045, 
8065, 
8066, 
8070, 
8071, 
8077, 
8084, 
8121, 
8146, 
8178, 
8209, 
8210, 
8211, 
12521, 
12522, 
12523, 
3, 
2601)


PRINT '... National Donor Sabbath 2002 Incorrect Source Code'
/*  National Donor Sabbath 2002 Incorrect Source Code */
Update _RegistryXref SET SourceCode = 'NDS02'
WHERE ID IN(
144, 
205, 
206, 
207, 
645, 
646, 
707, 
714, 
717, 
939, 
940, 
941, 
75, 
139, 
140, 
146, 
148, 
149, 
150, 
152, 
153, 
155, 
169, 
170, 
171, 
172, 
174, 
175, 
180, 
181, 
209, 
211, 
230, 
231, 
232, 
234, 
235, 
236, 
237, 
241, 
242, 
243, 
244, 
245, 
246, 
247, 
248, 
249, 
250, 
251, 
253, 
254, 
255, 
256, 
258, 
261, 
262, 
263, 
264, 
265, 
266, 
293, 
294, 
295, 
296, 
298, 
299, 
300, 
302, 
303, 
304, 
305, 
306, 
307, 
308, 
309, 
310, 
311, 
312, 
313, 
314, 
315, 
316, 
317, 
318, 
319, 
320, 
321, 
322, 
323, 
324, 
325, 
326, 
327, 
328, 
329, 
330, 
331, 
332, 
333, 
334, 
335, 
336, 
337, 
338, 
339, 
340, 
341, 
342, 
343, 
344, 
345, 
346, 
347, 
348, 
349, 
350, 
351, 
352, 
353, 
354, 
355, 
356, 
358, 
359, 
360, 
361, 
362, 
363, 
364, 
365, 
366, 
367, 
368, 
369, 
370, 
371, 
372, 
375, 
376, 
377, 
382, 
383, 
384, 
385, 
402, 
408, 
412, 
413, 
414, 
415, 
416, 
417, 
418, 
419, 
420, 
421, 
422, 
423, 
424, 
425, 
426, 
443, 
444, 
445, 
488, 
533, 
1404, 
1442, 
1908, 
2643, 
6283, 
6438, 
6935, 
7036, 
7272, 
7283, 
7550, 
7776, 
8196, 
8201, 
8216, 
8218, 
8220, 
8270, 
8276)


PRINT '... National Donor Sabbath 2006 Incorrect Source Code'
/*  National Donor Sabbath 2002 Incorrect Source Code */
Update _RegistryXref SET SourceCode = 'NDS06'
WHERE ID IN(
19102,
19225,
19356,
19137
)


PRINT '... Regis University Registry Drive 2006 Incorrect Source Code'

/*  Regis University Registry Drive 2006 Incorrect Source Code */
Update _RegistryXref SET SourceCode = 'REGIS06'
WHERE ID IN(
16126,
16127,
16128,
16129,
16130,
16131,
16132,
16133,
16134,
16135,
16136,
16137,
16138,
16139,
16140,
16141,
16142
)


PRINT '... St. Andrews United Methodist Church Registry Drive Incorrect Source Code'

/*  St. Andrews United Methodist Church Registry Drive Incorrect Source Code */
Update _RegistryXref SET SourceCode = 'DA/ST ANDR'
WHERE ID IN(
21281
)


PRINT '... VA Medical Center Incorrect Source Code'

/*  VA Medical Center Incorrect Source Code */
Update _RegistryXref SET SourceCode = 'DA/VAMEDIC'
WHERE ID IN(
22206
)


PRINT '... Diabetes Expo'

/*  Diabetes Expo */
Update _RegistryXref SET SourceCode = 'DA-Diabetes Expo 08'
WHERE ID IN(
24540,
24651,
24653,
24654,
24655,
24656,
24658,
24659,
24663,
24657,
24664,
24680,
24652,
24660,
24661,
24662,
24679
)


PRINT '... CJ Spiegel Memorial Golf Tournament'

/*  CJ Spiegel Memorial Golf Tournament  */
Update _RegistryXref SET SourceCode = 'SPIEGEL-07'

WHERE ID IN(
22673, 
18240)



PRINT '... National Donate Life Month'

/*  National Donate Life Month  */
Update _RegistryXref SET SourceCode = 'NDLM'
WHERE ID IN(
21102, 
21428, 
21429, 
21430, 
21432, 
21433, 
21434)


PRINT '... Community Hospital of Boulder'

/*  Community Hospital of Boulder  */
Update _RegistryXref SET SourceCode = 'CHB'
WHERE ID IN(21233)



PRINT '... Grand Valley Medical Center'

/*  Grand Valley Medical Center  */
Update _RegistryXref SET SourceCode = 'GRNDVLYMC'
WHERE ID IN(
20702, 
20703, 
20704)



PRINT '... Lowry Medical Center'

/*  Lowry Medical Center  */
Update _RegistryXref SET SourceCode = 'DA/LOWRY'

WHERE ID IN(
21412, 
21464)



PRINT '... Montrose Main'

/*  Montrose Main  */
Update _RegistryXref SET SourceCode = 'MONTROSE'
WHERE ID IN(
20705)


PRINT '... Safeway Pharmacy'

/*  Safeway Pharmacy  */
Update _RegistryXref SET SourceCode = 'SAFEWAY 07'
WHERE ID IN(
20876, 
20995, 
20997, 
21130, 
21131, 
21132, 
21133, 
21134, 
21135, 
21136, 
21137, 
21138)


PRINT '... PHONE CALL'

/*  PHONE CALL  */
Update _RegistryXref SET SourceCode = 'PHONE CALL'

WHERE ID IN(21937)


PRINT '... Frederic Printing'

/*  Frederic Printing  */
Update _RegistryXref SET SourceCode = 'FREDERIC 07'

WHERE ID IN(
23662, 
23663, 
23664, 
23665, 
23666)


PRINT '... WPFL'

/*  WPFL  */
Update _RegistryXref SET SourceCode = 'WPFL'

WHERE ID IN(
19731, 
8315)


PRINT '... MM-REGIS'

/*  March Madness Regis Univ.  */
Update _RegistryXref SET SourceCode = 'MM-REGIS'
WHERE ID IN(
13003, 
13004, 
13005)




PRINT '-------------------------------------------------------------------------'
PRINT 'New Sub Events'

PRINT '...Denver West CDC'

/* Denver West CDC 
EventCategoryID = 1, EventSubCategoryID = 6 */
Update _RegistryXref SET SourceCode = 'BODENW'
WHERE ID IN(
10130,
1213
)

PRINT '...Regis University Registry Drive 2006'
/* Regis University Registry Drive 2006 
EventCategoryID = 13, EventSubCategoryID = 220 */
Update _RegistryXref SET SourceCode = 'Regis HF 4-19'
WHERE ID IN(
16126,
16127,
16128,
16129,
16130,
16131,
16132,
16133,
16134,
16135,
16136,
16137,
16138,
16139,
16140,
16141,
16142
)


PRINT '...RRocky Mountain Lions Eye Bank'
/* Rocky Mountain Lions Eye Bank
EventCategoryID = 17, EventSubCategoryID = 270 */
Update _RegistryXref SET SourceCode = 'Corneas.org'
WHERE ID IN(
15712,
21312,
22855,
23165
)


PRINT '...University of Colorado Hospital'

/* University of Colorado Hospital
EventCategoryID = 16, EventSubCategoryID = 264 */
Update _RegistryXref SET SourceCode = 'DA-UCH'
WHERE ID IN(
16596,
16597,
16598,
16599,
16600,
16620
)


PRINT '...Diabetes Expo'

/* Diabetes Expo
EventCategoryID = 7, EventSubCategoryID = 238 */
Update _RegistryXref SET SourceCode = 'DIABETES-EXPO'
WHERE ID IN(
24540,
24651,
24653,
24654,
24655,
24656,
24658,
24659,
24663,
24657,
24664,
24680,
24652,
24660,
24661,
24662,
24679
)

PRINT '...National Donor Sabbath 2003'
/* National Donor Sabbath 2003
EventCategoryID = 2, EventSubCategoryID = 326 */
Update _RegistryXref SET SourceCode = 'NDS03'
WHERE ID IN(
10887,
10980,
10981
)

PRINT '...National Donor Sabbath 2004'
/* National Donor Sabbath 2004
EventCategoryID = 2, EventSubCategoryID = 327 */
Update _RegistryXref SET SourceCode = 'NDS04'
WHERE ID IN(12491)

PRINT '...National Donor Sabbath 2006'
/* National Donor Sabbath 2006
EventCategoryID = 2, EventSubCategoryID = 328 */
Update _RegistryXref SET SourceCode = 'NDS06'
WHERE ID IN(
19102,
19225,
19356,
1046,
19076,
19077,
19100,
19101,
19103,
19115,
19142,
19143,
19144,
19145,
19146,
19283,
19372,
19413,
19414,
19415,
19432,
19593,
19594,
20328,
22087,
19137
)


PRINT '...LETTER'
/* Letter
EventCategoryID = 18, EventSubCategoryID = 329 */
Update _RegistryXref SET SourceCode = 'LETTER'
WHERE ID IN(
18014,
18166,
18242,
18272,
18437,
18472,
18497,
18718,
18778,
18854,
18935,
18973,
18974,
19106,
19129,
19366,
19401,
19463,
19476,
19506,
19522,
19658,
19728,
19796,
19857,
19983,
19984,
20178,
20263,
20354,
20398,
20632,
20666,
20667,
21039,
21124,
21160,
21377,
21444,
21466,
21503,
21676,
21740,
21850,
21934,
22063,
22386,
22437,
22853,
22934,
23012,
23076,
23275,
23633,
23672,
23708,
23764
)

PRINT '...LETTER Y'
/* Letter Y
EventCategoryID = 18, EventSubCategoryID = 330 */
Update _RegistryXref SET SourceCode = 'Y'
WHERE ID IN(
20968,
21852,
22122,
22133,
22159,
22196,
22216,
22279,
22281,
22306,
22309,
22502,
22551,
22621,
22688,
22782
)


PRINT '... CJ Speigel'
/* CJ Speigel
EventCategoryID = 6, EventSubCategoryID = 331 */
Update _RegistryXref SET SourceCode = 'SPIEGEL-07'
WHERE ID IN(
22673,
18240
)


PRINT '...Donor Dash 2007'
/* Donor Dash 2007
EventCategoryID = 6, EventSubCategoryID = 332 */
Update _RegistryXref SET SourceCode = 'DA-DD2007'
WHERE ID IN(22322)

PRINT '...Donate Life Month'
/* National Donate Life Month
EventCategoryID = 6, EventSubCategoryID = 333 */
Update _RegistryXref SET SourceCode = 'NDLM'
WHERE ID IN(
21102,
21428,
21429,
21430,
21432,
21433,
21434
)


PRINT '...Hospital of Boulder'
/* Community Hospital of Boulder
EventCategoryID = 16, EventSubCategoryID = 334 */
Update _RegistryXref SET SourceCode = 'CHB'
WHERE ID IN(21233)


PRINT '...Grand Valley Medical Center'
/* Grand Valley Medical Center
EventCategoryID = 16, EventSubCategoryID = 335 */
Update _RegistryXref SET SourceCode = 'GRNDVLYMC'
WHERE ID IN(
20702, 
20703,
20704
)

PRINT '...Lowry Medical Center'
/* Lowry Medical Center 
EventCategoryID = 16, EventSubCategoryID = 336 */
Update _RegistryXref SET SourceCode = 'DA/LOWRY'
WHERE ID IN(
21412,
21464
)


PRINT '...Montrose Main'
/* Montrose Main  
EventCategoryID = 16, EventSubCategoryID = 337 */
Update _RegistryXref SET SourceCode = 'MONTROSE'
WHERE ID IN(20705)

PRINT '...Safeway Pharmacy'
/*  Safeway Pharmacy 
EventCategoryID = 9, EventSubCategoryID = 338 */
Update _RegistryXref SET SourceCode = 'SAFEWAY 07'
WHERE ID IN(
20876, 
20995, 
20997, 
21130, 
21131, 
21132, 
21133, 
21134, 
21135, 
21136, 
21137, 
21138)

PRINT '...PHONE CALL'
/*  PHONE CALL 
EventCategoryID = 18, EventSubCategoryID = 339 */
Update _RegistryXref SET SourceCode = 'PHONE CALL'
WHERE ID IN(21937)

PRINT '...Frederic Printing'
/*  Frederic Printing 
EventCategoryID = 10, EventSubCategoryID = 340 */
Update _RegistryXref SET SourceCode = 'FREDERIC 07'
WHERE ID IN(
23662, 
23663, 
23664, 
23665, 
23666
)

PRINT '...WPFL'
/*  WPFL 
EventCategoryID = 10, EventSubCategoryID = 341 */
Update _RegistryXref SET SourceCode = 'WPFL'
WHERE ID IN(
19731, 
8315)

PRINT '...March Madness Regis Univ.'
/*  March Madness Regis Univ. 
EventCategoryID = 13, EventSubCategoryID = 342 */
Update _RegistryXref SET SourceCode = 'MM-REGIS'
WHERE ID IN(
13003, 
13004, 
13005)

/*** END of Sorce Code Corrections ***/


/* Update Obsolete SourceCodes */ 
PRINT 'Updating Obsolete Source Codes to New Source Code names > _RegistryXref Table'

UPDATE _RegistryXref SET SourceCode = NewSourceCode
FROM _RegistryXref
JOIN _OldCodeNewCodeXref ON _OldCodeNewCodeXref.OldSourceCode = _RegistryXref.SourceCode



/* 2.0 Add values */
PRINT 'Adding table values: EventRegistry'

	INSERT INTO EventRegistry
			(
			RegistryID,
			EventCategoryID,
			EventSubCategoryID,
			EventCategorySpecifyText,
			EventSubCategorySpecifyText,
			LastModified,
			CreateDate
			)


	SELECT 	_RegistryXref.ID AS 'RegistryID',
	EventSubCategory.EventCategoryID,
	EventSubCategory.EventSubCategoryID,
	'' AS 'EventCategorySpecifyText',
	'' AS 'EventSubCategorySpecifyText',
	Null AS 'LastModified',
	GetDate() AS 'CreateDate'
	FROM _RegistryXref
	JOIN EventSubCategory ON EventSubCategory.EventSubCategorySourceCode = _RegistryXref.SourceCode
	LEFT JOIN EventRegistry ON EventRegistry.RegistryID = _RegistryXref.ID
	WHERE IsNull(_RegistryXref.SourceCode,'') <> ''
	AND EventRegistry.RegistryID Is NULL
	

		PRINT 'Row add completed successfully'




/* 3.0 Add Missing Old Source Codes */
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = '_TempOldSourceCodeRegistryID')
	BEGIN
		PRINT 'Dropping Table _TempOldSourceCodeRegistryID'
		DROP  Table _TempOldSourceCodeRegistryID
	END
GO

CREATE TABLE [_TempOldSourceCodeRegistryID] (
	[ID] [int] IDENTITY (1, 1) NOT NULL,
	[RegistryID] [int] NULL 
	CONSTRAINT [PK_TempOldSourceCodeRegistryID] PRIMARY KEY  NONCLUSTERED 
	(
		[ID]
	)  ON [PRIMARY] 
) ON [PRIMARY]


PRINT 'Add Old SourceCodes > _TempOldSourceCodeRegistryID'

INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(17022)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18037)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(19829)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(23769)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3055)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3237)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4984)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4869)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4870)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4871)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4951)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5007)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5008)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5009)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5010)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1829)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2944)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7948)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2917)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3472)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3578)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3600)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3970)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5177)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5956)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6034)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6541)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7824)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8114)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1671)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2775)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2853)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3191)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5179)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6927)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7558)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7904)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7999)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(65)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1881)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1941)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3629)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5987)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6675)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6883)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(108)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1594)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1615)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1860)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1927)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2061)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2163)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2179)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2199)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2344)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2348)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2353)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2498)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2538)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2554)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2704)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2803)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2876)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2931)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3085)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3441)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3573)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3620)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3624)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3785)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3818)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3824)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3835)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3842)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3968)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4024)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4064)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4911)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4944)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4946)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4982)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4991)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5154)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5185)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5199)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5272)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5330)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5345)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5355)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5497)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5589)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5596)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5649)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5672)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5736)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5882)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6185)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6224)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6262)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6489)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6531)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6543)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6573)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6639)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6644)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6645)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6662)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6692)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6735)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6776)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6786)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6799)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6915)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6917)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6984)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7082)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7408)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7559)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7610)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7645)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7683)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7791)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7894)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7913)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7960)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8124)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3569)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6864)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6865)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6866)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6867)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6899)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6900)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6901)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6902)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6903)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6904)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6905)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6906)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6907)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6908)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6909)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6910)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6911)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6912)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6913)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6914)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7227)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7228)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7229)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7230)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7231)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7232)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7233)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7234)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7238)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7239)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2492)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(14815)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(14816)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(14817)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(14818)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(14819)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(14820)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7954)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(965)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3681)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4099)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6765)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6767)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7209)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11110)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(441)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3148)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5695)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5233)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2078)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2530)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5588)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5749)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6066)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6389)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7616)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(28)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1683)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1777)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1821)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2227)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2281)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2400)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2667)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2928)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2937)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3200)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3590)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3649)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3892)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4021)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5152)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5611)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6318)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6774)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1012)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7066)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10677)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10678)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10679)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10680)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10681)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10682)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10683)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(15859)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(15860)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(15861)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(15858)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2875)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4129)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5927)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7028)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7380)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5471)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5678)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(14743)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(14744)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1565)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1693)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2483)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3615)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6096)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6341)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6780)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7414)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1776)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1964)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2136)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2222)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2390)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2436)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2866)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2882)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3156)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3726)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3737)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4977)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5350)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5362)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5432)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6048)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6242)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6263)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7393)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7430)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8040)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1698)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2488)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3261)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4109)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8031)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3518)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3561)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6357)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6938)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7630)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8107)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2094)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2239)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3349)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4058)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4102)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5376)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5685)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6170)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6886)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7004)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7094)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7335)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7431)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7556)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7910)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8027)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(182)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8224)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(14407)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(14408)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(14409)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(14410)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(14434)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1004)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5386)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5459)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7281)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4281)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4282)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4555)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4556)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4557)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4558)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4559)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4585)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4586)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4587)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8230)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(114)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(135)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4132)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4191)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4192)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4443)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4444)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1763)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3739)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4570)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5724)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5734)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7433)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(959)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(960)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1497)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1813)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2236)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3076)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3093)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4019)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4030)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4034)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5462)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5995)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6199)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6589)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6729)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6874)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7403)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8032)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1824)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7108)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7781)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8016)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2077)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(78)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1510)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1511)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2019)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2442)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3094)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3833)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5293)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5387)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5415)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5454)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5564)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5566)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5620)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5957)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6053)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6223)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6600)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7122)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7176)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7178)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7405)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7837)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7970)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(541)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(542)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(543)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(544)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(545)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(546)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(706)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(712)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(48)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(89)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(993)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(995)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(997)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1030)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1031)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1032)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1533)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1534)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1550)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1558)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1607)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1667)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1678)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1679)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1688)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1690)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1725)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1782)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1795)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1845)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1875)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1880)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1882)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1915)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1931)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1932)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1938)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1956)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1960)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1977)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2040)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2100)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2120)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2156)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2161)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2180)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2185)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2186)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2260)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2271)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2278)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2319)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2327)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2399)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2402)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2451)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2457)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2499)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2556)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2585)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2588)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2589)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2616)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2720)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2733)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2771)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2791)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2815)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2819)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2849)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2865)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2878)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2884)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2927)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2934)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2945)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2990)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2993)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2996)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3073)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3088)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3096)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3132)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3137)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3193)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3195)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3206)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3207)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3224)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3230)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3360)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3363)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3371)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3405)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3418)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3501)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3583)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3635)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3641)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3689)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3694)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3710)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3724)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3736)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3759)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3841)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3856)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3878)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3879)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3885)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3975)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3983)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4089)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4113)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4511)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4569)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4576)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4983)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4989)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5137)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5172)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5174)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5243)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5245)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5248)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5253)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5268)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5277)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5315)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5339)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5343)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5366)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5379)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5391)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5455)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5473)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5491)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5523)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5568)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5599)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5615)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5655)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5670)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5680)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5691)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5712)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5726)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5779)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5788)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5807)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5834)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5843)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5960)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5961)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6022)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6023)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6085)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6095)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6107)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6178)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6191)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6213)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6264)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6276)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6293)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6424)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6431)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6433)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6437)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6465)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6491)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6559)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6570)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6574)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6635)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6651)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6656)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6676)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6696)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6758)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6762)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6773)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6793)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6805)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6945)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6954)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6977)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6985)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6997)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7049)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7102)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7135)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7177)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7270)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7328)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7334)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7363)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7368)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7369)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7471)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7485)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7499)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7505)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7515)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7536)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7593)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7619)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7633)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7663)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7702)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7715)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7735)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7764)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7795)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7812)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7862)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7864)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7883)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7884)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8002)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8013)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8053)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8057)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8088)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8095)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8098)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8118)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(74)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1521)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1866)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2012)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2362)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3229)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5311)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6859)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6956)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7291)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7375)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7425)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7941)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(22865)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(23073)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(23074)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(23075)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(23811)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(16890)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(17429)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(16844)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(20265)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18840)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18841)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18842)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18843)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18844)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18909)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18845)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(17890)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(17334)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(17333)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(23238)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18162)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(19105)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(17374)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18667)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18681)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(19709)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18149)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18373)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18374)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(17888)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(17889)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(19475)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18087)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(17512)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(17513)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(17585)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(20576)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(19341)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18295)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(19314)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(19166)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18137)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18163)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18294)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18364)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18966)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(17860)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(19075)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18847)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18848)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18849)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18850)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18851)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18852)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18967)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(19013)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18150)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(16923)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(21410)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(21411)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(20663)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1045)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2391)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2594)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3104)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3296)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3705)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4300)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4301)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4302)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4303)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4304)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4305)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4306)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4307)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4308)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4309)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4310)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4311)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4312)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4313)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4314)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4315)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4316)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4317)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4318)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4319)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4320)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4321)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4347)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4649)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4650)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4651)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4652)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4653)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4654)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4655)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4656)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4674)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4675)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4676)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4677)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4678)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4680)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4681)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4682)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4683)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4684)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4685)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4686)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4687)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4688)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4689)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4690)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4691)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4692)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4693)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4694)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4695)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4696)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4697)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4698)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4699)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4700)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4701)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4702)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4704)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4705)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4706)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4707)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4708)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4709)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4710)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4711)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4712)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4713)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4714)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4715)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4716)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4717)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4718)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4719)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4720)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4721)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4722)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4723)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4725)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4726)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4727)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4728)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4729)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4730)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4731)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4732)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4733)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4734)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4735)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4736)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4738)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4739)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4740)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4741)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4742)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4743)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4744)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4745)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4746)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4747)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4748)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4749)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4750)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4752)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4753)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4754)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4755)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4756)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4757)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4758)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4759)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4760)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4761)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4762)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4763)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4767)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4770)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4771)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4772)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4773)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4774)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4775)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4776)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4777)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4778)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4780)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4781)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4782)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4783)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4784)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4785)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4786)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4788)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4789)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4790)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4791)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4792)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4793)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4795)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4796)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4797)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4798)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4799)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4800)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4801)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4802)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4803)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4804)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4805)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4806)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4807)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4808)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4813)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4830)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4831)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4832)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4833)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4834)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4835)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4836)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4837)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5951)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6363)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6717)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6840)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7843)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7873)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8005)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(15692)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(16848)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(16930)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(17682)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(17967)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18028)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18511)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18526)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18527)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18536)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18683)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18736)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18737)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18804)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18806)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18910)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18911)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18912)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18946)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(19015)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(19136)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(19507)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(20940)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(21415)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(21418)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(21501)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(21719)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(21738)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(22896)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(23166)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(15103)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(15461)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(16089)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18340)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(21581)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(23011)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18968)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18350)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(21326)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(21417)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(22951)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(23888)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18549)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18228)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18528)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18682)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18227)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11402)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11403)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11404)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(16253)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(15869)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(16718)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1040)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1065)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2005)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2212)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2393)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2514)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2688)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2764)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2922)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2957)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3666)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5708)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5755)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6496)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6658)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6693)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6697)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6745)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7336)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(23460)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(23502)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(23510)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(23562)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(23469)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(23542)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(23851)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7170)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7897)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3275)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10116)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10117)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(106)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(982)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1640)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2079)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2296)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2378)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2490)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3192)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3592)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5781)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5911)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7117)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7817)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(85)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(98)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1543)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1648)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1682)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1831)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1841)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1898)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1903)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1911)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1948)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2182)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2274)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2282)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2372)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2386)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2430)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2555)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2611)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2754)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2828)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2873)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2925)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3018)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3225)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3294)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3327)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3381)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3454)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3510)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3648)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3664)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3734)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3780)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3787)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3896)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4028)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4106)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5411)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5452)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5495)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5509)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5516)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5739)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5791)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5826)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5896)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6003)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6027)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6173)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6225)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6261)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6304)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6398)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6466)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6605)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6885)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6983)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7169)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7189)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7364)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7450)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7621)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7670)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7674)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7678)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7711)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7805)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7833)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7974)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8000)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8011)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8047)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8105)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(46)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(64)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(84)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(981)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(992)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1003)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1526)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1535)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1547)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1548)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1572)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1616)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1685)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1719)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1747)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1749)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1793)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1822)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1828)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1847)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1909)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1929)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1979)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1998)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2016)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2042)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2056)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2112)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2152)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2162)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2173)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2234)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2272)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2349)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2370)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2387)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2433)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2444)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2472)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2476)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2491)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2506)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2528)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2570)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2591)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2623)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2635)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2676)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2679)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2761)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2801)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2839)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2874)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2881)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2906)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2949)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2954)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2980)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2984)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3010)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3081)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3086)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3143)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3173)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3176)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3216)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3220)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3226)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3233)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3243)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3266)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3322)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3331)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3341)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3407)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3410)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3414)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3431)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3457)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3488)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3553)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3556)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3587)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3598)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3616)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3637)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3638)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3675)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3687)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3715)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3744)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3771)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3790)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3797)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3800)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3809)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3819)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3832)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3855)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3871)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3982)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3996)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4010)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4043)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4049)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4086)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4510)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4516)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4908)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4909)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4988)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5132)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5166)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5173)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5202)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5249)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5300)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5305)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5321)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5328)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5332)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5334)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5400)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5434)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5438)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5445)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5475)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5478)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5535)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5538)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5542)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5563)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5580)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5598)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5622)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5650)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5688)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5707)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5741)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5766)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5816)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5831)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5886)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5943)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5950)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5983)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6011)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6013)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6025)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6050)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6062)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6135)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6171)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6172)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6250)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6382)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6402)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6474)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6483)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6527)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6547)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6598)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6617)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6710)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6731)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6772)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6806)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6920)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7003)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7179)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7326)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7333)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7391)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7400)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7422)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7476)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7489)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7511)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7524)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7533)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7537)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7638)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7688)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7689)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7754)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7775)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7792)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7807)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7828)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7876)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7877)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7885)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8014)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8020)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8061)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8113)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(116)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(117)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(118)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(119)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(120)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(121)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(122)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(123)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(124)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(125)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(126)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(127)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(128)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(129)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(130)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(131)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(132)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(133)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8161)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10371)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4211)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4256)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4496)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4497)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4498)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4499)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4500)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4501)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4502)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4503)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4504)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4505)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4506)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4551)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4552)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4553)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4554)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4561)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10840)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1061)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1645)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1893)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1955)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2050)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2091)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2328)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2608)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2779)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3009)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3469)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3523)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3577)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3766)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5138)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5200)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5574)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6331)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6454)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6537)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6642)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6801)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7020)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7047)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7276)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7532)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7983)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2052)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2320)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2617)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2807)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2960)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2968)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3471)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3550)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3760)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3762)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3840)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4036)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4080)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4940)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5395)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5407)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5418)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5522)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5699)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5830)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6079)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6204)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6367)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6698)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6702)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6713)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6846)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6943)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7350)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7523)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7666)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7686)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7690)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7866)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7880)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4220)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4567)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4994)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6958)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8130)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2033)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3593)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3820)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5797)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5899)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6104)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6128)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6872)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2515)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5728)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6300)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6686)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7968)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1784)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3098)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6502)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6514)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6715)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7594)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7924)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10700)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1029)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2660)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2743)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2823)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3160)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3389)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3483)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3976)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5266)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5429)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6035)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6922)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7213)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7545)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7657)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7957)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8089)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(411)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8208)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(12213)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(12583)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3845)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5511)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5902)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6556)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5047)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5048)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5049)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5050)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5051)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8157)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6868)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7196)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7197)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7198)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7199)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7200)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7201)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7202)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7203)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7204)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7205)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7206)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7207)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7208)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7240)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7241)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7242)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7243)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7244)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7245)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7246)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7247)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1539)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1669)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1676)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2325)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3113)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4112)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5312)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5993)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6098)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(16037)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(12181)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2322)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5264)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5801)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5865)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(14942)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11252)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(19236)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10190)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10191)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10192)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10193)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10194)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10195)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10196)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10197)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10220)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(13881)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(13882)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(13883)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(13884)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(13885)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(13886)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(13887)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(13888)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(13889)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11085)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11086)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11087)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(18)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1650)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1687)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1707)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1724)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2035)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2157)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2168)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2195)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2870)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3171)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3172)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3486)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3508)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3754)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3981)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5385)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5512)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5792)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5800)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6041)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6273)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7048)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7161)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7192)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7518)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7699)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7992)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8093)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8132)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10886)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(15121)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2602)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2817)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3778)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3977)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5485)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6275)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6468)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7535)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7891)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7993)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11135)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2001)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3777)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3967)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6368)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6673)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7345)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1876)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5416)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5772)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7315)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7316)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7317)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7318)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7319)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7320)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7321)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7322)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7323)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7324)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7507)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7508)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7509)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1874)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1995)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2142)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2460)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2634)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2648)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2723)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2826)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2904)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3166)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3190)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3368)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3459)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3672)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3717)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3719)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5310)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5644)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5676)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5897)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6212)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6338)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6373)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6535)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7378)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7440)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7512)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7576)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7687)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(271)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(272)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(273)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(275)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(276)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(277)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(278)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(279)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(280)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(281)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(282)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(283)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(284)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(285)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(286)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(287)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(451)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(452)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(453)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(454)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(455)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(456)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(457)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(458)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(459)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(460)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(461)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(462)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(463)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(464)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(465)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(466)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(467)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(468)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(469)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(470)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(471)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(472)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(473)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(474)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(476)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(477)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(478)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(479)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(480)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(481)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(482)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(483)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(484)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(485)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(487)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(489)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(490)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(491)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(492)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(493)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(494)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(495)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(496)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(497)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(498)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(499)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(500)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(501)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(502)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(503)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8274)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2747)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2973)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5241)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5420)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1628)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1742)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1913)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1959)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2006)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2062)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2102)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2209)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2661)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2778)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2930)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2942)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2994)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3123)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3385)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3402)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3671)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3994)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5195)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5361)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5573)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5729)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5783)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5806)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5824)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6049)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6399)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6415)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6607)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7249)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7571)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7727)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7790)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7802)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7818)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7838)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7896)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8126)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(514)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(515)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(517)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(535)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(386)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(562)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(563)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(564)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(565)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(566)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(567)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(610)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(611)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(612)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(613)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(614)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(615)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(616)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(617)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(618)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(621)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(622)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(623)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(624)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(625)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(670)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(671)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(672)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(673)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(674)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(675)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(676)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(677)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(678)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(679)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(680)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(681)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(683)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(695)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(696)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8283)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8284)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8310)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2827)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(63)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(69)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(72)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(998)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1728)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2326)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2360)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2521)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2706)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3078)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3240)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3310)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3538)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4052)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5317)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5616)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5716)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6151)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6420)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7757)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(173)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(387)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(388)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(389)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(390)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(391)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(392)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(393)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8144)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8181)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8182)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8183)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8184)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8185)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8186)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8187)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8188)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8189)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8221)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8238)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8239)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8240)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8241)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8242)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8243)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8244)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8295)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8296)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8297)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8298)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8299)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8300)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8301)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8302)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(379)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(404)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1740)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3443)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5686)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(537)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(538)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(561)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(604)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(627)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(628)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(629)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(630)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(631)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(632)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(656)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(682)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(703)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1169)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8287)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10013)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3948)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3949)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3950)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3951)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3952)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3953)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3954)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3955)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3957)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3958)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3959)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3960)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3961)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3962)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3963)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3987)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3988)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3989)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3990)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3991)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4574)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4899)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4900)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4901)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4902)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4964)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4965)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4966)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4967)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5058)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5104)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5105)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5106)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5107)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5108)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5109)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5110)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5111)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5112)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5113)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5115)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5116)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5117)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5118)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5527)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7056)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1435)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1444)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1446)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1447)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1448)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1449)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1451)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1452)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1453)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1454)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1455)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1456)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1457)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1458)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1459)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1460)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1461)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1462)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1463)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1464)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1465)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1466)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1467)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1468)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1469)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1470)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1471)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1472)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1473)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1474)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1475)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1476)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1477)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1478)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1479)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1480)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1481)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1482)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1483)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1484)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1485)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1486)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1487)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1488)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1489)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1490)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1491)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1492)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1493)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10014)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10015)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10016)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(988)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1513)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1802)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2003)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2404)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2435)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2446)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2647)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5155)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5158)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5186)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6417)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6740)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7015)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7059)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7155)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7462)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7855)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7934)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1035)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1733)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1936)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1945)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2145)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2151)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2975)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3328)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3497)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5237)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5536)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5625)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5793)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5855)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5880)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6677)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6975)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7160)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7460)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7466)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7551)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7798)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7872)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8192)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(13317)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(12056)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(12057)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(13)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1020)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1973)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2092)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2965)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5282)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5828)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6661)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7381)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7397)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7609)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4264)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4265)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4266)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4267)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4268)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4269)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4277)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4278)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4283)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4284)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4285)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4290)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4291)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4292)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4293)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4294)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4295)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4580)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4581)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4582)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4588)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4589)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4590)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4591)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4592)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4593)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4594)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4595)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4596)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4597)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4598)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4599)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4600)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4605)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4606)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4607)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4608)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4609)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4610)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4611)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4612)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4616)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4617)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4618)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4619)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4620)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4621)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4622)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4623)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4641)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4642)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4643)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4644)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4645)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4646)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4647)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4648)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(80)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2043)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4035)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5257)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5546)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5735)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5848)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5966)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6516)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7985)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1593)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1819)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2275)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3134)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3548)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3898)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4932)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5358)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5425)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5539)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5549)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6978)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7293)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7660)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1445)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1524)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1578)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1889)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2910)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3063)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3147)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6162)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7267)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(708)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(709)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(710)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(711)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(835)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5394)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1048)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3489)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3631)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4572)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4765)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6824)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7263)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7716)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(380)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1664)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2125)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2995)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3611)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4463)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4482)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4483)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5056)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5469)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7119)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7340)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8190)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(971)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1595)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2215)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3281)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3477)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5702)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5764)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6832)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7951)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(381)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(166)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(167)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(270)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(396)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(505)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(513)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(548)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(552)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(602)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(839)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(848)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(849)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(850)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(952)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(954)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1011)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1018)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1064)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1068)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1069)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1071)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1072)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1073)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1774)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1775)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1872)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1891)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2068)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2263)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2341)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2366)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2392)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2440)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2453)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2486)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2607)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2738)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2811)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3032)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3182)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3213)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3448)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3563)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3599)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3660)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3695)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4004)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4076)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4098)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4190)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4195)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4275)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4838)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4872)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4945)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5057)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5169)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5170)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5193)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5258)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5299)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5333)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5771)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5850)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6019)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6057)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6182)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6231)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6288)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6565)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6582)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6622)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6630)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6647)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6652)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6744)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6929)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7022)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7032)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7190)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7237)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7327)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7562)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7572)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7737)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7803)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7961)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8043)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8062)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8145)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8153)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8154)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8155)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8167)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8168)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8169)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8170)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8172)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8173)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8191)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8272)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8273)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4375)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4376)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4377)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4378)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4379)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4380)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4381)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4382)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4383)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4196)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4464)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4465)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4466)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4467)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4468)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4469)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4470)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4471)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4472)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4473)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4474)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4475)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6709)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4125)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6252)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6253)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7548)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(56)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1014)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1058)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2116)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2216)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2377)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2529)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2670)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2707)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2856)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3048)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3153)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3264)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3506)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3685)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3868)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4001)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4092)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4514)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5226)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5414)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5442)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5626)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5858)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6195)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6494)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6591)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6768)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7151)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7371)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7454)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11175)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11176)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11177)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11178)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11179)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11180)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11181)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(598)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(797)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(798)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(799)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(805)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(836)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(933)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1406)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7857)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(575)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(577)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(766)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(767)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(768)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(769)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(770)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(771)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(772)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(773)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8048)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11157)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11159)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11160)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11161)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11162)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11163)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11164)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11165)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11166)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11167)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11196)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11390)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3514)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5642)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7307)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7308)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7309)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7310)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7311)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7312)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7313)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7314)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1436)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10011)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10012)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10045)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10097)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(12283)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(21961)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(21962)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(21963)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(21964)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(21965)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(21967)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(21968)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4563)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(34)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5283)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6321)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6657)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7188)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7257)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7661)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6187)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(980)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1015)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1041)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1495)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1570)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1834)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1855)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1943)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1996)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2126)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2289)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2464)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2671)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2722)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2783)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3083)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3111)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3118)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3130)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3202)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3343)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3451)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3456)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3535)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3639)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3654)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3755)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3811)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4018)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4913)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5134)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5196)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5252)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5354)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5433)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5627)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5786)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5878)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5906)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6081)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6229)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6272)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6492)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6536)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6538)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6719)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7035)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7084)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7427)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7432)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7808)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7926)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7984)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(647)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(832)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(833)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1084)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1085)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1086)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1087)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1088)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1089)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1090)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1091)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1092)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1093)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1094)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1095)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1096)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1097)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1098)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1099)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1100)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1101)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1103)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1104)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1105)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1106)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1107)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1108)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1109)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1110)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1111)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1112)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1113)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1114)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1115)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1116)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1117)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1118)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1119)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1120)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1121)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1122)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1127)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1144)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1145)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1146)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1147)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1148)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1149)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1150)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1151)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1152)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1153)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1154)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1155)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1156)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1157)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1158)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1159)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1160)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1161)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1162)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1163)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1164)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1165)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1166)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1167)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1181)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1832)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2385)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3427)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3554)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3862)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3899)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4703)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4737)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4751)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4779)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4787)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6180)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2414)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4995)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5316)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5673)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11569)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11570)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11571)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11572)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11573)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11575)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11576)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11577)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11578)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11579)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11580)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11581)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11582)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11583)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11584)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11585)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11586)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11587)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11588)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11589)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11600)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11601)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11602)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11603)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11604)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11605)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11606)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11608)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11609)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11610)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11611)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11612)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11613)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11614)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11615)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11616)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11617)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11619)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11620)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11621)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11622)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11644)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11645)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(11607)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2855)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3084)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3165)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3249)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3597)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3747)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4046)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4060)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4255)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5392)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5837)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6002)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6233)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6339)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6372)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7255)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7480)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7486)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7595)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7705)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4410)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4411)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4412)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4413)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4414)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4415)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4416)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4417)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4418)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4419)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4420)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4421)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4422)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(16)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(26)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(45)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1054)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1603)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1711)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1729)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1825)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1861)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1942)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2025)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2110)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2183)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2569)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2719)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2788)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2848)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3002)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3075)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3177)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3258)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3268)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3350)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3507)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3830)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4033)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4135)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4188)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4579)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4766)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5181)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5261)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5294)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5318)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5581)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5621)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5697)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6145)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6404)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6579)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6593)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6603)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6612)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6842)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6963)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7287)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7343)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7357)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7490)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7506)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7720)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7782)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7998)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8123)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8131)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(4896)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5024)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5025)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5026)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5027)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5028)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5029)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5030)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5031)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5032)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5033)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5034)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5035)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5037)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3627)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(35)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2249)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3214)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3793)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5590)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5760)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6753)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6833)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7804)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(13866)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(14323)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1727)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2147)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3210)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3279)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3692)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3850)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3893)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6270)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6748)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6851)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7563)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7651)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7836)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8127)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10664)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(536)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(568)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(569)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(570)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(571)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(8281)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1036)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(1646)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2047)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(2675)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(5198)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7860)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3011)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(3305)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6507)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(6646)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(7903)
INSERT INTO _TempOldSourceCodeRegistryID (RegistryID) VALUES(10099)

/* 4.0 Add values */
PRINT 'Adding Old Source Codes > EventRegistry'

	INSERT INTO EventRegistry
			(
			RegistryID,
			EventCategoryID,
			EventSubCategoryID,
			EventCategorySpecifyText,
			EventSubCategorySpecifyText,
			LastModified,
			CreateDate
			)

		SELECT 	_TempOldSourceCodeRegistryID.RegistryID AS 'RegistryID',
			21, -- OldSourceCode
			NULL,
			'' AS 'EventCategorySpecifyText',
			'' AS 'EventSubCategorySpecifyText',
			Null AS 'LastModified',
			GetDate() AS 'CreateDate'
		FROM _TempOldSourceCodeRegistryID
		LEFT JOIN EventRegistry ON EventRegistry.RegistryID = _TempOldSourceCodeRegistryID.RegistryID
		WHERE EventRegistry.RegistryID Is NULL


		PRINT '*** Update Complete ***'
GO
