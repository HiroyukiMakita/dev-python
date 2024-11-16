#!/usr/bin/env bash

# [extensions.json で指定された VS Code 拡張をコマンドで一括インストールする | DevelopersIO](https://dev.classmethod.jp/articles/installing-vs-code-extensions-from-vscode-extensions-json-in-bulk-using-command/)

cd "$(dirname "$0")" || exit

# extensions.json ファイルのパス
EXTENSIONS_FILE="extensions.json"

# extensions.json が存在するか確認
if [ ! -f "$EXTENSIONS_FILE" ]; then
    echo "extensions.json ファイルが見つかりません: $EXTENSIONS_FILE"
    exit 1
fi

# recommendations を読み込み、それぞれの拡張機能をインストール
for ext in $(jq -r '.recommendations[]' $EXTENSIONS_FILE); do
    echo "拡張機能をインストールしています: $ext"
    code --install-extension "$ext"
done

echo "すべての拡張機能のインストールが完了しました。"