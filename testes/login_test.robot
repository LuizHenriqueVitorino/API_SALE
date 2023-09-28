*** Settings ***
Resource    keywords/login_keywords.robot

*** Test Cases ***
Cenário 1: Autenticação com email e senha corretos
    [Tags]    Funcionalidade 01    [TC-01] Autenticação com credenciais corretas
    DADO que o SALE receba uma requisição POST para autenticação
    QUANDO o sistema validar as credenciais
    ENTÃO o SALE deve enviar um JSON de resposta contendo o token para o usuário

Cenário 1: Requisição com email inexistente
    [Tags]    Funcionalidade 01    [TC-02] Autenticação com credenciais incorretas
    DADO que o SALE receba uma requisição POST para autenticação
    QUANDO o sistema verificar que o/a email está incorreto/a
    ENTÃO o SALE deve enviar um JSON de resposta contendo um código de erro    email        incorreto

Cenário 2: Requisição com senha inexistente
    [Tags]    Funcionalidade 01    [TC-02] Autenticação com credenciais incorretas
    DADO que o SALE receba uma requisição POST para autenticação
    QUANDO o sistema verificar que o/a senha está incorreto/a
    ENTÃO o SALE deve enviar um JSON de resposta contendo um código de erro    senha        incorreto

Cenário 1: Autenticação com email em branco
    [Tags]    Funcionalidade 01    [TC-03] Autenticação com credenciais em branco
    DADO que o SALE receba uma requisição POST para autenticação
    QUANDO o sistema verificar que o/a email está em branco
    ENTÃO o SALE deve enviar um JSON de resposta contendo um código de erro    email    branco

Cenário 2: Autenticação com senha em branco
    [Tags]    Funcionalidade 01    [TC-03] Autenticação com credenciais em branco
    DADO que o SALE receba uma requisição POST para autenticação
    QUANDO o sistema verificar que o/a senha está em branco
    ENTÃO o SALE deve enviar um JSON de resposta contendo um código de erro    senha    branco
Cenário 3: Autenticação com email e senha em branco
    [Tags]    Funcionalidade 01    [TC-03] Autenticação com credenciais em branco
    DADO que o SALE receba uma requisição POST para autenticação
    QUANDO o sistema verificar que o/a senha e email está em branco
    ENTÃO o SALE deve enviar um JSON de resposta contendo um código de erro    email e senha    branco