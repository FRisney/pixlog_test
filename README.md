# pixlog_test

Aplicação para demonstração de conhecimentos em Flutter.

## Objetivos

- Recuperar dados de uma API.
- Guardar os dados em cache.
- Listar eficientemente os dados.
- Permitir filtrar a lista com três parâmetros não excludentes.

## Arquitetura

A principal referencia para a estrutura do aplicativo é a Clean Architecture,
utilizando orientação a interfaces, facilitando o desacoplamento da regra de negocio
de implementações de bibliotecas externas.

## Tecnologias

Este projeto utiliza as seguintes tecnologias:

- Bloc para o gerenciamento de estado da listagem.
- Freezed e JsonSerializable para geração de Data Class, com geracao de código evitando boilerplate.
    * para gerar estes códigos é necessário executar o comando:
    ```
    flutter pub run build_runner build
    ```
- GetIt para gerenciamento de Singletons e injeção de dependências.
- LocalStorage para o armazenamento dos resultados da API.