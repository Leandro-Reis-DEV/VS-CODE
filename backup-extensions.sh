#!/usr/bin/env bash

# ==============================================================================
# Script de Atualização do Backup do VS Code (Preferências e Extensões)
# Gerado pelo Jarvis para Leandro dos Reis
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXT_FILE="${SCRIPT_DIR}/extensions.txt"
SETTINGS_SRC="${HOME}/Library/Application Support/Code/User/settings.json"
SETTINGS_DST="${SCRIPT_DIR}/settings.json"

if ! command -v code &> /dev/null; then
    if [ -f "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" ]; then
        export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
    else
        echo "❌ Erro: O comando 'code' do VS Code não foi encontrado."
        exit 1
    fi
fi

echo "📦 Coletando extensões instaladas no VS Code..."
code --list-extensions > "$EXT_FILE"
TOTAL=$(wc -l < "$EXT_FILE" | tr -d ' ')
echo "✅ Extensões salvas: $TOTAL"

if [ -f "$SETTINGS_SRC" ]; then
    echo "📄 Copiando configurações (settings.json)..."
    cp "$SETTINGS_SRC" "$SETTINGS_DST"
    echo "✅ settings.json atualizado com sucesso."
fi

echo "🎉 Backup local atualizado em: $SCRIPT_DIR"
