/******************************************************************************
**		File: UserRoles.sql
**		Name: UserRoles
**		Desc: Load data to table UserRoles
**		Auth: Bret Knoll
**		Date: 10/21/2010
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		----------	----------------	---------------------------------------
**		10/21/2010	Bret Knoll			Initial data load
*******************************************************************************/

DECLARE
	@ID INT ,
	@OrganizationID INT,
	@Role nvarchar(100),
	@First nvarchar(100),
	@Last nvarchar(100),
	@WebPersonID INT,
	@RoleID INT
 

DECLARE @UserRoles TABLE
(
	ID INT IDENTITY(1, 1), 
	OrganizationID INT,
	Role nvarchar(100), 
	First nvarchar(100),
	Last nvarchar(100)
	
)


INSERT @UserRoles (OrganizationID, Role, First, Last)
VALUES

(5115, 'LOOP:Referral_Center_Manager', 'April', 'Parish'),
(5115, 'LOOP:Referral_Center_Manager', 'Brian', 'Coulter'),
(5115, 'LOOP:Referral_Center_Coordinator', 'Alicia', 'Bauder'),
(5115, 'LOOP:Referral_Center_Coordinator', 'Anita', 'Strawser'),
(5115, 'LOOP:Referral_Center_Coordinator', 'April', 'Caudill'),
(5115, 'LOOP:Referral_Center_Coordinator', 'Belinda', 'Ehret'),
(5115, 'LOOP:Referral_Center_Coordinator', 'Gloria', 'Demattio'),
(5115, 'LOOP:Referral_Center_Coordinator', 'Jackie', 'Hines'),
(5115, 'LOOP:Referral_Center_Coordinator', 'Jamie', 'Sicilian'),
(5115, 'LOOP:Referral_Center_Coordinator', 'Jennifer', 'Howell'),
(5115, 'LOOP:Referral_Center_Coordinator', 'Jennifer', 'Smith'),
(5115, 'LOOP:Referral_Center_Coordinator', 'Katherine', 'Dillon'),
(5115, 'LOOP:Referral_Center_Coordinator', 'Kyle', 'Hickinbotham'),
(5115, 'LOOP:Referral_Center_Coordinator', 'Kristi', 'Riley'),
(5115, 'LOOP:Referral_Center_Coordinator', 'Luke', 'Allen'),
(5115, 'LOOP:Referral_Center_Coordinator', 'Megan', 'Coleman'),
(5115, 'LOOP:Referral_Center_Coordinator', 'Michael', 'Willis'),
(5115, 'LOOP:Referral_Center_Coordinator', 'Mindy', 'Zoll'),
(5115, 'LOOP:Referral_Center_Coordinator', 'Molly', 'Baer'),
(5115, 'LOOP:Referral_Center_Coordinator', 'Tiffany', 'Sharp'),
(5115, 'LOOP:Referral_Center_Coordinator', 'Ryan', 'Parsley'),
(5115, 'LOOP:Referral_Center_Coordinator', 'Verna', 'Eitel'),

