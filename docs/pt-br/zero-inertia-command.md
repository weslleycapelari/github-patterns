# Zero Inertia Command: Operacionalizando GitHub Patterns

## 1. Introdução

### O que é o Zero Inertia Command?

O **Zero Inertia Command** é um fluxo de trabalho totalmente operacional que mantém seu repositório AI-first evoluindo sem sobrecarga manual. É um sistema estruturado e repetível para:

- **Auditar** sua maturidade de governança contra um modelo comprovado de cinco níveis
- **Descobrir** lacunas de capacidade antes que bloqueiem o envio de mudanças
- **Planejar** o próximo sprint com precisão usando agentes especializados
- **Implementar** melhorias através de fluxos de trabalho coordenados entre agentes
- **Validar** progresso e preparar para a próxima iteração

Em essência, o Zero Inertia Command é um único comando que você cola no Copilot Chat. O agente Roadmap Steward retorna uma análise abrangente e um comando master executável. Você revisa as descobertas, aprova o progresso e invoca os próximos agentes em sequência. O repositório evolui metodicamente sem se tornar um fardo.

### Por Que Isso É Importante

A governança manual de repositório é um imposto sobre a velocidade:

- **Gargalo**: Cada melhoria exige que alguém identifique lacunas, pesquise soluções e conduza as mudanças pela revisão.
- **Perda de contexto**: O conhecimento sobre "por que construímos este agente" decai conforme os times crescem e as pessoas saem.
- **Sangramento de momentum**: Os times escolhem não refatorar ou atualizar porque o processo parece pesado.

O Zero Inertia Command elimina esses pontos de atrito:

- **Automação**: Roadmap Steward escaneia seu registry, padrões e agentes automaticamente, produzindo uma auditoria em minutos.
- **Clareza**: Cada recomendação vem com critérios de aceitação e pontos de integração, não sugestões vagas.
- **Momentum**: Uma vez que as decisões são tomadas, Asset Factory e Registry Governor executam melhorias em sprints coordenados.
- **Rastreabilidade**: Cada mudança cria arquivos de missão e logs de decisão, para que você nunca perca o contexto.

### Quem Deve Usar

- **Desenvolvedores solo** construindo projetos AI-first e querendo governança sem burocracia.
- **Pequenos times** (2–5 engenheiros) usando GitHub Patterns para estruturar seu repositório.
- **Times empresariais** gerenciando grandes bases de código em múltiplos domínios (ex: backend Laravel + frontend Vue + iOS).
- **Mantenedores de código aberto** coordenando contribuições sem controle centralizado.
- **Líderes técnicos** que querem que a governança seja **invisível**—integrada ao fluxo de trabalho, não um processo separado.

---

## 2. Arquitetura do Sistema

### Orquestração dos Quatro Agentes

```
Você (Desenvolvedor / Líder de Time)
    ↓
    │ "Execute uma varredura de maturidade e recomende ações"
    │ (Zero Inertia Command)
    ↓
Agente Roadmap Steward
    ├─→ Auditoria: Varredura do registry, verificação de estrutura, alinhamento de padrões
    ├─→ Análise de Lacunas: O que falta vs. Modelo de Maturidade
    ├─→ Comando Master: Orquestração pronta para colar para o próximo sprint
    ↓
Você (Revisa & Aprova)
    ├─→ Lê Relatório de Auditoria
    ├─→ Avalia Análise de Lacunas
    ├─→ Aprova escopo para o próximo sprint
    ↓
Você (Cola o Comando Master)
    │ "Ejecute: Fase 1 — Criar eval de segurança Laravel"
    ↓
Agente Asset Factory
    ├─→ Rascunho: Gera conteúdo de eval (subagente)
    ├─→ Revisão: Crítica independente (subagente)
    ├─→ Melhorar: Aplicar descobertas
    ├─→ Validar: Verificações de sintaxe e consistência
    ├─→ Entregar: Arquivo de eval atualizado + entrada do registry
    ↓
Agente Registry Governor
    ├─→ Varredura de sincronização: Detectar ativos não registrados
    ├─→ Validação: Garantir registry.json estar conforme o schema
    ├─→ Reconciliação: Atualizar registry com novos ativos
    ├─→ Entregar: Snapshot pronto para mesclar do registry
    ↓
Você (Mescla & Implanta)
    │ Revisa PRs, aprova, mescla para main
    ↓
Repositório (Atualizado & Evoluído)
    │ Novos evals, padrões, agentes ou prompts agora estão em produção
```

### Propósito de Cada Agente

| Agente | Papel | Invocação | Saída |
|--------|-------|-----------|-------|
| **Você** | Tomador de decisão, aprovador, executor | Cola comandos, revisa relatórios, aprova sprints | Decisões, sinais de aprovação |
| **Roadmap Steward** | Auditor estratégico e planejador | "Execute varredura de maturidade" (Zero Inertia Command) | Relatório de Auditoria, Análise de Lacunas, Comando Master |
| **Asset Factory** | Especialista em implementação | Delegado por Roadmap Steward ou Comando Master | Agentes/prompts/padrões/docs novos ou atualizados |
| **Registry Governor** | Guardião da integridade do catálogo | Delegado por Asset Factory ou Roadmap Steward | registry.json atualizado, validação de schema, reconciliação |

### Como Interagem: Fluxo de Entrada/Saída

**Passo 1: Auditoria**
- **Entrada**: `registry.json` atual, estrutura `library/`, `ROADMAP.md`, `governance-maturity-model.md`
- **Processo**: Roadmap Steward escaneia presença, atualidade e coerência dos ativos
- **Saída**: Auditoria de Maturidade (avaliação por nível)

**Passo 2: Análise de Lacunas**
- **Entrada**: Descobertas da auditoria + contexto do usuário (tamanho do time, direção estratégica)
- **Processo**: Roadmap Steward faz referência cruzada ao Modelo de Maturidade para identificar o que falta ou está obsoleto
- **Saída**: Análise de Lacunas (lista classificada: bloqueadores, itens de alto impacto, nice-to-haves)

**Passo 3: Geração de Comando Master**
- **Entrada**: Análise de Lacunas + aprovação do usuário do escopo
- **Processo**: Roadmap Steward gera uma sequência de comandos orquestrados, um por item do sprint
- **Saída**: Comando Master (pronto para colar, invoca Asset Factory → Registry Governor → Validação)

**Passo 4: Implementação de Ativos**
- **Entrada**: Comando Master + invocação do usuário + escopo aprovado
- **Processo**: Asset Factory cria/atualiza artefatos usando ciclo Desenvolver → Revisar → Melhorar → Validar
- **Saída**: Arquivos de ativos novos/atualizados (agente, padrão, eval, prompt, documentação)

**Passo 5: Reconciliação de Registry**
- **Entrada**: Arquivos de ativos novos/atualizados + registry.json atual
- **Processo**: Registry Governor escaneia por arquivos não registrados, valida schema, gera snippets de atualização
- **Saída**: registry.json atualizado + relatório de validação

---

## 3. Fundação do Modelo de Maturidade

### Cinco Níveis, Um Caminho Adiante

O **Modelo de Governança de Maturidade** define cinco níveis progressivos de governança AI-first:

| Nível | Nome | Estado | Foco |
|-------|------|--------|------|
| 1 | **Fundação** ✅ | Completo | Estrutura, docs, licença, hierarquia de pastas |
| 2 | **Controlado** ✅ | Completo | Proteção de branch, pipelines CI, automação |
| 3 | **Orientado por IA** 🚧 | Em Progresso | Agentes, padrões, tomada de decisão |
| 4 | **Auto-Auditável** 🎯 | Próximo Objetivo | Auditoria contínua, rastreabilidade, evolução |
| 5 | **Evolução Autônoma** 🚀 | Visão | Roadmap adaptativo, sincronização multi-idioma |

Cada nível se baseia no anterior. Você pode amadurecer *dentro* de um nível sem avançar para o próximo—e geralmente essa é a decisão correta.

### Conceito-chave: Maturidade vs. Progressão

- **Maturidade (Profundidade)**: Como você implementa practices dentro do nível atual. Um nível está maduro quando:
  - Todos seus artefatos estão presentes e documentados
  - Practices são aplicadas consistentemente através do time
  - Riscos e casos extremos são tratados explicitamente
  - Decisões são rastreáveis

- **Progressão (Avanço)**: Passar para o próximo nível. **Não avance até que o nível atual esteja maduro o suficiente para suportar as dependências do próximo nível.**

**Exemplo**: Você pode ficar no Nível 3 por 6 meses, amadurecendo constantemente seus agentes, padrões e prompts. Apenas quando agentes são confiáveis e padrões são comprovados você avança para Nível 4 (Auto-Auditável).

### Como Roadmap Steward Usa o Modelo

O agente Roadmap Steward executa essa lógica no início de cada varredura de maturidade:

