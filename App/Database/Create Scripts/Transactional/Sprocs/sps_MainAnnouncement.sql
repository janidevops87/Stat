SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_MainAnnouncement]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_MainAnnouncement]
GO

/***** Object: Stored Procedure dbo.sps_MainAnnouncement  Script Date: 1/19/00 13:30 *****/

CREATE PROCEDURE sps_MainAnnouncement

	@vTodaysDate		smalldatetime		=null

AS

BEGIN
	IF @vTodaysDate is null
		Select @vTodaysDate = GetDate()
END

SELECT Announcement.AnnouncementID,
	Announcement.AnnouncementTitle,
	Announcement.AnnouncementMessage,
	Announcement.AnnouncementStartDate,
	Announcement.AnnouncementEndDate,
	Links.LinksName,
	Links.LinksURL
FROM Announcement LEFT OUTER JOIN Links ON Announcement.AnnouncementID = Links.AnnouncementID
WHERE AnnouncementStartDate <= @vTodaysDate
ORDER BY AnnouncementStartDate DESC










GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

