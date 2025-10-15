# Tarefas para adicionar Firebase (Realtime Database) ao projeto

Este checklist cobre: configuração do Firebase no Flutter (Android, iOS, Web/desktop quando aplicável), instalação de dependências, inicialização, segurança (Rules) e tarefas CRUD para salvar/buscar/excluir/atualizar os modelos Personagem, Item, Cidade, Missao no Realtime Database.

Observações rápidas
- Projeto atual usa Kotlin DSL no Gradle (build.gradle.kts) e Flutter 3.9 (Dart 3.9). Instruções abaixo consideram isso.
- Nome/appId Android atual: `com.example.ticket_personagen`. Caso for publicar, ajuste o applicationId antes de registrar no Firebase.
- Os modelos em `lib/models` não têm fromJson/toJson ainda. Vamos incluir camadas de mapeamento nas tarefas CRUD.

## 1) Configuração do Firebase

1. Console Firebase
	 - Criar projeto no console Firebase.
	 - Ativar Realtime Database (modo bloqueado por regras; ver seção "Rules").
	 - Ativar Authentication (opcional, mas recomendado). Para desenvolvimento, pode começar sem auth e usar regras temporárias restritas ao seu app.

2. Adicionar apps ao projeto Firebase
	 - Android:
		 - Registrar pacote: `com.example.ticket_personagen` (ou o seu definitivo).
		 - Baixar `google-services.json` e colocar em `android/app/google-services.json`.
	 - iOS (se for rodar no iOS):
		 - Registrar iOS bundle id (ex.: `com.example.ticketPersonagen`).
		 - Baixar `GoogleService-Info.plist` e colocar em `ios/Runner/GoogleService-Info.plist`.
	 - Web (se rodar no Web):
		 - Registrar app web e copiar as credenciais (apiKey, authDomain, etc.) para inicialização no Dart.

3. Dependências (pubspec.yaml)
	 - Adicionar:
		 - firebase_core
		 - firebase_database
		 - (opcional) firebase_auth
	 - Exemplo de constraints sugeridas (ajuste para a versão estável mais nova se necessário):
		 - firebase_core: ^3.6.0
		 - firebase_database: ^11.1.3
		 - firebase_auth: ^5.3.1

4. Gradle Android (Kotlin DSL)
	 - Arquivo `android/build.gradle.kts` (nível de projeto): adicionar o classpath do Google Services no bloco plugins usando o plugin management no topo do settings ou aplicar no app. Alternativa simples: aplicar o plugin no módulo app e garantir o repositório Google.
	 - Arquivo `android/app/build.gradle.kts` (módulo app):
		 - Adicionar plugin: `id("com.google.gms.google-services")`
		 - Confirmar repositórios `google()` e `mavenCentral()` já existem (já existem no projeto).

5. iOS
	 - Rodar `pod install` via Flutter (`flutter pub get` e primeiro build já acionam pods) após adicionar as libs.
	 - Certificar que a versão mínima do iOS está compatível com as libs (padrão do Flutter recente costuma ser ok).

6. Inicialização no Flutter (`main.dart`)
	 - Antes de runApp, chamar `WidgetsFlutterBinding.ensureInitialized();` e `await Firebase.initializeApp()`.
	 - No Web, passar as `FirebaseOptions` do app web. Em Android/iOS, os arquivos `google-services` cuidam da configuração.

7. Regras do Realtime Database (segurança)
	 - Em desenvolvimento (temporário):
		 {
			 "rules": {
				 ".read": false,
				 ".write": false,
				 "game": {
					 ".read": true,
					 ".write": true
				 }
			 }
		 }
	 - Em produção: utilizar auth e regras baseadas no uid. Ex.: cada jogador só pode ler/gravar seus dados `game/users/<uid>/**`.

## 2) Estrutura de dados no Realtime Database

Raiz sugerida: `game/`

- `game/users/{uid}/personagem`: dados serializados do personagem atual do usuário.
- `game/users/{uid}/itens`: coleção de itens do jogador (se o inventário for salvo por nome + quantidade).
- `game/users/{uid}/cidade`: cidade atual.
- `game/users/{uid}/missao`: missão ativa (ou coleção de missões, se necessário).

Notas de modelagem
- Item no código é imutável e não tem id/quantidade. Se quiser inventário com quantidades, usar `{ nome: { quantidade: N, ... } }` ou lista com `{nome, quantidade}`.
- Missao tem `id`, então persistência pode usar esse id como chave.
- Personagem contém Missao, Cidade, Itens – podemos salvar o snapshot do personagem completo em um nó e também nós específicos se quisermos consultas separadas.

## 3) Tasks de implementação no código

3.1 Adicionar dependências
- Atualizar `pubspec.yaml` com firebase_core, firebase_database, (opcional) firebase_auth.
- Executar `flutter pub get`.

