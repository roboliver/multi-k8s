docker build -t oliverrw93/multi-client:latest -t oliverrw93/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t oliverrw93/multi-server:latest -t oliverrw93/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t oliverrw93/multi-worker:latest -t oliverrw93/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push oliverrw93/multi-client:latest
docker push oliverrw93/multi-server:latest
docker push oliverrw93/multi-worker:latest

docker push oliverrw93/multi-client:$SHA
docker push oliverrw93/multi-server:$SHA
docker push oliverrw93/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=oliverrw93/multi-server:$SHA
kubectl set image deployments/client-deployment client=oliverrw93/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=oliverrw93/multi-worker:$SHA