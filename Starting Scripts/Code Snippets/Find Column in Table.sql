SELECT TableName  = A.Name, 
       ColumnName = B.Name
FROM   syscolumns b,
       sysobjects a
WHERE  a.id = b.id
AND    a.Type = 'U'
AND    b.Name like '%column%' -- enter column name here
ORDER BY A.Name, B.Name