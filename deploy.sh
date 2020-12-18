docker build -t nalamahen/multi-client:latest -t nalamahen/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nalamahen/multi-server:latest -t nalamahen/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nalamahen/multi-worker:latest -t nalamahen/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nalamahen/multi-client:latest
docker push nalamahen/multi-server:latest
docker push nalamahen/multi-worker:latest

docker push nalamahen/multi-client:$SHA
docker push nalamahen/multi-server:$SHA
docker push nalamahen/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=nalamahen/multi-client:$SHA
kubectl set image deployments/server-deployment server=nalamahen/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=nalamahen/multi-worker:$SHA