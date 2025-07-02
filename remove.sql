SELECT
    CONCAT (
        'UPDATE `',
        TABLE_NAME,
        '` SET `',
        COLUMN_NAME,
        '` = REGEXP_REPLACE(`',
        COLUMN_NAME,
        '`, ',
        '\'<a href="mailto:oncley@ucar.edu">([^<]*)</a>\', \'\\1\') ',
        'WHERE `',
        COLUMN_NAME,
        '` LIKE ''%<a href="mailto:oncley@ucar.edu">%'';'
    ) AS update_sql
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_SCHEMA = 'pantheon'
    AND COLUMN_NAME LIKE '%value%';

SELECT
    CONCAT (
        'UPDATE `',
        TABLE_NAME,
        '` SET `',
        COLUMN_NAME,
        '` = REGEXP_REPLACE(`',
        COLUMN_NAME,
        '`, ',
        '''<a\\s+href="mailto:oncley@ucar\\.edu">([^<]*)</a>'', ''\\1'', 1, 0, ''i'') ',
        'WHERE `',
        COLUMN_NAME,
        '` REGEXP ''<a[[:space:]]+href="mailto:oncley@ucar\\.edu"'';'
    ) AS update_sql
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_SCHEMA = 'pantheon'
    AND COLUMN_NAME LIKE '%value%';

SELECT
    CONCAT (
        'UPDATE `',
        TABLE_NAME,
        '` SET `',
        COLUMN_NAME,
        '` = REGEXP_REPLACE(`',
        COLUMN_NAME,
        '`, ',
        '''<a[[:space:]]+href="mailto:[Oo][Nn][Cc][Ll][Ee][Yy]@[Uu][Cc][Aa][Rr]\\.[Ee][Dd][Uu]">([^<]*)</a>'', ''\\1'') ',
        'WHERE `',
        COLUMN_NAME,
        '` REGEXP ''<a[[:space:]]+href="mailto:[Oo][Nn][Cc][Ll][Ee][Yy]@[Uu][Cc][Aa][Rr]\\.[Ee][Dd][Uu]"'';'
    ) AS update_sql
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_SCHEMA = 'pantheon'
    AND COLUMN_NAME LIKE '%value%';

SELECT
    CONCAT (
        'UPDATE `',
        table_name,
        '` SET `',
        column_name,
        '` = REPLACE(`',
        column_name,
        '`, ',
        '"Steve Oncley", ',
        '"steve Oncley") WHERE `',
        column_name,
        '` LIKE "%Steve Oncley%";'
    ) AS update_sql
FROM
    information_schema.columns
WHERE
    table_schema = DATABASE ()
    AND data_type IN ('text', 'longtext', 'mediumtext', 'varchar');

SELECT
    CONCAT (
        'UPDATE `',
        TABLE_NAME,
        '` SET `',
        COLUMN_NAME,
        '` = REGEXP_REPLACE(`',
        COLUMN_NAME,
        '`, ',
        '''<a[[:space:]]+href="mailto:[Oo][Nn][Cc][Ll][Ee][Yy]@[Uu][Cc][Aa][Rr]\\.[Ee][Dd][Uu]">([^<]*)</a>'', ''\\1'') ',
        'WHERE `',
        COLUMN_NAME,
        '` REGEXP ''<a[[:space:]]+href="mailto:[Oo][Nn][Cc][Ll][Ee][Yy]@[Uu][Cc][Aa][Rr]\\.[Ee][Dd][Uu]"'';'
    ) AS update_sql
FROM
    information_schema.columns
WHERE
    table_schema = DATABASE ()
    AND data_type IN ('text', 'longtext', 'mediumtext', 'varchar');

SELECT
    CONCAT (
        'UPDATE `',
        TABLE_NAME,
        '` SET `',
        COLUMN_NAME,
        '` = REGEXP_REPLACE(`',
        COLUMN_NAME,
        '`, ',
        '\'<a href="mailto:Oncley@UCAR.edu">([^<]*)</a>\', \'\\1\') ',
        'WHERE `',
        COLUMN_NAME,
        '` LIKE ''%<a href="mailto:oncley@ucar.edu">%'';'
    ) AS update_sql
FROM
    information_schema.columns
WHERE
    table_schema = DATABASE ()
    AND data_type IN ('text', 'longtext', 'mediumtext', 'varchar');

