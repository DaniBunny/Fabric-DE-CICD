# Module 6: End-to-End Pipeline - Three-Stage Deployment

> [!NOTE]
> **Duration:** 45 minutes | **Difficulty:** Intermediate | [← Back to Deployment Pipelines](./start.md) | [Next: Azure DevOps →](./azuredevops.md)

## Overview

Complete your enterprise deployment pipeline by adding a Test stage between Development and Production. Apply the knowledge gained from Modules 4 and 5 to create a three-stage promotion flow (Dev → Test → Prod) with proper branch management, variable configuration, and end-to-end validation.

In this module, you'll use what you've learned to:
- Create a Test environment using branch out strategies from Module 4
- Configure deployment rules and variables using patterns from Module 5
- Execute and validate a complete three-stage deployment pipeline

## Learning Objectives

- Apply Module 4 learnings: Create Test workspace and branch using branch out strategy
- Apply Module 5 learnings: Configure three-stage variable library and deployment rules
- Update variable libraries for three-stage environment management
- Execute complete deployment pipeline
- Validate data processing, transformation, and reporting across all stages
- Troubleshoot and resolve deployment issues independently

## Prerequisites

- **Successfully completed Module 5** with working two-stage deployment pipeline
- Functional deployment pipeline: Development → Production
- Working variable library with Dev/Prod configurations
- All deployment rules functioning correctly from Module 5
- Current workspace setup:
  - `DEWorkshop_<username>` (Development - main branch)
  - `DEWorkshop_<username>_Prod` (Production - production branch)

## Part 1: Apply Module 4 - Create Test Environment

### High-Level Objective

Use the branch out strategy you learned in Module 4 to create a Test environment between Development and Production.

### Tasks

> [!TIP]
> **Apply Module 4 Knowledge**: You successfully created a Production workspace using branch out. Now apply the same pattern to create a Test workspace.

#### Task 1.1: Create Test Workspace Using Branch Out

1. **Use Fabric Branch Out capability**
   - From your `DEWorkshop_<username>` workspace
   - Branch out to create `DEWorkshop_<username>_Test`
   - Connect to the `test` branch in Azure DevOps

#### Task 1.2: Verify Test Environment

1. **Confirm workspace creation**
   - Test workspace should have all items from development
   - Git integration should point to `test` branch
   - Use all validation techniques from Module 4

> **Expected Result**: You now have three workspaces:
> - `DEWorkshop_<username>` (Development - main branch)
> - `DEWorkshop_<username>_Test` (Test - test branch)  
> - `DEWorkshop_<username>_Prod` (Production - production branch)

## Part 2: Apply Module 5 - Configure Three-Stage Pipeline

### High-Level Objective

Apply the deployment pipeline configuration skills from Module 5 to create a three-stage pipeline with proper variable libraries and deployment rules.

### Tasks

> [!TIP]
> **Apply Module 5 Knowledge**: You successfully configured a two-stage pipeline with variables and rules. Now extend that pattern to three stages.

#### Task 2.1: Rebuild Deployment Pipeline

1. **Navigate to DEWorkshop_<username> workspace**
   - Click on **View deployment pipelines**
   - Click on the ellipsis `...` and select **Delete pipeline** from the drop menu.
   - **Confirm** deletion when prompted. The `DEWorkshop_<username>_Pipeline` pipeline is now deleted.

2. **Create new three-stage pipeline**
   - Name: `DEWorkshop_<username>_Pipeline_3Stage`
   - Stages: Development → Test → Production
   - Assign workspaces to each stage

#### Task 2.2: Configure Three-Stage Variable Library

1. **Extend variable library**
   - Add Test stage variables to your existing variable library
   - Use the same pattern you learned in Module 5

#### Task 2.3: Configure Three-Stage Deployment Rules

1. **Apply deployment rules pattern**
   - Use the same deployment rules from Module 5
   - Extend to include Test stage in the rule configurations
   - Test stage should use same rule patterns as Production

> **Expected Result**: Three-stage deployment pipeline with working variable library and deployment rules.

## Part 3: Execute Three-Stage Deployment

### High-Level Objective

Execute a complete deployment from Development → Test → Production, applying validation patterns from Module 5.

### Tasks

> [!TIP]
> **Apply Module 5 Knowledge**: You successfully executed deployment pipeline automation. Now execute the same pattern across three stages.

#### Task 3.1: Deploy Development → Test

1. **Execute first deployment**
   - Deploy from Development to Test stage
   - Apply the same validation steps you learned in Module 5
   - Verify deployment rules executed correctly.

