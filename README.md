# The high priestess

ホスト用のDocker環境を構築する

## 必要なもの

> [!Note]
> Windows用の .bat ファイルは、以下の必要なソフトウェアも自動でインストールしますが、その場合スクリプトを再実行し直す必要があるかもしれません。
> 必須ではありませんが、手動でインストールしておくことをオススメします。

- [Docker](https://www.docker.com/ja-jp/)

```
winget install Docker.DockerDesktop 
```

- [Git](https://git-scm.com/install/windows)

```
winget install --id Git.Git -e --source winget
```

## 手順
### Windows
0. デフォルト設定を利用しない場合、`.env.sample` をコピーして `.env` を作成し、設定値を書き換える
1. init.bat をダブルクリックする
2. 以上

