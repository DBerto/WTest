# WTest
iOS App Chalenge for iOS Position

Ao iniciar o Xcode garantir que o projeto importa as dependências necessárias através do package manager. 

A aplicação tem o seguinte funcionamento:
  - Ao iniciar descarrega o ficheiro CSV de códigos postais
  - Da parse ao ficheiro e guarda os dados em memória
  - Guarda os dados no Realm
  - Caso o download ou o guardar dos dados seja interrompido, ao arrancar novamente a app retoma o processo
  - Menu inicial com as funcionalidades desenvolvidas. Foi desenvolvida a funcionalidade de listagem de códigos postais, 
  correspondente ao ponto "2" do exercício e a funcionalidade de listagem de artigos correspondente ao ponto "3"(parcialmente).
  - Listagem de códigos postais, permite consultar a lista carregada e procurar pelo código desejado. 
  - Servidor Rest genérico
  - Dois schemes diferentes que permitem aceder a funcionalidades e endpoints diferentes na listagem de artigos.
  - Listagem de artigos através da "GET" API
