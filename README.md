# Task Manager - Prova Prática Flutter

Um aplicativo Flutter que implementa o sistema **CRUD** (Create, Read, Update, Delete) para gerenciar tarefas com prioridades e campo personalizado de sincronização.

## 📋 Descrição do Aplicativo

Este aplicativo foi desenvolvido como projeto acadêmico para demonstrar o domínio de:
- **SQLite** com **sqflite** para persistência de dados
- **CRUD completo** funcionando
- **UI/UX** com tema consistente
- **Validações** de formulário
- **Atualização automática** de interface

### Funcionalidades Principais

✅ **Criar** nova tarefa com validação  
✅ **Listar** todas as tarefas em ListView  
✅ **Editar** tarefa existente  
✅ **Deletar** tarefa com confirmação  
✅ **Campo Extra**: `Sincronizar`  
✅ **Prioridades**: BAIXA, MÉDIA, ALTA com cores visuais  
✅ **Banco SQLite** com RA no nome do arquivo  
✅ **Tema consistente**: temaMetal (Cinza + Azul)

---

## 📊 Dados do Aluno

| Campo | Valor |
|-------|-------|
| **RA** | 202310149 |
| **Nome do Banco** | RA_202310149_tarefas.db |
| **Campo Extra** | flagSincronizado (boolean) |
| **Tema** | temaMetal |
| **Cor Primária** | Grey (#757575) |
| **Cor Secundária** | Blue (#1976D2) |

---

##  Estrutura do Projeto

```
lib/
├── main.dart                 # Entrada da aplicação + Telas
├── models/
│   └── tarefa_model.dart     # Modelo de Tarefa com CRUD
├── database/
│   └── database_helper.dart  # SQLite Helper
├── themes/
│   └── app_theme.dart        # Tema da aplicação
└── pubspec.yaml              # Dependências
```

### Arquivos Principais

1. **tarefa_model.dart** - Modelo de dados com conversão JSON
2. **database_helper.dart** - Helper SQLite com CRUD completo
3. **main.dart** - Telas (Listagem, Formulário, Detalhes)
4. **app_theme.dart** - Tema visual (Cinza + Azul)

---

## 🗄️ Banco de Dados

### Arquivo do Banco
```
RA_202310149_tarefas.db
```

### Estrutura da Tabela `tarefas`
```sql
CREATE TABLE tarefas (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  titulo TEXT NOT NULL,
  descricao TEXT,
  prioridade TEXT NOT NULL,
  criadoEm TEXT NOT NULL,
  flagSincronizado INTEGER DEFAULT 0
);
```

### Campos da Tarefa

| Campo | Tipo | Descrição |
|-------|------|-----------|
| id | INTEGER | Identificador único auto-incremento |
| titulo | TEXT | Título da tarefa (obrigatório) |
| descricao | TEXT | Descrição detalhada |
| prioridade | TEXT | BAIXA, MÉDIA ou ALTA |
| criadoEm | TEXT | Data/hora ISO 8601 |
| flagSincronizado | INTEGER | 0=false, 1=true |

---

## 🔧 Dependências

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.2.8+4
  path_provider: ^2.1.1
  intl: ^0.19.0
```
---

## 🚀 Como Executar

### Pré-requisitos
- Flutter 3.0+
- Dart 3.0+
- VS Code ou Android Studio

### Passos

1. **Clone o repositório**
```bash
git clone https://github.com/seu-usuario/flutter-crud-tarefas.git
cd flutter-crud-tarefas
```

2. **Instale as dependências**
```bash
flutter pub get
```

3. **Execute o aplicativo**
```bash
flutter run
```
---

## 📸 Screenshots Inclusos

O repositório contém screenshots de:
- ✅ Banco de dados criado (DB Browser)
- ✅ Método `createDatabase()` no código
- ✅ Tela de listagem com tarefas
- ✅ Formulário preenchido
- ✅ JSON do objeto criado
- ✅ Arquivo .db com RA no nome

---

## 🎬 Vídeo Demonstrativo



---

## 🛠️ Dificuldades Encontradas

### 1. Sincronização de Estado
**Problema**: Após operações CRUD, a ListView não atualizava automaticamente.  
**Solução**: Usar `setState()` com `_carregarTarefas()` após cada operação.

### 2. Validação de Formulário
**Problema**: Campos vazios eram aceitos.  
**Solução**: Implementar `FormState.validate()` com `validator` em cada campo.

### 3. Formatação de Datas
**Problema**: Datas ISO 8601 não eram legíveis.  
**Solução**: Usar `intl: ^0.19.0` com `DateFormat`.

### 4. Conversão SQLite ↔ Dart
**Problema**: SQLite não tem tipo boolean nativo.  
**Solução**: Usar INTEGER (0/1) e converter em Tarefa.fromMap().

### 5. Caminho do Banco
**Problema**: Banco não era criado no local correto.  
**Solução**: Usar `getApplicationDocumentsDirectory()` + `path_provider`.


## 📄 Licença

Este projeto foi desenvolvido para fins educacionais.