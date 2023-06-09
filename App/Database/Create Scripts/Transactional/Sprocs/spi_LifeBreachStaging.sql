SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_LifeBreachStaging]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_LifeBreachStaging]
GO


CREATE PROCEDURE spi_LifeBreachStaging  AS
--Searches for referral that do not have a designated approacher



declare @ID int,
	@ApproachedbyID int,
	@ApproachedbyName	varchar(255),
	@approachedbyNameFL	varchar (255),
	@ApproachedbyNameFirst varchar (255),	
	@OrganizationID	int,
	@Count	int,
	@Email 	varchar(255),
	@Items  int,
	@ILoop  int,
	@currentEmail varchar(255),
	@PatientName varchar(255),
	@LastModified datetime,
	@CallID		int,
	@PrevCount	int,
	@ApproachedByArchive  varchar(255)
declare aRef cursor for
	
	
	
	select Referral.ReferralID
	from Referral where referral.LastModified >current_timestamp - '00:15' and referral.Lastmodified< current_timestamp 
	
	open aRef
	fetch next from aRef into @ID
	while @@fetch_status = 0
		begin
			begin transaction Referral

				select   @CallID = referral.CallID,@ApproachedbyID = referral.ReferralapproachedbypersonID, @OrganizationID = referral.ReferralCallerOrganizationID,
					 @PatientName = referral.ReferralDonorName, @LastModified = referral.LastModified
				 
				from Referral
				where referralID = @ID
				--print @approachedbyid
				--print @OrganizationID

				select @ApproachedbyName = person.personlast, @approachedbyNamefirst = person.personfirst
				from person
				where personID = @ApproachedbyID
				--print @approachedbyName

				if right(@approachedbyname,1)<> '*'  and @ApproachedbyID > 0 
					Begin
						select @Count = count(*) 
						from LifeBreachEmail 
						where OrganizationID = @OrganizationID --AND OrganizationLifeBreachEnabled = -1 
						
						
							if @Count >0 
								begin
								set @approachedbyNameFL = @approachedbyName + ',' + @approachedbyNamefirst

								Select @PrevCount = Count(*) from StagingLifeBreachArchive  where ReferralID = @CallID
								--Check to see if Referral is in the Archive Table
									If @PrevCount = 0  
									Begin

										insert into StagingLifeBreach (PersonID,PersonName,BreachedName,EmailAddress,OrganizationID,OrganizationName,ReferralTime,ReferralID,RunTime)	--entered all emails into numbers table of contacts
										select @ApproachedbyID, @approachedbyNameFL,@PatientName,EmailAddress,OrganizationID,OrganizationName,@LastModified,@CallID,CURRENT_TIMESTAMP + Repeatmin - '00:05'
										from LifeBreachEmail
										where organizationID = @OrganizationID


										insert into StagingLifeBreacharchive (PersonID,PersonName,BreachedName,EmailAddress,OrganizationID,OrganizationName,ReferralTime,ReferralID,RunTime)	--entered all emails into numbers table of contacts
										select @ApproachedbyID, @approachedbyNameFL,@PatientName,EmailAddress,OrganizationID,OrganizationName,@LastModified,@CallID,CURRENT_TIMESTAMP + Repeatmin - '00:05'
										from LifeBreachEmail
										where organizationID = @OrganizationID
									end
									--If referral is in the archive table, check to see if the approached by name has changed, if so, then resend the email
									If @PrevCount > 0  
										Begin
											Select @ApproachedbyArchive = PersonName from StagingLifeBreacharchive where ReferralID = @CallID
											
											If @ApproachedByArchive <> @approachedbyNameFL
												Begin
											
													insert into StagingLifeBreach (PersonID,PersonName,BreachedName,EmailAddress,OrganizationID,OrganizationName,ReferralTime,ReferralID,RunTime)	--entered all emails into numbers table of contacts
													select @ApproachedbyID, @approachedbyNameFL,@PatientName,EmailAddress,OrganizationID,OrganizationName,@LastModified,@CallID,CURRENT_TIMESTAMP + Repeatmin - '00:05'
													from LifeBreachEmail
													where organizationID = @OrganizationID


													insert into StagingLifeBreacharchive (PersonID,PersonName,BreachedName,EmailAddress,OrganizationID,OrganizationName,ReferralTime,ReferralID,RunTime)	--entered all emails into numbers table of contacts
													select @ApproachedbyID, @approachedbyNameFL,@PatientName,EmailAddress,OrganizationID,OrganizationName,@LastModified,@CallID,CURRENT_TIMESTAMP + Repeatmin - '00:05'
													from LifeBreachEmail
													where organizationID = @OrganizationID
												End											
										End														 						 
								End
					End
			commit transaction Referral
			fetch next from aRef into @ID
		end
		close aRef
		deallocate aRef
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

