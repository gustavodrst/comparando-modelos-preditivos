# Bibliotecas que serão utilizadas no projeto

library(readr) # Utilizada para a leitura de arquivos(CSV, TXT, XLSX....)
library(rpart) # Utilizada para construir a árvore de decisão
library(rpart.plot) # Utiizada para plotar a árvore
library(randomForest) # Utilizada para construir a Floresta aleátória
library(caret) # Utilizado para treinar o modelo KNN com validação cruzada
library(class) # Para utilizar o o modelo KNN
library(tidyverse) # Utilizada para tratamento de dados
library(ggplot2) # Utilizada para visualização dos dados
library(DataExplorer) # Para utilizar função plot_missing
library(patchwork) # Utilizada para montar combinação de gráficos
library(fastDummies) # Utilizada para realizar o One-Hot Encoding para o modelo KNN
library(ggcorrplot) # Utilizado para construir a correlação
library(tibble) # para Utilizar a função rownames_to_column()

# Leitura da base de dados retirada do Site Kaggle.

dados <- read.csv("data.csv", sep= ",")

# Verificando as variaveis
summary(dados)

#convertendo a variavel alvo para fator
dados <- dados |>
  mutate(Injury_Next_Season = as.factor(Injury_Next_Season))

# verificando se temos valores missing em cada uma das colunas
plot_missing(dados,
             group = list(Good = 0.0, OK = 0.4, Bad = 0.8, Remove = 1),
             title = "Porcentagem de valores ausentes na base de dados",
             ggtheme = theme_bw(),
             theme_config = list(legend.position = "none",plot.title = element_text(hjust = 0.5)))

# Verificando se as classes da variável estão balanceadas
contagem_distinta <- table(dados$Injury_Next_Season)
contagem_distinta

# Vizulizando os dados quanto a parametros físicos dos jogadores

# Histogramas

# Distribuição Altura
h1 <- dados |>
  ggplot(aes(x=Height_cm))+
  geom_histogram(bins=15, alpha=0.5, fill = "skyblue",color = "black", position = "identity")+
  labs(title = "Distribuição altura", y = "Frequência", x = "Altura(cm)")+
  scale_x_continuous(breaks = seq(150,200, by = 5))+
  scale_y_continuous(breaks = seq(0,200, by = 20))+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))

# Distribuição peso
h2 <- dados |>
  ggplot(aes(x=Weight_kg))+
  geom_histogram(bins=15, alpha=0.5, fill = "skyblue",color = "black", position = "identity")+
  labs(title = "Distribuição peso", y = "Freqência", x = "Peso(Kg)")+
  scale_x_continuous(breaks = seq(40,110, by =5))+
  scale_y_continuous(breaks = seq(0,200, by = 20))+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))

# Distribuição Idade
h3 <- dados |>
  ggplot(aes(x=Age))+
  geom_histogram(bins=7, alpha=0.5, fill = "skyblue",color = "black", position = "identity")+
  labs(title = "Distribuição idade", y = "Frequência", x = "Idade(anos)")+
  scale_x_continuous(breaks = seq(18,24, by =1))+
  scale_y_continuous(breaks = seq(0,200, by = 20))+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))

# Distribuição IMC
h4 <- dados |>
  ggplot(aes(x=BMI))+
  geom_histogram(bins=15, alpha=0.5, fill = "skyblue",color = "black", position = "identity")+
  labs(title = "Distribuição IMC", y = "Frequência", x = "IMC")+
  scale_x_continuous(breaks = seq(13,37, by =2))+
  scale_y_continuous(breaks = seq(0,200, by = 20))+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))

# Gráficos de distribuição juntos
(h1 + h2) / (h3 + h4)


# BoxPlots

# Boxplot altura 
b1 <- dados |>
  ggplot(aes(y=Height_cm, x=""))+
  geom_errorbar(stat="boxplot", width = 0.1)+
  geom_boxplot(width = 0.6,fill="skyblue", outlier.shape = 1)+
  labs(title = "Boxsplot altura",y = "Altura(cm)", x = "")+
  scale_y_continuous(breaks = seq(150,200, by = 5))+
  theme_bw()+
  theme(plot.title = element_text(hjust = 0.5))

# Boxplot peso
b2 <- dados |>
  ggplot(aes(y=Weight_kg, x=""))+
  geom_errorbar(stat="boxplot", width = 0.1)+
  geom_boxplot(width = 0.6,fill="skyblue", outlier.shape = 1)+
  labs(title = "Boxsplot peso",y = "Peso(Kg)", x = "")+
  scale_y_continuous(breaks = seq(40,110, by = 5))+
  theme_bw()+
  theme(plot.title = element_text(hjust = 0.5))

