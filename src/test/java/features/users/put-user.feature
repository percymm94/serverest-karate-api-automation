@users @put @regression
Feature: PUT /usuarios/{_id} - Actualizar usuario

Background:
  * def factory = call read('classpath:data/user-factory.js')

@smoke @positive
Scenario: Actualizar un usuario existente y validar persistencia
  * def created = call read('classpath:helpers/users/create-user.feature')
  * def userId = created.userId
  * def updated = factory.updatedUser()

  Given url baseUrl
  And path 'usuarios', userId
  And request updated
  When method put
  Then status 200
  And match response.message == 'Registro alterado com sucesso'

  Given url baseUrl
  And path 'usuarios', userId
  When method get
  Then status 200
  And match response contains updated
  And match response._id == userId

  * call read('classpath:helpers/users/delete-user.feature') { userId: '#(userId)' }

@negative
Scenario: No actualizar un usuario usando el email de otro usuario
  * def first = call read('classpath:helpers/users/create-user.feature')
  * def second = call read('classpath:helpers/users/create-user.feature')
  * def payload = factory.updatedUser()
  * set payload.email = second.user.email

  Given url baseUrl
  And path 'usuarios', first.userId
  And request payload
  When method put
  Then status 400
  And match response.message == 'Este email já está sendo usado'

  * call read('classpath:helpers/users/delete-user.feature') { userId: '#(first.userId)' }
  * call read('classpath:helpers/users/delete-user.feature') { userId: '#(second.userId)' }
