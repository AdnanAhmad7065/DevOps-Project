# 🚀 Kubernetes Service Exposed to World: Load Balancing & Service Discovery

This project demonstrates how to containerize a Python web application, deploy it on Kubernetes (Minikube), expose it to the outside world, and observe load balancing and service discovery using tools like **kubectl** and **Kubeshark**.
We also use **Kubeshark** (formerly known as Mizu) to visualize real-time traffic flowing through the Kubernetes cluster.

> 🎁 Credit: This project is based on [Abhishek Veeramalla's](https://github.com/iam-veeramalla) awesome [Docker-Zero-to-Hero](https://github.com/iam-veeramalla/Docker-Zero-to-Hero) repository.

---

## 🛠️ Tools & Technologies Used

- Docker
- Minikube (Kubernetes)
- kubectl
- Kubeshark
- Git
- Python/Django web app

---

## 📋 Prerequisites

### 1. ✅ Install Docker
Install Docker according to your OS:
- [Download Docker](https://docs.docker.com/get-docker/)

### 2. ✅ Install Minikube or KIND
We used **Minikube** for this project. Follow the docs to install:
- [Minikube Installation](https://minikube.sigs.k8s.io/docs/start/)
- [KIND (alternative)](https://kind.sigs.k8s.io/)

> 🧠 **Tip:** If you have free AWS credits, you can also use [kOps](https://kops.sigs.k8s.io/getting_started/aws/) to set up Kubernetes on AWS.

### 3. ✅ Install kubectl
Install the Kubernetes CLI `kubectl` to interact with the cluster:
- [Install kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

---

## 🧪 Project Steps

### Step 1: 🔁 Fork & Clone the Project

Fork this GitHub repo:

👉 [Abhishek’s Docker Zero to Hero Repo](https://github.com/iam-veeramalla/Docker-Zero-to-Hero)


git clone https://github.com/<your-username>/Docker-Zero-to-Hero.git
cd Docker-Zero-to-Hero/example-python-web-app/

**Step 2: 🐳 Build Docker Image**

check the Dockerfile from the repo link given above 

Use the provided Dockerfile to build your custom Docker image:

docker build -t adnanahmad7065/python-simple-app-demo:v1 .

Push it to DockerHub if needed:
docker push adnanahmad7065/python-simple-app-demo:v1

**Step 3: ⚙️ Create Deployment YAML**
Create deployment.yaml to manage app replicas:
(alreday attached in the repo)
vim deployment.yaml

Apply it:
kubectl apply -f deployment.yaml
Check status:
kubectl get deployments
kubectl get pods -o wide

**Step 4: 🌐 Create Service YAML (NodePort)**
Create a service.yaml to expose the app inside/outside the cluster.
(attached in the repo)

vim service.yaml

Apply it:
kubectl apply -f service.yaml

📝 Note: The selector must match the labels used in your deployment. If they differ, the service won’t find pods to route traffic to.

Check service status:
kubectl get svc

**Step 5: 🌍 Access the App**
You’ll get internal and external IPs from the output of:

minikube ip
kubectl get svc
Example (Your IPs will vary):

curl http://10.101.63.207:80/demo -L

Check via NodePort (external):


curl http://192.168.64.20:30007/demo -L

You might need to SSH into Minikube for IP visibility:

minikube ssh

🧠 What do you observe?

You can access the app via both cluster IP and NodePort.

Load is balanced across pods.

**Step 6: 🔁 Convert NodePort to LoadBalancer**
Edit the service directly:

kubectl edit svc python-django-sample-app

Change:
type: NodePort
to:
type: LoadBalancer

Or update service.yaml and re-apply.

📌 Observation:
If using Minikube, use the tunnel to simulate a LoadBalancer:

minikube tunnel

**Step 7: ⚠️ What If Labels Mismatch?**
If selector or pod labels don’t match:

Service will not discover any pods.

App won’t be reachable.

Use kubectl describe svc <svc-name> to troubleshoot.

**Step 8: 🧪 Load Balancing with Kubeshark**
Install Kubeshark for packet sniffing in K8s:


curl https://raw.githubusercontent.com/kubeshark/kubeshark/main/scripts/install.sh | bash

Access on:


http://localhost:8899

Run this command a few times to simulate load:

curl http://192.168.64.10:30007/demo

Then open Kubeshark dashboard and observe packet flow between pods — verifying real-time load balancing.

✅ Final Takeaways
You learned to deploy a Python web app on Kubernetes.

You used NodePort and LoadBalancer types to expose services.

You observed service discovery and load balancing behavior.

You verified traffic flow using Kubeshark.