1. **Escaneia Artefatos**: Verifica o que existe em seu registry e biblioteca.
2. **Avalia Maturidade**: Para cada nível, marca quais artefatos estão presentes, atuais e funcionais.
3. **Identifica Lacunas**: O que é necessário para amadurecer o nível atual? O que é necessário para progredir?
4. **Recomenda Caminho**: Sugere APROFUNDAR (melhorar nível atual) ou AVANÇAR (mover para próximo nível).
5. **Classifica Escopo**: Prioriza itens de lacuna por impacto e esforço.

### Conexão com Tomada de Decisão Estratégica

O Modelo de Maturidade **não é prescritivo**—é uma ferramenta de diagnóstico. Você decide:

- **Ritmo**: Avançar para Nível 4 em 8 semanas, ou ficar no Nível 3 por um ano enquanto o aprofunda?
- **Escopo**: Focar em um padrão ou construir três agentes em paralelo?
- **Risco**: Aceitar débito técnico para enviar mais rápido, ou investir tempo em governança apropriada?

O Zero Inertia Command superficializa esses trade-offs por escrito, para que decisões sejam intencionais e auditáveis.

---

## 4. Passo 1: O Zero Inertia Command (Fluxo Principal)

### O Que Fazer: Comando Exato

Copie este comando exatamente e cole no **Copilot Chat** (no VS Code ou em GitHub.com):

```text
@roadmap-steward

Preciso de uma varredura de maturidade do repositório github-patterns.

Por favor, analise:
1. Maturidade de governança atual (contra o modelo de cinco níveis)
2. Lacunas de capacidade vs. direção estratégica
3. Itens de sprint recomendados (2–3, classificados por impacto)
4. Um comando master que eu possa executar para implementar as recomendações

Formato de saída:
- Relatório de Auditoria (maturidade atual por nível)
- Análise de Lacunas (o que falta, por quê, estimativa de esforço)
- Comando Master (comando pronto para colar para próximo agente na cadeia)

Contexto: [Forneça contexto do usuário aqui: tamanho do time, stack de tecnologia, prioridades estratégicas, restrições de timeline]
Exemplo: "Time de 5 pessoas, loja Laravel + Vue, objetivando maturidade Nível 4 até Q3"
```

### O Que Roadmap Steward Vai Retornar

Você receberá uma resposta estruturada em três partes:

#### Parte 1: Relatório de Auditoria (5–10 minutos de leitura)

Uma avaliação por nível como:

```
RELATÓRIO DE AUDITORIA DE MATURIDADE
====================================

Nível 1: Fundação ✅ MADURO
  - README.md: ✓ Presente, atual, completo
  - CONTRIBUTING.md: ✓ Detalhado, seguido
  - LICENSE: ✓ MIT declarado
  - structure.md: ✓ Abrangente
  Status: PRONTO PARA MANTER

Nível 2: Controlado ✅ MADURO
  - Proteção de branch: ✓ Branch main protegido
  - Pipeline CI: ✓ Suite de lint + teste passa
  - Templates de issue: ✓ 6 templates em uso
  Status: PRONTO PARA MANTER

Nível 3: Orientado por IA 🚧 EM PROGRESSO (85% maduro)
  - Agentes presentes: ✓ 6 agentes no registry
  - Padrões presentes: ✓ 8 padrões documentados
  - Stacks presentes: ✓ Laravel (1), Vue.js (1), faltando: iOS Swift
  - copilot-instructions.md: ✓ Completo
  - Evals presentes: ✓ 4 evals, faltando: performance Vue, padrões de migração Laravel
  Status: AVANÇANDO — Evals ausentes são o bloqueador principal

Nível 4: Auto-Auditável 🎯 NÃO INICIADO (0% maduro)
  - Protocolo de arquivo de missão: ✗ Não aplicado
  - Logs de decisão: ✗ Não sistemático
  - Auditoria contínua: ✗ Sem automação
  Status: PRÉ-REQUISITO PARA NÍVEL 4 = Amadurecer Nível 3

Nível 5: Evolução Autônoma 🚀 VISÃO (0% maduro)
  - Roadmap adaptativo: ✗ Não implementado
  - Sincronização multi-idioma: ✗ Parcialmente feita
  Status: DEPENDE DO NÍVEL 4
```

#### Parte 2: Análise de Lacunas (Entrada crítica de decisão)

Uma lista priorizada de lacunas com impacto comercial:

```
ANÁLISE DE LACUNAS
==================

BLOQUEADOR (Deve ser resolvido antes do avanço para Nível 4):
1. Eval de Performance Laravel
   - Por quê: 4 agentes existem (Laravel expert, segurança, reatividade, etc.)
      mas sem eval para cenários de otimização de performance.
   - Impacto: Times não conseguem validar recomendações do expert Laravel.
   - Esforço: Médio (3–4 dias)
   - Dono: Recomenda-se @asset-factory → agente de stack Laravel

ALTO IMPACTO (Melhora maturidade do nível atual):
1. Agente de Auditoria de Performance Vue.js
   - Por quê: Arquiteto Vue existe; debugging de performance é uma lacuna central.
   - Impacto: Completa o stack Vue; habilita auditorias full-stack.
   - Esforço: Grande (2–3 semanas)
   - Dono: Recomenda-se @asset-factory → novo agente

2. Eval para Padrões de Migração (Laravel)
   - Por quê: Times atualizando versões Laravel precisam de orientação padrão.
   - Impacto: Eval reutilizável, alta demanda.
   - Esforço: Pequeno (2–3 dias)
   - Dono: Recomenda-se @asset-factory → estender stack Laravel

NICE-TO-HAVE (Melhora processo, não caminho crítico):
1. Detecção Automática de Drift de Registry
   - Por quê: Varreduras manuais de sincronização são propensas a erro.
   - Impacto: Reduz sobrecarga operacional.
   - Esforço: Médio (1 semana)
   - Dono: Recomenda-se @registry-governor → novo fluxo CI
```

#### Parte 3: Comando Master (Seu blueprint de execução)

Um comando pronto para colar em sequência:

```
COMANDO MASTER - EXECUTE EM SEQUÊNCIA
=====================================

FASE 1: Criar Eval de Performance Laravel (Prioridade: BLOQUEADOR)

@asset-factory

Crie um caso de eval abrangente para auditoria de performance Laravel.

Arquivo: library/evals/laravel-expert/performance-optimization.md
Escopo:
- 3 cenários realistas de app Laravel (e-commerce, SaaS, site de conteúdo)
- Anti-padrões de performance (queries N+1, rotas não otimizadas, vazamentos de memória)
- Recomendações esperadas do expert por cenário
- Critérios de sucesso/falha para validação de eval

Validação: Garanta consistência com estrutura de eval existente
            (veja: library/evals/laravel-expert/README.md)

Critérios de Sucesso:
✓ Arquivo de eval é markdown com pelo menos 3 cenários
✓ Anti-padrões são realistas (extraídos de problemas de produção)
✓ Saídas esperadas são testáveis (não subjetivas)

---

FASE 2: Atualizar Registry

@registry-governor

Sincronize o registry após criação de ativos.

Tarefas:
1. Escanear library/ para ativos não registrados
2. Validar registry.json contra registry.schema.json
3. Gerar atualização registry.json pronta para colar

Critérios de Sucesso:
✓ registry.json é JSON válido
✓ Todos os paths no registry existem
✓ Todos os novos ativos estão registrados com metadata apropriada

---

FASE 3: Validar & Sumarizar

Após a Fase 2 ser concluída, você:
1. Revisa novas entradas do registry
2. Mescla a atualização do registry
3. Marca item do sprint como COMPLETO em ROADMAP.md
4. Execute validação local: 
   python -c "import json; from jsonschema import Draft202012Validator; 
   data=json.load(open('registry.json')); schema=json.load(open('docs/schemas/registry.schema.json')); 
   Draft202012Validator(schema).validate(data); print('✓ VÁLIDO')"

---

PRÓXIMO SPRINT (Execute após a Fase 3 ser mesclada):

@roadmap-steward

Execute varredura de maturidade novamente para identificar próxima prioridade.
```

### Como Interpretar Resultados

**Relatório de Auditoria**: Use para entender seu *estado atual*. Foque na linha "Status" para cada nível.

**Análise de Lacunas**: Use para entender *o que falta e por quê*. Ignore itens marcados "NICE-TO-HAVE" se estiver com pressa. Foque primeiro em itens "BLOQUEADOR" e "ALTO IMPACTO".

**Comando Master**: Use como um *template para execução*. Você não precisa seguir exatamente—mas foi projetado para ser pronto para colar. Se discordar de uma recomendação, edite o escopo ou pule a fase.

### Portão de Confirmação Antes de Começar o Trabalho

**Pare aqui. Antes de invocar o Comando Master, responda estas perguntas:**

