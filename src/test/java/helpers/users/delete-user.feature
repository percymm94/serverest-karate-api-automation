@ignore
Feature: Helper - delete user

Scenario:
  Given url baseUrl
  And path 'usuarios', userId
  When method delete
  * match responseStatus == 200
