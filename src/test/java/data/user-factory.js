function fn() {
  function unique() {
    return java.util.UUID.randomUUID() + '';
  }

  function validUser() {
    var id = unique();
    return {
      nome: 'QA Automation ' + id.substring(0, 8),
      email: 'qa.' + id + '@example.com',
      password: 'Qa123456!',
      administrador: 'true'
    };
  }

  function updatedUser() {
    var id = unique();
    return {
      nome: 'QA Updated ' + id.substring(0, 8),
      email: 'qa.updated.' + id + '@example.com',
      password: 'NewQa123456!',
      administrador: 'false'
    };
  }

  return {
    validUser: validUser,
    updatedUser: updatedUser
  };
}
