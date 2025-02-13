import com.dev.*
final case class DefaultPokemonService[F[_]]() extends PokemonService[F]{

  override def getPokemonSpecies(name: String): F[GetPokemonSpeciesOutput] = ???

    
}
