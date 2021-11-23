SELECT * 
FROM (
SELECT EjhEEID AS YEjhEEID, EjhCOID AS YEjhCOID
					,MAX(SalaryOrHourly) AS SalaryOrHourly 
					,MAX(SalaryOrHourlyDate) AS SalaryOrHourlyDate
					,MAX(FullTimeOrPartTime) AS FullTimeOrPartTime
					,MAX(FullTimeOrPartTimeDate) AS FullTimeOrPartTimeDate
					,MAX(EEType) AS EEType
					,MAX(EETypeDate) AS EETypeDate
					,CASE WHEN ISNULL(MAX(SalaryOrHourlyDate), '1/1/1900') > ISNULL(MAX(FullTimeOrPartTimeDate), '1/1/1900') AND ISNULL(MAX(SalaryOrHourlyDate), '1/1/1900') > ISNULL(MAX(EETypeDate), '1/1/1900') THEN MAX(SalaryOrHourlyDate)
						WHEN ISNULL(MAX(FullTimeOrPartTimeDate), '1/1/1900') > ISNULL(MAX(EETypeDate), '1/1/1900') THEN MAX(FullTimeOrPartTimeDate)
						ELSE MAX(EETypeDate)
					END AS LargestDate
				FROM (
						SELECT A.EjhEEID, A.EjhCOID, 'EjhSalaryOrHourly' AS SalaryOrHourly, MAX(A.EjhJobEffDate) AS SalaryOrHourlyDate, NULL AS FullTimeOrPartTime, NULL AS FullTimeOrPartTimeDate, NULL AS EEType, NULL AS EETypeDate
						FROM EmpHJob A WITH (NOLOCK)
						WHERE A.EjhSalaryOrHourly <>
							(
								SELECT TOP 1 B.EjhSalaryOrHourly
								FROM EmpHJob B
								WHERE A.EjhEEID = B.EjhEEID
									AND A.EjhCOID = B.EjhCOID
									AND A.EjhJobEffDate > B.EjhJobEffDate
								ORDER BY B.EjhJobEffDate DESC
							)
							GROUP BY A.EjhEEID,  A.EjhCoID

						UNION

						SELECT A.EjhEEID, A.EjhCOID, NULL AS SalaryOrHourly, NULL AS SalaryOrHourlyDate, 'EjhFullTimeOrPartTime' AS FullTimeOrPartTime, MAX(A.EjhJobEffDate) AS FullTimeOrPartTimeDate, NULL AS EEType, NULL AS EETypeDate
						FROM EmpHJob A WITH (NOLOCK)
						WHERE A.EjhFullTimeOrPartTime <>
							(
								SELECT TOP 1 B.EjhFullTimeOrPartTime
								FROM EmpHJob B
								WHERE A.EjhEEID = B.EjhEEID
									AND A.EjhCOID = B.EjhCOID
									AND A.EjhJobEffDate > B.EjhJobEffDate
								ORDER BY B.EjhJobEffDate DESC
							)
							GROUP BY A.EjhEEID, A.EjhCOID

						UNION

						SELECT A.EjhEEID, A.EjhCOID, NULL AS SalaryOrHourly, NULL AS SalaryOrHourlyDate, NULL AS FullTimeOrPartTime, NULL AS FullTimeOrPartTimeDate, 'EjhEEType' AS EEType, MAX(A.EjhJobEffDate) AS EETypeDate
						FROM EmpHJob A WITH (NOLOCK)
						WHERE A.EjhEEType <>
							(
								SELECT TOP 1 B.EjhEEType
								FROM EmpHJob B
								WHERE A.EjhEEID = B.EjhEEID
									AND A.EjhCOID = B.EjhCOID
									AND A.EjhJobEffDate > B.EjhJobEffDate
								ORDER BY B.EjhJobEffDate DESC
							)
						GROUP BY A.EjhEEID, A.EjhCOID
				) AS X 
				GROUP BY EjhEEID, EjhCOID) AS Y
	where YEjhEEID = 'DGI35V00S020'