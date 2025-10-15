# RPG por Turnos (Flutter)

## Visão geral

RPG leve por turnos, multiplataforma (Flutter), focado em progressão de personagem, gerenciamento de inventário, missões com acompanhamento de progresso e batalhas rápidas. O jogador evolui derrotando inimigos, coletando moedas e itens, comprando/vendendo na loja e concluindo missões.

- Plataformas: Android, iOS, Web e Desktop (Windows, macOS, Linux).
- Perspectiva: UI orientada a cards/listas, com telas dedicadas para Personagem, Itens, Missões e Cidades.
- Público-alvo: jogadores casuais de RPG com foco em progressão e colecionáveis.

## Loop central do jogo

1. Encontrar/Enfrentar inimigos (Batalha por turnos).
2. Usar ataque físico, magia ou itens para vencer.
3. Receber recompensas: XP, moedas e possíveis drops de itens.
4. Subir de nível, melhorar atributos, comprar/vender itens.
5. Avançar missões através de vitórias e objetivos.
6. Repetir até concluir missões e metas de progressão.

## Personagens

Cada personagem tem atributos, inventário e uma missão associada.

- Atributos base:
  - Nível: de 1 até 50 (cap).
  - XP: experiência atual; ao atingir o necessário, sobe de nível.
  - HP/Mana: valores atuais e máximos.
  - Ataque/Defesa.

- Limites (caps):
  - Nível máximo: 50
  - HP máx.: 999
  - Mana máx.: 500
  - Ataque máx.: 200
  - Defesa máx.: 200

- Progressão de nível:
  - Ao ganhar XP, quando atingir o limiar, sobe de nível e:
    - +12 no HP máximo
    - +6 na Mana máxima
    - +3 no Ataque
    - +2 na Defesa
    - HP e Mana são totalmente restaurados
  - O custo de XP para o próximo nível cresce suavemente: 35% a cada nível.
    - Fórmula: $XP_{próximo} = \lceil XP_{atual} \times 1.35 \rceil$
  - No nível 50, a XP é limitada e não há mais ganho de níveis.

- Inventário do personagem:
  - Lista de itens carregados pelo personagem.
  - Ações: Usar item (em batalha), Vender item (economia), Remover item.

## Combate por turnos

- Fluxo:
  - Jogador escolhe ação: Ataque Físico, Magia (elemental) ou Item.
  - Inimigo possui HP, Ataque, Defesa e uma fraqueza elemental.
  - Ao reduzir o HP do inimigo a 0, há vitória e distribuição de recompensas.

- Ataque físico:
  - Dano básico: tentativa de $dano = ataque_{jogador} - defesa_{inimigo}$.
  - Se a defesa do inimigo for maior ou igual ao ataque do jogador, o ataque pode ser bloqueado (sem dano).

- Magia elemental:
  - Tipos: Fogo, Gelo, Raio.
  - Inimigos têm uma fraqueza entre esses elementos.
  - Custo de Mana fixo por uso (por exemplo, 10).
  - Dano base: 15 por carga de magia.
  - Multiplicadores:
    - Fraqueza: $\times 1.5$ se o elemento corresponder à fraqueza do inimigo.
    - Multiplicador manual do jogador (ex.: x1, x2, ...), controlado na UI.
  - Fórmula de dano mágico: $dano = \operatorname{round}(15 \times mult_{magia} \times (fraqueza?\ 1.5:1.0))$.

- Itens em batalha:
  - Tipos de efeito: Cura de HP, Cura de Mana, Buff de Ataque, Buff de Defesa, Dano Mágico.
  - Alguns itens são consumíveis (somem após uso), outros são permanentes (ex.: equipamentos/buffs fixos).
  - Efeitos respeitam os caps de atributos.

- Derrota/Vitória:
  - Derrota: HP do jogador reduzido a 0 (mostra aviso de morte).
  - Vitória: sempre concede XP e moedas; itens podem “dropar” por chance.

## Inimigos e recompensas

- Atributos do inimigo:
  - HP, Ataque, Defesa, Fraqueza elemental.
- Recompensas garantidas ao vencer:
  - XP (xpRecompensa)
  - Moedas (moedasRecompensa)
- Tabela de drops por inimigo:
  - Cada entrada tem nome do item, chance de 0.0 a 1.0 e faixa de quantidade.
  - Para cada drop, uma rolagem decide se cai; ao cair, adiciona ao inventário do personagem.