1. **Eu concordo com a classificação de prioridade?** (Se não, reordene fases ou peça ao Roadmap Steward repriorizar.)
2. **Tenho capacidade para este sprint?** (Sprint típico: 1–3 semanas. Se não, peça ao Roadmap Steward reduzir escopo.)
3. **Existem bloqueadores impedindo esse trabalho?** (Requisitos pouco claros, conflito no time, dependências externas. Superficialize-os agora.)
4. **Revisei as referências no Comando Master?** (Garanta que você entende os arquivos sendo modificados.)

Uma vez respondido "sim" a todos os quatro, você está pronto para executar o Comando Master.

---

## 5. Passo 2: Captura de Sinais (Exemplos Reais)

### Quando Usar Captura de Sinais

Captura de Sinais é uma variante do Zero Inertia Command. Use quando você tem entrada externa:

- **Descrição de trabalho**: "Estamos contratando um engenheiro full-stack Laravel; que lacunas isso revela?"
- **Feedback de cliente**: "Múltiplos clientes pediram auditoria de performance em Vue; o que devemos construir?"
- **Retrospectiva do time**: "Tivemos dificuldade em migrar versões Laravel; devemos criar um padrão para isso?"
- **Mudança de tecnologia**: "Swift/iOS é uma nova plataforma para nosso time; como isso afeta governança?"

Captura de Sinais diz a você: "Dado este novo constrangimento ou oportunidade, o que devemos priorizar no próximo sprint?"

### Comando de Exemplo

```text
@roadmap-steward

Estou vendo um sinal de mercado e quero entender o impacto de governança.

Sinal: Estamos contratando para papel de "Desenvolvedor Full-Stack Laravel + Vue".
         Descrição de trabalho requer: Laravel 11, Vue 3, PostgreSQL, Docker, caching com Redis.

Por favor, analise:
1. Nosso registry atual cobre essas tecnologias?
2. Que lacunas podem impedir onboarding efetivo dessa contratação?
3. Esse sinal deve mudar nossas prioridades de sprint?

Saída: Análise de Lacunas focada em capacidade de onboarding, não maturidade geral.
```

### Como Extrair Descrição de Trabalho e Analisar Lacunas

**Fluxo de trabalho:**

1. **Cole a descrição de trabalho** no comando Captura de Sinais (texto completo ou resumo).
2. **Peça ao Roadmap Steward** para alinhá-la com padrões e stacks existentes.
3. **Roadmap Steward retorna** um mapeamento como:

```
ANÁLISE DE SINAL: Desenvolvedor Full-Stack Laravel + Vue
=========================================================

Alinhamento de Tecnologia:
- Laravel 11: ✓ Coberto por agente laravel-expert + stack
- Vue 3: ✓ Coberto por agente vue-architect + stack
- PostgreSQL: ✓ Coberto em padrões de banco de dados
- Docker: ✓ Coberto em baseline de infraestrutura
- Caching com Redis: ✗ NÃO COBERTO — Lacuna identificada

Lacuna Identificada: Padrões de Caching com Redis
- Por quê: Candidato usará Redis desde o dia 1; sem orientação existe.
- Impacto: Alto (otimização de performance, crítico para produção)
- Esforço para fechar: Médio (criar eval + estender stack Laravel com padrões de caching)
- Recomendação: Adicionar ao próximo sprint como item de ALTO IMPACTO

Este sinal deve elevar "Eval de Caching Laravel" de NICE-TO-HAVE para ALTO IMPACTO.
```

### Exemplo Prático: "Desenvolvedor Fullstack Laravel/Vue"

**Cenário**: Seu time está contratando. A descrição de trabalho diz:

> "5+ anos Laravel e Vue.js, expert em otimização de performance, familiarizado com Docker e microserviços, forte em practices de testes."

**Você submete a Captura de Sinais:**

```text
@roadmap-steward

Sinal de Descrição de Trabalho: Estamos contratando expert full-stack Laravel/Vue.

Requisitos:
- Laravel 11 + padrões avançados (migrations, otimização, filas)
- Vue 3 + Composition API
- Docker, arquitetura de microserviços
- Otimização de performance (tanto backend quanto frontend)
- Expertise em testes (unidade, integração, e2e)

Perguntas:
1. Nossos agentes e padrões atuais conseguem guiar essa contratação efetivamente?
2. Que lacunas de onboarding existem?
3. Este sinal de contratação deve mudar nossas prioridades de sprint?
```

**Roadmap Steward retorna:**

```
ANÁLISE DE SINAL DE TRABALHO
============================

Cobertura Alinhada:
✓ Laravel 11: agente laravel-expert + casos de eval
✓ Vue 3: agente vue-architect + padrões de componentes
✓ Docker: infraestrutura em github-baseline
✓ Testes: padrão testing-excellence

Lacunas Identificadas:
1. Padrões de Microserviços Laravel: NENHUM EXISTE
   - Candidato perguntará "Como estruturamos chamadas entre serviços?"
   - Estado atual: Padrões genéricos Laravel, sem orientação de microserviços
   - Impacto: ALTO (onboarding vai ter dificuldade)
   - Solução: Estender agente laravel-expert com eval de microserviços

2. Otimização de Performance (Full-Stack): PARCIAL
   - Expert Laravel existe; agente Vue performance NÃO EXISTE
   - Candidato perguntará "Como otimizamos tamanho do bundle e Core Web Vitals?"
   - Estado atual: Arquiteto Vue existe; sem orientação específica de performance
   - Impacto: ALTO (performance full-stack é central ao papel)
   - Solução: Criar agente vue-performance-optimizer + eval

Ação Recomendada:
REPRIORIZAR próximo sprint para incluir:
1. Eval de microserviços Laravel (2 dias)
2. Agente otimizador de performance Vue (3 semanas)
3. Padrão de performance full-stack (5 dias)

Timeline: Se precisa contratar em 6 semanas, inicie Fase 1 imediatamente.
```

---

## 6. Passo 3: Interpretando Resultados

### Como Ler Saída de Auditoria de Maturidade

O relatório de auditoria usa este formato por nível:

```
Nível [N]: [Nome] [Emoji de Status]
  - [Artefato 1]: [Verificação de Presença] [Descrição]
  - [Artefato 2]: [Verificação de Presença] [Descrição]
  Status: [Próxima ação legível para humanos]
```

**Decodifique os símbolos:**

| Símbolo | Significado |
|---------|-------------|
| ✓ | Artefato existe e está atual (última atualização ≤ 2 sprints) |
| ✗ | Artefato ausente ou severamente desatualizado (>2 sprints) |
| ⚠ | Artefato existe mas incompleto ou inconsistente |
| ✅ | Nível está maduro e pronto para manter |
| 🚧 | Nível está em progresso; avançando mas não yet estável |
| 🎯 | Próximo marco lógico após nível atual |
| 🚀 | Meta aspiracional; depende de níveis anteriores amadurecerem |

**O que "maduro" realmente significa:**

Um nível está maduro quando:
- Todos seus artefatos críticos existem e estão atuais
- Practices do time são consistentes
- Riscos são explicitamente gerenciados
- Casos extremos estão documentados

Um nível está "em progresso" quando:
- A maioria dos artefatos existe, mas alguns são incompletos
- Adoção é desigual através do time
- Decisões ainda estão sendo validadas
- O modelo funciona mas precisa refinamento

### Entendendo Análise de Lacunas

A Análise de Lacunas está estruturada por tier de impacto:

| Tier | Significado | Ação |
|------|-------------|------|
| BLOQUEADOR | Impede progressão ou cria risco de produção | Deve ser resolvido antes de avançar para próximo nível |
| ALTO IMPACTO | Melhora significativamente maturidade; alto ROI | Priorize próximo sprint |
| MÉDIO | Valioso mas pode esperar; menor urgência | Planejar para sprints futuros |
| NICE-TO-HAVE | Melhora processo, não crítico | Faça se houver capacidade |

**Quando você vê "BLOQUEADOR", pare.** Não avance para próximo nível de maturidade até que bloqueadores sejam resolvidos.

**Quando você vê "ALTO IMPACTO", planeje.** Este é seu próximo sprint.

### Lendo o Comando Master

O Comando Master é seu blueprint de execução. Contém:

1. **Descrições de FASE**: Qual agente invocar, qual escopo dar.
2. **Critérios de Sucesso**: Critérios de aceitação testáveis para cada fase.
3. **Sequências de Comando**: Pronto para colar, em ordem de execução.
4. **Passos de Validação**: Como confirmar que cada fase funcionou.

**Use o Comando Master como uma receita.** Você não precisa seguir exatamente, mas:

- Não pule passos de validação
- Não reordene fases sem entender dependências
- Não assuma que um agente "vai descobrir"—forneça escopo explícito

### Métricas de Sucesso Por Nível

