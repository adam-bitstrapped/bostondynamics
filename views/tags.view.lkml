# The name of this view in Looker is "Tags"
view: tags {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `sfp_data.tags`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # This field is hidden, which means it will not show up in Explore.
  # If you want this field to be displayed, remove "hidden: yes".

  dimension: d__column {
    hidden: yes
    sql: ${TABLE}.d.column ;;
    group_label: "D"
    group_item_label: "Column"
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: d__data__cell__timestamp {
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
    sql: ${TABLE}.d.data.cell.timestamp ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "D Data Cell Value" in Explore.

  dimension: d__data__cell__value {
    type: string
    sql: ${TABLE}.d.data.cell.value ;;
    group_label: "D Data Cell"
    group_item_label: "Value"
  }

  dimension: rowkey {
    type: string
    sql: ${TABLE}.rowkey ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

# The name of this view in Looker is "Tags D Column"
view: tags__d__column {
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: cell__timestamp {
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
    sql: ${TABLE}.cell.timestamp ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Cell Value" in Explore.

  dimension: cell__value {
    type: string
    sql: ${TABLE}.cell.value ;;
    group_label: "Cell"
    group_item_label: "Value"
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }
}
