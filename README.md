# SALE_API
Este repositório contém os testes automatizados do projeto Sale
## ESTRUTURA DO PROJETO
- **Mocks:** Nesta pasta, você encontrará todos os mocks e dados de teste necessários para simular os endpoints do SALE. Eles são essenciais para garantir que nossos testes sejam realistas e abrangentes.

- **Testes:** Aqui é onde toda a mágica acontece. Nossa suíte de testes automatizados está organizada nesta pasta.

## DEPENDÊNCIAS
Recomendamos que instale tudo em uma máquina virtual.
1. Utilizamos o framework FLASK para criação dos mocks
```shell
    sudo pip install flask
```
2. Utilizamos o ROBOT FRAMWORK para criação dos testes automatizados
```shell
    pip install robotframework
```
3. Para realizar as requisições na API, utilizamos a bibioteca REQUESTS do ROBOT
```shell
    pip install robotframework-requests
```