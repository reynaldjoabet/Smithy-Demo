$version: "2"

namespace library

use alloy#simpleRestJson
use alloy#UUID

@simpleRestJson
service LibraryService {
    version: "2023-05-01"
    operations: [
        CreateBook,
        UpdateBook,
        GetBook,
        GetAllBooks,
        CreateMember,
        GetMember,
        GetAllMembers
    ]
}

// Generic input for pagineted GET operations
structure CommonGetAllInput {
    @httpQuery("maxPageSize")
    @documentation("Maximum number of items to return in a single page")
    maxPageSize: Integer = 20
    @httpQuery("pageToken")
    @documentation("Meaning resume iteration from that point exclusively, regardless if it is some sort of id or not")
    pageToken: String
    @httpQuery("sortOrder")
    @documentation("Order in which to sort the returned items. Valid values are 'asc' and 'desc'.")
    sortOrder: String
}

@documentation("Metadata for paginated responses. Includes sort order and tokens for the next page.")
structure PaginationMetadata {
    sortOrder: String,
    nextPageToken: String,
    next: String
}

@documentation("Represents an author in the library. Each author has a unique ID")
structure Author {
    @required
    id: UUID,

    @required
    name: String,

    @required
    surname: String
}

@documentation("Represents a book in the library. Each book has a unique ID.")
structure Book {
    @required
    @httpLabel
    id: UUID
    @required
    title: String
    @required
    author: String
    @required
    publishedDate: Timestamp
    @required
    genre: Genre
    coverImageUrl: String
}

@documentation("Represents a member of the library. Each member has a unique ID.")
structure Member {
    @required
    id: UUID,

    @required
    name: String,

    @required
    membershipNumber: String,

    @required
    membershipStartDate: Timestamp,

    email: String,  // Optional contact information

    phoneNumber: String  // Optional contact information
}

list Authors {
    member: Author
}

list Books {
    member: Book
}

list Members {
    member: Member
}

list Genres {
    member: Genre
}

// Define the GetBook operation to retrieve a single book by ID
@readonly
@http(method: "GET", uri: "/books/{id}")
operation GetBook {
    input: GetEntityInput
    output: GetBookOutput
    errors: [BookNotFoundException]
}

// Define the GetAllBooks operation to retrieve all books
@readonly
@http(method: "GET", uri: "/books")
operation GetAllBooks {
    input: CommonGetAllInput
    output: GetAllBooksOutput
}

structure GetAllBooksOutput{
    @required
    content: Books,
    @required
    metadata: PaginationMetadata
}

// Output for GetBook operation
structure GetBookOutput {
    @required
    book: Book
}

// Define a structure to represent a list of books
structure BooksAmount {
    @required
    books: Books
    amount: Integer
    // Optional: Add metadata like total number of books
}

@http(method: "POST", uri: "/books", code: 201)
operation CreateBook {
    input: CreateBookInput
    output: Book
}

@idempotent
@http(method: "PUT", uri: "/books/{id}")
operation UpdateBook {
    input: Book
    output: Book
    errors: [BookNotFoundException]
}

@http(method: "GET", uri: "/books/search")
@readonly
operation SearchBooks {
    input := {
        @required
        @httpQuery("title")
        title: String
    }
    output := {
        @required
        playable: Books
    }
}

@readonly
@http(method: "GET", uri: "/members/{id}", code: 200)
operation GetMember {
    input: GetEntityInput
    output: Member
    errors: [MemberNotFoundException]
}

@error("client")
@httpError(404)
structure MemberNotFoundException {
    @required
    message: String
}

@error("client")
@httpError(404)
structure BookNotFoundException {
    @required
    message: String
}

@readonly
@http(method: "GET", uri: "/members")
operation GetAllMembers {
    input: CommonGetAllInput
    output: GetAllMembersOutput
}


structure GetAllMembersOutput{
    @required
    content: Members,
    @required
    metadata: PaginationMetadata
}

@http(method: "POST", uri: "/members")
operation CreateMember {
    input: CreateMemberInput
    output: Member
}

// Define input and output structures
structure GetEntityInput {
    @required
    @httpLabel
    id: UUID
}

structure CreateBookInput {
    @required
    title: String
    @required
    author: String
    @required
    publishedDate: Timestamp
    @required
    genre: Genre
    coverImageUrl: String
}

structure CreateMemberInput {
    @required
    name: String
    @required
    membershipNumber: String
    @required
    membershipStartDate: Timestamp
}

structure CreateGenreInput {
    name: String
    description: String
}


enum Genre {
    @documentation("Fiction covers novels and other narrative works that depict imaginary events and people.")
    FICTION,

    @documentation("Non-fiction covers books that are factually accurate and informative.")
    NON_FICTION,

    @documentation("Mystery involves suspenseful events, often involving a crime or other intrigue.")
    MYSTERY,

    @documentation("Science fiction deals with futuristic concepts such as advanced science and technology.")
    SCIENCE_FICTION,

    @documentation("Fantasy features magical or supernatural elements not existing in the real world.")
    FANTASY,

    @documentation("Biography is a detailed description of a person's life.")
    BIOGRAPHY,

    @documentation("History involves books that relate to past events.")
    HISTORY,

    @documentation("Children's books are aimed at young children and young readers.")
    CHILDRENS,

    @documentation("Romance centers on love and relationships.")
    ROMANCE,

    @documentation("Horror is intended to frighten, scare, or disgust.")
    HORROR
}