Exemplos (ajustáveis para balanceamento):
- Goblin: 20 XP, 10 moedas; chance de Poção (25%), Adaga (10%).
- Esqueleto: 35 XP, 20 moedas; chance de Espada (8%), Poção de Vida (18%).
- Lobo de Gelo: 28 XP, 18 moedas; chance de Escudo (12%), Poção (22%).

## Missões e progresso

- Cada personagem possui uma missão com:
  - id (identificador), descrição, objetivo total e progresso atual.
  - A missão é concluída quando $progressoAtual \ge objetivoTotal$.
  - Progresso por vitória: a cada inimigo derrotado, +1 no progresso (padrão).
- UI de missões:
  - Resumo no topo: “Concluídas: X/Y”.
  - Cartões por personagem mostrando descrição, barra de progresso e status (Concluída/Em andamento).
- Recompensas de missão (sugestão/comportamento padrão):
  - Ao concluir, conceder moedas/itens/XP bônus (ex.: +50 moedas).

## Itens e economia

- Estrutura dos itens:
  - nome, descrição
  - preço de compra (preco)
  - preço de venda (precoVenda), padrão metade do preço de compra
  - tipo de efeito (curaHp, curaMana, buffAtaque, buffDefesa, danoMagico)
  - valor do efeito
  - consumível (true/false)

- Exemplos de itens:
  - Poção de Vida: consumível, cura 30 HP.
  - Poção: consumível, cura 20 HP.
  - Espada/Escudo/Adaga: não consumíveis, fornecem buffs fixos de ataque/defesa.

- Loja:
  - Lista de itens à venda com preço de compra e valor de venda exibidos.
  - Compra exige moedas suficientes; ao comprar, item vai para o inventário.
  - Venda pode ser feita pela tela do personagem (ação “Vender”).

- Moedas:
  - Obtidas ao vencer batalhas e concluir missões.
  - Gastas na loja para aquisição de itens.

## Cidades

- Tela de Cidades para ambientação e expansão futura (lojas, NPCs, viagens).
- Exibe a cidade atual do personagem; pode listar locais visitáveis.

## Salvamento e carregamento

- Sistema de save/load do personagem (simulado no serviço), preservando:
  - Atributos, inventário, missão e progresso, cidade, XP e nível.
- Carregamento fornece um personagem jogável com estado persistido.

## UI e navegação

- Fluxo inicial:
  - Criar novo personagem (nome, valores padrão) ou carregar jogo salvo.
- Tela principal (tabs):
  - Personagem: status (HP, Mana, XP, Nível) e batalhas.
  - Itens: inventário geral (visualização por personagem).
  - Missões: resumo e progresso por personagem.
  - Cidades: contexto e interação futura.
- Tela de Detalhe do Personagem:
  - Barras de HP/Mana/XP, nível atual, ações de batalha (Físico/Magia), itens, logs.

## Balanceamento e fórmulas

- Crescimento por nível (por nível ganho):
  - $HP_{max} += 12$, $Mana_{max} += 6$, $Ataque += 3$, $Defesa += 2$.
- Custo de XP:
  - $XP_{próximo} = \lceil XP_{atual} \times 1.35 \rceil$.
- Dano físico:
  - $dano = \max(ataque - defesa, 0)$; se $ataque \le defesa$, o golpe pode ser bloqueado.
- Dano mágico:
  - $dano = \operatorname{round}(15 \times mult_{magia} \times (fraqueza?\ 1.5:1.0))$.
- Drops:
  - Para cada item na tabela: rolagem $r \in [0,1]$; se $r \le chance$, cai entre $[quantidadeMin, quantidadeMax]$.

## Acessibilidade e opções (recomendado)

- Tamanhos de fonte ajustáveis.
- Feedback sonoro/visual nas ações (ataques, vitória, drops).
- Paleta com bom contraste (tema escuro já adotado).

## Telemetria (opcional)

- Contagem de vitórias/derrotas, uso de itens, economia (compras/vendas), progresso médio de missão.

## Conteúdo e expansão futura

- Novos inimigos com mecânicas especiais, bosses com fases.
- Árvores de talentos/perícias para o personagem.
- Conjuntos de equipamentos com bônus de set.
- Múltiplas cidades com lojas exclusivas e NPCs de missão.
- Eventos aleatórios e encontros especiais.

## Critérios de sucesso

- Sessões curtas com sensação de progresso a cada batalha.
- Economia justa (sem grinds excessivos) e drops que motivem o próximo combate.
- Missões claras, com feedback constante de avanço e conclusão.

---

Documento criado para orientar desenvolvimento, balanceamento e validação de funcionalidades do RPG por turnos em Flutter.
