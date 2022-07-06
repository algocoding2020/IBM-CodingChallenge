docker build -t amar/multi-client -f ./client/Dockerfile ./client
docker build -t amar/multi-server -f ./server/Dockerfile ./server
docker build -t amar/multi-worker -f ./worker/Dockerfile ./worker

docker push amar/multi-client:latest
docker push amar/multi-server:latest
docker push amar/multi-worker:latest



kubectl apply -f k8s
kubectl set image deployments/server-deployment server=amar/multi-server
kubectl set image deployments/client-deployment client=amar/multi-client
kubectl set image deployments/worker-deployment worker=amar/multi-worker