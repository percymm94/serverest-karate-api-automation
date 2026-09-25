package runners;

import io.karatelabs.junit6.Karate;

class UsersTest {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("classpath:features/users")
                .outputHtmlReport(true);
    }
}