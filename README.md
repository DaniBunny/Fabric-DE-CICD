# Data Engineering git/CI/CD with Microsoft Fabric - Workshop Guide

## Welcome Workshop Participants!

This is your main instruction guide for today's hands-on workshop. Follow this document step-by-step to successfully complete all exercises.

### What You'll Build Today

You'll implement a complete data engineering solution with professional DevOps practices:
- **Medallion Architecture**: Bronze → Silver data layers using Microsoft Fabric Lakehouses
- **Version Control**: Full Git integration for all Fabric artifacts
- **CI/CD Automation**: Automated deployments across dev, test, and production environments
- **Real-world Scenarios**: Handle schema changes, data migrations, and cross-environment promotions

### Who This Workshop Is For

Whether you're a data engineer, architect, or DevOps practitioner, this workshop will equip you with the skills to confidently manage Fabric-based solutions at scale. No prior Fabric CI/CD experience required, but basic familiarity with Microsoft Fabric and Git concepts is helpful.

## Prerequisites

Before starting, ensure you have:

1. **Microsoft Fabric Capacity** (Trial or Premium)
2. **Git Repository Access** (GitHub or Azure DevOps)
3. **Development Environment**:
   - Python 3.11+ installed
   - Git command line tools
   - Text editor or IDE (VS Code recommended)
4. **Permissions**:
   - Fabric workspace admin rights
   - Repository write access

## Learning Objectives

By the end of this workshop, you will:

- Build a complete Data Engineering solution with Microsoft Fabric git and deployment pipelines  
- Configure Fabric workspaces for Git integration and synchronization  
- Master bi-directional changes: Fabric UI → Git and Git → Fabric  
- Implement environment variables and deployment rules  
- Deploy CI/CD pipelines that handle code, schema, and data changes  
- Take home production-ready code samples for your organization  

## Visual Overview

Want to understand the workshop at a glance? Check our **[Visual Workshop Diagrams](./workshop-diagrams.md)**:
- 🗺️ **Workshop Flow** - Complete journey with checkpoints and timing
- **Purpose & Architecture** - What you'll build and why
- **Skills Progression** - From beginner to advanced
- **Business Value** - ROI and transformation benefits
- ✨ **Before vs After** - Your transformation journey

## Solution Architecture

You'll build a practical data engineering solution using public datasets, designed to demonstrate real-world complexity:

![Diagram of the solution you will build today](screenshots/novelty-solution.png)

**Key Components:**
- **2 Lakehouses**: Bronze (raw data) and Silver (processed data)
- **3 Spark Notebooks**: Data transformation logic
- **2 Copy Jobs**: Data loading
- **1 Semantic Model**: Business logic layer
- **1 Power BI Report**: End-user analytics

## Workshop Modules - Follow in Order

> [!IMPORTANT]
> **START HERE**: Each module builds on the previous one. Complete them in sequence for the best learning experience.
> 
> **Exercise Tracking**: Each module contains 4-6 exercises with clear checkpoints. Track your progress within each module!

### Getting Started (9:00 AM - 10:30 AM)

| Time | Module | Duration | What You'll Do |
|------|--------|----------|----------------|
| 9:00 AM | **[Module 1: Environment Setup](./configuration/start.md)** | 30 min | • Install fabric-cli tool<br>• Configure Fabric workspace<br>• Connect to Git repository<br>• Validate round-trip sync |
| 9:30 AM | **[Module 2: First Deployment](./deployment/bootstrap.md)** | 30 min | • Deploy the baseline solution<br>• Explore medallion architecture<br>• Run initial deployment pipeline<br>• Verify Power BI report<br>**→ CHECKPOINT #1** |
| 10:00 AM | **[Module 3: Version Control Basics](./versioning/start.md)** | 30 min | • Make changes in Fabric UI<br>• Commit to Git<br>• Pull changes from Git<br>• Resolve conflicts |

**Morning Break: 10:30 AM - 11:00 AM**

### Advanced Deployment (11:00 AM - 1:00 PM)

| Time | Module | Duration | What You'll Do |
|------|--------|----------|----------------|
| 11:00 AM | **[Module 4: Branch Management](./deployment/branch-out.md)** | 60 min | • Create feature branches<br>• Deploy to isolated workspaces<br>• Test changes safely<br>• Merge strategies |
| 12:00 PM | **[Module 5: Deployment Pipelines](./deployment/start.md)** | 60 min | • Configure deployment stages<br>• Set environment variables<br>• Create mapping rules<br>• Automate promotions<br>**→ CHECKPOINT #2** |

**Lunch Break: 1:00 PM - 2:00 PM**

### CI/CD Automation (2:00 PM - 5:00 PM)

| Time | Module | Duration | What You'll Do |
|------|--------|----------|----------------|
| 2:00 PM | **[Module 6: End-to-End Pipeline](./deployment/full-run.md)** | 45 min | • Deploy across dev/test/prod<br>• Validate each environment<br>• Monitor deployment status<br>• Troubleshoot issues |
| 2:45 PM | **[Module 7: Azure DevOps Integration](./deployment/azuredevops.md)** | 30 min | • Set up Azure Pipelines<br>• Configure service connections<br>• Automate with YAML<br>• Schedule deployments<br>**→ CHECKPOINT #3** |

**Afternoon Break: 3:15 PM - 3:45 PM**