| Nível | Sucesso Parece | Como Medir |
|-------|----------------|-----------| 
| **Nível 1** | Todos docs estão atuais; onboarding funciona | Novo contribuidor consegue configurar repo em <30 min |
| **Nível 2** | Todos PRs passam automação; zero erros de porta humana | CI pega problemas antes de revisão; zero merges falhando |
| **Nível 3** | Agentes fazem recomendações consistentes; padrões são aplicados | Agentes retornam mesma recomendação em múltiplos usos; zero violações de padrão |
| **Nível 4** | Descobertas de auditoria são consistentes; rastreabilidade é automática | Resultados de varredura combinam com varredura anterior para mesma query; todas mudanças têm arquivos de missão |
| **Nível 5** | Registry melhora autonomamente; codebase evolui sem direção humana | Roadmap avança automaticamente; sincronização de idioma é automática |

---

## 7. Passo 4: Fluxo de Trabalho Semanal

### Breakdown Dia-a-Dia

**Segunda-feira**: Varredura de Maturidade
- Tempo: 15 minutos (copie comando, cole, espere resposta)
- Você faz: Revisa Relatório de Auditoria e Análise de Lacunas. Socializa descobertas com time se necessário.
- Resultado: Entender estado atual; identificar prioridades.

**Terça-feira**: Portão de Aprovação
- Tempo: 30 minutos (leia descobertas, faça perguntas, aprove escopo)
- Você faz: 
  - Responda: "Concordo com essa prioridade?"
  - Responda: "Tenho capacidade?"
  - Responda: "Existem bloqueadores?"
- Resultado: Escopo de sprint aprovado; Comando Master pronto para executar.

**Quarta–Sexta**: Implementação de Ativos
- Tempo: Varia (tipicamente 8–16 horas distribuídas em 3 dias)
- Você faz:
  - Cole Fase 1 do Comando Master
  - Espere Asset Factory retornar rascunho
  - Revise e aprove (ou solicite mudanças)
  - Cole Fase 2 (Registry Governor)
  - Revise registry mesclado
  - Cole Fase 3 (Validação)
- Resultado: Novos/ativos atualizados; registry sincronizado.

**Próxima Segunda**: Mescla & Celebração
- Tempo: 30 minutos (revise PR, mescle, execute verificação de sanidade)
- Você faz: Revisão final de mudanças mescladas; garanta sem conflitos com trabalho em andamento.
- Resultado: Mudanças estão em produção; time se beneficia de melhorias.

**Segunda-feira Seguinte**: Repetir
- Tempo: 15 minutos (próxima varredura de maturidade)
- Você faz: Execute Zero Inertia Command novamente; identifique próxima prioridade.
- Resultado: Ciclo de melhoria contínua começa novamente.

### Seu Papel em Cada Estágio

| Estágio | Seu Papel | Portão de Decisão |
|---------|-----------|-------------------|
| **Descobrir** | Observador passivo | Nenhum; Roadmap Steward escaneia automaticamente |
| **Analisar** | Revisor ativo | Aprove descobertas de auditoria; concorde com ranking de lacunas |
| **Planejar** | Aprovador ativo | Confirme que escopo é alcançável; verifique capacidade |
| **Implementar** | Revisor ativo | Revise rascunhos; aprove/solicite mudanças por fase |
| **Validar** | Guardião do portão | Confirme que validação passou; mescle para main |
| **Repetir** | Entrada estratégica | Execute próxima varredura; sinalize novas mudanças de mercado se houver |

### Tempos de Entrega Esperados

| Atividade | Duração Típica | Dono |
|-----------|----------------|------|
| Varredura de Maturidade (Auditoria + Análise de Lacunas) | 15 min | Roadmap Steward (automatizado) |
| Sua revisão de descobertas | 30 min | Você |
| Discussão de aprovação/escopo | 30 min | Você + time |
| Fase Asset Factory (rascunho + revisão + melhorar) | 8–16 horas | Asset Factory |
| Sua revisão de saída Asset Factory | 30 min | Você |
| Fase Registry Governor (sincronização + validação) | 2–4 horas | Registry Governor |
| Sua revisão de mesclagem de registry | 30 min | Você |
| Validação final + mescla | 30 min | Você |
| **Ciclo total (Varredura → Produção)** | **1–2 semanas** | Time + Agentes |

### Quando Intervir

**Intervenha imediatamente se:**

- Saída Asset Factory não combina com escopo aprovado (fora dos limites).
- Registry Governor relata erro de validação (incompatibilidade de schema).
- Uma fase leva mais de 2 semanas (provável um bloqueador; superficialize-o).

**Intervenha proativamente se:**

- Você descobre um novo sinal de mercado ou mudança estratégica (pause sprint atual, execute Captura de Sinais).
- Capacidade do time cai (pause sprint, estenda timeline).
- Revisão encontra uma alternativa melhor do que proposto (discuta com Roadmap Steward para próximo ciclo).

**NÃO intervenha se:**

- Você discorda de uma recomendação mas não tem certeza (peça ao Roadmap Steward explicar; não force).
- Uma fase é lenta mas progredindo (deixe rodar; iterar agressivamente causa retrabalho).

---

## 8. Passo 5: Tomada de Decisão Profissional

### Quando AVANÇAR para Próximo Nível (Todos os 5 Devem Ser Verdadeiros)

Você está pronto para avançar para próximo nível de maturidade apenas quando:

1. **Nível Atual está Maduro** (≥80% presença de artefato, ≥1 sprint bem-sucedido aplicando practices do nível)
   - Exemplo: No Nível 3, você tem agentes funcionando, padrões são comprovados, time os usou com sucesso pelo menos uma vez.

2. **Dependências do Próximo Nível São Entendidas** (Você leu Modelo de Maturidade para próximo nível; sem surpresas)
   - Exemplo: Antes de avançar para Nível 4, você entende que Nível 4 requer arquivos de missão e logs de decisão, que mudarão seu fluxo de trabalho.

3. **Capacidade do Time Existe** (Sprint de transição é realista; não sobrecarregando time)
   - Exemplo: Avançar para Nível 4 leva 4 semanas. Se seu time está apagando fogo, espere 2 sprints.

4. **Alinhamento Estratégico é Claro** (Liderança concordou que isto é próxima prioridade; não apenas "seria legal")
   - Exemplo: "Estamos avançando para Nível 4 para melhorar auditabilidade para requisitos de conformidade" (motivo claro).

5. **Riscos Estão Documentados** (Você identificou riscos de transição e tem plano de mitigação)
   - Exemplo: "Risco de transição: resistência do time a arquivos de missão. Mitigação: workshop de 1 hora + demos em pares."

**Lógica de Decisão:**

```
SE (maturidade_nível_atual >= 80%)
   E (dependências_próximo_nível_entendidas)
   E (capacidade_time > 0)
   E (alinhamento_estratégico == SIM)
   E (riscos_documentados)
ENTÃO: AVANCE
SENÃO: APROFUNDE nível atual ou resolva bloqueador
```

### Quando APROFUNDAR Nível Atual (4 Indicadores)

Aprofunde (maturidade sem progressão) quando:

1. **Cobertura de Artefato < 80%**: Alguns artefatos críticos faltam ou estão incompletos.
   - Exemplo: No Nível 3, você tem agentes mas evals são poucos. Aprofunde adicionando 4 mais evals.

2. **Adoção é Desigual**: Alguns membros do time usam practices; outros não.
   - Exemplo: Uma pessoa escreve agentes bons; outra não segue estrutura de agente. Aprofunde treinando + auditoria de padrões.

3. **Questões de Qualidade Emergem**: Na prática, artefatos têm bugs ou features incompletas.
   - Exemplo: Um agente retorna recomendações inconsistentes. Aprofunde refinarando lógica de agente e adicionando evals.

4. **Processo Não Estabilizou**: Times ainda argumentam sobre "como fazer isso". Practices não são rotina ainda.
   - Exemplo: Ainda debatendo como estruturar casos de avaliação. Aprofunde finalizando padrão de eval e treinando.

**Lógica de Decisão:**

```
SE (qualquer dos 4 indicadores de aprofundamento é VERDADEIRO)
ENTÃO: Execute Varredura de Maturidade com foco="APROFUNDAR", não "AVANÇAR"
SENÃO: Avalie prontidão de avanço
```

### Anti-Padrões Comuns para Evitar

**Anti-Padrão 1: "Avançando Muito Rápido"**
- **Parece**: "Estamos no Nível 3 há 2 semanas; vamos pular para Nível 4."
- **Risco**: Arquivos de missão são novos; se não adotados, automação de auditoria do Nível 4 falha.
- **Prevenção**: Siga a regra de 5 portões de avanço. Fique no Nível 3 por ≥8 semanas.

