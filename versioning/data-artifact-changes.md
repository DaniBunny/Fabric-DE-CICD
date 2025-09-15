# Module 8: Schema Changes with Spark SQL DDL - Practical Git & Azure DevOps Workflows

[← Back to Azure DevOps](../deployment/azuredevops.md) | [Home](../README.md)

## Overview

Master practical schema evolution in Microsoft Fabric using **Spark SQL DDL statements** deployed through the **Azure DevOps pipeline infrastructure** built in Module 7. This module focuses on hands-on implementation of additive and destructive schema changes using git workflows and automated deployments.

**Key Focus**: Real Spark SQL DDL changes deployed automatically through Azure DevOps pipelines with manual execution in development and automated execution during deployment.

## Learning Objectives

- **Execute Spark SQL DDL** for schema changes in development environment
- **Deploy schema changes** using the Azure DevOps pipeline from Module 7
- **Implement additive changes** (new table creation) through git workflows
- **Handle destructive changes** (column removal) with proper risk management
- **Validate changes** across all three environments (Development → Test → Production)
- **Understand automatic notebook execution** during Azure DevOps deployments

## Prerequisites

- **Completed Module 7**: [Azure DevOps Integration](../deployment/azuredevops.md) with working pipeline
- **Azure DevOps pipeline** executing successfully (Development → Test → Production)
- **fabric-cicd deployment script** working with authentication  
- **Three workspaces operational**:
  - `DEWorkshop_<username>` (Development - main branch)
  - `DEWorkshop_<username>_Test` (Test - test branch)  
  - `DEWorkshop_<username>_Prod` (Production - production branch)
- **Git integration** working in Development workspace

> [!IMPORTANT]
> **Module 7 Pipeline Required**  
> This module uses the Azure DevOps pipeline infrastructure created in Module 7. When we deploy notebooks through fabric-cicd, they **don't execute automatically**. We need to modify the deployment script to run notebooks after deployment.

> [!NOTE]
> **Practical Schema Evolution**  
> This module demonstrates real-world schema changes using Spark SQL DDL. You'll manually test changes in development, then deploy through Azure DevOps with automatic notebook execution.

## Part 1: Understanding Schema Change Types

### Additive vs Destructive Changes

Schema changes in data engineering require different risk management strategies:

#### 🟢 Additive Changes (Safe - Low Risk)

**Definition**: Changes that extend existing data structures without breaking existing functionality.

**Characteristics**:

- ✅ **Backward compatible** - existing queries continue to work
- ✅ **Non-breaking** - downstream systems remain functional  
- ✅ **Reversible** - can be rolled back without data loss
- ✅ **Incremental** - can be deployed independently

**Examples**:

- Creating new tables with new data lineage
- Adding new columns to existing tables
- Adding indexes or constraints to improve performance
- Creating new views or stored procedures
- Adding new data pipelines or transformation logic

#### 🔴 Destructive Changes (High Risk - Requires Careful Planning)

**Definition**: Changes that modify or remove existing data structures, potentially breaking existing functionality.

**Characteristics**:

- ⚠️ **Breaking changes** - existing queries may fail
- ⚠️ **Data loss risk** - incorrect implementation can destroy data
- ⚠️ **Dependency cascade** - affects downstream systems
- ⚠️ **Complex rollback** - may require data restoration

**Examples**:

- Renaming or dropping existing tables
- Renaming or removing columns from existing tables
- Changing column data types (potential data truncation)
- Modifying primary keys or unique constraints
- Changing partitioning strategies

### Strategic Approach Comparison

| Aspect | Additive Changes | Destructive Changes |
|--------|------------------|-------------------|
| **Risk Level** | 🟢 Low | 🔴 High Risk - Data Loss Potential |
| **Git Strategy** | Direct branch promotion | Multi-phase branch strategy |
| **DDL Approach** | Simple CREATE/ALTER ADD | Incremental non-destructive steps |
| **Testing Requirements** | Standard validation | Extensive validation across stages |
| **Production Window** | No downtime required | Planned maintenance window |
| **Validation Focus** | New functionality works | Existing functionality preserved |

### Implementation Strategies

