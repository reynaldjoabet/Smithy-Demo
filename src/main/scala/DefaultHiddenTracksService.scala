import dev.hiddentracks.*
final case class DefaultHiddenTracksService[F[_]]() extends HiddenTracksService[F]{

  override def listSongsForEncoding(user: User, message: NonEmptyString): F[ListSongsForEncodingOutput] = ???

  override def listConversations(user: User): F[ListConversationsOutput] = ???

  override def sendMessage(user: User, conversationId: Identifier, playlistId: PlaylistId, startOffset: SongOffset, endOffset: SongOffset): F[MessageSummary] = ???

  override def listMessages(user: User, conversationId: Identifier): F[ListMessagesOutput] = ???

  override def createConversation(user: User, recipients: List[User], encodingFormat: NonEmptyString): F[ConversationSummary] = ???


}
