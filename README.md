# Configurações e Extensões do VS Code — Leandro dos Reis

Repositório de backup e sincronização das preferências e extensões do Visual Studio Code.

## 📦 Conteúdo

- `settings.json`: Configurações visuais, formatação, temas e preferências do editor.
- `extensions.txt`: Lista com todas as extensões instaladas no VS Code.
- `restore-extensions.sh`: Script para restaurar todas as configurações e extensões automaticamente.
- `backup-extensions.sh`: Script para atualizar os arquivos de backup locais com as novidades instaladas.

---

## 🚀 Como Restaurar Tudo em uma Nova Instalação

### Opção 1: Via Terminal (Script Automatizado)
Clone este repositório ou execute diretamente:
```bash
git clone https://github.com/Leandro-Reis-DEV/VS-CODE.git ~/.vscode-backup
cd ~/.vscode-backup
chmod +x restore-extensions.sh
./restore-extensions.sh
```

### Opção 2: Via Settings Sync do VS Code (Nuvem)
1. Abra o VS Code recém-instalado.
2. Clique na **Engrenagem** (canto inferior esquerdo) > **"Ativar Sincronização de Configurações..."**.
3. Selecione **GitHub** e faça login na conta **@Leandro-Reis-DEV**.
4. O VS Code baixará todas as preferências e extensões automaticamente em segundo plano.
