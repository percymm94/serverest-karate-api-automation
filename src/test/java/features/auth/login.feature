@auth @login @regression
Feature: POST /login - Autenticacion de usuarios

  Background:
    * def created = call read('classpath:helpers/users/create-user.feature')
    * def user = created.user
    * def userId = created.userId

  @smoke @positive
  Scenario: Login exitoso y generacion de token
    * def credentials =
  """
  {
    "email": "#(user.email)",
    "password": "#(user.password)"
  }
  """

    Given url baseUrl
    And path 'login'
    And request credentials
    When method post
    Then status 200
    And match response.message == 'Login realizado com sucesso'
    And match response.authorization == '#string'
    And match response.authorization contains 'Bearer '

    * def token = response.authorization
    * print 'Token generado:', token

  # Cleanup
    * call read('classpath:helpers/users/delete-user.feature') { userId: '#(userId)' }