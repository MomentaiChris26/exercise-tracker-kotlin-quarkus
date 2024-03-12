import io.quarkus.test.junit.QuarkusTest
import io.restassured.RestAssured.given
import org.junit.jupiter.api.Test


@QuarkusTest
class ClientTest {

    @Test
    fun `List all users, should return 200`() {
        given()
            .`when`().get("/client")
            .then()
            .statusCode(200)
    }

    @Test
    fun `Create a new user`() {
        given()
            .`when`()
            .contentType("application/json")
            .body("{\"username\": \"test\", \"password\": \"test\"}")
            .post("/client")
            .then()
            .statusCode(201)
    }
}