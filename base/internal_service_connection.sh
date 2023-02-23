# kubectl is requried to connect to right cluster
# check service resolution/connection from gateway pod in SP namespace
# usage: internal_service_connection.sh <SP namespace list>
for sp_namespace in $@
do
  echo "namespace: ${sp_namespace}:"
  for pod in $(kubectl -n ${sp_namespace} get po -l app=gateway | grep gateway- | awk '{print $1}')
    do
      echo "    ${pod}:"
      kubectl -n ${sp_namespace} exec ${pod} -- /bin/bash -c 'curl -k stonehub:9333' #; nc -zv 172.20.0.10 53'
    done
  echo "------"
  echo ""
done