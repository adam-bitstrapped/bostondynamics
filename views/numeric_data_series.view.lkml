# The name of this view in Looker is "Numeric Data Series"
view: numeric_data_series {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `sfp_data.NumericDataSeries`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Cloud Tag Name" in Explore.

  dimension: cloud_tag_name {
    type: string
    sql: ${TABLE}.cloudTagName ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: event_timestamp {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.eventTimestamp ;;
  }

  dimension_group: ingest_timestamp {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.ingestTimestamp ;;
  }

  dimension: message_id {
    type: string
    sql: ${TABLE}.messageId ;;
  }

  dimension: meta_json {
    type: string
    sql: ${TABLE}.metaJson ;;
  }

  # This field is hidden, which means it will not show up in Explore.
  # If you want this field to be displayed, remove "hidden: yes".

  dimension: meta_kv {
    hidden: yes
    sql: ${TABLE}.metaKV ;;
  }

  dimension: payload_json {
    type: string
    sql: ${TABLE}.payloadJson ;;
  }

  dimension: payload_kv {
    hidden: yes
    sql: ${TABLE}.payloadKV ;;
  }

  dimension: payload_qualifier_json {
    type: string
    sql: ${TABLE}.payloadQualifierJson ;;
  }

  dimension: metadata {
    type: string
    sql: JSON_EXTRACT(${TABLE}.payloadQualifierJson, '$[0].metadata') ;;
  }

  dimension: dumb_gcs_url {
    type: string
    sql: CONCAT('https://storage.cloud.google.com/',SPLIT(SPLIT(${TABLE}.payloadQualifierJson, 'gauge-image":"')[SAFE_OFFSET(1)],'"')[SAFE_OFFSET(0)]) ;;
  }

  dimension: smart_gcs_url {
    type: string
    sql: TRIM(REPLACE(REPLACE(REPLACE(${dumb_gcs_url},'https://storage.cloud.google.com/https://storage.cloud.google.com/','https://storage.cloud.google.com/'),'https://storage.cloud.google.com/gs://','https://storage.cloud.google.com/'),'https://storage.cloud.google.com/https://storage.googleapis.com/','https://storage.cloud.google.com/')) ;;
  }

  dimension: gcs_image {
    type: string
    sql: ${smart_gcs_url} ;;
    html: <img src="{{value}}" height=200 width=200 /> ;;
  }

  dimension: base64string {
    type: string
    sql: 'iVBORw0KGgoAAAANSUhEUgAAAAQAAAADCAIAAAA7ljmRAAAAGElEQVQIW2P4DwcMDAxAfBvMAhEQMYgcACEHG8ELxtbPAAAAAElFTkSuQmCC' ;;
  }

  dimension: base64html {
    type: string
    sql: '1' ;;
    html: <img src="data:image/jpg;base64, iVBORw0KGgoAAAANSUhEUgAAAAQAAAADCAIAAAA7ljmRAAAAGElEQVQIW2P4DwcMDAxAfBvMAhEQMYgcACEHG8ELxtbPAAAAAElFTkSuQmCC" /> ;;
  }

  dimension: payload_qualifier_kv {
    hidden: yes
    sql: ${TABLE}.payloadQualifierKV ;;
  }

  dimension: tag_definition {
    type: string
    sql: ${TABLE}.tagDefinition ;;
  }

  dimension: tag_name {
    type: string
    sql: ${TABLE}.tagName ;;
  }

  dimension: value {
    type: number
    sql: ${TABLE}.value ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_value {
    type: sum
    sql: ${value} ;;
  }

  measure: average_value {
    type: average
    sql: ${value} ;;
  }

  measure: count {
    type: count
    drill_fields: [tag_name, cloud_tag_name]
  }
}

# The name of this view in Looker is "Numeric Data Series Meta Kv"
view: numeric_data_series__meta_kv {
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Key" in Explore.

  dimension: meta_key {
    type: string
    sql: ${TABLE}.key ;;
  }

  # This field is hidden, which means it will not show up in Explore.
  # If you want this field to be displayed, remove "hidden: yes".

  dimension: numeric_data_series__meta_kv {
    type: string
    hidden: yes
    sql: ${TABLE}.numeric_data_series__meta_kv ;;
  }

  dimension: schema_identifier {
    type: string
    sql: ${TABLE}.schemaIdentifier ;;
  }

  dimension: meta_value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

# The name of this view in Looker is "Numeric Data Series Payload Kv"
view: numeric_data_series__payload_kv {
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Key" in Explore.

  dimension: payload_key {
    type: string
    sql: ${TABLE}.key ;;
  }

  # This field is hidden, which means it will not show up in Explore.
  # If you want this field to be displayed, remove "hidden: yes".

  dimension: numeric_data_series__payload_kv {
    type: string
    hidden: yes
    sql: ${TABLE}.numeric_data_series__payload_kv ;;
  }

  dimension: payload_value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

# The name of this view in Looker is "Numeric Data Series Payload Qualifier Kv"
view: numeric_data_series__payload_qualifier_kv {
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Key" in Explore.

  dimension: playload_qualifier_key {
    type: string
    sql: ${TABLE}.key ;;
  }

  # This field is hidden, which means it will not show up in Explore.
  # If you want this field to be displayed, remove "hidden: yes".

  dimension: numeric_data_series__payload_qualifier_kv {
    type: string
    hidden: yes
    sql: ${TABLE}.numeric_data_series__payload_qualifier_kv ;;
  }

  dimension: playload_qualifier_value {
    type: string
    sql: ${TABLE}.value ;;
  }

  dimension: pq_url {
    type: string
    sql: ${TABLE}.value ;;
    html: <img src="{{value}}" height=200 width=200 /> ;;
  }
}
