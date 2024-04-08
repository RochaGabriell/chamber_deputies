# Chamber of Deputies

[<img src="https://github.com/RochaGabriell/chamber_deputies/raw/main/.github/Screenshot_chamber_deputies.jpg" width="50%">](https://youtu.be/bh5vabDTs1c "App Flutter")

O Chamber of Deputies é um aplicativo móvel desenvolvido para fornecer aos usuários informações detalhadas sobre os deputados da Câmara dos Deputados do Brasil. Este aplicativo consome a API de Dados Abertos da Câmara dos Deputados, permitindo aos usuários acessarem informações sobre os deputados, suas atividades, comissões e gastos mensais.

## Funcionalidades

| Funcionalidade           | Descrição                                                                                                                                                                  |
|--------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Lista de Deputados       | Exibe uma lista de deputados, incluindo seus nomes e partidos. Ao tocar em um deputado, o usuário é direcionado para uma tela de detalhes do deputado.                |
| Detalhes do Deputado     | Apresenta informações detalhadas sobre um deputado específico, incluindo nome, partido, estado, e outras informações relevantes disponíveis na API.                       |
|                          | Mostra as atividades recentes do deputado.                                                                                                                                |
|                          | Exibe os gastos de um determinado mês do deputado.                                                                                                                        |
| Comissões                | Oferece uma lista de comissões presentes na Câmara dos Deputados. Ao selecionar uma comissão, exibe informações sobre os membros e atividades relacionadas a ela.       |
| Pesquisa                 | Permite que os usuários pesquisem deputados por nome, partido, estado, ou outros critérios disponíveis na API.                                                              |

## Requisitos Técnicos

| Requisito Técnico        | Descrição                                                                                                                                                                                                                                                                                             |
|--------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Consumo da API           | Utiliza a API Dados Abertos da Câmara dos Deputados para obter as informações necessárias. Gerencia as solicitações HTTP de forma eficiente, tratando erros e otimizando o desempenho.                                                                                                            |
| Navegação entre Telas    | Implementa navegação entre telas para permitir que os usuários explorem deputados, comissões e atividades.                                                                                                                                                                                            |
| Interface de Usuário (UI)| Desenvolve uma interface de usuário intuitiva e atraente. Utiliza listas, cartões e outros componentes visuais apropriados para apresentar informações.                                                                                                                                           |


## Tecnologias Utilizadas

- **Framework**: Flutter
- **Linguagem de Programação**: Dart

## Instalação e Execução

1. Clone o repositório do GitHub:
    ```
    git clone https://github.com/RochaGabriell/chamber_deputies.git
    ```
2. Navegue até o diretório do projeto:
    ```
    cd chamber_deputies
    ```
3. Instale as dependências:
    ```
    flutter pub get
    ```
4. Execute o aplicativo:
    ```
    flutter run
    ```

## Construção
Para construir o aplicativo, use o seguinte comando:

```
flutter build apk --release
```


Certifique-se de ter o Flutter instalado e configurado corretamente em seu ambiente de desenvolvimento antes de seguir as etapas acima.

--- 