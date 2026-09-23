# Catálogo de Jogos 🎮

Aplicativo Flutter desenvolvido como trabalho final da disciplina
**Desenvolvimento Mobile I** do curso de Análise e Desenvolvimento de
Sistemas — Unilavras.

---

## 👤 Autor

- **Nome**: Fernando da Silva Pires
- **Matrícula**: 0009662
- **Curso**: Superior de Tecnologia em Análise e Desenvolvimento de Sistemas
- **Disciplina**: Desenvolvimento Mobile I
- **Período**: 4º Período — 2º Semestre / 2026
- **Instituição**: Unilavras — Lavras/MG

---

## 📱 Sobre o trabalho

Trabalho final da disciplina **Desenvolvimento Mobile I** (vale 13 pontos).
Aplicativo Flutter que implementa um **catálogo pessoal de jogos** com:

- Navegação entre telas (lista → detalhe → formulário)
- Coleção dinâmica com **estado vazio**
- Formulário validado com feedback útil ao usuário
- Criação e edição refletidas no estado local (sem duplicação)
- Modelo de domínio e widgets reutilizáveis
- Tema **Material 3** com cuidados de acessibilidade
- **Layout adaptativo** (1 coluna em telas estreitas, 2 colunas em telas largas)
- **Teste de widget** cobrindo estado vazio e coleção com itens
- Análise estática (`flutter analyze`) sem avisos

### Fluxo principal

1. Tela de **lista** mostra a coleção em cards.
2. Toque em um jogo → abre a tela de **detalhe** com todas as informações.
3. Botão **lápis** no detalhe → abre o **formulário** pré-preenchido (edição).
4. Botão **+** (FAB) na lista → abre o formulário em branco (criação).
5. O formulário **valida** os campos antes de salvar e mostra mensagens de erro.
6. Ao salvar, a coleção é atualizada **em memória** (M1 não usa persistência).

---

## 🚀 Como executar

### Pré-requisitos

- **Flutter** 3.47.0 (stable) ou superior
- **Dart** 3.13.0 ou superior
- **Android SDK** 35 ou superior (com `cmdline-tools` e `NDK`)
- **Git**
- Emulador Android ou dispositivo físico

### Passos

```bash
# 1. Clone o repositório
git clone https://github.com/FernandoPires17/catalogo-jogos.git
cd catalogo-jogos

# 2. Obtenha as dependências
flutter pub get

# 3. Verifique o ambiente
flutter doctor

# 4. Rode a análise estática
flutter analyze

# 5. Rode os testes
flutter test

# 6. Rode o app (com emulador ou dispositivo conectado)
flutter run
```

### Gerar o APK release

```bash
flutter build apk --release
```

O APK fica em: `build/app/outputs/flutter-apk/app-release.apk`

---

## 📂 Estrutura do projeto

```
lib/
├── models/
│   └── jogo.dart              # Modelo de domínio (Jogo)
├── screens/
│   ├── lista_page.dart        # Tela principal (lista + estado vazio)
│   ├── detalhe_page.dart      # Tela de detalhe do jogo
│   └── formulario_page.dart   # Formulário de criação/edição
├── widgets/
│   ├── jogo_card.dart         # Card reutilizável do jogo
│   └── estado_vazio.dart      # Widget de estado vazio
├── theme/
│   └── app_theme.dart         # Tema Material 3
└── main.dart                  # Entrada do app

test/
└── widget_test.dart           # Testes de widget
```

---

## 🏷️ Versão avaliada

- **Tag**: `m1-entrega`
- **Hash do commit**: `(será preenchido após criar a tag)`

---

## 📋 Checklist da rubrica

| # | Critério | Status |
|---|----------|--------|
| 1 | Identificação, objetivo e fluxo | ✅ |
| 2 | Repositório, versão e instruções | ✅ |
| 3 | Execução e artefato Android | ✅ |
| 4 | Duas ou mais telas e navegação | ✅ |
| 5 | Coleção dinâmica e estado vazio | ✅ |
| 6 | Detalhe do item selecionado | ✅ |
| 7 | Formulário e validação | ✅ |
| 8 | Criação e edição no estado local | ✅ |
| 9 | Modelo e widgets organizados | ✅ |
| 10 | Dois espaços de tela sem overflow | ✅ |
| 11 | Tema e acessibilidade | ✅ |
| 12 | Análise e teste de widget | ✅ |
| 13 | Decisões, fontes e autoria | ✅ |

---

## 📜 Licença

Projeto acadêmico, sem fins comerciais.