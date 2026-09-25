@users @post @regression
Feature: POST /usuarios - Registrar usuario

Background:
  * def factory = call read('classpath:data/user-factory.js')

@smoke @positive
Scenario: Registrar un usuario con datos validos
  * def user = factory.validUser()
  Given url baseUrl
  And path 'usuarios'
  And request user
  When method post
  Then status 201
  And match response == { message: 'Cadastro realizado com sucesso', _id: '#string' }
  * def userId = response._id

  # Validacion de persistencia
  Given url baseUrl
  And path 'usuarios', userId
  When method get
  Then status 200
  And match response contains user
  And match response._id == userId

  # Cleanup
  * call read('classpath:helpers/users/delete-user.feature') { userId: '#(userId)' }

@negative
Scenario: No registrar un usuario con email duplicado
  * def created = call read('classpath:helpers/users/create-user.feature')
  * def userId = created.userId
  * def duplicate = created.user

  Given url baseUrl
  And path 'usuarios'
  And request duplicate
  When method post
  Then status 400
  And match response.message == 'Este email já está sendo usado'

  * call read('classpath:helpers/users/delete-user.feature') { userId: '#(userId)' }

@negative
Scenario: No registrar usuario con formato de email invalido
  * def invalidUser = factory.validUser()
  * set invalidUser.email = 'correo-invalido'

  Given url baseUrl
  And path 'usuarios'
  And request invalidUser
  When method post
  Then status 400
  And match response.email == '#string'
