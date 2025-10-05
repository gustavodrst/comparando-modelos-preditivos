## ⚽ Introdução

O futebol, como esporte de alta intensidade e contato, demanda um desempenho físico excepcional de seus atletas. A busca constante por vantagens competitivas elevou a importância de estratégias de otimização de performance e, crucialmente, de prevenção de lesões. Historicamente, a abordagem para a gestão da saúde dos jogadores era reativa, focada no tratamento após a ocorrência de uma lesão. Contudo, a evolução da ciência e da tecnologia nos permite uma transição para um paradigma proativo, onde a prevenção se torna o foco principal.

A capacidade de prever a probabilidade de um atleta sofrer uma lesão representa uma mudança fundamental nessa dinâmica. A utilização de modelos de classificação surge como uma ferramenta de valor inestimável para essa tarefa. Ao integrar e analisar uma variedade de dados desde a carga de treino e o histórico de lesões até informações biomecânicas e biológicas, esses modelos podem identificar padrões complexos e predizer o risco de lesão. A relevância dessa abordagem se estende por múltiplos domínios: do ponto de vista médico, permite a intervenção precoce e personalizada, no âmbito esportivo, contribui para a otimização da carga de treinamento e a redução do tempo de inatividade, e em termos financeiros, protege o investimento em atletas de alto nível. Portanto, este estudo visa explorar a aplicação e a eficácia de modelos de classificação para a previsão de lesões no futebol, demonstrando como essa abordagem baseada em dados é essencial para a saúde e o sucesso a longo prazo dos jogadores e de suas equipes.

### 🎯Objetivo

Este estudo tem como objetivo principal analisar e comparar a eficácia de três modelos de classificação: Árvore de decisão, Floresta aleatória(Random Forest) e KNN (k-Nearest Neighbors) para prever lesões no futebol. A comparação será pautada em métricas de desempenho essenciais, como acurácia, sensibilidade e precisão, a fim de determinar qual modelo apresenta a melhor performance preditiva para prever lesões no futebol.

#### Questões de pesquisa

-   Qual a posição no futebol é mais sucetível a lesões?

-   A rotina de aquecimento desempenha um papel fundamental na prevenção de lesões?

-   Qual modelo melhor prevê lesões nos jogadores?

-   Quais váriaveis são mais importantes para a previsão de lesões desse modelo?

-   Teria aplicabilidade para a UFU?

## 🎲 Dados

