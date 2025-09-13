# dev-python

![Python](https://img.shields.io/badge/Python-3.13-065F97?logo=python&logoColor=CD9A0B)
![uv](https://img.shields.io/badge/uv-86944A?logo=uv&logoColor=271231)
![Ruff](https://img.shields.io/badge/Ruff-86944A?logo=ruff&logoColor=271231)
![Jupyter](https://img.shields.io/badge/Jupyter-CCCCCC?logo=jupyter&logoColor=C25F20)
![Pytest](https://img.shields.io/badge/Pytest-0480B5?logo=pytest&logoColor=white)

![Make](https://img.shields.io/badge/Make-822322?logo=gnu&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Compose-1658DB?logo=docker&logoColor=white)
![Devbox](https://img.shields.io/badge/Devbox-1C0147?logo=devbox&logoColor=white)
![lefthook](https://img.shields.io/badge/lefthook-282828?logo=lefthook&logoColor=FF2927)

## Python の開発環境

※ venv ディレクトリはプロジェクトルートに作成するように設定しています。

## 🛠 構築

### ◯ Docker を使用した開発環境構築

将来的にどこかにデプロイするような場合やインフラ担当、リーダーメンバーは Docker を使用して開発環境を構築すると良いかもしれません。

1. Docker コンテナビルド

```bash
$ cd docker
$ make
```

1. コンテナ立ち上げ

```bash
## make 後は立ち上がるので不要
$ make up
## python コンテナに入る
$ make exec-py
```

その他の make コマンドは `docker/Makefile` をご覧ください。

### ◯ Devbox を使用した開発環境構築（※ 試験的）

[Devbox](https://www.jetify.com/devbox) は [Nix (パッケージ管理システム) - Wikipedia](<https://ja.wikipedia.org/wiki/Nix_(%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E7%AE%A1%E7%90%86%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0)>) によって管理される隔離された開発環境を提供します。  
プロジェクトの依存関係を `devbox.json` ファイルに定義することで、異なるマシン間で一貫した環境を保証します。

Docker のオーバーヘッドがなく高速なので、まず開発を試す場合やインフラを気にしない場合は Devbox を利用するのが良いかもしれません。

#### ● Devbox のインストール

1.  公式の指示に従って Devbox をインストールします: [Devbox のインストール](https://www.jetpack.io/devbox/docs/installing-devbox/)。

#### ● 依存関係のインストール

```bash
$ devbox install
```

#### ● Devbox シェルに入る

プロジェクトルートから次のコマンドを実行して Devbox シェルを有効化します:

```bash
$ devbox shell

# Devbox シェルが起動し、（devbox）と表示されます。
(devbox) /bin/bash /Users/hoge/workspace/dev-python $
# Devbox シェル内で Python の依存関係をインストール
(devbox) /bin/bash /Users/hoge/workspace/dev-python $ uv sync
# Python スクリプトを実行を試す
(devbox) /bin/bash /Users/hoge/workspace/dev-python $ uv run python hello.py
# Devbox シェルから抜ける場合
(devbox) /bin/bash /Users/hoge/workspace/dev-python $ exit
```

## 📦 Python のパッケージマネージャー

[uv](https://docs.astral.sh/ruff/) を使用しています。  
そのため、ホストにインストールした uv で依存関係インストールをおこなっておけば、  
Docker や Devbox を使用せずとも Jupyter Notebook や Python スクリプトを実行できるはずです。

```bash
# 依存関係のインストール
$ uv sync

# 依存関係を追加
$ uv add hogehoge

# 依存関係を削除
$ uv remove hogehoge

# Python スクリプトを実行
$ uv run python hogehoge.py
```

## 🧪 テスト

[pytest](https://docs.pytest.org/) を使用しています

```bash
$ uv run pytest
```

## ✨ Linter、Formatter を実行

以下を使用しています。

- [Ruff](https://docs.astral.sh/ruff/) を使用しています。

  以前は以下を利用していましたが、Ruff は単独ですべてを網羅できるようにするもののようでそれに移行しました。

  - [isort](https://pycqa.github.io/isort/)  
    インポートをアルファベット順に並べ替え、自動的にセクションとタイプ別に分類する Python ユーティリティ/ライブラリ
  - [Flake8](https://flake8.pycqa.org/en/latest/)  
    Python ソースコードの論理エラーやスタイルをチェックするリンター
  - [Black](https://black.readthedocs.io/)  
    フォーマッター

VSCode の拡張機能を入れてください。  
`.vscode/extensions.json` に記載の拡張機能をインストールしてください。  
`jq` が必要ですが、`./vscode/extensions-installer.sh` で一括インストール可能です。
