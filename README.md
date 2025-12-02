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
| **Nome** | Yuri Alves Bordin |
| **RA** | 202310149 |
| **Nome** | Iago Armelin Piai |
| **RA** | 202310086 |
| **Nome do Banco** | RA_202310149_tarefas.db |
| **Campo Extra** | flagSincronizado (boolean) |
| **Tema** | temaMetal |

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

### Print do arquivo .db do banco de dados
<img width="499" height="229" alt="image" src="https://github.com/user-attachments/assets/62eacac3-1683-428f-8bb7-fa8bfcccdaba" />

### Print do código do método createDatabase()
<img width="533" height="252" alt="image" src="https://github.com/user-attachments/assets/f3d62637-b184-44c6-9f53-d2150169e162" />

### Print da tela de listagem com pelo menos 1 tarefa
<img width="407" height="864" alt="image" src="https://github.com/user-attachments/assets/69fdb97d-497c-496b-8b7c-d9eb45ae25d1" />

### Print do formulário preenchido antes de salvar
<img width="407" height="864" alt="image" src="https://github.com/user-attachments/assets/e67315ad-0bca-4111-9536-f1f73710b6f2" />

### Print do JSON do objeto criado no console
<img width="1172" height="36" alt="image" src="https://github.com/user-attachments/assets/ed78fe1e-4d51-43cc-9756-eb7ef0bc3a26" />

---

## 🎬 Vídeo Demonstrativo

https://drive.google.com/file/d/1DuufLQNPJGx-GN9PqQES-QceV813XVzZ/view

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