#### For Additive Changes

1. **Create new structures** using `CREATE TABLE` or `ALTER TABLE ADD COLUMN`
2. **Test thoroughly** with existing data patterns in development
3. **Promote through git branches** (main → test → production)
4. **Validate at each stage** using Azure DevOps pipeline checks
5. **Document changes** for downstream teams

#### For Destructive Changes (Non-Destructive Approach)

1. **Never drop or rename directly** - always create alternatives
2. **Add new columns/tables** alongside existing ones  
3. **Implement dual-read patterns** during transition
4. **Use views to abstract changes** for downstream consumers
5. **Plan deprecation timeline** but keep old structures
6. **Execute through git workflows** with extensive validation
7. **Fix forward always** - if issues arise, add more, never remove

## Part 2: Practical Implementation - Additive Schema Change

### Creating New Table t5 - Additive Change

**Objective:** Create a new table `t5` using Spark SQL DDL by joining existing tables `t1` and `t2`. This demonstrates a safe additive change deployed through the Azure DevOps pipeline from Module 7.

#### Step 2.1: Development - Manual Testing

1. **Open Development workspace in Fabric**
   - Navigate to `DEWorkshop_<username>` workspace  
   - Open `Transformations.Notebook`

2. **Add new table creation code to notebook**

   Add this new code cell to the **Transformations** notebook:

   ```sql
   -- Part 2: Create new table t5 (Additive Schema Change)
   -- This creates a new analytics table combining t1 and t2 data
   CREATE OR REPLACE TABLE Lakehouse_Silver.dbo.t5 AS
   SELECT 
       t1.id as entity_id,
       t1.name,
       t1.category,
       t2.region,
       t2.status,
       CURRENT_TIMESTAMP() as created_timestamp
   FROM Lakehouse_Silver.dbo.t1 t1
   INNER JOIN Lakehouse_Silver.dbo.t2 t2 ON t1.id = t2.id;
   
   -- Validate new table t5
   SELECT COUNT(*) as t5_record_count FROM Lakehouse_Silver.dbo.t5;
   SELECT * FROM Lakehouse_Silver.dbo.t5 LIMIT 5;
   ```

3. **Execute notebook manually in Development**
   - Run the notebook to create table t5
   - Verify the new table is created successfully
   - Confirm data is populated correctly

#### Step 2.2: Git Integration - Commit to Main Branch

1. **Save and commit changes in Development workspace**
   - Save the Transformations notebook in Development workspace
   - Use Git integration to sync changes to `main` branch
   - Commit message: "Add table t5 creation - additive schema change"

#### Step 2.3: Deploy to Test Environment via Pull Request

1. **Create Pull Request from main to test branch**
   - In Azure DevOps, navigate to **Repos** → **Pull requests**  
   - Click **New pull request**
   - Source branch: `main`
   - Target branch: `test`
   - Title: "Deploy table t5 to test environment"
   - Description: "Additive schema change - creates new analytics table t5"
   - Click **Create**

2. **Approve and merge Pull Request**
   - Click **Approve** 
   - Click **Complete** → **Complete merge**
   - This triggers the Azure DevOps pipeline to deploy to Test workspace

3. **IMPORTANT: Notebook execution after deployment**

   The current deployment script only deploys notebooks but doesn't execute them. For schema changes to take effect, notebooks must run after deployment.

   **Option A: Manual execution after deployment (Recommended for this workshop)**
   - Monitor Azure DevOps pipeline completion
   - Navigate to Test workspace (`DEWorkshop_<username>_Test`)
   - Manually run the Transformations notebook to create table t5

   **Option B: Modify deployment script to auto-execute (Advanced)**
   ```python
   # Add to deploy-to-fabric.py after publish_all_items()
   # Execute notebooks after deployment for schema changes
   
   if branch in ['test', 'production']:
       # Execute Transformations notebook to apply schema changes
       notebook_run_response = workspace.run_notebook("Transformations.Notebook")
       print(f"Transformations notebook execution: {notebook_run_response}")
   ```

4. **Validate Test deployment**
   - Verify pipeline completes successfully
   - Navigate to Test workspace and execute Transformations notebook
   - Check that table t5 is created with expected data

