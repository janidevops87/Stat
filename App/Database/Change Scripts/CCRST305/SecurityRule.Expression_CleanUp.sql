
-- Clean Up SecurityRule.Expression

--Capture Data Before/After Update
--SELECT *, LEN(Expression) AS ExpressionLength FROM SecurityRule

-- Loop Through Rows With Extra Spaces (more than one single space in a row)
WHILE EXISTS (SELECT 1 FROM SecurityRule WHERE Expression LIKE ('%  %'))
BEGIN

	-- Remove Extra Spaces
	UPDATE SecurityRule
	SET Expression = REPLACE(Expression, '  ', ' '),
		LastModified = GETDATE()
	WHERE Expression LIKE ('%  %');

END


-- Load FormerEmployees
DROP TABLE IF EXISTS #FormerEmployees;

CREATE TABLE #FormerEmployees (
	RowID				INT IDENTITY(1,1),
	WebPersonUserName	VARCHAR(15) NOT NULL
);

INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('achuckran');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('acolombo');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('aestrella');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('akentris');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('akloeppel');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('aljohnson');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('amartin');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('asandau');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('asandau');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('award');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('award');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('award');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('awatkins');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('awillard');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('baparks');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('bbunch');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('bclarkrussell');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('bcriglargolm');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('bdunn');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('bhaag');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('bzepeda');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('cdethomas');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('cdroegemueller');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('cgreer');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('chartel');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('cneal');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('colivarez2lgh');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('cpadgett');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('cparker');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('cramirez');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('croemhild');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('cromero');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('cstiffler');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('cwood');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('DaCollins');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('dbarcenas');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('dcaro');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('dcooke');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('dcudjo');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('dfaulkner');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('dgarcia');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('dhorner');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('djohn');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('djohn');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('djohn');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('djwhite');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('dlawrence');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('dlwoerner');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('drolniak');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('drreynolds');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('eaustgen');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('ecato');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('ejones');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('ejones');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('eloomis');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('emilym');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('emwaura');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('eraab');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('esenne');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('gfisher');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('goliver');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('hardinpa');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('hclough');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('hhsimms');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('hnguyen');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('hpennington');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('hsiauw');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('jaroth');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('Jbree');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('jcalnan');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('jdexter');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('jhawkins');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('jhickey');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('jhughes');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('jjefferson');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('jkpinkston');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('jlabramson');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('jlbush');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('jlowegolm');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('jmu123oz');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('jsharkey');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('jyounger');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('kathygolm');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('kclark');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('kclark');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('kclark');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('krosslgh');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('lcarr');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('lcity');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('lcoleman');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('lschaefer');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('lshore');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('masmithasp');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('merickson');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('msutherland');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('mswope');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('rapaisley');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('rbellrose');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('rdwall');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('remartin');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('rmorris');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('rpbrown');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('sbrinkman');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('sdabiri');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('sfritz');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('skhughes1');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('smrobbins');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('sostclair');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('sweatherford');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('taberube');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('tanderson');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('testtest');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('tgoggin');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('tharrison');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('vlisser');
INSERT INTO #FormerEmployees (WebPersonUserName) VALUES ('wvarsos');

-- Loop through FormerEmployees
DECLARE @RecordCount		INT = (SELECT COUNT(*) FROM #FormerEmployees);
DECLARE @CurrentRowNum		INT = 1;
DECLARE @ThisFormerEmployee VARCHAR(99);

WHILE @CurrentRowNum <= @RecordCount
BEGIN

	-- Remove FormerEmployees
	SET @ThisFormerEmployee = (SELECT WebPersonUserName FROM #FormerEmployees WHERE RowID = @CurrentRowNum);

	UPDATE SecurityRule SET Expression = Replace(Expression, 'OR I:' + @ThisFormerEmployee, ''), LastModified = GETDATE();
	--SELECT top 1 @ThisFormerEmployee, Replace(Expression, 'OR I:' + @ThisFormerEmployee, '') FROM SecurityRule;

	SET @CurrentRowNum = @CurrentRowNum + 1;

END