package user

import jakarta.inject.Inject
import jakarta.ws.rs.Consumes
import jakarta.ws.rs.GET
import jakarta.ws.rs.POST
import jakarta.ws.rs.Path
import jakarta.ws.rs.Produces
import io.quarkus.elytron.security.common.BcryptUtil;
import jakarta.transaction.Transactional
import jakarta.ws.rs.core.Response

@Path("/client")
class ClientResource {

    @Inject
    lateinit var clientRepository: ClientRepository

    @GET
    @Produces("application/json")
    fun getAllUsers(): List<ClientEntity> {
        return clientRepository.listAll()
    }

    @GET
    @Path("/{id}")
    @Produces("application/json")
    fun getUserById(id: Long): ClientEntity {
        return clientRepository.findById(id) ?: throw Exception("User not found")
    }

    @POST
    @Produces("application/json")
    @Consumes("application/json")
    @Transactional
    fun createUser(user: ClientEntity): Response {
        user.password = BcryptUtil.bcryptHash(user.password);

        clientRepository.persist(user)
        return Response.ok(user).status(201).build()
    }


}