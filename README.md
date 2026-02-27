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

> [!Important]
> セキュリティについて警告されることがあります。その場合は画面内の警告文を確認の上、実行を許可してください。

4. http://localhost:8080 にアクセスしてゲームを開始

> [!Note]
> `.env` 内の `PORT` を変更すれば、ポート番号を 8080 以外の値に変更できます。
>
> なお、サーバとクライアントで6000番と4000番のポートを使用するため、このポートが使われていない必要があります。
> 使用済みの場合は必要に応じて docker-compose.yml を編集し、外部ポート番号を変更して下さい。
