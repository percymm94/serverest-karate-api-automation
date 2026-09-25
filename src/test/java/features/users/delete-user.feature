@users @delete @regression
Feature: DELETE /usuarios/{_id} - Eliminar usuario

@smoke @positive
Scenario: Eliminar un usuario existente
  * def created = call read('classpath:helpers/users/create-user.feature')
  * def userId = created.userId

  Given url baseUrl
  And path 'usuarios', userId
  When method delete
  Then status 200
  And match response.message == 'Registro excluído com sucesso'

  # Verificar que ya no existe
  Given url baseUrl
  And path 'usuarios', userId
  When method get
  Then status 400
  And match response.message == 'Usuário não encontrado'

@negative
Scenario: Eliminar un ID inexistente
  * def unknownId = 'id-inexistente-' + java.util.UUID.randomUUID()
  Given url baseUrl
  And path 'usuarios', unknownId
  When method delete
  Then status 200
  And match response.message == 'Nenhum registro excluído'