O conjunto de dados escolhido foi o `Conjunto de dados de previsão de lesões no futebol universitário`, retirado o site [kaggle](https://www.kaggle.com/datasets/yuanchunhong/university-football-injury-prediction-dataset/data).

### Descrição do conjunto de dados e objetivo

Esta base de dados reúne informações detalhadas de 800 futebolistas universitários da China, atuantes em ligas de nível universitário e provincial. O propósito principal é aplicar modelos de classificação de aprendizado de máquina para antecipar a probabilidade de um atleta sofrer uma lesão durante a próxima temporada.

#### Variáveis presentes no data frame
![](https://github.com/gustavodrst/imagens/blob/main/tabela%20variaveis.png)

A variável alvo deste estudo, `Injury_Next_Season` (Possibilidade de Lesão), é uma classificação binária que identifica a possibilidade de ocorrência de lesões na próxima temporada. Uma lesão é definida como qualquer dano relacionado ao treinamento ou competição que resulte em 7 ou mais dias consecutivos de afastamento, conforme verificado pela equipe técnica e pelo centro médico universitário.

## 🛠️ Materiais e Métodos

O pré-processamento dos dados consistiu em duas etapas principais: a verificação de dados faltantes em todas as colunas e a conversão da variável resposta de numérica para factor, garantindo assim a qualidade e a prontidão dos dados para análise.

![](https://github.com/gustavodrst/imagens/blob/main/valores%20ausentes.png)

### 🧮 Modelos de classificação

O presente estudo empregou uma abordagem de aprendizado de máquina supervisionado para classificar jogadores suscetíveis a lesões para a próxima temporada, utilizando três modelos distintos: Árvore de Decisão, Floresta Aleatória e KNN (k-Nearest Neighbors). A verificação dessas ocorrências foi realizada e confirmada pelo centro médico universitário e pela equipe técnica.

Modelos de Classificação

1.  Árvore de Decisão: A Árvore de Decisão é um modelo preditivo que utiliza uma abordagem hierárquica, baseada em regras condicionais, para classificar os dados. O modelo constrói uma estrutura de árvore com nós de decisão, que representam testes em atributos, e nós folha, que correspondem às classificações finais (lesão ou sem lesão). Para este estudo, a árvore foi treinada com o objetivo de encontrar os melhores pontos de divisão nos dados que maximizem a pureza dos nós, resultando em uma lógica de fácil interpretação para a previsão de lesões.

2.  Floresta Aleatória(Random Forest): A Floresta Aleatória opera construindo múltiplas árvores de decisão em subconjuntos aleatórios dos dados e das variáveis. Para a classificação de um novo jogador, o modelo agrega as previsões de cada árvore individual e determina a classe final por meio de um sistema de voto majoritário. Esta abordagem foi utilizada para mitigar o risco de overfitting inerente a árvores de decisão únicas e para aumentar a robustez e a precisão das previsões de lesões.

3.  KNN (k-Nearest Neighbors): O KNN é um algoritmo de aprendizado de máquina não-paramétrico que classifica novas observações com base em sua similaridade com as observações existentes. A classificação de um jogador é determinada pela classe majoritária de seus k vizinhos mais próximos no espaço multidimensional dos dados. Para a aplicação deste modelo, a distância euclidiana foi utilizada como métrica para identificar os vizinhos mais próximos, com a finalidade de classificar a possibilidade de lesão com base nas características de jogadores com perfis semelhantes.

A eficácia de cada modelo será avaliada com base em métricas de desempenho essenciais, como acurácia, sensibilidade e precisão, que permitirão determinar qual dos três modelos oferece a melhor performance preditiva para o problema de classificação de lesões.

No entanto, antes de realizar a construção e aplicação dos modelos a base de dados, uma análise exploratória preliminar foi conduzida. Neste processo, foram geradas visualizações como histogramas e boxplots dos parâmetros físicos dos jogadores, o que possibilitou a identificação de padrões e a verificação de potenciais relações entre as variáveis com o objetivo de compreender a estrutura e a distribuição dos dados.

Hitogramas e Boxsplots:

![](https://github.com/gustavodrst/imagens/blob/main/histogramas.png) ![](https://github.com/gustavodrst/imagens/blob/main/boxsplots.png)

Por meio do seguinte gráfico foi identificado que não há posição de jogo que apresenta destaque na média de lesões.

![](https://github.com/gustavodrst/imagens/blob/main/media%20de%20lesoes.png)

Além disso, atletas com maior adesão à rotina de aquecimento apresentam ligeira média menor de lesões durante a temporada.

![](https://github.com/gustavodrst/imagens/blob/main/rotina%20de%20aquecimento.png)

Por fim, foi realizada uma análise de correlação utilizando o metódo de Pearson para quantificar o grau de relação entre as variáveis de estudo e a variável alvo.

![](https://github.com/gustavodrst/imagens/blob/main/Correla%C3%A7%C3%A3o.png)

Observou-se que as seguintes variáveis apresentam correlação direta forte: Stress_Level_Score (Nível de estresse), Reaction_Time_ms (Tempo de reação) e Previous_Injury_Count (Histórico de lesão).

Por outro lado, as variáveis com correlação inversa proeminente são: Sleep_Hours_Per_Night (Horas de sono), Balance_Test_Score (Equilíbrio) e Sprint_Speed_10m_s (Velocidade de corrida).

## 📊 Resultados

Para verificar o modelo que melhor prediz se o jogador irá se lesionar na próxima temporada foram utilizadas as seguintes métricas:

Acurácia: mede a proporção de todas as previsões que o modelo acertou em relação ao total de previsões.

$$Acurácia = \frac{VP+VN}{VP+VN+FP+FN}$$

Precisão: mede a capacidade do modelo de fazer previsões positivas corretamente

$$Precisão = \frac{VP}{VP+FP}$$

Sensibilidade: mede a capacidade do modelo de encontrar corretamente todos os casos positivos

$$Sensibilidade = \frac{VP}{VP+FN}$$ 

Onde:
-   Verdadeiro Positivo (VP): O modelo acertou a classe positiva.
-   Verdadeiro Negativo (VN): O modelo acertou a classe negativa.
-   Falso Negativo (FN): O modelo classificou como negativa, mas o real era positivo.
-   Falso Positivo (FP): O modelo classificou como positiva, mas o real era negativo.

### 📈 Aplicação dos modelos

O primeiro modelo utilizado foi a Árvore de decisão, sendo obtido a seguinte árvore:

![](https://github.com/gustavodrst/imagens/blob/main/arvore%20decisao.png)

Foi obtido a seguinte matriz de confusão do modelo árvore de decisão:

| Matriz de confusão | Real positivo | Real negativo |
|--------------------|---------------|---------------|
| Previsto positivo  | 60            | 14            |
| Previsto negativo  | 20            | 66            |

O segundo modelo utilizado foi o KNN, obtendo a seguinte matriz de confusão:

| Matriz de confusão | Real positivo | Real negativo |
|--------------------|---------------|---------------|
| Previsto positivo  | 75            | 2             |
| Previsto negativo  | 5             | 78            |

Por fim, o último modelo de classificação praticado foi a Floresta aleatória, o qual retornou a seguinte matriz de confusão:

| Matriz de confusão | Real positivo | Real negativo |
|--------------------|---------------|---------------|
| Previsto positivo  | 77            | 4             |
| Previsto negativo  | 3             | 76            |

Desse modo, obtvemos as seguintes metricas dos modelos:

|Modelos             | Acurácia | Precisão | Sensibilidade |
|--------------------|----------|----------|---------------|
| Árvore de decisão  | 78.75%	  | 81.08%   | 75.0%         |
| KNN	               | 95.62%	  | 97.40%   | 93.75%        |
| Floresta aleatória |	95.62%	| 95.06%	 | 96.25%        |

## 📋Discussão

Para prever uma lesão, o custo de um falso negativo é muito mais alto do que o de um falso positivo. É preferível poupar um jogador desnecessariamente do que arriscar uma lesão grave que não foi prevista.

Por esse motivo, a Sensibilidade é a métrica mais importante neste cenário.

Considerando isso, o melhor modelo seria a Floresta aleatória. Embora o KNN tenha uma precisão ligeiramente maior, a Floresta aleatória é superior na capacidade de detectar a maior quantidade possível de lesões reais pois possui a maior sensibilidade, o que é o objetivo principal para garantir a saúde do atleta.

### 🚫 Limitações do estudo

Apesar dos resultados promissores, o estudo possui algumas limitações importantes que devem ser consideradas:

-   Generalização dos Dados: O conjunto de dados é específico para 800 futebolistas universitários da China. Os resultados podem não ser diretamente aplicáveis a atletas profissionais, de outras nacionalidades, faixas etárias ou gênero, que possuem diferentes cargas de treino, fisiologias e acompanhamento médico.

-   Definição de Lesão: A lesão foi definida como um afastamento de 7 ou mais dias consecutivos. Isso exclui lesões mais leves ou dores crônicas que, embora não causem um afastamento longo, podem impactar o desempenho e ser precursoras de problemas mais graves.

-   Variáveis: Fatores como dados biomecânicos mais detalhados, predisposição genética, aspectos psicológicos aprofundados ou qualidade da recuperação pós-treino não foram incluídos e poderiam aprimorar a previsão.

### 🗣 Sugestões para trabalhos futuros

Com base nas limitações identificadas, os seguintes passos poderiam aprofundar e expandir esta pesquisa:

-   Ampliar a Amostra de Dados: Coletar dados de diferentes populações de atletas tais como profissionais, femininas, de outras ligas e países para criar modelos mais robustos e generalizáveis. A própria questão de pesquisa sobre a aplicabilidade na UFU aponta para essa direção.

-   Incorporar Novas Variáveis: Utilizar tecnologias de monitoramento, como sensores, para obter dados em tempo real sobre carga de trabalho, impacto e fadiga, enriquecendo o conjunto de preditores.

-   Explorar Outros Algoritmos: Testar modelos mais complexos, como Redes Neurais ou modelos de Deep Learning, que podem capturar padrões não lineares mais complexos nos dados.

-   Validação em Ambiente Real: Implementar o modelo Floresta aleatória como uma ferramenta de triagem em uma equipe real, tal como a da UFU, validando se as intervenções preventivas baseadas em suas previsões de fato reduzem a incidência de lesões.

## 💡Conclusão

Este estudo demonstrou a viabilidade e a eficácia da aplicação de modelos de aprendizado de máquina para a previsão de lesões no futebol universitário. A análise exploratória identificou variáveis com forte correlação com a ocorrência de lesões, incluindo fatores de risco como alto nível de estresse, maior tempo de reação e histórico de lesões prévias, e fatores de proteção como mais horas de sono e melhor equilíbrio. A comparação de modelos mostrou que o Floresta aleatória e o KNN superam a Árvore de Decisão.

O modelo Floresta aleatória foi identificado como o de melhor desempenho geral. Com maior acurácia e sensibilidade entre os modelos testados, sendo assim, ele oferece a melhor capacidade para identificar corretamente os atletas em risco de sofrer uma lesão futura, alinhando-se perfeitamente com o objetivo principal de identificar os jogares com maior potencial de lesionarem.

A implementação de um modelo preditivo como o Floresta aleatória pode transformar a gestão da saúde dos atletas, passando de uma abordagem reativa para uma proativa. As equipes podem utilizar o modelo para triar atletas, identificar aqueles com maior risco de lesão e intervir preventivamente por meio de programas de treinamento personalizados, ajustes na carga de trabalho, fisioterapia focada e monitoramento aprimorado.

Portanto, uma abordagem orientada por dados, através de modelos de classificação, é uma estratégia poderosa e eficaz para a prevenção de lesões no esporte. O estudo comprova que é possível prever com alta precisão o risco de lesões, permitindo que as equipes ajam antes que elas ocorram.
