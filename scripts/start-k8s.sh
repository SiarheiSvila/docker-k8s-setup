#!/usr/bin/env bash

minikube start
cp ~/.kube/config /mnt/c/Users/{WINDOWS_USER_NAME}/.kube/config
sed -i 's@/home/{LINUX_USER_NAME}/.minikube/ca.crt@\\\\wsl.localhost\\Ubuntu\\home\\{LINUX_USER_NAME}\\.minikube\\ca.crt@g' /mnt/c/Users/Siarhei_Svila/.kube/config
sed -i 's@/home/{LINUX_USER_NAME}/.minikube/profiles/minikube/client.crt@\\\\wsl.localhost\\Ubuntu\\home\\{LINUX_USER_NAME}\\.minikube\\profiles\\minikube\\client.crt@g' /mnt/c/Users/{WINDOWS_USER_NAME}/.kube/config
sed -i 's@/home/{LINUX_USER_NAME}/.minikube/profiles/minikube/client.key@\\\\wsl.localhost\\Ubuntu\\home\\{LINUX_USER_NAME}\\.minikube\\profiles\\minikube\\client.key@g' /mnt/c/Users/WINDOWS_USER_NAME/.kube/config
