docker build -t aryan9600/multi-client:latest -t aryan9600/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aryan9600/multi-server:latest -t aryan9600/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aryan9600/multi-worker:latest -t aryan9600/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aryan9600/multi-client:latest
docker push aryan9600/multi-server:latest
docker push aryan9600/multi-worker:latest

docker push aryan9600/multi-client:$SHA
docker push aryan9600/multi-server:$SHA
docker push aryan9600/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=aryan9600/multi-client:$SHA
kubectl set image deployments/server-deployment server=aryan9600/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=aryan9600/multi-worker:$SHA