**Anti-Padrão 2: "Ignorando Descobertas de Auditoria"**
- **Parece**: "Roadmap Steward disse que temos um bloqueador, mas vamos ignorar e enviar features."
- **Risco**: Bloqueador geralmente impede progressão ou cria débito operacional. Ignorar causa falha maior depois.
- **Prevenção**: Se discorda de descoberta, discuta explicitamente com Roadmap Steward. Não pule silenciosamente.

**Anti-Padrão 3: "Sobre-Customizando Saídas de Agente"**
- **Parece**: "Asset Factory retornou um padrão, mas nós modificamos pesadamente porque 'nosso time é especial'."
- **Risco**: Drift de padrões repositório; membros futuros confusos; mais difícil manter.
- **Prevenção**: Use saídas de Agente como-estão a menos que haja exceção documentada. Solicite revisão de Roadmap Steward antes de customizar.

**Anti-Padrão 4: "Assumindo o Sistema é Hands-Off"**
- **Parece**: "Configuramos Zero Inertia Command e assumimos que rodaria sozinho."
- **Risco**: Agentes precisam de portões humanos (aprovação, confirmação de escopo, alinhamento estratégico). Portões faltando causam escopo fugindo.
- **Prevenção**: Trate Roadmap Steward como conselheiro estratégico, não um robô. Revise descobertas; aprove conscientemente.

**Anti-Padrão 5: "Drift de Registry"**
- **Parece**: "Criamos novo agente localmente mas não o registramos."
- **Risco**: Outros agentes não sabem sobre ele; descoberta de ativos falha; documentação fica velha.
- **Prevenção**: Sempre execute Registry Governor após Asset Factory. Faça sincronização de registry uma parte não-negociável do fluxo de trabalho.

### Diretrizes de Gestão de Risco

**Risco Operacional**: Practices de governança quebram; time para de usar agentes/padrões.
- **Mitigação**: Execute Varreduras de Maturidade mensalmente (não ad-hoc). Torne adoção visível (métricas: uso de agente, aderência de padrão). Treine novos membros do time explicitamente.

**Risco Técnico**: Novo agente ou padrão tem baixa qualidade; time acha não confiável.
- **Mitigação**: Asset Factory sempre inclui revisão independente. Evals validam saídas de agente. Nunca envie agentes não-testados.

**Risco Organizacional**: Governança parece burocracia; time resiste.
- **Mitigação**: Foque em *benefício*, não *conformidade*. Agentes economizam tempo; padrões reduzem argumentos. Meça resultados (revisões mais rápidas, menos bugs, onboarding mais suave).

**Risco de Timeline**: Avanço leva mais que esperado; time fica desmoralizado.
- **Mitigação**: Quebre avanço em marcos menores. Celebre vitórias. Seja realista sobre timelines (8 semanas por nível não é um sprint; é um quarter).

---

## 9. Passo 6: Indicadores de Sucesso

### Indicadores-Chave de Performance (KPIs) Por Nível

| KPI | Nível 1 | Nível 2 | Nível 3 | Nível 4 | Nível 5 |
|-----|---------|---------|---------|---------|---------|
| **Tempo de Varredura de Maturidade** | N/A | N/A | 15 min | 15 min | 15 min |
| **Atualidade de Artefato** | ≥1 mês | ≥2 sem | ≥1 sem | ≥3 dias | Diário |
| **Precisão de Auditoria** | Spot-check manual | Manual | Semi-auto | Auto completa | Contínua |
| **Ciclo de Identificação de Lacunas** | Manual (semanas) | Manual (semanas) | Semi-auto (dias) | Full-auto (horas) | Tempo real |
| **Ciclo de Criação de Ativos** | 2–4 sem | 1–2 sem | 3–5 dias | 1–2 dias | Horas |
| **Taxa de Adoção do Time** | 100% (obrigatório) | 100% | 80%+ | 80%+ | 90%+ |
| **Coerência de Registry** | Check manual | Check manual | Semi-auto | Automatizado | Tempo real |
| **Atrito de Onboarding** | Alto (30 min) | Médio (20 min) | Baixo (10 min) | Mínimo (5 min) | Zero (auto) |

### O Que "Sucesso" Parece Em Cada Nível

**Sucesso Nível 1**:
- Novo membro do time consegue clonar repo e ter setup local em <30 minutos
- Regras de contribuição são cristalinas; zero PRs rejeitadas por "intenção pouco clara"
- Conformidade legal e de licença estão em ordem; sem ambiguidade

**Sucesso Nível 2**:
- Cada PR é testado automaticamente antes de revisão humana
- Zero PRs mescladas com testes falhando ou violações de estilo
- Triagem (labeling, roteamento) é 80% automatizada; humanos focam em decisões, não classificação

**Sucesso Nível 3**:
- Agentes são confiáveis em fazer recomendações; time age nelas sem debate
- Novos padrões são adotados dentro de 1 sprint; sem "faremos à nossa forma"
- Criação de ativos é repetível; mesmo agente invocado para problemas similares produz qualidade similar

**Sucesso Nível 4**:
- Cada mudança é rastreável a decisão; governança é auditável
- Varreduras de Maturidade revelam sem surpresas; descobertas são consistentes semana-a-semana
- Melhoria contínua requer zero orquestração manual; agentes invocam outros agentes automaticamente

**Sucesso Nível 5**:
- Repositório melhora sem direção humana explícita; roadmap avança autonomamente
- Documentação multi-idioma fica sincronizada automaticamente
- Novos padrões e agentes emergem em resposta a sinais do time (contratação, feedback de mercado) com zero esforço manual

### Como Medir Progresso

**Métricas Quantitativas:**

- Rastreie resultados de Varredura de Maturidade ao longo do tempo. Gráfico: "% presença de artefato por nível" (deve aumentar ou estabilizar).
- Conte "ciclos de criação de ativos": Quantos ativos foram criados/melhorados por sprint? (deve estabilizar em taxa previsível)
- Meça "feedback loop de auditoria": Quantas descobertas de uma varredura são resolvidas antes da próxima? (deve ser >80%)

**Sinais Qualitativos:**

- **Facilidade de Uso**: "A recomendação de agente se sentiu natural ou forçada?" (pergunte ao time mensalmente)
- **Confiança**: "Você confia neste agente?" (escala 1–5, rastreie ao longo do tempo)
- **Atrito**: "Qual é a parte mais chata do nosso processo de governança?" (superficialize os 3 principais bloqueadores)

**Painel de Exemplo (execute mensalmente):**

```
PAINEL DE SAÚDE DE GOVERNANÇA
=============================
Nível de Maturidade Atual: 3 (Em Progresso)
Cobertura do Nível 3: 85% (8/9 artefatos presentes e atuais)

Ativos Criados Este Sprint: 2 (eval Laravel, padrão Vue)
Ciclo Médio de Criação de Ativos: 5 dias (baixo de 7 dias último mês ✓)
Sincronização de Registry: 100% (sem drift) ✓

Métricas de Adoção do Time:
- Uso de agente: 8/8 membros do time usaram pelo menos 1 agente (100%)
- Aderência de padrão: 95% (1 outlier sinalizado para discussão)
- Frequência de Varredura de Maturidade: Mensal (no cronograma)

Próximos Marcos:
- Meta de maturidade Nível 3: 95% cobertura até fim de Q2
- Avanço para Nível 4: Q3 (condicional a aprofundamento do Nível 3)
```

---

## 10. Passo 7: Executando Sua Primeira Varredura

### Comando Exato para Colar (Pronto para Copiar)

Abra **Copilot Chat** e cole isto exatamente:

```text
@roadmap-steward

Estou executando minha primeira varredura de maturidade para repositório github-patterns.

Por favor, faça auditoria do estado atual e forneça:
1. Uma avaliação de maturidade contra o Modelo de Governança de Maturidade de cinco níveis
2. Lacunas de capacidade, classificadas por impacto
3. Um comando master para implementar o gap de prioridade máxima

Contexto: 
[Tamanho do Time]: 1–2 engenheiros (solo/pequeno time, responsabilidades compartilhadas)
[Stack de Tecnologia]: Poliglota (agentes são agnósticos de tecnologia; evals variam por domínio)
[Timeline]: 6–12 meses para amadurecer. Sem prazo rígido.
[Prioridade Estratégica]: Estabelecer governança AI-first; evitar sobrecarga manual.

Por favor, formate a resposta como:
- RELATÓRIO DE AUDITORIA (avaliação por nível)
- ANÁLISE DE LACUNAS (classificada, com estimativas de esforço)
- COMANDO MASTER (pronto para colar)
```

### Investimento de Tempo Esperado

**Antes de varredura (setup)**: 5 minutos
- Abrir Copilot Chat
- Colar comando
- Aguardar resposta (geralmente <2 minutos)

**Revisando descobertas (leitura)**: 15 minutos
- Ler Relatório de Auditoria (5 min)
- Entender Análise de Lacunas (5 min)
- Visualizar Comando Master (5 min)