# Boxplot IMC
b3 <- dados |>
  ggplot(aes(y=BMI, x=""))+
  geom_errorbar(stat="boxplot", width = 0.1)+
  geom_boxplot(width = 0.6,fill="skyblue", outlier.shape = 1)+
  labs(title = "Boxsplot IMC",y = "IMC", x = "")+
  scale_y_continuous(breaks = seq(13,37, by = 3))+
  theme_bw()+
  theme(plot.title = element_text(hjust = 0.5))

# Gráficos de Boxplot juntos
b1 + b2 + b3

# AGRUPAR E SOMAR AS LESÕES POR POSIÇÃO
lesoes <- dados|>
  group_by(Position)|>
  summarise(total_lesoes = round(mean(Previous_Injury_Count),2))

# Gráfico de lesões por posição
lesoes |>
  ggplot(aes(x=Position, y =total_lesoes))+
  geom_bar(stat = "identity", fill = "skyblue")+
  geom_label(aes(label = total_lesoes),
             vjust = 1.5, # Ajuste para ficar dentro da barra
             fill = "white", # Cor do fundo do rótulo
             colour = "black", # Cor do texto
             size = 3.5)+
  labs(title = "Média de lesões por posição", y = "Média de lesões", x = "Posição")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))

# AGRUPAR E SOMAR AS LESÕES POR ADESÃO
lesoes_aquecimento <- dados|>
  group_by(Warmup_Routine_Adherence)|>
  summarise(total_lesoes = round(mean(Previous_Injury_Count), 2))

# Gráfico de lesões por adesão a rotina de aquecimento
lesoes_aquecimento |>
  ggplot(aes(x=Warmup_Routine_Adherence, y = total_lesoes))+
  geom_bar(stat = "identity", fill = "skyblue")+
  geom_label(aes(label = total_lesoes),
             vjust = 1.5, # Ajuste para ficar dentro da barra
             fill = "white", # Cor do fundo do rótulo
             colour = "black", # Cor do texto
             size = 3.5)+
  scale_x_continuous(breaks = seq(0,1, by = 1))+
  labs(title = "Média de lesões na temporada e rotina de aquecimento", y = "Média de lesões", x = "	Adesão à rotina de aquecimento")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))

# Construindo um gráfico de correlação
# Para isso não utilizaremos a variavei Position retornaremos a coluna Injury_Next_Season para numeric
correlacao <- dados |>
  select(-Position) |>
  mutate(Injury_Next_Season = as.numeric(Injury_Next_Season))

# matriz de correlação
correl <- cor(correlacao)

# Montando o gráfico
ggcorrplot(correl,
           hc.order = TRUE,
           type = "lower",
           ggtheme =ggplot2::theme_bw()+
             theme(plot.title = element_text(hjust = 0.5), legend.text = element_text(size = 5)),
           title = "Mapa de calor de correlação de características numéricas",
           legend.title = "Correlação",
           lab = TRUE,lab_size = 2.5,
           tl.cex = 9,
           tl.col = "black",
           tl.srt = 45)


# Gráfico de relação entre flexibilidade X estresse X possibilidade de lesão
dados |>
  ggplot(mapping = aes(x =Stress_Level_Score, y =Hamstring_Flexibility, col =Injury_Next_Season))+
  geom_point()+
  scale_color_manual(values = c("0" = "#66c2a5", "1" = "firebrick")) +
  facet_wrap(~Injury_Next_Season)+
  labs(x = "Nível de estresse",y = "Flexibilidade dos isquiotibiais",title = "Propenção a lesão relacionado a flexibilidade e estresse") +
  theme_bw()+
  theme(legend.position = "none",plot.title = element_text(hjust = 0.5))
#plot.title = element_markdown(size = 12, face = "bold"))


# CONSTRUINDO E APLICANDO O MODELO ÁRVORE DE DECISÃO

# determinando uma semente para fins de reprodutibilidade
set.seed(1915)

# embaralhando os dados
dados <- dados[sample(nrow(dados)),] 

#  seguir, dividiremos os dados em conjuntos de treino e teste. Deixaremos 80% dos dados para treino e 20% para teste. Esse bases serão utilizados para treinar e testar os modelos.
n <- round(0.8*nrow(dados))
dados_treino <- dados[1:n,]
dados_teste <- dados[-(1:n),]

# Criando a árvore grande
arvore_lesao_grande <- rpart(Injury_Next_Season ~., data = dados_treino, method = "class")

# Visualizando a árvore grade
rpart.plot(arvore_lesao_grande, extra = 101)

# Aplicando a árvore grande
previsao_arvore_grande <- predict(arvore_lesao_grande, dados_teste, type = "class")

# Contruindo matriz de confusão e demais métricas para a árvore grande
matriz_arvore_grande<- confusionMatrix(table(previsao_arvore_grande, dados_teste$Injury_Next_Season),positive = "1")

# Verificando os valores para xerror
arvore_lesao_grande$cptable

# selecinando o melhor xerror e alfa
menor <- which.min(arvore_lesao_grande$cptable[, "xerror"])
alpha_otimo <- arvore_lesao_grande$cptable[menor,"CP"]

