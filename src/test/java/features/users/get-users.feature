@users @get @regression
Feature: GET /usuarios - Listar usuarios

  Background:
    * def listSchema = read('classpath:schemas/users-list-schema.json')
    * def userSchema = read('classpath:schemas/user-schema.json')

  @smoke @positive
  Scenario: Listar usuarios registrados y validar contrato

  # Arrange
    Given url baseUrl
    And path 'usuarios'

  # Act
    When method get

  # Assert
    Then status 200
    And match header Content-Type contains 'application/json'
    And match response == listSchema
    And match response.quantidade == response.usuarios.length
    And match each response.usuarios == userSchema