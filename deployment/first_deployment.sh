#!/bin/bash

# Data Engineering Workshop first deployment (from template) into user workspace

# default parameters
capacity_name="none"
spn_auth_enabled="false"
upn_objectid=""
username="${USER}"  # Use current user by default

# static, do not change
workspace_name="DEWorkshop"

source ./scripts/utils.sh
parse_args "$@"
# check_spn_auth

run_first_deployment() {

    # import paths 
    _workspace_name="${workspace_name}_${username}.Workspace"
    _lakehouse_bronze_name_no_ext="Lakehouse_Bronze"
    _lakehouse_bronze_name="${_lakehouse_bronze_name_no_ext}.Lakehouse"
    _lakehouse_silver_name_no_ext="Lakehouse_Silver"
    _lakehouse_silver_name="${_lakehouse_silver_name_no_ext}.Lakehouse"
    #_warehouse_name="Warehouse_Gold.Warehouse"
    _environment_name="MyEnv.Environment"
    _notebook_names=("Bronze_Data_Preparation.Notebook" "Transformations.Notebook" "Validations.Notebook")
    #_copyjob_names=("MyLHCopyJob.CopyJob" "MyDWCopyJob.CopyJob")
    _copyjob_names=("MyLHCopyJob.CopyJob" "MyLHCopyJob2.CopyJob")
    _sem_model_name="MySemanticModel.SemanticModel"
    _report_name="MyReport.Report"
    # _connection_adlsgen2_name="${abbreviations["Connection"]}_stfabdemos_adlsgen2_${_workspace_name}.Connection" 
    # _sas_token="sv=2022-11-02&ss=b&srt=co&sp=rlx&se=2026-12-31T18:59:36Z&st=2025-01-31T10:59:36Z&spr=https&sig=aL%2FIOiwz2AEj1fL9tRxH%2B4z%2FyfBl8qJ3KXinfPlaSEM%3D"

    # workspace
    create_staging
    EXIT_ON_ERROR=false
    create_workspace $_workspace_name
    _workspace_id=$(run_fab_command "get /${_workspace_name} -q id" | tr -d '\r')

    echo -e "\n_ assigning capacity..."
    # Assign capacity - replace with your available capacity name
    # Example: run_fab_command "assign .capacities/YourCapacityName.Capacity -W ${_workspace_name}"
    if [ "$capacity_name" != "none" ]; then
       run_fab_command "assign -f .capacities/${capacity_name}.Capacity -W ${_workspace_name}"
    else
       echo "Warning: No capacity specified. Use -c parameter to specify capacity name."
    fi

    # lakehouses
    echo -e "\n_ creating lakehouses..."
    run_fab_command "create /${_workspace_name}/${_lakehouse_bronze_name} -P enableschemas=true"
    run_fab_command "create /${_workspace_name}/${_lakehouse_silver_name} -P enableschemas=true"

    # warehouse
    #echo -e "\n_ creating a warehouse..."
    #run_fab_command "create /${_workspace_name}/${_warehouse_name}"

    # environment
    echo -e "\n_ importing an environment..."
    run_fab_command "import -f /${_workspace_name}/${_environment_name} -i ${staging_dir}/${_environment_name}"

    # metadata
    echo -e "\n_ getting items metadata..."
    _lakehouse_bronze_id=$(get_fab_property "/${_workspace_name}/${_lakehouse_bronze_name}" "id")
    _lakehouse_silver_id=$(get_fab_property "/${_workspace_name}/${_lakehouse_silver_name}" "id")
    _lakehouse_silver_conn_id=$(get_fab_property "/${_workspace_name}/${_lakehouse_silver_name}" "properties.sqlEndpointProperties.id")
    _lakehouse_silver_conn_string=$(get_fab_property "/${_workspace_name}/${_lakehouse_silver_name}" "properties.sqlEndpointProperties.connectionString")
    echo "  - Workspace ID: ${_workspace_id}"
    echo "  - Lakehouse Bronze ID: ${_lakehouse_bronze_id}"
    echo "  - Lakehouse Silver ID: ${_lakehouse_silver_id}"
    echo "  - Lakehouse Silver SQL Endpoint ID: ${_lakehouse_silver_conn_id}"
    echo "  - Lakehouse Silver SQL Endpoint Conn String: ${_lakehouse_silver_conn_string}"
    #_warehouse_id=$(get_fab_property "/${_workspace_name}/${_warehouse_name}" "id")
    #_warehouse_conn_string=$(get_fab_property "/${_workspace_name}/${_warehouse_name}" "properties.connectionString")
    ## _environment_id=$(get_fab_property "/${_workspace_name}/${_environment_name}" "id")
    echo -e "* Done"

    # notebooks
    for _notebook_name in "${_notebook_names[@]}"; do
        echo -e "\n_ importing a notebook..."
        run_fab_command "import -f /${_workspace_name}/${_notebook_name} -i ${staging_dir}/${_notebook_name}"
        run_fab_command "set -f /${_workspace_name}/${_notebook_name} -q lakehouse -i '{\"known_lakehouses\": [{\"id\": \"${_lakehouse_silver_id}\"}],\"default_lakehouse\": \"${_lakehouse_silver_id}\",\"default_lakehouse_name\": \"${_lakehouse_silver_name_no_ext}\",\"default_lakehouse_workspace_id\": \"${_workspace_id}\"}'"
        # run_fab_command "set -f /${_workspace_name}/${_notebook_name} -q environment -i '{\"environmentId\": \"${_environment_id}\",\"workspaceId\": \"${_workspace_id}\"}'"
    done
    # notebook Bronze_Data_Preparation points to bronze lakehouse
    run_fab_command "set -f /${_workspace_name}/"Bronze_Data_Preparation.Notebook" -q lakehouse -i '{\"known_lakehouses\": [{\"id\": \"${_lakehouse_bronze_id}\"}],\"default_lakehouse\": \"${_lakehouse_bronze_id}\",\"default_lakehouse_name\": \"${_lakehouse_bronze_name_no_ext}\",\"default_lakehouse_workspace_id\": \"${_workspace_id}\"}'"

    # copy jobs
    for _copyjob_name in "${_copyjob_names[@]}"; do
        echo -e "\n_ importing a copy job..."
        # Replace placeholder GUIDs with actual IDs
        replace_string_value $_copyjob_name "copyjob-content.json" "8e0cc78d-1667-4e88-9523-a04c1d5dd187" $_workspace_id
        replace_string_value $_copyjob_name "copyjob-content.json" "3ad63567-2849-4e5b-9cf2-eacd059e50a5" $_lakehouse_bronze_id
        #replace_string_value $_copyjob_name "copyjob-content.json" "a8d62227-a513-4837-9537-c7761c2e9c11" $_warehouse_id
        #replace_string_value $_copyjob_name "copyjob-content.json" "x6eps4xrq2xudenlfv6naeo3i4-rxdqzdthc2ee5fjdubgb2xorq4.msit-datawarehouse.fabric.microsoft.com" $_warehouse_conn_string
        run_fab_command "import -f /${_workspace_name}/${_copyjob_name} -i ${staging_dir}/${_copyjob_name}"
    done

    # run jobs
    for _copyjob_name in "${_copyjob_names[@]}"; do
        echo -e "\n_ running a copy job..."
        _copyjob_id=$(get_fab_property "/${_workspace_name}/${_copyjob_name}" "id")
        run_fab_command "api -X post workspaces/${_workspace_id}/items/${_copyjob_id}/jobs/instances?jobType=Execute" >/dev/null
        echo "CopyJob started. Waiting for completion..."
    done

    sleep 45
    echo "* CopyJob executions finished"

    # shortcuts
    echo -e "\n_ creating t2 shortcut to silver lakehouse..."
    run_fab_command "ln -f /${_workspace_name}/${_lakehouse_silver_name}/Tables/dbo/t2.Shortcut --type oneLake --target /${_workspace_name}/${_lakehouse_bronze_name}/Tables/dbo/t2"

    # #echo -e "\n_ creating a shortcut to warehouse..."
    # #run_fab_command "ln -f /${_workspace_name}/${_lakehouse_silver_name}/Tables/dbo/t3.Shortcut --type oneLake --target /${_workspace_name}/${_warehouse_name}/Tables/dbo/dw_t3"

    # run notebook that creates t3's
    echo -e "\n_ running notebook..."
    run_fab_command "job run /${_workspace_name}/Bronze_Data_Preparation.Notebook"

    # now create shortcut t3_dev in silver lakehouse
    echo -e "\n_ creating t3 shortcut to silver lakehouse..."
    run_fab_command "ln -f /${_workspace_name}/${_lakehouse_silver_name}/Tables/dbo/t3.Shortcut --type oneLake --target /${_workspace_name}/${_lakehouse_bronze_name}/Tables/dbo/t3_dev"

    # run notebook that creates t1
    echo -e "\n_ running notebook..."
    run_fab_command "job run /${_workspace_name}/Transformations.Notebook"

     # change DL connection
    replace_string_value $_sem_model_name "definition/expressions.tmdl" "X6EPS4XRQ2XUDENLFV6NAEO3I4-RXDQZDTHC2EE5FJDUBGB2XORQ4.msit-datawarehouse.fabric.microsoft.com" $_lakehouse_silver_conn_string
    replace_string_value $_sem_model_name "definition/expressions.tmdl" "48d64684-b584-4ef5-ad7b-a094b42f52f8" $_lakehouse_silver_conn_id

    # semantic model
    import_semantic_model $_workspace_name $_sem_model_name
    _semantic_model_id=$(get_fab_property "/${_workspace_name}/${_sem_model_name}" "id")

    # report
    replace_string_value $_report_name "definition.pbir" "e4e9593c-b1a9-428e-9581-64939a83c4d9" $_semantic_model_id
    import_powerbi_report $_workspace_name $_report_name $_semantic_model_id

    # open and clean up
    open_workspace $_workspace_name
    clean_up_staging
}

run_first_deployment