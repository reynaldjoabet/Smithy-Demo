import software.amazon.smithy.aws.traits.protocols.AwsJson1_1Trait
import smithy4s.codegen.Smithy4sCodegenPlugin

ThisBuild / scalaVersion := "3.3.3"

ThisBuild / name := "smithy-Demo"

ThisBuild / version := "1.0"

lazy val root = project
  .in(file("."))
  .settings(
    libraryDependencies ++= Seq(
      "com.disneystreaming.smithy4s" %% "smithy4s-core" % smithy4sVersion.value,
      "com.disneystreaming.smithy4s" %% "smithy4s-http4s" % smithy4sVersion.value,
      "com.disneystreaming.smithy4s" %% "smithy4s-http4s-swagger" % smithy4sVersion.value,
      "software.amazon.smithy" % "smithy-validation-model" % smithy4s.codegen.BuildInfo.smithyVersion % Smithy4s,
      "org.http4s" %% "http4s-ember-server" % "0.23.30",
      "org.http4s" %% "http4s-ember-client" % "0.23.30",
      "org.typelevel" %% "cats-effect" % "3.6-623178c",
      "org.typelevel" %% "cats-effect-std" % "3.6-623178c",
      "com.disneystreaming" %% "weaver-cats" % "0.8.4" % Test,
      "com.disneystreaming" %% "weaver-scalacheck" % "0.8.4" % Test
    ),
    fork := true,
    testFrameworks += new TestFramework("weaver.framework.CatsEffect")
  )
  .enablePlugins(Smithy4sCodegenPlugin)

// https://mvnrepository.com/artifact/software.amazon.smithy/smithy-validation-model

// https://mvnrepository.com/artifact/com.disneystreaming.smithy4s/smithy4s-core
//libraryDependencies += "com.disneystreaming.smithy4s" %% "smithy4s-core" % "0.18.29"
// https://mvnrepository.com/artifact/com.disneystreaming.smithy4s/smithy4s-http4s
//libraryDependencies += "com.disneystreaming.smithy4s" %% "smithy4s-http4s" % "0.18.29"

// https://mvnrepository.com/artifact/com.disneystreaming.smithy4s/smithy4s-json
//libraryDependencies += "com.disneystreaming.smithy4s" %% "smithy4s-json" % "0.18.29"

// https://mvnrepository.com/artifact/com.disneystreaming.smithy4s/smithy4s-protocol
//libraryDependencies += "com.disneystreaming.smithy4s" % "smithy4s-protocol" % "0.18.29"

// https://mvnrepository.com/artifact/com.disneystreaming.smithy4s/smithy4s-codegen-cli
//libraryDependencies += "com.disneystreaming.smithy4s" %% "smithy4s-codegen-cli" % "0.18.29"

// https://mvnrepository.com/artifact/com.disneystreaming.smithy4s/smithy4s-aws-http4s
//libraryDependencies += "com.disneystreaming.smithy4s" %% "smithy4s-aws-http4s" % "0.18.29"

// https://mvnrepository.com/artifact/com.disneystreaming.smithy4s/smithy4s-fs2
//libraryDependencies += "com.disneystreaming.smithy4s" %% "smithy4s-fs2" % "0.18.29"
// https://mvnrepository.com/artifact/com.disneystreaming.smithy4s/smithy4s-cats
//libraryDependencies += "com.disneystreaming.smithy4s" %% "smithy4s-cats" % "0.18.29"

// https://mvnrepository.com/artifact/com.disneystreaming.smithy4s/smithy4s-http4s-swagger
//libraryDependencies += "com.disneystreaming.smithy4s" %% "smithy4s-http4s-swagger" % "0.18.29"

// https://mvnrepository.com/artifact/com.disneystreaming.smithy4s/smithy4s-protobuf
//libraryDependencies += "com.disneystreaming.smithy4s" %% "smithy4s-protobuf" % "0.18.29"

addCommandAlias("tc", "Test/Compile")

addCommandAlias("ctc", "clean; Test/Compile")

addCommandAlias("rctc", "reload; clean; Test/Compile")

//This file can then used to configure codegen via the appropriate SBT setting:

//Compile / smithyBuild := Some(baseDirectory.value / "smithy-build.json")

smithy4sAllowedNamespaces := List("smithy.framework","com.weather","com.bison","utils","com.running","com.dev","leaderboard","dev.hiddentracks","jobs.spec","com.bank","com.minerva","library","filmclub.","authlete.models","authlete.services","com.cloud.auth","com.cloud.common","com.cloud.date_tracker","com.cloud.main","com.cloud.minecraft","com.cloud.picture")

// smithy4sAllowedNamespaces := List(
//   "smithy.framework",
//   "com.",
//   "utils",
//   "leaderboard",
//   "dev.hiddentracks",
//   "jobs.spec",
//   "library",
//   "filmclub.*"
// )
