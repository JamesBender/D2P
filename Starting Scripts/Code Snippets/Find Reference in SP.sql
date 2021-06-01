SELECT name
FROM   sys.procedures
WHERE  Object_definition(object_id) LIKE '%EdhEffDate%'

SELECT [Scehma]=schema_name(o.schema_id), o.Name, o.type 
FROM sys.sql_modules m
INNER JOIN sys.objects o
ON o.object_id = m.object_id
WHERE m.definition like '%edheffdate%'