**Decidindo próximos passos (pensamento)**: 10 minutos
- Concordo com prioridades? (Sim/Não/Discutir)
- Tenho capacidade? (Sim/Não/Adiar)
- Algum bloqueador? (Sim/Não/Escalar)

**Total para primeira varredura**: ~30 minutos

### O Que Esperar na Saída

Você receberá um documento estruturado (geralmente 2–4 páginas) com:

- **Relatório de Auditoria** (numerado por nível, com símbolos ✓/✗/⚠)
- **Análise de Lacunas** (classificada por BLOQUEADOR/ALTO/MÉDIO/NICE-TO-HAVE)
- **Comando Master** (comandos fase-por-fase executáveis)
- **Apêndice** (opcional: explicação detalhada de descobertas ambíguas)

**Tom**: Profissional, claro, sem surpresas. Roadmap Steward é projetado para dar análise confiável e auditável.

### Próximos Passos Após Primeira Varredura

**Passo 1: Compartilhe com time** (se relevante)
- Encaminhe descobertas para qualquer pessoa afetada pelas recomendações
- Discuta: "Concordamos com essa prioridade? Temos capacidade?"

**Passo 2: Aprove escopo**
- Decida: "Estamos avançando ou aprofundando?"
- Decida: "Qual fase do Comando Master devemos executar primeiro?"

**Passo 3: Execute Comando Master** (ou planeje para próximo sprint)
- Se há capacidade: Cole Fase 1 imediatamente
- Se não há capacidade: Agende Fase 1 para próximo sprint, documente decisão

**Passo 4: Após Fase 1 ser concluída, continue para Fase 2 e Fase 3**
- Fase 2: Registry Governor gerencia sincronização de registry
- Fase 3: Passo de validação (garanta que tudo está coerente)

**Passo 5: Mescla & celebre**
- Revise PR
- Mescle para main
- Execute próxima varredura em 1 semana (para validar que ciclo funciona)

---

## 11. Perguntas Frequentes & Troubleshooting

### "E se Roadmap Steward Sugerir Algo Com Que Eu Discorde?"

**Resposta**: Discordância é válida. Você tem opções:

1. **Peça explicação**: "Por que você priorizou [Item X] como ALTO IMPACTO? Acho que é menor valor."
   - Roadmap Steward explicará o raciocínio. Você pode mudar de ideia, ou você pode ter melhor contexto.

2. **Solicite repriorização**: "Gostaria de desprioritizar [Item X] e focar em [Item Y] em vez. O que isso mudaria?"
   - Roadmap Steward pode recalcular impacto assumindo prioridade diferente.

3. **Override silenciosamente**: (Não recomendado, mas acontece.)
   - Você pode escolher trabalhar em algo diferente. Mas você perde rastreabilidade: próxima Varredura de Maturidade pode superficializar a mesma lacuna novamente.

**Melhor prática**: Se discordar, discuta *por quê*. Geralmente, Roadmap Steward tem motivos orientados por dados (ex: "X bloqueia 3 agentes; Y bloqueia 0"). Documente seu override no arquivo MEMORY.md para que você e o time futuro saibam por quê.

### "Como Priorizo Entre Lacunas Competindo?"

**Método**: Use Comando Master como ponto de partida, mas você pode reordenar.

1. **Alinhamento estratégico**: Esta lacuna alinha com foco atual do time?
2. **Esforço vs. impacto**: O ROI vale o esforço? (Alto impacto, baixo esforço = faça primeiro)
3. **Dependências**: Arrumar Lacuna A desbloqueia Lacuna B? (Arrume A primeiro se sim)
4. **Capacidade do time**: Você tem pessoas com skill suficiente para fazer essa lacuna?
5. **Sensibilidade de tempo**: Tem prazo? (Timeline de contratação, deadline de cliente, etc.)

**Exemplo de reordenação:**

```
Roadmap Steward sugere: BLOQUEADOR, depois ALTO #1, depois ALTO #2

Você reordena como:
- ALTO #1 (alinha com plano de contratação; mais fácil; desbloqueia BLOQUEADOR)
- BLOQUEADOR (agora você tem capacidade e conhecimento de ALTO #1)
- ALTO #2 (nice-to-have; adie para próximo sprint)
```

**Vá em frente.** O Comando Master é uma sugestão, não verdade absoluta.

### "Posso Pular um Nível?"

**Resposta curta: Não.** Os níveis se constroem. Pular cria fragilidade.

**Por quê**: Nível 4 (Auto-Auditável) requer Nível 3 (Orientado por IA) funcionar. Se você não amadureceu agentes e padrões, arquivos de missão e automação de auditoria do Nível 4 sentirão como overhead, não ajuda.

**O que você PODE fazer**: Ficar em um nível por muito tempo enquanto o aprofunda. Ex: ficar no Nível 3 por 2 anos, construindo biblioteca massiva de evals e padrões. Tudo bem.

**Mas NÃO FAÇA**: Pular de Nível 2 direto para Nível 4. Muito quebrará.

### "E se Capacidade Do Time Está Baixa?"

**Opção 1: Adie o sprint**
- Não execute sprint se não tem capacidade para executá-lo. Espere 2–3 semanas.
- Execute Varredura de Maturidade novamente naquele tempo.

**Opção 2: Reduza escopo**
- Peça ao Roadmap Steward sugerir "mini-sprint" (só 1 item, <1 semana esforço).
- Execute aquilo, depois reavalie.

**Opção 3: Contrate ou delegue**
- Se governança está bottlenecking você, considere contratar especialista (até tempo parcial) para focar em agentes/padrões.
- Ou nomeie membro do time para dono de governança por um sprint.

### "Com Que Frequência Devo Executar Varreduras de Maturidade?"

**Cadência recomendada:**

- **Mínimo**: Uma vez por quarter (a cada 3 meses). Se menos frequente, drift se acumula.
- **Típico**: Uma vez por mês (a cada 4 semanas). Dá ritmo constante; descobertas são geralmente deltas pequenas.
- **Agressivo**: A cada 2 semanas. Apenas se você está avançando níveis rapidamente (ex: transição Nível 2 → Nível 3).

**No mínimo, execute varredura quando:**

- Você está considerando avançar para próximo nível
- Composição do time muda significativamente
- Um novo sinal de mercado emerge (contratação, pedido de cliente, mudança de tecnologia)
- Um sprint se completa, e você quer validar progresso

---

## 12. Anti-Padrões & Pegadinhas

### Pegadinha 1: Avançando Muito Rápido Sem Maturidade

**Sintoma**: "Estamos usando agentes há 3 semanas; vamos avançar para Nível 4!"

**Problema**: Avançar sem 8+ semanas no nível atual significa pular o processo de *refinar* agentes, provar seu valor, treinar o time.

**Resultado**: Automação do Nível 4 (auditoria contínua, arquivos de missão) se sente como trabalho temporário. Adoção falha; você fica preso com overhead.

**Prevenção**: Siga regra de 5 portões de avanço. Estadia mínima no nível = 8 semanas (2 meses) de uso ativo.

### Pegadinha 2: Ignorando Descobertas de Auditoria

**Sintoma**: "Roadmap Steward disse que temos 3 bloqueadores, mas enviaremos features em vez."

**Problema**: Bloqueadores existem porque impedem algo importante (ex: avanço para Nível 4, risco de produção, atrito de onboarding).

**Resultado**: Próxima Varredura de Maturidade superficializará bloqueador igual novamente. Morale cai porque "governança é inútil; nada melhora."

**Prevenção**: Se não concorda que descoberta é bloqueador, discuta explicitamente com Roadmap Steward (ou time). Documente sua decisão em MEMORY.md. Não ignore silenciosamente.

### Pegadinha 3: Sobre-Customizando Saídas de Agente

**Sintoma**: "Asset Factory criou padrão, mas customizamos 60% porque 'nosso time é especial'."

**Problema**: Drift de padrões repositório. Futuros hires veem artefato não-padrão; codebase se sente caótico.

**Resultado**: Padrões perdem autoridade. Novas pessoas seguem padrão custom, não oficial. Governança erode.

**Prevenção**: Use saídas de Agente como-estão. Se precisa customizar, discuta com time *primeiro* e Roadmap Steward. Documente exceções claramente.

### Pegadinha 4: Assumindo o Sistema é Totalmente Automatizado

**Sintoma**: "Configuramos Zero Inertia Command e agora o sistema deve rodar sozinho, certo?"

**Problema**: Zero Inertia remove *trabalho repetitivo* (scaneamento, análise), mas não remove *decisões estratégicas* (o que priorizar, se avançar, como lidar com riscos).

**Resultado**: Escopo cresce. Agentes propõem muito; nada enviam. Ou decisões tomadas sem input humano; resistência organizacional cresce.

