SELECT
    CONCAT (
        'UPDATE `',
        TABLE_NAME,
        '` SET `',
        COLUMN_NAME,
        '` = REPLACE(`',
        COLUMN_NAME,
        '`, ',
        '''steve Oncley'', ''Steve Oncley'') ',
        'WHERE `',
        COLUMN_NAME,
        '` LIKE ''%steve Oncley%'';'
    ) AS update_sql
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_SCHEMA = 'pantheon'
    AND COLUMN_NAME LIKE '%value%';