# Apliacando a poda
arvore_podada <- prune(arvore_lesao_grande, cp = alpha_otimo)

# Plotando a árvore podada
rpart.plot(arvore_podada, extra = 101)

# Aplicando a árvore podada
previsao_poda <- predict(arvore_podada, newdata = dados_teste, type = "class")

# Contruindo matriz de confusão e demais métricas para a árvore podada
matriz_arvore_podada<- confusionMatrix(previsao_poda, dados_teste$Injury_Next_Season,positive = "1")

# CONSTRUINDO E APLICANDO O MODELO KNN

# Vamos normalizar a coluna "Position" utilizando o metodo One-Hot Encoding
# Aplicar One-Hot Encoding para a base teste
dados_teste_knn <- dummy_cols(dados_teste, 
                              select_columns = c("Position"),
                              remove_first_dummy = FALSE,
                              remove_selected_columns = TRUE)

# Aplicar One-Hot Encoding para a base treino
dados_treino_knn <- dummy_cols(dados_treino, 
                               select_columns = c("Position"),
                               remove_first_dummy = FALSE,
                               remove_selected_columns = TRUE)

# Padronizando os dados exceto minha variável alvo
treino_padronizado <- scale(dados_treino_knn[,-17])
teste_padronizado <- scale(dados_teste_knn[,-17])

# Vamos utilizar o Crossvalidation com 10 folds (10 subpastas)
controle <- trainControl(method ="cv",
                         number = 10)

# Grid de valores de k(vizinhos próximos) para testar
grid_k <- expand.grid(k = 1:20)

# Verificando o desempenho para 10 folds e k de 1 a 20
treinamento <- train(Injury_Next_Season ~ .,
                     data = dados_treino,
                     trControl = controle,
                     preProcess = c("center", "scale"),
                     method = "knn",
                     tuneGrid = grid_k)

# Visualizando a Acurácia X número de vizinhos
plot(treinamento) 

# Melhor KNN
treinamento$finalModel

# Modelo KNN com a melhor acurácia
modelo_knn <- knn(train = treino_padronizado,
                  test = teste_padronizado,
                  cl = dados_treino_knn$Injury_Next_Season,
                  k = treinamento$bestTune)

# Matriz de confusão do modelo final
matriz_KNN <- confusionMatrix(reference = dados_teste_knn$Injury_Next_Season, 
                              data = modelo_knn, 
                              positive = "1")
names(modelo.floresta)

# CONSTRUINDO E APLICANDO A FLORESTA ALEATÓRIA

# Construindo a Floresta aleatória
modelo.floresta <- randomForest(Injury_Next_Season ~.,
                                data = dados_treino,
                                importance = TRUE)

# Aplicando a Floresta aleatória
previsao.floresta <- predict(modelo.floresta, newdata = dados_teste, type = "class")

# Matriz de confusão do modelo
matriz_floresta <- confusionMatrix(reference = dados_teste$Injury_Next_Season,
                                   data = previsao.floresta,
                                   positive = "1")

# Verificando a ordem de importância das variaveis
importancia <- data.frame(importance(modelo.floresta)) 

# Averiguando as variaveis mais importantes 
varImpPlot(modelo.floresta)

# Construindo o gráfico das top 10 variáveis
importancia |>
  arrange(MeanDecreaseAccuracy)|>
  #top_n(15, MeanDecreaseAccuracy)|>
  rownames_to_column( var = "variaveis")|>
  ggplot(aes(y=reorder(variaveis,MeanDecreaseAccuracy),x = MeanDecreaseAccuracy))+
  labs(title = "Importância da variável para o modelo",y = "Variável", x = "medida da adequação da variável como preditora.")+
  geom_col(aes(fill = MeanDecreaseAccuracy))+
  scale_x_continuous(breaks = seq(0,40, by =2))+
  scale_fill_gradient(low = "darkblue", high = "firebrick") +
  theme_bw()+
  theme(legend.position = "none",plot.title = element_text(hjust = 0.5))

# Selecionando as 10 melhores variáveis
top_10 <- importancia|>
  rownames_to_column(var="variaveis")|>
  arrange(MeanDecreaseAccuracy)|>
  top_n(10,MeanDecreaseAccuracy)

# Nome das variáveis a serem utilizadas
nomes <- top_10$variaveis

# Recriando a floresta apenas com as TOP 10 variáveis
modelo.floresta.red <- randomForest(Injury_Next_Season ~.,
                                    data = dados_treino[,c("Injury_Next_Season", nomes)],
                                    importance = TRUE)

# Aplicando a floresta reduzida
previsao.floresta.red <- predict(modelo.floresta.red, newdata = dados_teste, type = "class")

# Matriz de confusão do modelo reduzido
matriz_floresta.red <- confusionMatrix(reference = dados_teste$Injury_Next_Season,
                                       data = previsao.floresta.red,
                                       positive = "1")