#### Step 2.4: Deploy to Production Environment  

1. **Create Pull Request from test to production branch**
   - In Azure DevOps, navigate to **Repos** → **Pull requests**
   - Click **New pull request**  
   - Source branch: `test`
   - Target branch: `production`
   - Title: "Deploy validated table t5 to production"
   - Description: "Tested additive schema change - table t5 ready for production"
   - Click **Create**

2. **Approve production deployment**
   - Click **Approve** to approve the PR
   - Click **Complete** → **Complete merge**
   - Pipeline will pause at production environment approval gate
   - Navigate to **Pipelines** → **Environments** → **prod**
   - Click **Review pending deployments** → **Approve**

3. **Validate Production deployment**
   - Monitor pipeline completion
   - Navigate to Production workspace (`DEWorkshop_<username>_Prod`)
   - Execute Transformations notebook to create table t5
   - Verify table t5 exists with expected data

> [!SUCCESS]
> **Additive Schema Change Complete!** New table t5 successfully deployed across all environments (Development → Test → Production).

## Part 3: Practical Implementation - Destructive Schema Change

### Removing Column from Table t5 - Destructive Change

**Objective:** Demonstrate handling a potentially risky destructive schema change (dropping a column) using the same Azure DevOps pipeline workflow. This shows the risk management needed for destructive operations.

> [!WARNING]
> **Destructive Change Alert**  
> Dropping columns can break existing queries and cause data loss. In production environments, consider deprecation periods and alternative approaches before executing destructive changes.

#### Step 3.1: Development - Test Destructive Change

1. **Open Development workspace in Fabric**
   - Navigate to `DEWorkshop_<username>` workspace
   - Open `Transformations.Notebook`

2. **Add destructive schema change code to notebook**

   Add this new code cell to the **Transformations** notebook:

   ```sql
   -- Part 3: Remove column from table t5 (Destructive Schema Change)
   -- WARNING: This is a destructive operation that can break existing queries
   ALTER TABLE Lakehouse_Silver.dbo.t5 
   DROP COLUMN created_timestamp;
   
   -- Validate column removal
   DESCRIBE Lakehouse_Silver.dbo.t5;
   SELECT * FROM Lakehouse_Silver.dbo.t5 LIMIT 5;
   ```

3. **Execute notebook manually in Development**
   - Run the notebook to drop the column from table t5
   - Verify the column is removed successfully
   - **Test existing queries** to ensure they still work without the dropped column

#### Step 3.2: Git Integration - Commit Destructive Change

1. **Save and commit changes in Development workspace**
   - Save the Transformations notebook in Development workspace
   - Use Git integration to sync changes to `main` branch
   - Commit message: "Remove created_timestamp column from t5 - destructive schema change"

#### Step 3.3: Deploy to Test Environment

1. **Create Pull Request from main to test branch**
   - In Azure DevOps, navigate to **Repos** → **Pull requests**
   - Click **New pull request**
   - Source branch: `main`
   - Target branch: `test`
   - Title: "Deploy destructive schema change to test - remove t5.created_timestamp"
   - Description: "⚠️ DESTRUCTIVE CHANGE: Removes created_timestamp column from table t5. Validate all downstream queries."
   - Click **Create**

2. **Approve and merge Pull Request**
   - **Review carefully** - this is a destructive change
   - Click **Approve**
   - Click **Complete** → **Complete merge**
   - Monitor Azure DevOps pipeline execution

3. **Validate Test deployment**
   - Verify pipeline completes successfully
   - Navigate to Test workspace (`DEWorkshop_<username>_Test`)
   - Execute Transformations notebook to apply schema change
   - **Verify column is dropped** and **test all dependent queries/reports**

#### Step 3.4: Production Deployment with Extra Caution

1. **Create Pull Request from test to production branch**
   - In Azure DevOps, navigate to **Repos** → **Pull requests**
   - Click **New pull request**
   - Source branch: `test`
   - Target branch: `production`
   - Title: "⚠️ PRODUCTION DESTRUCTIVE CHANGE - remove t5.created_timestamp"
   - Description: "Validated destructive schema change. Column removal tested in Development and Test environments. All dependent systems verified."
   - Click **Create**