**Prevenção**: Trate Roadmap Steward como conselheiro estratégico. Você sempre está no loop de decisão:
- Você aprova escopo antes Asset Factory começar
- Você revisa descobertas antes agir
- Você decide "avançar ou aprofundar" baseado em seu contexto

### Pegadinha 5: Drift de Registry

**Sintoma**: "Criamos novo agente e eval localmente, mas não os registramos ainda."

**Problema**: Outras ferramentas não sabem sobre esses ativos. Descoberta quebra. Documentação fica velha.

**Resultado**: Próximo membro do time olha registry, não vê novo agente, o recria (duplicação). Tempo perdido.

**Prevenção**: Sincronização de registry é **não-negociável** após Asset Factory criar qualquer coisa. Execute Registry Governor como Fase 2 de cada Comando Master.

### Pegadinha 6: Faltando Contexto em Varreduras de Maturidade

**Sintoma**: Você executa Varredura de Maturidade sem fornecer contexto (tamanho time, stack, prioridades estratégicas).

**Problema**: Roadmap Steward faz assunções padrão (pequeno time, tech genérica, timeline longa). Recomendações não se encaixam em sua situação real.

**Resultado**: Análise de Lacunas se sente irrelevante. Você não implementa recomendações. Sistema parece quebrado.

**Prevenção**: Sempre inclua contexto no comando de varredura:
- Tamanho e composição do time
- Stacks e domínios de tecnologia
- Prioridades estratégicas (contratação? expansão? estabilização?)
- Restrições de timeline (precisa avançar em 3 meses ou 12?)

---

## 13. Integração com Outros Sistemas

### Conexão com `copilot-instructions.md`

[copilot-instructions.md](.github/copilot-instructions.md) define o **fluxo obrigatório para todas mudanças dirigidas por Copilot**.

Zero Inertia Command alavanca esse fluxo:

- **Descobrir**: Roadmap Steward lê registry e padrões existentes
- **Desenvolver**: Asset Factory gera rascunhos (com ciclo subagente)
- **Revisar**: Crítica subagente independente (não-negociável)
- **Melhorar**: Descobertas aplicadas
- **Validar**: Verificações de schema, validação de path, verificações de coerência
- **Sumarizar**: Logs de decisão criados

Cada ativo criado através Zero Inertia Command segue este portão. Você não tem que forçar manualmente; o fluxo é integrado.

### Conexão com `agent-mission-protocol.md`

[agent-mission-protocol.md](.github/standards/agent-mission-protocol.md) define como agentes delegam para outros agentes.

Zero Inertia Command é orquestrado através arquivos de missão:

- **Fase 1**: Roadmap Steward cria arquivo de missão para Asset Factory (`.github/MISSIONS/sprint-xxx.md`)
- **Fase 2**: Asset Factory cria arquivo de missão para Registry Governor
- **Fase 3**: Registry Governor valida e relata de volta

Cada arquivo de missão inclui:
- Agentes pai e filho
- Objetivo (o que construir e por quê)
- Links de contexto (arquivos para ler)
- Critérios de sucesso (testáveis)
- Payload de resultado (estrutura de saída esperada)

Essa rastreabilidade significa você sempre sabe *por quê* um agente fez uma decisão.

### Conexão com `governance-maturity-model.md`

[governance-maturity-model.md](library/standards/governance-maturity-model.md) é o **framework de referência** para todas Varreduras de Maturidade.

Roadmap Steward usa o modelo para:
- Avaliar seu nível atual
- Identificar o que é necessário para amadurecer o nível atual
- Recomendar se aprofunda ou avança
- Sugerir bloqueadores e dependências

Você entende o modelo, então entende resultados de varredura.

### Conexão com `MEMORY.md`

[MEMORY.md](library/github-baseline/MEMORY.md) rastreia decisões operacionais e lições aprendidas.

Após cada Varredura de Maturidade, você (ou Roadmap Steward) deve registrar:
- Descobertas (o que foi descoberto)
- Decisão (o que você escolheu fazer e por quê)
- Impacto (o que mudou como resultado)

Isto cria memória persistente de sua evolução de governança. Você futuro pode olhar atrás e ver: "Em maio, avançamos para Nível 4. Eis o que disparou essa decisão."

---

## 14. Exemplos Reais do Mundo

### Exemplo 1: Avançando de Nível 3 para Nível 4

**Contexto**: Seu time está no Nível 3 há 3 meses. Agentes são comprovados; padrões são adotados. Você quer melhorar auditabilidade e habilitar melhorias autônomas.

**Você executa**:

```text
@roadmap-steward

Estamos no Nível 3 há 3 meses. Agentes são estáveis; padrões são seguidos.
Queremos avançar para Nível 4 (Auto-Auditável) para melhorar visibilidade de governança 
e habilitar melhoria contínua.

Por favor, faça auditoria:
1. Nível 3 está maduro o suficiente para avançar?
2. Que bloqueadores do Nível 4 existem?
3. Qual é o caminho realista de Nível 3 para Nível 4?
4. Que timeline devemos planejar?
```

**Roadmap Steward retorna**:

```
AVALIAÇÃO DE AVANÇO: Nível 3 → Nível 4
=======================================

Maturidade do Nível 3: 92% (PRONTO PARA AVANÇO)
✓ 6 agentes, todos atuais e testados
✓ 8 padrões documentados e adotados
✓ 2 evals por padrão; qualidade validada
✓ copilot-instructions.md define fluxos
✓ Adoção do time é 100% (todos engenheiros usam agentes)

Bloqueadores do Nível 4: NENHUM IDENTIFICADO

Dependências para Nível 4:
1. Protocolo de Arquivo de Missão (rastreamento de delegação de agente) — NÃO AINDA IMPLEMENTADO
2. Log de Decisão (registrar *por quê* mudanças foram feitas) — NÃO AINDA IMPLEMENTADO
3. Auditoria Contínua (varreduras semanais, não manuais) — NÃO AINDA IMPLEMENTADO

Recomendação: AVANCE PARA NÍVEL 4
Timeline: 6–8 semanas (sprint de transição para implementar arquivos de missão, 
          depois estado estacionário com auditorias semanais)

Comando Master:
[Fase 1] Implementar protocolo de arquivo de missão em todos agentes
[Fase 2] Criar padrão de log de decisão
[Fase 3] Automatizar varreduras semanais de maturidade
[Fase 4] Validar auditoria contínua por 2 semanas
[Fase 5] Declarar prontidão de Nível 4
```

**Você decide**: "Sim, isto alinha com nossas metas. Comece Fase 1 próximo sprint."

**Resultado**: 6–8 semanas depois, você atinge Nível 4. Governança agora é auditável; cada mudança é rastreável.

### Exemplo 2: Descrição de Trabalho Revela Lacunas de Segurança

**Contexto**: Você está contratando "Engenheiro de DevOps Focado em Segurança." A descrição requer Docker, Kubernetes, IAM, conhecimento de conformidade.

**Você executa Captura de Sinais**:

```text
@roadmap-steward

Sinal de Descrição de Trabalho: Contratando Engenheiro de DevOps Focado em Segurança.

Requisitos:
- Expert Docker & Kubernetes
- IAM e autenticação (OAuth2, SAML, LDAP)
- Conhecimento de conformidade (SOC2, consciência de HIPAA)
- Infrastructure-as-code (Terraform, CloudFormation)

Nosso repositório cobre: Laravel, Vue.js, baseline geral GitHub.
NÃO temos agentes ou padrões específicos de infraestrutura.

Perguntas:
1. Que lacunas essa sinalização de contratação revela?
2. Devemos mudar nossas prioridades de sprint?
3. Quão urgente é fechar essas lacunas antes de contratar?
```

**Roadmap Steward retorna**:

```
ANÁLISE DE SINAL: Engenheiro de DevOps Focado em Segurança
===========================================================

Avaliação de Cobertura:
✗ Docker: Mencionado em github-baseline; sem orientação profunda
✗ Kubernetes: NÃO COBERTO
✗ IAM/Auth: Mencionado em padrão security-hardening; incompleto
✗ Conformidade: NÃO COBERTO
✗ IaC: NÃO COBERTO

Lacunas Identificadas (Classificadas por Urgência):
1. BLOQUEADOR: Agente de Boas Práticas Kubernetes
   - Por quê: Candidato perguntará "Como estruturamos manifestos K8s?"
   - Impacto: CRÍTICO (infraestrutura é central ao papel)
   - Esforço: Grande (4 semanas)
   - Recomendação: Construir antes de contratar

2. ALTO: Padrão de IAM/Autenticação
   - Por quê: Parcialmente coberto; candidato encontrará lacunas
   - Impacto: ALTO (segurança é crítica)
   - Esforço: Médio (2 semanas)
   - Recomendação: Aprofundar padrão existente

3. ALTO: Playbook de Conformidade
   - Por quê: Não coberto; conformidade é responsabilidade central
   - Impacto: ALTO (risco de produção)
   - Esforço: Médio (2–3 semanas)
   - Recomendação: Criar novo padrão

Ação Recomendada:
Se quer que essa contratação seja produtiva imediatamente:
- Sprint 1 (2 semanas): Padrão IAM + Playbook de Conformidade
- Sprint 2 (4 semanas): Agente Kubernetes
- Timeline de contratação: Comece recrutamento em 8 semanas (após ambos sprints)

Se não consegue esperar 8 semanas:
- Contrate agora; invista 2 semanas depois para documentação específica de onboarding
- Planeje desenvolvimento de agente Kubernetes para Q3 em paralelo

Este sinal de contratação deve repriorizar seu roadmap.
```

