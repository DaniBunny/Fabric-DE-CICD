#!/bin/bash

staging_dir="./tmp"

# Replace metadata values in JSON files using jq
replace_json_value() {
    local json_file=$1
    local jq_filter=$2
    jq "$jq_filter" "$json_file" > "$json_file.tmp" && mv "$json_file.tmp" "$json_file"
}

# Replace eventhouse ID in KQL database properties
replace_kql_database_parent_eventhouse() {
    local kql_db_name=$1
    local eventhouse_id=$2
    local _stg_json="$staging_dir/$kql_db_name/DatabaseProperties.json"
    jq --arg _eventhouse_id "$eventhouse_id" \
    '.parentEventhouseItemId = $_eventhouse_id' \
        "$_stg_json" > "$_stg_json.tmp" && mv "$_stg_json.tmp" "$_stg_json"
}

# Replace eventstream metadata with workspace ID and KQL database ID
replace_eventstream_destination_kql_database() {
    local eventstream_name=$1
    local workspace_id=$2
    local kql_db_id=$3
    local _stg_json="$staging_dir/$eventstream_name/eventstream.json"
    jq --arg _workspace_id "$workspace_id" \
    --arg _kql_db_id "$kql_db_id" \
    '.destinations[0].properties.workspaceId = $_workspace_id |
    .destinations[0].properties.itemId = $_kql_db_id' \
    "$_stg_json" > "$_stg_json.tmp" && mv "$_stg_json.tmp" "$_stg_json"
}

# Replace KQL dashboard datasource with workspace ID, KQL database ID, and cluster URI
replace_kql_dashboard_datasource() {
    local kql_dh_name=$1
    local workspace_id=$2
    local kql_db_id=$3
    local cluster_uri=$4
    local _stg_json="$staging_dir/$kql_dh_name/RealTimeDashboard.json"
    jq --arg _workspace_id "$workspace_id" \
    --arg _kql_db_id "$kql_db_id" \
    --arg _cluster_uri "$cluster_uri" \
    '.dataSources[0].database = $_kql_db_id |
    .dataSources[0].clusterUri = $_cluster_uri |
    .dataSources[0].workspace = $_workspace_id' \
    "$_stg_json" > "$_stg_json.tmp" && mv "$_stg_json.tmp" "$_stg_json"
}

# Replace KQL queryset connection string and initial catalog
replace_kqlqueryset_connection() {
    local kql_qs_name=$1
    local kql_db_id=$2
    local cluster_uri=$3
    local _stg_json="$staging_dir/$kql_qs_name/RealTimeQueryset.json"
    jq --arg _kql_db_id "$kql_db_id" \
    --arg _cluster_uri "$cluster_uri" \
    '(.payload.connections[] | select(.connectionString) | .connectionString) = $_cluster_uri |
     (.payload.connections[] | select(.initialCatalog) | .initialCatalog) = $_kql_db_id |
     walk(if type == "string" then gsub("88a7ebfd-4b71-b41d-41ea-8bc0286d907e"; $_kql_db_id) else . end)' \
    "$_stg_json" > "$_stg_json.tmp" && mv "$_stg_json.tmp" "$_stg_json"
}

# Replace dataset reference in report metadata with byConnection
replace_report_bypath_to_byconnection() {
    local report_name=$1
    local semantic_model_id=$2
    local _stg_json="$staging_dir/$report_name/definition.pbir"
    jq --arg _semantic_model_id "$semantic_model_id" \
        '.datasetReference.byPath = null | .datasetReference.byConnection = {
        "connectionString": "Data Source=powerbi://api.powerbi.com/v1.0/myorg/mkdir;Initial Catalog=r3;Integrated Security=ClaimsToken",
        "pbiServiceModelId": null,
        "pbiModelVirtualServerName": "sobe_wowvirtualserver",
        "pbiModelDatabaseName": $_semantic_model_id,
        "name": "EntityDataSource",
        "connectionType": "pbiServiceXmlaStyleLive"
    }' "$_stg_json" > "$_stg_json.tmp" && mv "$_stg_json.tmp" "$_stg_json"
}

# Replace string value in a file
replace_string_value() {
    local semmodel_name=$1
    local path=$2
    local old_string=$3
    local new_string=$4
    local _stg_semmodel_tmdl="$staging_dir/$semmodel_name/$path"
    if sed --version >/dev/null 2>&1; then
        # GNU sed (Linux/WSL)
        sed -i "s|$old_string|$new_string|g" "$_stg_semmodel_tmdl"
    else
        # BSD sed (macOS)
        sed -i '' "s|$old_string|$new_string|g" "$_stg_semmodel_tmdl"
    fi
}

# Replace pipeline metadata with workspace ID, lakehouse ID, and connection ID
replace_pipeline_metadata() {
    local pipeline_name=$1
    local workspace_id=$2
    local lakehouse_id=$3
    local connection_id_blob=$4
    local _stg_pip_json="$staging_dir/$pipeline_name/pipeline-content.json"

    jq --arg _workspace_id "$workspace_id" \
    --arg _lakehouse_id "$lakehouse_id" \
    --arg _connection_id "$connection_id_blob" \
    '.properties.activities[].typeProperties.sink.datasetSettings.linkedService.properties.typeProperties.workspaceId = $_workspace_id |
        .properties.activities[].typeProperties.sink.datasetSettings.linkedService.properties.typeProperties.artifactId = $_lakehouse_id |
        .properties.activities[].typeProperties.source.datasetSettings.externalReferences.connection = $_connection_id' \
        "$_stg_pip_json" > "$_stg_pip_json.tmp" && mv "$_stg_pip_json.tmp" "$_stg_pip_json"
}

# Replace semantic model metadata with lakehouse connection string and ID
replace_semanticmodel_metadata() {
    local sem_model_name=$1
    local lakehouse_conn_string=$2
    local lakehouse_conn_id=$3
    local _stg_tmdl_expressions="$staging_dir/$sem_model_name/definition/expressions.tmdl"
    content=$(cat "$_stg_tmdl_expressions")
    old_string_1="XUO7C7SW7ONUHHLEI7JMT7CN3E-5NMTCG4VCUAELMP2UGNFR7CLCI.datawarehouse.fabric.microsoft.com"
    old_string_2="5ec27d10-f4e8-402c-8707-6c54fe94ef5c"
    content="${content//$old_string_1/$lakehouse_conn_string}"
    content="${content//$old_string_2/$lakehouse_conn_id}"
    echo "$content" > "$_stg_tmdl_expressions"
}

# Replace report metadata with semantic model ID
replace_report_semantic_model() {
    local report_name=$1
    local semantic_model_id=$2
    local _stg_report_json="$staging_dir/$report_name/definition.pbir"
    jq --arg _semantic_model_id "$semantic_model_id" \
    '.datasetReference.byConnection.pbiModelDatabaseName = $_semantic_model_id' \
        "$_stg_report_json" > "$_stg_report_json.tmp" && mv "$_stg_report_json.tmp" "$_stg_report_json"
}

# Replace string value in JSON file
replace_string_value_json() {
    local path=$1
    local old_string=$2
    local new_string=$3
    local _stg_json="$staging_dir/$path"
    [[ -f "$_stg_json" ]] && sed -i '' "s|$old_string|$new_string|g" "$_stg_json"
}
