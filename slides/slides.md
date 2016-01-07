# しゃべるMAGONIA on docker PaaS

@sinohara

2016.1.8

---

# モチベーション

* <p class="fragment">PaaS勉強会で知った技術を使ってみたい</p>
* <p class="fragment">ruby触ってみたい</p>
* <p class="fragment">MAGONIAかわいい</p>

---

# 時間無いのでとっととデモします


---

# 環境の用意

* サーバ借りるところから
* AWS EC2を使用
* OSはubuntu
* セキュリティルール インバウンドのHTTP通信を許可

---

![Alt Text](./fig1.png)

---

# セットアップ

```sh
$ wget https://github.com/k-shino/mago-talk/raw/master/setup.sh
$ chmod +x ./setup.sh
$ ./setup.sh
```

## やってること

* dockerのインストール
* docker PaaS(tetsusat氏作成)のダウンロード
* mago-talkプログラムのダウンロード

---

![Alt Text](./fig2.png)

---

# サービスの起動

```sh
$ sudo ./raspaas/bootstrap.sh mago-talk
```

## やってること

* docker PaaSでサービス起動
 * nginx(LoadBalancer)の起動
 * gitreceive(gitフック)
 * Consul / Consul Template
 * registrator
 * Docker Compose

---

![Alt Text](./fig3.png)

---

# アプリのデプロイ
     フォルダ移動、create、push
     やってること 言語の確認、rubyのdockrイメージのダウンロード、dockerfile自動生成、デプロイ

---

![Alt Text](./fig4.png)

---

![Alt Text](./fig5.png)
