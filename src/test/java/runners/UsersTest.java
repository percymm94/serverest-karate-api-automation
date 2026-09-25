package runners;

import io.karatelabs.junit6.Karate;

class UsersTest {

    @Karate.Test
    Karate testApi() {
        return Karate.run("classpath:features")
                .outputHtmlReport(true);
    }
}