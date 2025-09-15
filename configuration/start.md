# Module 1: Environment Setup - Getting Started

> [!NOTE]
> **Duration:** 30 minutes | **Difficulty:** Beginner | [← Back to Workshop Home](../README.md) | [Next: First Deployment →](../deployment/bootstrap.md)

## 🎯 Module Objectives

By the end of this module, you will have:
- ✅ Installed all required tools (Git, Python, VSCode)
- ✅ Set up fabric-cli and fabric-cicd packages
- ✅ Connected to Microsoft Fabric portal
- ✅ Cloned the workshop repository
- ✅ Verified everything works correctly

## 📋 Module Exercise Flow

You'll complete 6 setup exercises:

| Exercise | Task | Duration | Status |
|----------|------|----------|--------|
| **1** | Install Git | 5 min | ⬜ Ready |
| **2** | Install Python & Workshop Tools | 10 min | ⬜ Ready |
| **3** | Install Visual Studio Code | 5 min | ⬜ Ready |
| **4** | Access Microsoft Fabric Portal | 5 min | ⬜ Ready |
| **5** | Get the Workshop Code | 5 min | ⬜ Ready |
| **6** | Set Up VSCode Workspace | 2 min | ⬜ Ready |

> **Track Your Progress:** Check off each exercise as you complete it!

## 📋 Quick Pre-flight Check

Before starting, ensure you have:
- 🌐 Internet access to GitHub and Microsoft Fabric
- 💻 Admin rights to install software on your machine
- 📧 Workshop credentials (provided by instructor)
- ⏱️ 30 minutes of uninterrupted time

> [!TIP]
> **Pro Tip:** Use an incognito/private browser window to avoid conflicts with existing work accounts. This prevents automatic redirects and makes login smoother.

---

## 📝 Exercise 1: Install Git (5 minutes)

> **Goal:** Install Git version control system on your machine.
>
> Git is your version control system - essential for tracking changes and collaborating on code.

Git is essential for version control and CI/CD workflows.

### Windows (WSL)
1. Install Windows Subsystem for Linux (WSL2) if not already installed:
   ```powershell
   wsl --install
   ```
2. Open WSL terminal and install Git:
   ```bash
   sudo apt update
   sudo apt install git
   ```
3. Verify installation:
   ```bash
   git --version
   ```

