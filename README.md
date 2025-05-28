# docker-python

![Python](https://img.shields.io/badge/Python-3.13-065F97?logo=python&logoColor=CD9A0B)
![uv](https://img.shields.io/badge/uv-86944A?logo=uv&logoColor=271231)
![Ruff](https://img.shields.io/badge/Ruff-86944A?logo=ruff&logoColor=271231)
![Jupyter](https://img.shields.io/badge/Jupyter-CCCCCC?logo=jupyter&logoColor=C25F20)
![Pytest](https://img.shields.io/badge/Pytest-0480B5?logo=pytest&logoColor=white)

![Make](https://img.shields.io/badge/Make-822322?logo=gnu&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Compose-1658DB?logo=docker&logoColor=white)
![lefthook](https://img.shields.io/badge/lefthook-282828?logo=lefthook&logoColor=FF2927)

## Python の開発環境

※ venv ディレクトリはプロジェクトルートに作成するように設定しています。

## 構築

1. Docker コンテナビルド

```
$ cd docker
$ make
```

1. コンテナ立ち上げ

```
// make 後は立ち上がるので不要
$ make up
// python コンテナに入る
$ make exec-py
```

その他の make コマンドは `docker/Makefile` をご覧ください。

## ライブラリのインストール

[uv](https://docs.astral.sh/ruff/) を使用しています

```
$ uv add hogehoge
```

## テスト

[pytest](https://docs.pytest.org/) を使用しています

```
$ uv run pytest
```

## Linter、Formatter を実行

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

## Devbox 開発環境

Devbox は Nix によって管理される隔離された開発環境を提供します。プロジェクトの依存関係を `devbox.json` ファイルに定義することで、異なるマシン間で一貫した環境を保証します。

### Devbox のインストール

1.  公式の指示に従って Devbox をインストールします: [Devbox のインストール](https://www.jetpack.io/devbox/docs/installing-devbox/)。

### セットアップ

1.  `devbox` ディレクトリに移動します:
    ```bash
    cd devbox
    ```
2.  環境ファイルの例をコピーします:
    ```bash
    cp .env.example .env
    ```
3.  `devbox/.env` を編集して、希望の `PYTHON_VERSION` を設定します。例:
    ```env
    PYTHON_VERSION=3.11
    ```
    サポートされているバージョンは通常 `3.11`、`3.12`、`3.13` のような形式です。Devbox シェルを開始すると、`init_hook` スクリプトがこのバージョンを読み取り、対応する Nix パッケージ名（例: `python311`）を構築し、`devbox add <package_name>@latest` を使用して追加・インストールを試みます。このプロセスは、新しい Python パッケージがまだリストされていない場合、`devbox.json` も更新します。

### 有効化

`devbox/` ディレクトリ内から次のコマンドを実行して Devbox シェルを有効化します:

```bash
devbox shell
```

`init_hook` が実行され、`.env` ファイルが読み込まれ、指定した Python バージョンがインストールされていることが確認されます。

### Jupyter Notebook の実行

Devbox シェル内（そしてまだ `devbox/` ディレクトリ内）で、Jupyter Lab を起動できます:

```bash
devbox run jupyter
```

これにより Jupyter Lab が起動し、`http://localhost:8888` でアクセス可能になります。`--notebook-dir=../` 引数により、Jupyter Lab がプロジェクトのルートディレクトリで開かれ、プロジェクト全体のノートブックやファイルにアクセスできます。

### `uv` の使用

`uv` パッケージマネージャーは Devbox 環境に含まれています。シェルがアクティブになったら、`uv` コマンドを直接使用できます:

```bash
uv add <package-name>
uv run <script-name>
```

### Python バージョン管理に関する注意

`devbox.json` の `init_hook` は、Python バージョンを動的に管理するように設定されています。`devbox shell` が呼び出されると、`devbox/.env` から `PYTHON_VERSION` を読み取り、`devbox add python<ドットなしバージョン>@latest`（例: `devbox add python311@latest`）を実行します。

これには2つの影響があります:
1.  指定された Python パッケージがまだ存在しない場合、Devbox によって `devbox.json` が自動的に変更され、そのパッケージが含まれます。
2.  `.env` の `PYTHON_VERSION` を頻繁に変更すると、複数の Python バージョン（例: `python311`、`python312`）が時間とともに `devbox.json` の `packages` 配列に蓄積される可能性があります。これは通常問題を引き起こしませんが（Devbox は最後に追加されたもの、またはプライマリとして設定されたものを使用します）、注意すべき点です。必要に応じて `devbox.json` を手動でクリーンアップできます。

`init_hook` はまた、インストール試行後に Python のバージョンを検証します。
