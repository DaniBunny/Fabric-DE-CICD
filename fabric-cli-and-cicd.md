# fabric-cli vs fabric-cicd: Capabilities and Use Cases

## Overview

This document outlines the key differences between **fabric-cli** and **fabric-cicd**, explaining what each tool brings to Microsoft Fabric development and deployment workflows, and when to use each one.

## fabric-cli Capabilities

**fabric-cli** is a **command-line interface** for interactive and scripted operations:

### Core Strengths
- **Interactive REPL-like environment** for exploring Fabric workspaces
- **Individual item operations** (create, import, export, run, query)
- **Real-time workspace navigation** with filesystem-like paths
- **Direct API access** for all supported Fabric operations
- **Authentication management** (interactive, SPN, managed identity)
- **OneLake operations** (shortcuts, file management)

### Primary Use Cases
- **Manual workspace management**
- **Individual item deployment**
- **Interactive development and testing**
- **One-off operations and scripts**

## fabric-cicd Capabilities

**fabric-cicd** is a **Python library for CI/CD automation** with enterprise deployment patterns:

### What fabric-cicd Brings That fabric-cli Doesn't

#### 1. Environment-Aware Deployment Framework
```python
# fabric-cicd: Environment-specific deployments
workspace = FabricWorkspace(
    workspace_id=workspace_id,
    environment="DEV",  # DEV, TEST, PROD
    item_type_in_scope=["Notebook", "DataPipeline"]
)
```
- **Multi-environment support** (DEV/TEST/PROD)
- **Environment-specific parameterization**
- **Deployment rules and transformations**

#### 2. Advanced Parameterization Engine
```yaml
# parameter.yml - fabric-cicd only
find_replace:
  - find: "{{workspace_id}}"
    replace: "$workspaces.current.id"
  - find: "{{lakehouse_name}}"
    replace: "Lakehouse_{{environment}}"
```
- **Template-based configuration**
- **Dynamic variable substitution**
- **Cross-item parameter relationships**
- **Environment-specific value replacement**

#### 3. Bulk Operations and Orchestration
```python
# fabric-cicd: Deploy entire workspace at once
publish_all_items(workspace)
unpublish_all_orphan_items(workspace)
```
- **Batch deployment of multiple items**
- **Dependency-aware deployment ordering**
- **Orphan item cleanup**
- **Full workspace synchronization**

#### 4. CI/CD Pipeline Integration
```python
# fabric-cicd: Built for automation
from fabric_cicd import FabricWorkspace, publish_all_items

# Designed for Azure DevOps, GitHub Actions
workspace = FabricWorkspace(
    repository_directory="./workspace_items",
    environment=os.getenv('DEPLOYMENT_ENVIRONMENT')
)
```
- **Pipeline-ready Python package**
- **Structured error handling for CI/CD**
- **Environment variable integration**
- **Service principal authentication patterns**

#### 5. Deployment Rules and Transformations
```python
# fabric-cicd: Smart deployment logic
workspace.item_type_in_scope = ["Notebook", "DataPipeline", "Environment"]
workspace.publish_item_name_exclude_regex = r"^test_.*"
```
- **Selective item deployment**
- **Regex-based filtering**
- **Item type scoping**
- **Deployment rule enforcement**

#### 6. Schema Evolution Support
- **Parameter-driven schema changes**
- **Cross-environment data artifact management**
- **Database object parameterization**
- **Connection string management**

#### 7. Enterprise Deployment Patterns
```python
# fabric-cicd: Enterprise features
workspace.deployed_items  # Track what's deployed
workspace.repository_items  # Track what's in source
workspace.environment_parameter  # Environment config
```
- **Deployment state tracking**
- **Source vs. target comparison**
- **Configuration management**
- **Audit and compliance features**

## Key Architectural Differences

### fabric-cli: Interactive Tool
```bash
# One-off operations
fab create MyWorkspace.Workspace
fab import MyNotebook.Notebook -i ./notebook.ipynb
fab run MyPipeline.DataPipeline
```

### fabric-cicd: Automation Framework
```python
# Systematic deployment
workspace = FabricWorkspace(
    repository_directory="./workspace",
    environment="PROD",
    item_type_in_scope=["Notebook", "DataPipeline"]
)
publish_all_items(workspace)
```

## When to Use Each

### Use **fabric-cli** for:
- **Interactive development**
- **Manual operations**
- **Learning and exploration**
- **One-off scripts**
- **Individual item management**

### Use **fabric-cicd** for:
- **Production CI/CD pipelines**
- **Multi-environment deployments**
- **Automated testing and validation**
- **Enterprise governance**
- **Bulk workspace operations**

## Workshop Context

For the **Fabric DE git CI-CD workshop**, both tools are used strategically:

### 1. fabric-cli for Bootstrap (`first_deployment.sh`)
- Quick workspace setup
- Individual item creation
- Manual validation steps
- Learning the fundamentals

### 2. fabric-cicd for Advanced Scenarios
- Environment promotion (DEV → TEST → PROD)
- Parameter-driven deployments
- Schema evolution handling
- Production CI/CD patterns

## Real-World Usage Patterns

This combination reflects how teams actually work:

1. **Development Phase**: Use `fabric-cli` for rapid prototyping and testing
2. **Production Phase**: Use `fabric-cicd` for automated, governed deployments
3. **Hybrid Approach**: `fabric-cli` for manual operations, `fabric-cicd` for automation

## Tool Comparison Matrix

| Feature | fabric-cli | fabric-cicd |
|---------|------------|-------------|
| **Interactive Use** | ✅ Primary | ❌ Not designed for |
| **Individual Items** | ✅ Excellent | ⚠️ Limited |
| **Bulk Operations** | ⚠️ Manual scripting | ✅ Native support |
| **Environment Management** | ❌ Manual | ✅ Built-in |
| **Parameterization** | ⚠️ Basic | ✅ Advanced |
| **CI/CD Integration** | ⚠️ Script-based | ✅ Native library |
| **Error Handling** | ⚠️ Command-line | ✅ Structured |
| **Deployment Rules** | ❌ Manual | ✅ Automated |
| **State Tracking** | ❌ None | ✅ Built-in |
| **Learning Curve** | ✅ Easy | ⚠️ Moderate |

## Conclusion

Both tools are essential for a complete Microsoft Fabric development lifecycle:

- **fabric-cli** excels at **developer productivity** and **interactive operations**
- **fabric-cicd** excels at **enterprise automation** and **production deployments**

The workshop demonstrates this progression: start with fabric-cli fundamentals, then advance to fabric-cicd enterprise patterns. This mirrors real-world adoption where teams begin with manual operations and evolve to automated governance.

## References

- [fabric-cli GitHub Repository](https://github.com/microsoft/fabric-cli)
- [fabric-cicd GitHub Repository](https://github.com/microsoft/fabric-cicd)
- [Microsoft Fabric Documentation](https://learn.microsoft.com/fabric/)
- [Workshop Repository](https://github.com/DaniBunny/Fabric-DE-git-CI-CD)