3.2 Inicializar Firebase
- Editar `lib/main.dart` para inicializar o Firebase antes do runApp.
- Se Web: incluir FirebaseOptions do app web.

3.3 Service de persistência Firebase
- Criar `lib/services/firebase_database_service.dart` com funções CRUD para nós:
	- Caminho base: `DatabaseReference get _base => FirebaseDatabase.instance.ref('game');`
	- Se usar auth: `_userRef => _base.child('users').child(uid)`.
	- Sem auth (dev): `_userRef => _base.child('users').child('dev_user')`.

3.4 Mapeamentos (toMap/fromMap)
- Adicionar métodos de serialização sem alterar APIs públicas originais:
	- Criar extensões estáticas de mapeamento em um arquivo util, ex.: `lib/models/mappers.dart`:
		- PersonagemMapper.toMap(Personagem p) -> Map<String, dynamic>
		- PersonagemMapper.fromMap(Map) -> Personagem
		- ItemMapper (para itens simples), CidadeMapper, MissaoMapper
	- Assumir persistência de itens por nome (e opcionalmente tipo/valorEfeito).

3.5 CRUD por tipo
- Personagem
	- add/update: `set()` em `users/{uid}/personagem`
	- get: `get()`
	- delete: `remove()`
- Item (inventário)
	- add: `push()` ou `child(nome).set({quantidade})`
	- list: `get()`
	- delete: `child(nome).remove()`
- Cidade
	- set: `users/{uid}/cidade`
	- get: `get()`
- Missao
	- set/update: `users/{uid}/missao/{id}` ou `users/{uid}/missaoAtual`
	- get: `get()`
	- delete: `remove()`

3.6 Integração com `SaveLoadService`
- Substituir a simulação por chamadas ao `FirebaseDatabaseService`.
- saveGame(Personagem): persistir `personagem`, `cidade`, `missao`, `itens`.
- loadGame(): reconstruir `Personagem` a partir dos nós (ou de um snapshot único, conforme a modelagem escolhida em 2).

3.7 Tratamento de erros e timeouts
- Envolver operações com try/catch e retornar Result/Either ou lançar exceções tratadas.
- Configurar retry simples (ex.: re-tentar 1x em erro transitório) se necessário.

3.8 Testes manuais rápidos
- Escrever um pequeno botão de teste num screen dev-only para salvar/carregar e logar no console.

## 4) Itens concretos para executar (checklist)

- [ ] Criar projeto Firebase, habilitar Realtime Database e (opcional) Authentication.
- [ ] Android: baixar `google-services.json` em `android/app/`.
- [ ] iOS (se usar): adicionar `GoogleService-Info.plist` em `ios/Runner/`.
- [ ] Adicionar dependências no `pubspec.yaml`:
	- [ ] firebase_core
	- [ ] firebase_database
	- [ ] (opcional) firebase_auth
- [ ] Rodar `flutter pub get`.
- [ ] Android Gradle (Kotlin DSL): em `android/app/build.gradle.kts`, adicionar `id("com.google.gms.google-services")`.
- [ ] Confirmar repositórios `google()` e `mavenCentral()` (já presentes).
- [ ] Inicializar Firebase no `main.dart` com `Firebase.initializeApp()` (e `FirebaseOptions` no Web).
- [ ] Definir Regras mínimas no Realtime Database (dev) e planejar regras com auth para prod.
- [ ] Criar `lib/services/firebase_database_service.dart` com referências base e métodos CRUD.
- [ ] Criar `lib/models/mappers.dart` com toMap/fromMap para Personagem, Item, Cidade, Missao.
- [ ] Trocar implementação de `SaveLoadService` para usar o serviço Firebase.
- [ ] Adicionar logs básicos e tratamento de erros.
- [ ] Testar salvar/carregar um personagem de exemplo.

## 5) Esboço de assinatura dos métodos (guia)

- firebase_database_service.dart
	- Future<void> setPersonagem(Personagem p, {String? uid})
	- Future<Personagem?> getPersonagem({String? uid})
	- Future<void> deletePersonagem({String? uid})
	- Future<void> upsertItem(Item item, {int quantidade = 1, String? uid})
	- Future<List<Item>> getItens({String? uid})
	- Future<void> deleteItem(String nome, {String? uid})
	- Future<void> setCidade(Cidade c, {String? uid})
	- Future<Cidade?> getCidade({String? uid})
	- Future<void> setMissao(Missao m, {String? uid})
	- Future<Missao?> getMissao({String? uid})
	- Future<void> deleteMissao(String id, {String? uid})

## 6) Próximos passos opcionais

- Autenticação com Firebase Auth (email/senha, anônima, Google, etc.).
- Sincronização em tempo real com streams (`onValue`) para refletir alterações instantaneamente na UI.
- Normalização de dados (ex.: catálogo de itens global e inventário por referência + quantidade).
- Migração futura para Cloud Firestore se precisar de queries mais ricas.

