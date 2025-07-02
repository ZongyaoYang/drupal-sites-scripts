<?php

// terminus drush eol-unity.dev -- php:eval '
$nids = \Drupal::entityQuery("node")->accessCheck(FALSE)->execute();
foreach (array_chunk($nids, 3) as $batch) {
    $nodes = \Drupal::entityTypeManager()->getStorage("node")->loadMultiple($batch);
    foreach ($nodes as $node) {
        $updated = FALSE;
        foreach ($node->getFields() as $field_name => $field) {
            if ($field->getFieldDefinition()->getType() === "text_with_summary" || $field->getFieldDefinition()->getType() === "text_long") {
                $value = $field->value;
                if (stripos($value, "mailto:oncley@ucar.edu") !== FALSE) {
                    $value = preg_replace(
                        "#<a[^>]+href=[\"\\\']mailto:oncley@ucar.edu[\"\\\'][^>]*>(.*?)</a>#i",
                        "$1",
                        $value
                    );
                    $field->value = $value;
                    $updated = TRUE;
                }
            }
        }
        if ($updated) {
            $node->save();
            \Drupal::logger("bulk_replace")->info("✅ Removed mailto from node " . $node->id() . ": " . $node->label());
        }
        unset($node);
        gc_collect_cycles();
    }
}
    // '

