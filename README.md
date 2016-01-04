# mago-talk

## Installing on raspaas

```
wget https://github.com/k-shino/mago-talk/raw/master/setup.sh
chmod +x ./setup.sh
./setup.sh

sudo ./raspaas/bootstrap.sh paas
cd ./mago-talk/
paas create
git push paas master
```