# 🔐 GitHub Repository Access Checker

This script allows you to **list all users with read (pull) access** to a specific GitHub repository using the GitHub REST API.

> ✅ This is useful for auditing repository access permissions in your GitHub projects.

---

## 📦 Prerequisites

- A GitHub **Personal Access Token (Classic)** with `repo` scope
- An EC2 instance (Amazon Linux, Ubuntu, etc.)
- Internet access on the instance
- `jq` package installed (for parsing JSON)

---

## 🛠️ Step-by-Step Guide

### ✅ Step 1: Create and Connect to EC2

1. **Launch an EC2 instance** (Ubuntu preferred) from your AWS Console.
2. Open **MobaXterm** on your Windows system.
3. Use your `.pem` key to connect to your EC2 instance:
   ```bash
   ssh -i "your-key.pem" ec2-user@<your-ec2-public-ip>
### 🔽 Step 2: Clone the Repository Containing the Script
bash
Copy
Edit
git clone https://github.com/AdnanAhmad7065/DevOps-Project
cd DevOps-Project
This repository contains the script list.users that checks collaborators with read access.

### 🔐 Step 3: Generate a Personal Access Token
Go to: GitHub Developer Settings

Click on "Generate new token (Classic)"

Provide a note like access-checker-script

Select scopes:

✅ repo (Full control of private repositories — needed to view collaborators)

Click Generate Token and copy it immediately — it won’t be shown again.

This token is used to authenticate API requests to GitHub securely.

### 🔒 Step 4: Set Your GitHub Credentials as Environment Variables
bash
Copy
Edit
export username="your_github_username"
export token="your_generated_token"

### 📦 Step 5: Install jq (If Not Installed)
bash
Copy
Edit
sudo apt update && sudo apt install -y jq
jq is a command-line JSON processor — used to filter and format GitHub API responses.

### ⚙️ Step 6: Give Execute Permission to the Script
bash
Copy
Edit
chmod +x list.users

### 🚀 Step 7: Run the Script
bash
Copy
Edit
./list.users "repo_owner" "repo_name"
💡 Example:
bash
Copy
Edit
./list.users "AdnanAhmad7065" "DevOps-Project"
🔍 You can use this script to check any public repository if GitHub allows access via API, or you can create your own organization, add 2–3 members as collaborators, and try the script practically.


### 🧾 Output Example
bash
Copy
Edit
🔍 Listing users with read access to AdnanAhmad7065/DevOps-Project...
Users with read access to AdnanAhmad7065/DevOps-Project:
john-doe
qa-user
devops-bot
### 🧠 Notes
Ensure your GitHub username and token are correct.

The script uses the GitHub /collaborators API endpoint to check permissions.

Only users with pull: true permission are shown (i.e., read access).