### macOS
1. Install using Homebrew (recommended):
   ```bash
   brew install git
   ```
   Or download from [git-scm.com](https://git-scm.com/download/mac)
2. Verify installation:
   ```bash
   git --version
   ```

### Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install git
git --version
```

> [!TIP]
> If you already have Git installed, ensure it's version 2.25 or later for optimal compatibility with Microsoft Fabric git integration.

### ✅ Exercise 1 Checkpoint

**Before continuing, verify:**
- [ ] Git is installed (`git --version` shows 2.25+)
- [ ] Git works from command line/terminal
- [ ] You understand basic Git concepts

✨ **Exercise 1 Complete!** Git is ready for version control.

---

## 📝 Exercise 2: Install Python & Workshop Tools (10 minutes)

> **Goal:** Set up Python environment with fabric-cli and fabric-cicd packages.
>
> Python powers the fabric-cli and fabric-cicd tools you'll use throughout the workshop.

Python is required for fabric-cli and fabric-cicd automation tools.

### Windows (WSL)
1. Open WSL terminal and install Python:
   ```bash
   sudo apt update
   sudo apt install python3.11 python3.11-venv python3-pip
   ```
2. Verify installation:
   ```bash
   python3 --version
   pip3 --version
   ```

### macOS
1. Install using Homebrew (recommended):
   ```bash
   brew install python@3.11
   ```
   Or download from [python.org](https://www.python.org/downloads/macos/)
2. Verify installation:
   ```bash
   python3 --version
   pip3 --version
   ```

### Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install python3.11 python3.11-venv python3-pip
python3 --version
pip3 --version
```

### 🔧 Set Up Your Workshop Environment

> [!IMPORTANT]
> A virtual environment keeps workshop packages isolated from your system Python.

1. **Create your workshop environment:**
   ```bash
   # Windows (WSL)
   python3 -m venv fabric-de-workshop
   source fabric-de-workshop/bin/activate

   # macOS/Linux
   python3 -m venv fabric-de-workshop
   source fabric-de-workshop/bin/activate
   ```

2. **Install the workshop tools:**
   ```bash
   pip install ms-fabric-cli fabric-cicd
   ```
   
   This installs:
   - **fabric-cli**: Command-line tool for Fabric operations
   - **fabric-cicd**: Python library for CI/CD automation

3. **Verify everything works:**

   **Test fabric-cicd library import:**
   ```bash
   python
   ```
   
   In the Python interpreter, run:
   ```python
   from fabric_cicd import FabricWorkspace
   print("✅ fabric-cicd imported successfully!")
   exit()
   ```

   **Test fabric-cli command:**
   ```bash
   fab --version
   ```

   Expected output:
   ```
   Fabric CLI version 1.0.1 (07-2025)
   ```

   If version is greater than 1.0.1 it's ok!

   If both tests pass, your installation is complete! If you encounter errors, refer to the Troubleshooting section below.

> [!IMPORTANT]
> Keep your virtual environment activated for the duration of the workshop. You'll need to reactivate it if you open a new terminal session.

### ✅ Exercise 2 Checkpoint

**Before continuing, verify:**
- [ ] Python 3.11+ installed (`python3 --version`)
- [ ] Virtual environment created and activated
- [ ] fabric-cli installed (`fab --version` works)
- [ ] fabric-cicd imported successfully in Python
- [ ] Terminal shows `(fabric-de-workshop)` prefix

🎉 **Exercise 2 Complete!** Python environment is configured.

---

## 📝 Exercise 3: Install Visual Studio Code (5 minutes)

> **Goal:** Install and configure VSCode as your development environment.
>
> VSCode is your development environment where you'll write code and manage Git operations.

VSCode will be our primary development environment for the workshop.

### All Platforms
1. Download VSCode from [code.visualstudio.com](https://code.visualstudio.com/)
2. Install with default settings
3. **Install the Python extension:**
   - Open VSCode
   - Go to Extensions (Ctrl+Shift+X or Cmd+Shift+X)
   - Search for "Python" by Microsoft
   - Click "Install"

4. **Configure Python interpreter:**
   - Open Command Palette (Ctrl+Shift+P or Cmd+Shift+P)
   - Type "Python: Select Interpreter"
   - Choose the interpreter from your `fabric-de-workshop` virtual environment

> [!TIP]
> VSCode will automatically detect your virtual environment if you open a terminal within VSCode after activating it.

### ✅ Exercise 3 Checkpoint

**Before continuing, verify:**
- [ ] VSCode is installed and opens correctly
- [ ] Python extension is installed
- [ ] Python interpreter is configured
- [ ] You can open integrated terminal (Ctrl+`)

💻 **Exercise 3 Complete!** VSCode is ready for development.

---

## 📝 Exercise 4: Access Microsoft Fabric Portal (5 minutes)

> **Goal:** Log into Microsoft Fabric with workshop credentials.
>
> [!IMPORTANT]
> Use the credentials provided by your instructor. Do NOT use your company account.

### Navigate to Microsoft Fabric
Visit the Microsoft Fabric website at [https://fabric.microsoft.com/](https://fabric.microsoft.com/).

![Fabric Portal](../screenshots/setup/fabric-portal-login.png)

### Log In with Workshop Credentials
Use the credentials provided by the workshop instructor (typically on a business card or shared document).

![Login Credentials](../screenshots/setup/fabric-login.png)

### Enter Your Password and Sign In
Input your password in the designated field and click the `Sign In` button.

![Password Entry](../screenshots/setup/fabric-password.png)

### Update Your Password (If Required)
You may be required to update your password upon first login. Follow the prompts to do so.

> [!TIP]  
> **Write your new password in a secure location for reference during the workshop.**

### Setup Multi-Factor Authentication (MFA)
If prompted for MFA setup, you can defer this by selecting `Ask Me Later` for workshop purposes.

![MFA Setup](../screenshots/setup/fabric-mfa.png)

### Welcome to Microsoft Fabric
You have successfully logged in to Microsoft Fabric!

![Fabric Welcome](../screenshots/setup/fabric-welcome.png)

### Explore Data Engineering Workload
1. Click the Microsoft Fabric icon in the bottom left corner
2. Select **Data Engineering** from the workload menu

![Workload Selection](../screenshots/setup/fabric-workloads.png)

### ✅ Exercise 4 Checkpoint

**Before continuing, verify:**
- [ ] Successfully logged into Fabric portal
- [ ] Can see Data Engineering workload
- [ ] New password saved (if changed)
- [ ] No MFA blocks for workshop

🌐 **Exercise 4 Complete!** You have access to Microsoft Fabric.

---

## 📝 Exercise 5: Get the Workshop Code (5 minutes)

> **Goal:** Clone the workshop repository to your local machine.
>
> You'll work with a pre-built solution that demonstrates best practices for Fabric CI/CD.
>
> You'll use this solution only once to deploy the solution to the workspace.

### Set Up GitHub Account
1. **If you don't have a GitHub account:**
   - Visit [github.com](https://github.com)
   - Click "Sign up" and create a free account
   - Verify your email address

2. **If you have an existing GitHub account:**
   - Sign in at [github.com](https://github.com)

![GitHub Login](../screenshots/setup/github-login.png)

### 📦 Clone the Workshop Repository

1. **Open the workshop repository:**
   
   🔗 [https://github.com/DaniBunny/Fabric-DE-git-CI-CD](https://github.com/DaniBunny/Fabric-DE-git-CI-CD)

2. **Copy it to your machine:**
   
   **Option A: Using Git Command Line (Recommended)**
   ```bash
   # Navigate to your desired directory
   cd ~/Documents  # or your preferred location
   
   # Clone the repository
   git clone https://github.com/DaniBunny/Fabric-DE-git-CI-CD.git
   
   # Navigate into the cloned directory
   cd Fabric-DE-git-CI-CD
   ```

   **Option B: Using GitHub Desktop**
   - Download GitHub Desktop from [desktop.github.com](https://desktop.github.com/)
   - Use "Clone a repository from the Internet"
   - Enter: `https://github.com/DaniBunny/Fabric-DE-git-CI-CD`

   **Option C: Download ZIP (Not recommended for workshop)**
   - Click "Code" → "Download ZIP" on the GitHub repository page
   - Extract to your desired location

![Repository Clone](../screenshots/setup/github-clone.png)

### Verify Repository Structure
Your cloned repository should contain:
```
Fabric-DE-git-CI-CD/
├── configuration/          # Workshop setup files
├── deployment/            # Deployment scripts and guides
├── versioning/           # Git workflow guides  
├── screenshots/          # Workshop screenshots
├── README.md            # Main workshop guide
└── fabric-cli-and-cicd.md  # Tool comparison guide
```

### ✅ Exercise 5 Checkpoint

**Before continuing, verify:**
- [ ] Repository cloned successfully
- [ ] All folders are present
- [ ] Can navigate to repository in terminal
- [ ] GitHub account is accessible

📦 **Exercise 5 Complete!** Workshop code is ready.

---

## 📝 Exercise 6: Set Up Your Workspace in VSCode (2 minutes)

> **Goal:** Open the workshop repository in VSCode and verify setup.

1. **Launch VSCode**
2. **Open the workshop folder:**
   - **File** → **Open Folder** (WSL/Linux)
   - **File** → **Open** (macOS)
   - Navigate to and select the `Fabric-DE-git-CI-CD` folder you cloned

3. **Verify your setup:**
   - VSCode should show the repository files in the Explorer panel
   - The integrated terminal should be available (Terminal → New Terminal)
   - Python extension should be active

![VSCode Repository](../screenshots/setup/vscode-repository.png)

4. **Activate your virtual environment in VSCode terminal:**
   ```bash
   # Windows (WSL)
   source fabric-de-workshop/bin/activate
   
   # macOS/Linux  
   source fabric-de-workshop/bin/activate
   ```

5. **Test fabric-cli in VSCode terminal:**
   ```bash
   fab --help
   ```

> [!TIP]
> VSCode will remember this workspace configuration. You can reopen it anytime from **File** → **Open Recent**.

### ✅ Exercise 6 Checkpoint

**Before continuing, verify:**
- [ ] Repository opened in VSCode
- [ ] Files visible in Explorer panel
- [ ] Terminal shows correct directory
- [ ] Virtual environment activated in terminal
- [ ] `fab --help` works in VSCode terminal

🚀 **Exercise 6 Complete!** Your development environment is ready!

---

## ✅ Final Module Validation

> [!IMPORTANT]
> **DO NOT PROCEED** to Module 2 until all exercises are complete. This ensures a smooth workshop experience.

### 📊 Exercise Summary

| Exercise | Completed | What You Achieved |
|----------|-----------|------------------|
| **1. Install Git** | ✅ | Version control system ready |
| **2. Python & Tools** | ✅ | fabric-cli and fabric-cicd installed |
| **3. Install VSCode** | ✅ | Development environment configured |
| **4. Access Fabric** | ✅ | Logged into Microsoft Fabric portal |
| **5. Clone Repository** | ✅ | Workshop code on local machine |
| **6. VSCode Setup** | ✅ | Integrated development workspace ready |

### 🛠️ Tools & Environment
```bash
# Run these commands to verify:
□ git --version                    # Should show 2.25+
□ python3 --version                # Should show 3.11+
□ fab --version                    # Should show Fabric CLI version
□ pip list | grep fabric           # Should show both packages
```

### 🌐 Access & Accounts
- □ Can access https://fabric.microsoft.com
- □ Logged in with workshop credentials (NOT work account)
- □ Can see Data Engineering workload
- □ GitHub account is working

### 📁 Workshop Files
- □ Repository cloned to local machine
- □ VSCode opened with workshop folder
- □ Can see all folders: configuration/, deployment/, versioning/
- □ Terminal shows (fabric-de-workshop) in prompt

### 🚀 Ready to Continue?
Try this final test:
```bash
fab --help
```
If you see the fabric-cli help menu, you're ready!

## 🔧 Troubleshooting Guide

> [!TIP]
> Most issues can be resolved quickly. Check these common problems first:

#### Python/pip not found
**Problem**: `python` or `pip` command not recognized
**Solution**: 
- Windows (WSL): Use `python3` and `pip3` instead of `python` and `pip`
- macOS/Linux: Use `python3` and `pip3` instead of `python` and `pip`

#### fabric-cli installation fails
**Problem**: Permission errors during `pip install`
**Solution**:
```bash
# Use --user flag if virtual environment isn't working
pip install --user ms-fabric-cli fabric-cicd

# Or try upgrading pip first
pip install --upgrade pip
```

#### Git clone fails
**Problem**: Repository clone fails or access denied
**Solution**:
- Verify internet connection
- Check GitHub account permissions
- Try HTTPS clone instead of SSH

#### VSCode Python interpreter not found
**Problem**: VSCode can't find Python interpreter
**Solution**:
- Open Command Palette (Ctrl+Shift+P)
- Type "Python: Select Interpreter"
- Browse and select your virtual environment's Python executable

### Getting Help
- **fabric-cli**: [GitHub Issues](https://github.com/microsoft/fabric-cli/issues)
- **fabric-cicd**: [GitHub Documentation](https://github.com/microsoft/fabric-cicd)
- **Workshop specific**: Ask your instructor or check the troubleshooting sections in subsequent labs

---

## 🎉 Setup Complete!

**Congratulations!** Your environment is ready for the workshop.

> [!IMPORTANT]
> ### ✅ Module 1 Complete! Ready to Continue?
> 
> **Your Progress:** [1] ✅ → **[2]** → [3] → [4] → [5] → [6] → [7] → [8]
> 
> ### 🚀 **NEXT MODULE: First Deployment**
> 
> **📁 Location:** [`/deployment/bootstrap.md`](../deployment/bootstrap.md)  
> **⏱️ Duration:** 30 minutes  
> **🎯 You'll Build:**
> - Complete medallion architecture (Bronze → Silver → Gold)
> - Lakehouses with sample data
> - Data transformation notebooks
> - Power BI report with semantic model
> 
> **[→ Click here to start Module 2: First Deployment](../deployment/bootstrap.md)**

### Finished Early?

Explore these commands while waiting:
```bash
# See all fabric-cli commands
fab --help

# Check Python packages
pip list | grep fabric

# Explore the repository structure
ls -la
```

> [!NOTE]
> **Reminder:** Keep your virtual environment activated throughout the workshop. If you close your terminal, reactivate it with:
> - Windows (WSL): `source fabric-de-workshop/bin/activate`
> - Mac/Linux: `source fabric-de-workshop/bin/activate`