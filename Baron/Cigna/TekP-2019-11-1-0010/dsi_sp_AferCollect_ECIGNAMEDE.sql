USE [ULTIPRO_WPBPS]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_AfterCollect_ECIGNAMEDE]    Script Date: 1/27/2020 6:44:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[dsi_sp_AfterCollect_ECIGNAMEDE]
AS
SET NOCOUNT ON;
/************************************************************
Client: Baron Management Services, Inc

Created By: James Bender
Create Date: 12/24/2020
ChangePoint Request Number: TekP-2019-11-1-0010

Purpose: Remove "bad" elements where record ends with Asterisk and Tilde (*~)

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

************************************************************/
BEGIN

	DELETE dbo.U_ECIGNAMEDE_File where LEFT(DATA, 1) = '*'
    --==================================================
    -- Remove Blank Elements Where Row Ends With '*~'
    --==================================================
    WHILE (SELECT COUNT(*) FROM dbo.U_ECIGNAMEDE_File WHERE RIGHT(DATA,2) = '*~') > 0
    BEGIN
        UPDATE dbo.U_ECIGNAMEDE_File SET DATA = REPLACE(DATA,'*~','~') WHERE RIGHT(RTRIM(DATA),2) = '*~';
    END;

    --========================================
    -- Remove Extra Records from PER Segment
    --========================================
    UPDATE dbo.U_ECIGNAMEDE_File SET DATA = REPLACE(DATA,'HP**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%HP**%';
    UPDATE dbo.U_ECIGNAMEDE_File SET DATA = REPLACE(DATA,'WP**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%WP**%';
    UPDATE dbo.U_ECIGNAMEDE_File SET DATA = REPLACE(DATA,'EM**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%EM**%';

    --====================================
    -- Update Record Count in SE Segment
    --====================================
    DECLARE @RecordCount INT;
    SET @RecordCount = (SELECT COUNT(*) FROM dbo.U_ECIGNAMEDE_File WHERE LEFT(Data, CHARINDEX('*',Data) - 1) NOT IN ('ISA','GS','IEA','GE'));

    UPDATE dbo.U_ECIGNAMEDE_File
    SET Data = REPLACE(Data,'9999',@RecordCount)
    WHERE LEFT(Data,2) = 'SE';

END
