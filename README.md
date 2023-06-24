# docker-python

## Python の開発環境

以下を参考に作成しています。
[Python 開発環境構築手順（VSCode, Docker, Poetry, isort, black, flake8, pytest） - Qiita](https://qiita.com/nokoxxx1212/items/da1832468cbd9a762a46)

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
$ make exec-python
```

その他の make コマンドは `docker/Makefile` をご覧ください。

1. ライブラリのインストール

[Poetry](https://python-poetry.org/) を使用しています

```
// 初回ビルド後はコンテナ内で以下を実行
$ poetry install
```

## テスト

[pytest](https://docs.pytest.org/) を使用しています

```
$ poetry run pytest
```

## Linter、Formatter を実行

以下を使用しています。

- [isort](https://pycqa.github.io/isort/)
  インポートをアルファベット順に並べ替え、自動的にセクションとタイプ別に分類する Python ユーティリティ/ライブラリ
- [Flake8](https://flake8.pycqa.org/en/latest/)
  Python ソースコードの論理エラーやスタイルをチェックするリンター
- [Black](https://black.readthedocs.io/)
  フォーマッター

```
$ poetry run isort src tests
$ poetry run black src tests
$ poetry run flake8 src tests
```

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
