# docker-python

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

- [Ruff](https://docs.astral.sh/ruff/)
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


[![My Skills](https://skillicons.dev/icons?i=js,html,css,wasm)](https://skillicons.dev)

</a>
<a href="https://python-poetry.org/">
<img alt="Poetry" src="https://python-poetry.org/images/logo-origami.svg"
  height="150"
/>
</a>

</a>
<a href="https://docs.pytest.org/">
<img alt="pytest" src="https://docs.pytest.org/en/7.3.x/_static/pytest_logo_curves.svg"
  height="150"
/>
</a>

</a>
<a href="https://pycqa.github.io/isort/">
<img alt="isort" src="https://raw.githubusercontent.com/pycqa/isort/main/art/logo_large.png"
  height="150"
/>
</a>

</a>
<a href="https://flake8.pycqa.org/en/latest/">
<img alt="flake8" src="https://www.python.org/static/img/python-logo-large.c36dccadd999.png?1576869008"
  height="150"
/><span>flake8</span>
</a>

</a>
<a href="https://black.readthedocs.io/">
<img alt="Black" src="https://black.readthedocs.io/en/stable/_static/logo2-readme.png"
  height="150"
/>
</a>
