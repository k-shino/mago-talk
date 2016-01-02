# mago-talk

## Installing on raspaas

```
sudo apt-get update
sudo apt-get install git -y
git clone https://github.com/k-shino/dotfiles.git
chmod +x ./dotfiles/init.sh
git clone https://github.com/k-shino/mago-talk.git
sudo ./raspaas/bootstrap.sh paas
cd ./mago-talk/
paas create
git push paas master
```
