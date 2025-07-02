-- Clean from node__field_f_p_contact_information
UPDATE `node__field_f_p_contact_information`
SET
    `field_f_p_contact_information_value` = REGEXP_REPLACE (
        `field_f_p_contact_information_value`,
        'href="mailto:[Oo][Nn][Cc][Ll][Ee][Yy]@[Uu][Cc][Aa][Rr]\\.[Ee][Dd][Uu]"',
        ''
    )
WHERE
    `field_f_p_contact_information_value` REGEXP 'href="mailto:[Oo][Nn][Cc][Ll][Ee][Yy]@[Uu][Cc][Aa][Rr]\\.[Ee][Dd][Uu]"';

-- Clean from node__field_sidebar_content_body
UPDATE `node__field_sidebar_content_body`
SET
    `field_sidebar_content_body_value` = REGEXP_REPLACE (
        `field_sidebar_content_body_value`,
        'href="mailto:[Oo][Nn][Cc][Ll][Ee][Yy]@[Uu][Cc][Aa][Rr]\\.[Ee][Dd][Uu]"',
        ''
    )
WHERE
    `field_sidebar_content_body_value` REGEXP 'href="mailto:[Oo][Nn][Cc][Ll][Ee][Yy]@[Uu][Cc][Aa][Rr]\\.[Ee][Dd][Uu]"';

-- Rmove string "oncley@ucar.edu"
UPDATE `node__field_f_p_contact_information`
SET
    `field_f_p_contact_information_value` = REGEXP_REPLACE (
        `field_f_p_contact_information_value`,
        '[Oo][Nn][Cc][Ll][Ee][Yy]@[Uu][Cc][Aa][Rr]\\.[Ee][Dd][Uu]',
        ''
    )
WHERE
    `field_f_p_contact_information_value` REGEXP '[Oo][Nn][Cc][Ll][Ee][Yy]@[Uu][Cc][Aa][Rr]\\.[Ee][Dd][Uu]';

UPDATE `node__field_sidebar_content_body`
SET
    `field_sidebar_content_body_value` = REGEXP_REPLACE (
        `field_sidebar_content_body_value`,
        '[Oo][Nn][Cc][Ll][Ee][Yy]@[Uu][Cc][Aa][Rr]\\.[Ee][Dd][Uu]',
        ''
    )
WHERE
    `field_sidebar_content_body_value` REGEXP '[Oo][Nn][Cc][Ll][Ee][Yy]@[Uu][Cc][Aa][Rr]\\.[Ee][Dd][Uu]';