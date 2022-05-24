# Define the database connection to be used for this model.
connection: "bd-spotsmartfactory"

# include all the views
include: "/views/**/*.view"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: bd_spotsmartfactory_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: bd_spotsmartfactory_default_datagroup

# Explores allow you to join together different views (database tables) based on the
# relationships between fields. By joining a view into an Explore, you make those
# fields available to users for data analysis.
# Explores should be purpose-built for specific use cases.

# To see the Explore you’re building, navigate to the Explore menu and select an Explore under "Bd Spotsmartfactory"

explore: continuous_data_series {
  join: continuous_data_series__meta_kv {
    view_label: "Continuous Data Series: Metakv"
    sql: LEFT JOIN UNNEST(${continuous_data_series.meta_kv}) as continuous_data_series__meta_kv ;;
    relationship: one_to_many
  }

  join: continuous_data_series__payload_kv {
    view_label: "Continuous Data Series: Payloadkv"
    sql: LEFT JOIN UNNEST(${continuous_data_series.payload_kv}) as continuous_data_series__payload_kv ;;
    relationship: one_to_many
  }

  join: continuous_data_series__payload_qualifier_kv {
    view_label: "Continuous Data Series: Payloadqualifierkv"
    sql: LEFT JOIN UNNEST(${continuous_data_series.payload_qualifier_kv}) as continuous_data_series__payload_qualifier_kv ;;
    relationship: one_to_many
  }
}

explore: component_data_series {
  join: component_data_series__meta_kv {
    view_label: "Component Data Series: Metakv"
    sql: LEFT JOIN UNNEST(${component_data_series.meta_kv}) as component_data_series__meta_kv ;;
    relationship: one_to_many
  }

  join: component_data_series__payload_kv {
    view_label: "Component Data Series: Payloadkv"
    sql: LEFT JOIN UNNEST(${component_data_series.payload_kv}) as component_data_series__payload_kv ;;
    relationship: one_to_many
  }

  join: component_data_series__payload_qualifier_kv {
    view_label: "Component Data Series: Payloadqualifierkv"
    sql: LEFT JOIN UNNEST(${component_data_series.payload_qualifier_kv}) as component_data_series__payload_qualifier_kv ;;
    relationship: one_to_many
  }
}

explore: numeric_data_series {
  sql_always_where: ${event_timestamp_year} > 2021 ;;
  join: numeric_data_series__meta_kv {
    view_label: "Numeric Data Series: Metakv"
    sql: LEFT JOIN UNNEST(${numeric_data_series.meta_kv}) as numeric_data_series__meta_kv ;;
    relationship: one_to_many
  }

  join: numeric_data_series__payload_kv {
    view_label: "Numeric Data Series: Payloadkv"
    sql: LEFT JOIN UNNEST(${numeric_data_series.payload_kv}) as numeric_data_series__payload_kv ;;
    relationship: one_to_many
  }

  join: numeric_data_series__payload_qualifier_kv {
    view_label: "Numeric Data Series: Payloadqualifierkv"
    sql: LEFT JOIN UNNEST(${numeric_data_series.payload_qualifier_kv}) as numeric_data_series__payload_qualifier_kv ;;
    relationship: one_to_many
  }
}

explore: pipelines {
  join: pipelines__d__column {
    view_label: "Pipelines: D Column"
    sql: LEFT JOIN UNNEST(${pipelines.d__column}) as pipelines__d__column ;;
    relationship: one_to_many
  }
}

# To create more sophisticated Explores that involve multiple views, you can use the join parameter.
# Typically, join parameters require that you define the join type, join relationship, and a sql_on clause.
# Each joined view also needs to define a primary key.

explore: insert_errors {}

explore: operations_dashboard {}

explore: payloads {
  join: payloads__d__column {
    view_label: "Payloads: D Column"
    sql: LEFT JOIN UNNEST(${payloads.d__column}) as payloads__d__column ;;
    relationship: one_to_many
  }
}

explore: tags {
  join: tags__d__column {
    view_label: "Tags: D Column"
    sql: LEFT JOIN UNNEST(${tags.d__column}) as tags__d__column ;;
    relationship: one_to_many
  }
}

explore: discrete_data_series {
  join: discrete_data_series__meta_kv {
    view_label: "Discrete Data Series: Metakv"
    sql: LEFT JOIN UNNEST(${discrete_data_series.meta_kv}) as discrete_data_series__meta_kv ;;
    relationship: one_to_many
  }

  join: discrete_data_series__payload_kv {
    view_label: "Discrete Data Series: Payloadkv"
    sql: LEFT JOIN UNNEST(${discrete_data_series.payload_kv}) as discrete_data_series__payload_kv ;;
    relationship: one_to_many
  }

  join: discrete_data_series__payload_qualifier_kv {
    view_label: "Discrete Data Series: Payloadqualifierkv"
    sql: LEFT JOIN UNNEST(${discrete_data_series.payload_qualifier_kv}) as discrete_data_series__payload_qualifier_kv ;;
    relationship: one_to_many
  }
}

explore: types {
  join: types__d__column {
    view_label: "Types: D Column"
    sql: LEFT JOIN UNNEST(${types.d__column}) as types__d__column ;;
    relationship: one_to_many
  }
}