2. **Production approval process**
   - **Extra review required** for destructive changes
   - Click **Approve** (consider requiring additional approvers in real scenarios)
   - Click **Complete** → **Complete merge**
   - Pipeline will pause at production environment approval gate
   - Navigate to **Pipelines** → **Environments** → **prod**
   - Click **Review pending deployments**
   - **Add approval comment**: "Destructive change validated in test environment. Approved for production."
   - Click **Approve**

3. **Monitor production deployment carefully**
   - Watch pipeline execution closely
   - Navigate to Production workspace (`DEWorkshop_<username>_Prod`)
   - Execute Transformations notebook to apply destructive change
   - **Immediately validate** that all systems continue to function
   - **Test downstream reports and queries** to ensure no breakage

> [!SUCCESS]
> **Destructive Schema Change Complete!** Column successfully removed across all environments with proper risk management and validation.

## Part 4: Key Takeaways and Best Practices

### What You've Accomplished

You've successfully implemented **practical schema evolution** patterns using Spark SQL DDL deployed through Azure DevOps pipelines:

**Additive Change (Table Creation)**:
- ✅ Created new table t5 using Spark SQL `CREATE TABLE AS`
- ✅ Manually tested in Development workspace
- ✅ Deployed through git workflow (main → test → production branches)
- ✅ Used Azure DevOps pipeline automation from Module 7
- ✅ Validated across all three environments

**Destructive Change (Column Removal)**:
- ✅ Removed column using Spark SQL `ALTER TABLE DROP COLUMN`
- ✅ Applied proper risk management and validation
- ✅ Used same git workflow and Azure DevOps automation
- ✅ Demonstrated production approval gates for high-risk changes

### Schema Evolution Best Practices

**Development Workflow**:

1. **Manual testing first** - Always test DDL changes in Development workspace
2. **Git integration** - Use Fabric's git sync to commit notebook changes  
3. **Pull Request workflow** - Deploy through controlled PR approvals
4. **Environment progression** - Development → Test → Production sequence
5. **Manual execution** - Run notebooks manually after deployment (until automated)

**Risk Management**:

1. **Additive changes are safer** - Prefer CREATE TABLE over ALTER TABLE
2. **Destructive changes need extra caution** - More approvals, better testing
3. **Test all dependencies** - Verify downstream queries and reports still work
4. **Use approval gates** - Production deployments should require manual approval

**Azure DevOps Integration**:

1. **Leverage Module 7 pipeline** - Use existing fabric-cicd automation
2. **Environment approvals** - Configure production approval gates
3. **Branch policies** - Require PR reviews for test and production branches  
4. **Monitoring** - Watch pipeline execution and validate results

### Next Steps for Advanced Schema Management

**Enhance the Deployment Script**:
```python
# Add automatic notebook execution to deploy-to-fabric.py
if branch in ['test', 'production']:
    # Execute Transformations notebook after deployment
    workspace.run_notebook("Transformations.Notebook")
```

**Implement Pre/Post Deployment Hooks**:
- Pre-deployment: Schema validation, backup creation
- Post-deployment: Data quality checks, downstream system validation

**Advanced Patterns to Explore**:
1. **Schema versioning** - Track DDL changes over time
2. **Data migration scripts** - Handle complex data transformations
3. **Rollback procedures** - Automated recovery from failed deployments
4. **Blue-green deployments** - Zero-downtime schema changes

### Workshop Success Criteria ✅

You have successfully:

- [x] **Implemented additive schema changes** using Spark SQL DDL
- [x] **Managed destructive schema changes** with proper risk controls
- [x] **Used git workflows** for controlled deployment progression
- [x] **Leveraged Azure DevOps pipelines** for automated deployment
- [x] **Applied approval gates** for production risk management
- [x] **Validated changes** across all three environments

The foundation you've built provides enterprise-grade schema evolution capabilities for Microsoft Fabric data engineering projects.

> [!SUCCESS]
> **Module 8 Complete!** You've mastered practical schema evolution using Spark SQL DDL, git workflows, and Azure DevOps automation.
