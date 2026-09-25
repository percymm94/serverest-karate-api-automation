@auth @authorization @regression
Feature: Validacion de autorizacion mediante Bearer Token


  @positive @security
  Scenario: Autorizar registro de producto utilizando token valido

  # Setup - crear administrador
    * def created = call read('classpath:helpers/users/create-user.feature')
    * def user = created.user
    * def userId = created.userId

  # Login
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
    And match response.authorization == '#string'
    And match response.authorization contains 'Bearer '

    * def token = response.authorization

  # Datos del producto
    * def productName = 'Producto QA ' + java.util.UUID.randomUUID()

    * def product =
  """
  {
    "nome": "#(productName)",
    "preco": 100,
    "descricao": "Producto creado por Karate",
    "quantidade": 10
  }
  """

  # Endpoint protegido
    Given url baseUrl
    And path 'produtos'
    And header Authorization = token
    And request product
    When method post
    Then status 201
    And match response.message == 'Cadastro realizado com sucesso'
    And match response._id == '#string'

    * def productId = response._id

  # Cleanup producto
    Given url baseUrl
    And path 'produtos', productId
    And header Authorization = token
    When method delete
    Then status 200

  # Cleanup usuario
    * call read('classpath:helpers/users/delete-user.feature') { userId: '#(userId)' }


  @negative @security
  Scenario: Rechazar registro de producto con token invalido

    * def invalidToken = 'Bearer token-invalido-123456'
    * def productName = 'Producto QA Invalid Token ' + java.util.UUID.randomUUID()

    * def product =
  """
  {
    "nome": "#(productName)",
    "preco": 100,
    "descricao": "Producto prueba token invalido",
    "quantidade": 10
  }
  """

    Given url baseUrl
    And path 'produtos'
    And header Authorization = invalidToken
    And request product
    When method post
    Then status 401
    And match response.message == '#string'


  @negative @security
  Scenario: Rechazar registro de producto sin token

    * def productName = 'Producto QA Without Token ' + java.util.UUID.randomUUID()

    * def product =
  """
  {
    "nome": "#(productName)",
    "preco": 100,
    "descricao": "Producto prueba sin token",
    "quantidade": 10
  }
  """

    Given url baseUrl
    And path 'produtos'
    And request product
    When method post
    Then status 401
    And match response.message == '#string'