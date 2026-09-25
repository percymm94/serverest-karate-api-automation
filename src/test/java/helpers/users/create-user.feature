@ignore
Feature: Helper - create user

Scenario:
  * def factory = call read('classpath:data/user-factory.js')
  * def user = factory.validUser()
  Given url baseUrl
  And path 'usuarios'
  And request user
  When method post
  Then status 201
  And match response.message == 'Cadastro realizado com sucesso'
  And match response._id == '#string'
  * def userId = response._id
