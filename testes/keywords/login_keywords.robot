*** Settings ***
Library    RequestsLibrary
Library    Collections
Resource   ../variables/utils_variables.robot

*** Keywords ***
Login e Validar token
    [Arguments]        ${username}              ${password}
    ${Body}            Create Dictionary        username=${username}        password=${password}
    Create Session     alias=${alias}           url=${localhost}:${porta}
    ${RESPONSE}        POST On Session          alias=${alias}              url=/auth/login    json=${Body}
    Log                ${Body}    
    RETURN             ${RESPONSE}

Login e Verificar credendiais invalidas
    [Arguments]        ${username}              ${password}
    ${Body}            Create Dictionary        username=${username}        password=${password}
    Create Session     alias=${alias}           url=${localhost}:${porta}
    ${RESPONSE}        POST On Session          alias=${alias}              url=/auth/login    json=${Body}    expected_status=401
    Log                ${Body}    
    RETURN             ${RESPONSE}

Login e Verificar credendiais em branco
    [Arguments]        ${username}              ${password}
    ${Body}            Create Dictionary        username=${username}        password=${password}
    Create Session     alias=${alias}           url=${localhost}:${porta}
    ${RESPONSE}        POST On Session          alias=${alias}              url=/auth/login    json=${Body}    expected_status=400
    Log                ${Body}    
    RETURN             ${RESPONSE}
DADO que o SALE receba uma requisição POST para autenticação
    ${HEADERS}        Create Dictionary     content-type=application-json
    Create Session    alias=${alias}        url=${localhost}:${porta}

QUANDO o sistema validar as credenciais
    ${RESPONSE}    Login e Validar token    email@correto.com    senha_correta
    Log            Resposta Retornada: ${\n}${RESPONSE.text}
    RETURN         ${RESPONSE}

QUANDO o sistema verificar que o/a ${campo} está incorreto/a
    IF          $campo == "email"
        ${RESPONSE}    Login e Verificar credendiais invalidas    email@incorreto .com       senha_qualquer
    ELSE IF     $campo == "senha" 
        ${RESPONSE}    Login e Verificar credendiais invalidas    email@correto.com           senha_incorreta
    ELSE
        ${RESPONSE}    Login e Verificar credendiais invalidas    email@incorreto.com           senha_incorreta
    END
        Log            Resposta Retornada: ${\n}${RESPONSE.text}
        RETURN         ${RESPONSE}

QUANDO o sistema verificar que o/a ${campo} está em branco
    IF           $campo == "email"
        ${RESPONSE}    Login e Verificar credendiais em branco   ${None}                     senha_qualquer
    ELSE IF      $campo == "senha"
        ${RESPONSE}    Login e Verificar credendiais em branco    email@correto.com           ${None}
    ELSE
        ${RESPONSE}    Login e Verificar credendiais em branco    ${None}                     ${None}
    END
        Log            Resposta Retornada: ${\n}${RESPONSE.text}
        RETURN         ${RESPONSE}
Verifica o Tipo de erro
    [Arguments]                       ${campo}        ${tipo}
    IF         $tipo == "incorreto"
        ${RESPONSE}                       QUANDO o sistema verificar que o/a ${campo} está incorreto/a
    ELSE IF    $tipo == "branco"
        ${RESPONSE}                       QUANDO o sistema verificar que o/a ${campo} está em branco
    END
        RETURN    ${RESPONSE}
ENTÃO o SALE deve enviar um JSON de resposta contendo o token para o usuário
    ${RESPONSE}                       QUANDO o sistema validar as credenciais
    Log                               Resposta Retornada: ${\n}${RESPONSE}
    Dictionary Should Contain Item    ${RESPONSE.json()}    token    eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c
    Log                               JSON: ${RESPONSE.json}   

ENTÃO o SALE deve enviar um JSON de resposta contendo um código de erro
    [Arguments]                       ${campo}        ${tipo}
    IF         $tipo == "incorreto"
        ${RESPONSE}                       QUANDO o sistema verificar que o/a ${campo} está incorreto/a
    ELSE IF    $tipo == "branco"
        ${RESPONSE}                       QUANDO o sistema verificar que o/a ${campo} está em branco
    END
        Log                               Resposta Retornada: ${\n}${RESPONSE}
        Dictionary Should Contain Item    ${RESPONSE.json()}    statusCode    400
        Dictionary Should Contain Item    ${RESPONSE.json()}    message       login failed
        Dictionary Should Contain Item    ${RESPONSE.json()}    name          error
        Log                               JSON: ${RESPONSE.json} 
    