> [!TIP]
> You'll notice that the shortcuts didn't remap. Make sure you made the Variable Set from MyVarLib as Active in the DEWorkshop_<username>_Test workspace. Make sure you update all variables in the Lakehouse Silver before Transformation notebook execution.

#### Task 3.2: Validate Test Environment

1. **Run comprehensive validation**
   - Execute Copy Jobs in Test workspace
   - Run required notebooks
   - Confirm if all tables, shortcuts, semantic models are pointing to the right place
   - Test the Validations notebook and run the MyReport report

#### Task 3.3: Deploy Test → Production  

1. **Execute second deployment**
   - Deploy from Test to Production stage  
   - Use same validation approach from Module 5
   - Verify all connections and rules work properly

2. **Run comprehensive validation**
   - Execute Copy Jobs in Test workspace (if needed)
   - Run required notebooks (if needed)
   - Confirm if all tables, shortcuts, semantic models are pointing to the right place
   - Test the Validations notebook and run the MyReport report

> **Expected Result**: Complete three-stage pipeline execution with data flowing Development → Test → Production.

## Module 6 Complete - Key Accomplishments

🎉 **Congratulations!** You have successfully applied learnings from Modules 4 and 5 to create a complete three-stage enterprise deployment pipeline.

### What You've Accomplished

1. **Applied Module 4 Knowledge**:
   - Created Test workspace using branch out strategy
   - Established three-branch Git structure (main, test, production)
   - Configured Test environment with proper isolation

2. **Applied Module 5 Knowledge**:
   - Extended deployment pipeline to three stages
   - Configured comprehensive variable library for all environments
   - Applied deployment rules across all three stages
   - Executed end-to-end deployment validation

3. **Enterprise-Ready Pipeline**:
   - Development → Test → Production flow
   - Complete environment isolation
   - Automated deployment rules and variable management
   - Comprehensive validation and monitoring

### Key Skills Mastered

- **Multi-stage pipeline architecture**
- **Environment-specific variable management**  
- **Cross-environment deployment automation**
- **Data isolation and security patterns**
- **End-to-end validation procedures**

---

## 🎓 INSTRUCTOR CHECKPOINT #3

> [!IMPORTANT]
> **Final Three-Stage Pipeline Validation** - This completes the core workshop modules. Ensure all participants have working three-stage pipelines.

### Final Instructor Verification

#### ✅ **Complete Pipeline Functionality**
- [ ] All participants have three-stage pipeline (Dev → Test → Prod)
- [ ] All three workspaces exist and are properly configured
- [ ] Variable library configured for all three stages
- [ ] Deployment rules working across all stages
- [ ] End-to-end data processing validated in Production

#### 🔧 **Critical Validation Items**
```
Instructor will verify each participant has:
1. Shortcut isolation working properly: ✓/✗
2. Environment detection in notebooks: ✓/✗  
3. Production data processing end-to-end: ✓/✗
4. Power BI report showing production data: ✓/✗
```

#### 📊 **Workshop Progress Summary**
- **Module 4 Completion**: Production workspace via branch out ✓
- **Module 5 Completion**: Two-stage deployment automation ✓  
- **Module 6 Completion**: Three-stage enterprise pipeline ✓
- Participants ready for advanced modules: ___/___

#### 💡 **Knowledge Transfer Check**
Final discussion points:
- How does three-stage deployment improve enterprise readiness?
- What are the key benefits of environment isolation?
- How do deployment rules ensure consistency across environments?
- What troubleshooting skills have you developed?

**Instructor Sign-off**: _________________ **Time**: _______

---

## 📚 What's Next?

> [!IMPORTANT]
> ### ✅ Core Workshop Complete!
> 
> **Your Progress:** [1] ✅ → [2] ✅ → [3] ✅ → [4] ✅ → [5] ✅ → [6] ✅ → **Go Advanced Track!**

### 🚀 **Advanced Automation**

**📁 Location:** [`/deployment/azuredevops.md`](./azuredevops.md)  
**⏱️ Duration:** 30 minutes  
**🎯 You'll Learn:**
- Azure DevOps CI/CD automation
- YAML pipeline definitions
- fabric-cicd patterns

**[→ Start Module 7: Azure DevOps Integration](./azuredevops.md)**

---

## References and Resources

- [Microsoft Fabric Deployment Pipelines - Three Stages](https://learn.microsoft.com/fabric/cicd/deployment-pipelines/understand-stages) - Official three-stage documentation
- [fabric-cli three-stage patterns](https://github.com/microsoft/fabric-cli) - CLI automation for complex pipelines
- [fabric-cicd enterprise patterns](https://github.com/microsoft/fabric-cicd) - Python automation for enterprise deployments
- [Workshop advanced scenarios](../versioning/) - Next-level deployment patterns
