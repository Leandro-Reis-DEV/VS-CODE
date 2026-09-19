#!/usr/bin/env bash

# ==============================================================================
# Script de Restauração do VS Code (Preferências e Extensões)
# Gerado pelo Jarvis para Leandro dos Reis
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXT_FILE="${SCRIPT_DIR}/extensions.txt"
SETTINGS_SRC="${SCRIPT_DIR}/settings.json"

# Caminho de destino das configurações no macOS
VSCODE_USER_DIR="${HOME}/Library/Application Support/Code/User"

echo "========================================================"
echo "⚙️  Restauração do Visual Studio Code"
echo "========================================================"

# 1. Restaurar configurações (settings.json)
if [ -f "$SETTINGS_SRC" ]; then
    echo "📄 Restaurando preferências (settings.json)..."
    mkdir -p "$VSCODE_USER_DIR"
    cp "$SETTINGS_SRC" "${VSCODE_USER_DIR}/settings.json"
    echo "   ✅ Preferências restauradas em: ${VSCODE_USER_DIR}/settings.json"
fi

# 2. Garante que o comando 'code' está disponível
if ! command -v code &> /dev/null; then
    if [ -f "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" ]; then
        export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
    else
        echo "❌ Erro: O comando 'code' do VS Code não foi encontrado no PATH."
        echo "Abra o VS Code, pressione Cmd+Shift+P e selecione 'Shell Command: Install code command in PATH'."
        exit 1
    fi
fi

# 3. Restaurar extensões
if [ ! -f "$EXT_FILE" ]; then
    echo "❌ Arquivo de extensões não encontrado em: $EXT_FILE"
    exit 1
fi

TOTAL=$(wc -l < "$EXT_FILE" | tr -d ' ')
echo ""
echo "🚀 Instalando $TOTAL extensões do VS Code..."
echo "--------------------------------------------------------"

COUNT=0
FAILURES=0

while IFS= read -r ext || [ -n "$ext" ]; do
    [[ -z "$ext" || "$ext" =~ ^# ]] && continue
    COUNT=$((COUNT + 1))
    echo "[$COUNT/$TOTAL] Instalando: $ext"
    if code --install-extension "$ext" --force; then
        echo "   ✅ $ext instalado com sucesso."
    else
        echo "   ⚠️ Falha ao instalar: $ext"
        FAILURES=$((FAILURES + 1))
    fi
done < "$EXT_FILE"

echo "--------------------------------------------------------"
if [ "$FAILURES" -eq 0 ]; then
    echo "🎉 Concluído com sucesso! Preferências e extensões restauradas."
else
    echo "⚠️ Concluído com $FAILURES falha(s). Verifique a lista acima."
fi
