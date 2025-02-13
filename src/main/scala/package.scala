// import skunk.Codec
// import skunk.codec.all.*
// import smithy4s.Newtype
// object codecs{
//   extension [T](c: Codec[T])
//     private[database] def as(obj: Newtype[T]): Codec[obj.Type] =
//       c.imap(obj.apply(_))(_.value)

// }      