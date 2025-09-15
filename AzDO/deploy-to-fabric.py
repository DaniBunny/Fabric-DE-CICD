# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

"""Deploy workspace to Fabric"""

import argparse
import os
import sys

from azure.identity import AzureCliCredential
from fabric_cicd import FabricWorkspace, change_log_level, publish_all_items, unpublish_all_orphan_items

# parse arguments from yaml pipeline. These are typically secrets from a variable group linked to an Azure Key Vault
parser = argparse.ArgumentParser(description="Deploy Fabric Workspace Parameters")
parser.add_argument("--repository_directory", type=str, help="Directory of the workspace files")
parser.add_argument("--environment", type=str, help="Environment to use for parameter.yml")
parser.add_argument("--workspace_name", type=str, help="Name of the workspace to deploy")

args = parser.parse_args()

repository_directory = args.repository_directory
environment = args.environment
workspace_name = args.workspace_name


# Force unbuffered output like `python -u`
sys.stdout.reconfigure(line_buffering=True, write_through=True)
sys.stderr.reconfigure(line_buffering=True, write_through=True)

# Enable debugging if defined in Azure DevOps pipeline
if os.getenv("SYSTEM_DEBUG", "false").lower() == "true":
    change_log_level("DEBUG")

# Use Azure CLI credential to authenticate
token_credential = AzureCliCredential()

# Initialize the FabricWorkspace object with the required parameters
target_workspace = FabricWorkspace(
    workspace_name=workspace_name,
    environment=environment,
    repository_directory=repository_directory,
    token_credential=token_credential,
)

# Publish all items defined in item_type_in_scope
publish_all_items(target_workspace)

# Unpublish all items defined in item_type_in_scope not found in repository
unpublish_all_orphan_items(target_workspace)