(1100, 'LifeBanc:Supervisor', 'Hannah', 'Magrum*'),
(1100, 'LifeBanc:Supervisor', 'Jackie', 'Rossi*'),
(1100, 'LifeBanc:Supervisor', 'Julie', 'Caldro*'),
(1100, 'LifeBanc:Supervisor', 'Tom', 'Krempa'),
(1100, 'LifeBanc:DRC', 'Alan', 'Berman*'),
(1100, 'LifeBanc:DRC', 'Ashley', 'Stehulak *'),
(1100, 'LifeBanc:DRC', 'Barbara', 'West *'),
(1100, 'LifeBanc:DRC', 'Brandon', 'Willoughby*'),
(1100, 'LifeBanc:DRC', 'Diana', 'Suchy-Davies*'),
(1100, 'LifeBanc:DRC', 'Elizabeth', 'Jackson *'),
(1100, 'LifeBanc:DRC', 'Eric', 'Mojzisik'),
(1100, 'LifeBanc:DRC', 'Gina', 'Santillo*'),
(1100, 'LifeBanc:DRC', 'Hannah', 'Magrum*'), -- Hannah Magrum
(1100, 'LifeBanc:DRC', 'Heather', 'Blair*'),
(1100, 'LifeBanc:DRC', 'Jamie', 'Doyle'),
--(1100, 'LifeBanc:DRC', 'Jennifer', 'Malainy*'),
(1100, 'LifeBanc:DRC', 'Jennifer', 'Palla'),
(1100, 'LifeBanc:DRC', 'Jessica', 'Roman*'),
(1100, 'LifeBanc:DRC', 'Julie', 'Roman *'),
(1100, 'LifeBanc:DRC', 'Kadijah', 'Jackson *'),
(1100, 'LifeBanc:DRC', 'Karen', 'Baer *'),
(1100, 'LifeBanc:DRC', 'Linda', 'Pubal'),
(1100, 'LifeBanc:DRC', 'Lisa', 'Trudick'),
(1100, 'LifeBanc:DRC', 'Lisa', 'Vitale *'),
(1100, 'LifeBanc:DRC', 'Lorraine', 'Pajek'),
(1100, 'LifeBanc:DRC', 'Noelle', 'Misch *'),
(1100, 'LifeBanc:DRC', 'Pamela', 'Carroll*'),
(1100, 'LifeBanc:DRC', 'Sandy', 'Adams*'),
(1100, 'LifeBanc:DRC', 'Sarah', 'Rogers*'),
(1100, 'LifeBanc:DRC', 'Sharon', 'Jones*'),
(1100, 'LifeBanc:DRC', 'Sherrin', 'Nichols *'),
(1100, 'LifeBanc:DRC', 'Steve', 'Sharish'),
--(1100, 'LifeBanc:DRC', 'Valerie', 'Horvath'),
(1100, 'LifeBanc:DRC', 'Vicki', 'McSherry'),

