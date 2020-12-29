select drvOrganizationName, drvClientOrganizationCode, * from dbo.U_ECIGFSLEXP_drvTbl
where drvEEID = 'DHOH21014030'
--where drvEEID IN ('9U3U8B0000K0','9U3U8C0000K0','9U3UAS00U0K0')
--where drvEEID = '9U3U5R0040K0'
--where drvEEID IN ('DHOH3T000030','DHOH4K000030')

--sp_getEEID 'Amacher' -- DHOH3T000030
--sp_getEEID 'Adelman' -- DHOH4K000030
--sp_getEEID 'Decker' -- 9U3U5R0040K0
--sp_getEEID 'Torgerud' -- 9U3U8B0000K0
--sp_getEEID 'Whipkey' -- 9U3U8C0000K0
--sp_getEEID 'Aagaard' -- 9U3UAS00U0K0
--sp_getEEID 'Adams' -- DHOH21014030

select OrgDesc, * from
OrgLevel WITH (NOLOCK)
WHERE OrgCode = '70'
        --AND OrgLvl = 4