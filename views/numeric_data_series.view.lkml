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
    sql: JSON_EXTRACT(${TABLE}.payloadQualifierJson, '$.metadata') ;;
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
    sql: JSON_EXTRACT(${TABLE}.payloadQualifierJson, '$.metadata.gauge-image-base64')
  }

  dimension: base64html {
    type: string
    sql: JSON_EXTRACT(${TABLE}.payloadQualifierJson, '$.metadata.gauge-image-base64')
    html: <img src="data:image/gif;base64,{{value}}" height=200 width=200 />
  }

  dimension: base64html {
    type: string
    sql: '1' ;;
    html: <img src="data:image/gif;base64,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
    " /> ;;
  }

  dimension: message_field {
    type: string
    sql: '1' ;;
    action: {
      label: "Send Spot"
      url:"https://us-central1-bd-spotsmartfactory.cloudfunctions.net/spotApi"
      param:{
        name:"name"
        value:"this is the value"
      }
    }
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
