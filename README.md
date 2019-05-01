# linuxenv

suinの仮想Linux環境。ローカルの開発環境向け。

## 構成

* Vagrant
	* NFS
* Ubuntu 16.04
* Docker CE
* VMware Fusion

## 要件

* Homebrewインストール済み

## 推奨

* VMware Fusion 11のライセンス購入済み
* vagrant-vmware-desktopのライセンス購入済み

一応virtualboxでも動くはず。

## なぜVMware Fusion?

* Virtualboxより速いから
	* [VirtualBoxはVMwareの5倍遅いのか改めて検証してみた - Qiita](https://qiita.com/suin/items/c4ba1cfd354586bbed59)
	* [ScalaのコンパイルはVirtualBox環境だと5倍時間がかかる - Qiita](https://qiita.com/reoring/items/df338d715c271c14a663)
* なぜ、Docker for Macじゃない？
	* 遅いから
	* [hanhan's blog - Docker for Macのmount遅い問題まとめ](https://blog.hanhans.net/2017/05/23/docker-for-mac-slow/)
	* NFSに比べて体感10倍くらい遅い
* なぜ、dinghyじゃない？
	* dinghyはNFSで共有できるディレクトリが1つしか指定できないから。
	* macOSに作った/Volume/devをマウントしながら、/Users/suinをマウントするってことができない。
	* /tmpに依存するdgossがちゃんと使えない。

あと、dockerまわりのツール(docker, docker-compose, dgossなど)がすべて仮想Linuxに入るので、Macの環境が汚れにくい。仮想Linuxが汚れたら作り直せばいいけど、Mac環境はなかなかそうもいかない。

## 使い方

### セットアップ

下記コマンドを実行すると、HomebrewでVMware FusionとVagrantが入る。また、vagrant-vmware-desktopのライセンスのアクティベーションがされる。

```
./setup.sh
```

`git clone`後の初回だけこれをやればいい。

### 日常的な使用法

仮想Linuxの起動:

```
vagrant up
```

仮想Linuxにログイン:

```
vagrant ssh
```
