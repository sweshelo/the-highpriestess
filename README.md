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
1. ソースコードをZIPファイルでダウンロードし展開する:
https://github.com/sweshelo/the-highpriestess/archive/refs/heads/main.zip

2. デフォルト設定を利用しない場合、`.env.sample` をコピーして `.env` を作成し、設定値を書き換える
3. init.bat をダブルクリックする
4. 以上

