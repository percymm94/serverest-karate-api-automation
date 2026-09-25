function fn() {
  var env = karate.env || 'qa';

  var config = {
    env: env,
    baseUrl: 'https://serverest.dev'
  };

  karate.configure('connectTimeout', 10000);
  karate.configure('readTimeout', 10000);

  karate.log('Environment:', env);
  karate.log('Base URL:', config.baseUrl);

  return config;
}
