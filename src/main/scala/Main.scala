import org.http4s.server
import org.http4s.syntax
import com.weather.*
import com.bank.*
import cats.effect.IO
import cats.effect.IOApp
import cats.effect.Resource
import com.comcast.ip4s.host
import com.comcast.ip4s.port
import library.Genre
import library.Genre.BIOGRAPHY
import library.LibraryServiceGen
import org.http4s.HttpRoutes
import org.http4s.Uri
import org.http4s.ember.client.EmberClientBuilder
import org.http4s.ember.server.EmberServerBuilder
import org.http4s.server.Server
import smithy4s.Timestamp
import smithy4s.http4s
import smithy4s.http4s.SimpleRestJsonBuilder
import smithy4s.http4s.swagger.docs

import authlete.models.*

object Main extends App {
  println("Hello, World!")

  //SimpleRestJsonBuilder

  val client=Client(clientNumber=12,serviceNumber=23,clientId=31,"secret",derivedSectorIdentifier="derivedSectorIdentifier")

  Display.PAGE
}

object Swagger {
  val swaggerRoutes = docs[IO](LibraryServiceGen)
}