(2257, 'LifeGift:Supervisor', 'Carla', 'Arreola'),
(2257, 'LifeGift:Supervisor', 'Serena', 'Simms'),
(2257, 'LifeGift:Supervisor', 'Jennifer', 'Reynolds'),
-- (2257, 'LifeGift:Supervisor', 'Bronwyn', 'Martin'),
(2257, 'LifeGift:Supervisor', 'Sara', 'Whitton'),
(2257, 'LifeGift:Supervisor', 'Kim', 'Davis'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Andy', 'Bigham (DSS)'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Angela', 'Conley'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Angelic', 'Brown'),
--(2257, 'LifeGift:Donation_Resource_Specialist', 'Britt', 'McKenzie'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Chandria', 'Robertson'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Conrad', 'Olivarez'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Cynthia', 'Fields'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Darryl', 'Chance'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Dawn', 'Brim'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Debi', 'Dalbey'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Debbie', 'Yeomans'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Diananna', 'Deal'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Eddie', 'Reta'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Eva', 'Scott'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Forest', 'Riggs'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Guy', 'McDaniel'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Heather', 'Phillips'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Janice', 'Whaley'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Jennifer', 'Roberson'),
(2257, 'LifeGift:Supervisor', 'Jennifer', 'Roberson'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Jennifer', 'Giordonello'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Jeorganna', 'Despania'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Josie', 'Arratia'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Karen', 'Griffin'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Ken', 'Mireles'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Kitty', 'Ross'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Kristi', 'Rodriguez'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Linda', 'Garza'),
--(2257, 'LifeGift:Donation_Resource_Specialist', 'Lisa', 'Juarez'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Lori', 'Luera'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Mark', 'Roth'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Mauricio', 'Ordonez'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Meoshia', 'Burton'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Mery', 'Andrade'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Neal', 'Hornaday'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Nick', 'Kafarela'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Pam', 'Johnson'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Priscilla', 'Gutierez'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Ron', 'Ehrle'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Roxana', 'Martinez'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Russell', 'Roberts'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Schawnte', 'Williams-Taylor'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Sergio', 'Manzano'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Shanee', 'Stewart'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Sheila', 'Buena'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Syed', 'Ali'),
(2257, 'LifeGift:Donation_Resource_Specialist', 'Veronica', 'Jones'),
-- (2257, 'LifeGift:Donation_Resource_Specialist', 'Virginia', 'Mireles'),

(2309, 'Gift_of_Life_MI:Supervisor', 'Loretta', 'White***'),
(2309, 'Gift_of_Life_MI:Supervisor', 'Dave', 'Gee'),
(2309, 'Gift_of_Life_MI:Supervisor', 'Jeanette', 'Ohm***'),
(2309, 'Gift_of_Life_MI:Supervisor', 'Nikki', 'Arno***'),
(2309, 'Gift_of_Life_MI:Supervisor', 'Susan', 'Shay***'),
(2309, 'Gift_of_Life_MI:Supervisor', 'Marlene', 'Witter***'),
(2309, 'Gift_of_Life_MI:Supervisor', 'Meghan', 'Kovalak***'),
(2309, 'Gift_of_Life_MI:Supervisor', 'Angie', 'Walden***'),
(2309, 'Gift_of_Life_MI:Supervisor', 'Amy', 'Keefe***'),
(2309, 'Gift_of_Life_MI:Supervisor', 'Michelle', 'Babinski***'),

--(2309, 'Gift_of_Life_MI:Coordinator', 'Adam', 'Schmid'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Amy', 'Garrison*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Amy', 'Keefe***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Amy', 'Olszewski***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Angie', 'Carlton*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Angie', 'Walden***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Antony', 'Trost*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Ashley', 'Kloosterman*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Ashley', 'Renkes***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Bill', 'Leeder*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Bill', 'Thompson*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Bob', 'Helm*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Barb', 'Bradley'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Bea', 'Thierry'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Betsy', 'Miner-Swartz'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Burt', 'Mattice***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Carolyn', 'Stoll'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Chris', 'Musico'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Chris', 'Schrecongost*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Christy', 'Marrocco'),
--(2309, 'Gift_of_Life_MI:Coordinator', 'Cindy', 'Jacobs'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Cindy', 'Plumley*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Cindy', 'Zarate*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Corinne', 'Doran*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Cornelia', 'Dunn***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Crystal', 'Peeples*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Cyndy', 'Kirschbaum*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'D''Traie', 'Jarret***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Dan', 'Kurdziel***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Dan', 'Farrell'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Dana', 'LaPointe O''Sullivan***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Danielle', 'Hilderbrand*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Daryl', 'Jensen***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Dave', 'Gee'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Dawn', 'Holt'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Dianna', 'Rogan'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Dona', 'Hopkins***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Doug', 'Butler*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Dusty', 'Dehaven***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Elizabeth', 'Gault'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Eric', 'Beuker*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Erin', 'McGreal-Miller***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Erin', 'Zuck***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Geralyn', 'Lerg*'),
--(2309, 'Gift_of_Life_MI:Coordinator', 'Heather', 'Craley'),
--(2309, 'Gift_of_Life_MI:Coordinator', 'Janette', 'St. Martin'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Janine', 'Loomis***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Jean', 'Frey'),
(2309, 'Gift_of_Life_MI:Schedules', 'Jean', 'Frey'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Jean', 'Jones*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Jeanette', 'Ohm***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Jeff', 'Roepke*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Jenna', 'Davis*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Jennifer', 'Pawson*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Jennifer', 'Schuler-Grimm***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Jessica', 'Lowe***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Joanne', 'Flores Doidge'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Joseph', 'Auker'),
(2309, 'Gift_of_Life_MI:Schedules', 'Joseph', 'Auker'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Josh', 'Angel*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Josie', 'Springer*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Julie', 'DeSantis*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Julie', 'Muncy*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Julie', 'Pfeiffer*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Karen', 'Forier***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Karen', 'Oldenburg*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Karla', 'O''Grady'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Kathleen', 'Hawley*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Kathleen', 'Smith***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Kathy', 'Watkins*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Katrina', 'Tanner'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Kim', 'Baltierra*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Kim', 'Zasa***'),
-- (2309, 'Gift_of_Life_MI:Coordinator', 'Kimberly', 'Gladson'),
--(2309, 'Gift_of_Life_MI:Coordinator', 'Kimberly', 'Jaskula'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Larry', 'Slate'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Lewis', 'Orange*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Leonard', 'Van Maanen***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Lica', 'Fenton***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Lisa', 'Louchart***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Lisa', 'Murphy*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Loretta', 'White***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Lori', 'Kelley***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Lynda', 'Harwood***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Margaret', 'Gansser'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Marie', 'Chappel*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Mark', 'Tudor***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Marlene', 'Witter***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Mary', 'Jackowski'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Mary', 'Mequio***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Mary Pat', 'Butcher***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Meghan', 'Kovalak***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Melanie', 'Juco*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Melody', 'Pehote*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Michelle', 'Babinski***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Michelle', 'Trachsel***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Michael', 'Hagan'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Misty', 'Brock'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Neil', 'Derbyshire'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Nicole', 'Harlan*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Nicole', 'Mossburg*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Nicole', 'Chmielewski***'),
--(2309, 'Gift_of_Life_MI:Coordinator', 'Nikki', 'Lee'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Nilam', 'Patel'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Ole', 'Dalby'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Omar', 'Sukkar***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Pat', 'Sansone***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Patrick', 'Wright*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Patti', 'Taub'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Penny', 'Colthurst***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Randal', 'Markiewicz***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Ranee', 'Caskey'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Rebecca', 'Shore*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Rebecca', 'Williams***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Richard', 'Pietroski'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Rita', 'Erickson***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Robin', 'Lanford'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Sally', 'Pitt-VanBuren'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Sarah', 'Hudson*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Scott', 'McQueer*'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Sheila', 'Alston***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Sheri', 'Sinar*'),
--(2309, 'Gift_of_Life_MI:Coordinator', 'Stacy', 'Romanowski'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Stephanie', 'Sommer***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Susan', 'Shay***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Tami', 'Thomson*'),
--(2309, 'Gift_of_Life_MI:Coordinator', 'Tanya', 'Good'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Terry', 'Kennedy'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Tim', 'Hannah'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Tomica', 'Alexander***'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Tracy', 'Davis- Casey'),
(2309, 'Gift_of_Life_MI:Coordinator', 'Wasim', 'Sawan***'),
(2309, 'Gift_of_Life_MI:Schedules', 'Janine', 'Loomis'),
(2309, 'Gift_of_Life_MI:Schedules', 'Dana', 'LaPointe O''Sullivan***'),

(14019, 'MTF:Supervisor', 'Flo', 'Rosenberg*'),
(14019, 'MTF:Supervisor', 'Stephanie', 'Meister*'),
(14019, 'MTF:Supervisor', 'Pam', 'Hinton**'),
(14019, 'MTF:Supervisor', 'Nichole', 'Mitchell*'),

(14019, 'MTF:Donor_Coordinator', 'Amy', 'Olive*'),
(14019, 'MTF:Donor_Coordinator', 'Andy', 'Bratz*'),
(14019, 'MTF:Donor_Coordinator', 'Bles', 'Nuqui*'),
(14019, 'MTF:Donor_Coordinator', 'Bronwyn', 'Martin*'),
(14019, 'MTF:Donor_Coordinator', 'Cheryl', 'Sharrah'),
(14019, 'MTF:Donor_Coordinator', 'Cynthia', 'Krumins*'),
(14019, 'MTF:Donor_Coordinator', 'Carol', 'Bentley'),
(14019, 'MTF:Donor_Coordinator', 'Deborah', 'Butash*'),
(14019, 'MTF:Donor_Coordinator', 'Ellyn', 'Lentz*'),
(14019, 'MTF:Donor_Coordinator', 'Flo', 'Rosenberg*'),
(14019, 'MTF:Donor_Coordinator', 'Gretchen', 'Perkins*'),
(14019, 'MTF:Donor_Coordinator', 'Jennifer', 'South*'),
(14019, 'MTF:Donor_Coordinator', 'Jessica', 'Robinson*'),
(14019, 'MTF:Donor_Coordinator', 'Jodi', 'Rosendal*'),
(14019, 'MTF:Donor_Coordinator', 'Judy', 'McCullough*'),
(14019, 'MTF:Donor_Coordinator', 'Keith', 'VanKirk*'),
(14019, 'MTF:Donor_Coordinator', 'Kylie', 'Bruce*'),
(14019, 'MTF:Donor_Coordinator', 'Lori', 'Perego*'),
(14019, 'MTF:Donor_Coordinator', 'Maria', 'Kyser'),
(14019, 'MTF:Donor_Coordinator', 'Marian', 'Erickson'),
(14019, 'MTF:Donor_Coordinator', 'Mark', 'Smith*'),
(14019, 'MTF:Donor_Coordinator', 'Mark', 'Smith*'),
(14019, 'MTF:Donor_Coordinator', 'Martha', 'Spears*'),
(14019, 'MTF:Donor_Coordinator', 'Michael', 'Heim*'),
(14019, 'MTF:Donor_Coordinator', 'Monica', 'Heston'),
(14019, 'MTF:Donor_Coordinator', 'Natalie', 'Dover*'),
(14019, 'MTF:Donor_Coordinator', 'Nicholas', 'Steele'),
(14019, 'MTF:Donor_Coordinator', 'Nicholas', 'Steele'),
(14019, 'MTF:Donor_Coordinator', 'Nichole', 'Mitchell*'),
(14019, 'MTF:Donor_Coordinator', 'Nicole', 'Rogers'),
(14019, 'MTF:Donor_Coordinator', 'Pam', 'Hinton**'),
(14019, 'MTF:Donor_Coordinator', 'Shea', 'Cardinale'),
(14019, 'MTF:Donor_Coordinator', 'Stephanie', 'Meister*'),
(14019, 'MTF:Donor_Coordinator', 'Susan', 'Haraway*'),
(14019, 'MTF:Donor_Coordinator', 'Tatyanna', 'Cuevas-Boyd'),
(14019, 'MTF:Donor_Coordinator', 'Teri', 'Dummer*'),
(14019, 'MTF:Donor_Coordinator', 'Timi', 'Pintor*'),


(194, 'SL:Team_Lead-Triage', 'Jennifer', 'Abramson'),
(194, 'SL:OASIS_Coordinator', 'Jennifer', 'Abramson'),
(194, 'SL:Administration-Statline', 'Karen', 'Alexander'),
(194, 'SL:Supervisior', 'Tiffany', 'Alves'),
(194, 'SL:Triage_Coordinator', 'George', 'Arpin'),
(194, 'SL:Administration-Statline', 'Tanvir', 'Ather'),
(194, 'SL:Administration-Statline', 'Steve', 'Barron'),
(194, 'SL:Triage_Coordinator', 'Tracy', 'Berube'),
(194, 'SL:Team_Lead-Triage', 'Joshua', 'Boaz'),
(194, 'SL:Administration-Statline', 'Jessica', 'Bush*'),
(194, 'SL:Administration-Statline', 'Lance', 'Cain'),
(194, 'SL:Triage_Coordinator', 'Julie', 'Calnan'),
(194, 'SL:Administration-Statline', 'Chris', 'Carroll'),
(194, 'SL:Administration-Statline', 'Kyle', 'Cottengim'),
(194, 'SL:Administration-Statline', 'Susan', 'Dabiri'),
(194, 'SL:Administration-Statline', 'Lisa', 'D''Agostino*'),
(194, 'SL:Team_Lead-Triage', 'Monica', 'Daniel-Robertson'),
(194, 'SL:Administration-Statline', 'Theresa', 'Davis'),
(194, 'SL:Supervisior', 'Tori', 'DeGraffe'),
(194, 'SL:Administration-Statline', 'Deidre', 'Ellis*'),
(194, 'SL:Administration-Statline', 'James', 'Gerberich'),
(194, 'SL:Administration-Statline', 'Michelle', 'Gilbert'),
(194, 'SL:Triage_Coordinator', 'Paulette', 'Givens'),
--(194, 'SL:Team_Lead-Triage', 'Daniel', 'Halkett'),
--(194, 'SL:OASIS_Coordinator', 'Daniel', 'Halkett'),
(194, 'SL:Team_Lead-Triage', 'Pam', 'Hardinger'),
(194, 'SL:OASIS_Coordinator', 'Pam', 'Hardinger'),
(194, 'SL:Team_Lead-Triage', 'Pamela', 'Hardinger'),
(194, 'SL:OASIS_Coordinator', 'Pamela', 'Hardinger'),
(194, 'SL:Triage_Coordinator', 'DeLynn', 'Hatfield'),
(194, 'SL:OASIS_Coordinator', 'DeLynn', 'Hatfield'),
(194, 'SL:Administration-Statline', 'Ed', 'Hawkes'),
(194, 'SL:Administration-Statline', 'Jim', 'Hawkins'),
(194, 'SL:Supervisior', 'Raquel', 'Jefferson'),
(194, 'SL:Triage_Coordinator', 'Gregory', 'Jones'),
--(194, 'SL:Triage_Coordinator', 'April', 'Kennedy'),
(194, 'SL:Team_Lead-Triage', 'Alonda', 'Kentris'),
(194, 'SL:OASIS_Coordinator', 'Alonda', 'Kentris'),
(194, 'SL:Administration-Statline', 'Bret', 'Knoll'),
(194, 'SL:Triage_Coordinator', 'Kevin', 'Le'),
(194, 'SL:Triage_Coordinator', 'Stacy', 'Locklair'),
(194, 'SL:Triage_Coordinator', 'Monica', 'Loya'),
(194, 'SL:Triage_Coordinator', 'Darlene', 'Martinez Mejia'),
(194, 'SL:Triage_Coordinator', 'Ricky', 'Morris'),
(194, 'SL:Team_Lead-Triage', 'Lucilia', 'Mundine'),

(194, 'SL:Supervisor', 'Kelly', 'Nakai'),
(194, 'SL:Triage_Super_User', 'Donna', 'Newman'),
(194, 'SL:Administration-Statline', 'Hoang', 'Nguyen'),
(194, 'SL:Administration-Statline', 'Brent', 'Page'),
(194, 'SL:Team_Lead-Triage', 'Raina', 'Paisley'),
(194, 'SL:OASIS_Coordinator', 'Raina', 'Paisley'),
(194, 'SL:Team_Lead-Triage', 'Brandie', 'Parks'),
(194, 'SL:OASIS_Coordinator', 'Brandie', 'Parks'),
(194, 'SL:Team_Lead-Triage', 'Tracey', 'Penner'),
(194, 'SL:OASIS_Coordinator', 'Tracey', 'Penner'),
(194, 'SL:Administration-Statline', 'Edie', 'Petz'),
(194, 'SL:Team_Lead-Triage', 'Donald', 'Reynolds'),
(194, 'SL:Triage_Coordinator', 'Sarah', 'Robbins'),
(194, 'SL:Team_Lead-OASIS', 'Sarah', 'Robbins'),
(194, 'SL:Triage_Coordinator', 'Joseph', 'Roth'),
(194, 'SL:Team_Lead-Triage', 'Sharon', 'Sanfilippo'),
(194, 'SL:Team_Lead-OASIS', 'Sharon', 'Sanfilippo'),
(194, 'SL:Administration-Statline', 'Pamela', 'Scheichenost'),
(194, 'SL:Administration-Statline', 'Julie', 'Scheierman'),
(194, 'SL:Team_Lead-Triage', 'Roger', 'Sequeira'),
(194, 'SL:OASIS_Coordinator', 'Roger', 'Sequeira'),
(194, 'SL:Triage_Coordinator', 'Jaime', 'Sharkey'),
(194, 'SL:Triage_Coordinator', 'Heather', 'Simms'),
(194, 'SL:OASIS_Coordinator', 'Heather', 'Simms'),
(194, 'SL:Administration-Statline', 'David', 'Spahr'),
(194, 'SL:Team_Lead-Triage', 'Andrea', 'Sperr'),
(194, 'SL:OASIS_Coordinator', 'Andrea', 'Sperr'),
(194, 'SL:Team_Lead-Triage', 'Sabrina', 'St. Clair'),
(194, 'SL:Team_Lead-Triage', 'Ryan', 'Wall'),
(194, 'SL:OASIS_Coordinator', 'Ryan', 'Wall'),
(194, 'SL:Administration-Statline', 'Lisa', 'Watkins'),
(194, 'SL:Triage_Coordinator', 'Sarah', 'Weatherford'),
(194, 'SL:Administration-Statline', 'Sara', 'Wells'),
(194, 'SL:Triage_Coordinator', 'Susi', 'Hughes 1'),
(194, 'SL:Triage_Coordinator', 'Lori', 'West'),
(194, 'SL:Triage_Coordinator', 'Damien', 'White'),
(194, 'SL:Team_Lead-OASIS', 'Damien', 'White'),
(194, 'SL:Team_Lead-Triage', 'Debra', 'Woerner'),
(194, 'SL:OASIS_Coordinator', 'Debra', 'Woerner'),
(194, 'SL:Administration-Statline', 'Richard', 'Zinter')

DELETE @UserRoles 
WHERE First IS NULL

--select COUNT(*), OrganizationID from @UserRoles
--group by Organizationid

--select p.OrganizationID, ur.Role, ur.First,ur.Last, p.PersonFirst, p.PersonLast, p.PersonID
--,
--Replace(
--REPLACE(
--replace(
--'(' + CONVERT(VARCHAR, p.OrganizationID) +', ''<role>'', ''<first>'', ''<last>''),', '<first>', P.PersonFirst), '<last>', p.PersonLast), '<role>', role)


--from Person p 
--left outer join @UserRoles ur ON p.OrganizationID  = ur.OrganizationID  and  p.PersonFirst = ur.First  and p.PersonLast = ur.Last
---- join StatEmployee s on p.PersonID = s.PersonID
------ p.PersonFirst like '''' + ur.First + '%'''  and  p.PersonLast like '''' + ur.Last + '%'''
----join Organization o ON ur.OrganizationID = o.OrganizationID
---- left outer join  Person p ON ur.OrganizationID = p.OrganizationID and ur.First like p.PersonFirst and ur.Last like p.PersonLast
--where 
-- p.Inactive = 0
-- AND 
-- --ur.Role LIKE 'SL:Administration-Statline'
----and 
--ur.OrganizationID = 2257

--order by p.OrganizationID, ur.Last, ur.First, p.PersonFirst, p.PersonLast



WHILE EXISTS (SELECT * FROM @UserRoles)
BEGIN
	SELECT 
	TOP 1
	@ID = ID, 
	@OrganizationID = OrganizationID,
	@Role = Role,
	@First = First,
	@Last = Last	
	FROM 
	@UserRoles
	
		SELECT @WebPersonID = WebPerson.WebPersonID 
		FROM WebPerson
		JOIN Person on WebPerson.PersonID = Person.PersonID
		WHERE Person.OrganizationID = @OrganizationID
		AND Person.PersonFirst = @First
		AND Person.PersonLast = @Last
		
		SELECT @RoleID = RoleID 
		FROM Roles
		WHERE RoleName = @Role
	IF NOT EXISTS (
			SELECT * FROM UserRoles 
			JOIN Roles on UserRoles.RoleID = Roles.RoleID
			WHERE UserRoles.RoleID = @RoleID
			AND WebPersonID = @WebPersonID)
	BEGIN
		
		--PRINT 'ADD'

		INSERT UserRoles (WebPersonID,	RoleID,	LastStatEmployeeID,	AuditLogTypeID,	LastModified)
		
		VALUES(@WebPersonID, @RoleID, 45, 1, GETDATE() )
		
	END
	
	DELETE @UserRoles WHERE ID = @ID
END


--SELECT * FROM UserRoles WHERE LastModified > '7/5/2011'