@users @getById @regression
Feature: GET /usuarios/{_id} - Buscar usuario por ID

  Background:
    * def userSchema = read('classpath:schemas/user-schema.json')

  @smoke @positive
  Scenario: Buscar un usuario existente por ID
    * def created = call read('classpath:helpers/users/create-user.feature')
    * def userId = created.userId
    * def expectedUser = created.user

    Given url baseUrl
    And path 'usuarios', userId
    When method get
    Then status 200
    And match response == userSchema
    And match response contains expectedUser
    And match response._id == userId

    * call read('classpath:helpers/users/delete-user.feature') { userId: '#(userId)' }

  @negative @getUserNotFound
  Scenario: Buscar usuario eliminado por ID

  # Arrange
    * def created = call read('classpath:helpers/users/create-user.feature')
    * def userId = created.userId

  # Eliminamos al usuario para garantizar que no exista
    * call read('classpath:helpers/users/delete-user.feature') { userId: '#(userId)' }

  # Act
    Given url baseUrl
    And path 'usuarios', userId
    When method get

  # Assert
    Then status 400