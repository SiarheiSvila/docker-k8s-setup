# k8s-setup (Minikube)
### Here are instructions on how to Setup Kubernetes with docker running on WSL
1. Check docker installation both on WSL and Windows:
```
docker ps -a
```
2. Download kubectl on WSL
```
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
kubectl version
```
You should see version, but also a message `The connection to the server localhost:8080 was refused - did you specify the right host or port?`

3. Install minikube
`docker ps | grep kube-apiserver` - should have empty output
```
sudo apt install -y conntrack
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x ./minikube
sudo mv ./minikube /usr/local/bin
minikube config set driver docker
```
4. Start minikube:
` minikube start`
It should have output like:
<img width="563" alt="image" src="https://github.com/SiarheiSvila/docker-k8s-setup/assets/47723898/2bb5cf79-6dba-4a3a-96c5-1b0cbb3f978d">

5. Test intsallation with `kubectl get ns` - this command returns all namespaces from your minikube cluster
6. Install kubectl at Windows:
https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/
To ensure installation is correct, run `kubectl version`. Same as at first steps in for WSL you should see `connection refused` message
7. Configure Windows kubectl same as WSL minikube
- see contents of WSL kubectl config file. To do this, run `cat ~/.kube/config`
- go to Windows kubectl config file: `C:\Users\{user}\.kube.config}` and copy content of WSL config to Windows config
- change `certificate-authority`, `client-certificate`, `client-key` properties with `\\wsl.localhost\Ubuntu`
Example of WSL kubectl config:

<img width="446" alt="image" src="https://github.com/SiarheiSvila/docker-k8s-setup/assets/47723898/5d204e3f-55d2-41da-87a5-74421c8495b8">

Windows kubectl config:

<img width="589" alt="image" src="https://github.com/SiarheiSvila/docker-k8s-setup/assets/47723898/0f428e97-77dd-4cd1-8b02-2093303b0134">

8. Check installation
- download example file: `curl -lo nginx.yaml "https://raw.githubusercontent.com/siarheisvila/docker-k8s-setup/master/k8s-nginx.yml"`
- run it in PowerShell/Cmd: `kubectl apply --f nginx.yaml`
- verify everything started up with: `kubectl get all`
- port-forward deployment to 8085: `kubectl port-forward service/nginx 8085:80` and check your browser at `localhost:8085`
- run `kubectl delete --f nginx.yaml`

