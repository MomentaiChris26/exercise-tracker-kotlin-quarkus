package user

import jakarta.persistence.*

@Entity

@Table(name = "clients")
class ClientEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "client_id_seq")
    var id: Long? = null
    lateinit var username: String
    lateinit var password: String
}