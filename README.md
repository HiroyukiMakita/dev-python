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
