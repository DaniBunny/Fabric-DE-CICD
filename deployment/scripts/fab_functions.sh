#!/bin/bash

source ./scripts/replace_metadata.sh

# Runs a fab command with error handling based on EXIT_ON_ERROR
run_fab_command() {
    local command=$1

    if [ "$EXIT_ON_ERROR" = true ]; then
        set -e  # Exit on error
    else
        set +e  # Continue on error
    fi

    fab -c "${command}"
}

# Checks and perform SPN authentication if enabled
check_spn_auth() {
    if [ "$spn_auth_enabled" == "true" ]; then
        # Use environment variables
        export FAB_CLIENT_ID
        export FAB_CLIENT_SECRET
        export FAB_TENANT_ID

        echo -e "\n_ authentication with spn..."
        run_fab_command "auth login -u $FAB_CLIENT_ID -p $FAB_CLIENT_SECRET --tenant $FAB_TENANT_ID"
        echo "* Done"
    fi
}

# Create a workspace and assign permissions if SPN authentication is enabled
create_workspace() {
    local suffix=$1
    echo -e "\n_ creating a workspace..."
    run_fab_command "create /${_workspace_name} -P capacityName=${capacity_name}"

    if [ "$spn_auth_enabled" == "true" ]; then
        echo -e "\n_ spn deployment; assigning permissions to workspace user..."
        run_fab_command "acl set -f /${_workspace_name} -I $upn_objectid -R admin"
    fi
}

# Import an eventhouse into the workspace
import_eventhouse() {
    local _workspace_name=$1
    local _eventhouse_name=$2
    echo -e "\n_ importing an eventhouse..."
    run_fab_command "import -f /${_workspace_name}/${_eventhouse_name} -i ${staging_dir}/${_eventhouse_name}"
}

# Import a KQL database into the workspace
import_kql_database() {
    local _workspace_name=$1
    local _kql_db_name=$2
    local _eventhouse_id=$3
    replace_kql_database_parent_eventhouse $_kql_db_name $_eventhouse_id
    echo -e "\n_ importing a kql database..."
    run_fab_command "import -f /${_workspace_name}/${_kql_db_name} -i ${staging_dir}/${_kql_db_name}"
}

# Import an eventstream into the workspace
import_eventstream() {
    local _workspace_name=$1
    local _eventstream_name=$2
    local _workspace_id=$3
    local _kql_db_id=$4
    replace_eventstream_destination_kql_database $_eventstream_name $_workspace_id $_kql_db_id
    echo -e "\n_ importing an eventstream..."
    run_fab_command "import -f /${_workspace_name}/${_eventstream_name} -i ${staging_dir}/${_eventstream_name}"
}

# Import a KQL dashboard into the workspace
import_kql_dashboard() {
    local _workspace_name=$1
    local _kql_dh_name=$2
    local _workspace_id=$3
    local _kql_db_id=$4
    local _cluster_uri=$5
    replace_kql_dashboard_datasource $_kql_dh_name $_workspace_id $_kql_db_id $_cluster_uri
    echo -e "\n_ importing a kql dashboard..."
    run_fab_command "import -f /${_workspace_name}/${_kql_dh_name} -i ${staging_dir}/${_kql_dh_name}"
}

# Import a KQL query set into the workspace
import_kql_queryset() {
    local _workspace_name=$1
    local _query_set=$2
    local _kql_db_id=$3
    local _cluster_uri=$4
    replace_kqlqueryset_connection $_query_set $_kql_db_id $_cluster_uri
    echo -e "\n_ importing a kql query set..."
    run_fab_command "import -f /${_workspace_name}/${_query_set} -i ${staging_dir}/${_query_set}"
}

# Import a semantic model into the workspace
import_semantic_model() {
    local _workspace_name=$1
    local _sem_model_name=$2
    echo -e "\n_ importing a semantic model..."
    run_fab_command "import -f /${_workspace_name}/${_sem_model_name} -i ${staging_dir}/${_sem_model_name}"
}

# Import a Power BI report into the workspace
import_powerbi_report() {
    local _workspace_name=$1
    local _report_name=$2
    local _semantic_model_id=$3
    # replace_report_bypath_to_byconnection $_report_name $_semantic_model_id
    echo -e "\n_ importing a powerbi report..."
    run_fab_command "import -f /${_workspace_name}/${_report_name} -i ${staging_dir}/${_report_name}"
}

# Import a pipeline into the workspace
import_pipeline(){
    local _workspace_name=$1
    local _pipeline_name=$2
    local _workspace_id=$3
    local _lakehouse_id=$4
    local _connection_id_blob=$5
    replace_pipeline_metadata $_pipeline_name $_workspace_id $_lakehouse_id $_connection_id_blob
    echo -e "\n_ importing a pipeline..."
    run_fab_command "import -f /${_workspace_name}/${_pipeline_name} -i ${staging_dir}/${_pipeline_name}"
}

# Open a workspace
open_workspace() {
    local _workspace_name=$1
    echo -e "\n_ opening workspace..."
    run_fab_command "open /${_workspace_name}"
}

# Retrieve the value of a specified property from an element
get_fab_property() {
    local element_path=$1
    local property=$2
    local value=$(run_fab_command "get $element_path -q $property" | tr -d '\r')
    while [[ "$value" == "None" || -z "$value" ]]; do
        sleep 5
        local value=$(run_fab_command "get $element_path -q $property" | tr -d '\r')
    done
    echo "$value"
}