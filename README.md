# mago-talk

## Installing on raspaas

```
sudo apt-get install git -y
git clone https://github.com/k-shino/mago-talk.git
chmod +x ./mago-talk/setup.sh
./mago-talk/setup.sh

sudo ./raspaas/bootstrap.sh paas
cd ./mago-talk/
paas create
git push paas master
```
