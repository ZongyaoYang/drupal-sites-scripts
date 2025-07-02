<?php

/**
 * Usage: php ./db-search.php --pantheon=site.env --terms=diversity,inclusion --tables=paragraph,block
 * All arguments are optional
 *
 * Will output something like:
 *
 * Connecting to database...
 * Searching for 'diversity, accessibility, inclusion, dei'...
 *
 * ========
 * Found 1 in table `media__field_caption`, column `field_caption_value`:
 *
 * <p>CISL Outreach, Diversity, and Education Team</p>
 * ========
 *
 * ========
 * Found 1 in table `menu_tree`, column `id`:
 *
 * simple_sitemap.inclusion
 * ========
 *
 * ========
 * Found 1 in table `node_field_data`, column `title`:
 *
 * WINS honored at SC19 with Workforce Diversity Leadership award
 * ========
 * ...
 * 
 * On 07/02/2025, this script is successful used to search a string on EOL datebase
 * Command line: php ./db_search.php --pantheon=eol-unity.dev --terms=oncley@ucar.edu > eol-dev-oncley.txt
 */

// Database connection settings
// For Pantheon sites, leave this blank and pass the site.env on the command line e.g.
// php ./db-search.php --pantheon=cisl-unity.live
$db_settings = [
    'mysql_host' => '',
    'mysql_port' => '',
    'mysql_username' => '',
    'mysql_password' => '',
    'mysql_database' => '',
];

// Default terms
// Or pass in terms on the command line e.g.
// php ./db-search.php --terms=diversity,inclusion
$search_terms = ['NCAR', 'UCAR'];

// Default to Drupal specific prefixes (always ignores revision tables)
// But you can override with the --tables option
// php ./db-search.php --tables=foo,bar
// php ./db-search.php --tables=all
$include_tables = ['block_', 'book', 'media', 'menu', 'node', 'paragraph', 'path', 'taxonomy_', 'webform'];

$opts = get_options();

if (isset($opts['pantheon'])) {
    $db_settings = get_pantheon_dbinfo($opts['pantheon']);
}

if (isset($opts['terms'])) {
    $search_terms = get_search_terms($opts['terms']);
}

if (isset($opts['tables'])) {
    $include_tables = get_searchable_tables($opts['tables']);
}

try {
    echo "Connecting to database...\n";
    $dsn = "mysql:host={$db_settings['mysql_host']}:{$db_settings['mysql_port']};dbname={$db_settings['mysql_database']};charset=utf8mb4";

    $pdo = new PDO($dsn, $db_settings['mysql_username'], $db_settings['mysql_password']);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $tables_query = $pdo->query("SHOW TABLES");
    $tables = $tables_query->fetchAll(PDO::FETCH_COLUMN);

    echo "Searching for '" . join(', ', $search_terms) . "'...\n\n";
    $count = 0;

    $search_tables = array_filter($tables, function ($item) use ($include_tables) {
        $item = strtolower($item);

        if (count($include_tables) == 1 && $include_tables[0] == 'all') {
            return true;
        }

        if (str_contains($item, 'revision')) {
            return false;
        }

        foreach ($include_tables as $table_prefix) {
            if (str_starts_with($item, $table_prefix)) {
                return true;
            }
        }
        return false;
    });

    $search_regexp = '[[:<:]](' . join('|', $search_terms) . ')[[:>:]]';

    foreach ($search_tables as $table) {
        $columns_query = $pdo->query("DESCRIBE `$table`");
        $columns = $columns_query->fetchAll(PDO::FETCH_ASSOC);

        foreach ($columns as $column) {
            $column_name = $column['Field'];
            $data_type = $column['Type'];

            // Check if column is of text-based type
            if (preg_match('/varchar|text|char|blob/i', $data_type)) {
                // Search the column for the string
                $search_query = $pdo->prepare("SELECT * FROM `$table` WHERE `$column_name` REGEXP :search");
                $search_query->execute([':search' => $search_regexp]);
                $results = $search_query->fetchAll(PDO::FETCH_ASSOC);

                if (!empty($results)) {
                    $num_results = count($results);
                    $count += $num_results;
                    echo "Found $num_results in table `$table`, column `$column_name`:\n";
                    foreach ($results as $row) {
                        echo "\n$row[$column_name]\n========\n";
                    }
                    ;
                }
            }
        }
    }

    echo "Search complete. Found $count instances\n";

} catch (PDOException $e) {
    echo "Error: " . $e->getMessage() . "\n";
}

function get_pantheon_dbinfo(string $site_env): array
{
    if (!str_contains($site_env, '.')) {
        echo "Invalid Pantheon site.env option\n";
        return [];
    }
    $command = "terminus connection:info --format=json --fields=mysql_username,mysql_host,mysql_password,mysql_url,mysql_port,mysql_database -- $site_env";
    $result = shell_exec($command);

    return is_string($result) ? json_decode($result, true) : [];
}

function get_options(): array
{
    $long_opts = [
        'pantheon::',    // Optional value
        'tables::',    // Optional value
        'terms::',    // Optional value
    ];

    return getopt('', $long_opts);
}

function get_searchable_tables(string $tables): array
{
    if (strtolower($tables) == 'all') {
        return ['all'];
    }

    return array_map('trim', explode(',', $tables));
}

function get_search_terms(string $terms): array
{
    return array_map('trim', explode(',', $terms));
}