**Você decide**: "Não conseguimos esperar 8 semanas. Contratemos agora, investimos pesadamente em onboarding. Planejar desenvolvimento de agente K8s para Q3."

**Resultado**: Você contrata engenheiro; são produtivos mais rápido porque você investe em documentação upfront. Agente K8s se torna prioridade Q3.

### Exemplo 3: Varredura de Maturidade Encontra 3 Bloqueadores; Priorize & Execute

**Contexto**: Faz 2 meses da última varredura. Você executa novamente.

**Você executa**:

```text
@roadmap-steward

Varredura de maturidade de rotina. Última varredura foi há 8 semanas no Nível 3.
Contexto atual: Time é estável; sem grandes mudanças.
Execute auditoria completa e relate descobertas.
```

**Roadmap Steward retorna**:

```
AUDITORIA DE MATURIDADE: Nível 3 (85% → 82% — LEVE DECAY)
===========================================================

Mudanças-Chave Desde Última Varredura:
✓ Agentes: Todos 6 agentes presentes, atuais
✓ Padrões: 8/8 presentes; 1 está desatualizado (atualizado >2 meses atrás)
⚠ Evals: 3 evals adicionados (ótimo!); 1 eval está incompleto (faltam 2 casos de teste)
✗ copilot-instructions.md: Versão atual corresponde; sem problemas

Bloqueadores (Impedem Avanço Nível 4):
1. Eval Incompleto (Performance Laravel)
   - Casos de teste 2 e 3 estão faltando; quebra validação
   - Status: 50% completo
   - Solução: 2 horas (adicionar 2 casos de teste, validar)

2. Padrão Desatualizado (Arquitetura de Padrões)
   - Última atualização >2 meses atrás; exemplo código referencia versão antiga de agente
   - Status: 80% atual
   - Solução: 1 dia (atualizar exemplos, validar com time)

3. Lacuna de Cobertura de Eval (Vue Reactivity)
   - Agente vue-reactivity-optimizer existe; sem eval para validar suas saídas
   - Status: 0% completo
   - Solução: 4 dias (criar 3 cenários de teste, validar)

Recomendação:
Resolva todos 3 bloqueadores antes de tentar avanço para Nível 4.
Timeline: 1 semana (bloqueador 1: 2 hrs, bloqueador 2: 1 dia, bloqueador 3: 4 dias)

Comando Master:
[Fase 1] Completar eval Performance Laravel (2 horas)
[Fase 2] Atualizar padrão Arquitetura Padrões (1 dia)
[Fase 3] Criar eval Vue Reactivity (4 dias)
[Fase 4] Registry Governor sincronizar + validar
[Fase 5] Declarar bloqueadores Nível 3 resolvidos; reavaliar prontidão Nível 4

Total Estimado: 1 semana. Próxima tentativa de avanço: 2 semanas adiante.
```

**Você decide**: "Todos 3 bloqueadores são válidos. Comece Fase 1 imediatamente; aloque 1 engenheiro por 1 semana."

**Resultado**: 1 semana depois, todos bloqueadores são resolvidos. Próxima Varredura de Maturidade mostra 92% cobertura. Você está pronto para Nível 4.

---

## 15. Fechamento: O Caminho Adiante

### Resumo de Cadência Semanal

```
SEMANA 1: Varredura de Maturidade
  Seg:   Execute Zero Inertia Command (15 min)
  Ter:   Revise descobertas; aprove escopo (30 min)
  Qua–Sex: Implemente Fase 1 (Asset Factory)
  
SEMANA 2: Asset Factory + Registry Governor
  Seg:   Revise saída Fase 1; aprove ou itere
  Ter–Qui: Execute Fase 2 & 3 (Registry, validação)
  Sex:   Revisão final; mescle para main

SEMANA 3: Monitorar & Estabilizar
  Seg:   Execute validação rápida (novo ativo está sendo usado?)
  Resto: Time usa novo agente/padrão em trabalho real
  
SEMANA 4: Preparação Para Próximo Ciclo
  Seg:   Execute próxima Varredura de Maturidade
  Repetir
```

**Tempo total por ciclo**: ~2 horas de você mão-na-massa; agentes fazem pesado levantando.

### Como o Sistema Fica Autônomo Ao Longo do Tempo

Zero Inertia Command é **progressivo**:

**Hoje (Nível 3)**:
- Você executa varreduras manualmente
- Você revisa e aprova descobertas
- Você invoca agentes
- Você mescla PRs

**Depois (Nível 4)**:
- Você executa varreduras manualmente (mesmo)
- Agentes sugerem próximos itens mais inteligentemente
- Agentes criam missões automaticamente
- Você revisa e aprova (menos overhead que antes)

**Eventualmente (Nível 5)**:
- Varreduras correm continuamente (rodam semanalmente automaticamente)
- Roadmap avança baseado em sinais do time (contratação, feedback)
- Novos agentes e padrões emergem em resposta a sinais
- Você revisa resultados, não entradas
- O repositório *evolui a si mesmo*

**Você não precisa fazer nada diferente.** Conforme você avança níveis, o sistema naturalmente fica mais autônomo porque:
- Mais automação está em lugar (auditoria de Nível 4)
- Mais histórico existe (decisões são rastreáveis)
- Mais padrões são estáveis (padrões são comprovados)

### Visão: Um Repositório Que Evolui a Si Mesmo

Imagine este estado futuro:

- **Toda segunda**: Varredura de Maturidade executa automaticamente. Descobertas são postadas em canal Slack (notificação, não ação).
- **Toda sexta**: Se lacunas são encontradas, Asset Factory prepara PR de rascunho com recomendações.
- **Portões de decisão são humanos**: Você aprova rascunho ou solicita mudanças.
- **Mesclagens são contínuas**: Mudanças chegam a main assim que aprovadas.
- **Registry sempre é coerente**: Registry Governor garante sem drift.
- **Documentação fica sincronizada**: Sincronização multi-idioma é automática.
- **Time evolui naturalmente**: Novas contratações disparam Captura de Sinais; lacunas de contratação são detectadas automaticamente.

**Isto não é fantasia do futuro.** É evolução natural do sistema conforme você amadurece. Você não precisa construir tudo de uma vez. Varreduras de Maturidade e metodologia de Comando Master guiarão você aí incrementalmente.

### Quando Revisitar Esta Documentação

Revisitar este documento quando:

- Você completou seu primeiro ciclo completo (Varredura de Maturidade → Implementação → Produção). Você terá perguntas concretas que este doc não responde.
- Você está transicionando entre níveis. Este doc explica caminho; você precisará confirmar timelines e escopo.
- Composição do time muda. Novos engenheiros precisam deste documento por contexto.
- Você está construindo novos agentes ou padrões e quer alinhar com modelo de governança.

**Esta documentação é um blueprint, não verdade absoluta.** Adapte à seu contexto. Se algo neste doc não funciona para seu time, discuta explicitamente (não ignore silenciosamente). A meta é governança que serve seu time, não governança que serve a si mesma.

---

## Apêndice A: Referências

- [Modelo de Governança de Maturidade](../library/standards/governance-maturity-model.md) — Framework completo de 5 níveis com expectativas detalhadas por nível
- [Agente Roadmap Steward](.github/agents/roadmap-steward.agent.md) — Especificação de agente e fluxos
- [Agente Asset Factory](.github/agents/asset-factory.agent.md) — Como novos ativos são criados
- [Agente Registry Governor](.github/agents/registry-schema-governor.agent.md) — Como registry é gerenciado
- [Protocolo de Missão de Agente](../library/standards/agent-mission-protocol.md) — Padrão de rastreabilidade de delegação
- [Instruções de Copilot](.github/copilot-instructions.md) — Fluxo obrigatório para todas mudanças
- [MEMORY.md](../library/github-baseline/MEMORY.md) — Rastreamento de decisão operacional

---

**Versão do Documento**: 1.0.0  
**Última Atualização**: 2026-05-11  
**Idioma**: Português (Brasileiro)  
**Status**: Estável, pronto para uso em produção
