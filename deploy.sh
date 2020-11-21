docker build -t mviitane/multi-client:latest -t mviitane/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mviitane/multi-server:latest -t mviitane/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mviitane/multi-worker:latest -t mviitane/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mviitane/multi-client:latest
docker push mviitane/multi-server:latest
docker push mviitane/multi-worker:latest

docker push mviitane/multi-client:$SHA
docker push mviitane/multi-server:$SHA
docker push mviitane/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mviitane/multi-server:$SHA
kubectl set image deployments/client-deployment client=mviitane/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mviitane/multi-worker:$SHA