| Time | Module | Duration | What You'll Do |
|------|--------|----------|----------------|
| 3:45 PM | **[Module 8: Schema Evolution](./versioning/data-artifact-changes.md)** | 45 min | • Handle column changes<br>• Manage table splits<br>• Cross-engine dependencies<br>• Data migration patterns |
| 4:30 PM | **Wrap-up & Q&A** | 30 min | • Review key concepts<br>• Discuss your scenarios<br>• Get additional resources<br>• Plan next steps |

> [!TIP]
> **Flexible Pacing**: While times are suggested, work at your own pace. If you finish early, explore the advanced scenarios or help others!

## Instructor Checkpoints

The workshop includes **3 mandatory instructor checkpoints** to ensure all participants stay synchronized:

| Checkpoint | After Module | Purpose | Key Validations |
|------------|--------------|---------|-----------------|
| **#1** | Module 2 | Foundation Ready | • Medallion architecture deployed<br>• Git sync working<br>• All participants have working environment |
| **#2** | Module 5 | Pipeline Working | • Deployment pipeline configured<br>• Variable libraries set up<br>• Rules successfully applied |
| **#3** | Module 7 | Automation Ready | • Azure DevOps integrated<br>• Service principals configured<br>• CI/CD pipeline operational |

> [!IMPORTANT]
> **Wait for instructor confirmation** at each checkpoint before proceeding. These synchronization points ensure no one gets left behind on critical technical foundations.

## Key Tools You'll Use

The fabric-cli and fabric-cicd are key tools to harness capabilities of Microsoft Fabric in a DevOps context. To understand the when to use each tool and learn more, read the article [fabric-cli vs fabric-cicd: Capabilities and Use Cases](fabric-cli-and-cicd.md).

### fabric-cli
A command-line interface that automates Fabric operations:
- Deploy workspaces and artifacts
- Manage environment configurations
- Integrate with CI/CD pipelines
- [Documentation](https://github.com/microsoft/fabric-cli)

### fabric-cicd
Best practices and patterns for Fabric DevOps:
- Deployment templates and scripts
- Environment management strategies
- Testing and validation approaches
- [Documentation](https://github.com/microsoft/fabric-cicd)

## Quick Reference Guide

### Troubleshooting Tips

| Issue | Solution |
|-------|----------|
| Can't connect to Fabric | Check capacity is running and you have admin rights |
| Git sync fails | Ensure workspace is linked to correct branch |
| Deployment errors | Verify artifact dependencies and naming conventions |
| Missing permissions | Request workspace admin or contributor role |

### Need Help?

- 🙋 **During Workshop**: Ask instructors or check with fellow participants
- 📖 **Documentation**: Each module has detailed step-by-step instructions
- 💬 **Slack/Teams Channel**: [If available for your workshop]
- 🐛 **Known Issues**: Check the [troubleshooting guide](./troubleshooting.md)

## Workshop Success Checklist

Use this checklist to track your progress:

- [ ] Environment setup complete
- [ ] First deployment successful
- [ ] Made changes through Fabric UI and Git
- [ ] Created feature branch and workspace
- [ ] Configured deployment pipeline
- [ ] Deployed to all environments (dev/test/prod)
- [ ] Set up Azure DevOps automation
- [ ] Handled schema changes successfully

## After the Workshop

### Next Steps
1. **Apply to Your Projects**: Use these patterns in your organization
2. **Explore Advanced Scenarios**: Check the additional resources below
3. **Share Knowledge**: Train your team on Fabric CI/CD practices
4. **Contribute**: Submit improvements or new scenarios to this repository

### Future Roadmap

We're expanding this workshop to cover:
- GitHub Actions integration
- Terraform infrastructure as code
- Advanced view patterns in Git
- Multi-tenant deployment strategies

![Diagram of the complete solution roadmap](screenshots/future-solution-roadmap.png)

## Additional Learning Resources

### Related Microsoft Fabric Workshops

| Workshop | Best For | Link |
|----------|----------|------|
| **Lakehouse Fundamentals** | Learning data integration patterns | [Build Your First Lakehouse](https://github.com/ekote/Build-Your-First-End-to-End-Lakehouse-Solution) |
| **Production Operations** | Monitoring and optimization | [Fabric Toolbox](https://github.com/microsoft/fabric-toolbox) |
| **Power BI CI/CD** | Report deployment automation | [Power BI CI/CD Sample](https://github.com/RuiRomano/fabric-cli-powerbi-cicd-sample) |
| **Data Warehousing** | Understanding medallion architecture | [Las Vegas Workshop 2025](https://aka.ms/FabConDW) |

### Recommended Learning Path

1. **Foundation** → Complete a Lakehouse or Data Warehousing workshop
2. **DevOps** → This workshop (Git/CI/CD)
3. **Operations** → Add monitoring and optimization
4. **Specialization** → Explore specific scenarios (Power BI, Real-Time, etc.)

## 🤝 Contributing

We welcome contributions! Please:
- Submit issues for bugs or feature requests
- Create pull requests for improvements
- Share your organization's patterns and practices
- Help expand the scenario library

## 📧 Contact & Support

- **Workshop Issues**: [GitHub Issues](https://github.com/your-repo/issues)
- **General Questions**: [Microsoft Fabric Community](https://community.fabric.microsoft.com/)
- **Documentation**: [Microsoft Fabric Docs](https://docs.microsoft.com/fabric)

---

**Ready to start?** → [Begin with Module 1: Environment Setup](./configuration/start.md)

**Good luck with your workshop! 🎉**
