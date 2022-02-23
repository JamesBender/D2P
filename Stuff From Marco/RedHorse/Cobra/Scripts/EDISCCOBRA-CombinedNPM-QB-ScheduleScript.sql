/****** DIRECTIONS ******
NOTES: This job creation script is specific to the Discovery Benefits Cobra template. It calls dsi_sp_TestSwitchbox_v2 'EDISCCOBRA','NPMFILE' and 'QBFILE'.
       It sets a WEEKLY schedule with a lookback of 6 days to current day (assumes SP is to run at night). If you need this to be different then I suggest
             applying as-is then manually changing in the Job.
       Change values not "variable-ized" below for your purposes at your own risk. Ensure you verify it worked as desired.
       We will try to create this for each SQL template. If it is not available for your needs please reach out to Chris Donovan.

1. Ensure there is not a time conflict (there is a script availble to check the current jobs in the customer's database)
2. Replace the below parameters with the appropriate values
3. Copy and paste script to customer DB. You MUST be in the customer's database for this to work properly.
4. This will create the job in the customer's database and leave as DISABLED. Manually verify the job exists and enable it when desired.

-- Descriptive variables for job/schedule name
@RunDayDescriptive - replace with readable description of the run day for the job name
    Monday, Tuesday, Wednesday, etc.
@RunTimeDescriptive - replace with readable description of the run time for the job name
    11:00pm, 4:52am, etc.

-- Numeric variables for actal job parameters
@24HrRunTime - replace with 24-hour format for actual run time
    2300, 0452, etc.
@DayOfWeekNumeric - replace with appropriate integer value for run day
    1 = Sunday
    2 = Monday
    4 = Tuesday
    8 = Wednesday
    16 = Thursday
    32 = Friday
    64 = Saturday
        (Fun fact, if you want it to run on more than one day just add together all the days.
         For example, if you want it to run on Tuesday (4) and Thursday (16), replace @DayOfWeekNumeric with 20)
*************************/

/***** BEGIN COPY *****/
    BEGIN TRANSACTION;
    DECLARE @ReturnCode INT, @JobName varchar(100), @dbName varchar(50), @JobCommand nvarchar(1000);
    SELECT @ReturnCode = 0;
    SELECT @JobName = RTRIM(REPLACE(DB_NAME(),'ULTIPRO_','')) + ' - Discovery Benefits Cobra Export (EDISCCOBRA) - Weekly, @RunDayDescriptive, @RunTimeDescriptive ET';
    SELECT @dbname = RTRIM(DB_NAME());
    SELECT @JobCommand = N'DECLARE @StartPerControl char(9),
        @EndPerControl char(9),
        @RunDate datetime;

SELECT @StartPerControl = CONVERT(char(8),GETDATE()' + CASE WHEN @24HrRunTime < 1200 THEN '-7' ELSE '-6' END + ',112) + ''1'';
SELECT @EndPerControl = CONVERT(char(8),GETDATE()' + CASE WHEN @24HrRunTime < 1200 THEN '-1' ELSE '' END + ',112) + ''9'';
SELECT @RunDate = GETDATE();

UPDATE dbo.AscExp
SET    expLastStartPerControl = @StartPerControl,
        expStartPerControl = @StartPerControl,
        expLastEndPerControl = @EndPerControl,
        expEndPerControl = @EndPerControl,
        expExported = @RunDate
WHERE expFormatCode = ''EDISCCOBRA''
  AND expExportCode = ''SCHEDULED'';';

    -- Job Params
    IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
    BEGIN
    EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]';
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;

    END

    DECLARE @jobId BINARY(16);
    EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@JobName,
            @enabled=0,
            @notify_level_eventlog=0,
            @notify_level_email=0,
            @notify_level_netsend=0,
            @notify_level_page=0,
            @delete_level=0,
            @description=N'No description available.',
            @category_name=N'[Uncategorized (Local)]',
            @job_id = @jobId OUTPUT;
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;

    -- Step [Run]
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;

    -- Step 'Update AscExp'
    EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Update AscExp Start/End Date (EDISCCOBRA)',
            @step_id=1,
            @cmdexec_success_code=0,
            @on_success_action=3,
            @on_success_step_id=0,
            @on_fail_action=2,
            @on_fail_step_id=0,
            @retry_attempts=0,
            @retry_interval=0,
            @os_run_priority=0, @subsystem=N'TSQL',
            @command=@JobCommand,
            @database_name=@dbName,
            @flags=0;
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;

    -- Step 'Run SP'
    EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Create Combined File (EDISCCOBRA)',
            @step_id=2,
            @cmdexec_success_code=0,
            @on_success_action=1,
            @on_success_step_id=0,
            @on_fail_action=2,
            @on_fail_step_id=0,
            @retry_attempts=0,
            @retry_interval=0,
            @os_run_priority=0, @subsystem=N'TSQL',
            @command=N'EXEC dbo.dsi_sp_TestSwitchbox_v2 ''EDISCCOBRA'', ''SCHEDULED'';',
            @database_name=@dbName,
            @flags=0;
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;
    EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1;
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;
    EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Weekly, @RunDayDescriptive, @RunTimeDescriptive ET',
            @enabled=1,
            @freq_type=8,
            @freq_interval=@DayOfWeekNumeric,
            @freq_subday_type=1,
            @freq_subday_interval=0,
            @freq_relative_interval=0,
            @freq_recurrence_factor=1,
            @active_start_date=20160816,
            @active_end_date=99991231,
            @active_start_time=@24HrRunTime00,
            @active_end_time=235959;
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;
    EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)';
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;
    EXEC msdb..usg_set_job_owner @job_name = @JobName;
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;
    COMMIT TRANSACTION;
    GOTO EndSave;
    QuitWithRollback:
        IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION;
    EndSave:

    GO
    --------END JOB SCRIPT--------
/***** END COPY *****/